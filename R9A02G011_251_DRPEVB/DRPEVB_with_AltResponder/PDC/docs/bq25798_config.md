# BQ25798 Battery Configuration

Board: 2S Li-ion pack, external ShipFET installed, 10k NTC on TS,
USB PD input up to 15V. Charger INT is currently unconnected.

The bqStudio screenshot represents power-on settings, not the firmware profile.
Firmware enables the installed charger with `has_charger = 1`.

## Charger Ownership and CE

P16 (`CHARGE_EN`) connects directly to the BQ25798 active-low CE pin.
High inhibits charging; low permits charging when EN_CHG and hardware
conditions allow it. Firmware initializes P16 high before enabling its output.
In firmware mode it remains high until configuration and requested limit
writes are verified, charging is requested, and the power budget permits it.
Read-only status/ADC polling does not toggle CE.

`charger_mcu_control` is a volatile global, default 1, adjustable in the debugger
or by changing its initializer in `PDC/user_main.c`:

- `1`: MCU owns charger configuration, negotiated limits, polling, and CE.
- `0`: bqStudio mode. MCU stops charger polling and PD-triggered charger writes,
  finishes any in-flight bus transaction, discards queued charger work, and
  holds CE low so bqStudio can control charging with EN_CHG. FPGA readiness
  bypasses the firmware charger-configuration check in this mode.

Keep `has_charger = 1` for bqStudio mode. `has_charger = 0` means the charger
is absent and keeps CE high. When returning to MCU mode, CE is inhibited and
the firmware profile and negotiated limits are reapplied on the next poll.

Before connecting the bqStudio adapter, set `charger_mcu_control = 0` and
confirm `bq25798_is_busy() == 0`. Disconnect the adapter before returning
the flag to 1. The flag stops MCU transactions to the charger; other devices
on the shared MCU I2C bus may still be active, so isolate the adapter's charger
segment from the MCU bus during manual access.

bqStudio mode intentionally allows charging without the firmware PD power
budget. Configure EN_CHG, ICHG, IINDPM, VREG, watchdog, and TS protection in
bqStudio before enabling charging. Set EN_CHG=0 before releasing firmware
control if charging should remain stopped during the handoff.

Firmware cannot control CE while the MCU is in reset or before user_init.
A hardware pull-up to an appropriate CE logic rail is required to inhibit
power-on default charging during that interval.

## Charger QON Connection

P32 connects to the charger QON pin (formerly labeled RESET_OUT in the code).
Firmware configures P32 as open-drain with its output latch high, leaving
the driver high-impedance. The charger's internal pull-up biases the line;
firmware does not currently generate QON pulses.

Future work: evaluate timed QON control for charger wake/reset functions,
including the required pulse durations, operating-mode restrictions, and
effects on VSYS and the MCU power supply. No QON control behavior is enabled
by this note.

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
| BC1.2 / HVDCP / ICO / MPPT / backup / OTG | Disabled; PD owns input selection |
| ADC | Continuous, 15-bit effective resolution, no averaging |

The nominal TS window is +10C to +45C for TI's 103AT thermistor with
RT1=5.24k and RT2=30.31k. A 10k nominal resistance alone does not establish
these temperatures: confirm the installed NTC curve and divider values.
TS ADC is retained as a percentage of REGN, not converted to pack temperature.

The profile explicitly clears REG12 bit 6 (EN_OTG), preserving the other
REG12 settings. REG0F EN_BACKUP is also cleared to disable automatic reverse
operation. OTG voltage/current limits and VBAT-for-OTG status can still appear
in bqStudio while OTG is disabled; they do not set forward charging current.
This does not disable battery supplement of VSYS or resolve a VBAT OVP fault.

## Display Board Power Sequence

P22 is BB_EN for external boards that do not manage the DP link. It is not
a measured power-good input, and a PD contract alone no longer asserts it.
P80 is FPGA_POWER_READY, an open-drain output requiring an external pull-up.
P21 drives an inverting FET on the FPGA's active-low PROGRAM_B input:
P21 high turns the FET on and holds PROGRAM_B low (configuration inhibited);
P21 low turns the FET off and lets the SOM pull-up release PROGRAM_B high.
P21 stays high until a successful DP Configure ACK authorizes display operation,
preventing FPGA configuration during charging-only operation. The board must
bias the FET control high during MCU reset to keep PROGRAM_B low before firmware
configures P21; a gate pull-down would instead allow configuration during reset.

1. On startup, drive P21 high to hold PROGRAM_B low, and keep BB_EN and
   FPGA_POWER_READY low. Initialize the charger
   and negotiate PD independently of the external display-board power.
2. On a new PD contract, update charger limits and charging enable normally.
   Charging-only operation leaves the display boards off.
3. Enter DP mode, accept the supported DP Configure pin assignment C, and
   send its ACK. Only successful ACK command completion authorizes BB_EN.
4. If `bb_extvcc = 1`, allow the existing additional 10ms startup delay.
   Then assert BB_EN, drive P21 low to release PROGRAM_B high through its pull-up,
   and start the 10ms FPGA readiness delay.
5. Assert FPGA_POWER_READY after the delay and after verified charger
   configuration and completion of pending charger transactions. bqStudio
   mode and `has_charger = 0` bypass only that charger check, not DP gating.
6. DP Exit Mode, cable removal, or a PD power-off request clears the outputs
   and cancels startup timers. Hard reset requires another successful DP
   Configure ACK before the display boards can be enabled again.

The 10ms delay is a settling allowance, not a measured VSYS or regulator
power-good qualification or an FPGA DONE check. Charger settings continue to update on a new PD
contract; an already configured display is not deliberately power-cycled
merely because its PD contract is renegotiated.

