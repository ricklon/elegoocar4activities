# Arduino UNO Stock Baseline

This directory preserves the original ELEGOO Arduino UNO firmware inside the project workspace.

## Purpose

- provide a known-good vendor baseline for comparison
- allow easy reflashing of stock UNO firmware during troubleshooting
- keep project-modified UNO firmware separate from the original code

## Included Sketch

- `SmartRobotCarV4.0_V1_20230201/`
  - copied from the original ELEGOO package
  - intended to stay unchanged except for clearly documented archival fixes if needed

## Compare Against Project Firmware

- stock baseline:
  - `arduino-code/arduino-uno-stock/SmartRobotCarV4.0_V1_20230201/`
- project firmware:
  - `arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050/`

## Expected Behavior

- stock UNO firmware should still work with the web interface for the stock protocol subset
- project-added IMU telemetry (`N=24`) is not expected from the stock baseline
- if stock firmware works but the project firmware does not, the likely regression is in the UNO-side protocol changes
