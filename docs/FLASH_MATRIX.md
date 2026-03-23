# Flash Matrix

Reference for which firmware, script, and hardware combination to use.

## Firmware Tiers

| Tier | ESP32 Sketch | UNO Sketch | Purpose |
|------|-------------|-----------|---------|
| Stock | `esp32-camera-stock/s3/ESP32_CameraServer_AP_2023_V1.3_vendor_s3` | `arduino-uno-stock/SmartRobotCarV4.0_V*` | Vendor reference only. Do not modify. |
| 2 — Class | `esp32-camera/ESP32_CameraServer_AP_simple` | `arduino-uno/SmartRobotCarV4.0_V*_TB6612_*` | Stable classroom firmware. Flash for class sessions. |
| 3 — WS | `esp32-camera/ESP32_CameraServer_WS` | same as Tier 2 | mDNS hostname, car identity. Use `provision-car-*.sh` to flash. |

## Script Matrix

### ESP32 — Tier 2 (class firmware)

| Hardware | Script | Default port |
|----------|--------|-------------|
| ESP32-S3 | `arduino-code/bin/flash-esp32-s3.sh` | `/dev/ttyACM0` |
| ESP32-WROVER | `arduino-code/bin/flash-esp32-wrover.sh` | `/dev/ttyUSB0` |

### ESP32 — Tier 3 (WS firmware, flash only)

| Hardware | Script | Default port |
|----------|--------|-------------|
| ESP32-S3 | `arduino-code/bin/flash-esp32-s3-ws.sh` | `/dev/ttyACM0` |
| ESP32-WROVER | `arduino-code/bin/flash-esp32-wrover-ws.sh` | `/dev/ttyUSB0` |

### ESP32 — Tier 3 (WS firmware, provision + flash in one step)

| Hardware | Script | Default port |
|----------|--------|-------------|
| ESP32-S3 | `arduino-code/bin/provision-car-s3.sh` | `/dev/ttyACM0` |
| ESP32-WROVER | `arduino-code/bin/provision-car-wrover.sh` | `/dev/ttyUSB0` |

### ESP32 — Stock (reference baseline)

| Hardware | Script | Default port |
|----------|--------|-------------|
| ESP32-S3 | `arduino-code/bin/flash-esp32-s3-stock.sh` | `/dev/ttyACM0` |
| ESP32-WROVER | _(no script — use vendor IDE)_ | — |

### UNO

| Kit variant | Script | Default port |
|-------------|--------|-------------|
| V1 MPU6050 (older kit) | `arduino-code/bin/flash-uno-imu.sh` | auto-detect |
| V2 QMI8658C (newer kit) | `arduino-code/bin/flash-uno-qmi-imu.sh` | auto-detect |
| V1 stock baseline | `arduino-code/bin/flash-uno-stock.sh` | auto-detect |
| V2 stock baseline | `arduino-code/bin/flash-uno-stock-qmi.sh` | auto-detect |

UNO port auto-detection tries `/dev/ttyUSB0` then `/dev/ttyACM0`. Pass a port explicitly if needed.

---

## Serial Device Reference

| Board | USB chip | Serial device | Baud |
|-------|----------|--------------|------|
| ESP32-S3 | Native USB (CDC) | `/dev/ttyACM0` | 115200 |
| ESP32-WROVER | External USB-serial | `/dev/ttyUSB0` | 115200 |
| Arduino UNO | External USB-serial | `/dev/ttyUSB0` or `/dev/ttyACM0` | 9600 (car) / 115200 (IDE) |

On macOS, substitute `/dev/cu.usbmodem*` (S3) or `/dev/cu.usbserial*` (WROVER/UNO).

---

## Network Behavior After Flash

| Scenario | Car address | Notes |
|----------|------------|-------|
| No saved credentials (fresh flash) | `192.168.4.1` | Car starts ELEGOO AP. Join `ELEGOO-<id>`. |
| Saved credentials, network reachable | LAN IP or `<hostname>.local` | Tier 3 only advertises mDNS. Tier 2 is IP-only. |
| Saved credentials, network unreachable | `192.168.4.1` (after ~20s timeout) | Falls back to AP. |
| Serial recovery (`r` key at boot) | `192.168.4.1` | Credentials cleared, immediate AP mode. |

---

## FQBN Reference

| Hardware | FQBN |
|----------|------|
| ESP32-S3 | `esp32:esp32:esp32s3:FlashSize=8M,PartitionScheme=default_8MB,PSRAM=opi,CDCOnBoot=cdc` |
| ESP32-WROVER | `esp32:esp32:esp32:PartitionScheme=huge_app,PSRAM=enabled` |
| Arduino UNO | `arduino:avr:uno` |
