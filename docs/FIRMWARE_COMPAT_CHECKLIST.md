# Firmware Compatibility Checklist (UNO + ESP32-S3 + Web UI)

Last verified: 2026-03-22

This checklist defines the firmware contract required for `wifi-control-ui` and records current compile/audit status.

## 1) Required Firmware Sources

### UNO (use the path that matches your kit)

- V1 — older `MPU6050` kit:
  - `arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050`
- V2 — newer `QMI8658C` kit:
  - `arduino-code/arduino-uno/SmartRobotCarV4.0_V2_20220322_TB6612_QMI8658C`

Both UNO variants implement the same command/telemetry protocol (`N=3`, `N=24`, `N=25`, etc.).

### ESP32 camera/socket (choose tier)

- Tier 2 — class firmware (stable):
  - `arduino-code/esp32-camera/ESP32_CameraServer_AP_simple`
  - supports ESP32-S3 and ESP32-WROVER via `board_profile.h`
- Tier 3 — WS firmware (mDNS, car identity):
  - `arduino-code/esp32-camera/ESP32_CameraServer_WS`
  - supports ESP32-S3 and ESP32-WROVER via `board_profile.h`

See `docs/FLASH_MATRIX.md` for the full script-per-variant reference.

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
- `N=25` battery telemetry (`BV` centivolts)

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

- UNO FQBN: `arduino:avr:uno`
- ESP32-S3 FQBN: `esp32:esp32:esp32s3:FlashSize=8M,PartitionScheme=default_8MB,PSRAM=opi,CDCOnBoot=cdc`
- ESP32-WROVER FQBN: `esp32:esp32:esp32:PartitionScheme=huge_app,PSRAM=enabled`

Both ESP32 tiers (Tier 2 `ESP32_CameraServer_AP_simple`, Tier 3 `ESP32_CameraServer_WS`) use the same FQBNs.

## 5) Compile Audit Result

- ESP32-S3 compile with newer vendor settings: `PASS`
  - Size: `804545` bytes program (`24%` of `3342336`)
  - Globals: `57816` bytes (`17%`)
- UNO compile (`MPU6050` path): `PASS`
  - Size: `31250` bytes program (`96%`)
  - Globals: `1204` bytes (`58%`)
- UNO compile (`QMI8658C` path with `N=24` and `N=25`): `PASS`
  - Size: `31144` bytes program (`96%`)
  - Globals: `1221` bytes (`59%`)

## 5a) IMU Telemetry Extension Audit (2026-03-21)

- UNO compile with `N=24` IMU telemetry: `PASS`
- UNO compile with `N=24` IMU telemetry and `N=25` battery telemetry: `PASS`
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
  --fqbn esp32:esp32:esp32s3:FlashSize=8M,PartitionScheme=default_8MB,PSRAM=opi,CDCOnBoot=cdc \
  "arduino-code/esp32-camera/ESP32_CameraServer_AP_simple/ESP32_CameraServer_AP_simple.ino"
```

UNO compile:

```bash
"$CLI" compile --build-path /tmp/arduino-build-uno \
  --fqbn arduino:avr:uno \
  "arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050"
```
