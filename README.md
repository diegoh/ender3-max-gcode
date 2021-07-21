# Config for Ender 3 Max

Includes marlin firmware config, instructions to set the correct z-offset for the BLTouch probe, and Cura start/end commands.

## Firmware

[Marlin](https://github.com/MarlinFirmware/Marlin) v2.0.x firmware config for Ender 3 Max + BLTouch.

### After Install

- Tune PID (hotend)
- Tune PID (bed)
- Calibrate extruder E-Steps
- Calibrate Probe Z-Offset (see below)

## Z-offset calibration

I came across an issue after installing BL Touch on my 3D Printer where the Z-axis would be too high. The Z-offset would simply not go low enough. These are the instructions to solve this issue and my startup settings for Cura.

### Fix bltouch Z-offset in an Ender 3 Max

To set the correct Z-offset using Creality's BL Touch on a Creality Ender 3 Max 3D Printer run the following commands and follow the instuctions [here](/src/bl-touch-z-offset.gcode). For this a tool like [OctoPrint](https://github.com/OctoPrint/OctoPrint) or PrintRun's [Pronterface](https://github.com/kliment/Printrun) is necessary.

## Cura

See [start](/src/cura/start.gcode) and [end](/src/cura/start.gcode) scripts.
