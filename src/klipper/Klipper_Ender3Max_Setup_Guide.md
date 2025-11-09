# Klipper Setup and Troubleshooting Guide for Ender 3 Max (V4.2.2)

## 🧱 Hardware Overview

- **Printer:** Ender 3 Max
- **Mainboard:** Creality V4.2.2 (STM32F103RET6, A4988 drivers)
- **Controller:** Raspberry Pi 4 (4 GB)
- **Probe:** BLTouch / CRTouch
- **USB Bridge:** CH340 (1a86:7523 device ID)
- **Firmware Link:** Pi ⇄ Printer via USB (micro-USB port)

---

## ⚙️ Installation Workflow

### 1. Flash MainsailOS on the Pi

1. Download [MainsailOS](https://mainsailos.com) and flash it using **Raspberry Pi Imager**.
2. Add Wi-Fi credentials in Imager or edit `mainsailos-wpa-supplicant.txt`.
3. Boot → Access the web UI at `http://mainsailos.local`.

### 2. Build Klipper Firmware for the Printer

```bash
cd ~/klipper
make menuconfig
```

**Configuration:**

```
Micro-controller:  STM32F103
Bootloader offset: 28KiB
Communication:     Serial (USART1 PA10/PA9)
```

Then build:

```bash
make
```

### 3. Flash the Board

**Option A – SD Card:**

1. Rename `klipper.bin` → `firmware.bin`
2. Copy to a **≤8 GB FAT32 SD card**
3. Power off → insert card → power on → wait 1 minute
4. File should rename to `OLD.BIN` → flash OK

**Option B – DFU Flash (Reliable):**

```bash
sudo apt install dfu-util
cd ~/klipper
make flash FLASH_DEVICE=0483:df11
```

Make sure BOOT0 jumper is moved to **3.3V** during flashing, then back to **GND**.

---

## 🪛 Connection & First Boot

1. Connect printer via **short micro-USB cable** to a **USB2 port** on the Pi.
2. Find the serial device:

```bash
ls /dev/serial/by-id/
```

→ `usb-1a86_USB_Serial-if00-port0`

3. Add to `printer.cfg`:

```ini
[mcu]
serial: /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0
restart_method: command
```

4. Restart:

```bash
RESTART
```

---

## 🧯 Common Troubleshooting

| Symptom                             | Cause                                 | Fix                                |
| ----------------------------------- | ------------------------------------- | ---------------------------------- |
| **Blank LCD / no connect**          | LCD uses same UART as Klipper         | Unplug LCD                         |
| **`mcu 'mcu': Timeout on connect`** | LCD conflict / bootloader issue       | Reflash firmware, unplug LCD       |
| **File not renaming**               | Bootloader issue / SD incompatibility | Flash via DFU                      |
| **`urb stopped: -32`**              | CH340 power issue                     | Use USB2 port, disable autosuspend |
| **`!! Unknown heater 'bed'`**       | `[heater_bed]` missing                | Add `[heater_bed]` config          |
| **Printer only works without LCD**  | UART contention                       | Leave LCD disconnected             |

---

## 🧠 Key Config Snippets

```ini
[heater_bed]
heater_pin: PA1
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PC4
control: pid
min_temp: 0
max_temp: 110

[fan]
pin: PA7

[bltouch]
sensor_pin: ^PC14
control_pin: PB1
x_offset: -44
y_offset: -9
z_offset: -1.8
```

---

## 🧭 Essential Commands

| Purpose              | Command                                                | Notes                    |
| -------------------- | ------------------------------------------------------ | ------------------------ |
| Home all axes        | `G28`                                                  | Must home before mesh    |
| Bed mesh             | `BED_MESH_CALIBRATE`                                   | Builds height map        |
| PID tune extruder    | `PID_CALIBRATE HEATER=extruder TARGET=200`             | ~10 min                  |
| PID tune bed         | `PID_CALIBRATE HEATER=bed TARGET=60`                   | ~15 min                  |
| Save tuned values    | `SAVE_CONFIG`                                          | Writes to cfg            |
| Z-offset calibration | `PROBE_CALIBRATE` → `TESTZ` → `ACCEPT` → `SAVE_CONFIG` | Sets nozzle height       |
| Check status         | `STATUS`                                               | Shows heater/motion info |

---

## 🧩 Advanced Tuning

After connecting an **ADXL345**:

```gcode
TEST_RESONANCES AXIS=X
TEST_RESONANCES AXIS=Y
SHAPER_CALIBRATE
SAVE_CONFIG
```

Then tune pressure advance:

```gcode
TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=0.005
```
