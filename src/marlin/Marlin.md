# Marlin Config for Ender 3 Max

Personal notes about marlin firmware config, instructions to set the correct z-offset for the BLTouch probe, and Cura start/end commands.

## Firmware

[Marlin](https://github.com/MarlinFirmware/Marlin) v2.0.x firmware config for Ender 3 Max + BLTouch.

### After Install

- Tune PID (hotend)
- Tune PID (bed)
- Calibrate extruder E-Steps
- Calibrate Probe Z-Offset

## PID Tuning

### Hotend Calibration

Ensure fan is running at 100%

```gcode
M106 S255
```

Use `M303` to get PID values

```gcode
M303 E0 S200 C8 ; M303 <extruder ID> S<temperature in Celsius> C<iterations>
```

Use the outputs of `M303` and store them using:

#### Store Hotend PID Values

```gcode
M301 P27.46 I2.77 D68.11 ; Example values
M500 ; Save to EEPROM
```

OR change your firmware if building firmware from scratch:

```gcode
; Example values
#define DEFAULT_Kp 27.46
#define DEFAULT_Ki 2.77
#define DEFAULT_Kd 68.11
```

### Bed Calibration

Similar to Hotend calibration with the exception of the ID and the command to store the values in EEPROM.

```gcode
M303 E-1 S60 C10
```

#### Store Bed PID Values

```gcode
M304 P146.37 I27.93 D511.31; Example values
M500 ; Save to EEPROM
```

OR change your firmware if building from scratch:

```gcode
; Example values
Recv: #define DEFAULT_bedKp 146.37
Recv: #define DEFAULT_bedKi 27.93
Recv: #define DEFAULT_bedKd 511.31

```

## Calibrate Bed Levelling Probe (BLTouch) Z-offset

To set the correct Z-offset for the bed levelling probe on a Creality Ender 3 Max 3D Printer run the following commands and follow the instuctions below. For this a tool like [OctoPrint](https://github.com/OctoPrint/OctoPrint) or PrintRun's [Pronterface](https://github.com/kliment/Printrun) is necessary.

```gcode
G28 ; Home all axes
M851 Z0 ; Clear Z-offset

M500 ; Save Settings
M501 ; Reload Settings
; M503 ; Read Settings

G28 Z0; Home Z-axis to 0

M211 S0 ; Disable Z-axis safety measures to allow negative values

; Position Z-axis to the desired location
; Lower the Z-axis until it is at the desired position using printer's interface or a tool like OctoPrint or Pronterface.
; Take note of the `Z-value` (Usually negative).

M851 Z-2 ; -2 is just an example ; Set the Z-offset using the `Z-value` noted above `M851 Z<offset>
M211 S1 ; Enable Z-axis safety measures

M500 ; Store Settings
M501 ; Reload Settings
; M503 ; Read Settings
```

NOTE on bed-levelling. Homing will disable bed-levelling unless `RESTORE_LEVELING_AFTER_G28` is set in `Configuration.h`. To do this manually `M420 S1` will re-enable it and load the last saved mesh.
