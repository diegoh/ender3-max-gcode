# Creality Ender 3 Max - BL Touch Settings

I came across an issue after installing BL Touch on my 3D Printer where the Z-axis would be too high. The Z-offset would simply not go low enough. These are the instructions to solve this issue and my startup settings for Cura.

## Firmware

[Marlin](https://github.com/MarlinFirmware/Marlin) 2.0.9

## Setup

### Manual steps to get the right Z-offset in an Ender 3 Max

To set the correct Z-offset using Creality's BL Touch on a Creality Ender 3 Max 3D Printer run the following commands and follow the instuctions using tools like [OctoPrint](https://github.com/OctoPrint/OctoPrint) or PrintRun's [pronterface](https://github.com/kliment/Printrun).

#### 1. Home all axes

```gcode
G28
```

#### 2. Clear the current Z-offset

```gcode
M851 Z0
```

#### 3. Save and Reload the Changes

```gcode
M500 ; Store Settings
M501 ; Reload Settings
M503 ; Read Settings
```

#### 4. Home Z-axis to 0

```gcode
G28 Z0
```

#### 5. Disable Z-axis safety measures to allow negative values

```gcode
M211 S0
```

#### 6. Position Z-axis to the desired location

Lower the Z-axis until it is at the desired position using printer's interface or a tool like OctoPrint or Pronterface and a piece of paper.
Take note of the `Z-value` (Usually negative).

#### 7. Set the Z-offset using the `Z-value` noted above `M851 Z<offset>

```gcode
M851 Z-2 ; NOTE -2 is an example
```

#### 8. Enable Z-axis safety measures

```gcode
M211 S1
```

#### 9. Save and Reload the Changes

```gcode
M500 ; Store Settings
M501 ; Reload Settings
M503 ; Read Settings
```

## Homing Disables Bed Levelling

Run `M420 S1` to enable it or `M420 S0` to disable it
