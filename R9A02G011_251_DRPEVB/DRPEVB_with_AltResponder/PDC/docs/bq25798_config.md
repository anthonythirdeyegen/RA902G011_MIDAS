# BQ25798 Battery Configuration

Board: 2S Li-ion pack, external ShipFET installed, 10k NTC on TS,
USB PD input up to 15V. Charger INT is currently unconnected.

The bqStudio screenshot represents power-on settings, not the firmware profile.
Firmware enables the installed charger with `has_charger = 1`.

## Programmed Profile

| Setting | Value |
| --- | --- |
| Cell count / charge voltage | 2S / 8400mV |
| Minimum system voltage | 7000mV |
| Precharge threshold / current | 71.4% of VREG / 240mA |
| Termination | Enabled, 200mA |
| Recharge | VREG minus 200mV, 1024ms debounce |
| Trickle / precharge safety timer | Enabled, 1h / 2h |
| Fast-charge safety timer | Enabled, 12h |
| Timer slowdown during DPM / thermal regulation | Enabled, 2x |
| Top-off timer | Disabled |
| Input OVP | 22V (REG10 VAC_OVP code 01) |
| Watchdog | Disabled; no watchdog refresh is required |
| ShipFET | Present |
| TS protection | Enabled; suspend in cool/warm JEITA bands |
| Die thermal regulation / shutdown | 120C / 150C |
| BC1.2 / HVDCP / ICO / MPPT / backup | Disabled; PD owns input selection |
| ADC | Continuous, 15-bit effective resolution, no averaging |

The nominal TS window is +10C to +45C for TI's 103AT thermistor with
RT1=5.24k and RT2=30.31k. A 10k nominal resistance alone does not establish
these temperatures: confirm the installed NTC curve and divider values.
TS ADC is retained as a percentage of REGN, not converted to pack temperature.

## Negotiated Limits

Charging requires a completed PD contract, at least 1500mA available,
more than 5W input power, and input voltage no greater than 15V.
The CHARGE_EN output is also gated by successful profile programming.

- VINDPM: negotiated voltage minus 500mV.
- IINDPM: negotiated current, capped at the charger's 3300mA limit.
- ICHG: reserve 5W for the system, assume 90% conversion efficiency,
  divide the remaining battery-side power by 8.4V, then cap at 800mA.
- Current registers round down to their 10mA steps.

The 5W system reserve and 90% efficiency are firmware budgeting assumptions.
For example, 5V/1.5A requests 260mA, while 5V/3A or 15V/1.5A requests 800mA.
The 240mA precharge and 200mA termination values remain the existing EVM profile.

## Polling and Debugging

`user_func_charger_poll()` runs from the main loop and uses PD timer USER3
for one-second polling. USER3 was used by the disabled `led_ctrl()`;
do not re-enable that task without allocating a different timer.

The driver verifies byte and word writes. Word transfers preserve the BQ's
MSB-first byte order. A failed transaction or readback invalidates the profile
and drops CHARGE_EN; the next idle polling interval retries the profile and
the currently allowed negotiated limits. REG10 is checked on each poll to
detect restored power-on watchdog/OVP settings.

Debugger fields in `gBq25798Info`:

- `ucConfigValid`: profile writes completed and verified.
- `ucStatusValid`, `ucStatus[0..6]`: last successful REG1B..REG21 status/fault read.
- `ucAdcValid`, `usAdc[0..8]`: last successful ADC snapshot, in register order:
  IBUS, IBAT, VBUS, VAC1, VAC2, VBAT, VSYS, TS, TDIE.
- ADC currents: signed 16-bit mA; voltages: mV; TS: 0.09765625% REGN per count;
  TDIE: signed 16-bit, 0.5C per count.
- `gSubDevErr.ucError = 0x80`: charger register readback mismatch.

ADC validity indicates successful register reads. Immediately after ADC startup,
results may still be zero until the first conversion finishes.
Polling observes current faults; short faults between polls can be missed.
The charger retains autonomous TS, timer, and electrical protection without INT.

## Hardware Verification

After firmware starts, check REG0A=0x63, REG0E=0x3D, REG08=0xC6,
REG00=0x12, and REG01/02=0x0348. Check REG10 masked with 0x37 equals 0x10,
REG14 masked with 0x86 equals 0x84, and REG2E masked with 0xFC equals 0x80.
After a PD contract, check VINDPM/IINDPM/ICHG against the negotiated limits.
Verify disconnect disables charging, NTC heating/cooling inhibits charging,
and a charger power cycle is detected and reconfigured by polling.

Register reference: https://www.ti.com/lit/gpn/bq25798
