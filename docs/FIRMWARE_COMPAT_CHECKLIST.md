# Firmware Compatibility Checklist (UNO + ESP32-S3 + Web UI)

Last verified: 2026-03-02

This checklist defines the firmware contract required for `wifi-control-ui` and records current compile/audit status.

## 1) Required Firmware Sources

- UNO:
  - `arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050`
  - main sketch file: `SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050.ino`
- ESP32-S3 camera/socket:
  - `arduino-code/esp32-camera/ESP32_CameraServer_AP_simple`

## 2) Command Contract (Must Stay Compatible)

Commands used by UI/bridge and required in UNO parser:
- `N=3` drive (`D1` direction, `D2` speed)
- `N=100` stop/standby
- `N=110` clear/programming mode
- `N=101` mode select (`D1=1 line`, `2 obstacle`, `3 follow`)
- `N=21` ultrasonic telemetry (`D1=1 bool`, `D1=2 distance`)
- `N=22` IR telemetry (`D1=0/1/2` left/mid/right)
- `N=23` ground safety status
- `N=24` IMU telemetry (`D1=1..3 accel`, `4..6 gyro`, `7 yaw cdeg`)

Reply frame format required by bridge:
- `{<H>_<value>}` (examples: `{US_37}`, `{UO_true}`, `{GR_false}`)

Heartbeat contract required between bridge and ESP32:
- ESP32 sends `{Heartbeat}` about every 1s.
- Bridge must echo `{Heartbeat}`.
- On disconnect/no station, ESP32 should send stop command `{"N":100}` to UNO.

## 3) Critical Behavior Constraints

- Do not poll `N22` during auto modes (`line`, `obstacle`, `follow`).
  - UNO `CMD_TraceModuleStatus_xxx0` forces programming mode after response.
- Stock obstacle threshold is `20 cm`.

## 4) Compile Targets

- UNO FQBN:
  - `arduino:avr:uno`
- ESP32-S3 FQBN:
  - `esp32:esp32:esp32s3:PartitionScheme=huge_app,PSRAM=opi,CDCOnBoot=cdc`

## 5) Compile Audit Result (2026-03-01)

- ESP32-S3 compile: `PASS`
  - Size: `792929` bytes program (`25%`)
  - Globals: `57816` bytes (`17%`)
- UNO compile: `PASS`
  - Size: `31250` bytes program (`96%`)
  - Globals: `1204` bytes (`58%`)

## 5a) IMU Telemetry Extension Audit (2026-03-21)

- UNO compile with `N=24` IMU telemetry: `PASS`
  - Size: `31670` bytes program (`98%`)
  - Globals: `1204` bytes (`58%`)
- Bridge/UI support added for:
  - `AX`, `AY`, `AZ`
  - `GX`, `GY`, `GZ`
  - `YW` (`imuYawCdeg`)

## 6) Re-run Commands

If your `arduino-cli` is in another path, substitute it below.

```bash
CLI="/home/ra/Documents/ELEGOO Smart Robot Car Kit V4.0 2023.02.01/bin/arduino-cli"
```

ESP32-S3 compile:

```bash
"$CLI" compile --build-path /tmp/arduino-build-esp32 \
  --fqbn esp32:esp32:esp32s3:PartitionScheme=huge_app,PSRAM=opi,CDCOnBoot=cdc \
  "arduino-code/esp32-camera/ESP32_CameraServer_AP_simple/ESP32_CameraServer_AP_simple.ino"
```

UNO compile:

```bash
"$CLI" compile --build-path /tmp/arduino-build-uno \
  --fqbn arduino:avr:uno \
  "arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050"
```
