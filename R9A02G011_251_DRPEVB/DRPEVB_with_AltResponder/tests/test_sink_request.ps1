$ErrorActionPreference = 'Stop'

# Run the production selector with mock SDK getters. Its C subset is also valid
# C# after mapping the RL78 integer types/suffixes to unsigned 32-bit arithmetic.
$source = Get-Content (Join-Path $PSScriptRoot '../PDC/user_main.c') -Raw
$match = [regex]::Match($source, '(?s)static ULONG sink_make_rdo\(void\)\r?\n\{.*?\r?\n\}')
if (-not $match.Success) { throw 'Production selector not found' }
$body = $match.Value.Replace('sink_make_rdo(void)', 'sink_make_rdo()')
$body = $body.Replace('ULONG', 'uint').Replace('UCHAR', 'uint')
$body = [regex]::Replace($body, '(0x[0-9A-Fa-f]+|[0-9]+)UL\b', '${1}U')
$harness = @'
public static class SinkRequestTest {
    const byte PDC_PDO_SRC = 1, PDC_PDO_SNK = 0, PDC_PDO_RCV = 0, PDC_PDO_SND = 1;
    const byte PD_USB_COMM_CAPABLE = 0, PD_NO_USB_SUSPEND = 0;
    static uint[] sources;
    static uint[] sinks;
    static byte pdc_get_num_of_pdos(byte role, byte direction) {
        return (byte)((direction == PDC_PDO_RCV) ? sources.Length : sinks.Length);
    }
    static uint pdc_get_pdo(uint index, byte role, byte direction) {
        return ((direction == PDC_PDO_RCV) ? sources : sinks)[index - 1];
    }
    public static uint Run(uint[] sourcePdos, uint[] sinkPdos) {
        sources = sourcePdos;
        sinks = sinkPdos;
        return sink_make_rdo();
    }
    SELECTOR
}
'@
Add-Type -TypeDefinition $harness.Replace('SELECTOR', $body) -WarningAction SilentlyContinue

function Fixed-Pdo([int]$millivolts, [int]$milliamps) {
    return [uint32]((($millivolts / 50) -shl 10) -bor ($milliamps / 10))
}

# Read the actual configured sink profiles rather than duplicating their limits.
$defs = Get-Content (Join-Path $PSScriptRoot '../pd_defs.c') -Raw
$first = [regex]::Match($defs, 'PD_SNK_PDO1_OPE_CUR\s*=\s*0x([0-9A-Fa-f]+)U')
$second = [regex]::Match($defs, 'PD_SNK_PDO2\s*=\s*0x([0-9A-Fa-f]+)UL')
[uint32[]]$sinks = @(
    [uint32]((100 -shl 10) -bor [Convert]::ToUInt32($first.Groups[1].Value, 16)),
    [Convert]::ToUInt32($second.Groups[1].Value, 16)
)
$init = Get-Content (Join-Path $PSScriptRoot '../R_Main_UserInit.c') -Raw
if ($init -notmatch 'pdc_set_snk_conf\(60000U, 2, 1\)') {
    throw 'Expected two sink profiles and intrusive mode'
}

$cases = @(
    @{ Name = '5V 3A'; Pdos = @((Fixed-Pdo 5000 3000)); Expected = '1004B12C' },
    @{ Name = '5V 2A'; Pdos = @((Fixed-Pdo 5000 2000)); Expected = '140320C8' },
    @{ Name = 'Phone 900mA'; Pdos = @((Fixed-Pdo 5000 900)); Expected = '1401685A' },
    @{ Name = 'Phone 500mA'; Pdos = @((Fixed-Pdo 5000 500)); Expected = '1400C832' },
    @{ Name = '100mA source'; Pdos = @((Fixed-Pdo 5000 100)); Expected = '1400280A' },
    @{ Name = 'Cap source at 3A'; Pdos = @((Fixed-Pdo 5000 5000)); Expected = '1004B12C' },
    @{ Name = '9V 3A preferred'; Pdos = @((Fixed-Pdo 5000 3000), (Fixed-Pdo 9000 3000)); Expected = '2004B12C' },
    @{ Name = '9V 2A beats 5V 3A'; Pdos = @((Fixed-Pdo 5000 3000), (Fixed-Pdo 9000 2000)); Expected = '240320C8' },
    @{ Name = '5V 3A beats 9V 1.5A'; Pdos = @((Fixed-Pdo 5000 3000), (Fixed-Pdo 9000 1500)); Expected = '1004B12C' },
    @{ Name = 'Equal power prefers 9V'; Pdos = @((Fixed-Pdo 5000 1800), (Fixed-Pdo 9000 1000)); Expected = '24019064' },
    @{ Name = '15V remains disabled'; Pdos = @((Fixed-Pdo 5000 3000), (Fixed-Pdo 15000 3000)); Expected = '1004B12C' },
    @{ Name = 'Skip PPS variable battery'; Pdos = @((Fixed-Pdo 5000 900), [uint32]3221225772, [uint32]2147483948, [uint32]1073742124); Expected = '1401685A' },
    @{ Name = 'Zero current'; Pdos = @((Fixed-Pdo 5000 0)); Expected = '00000000' },
    @{ Name = 'Unsupported voltage only'; Pdos = @((Fixed-Pdo 15000 3000)); Expected = '00000000' },
    @{ Name = 'Empty capabilities'; Pdos = @(); Expected = '00000000' },
    @{ Name = 'Zero PDO'; Pdos = @(0); Expected = '00000000' }
)

foreach ($case in $cases) {
    $actual = [SinkRequestTest]::Run([uint32[]]$case.Pdos, $sinks).ToString('X8')
    if ($actual -ne $case.Expected) {
        throw "$($case.Name): expected $($case.Expected), got $actual"
    }
    Write-Output "PASS $($case.Name): $actual"
}
Write-Output "$($cases.Count) selector cases passed"