The 11W reserve is retained for both display and charging-only operation
until the charging-only load is measured; a lower idle reserve is not yet
implemented.

## Negotiated Limits

A usable input contract requires completed PD negotiation, at least 100mA
available, and input voltage from 3.6V through 15V. Input limits are programmed
even for low-power contracts that cannot charge the battery. Battery charging
separately requires at least 1500mA available, more than 5W input power,
and at least 250mA of battery charge-current budget,
above the 240mA precharge and 200mA termination settings. The CHARGE_EN output
is also gated by successful profile programming.

- VINDPM: negotiated voltage minus 500mV.
- IINDPM: negotiated fixed-supply RDO operating current (bits 19:10 in
  10mA units), capped at the charger's 3300mA limit. This matches the SDK's
  forward-input-current driver; the units of `pdc_get_req_cur()` are not assumed.
- ICHG: convert available input power to output power at an assumed 90%
  efficiency, subtract an 11W VSYS reserve, divide the remaining power by
  8.4V, then cap at 800mA. Suspend charging below a 250mA budget.
- Current registers round down to their 10mA steps.

A 5V contract requesting 900mA operating current sets IINDPM to 900mA and
VINDPM to 4500mV, with battery charging disabled. The Pixel capture's RDO
`0x1400285A` instead requests 100mA operating and 900mA maximum current;
firmware conservatively limits IINDPM to 100mA for that request, not 900mA.
The maximum-current field is not substituted for the operating-current field.
Renegotiating down from a higher-power contract
updates these limits rather than leaving the previous limits in place.
If a new request arrives during a limit or charge-enable write, the driver
retains it until the latest requested value has been written and verified.
This path requires a PD contract; non-PD Type-C current advertisement handling
is not added here. Register updates are asynchronous, not an instantaneous clamp.
PPS is not supported by this current decoder and charging remains inhibited
for it. Debugger-visible `charger_pd_current_raw`, `charger_pd_rdo`, and
`charger_pd_input_limit_ma` expose the raw API value, negotiated RDO, and
decoded input current before the 3300mA hardware cap.

The system reserve uses the confirmed 11W combined VSYS load for both FPGAs
and the wireless power solution. This replaces the earlier 2500mA load
estimate and its derived 22.5W reserve. The 90% efficiency remains an estimate.
After successful DP configuration, FPGA_POWER_READY waits for verified charger
configuration and completion of pending charger transactions before asserting
after the existing startup delay.

| PD contract | Estimated output power | Charge behavior |
| --- | --- | --- |
| 5V/100mA operating (Pixel capture) | 0.45W | Disabled; IINDPM updated to 100mA |
| 5V/900mA operating | 4.05W | Disabled; IINDPM updated to 900mA |
| 5V/2A | 9W | Disabled; source alone cannot sustain the estimated VSYS load |
| 5V/3A | 13.5W | 290mA charge limit after reserving 11W for VSYS |
| 9V/3A | 24.3W | Up to the current 800mA cap |
| 15V/3A | 40.5W | Up to the current 800mA cap |

These rows assume the firmware reports the stated negotiated input current.
The PD sink currently has 15V disabled in `pd_defs.c`; changing the charger
budget does not enable a 15V contract or control the source's advertised PDOs.
The 240mA precharge and 200mA termination values remain the existing EVM profile.

## Charge Current Rationale

The 800mA limit was retained as a conservative bring-up setting to reduce
battery charging power and heat while validating TS, input limits, and PD
behavior. It is not a battery datasheet requirement.

The local pack datasheet `3350mah_-_li18650jp_2s1p_2_wires_70mm.pdf`
identifies Jauch 246480, LI NCR18650-BF 2S1P: 3350mAh typical, 3250mAh
minimum, 8.4V charge voltage, 0.2C standard charge current, 0.5C maximum
charge current, and +10C to +45C charging temperature.
The 0.5C maximum corresponds to 1675mA using typical capacity, or 1625mA
using minimum capacity. A proposed 1500mA charge cap is below both.

A 3.5-hour empty-to-full target is plausible at 1500mA but requires
measurement: capacity/current alone gives 2.23 hours, excluding precharge
and the constant-voltage taper. Input power, system load, temperature, and
starting state of charge affect the actual time. The firmware cap remains
800mA until explicitly changed.

## FPGA Power Budget Validation

The combined load of both FPGAs and the wireless power solution is 11W
at VSYS. Confirm sustained power and startup peaks on hardware. At the
assumed 90% charger efficiency, a 5V/2A source provides only 9W to the
outputs and cannot sustain that load alone. A 5V/3A source provides 13.5W,
leaving an estimated 2.5W for battery charging.

IINDPM limits source-side input current; ICHG separately limits battery
charging current. Keep IINDPM within the negotiated source allowance and
the charger's 3300mA range. Brownout mitigation must budget system power
before charging power and account for transient response and battery state.
The previous 5W reserve was insufficient and has been replaced with an
11W output-side reserve based on the clarified combined load. This does not
guarantee brownout prevention when the source cannot sustain the system load;
battery supplement requires a connected, sufficiently charged pack.

## Polling and Debugging

`user_func_charger_poll()` runs from the main loop and uses PD timer USER3
for one-second polling. USER3 was used by the disabled `led_ctrl()`;
do not re-enable that task without allocating a different timer.

The driver verifies byte and word writes. Word transfers preserve the BQ's
MSB-first byte order. A failed transaction or readback invalidates the profile
and drives CE high; the next idle polling interval retries the profile and
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
