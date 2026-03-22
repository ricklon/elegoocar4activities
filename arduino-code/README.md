# Arduino Code Layout

This folder contains the firmware sources currently used by this project, copied into one place for easier maintenance.

## Included Firmware

- `arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050/`
  - Main Arduino UNO firmware (motor/sensor/mode control).
  - Source copied from:
    - `02 Manual & Main Code & APP/02 Main Program   (Arduino UNO)/TB6612 & MPU6050/SmartRobotCarV4.0_V1_20230201/`

- `arduino-uno-stock/SmartRobotCarV4.0_V1_20230201/`
  - Preserved stock ELEGOO Arduino UNO baseline kept for comparison and troubleshooting.
  - Source copied from:
    - `02 Manual & Main Code & APP/02 Main Program   (Arduino UNO)/TB6612 & MPU6050/SmartRobotCarV4.0_V1_20230201/`

- `esp32-camera/ESP32_CameraServer_AP_simple/`
  - ESP32 camera/AP/socket bridge firmware used with ESP32-S3 camera module.
  - Source copied from:
    - `02 Manual & Main Code & APP/04 Code of Carmer (ESP32)/ESP32-WROVER-Camera/ESP32_CameraServer_AP_simple/`

- `esp32-camera-stock/wrover/ESP32_CameraServer_AP_simple/`
  - Preserved stock ELEGOO WROVER simplified camera/socket baseline.

- `esp32-camera-stock/wrover/ESP32_CameraServer_AP_20220120/`
  - Preserved older stock ELEGOO WROVER camera baseline.

- `esp32-camera-stock/s3/ESP32_CameraServer_AP_simple_local_vendor/`
  - Provisional local-vendor ESP32-S3 baseline kept separate from the project working copy.

## Notes

- These are copies to keep original vendor folders intact.
- The `arduino-uno-stock/` tree is the reference baseline.
- The `arduino-uno/` tree is the project working copy where protocol changes can be made.
- The `esp32-camera-stock/` tree is the ESP32 vendor reference baseline area.
- The `esp32-camera/` tree is the project working copy for ESP32 firmware.
- Main system/protocol details are documented in:
  - `docs/SYSTEM_PROTOCOL.md`
