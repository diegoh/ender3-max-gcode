# Marlin & Klipper Config for Ender 3 Max (4.2.2 with STM32F103)

Modifications: dual z + bl-touch / crtouch

- [Marlin Guide & Files](./src/marlin/Marlin.md)
- [Klipper Guide & Files](./src/marlin/Klipper.md)

## Thoughts

In my opinion Klipper is absolutely better as the processing is done on the Raspberry Pi rather than the STM32 MCU.

From the initial print, the movement was a lot smoother and the compensation achieved through accelerometers means that printing speeds are significantly faster.

The trade-off is that the screen needs to be unplugged for the firmware to be flashed successfully. I haven't looked further, so there might be options available.
