# Changelog

## v0.2.0 - 2026-03-22

- Added support for newer `ESP32-S3-WROOM-1 + QMI8658C` ELEGOO V4.0 kits.
- Preserved authoritative stock vendor baselines for:
  - newer S3 camera firmware (`V1.3`)
  - newer UNO `QMI8658C` firmware
- Added a new project UNO firmware tree for newer QMI kits with:
  - `N=24` IMU telemetry
  - `N=25` battery telemetry
- Corrected newer S3 project UART mapping to match the vendor baseline:
  - `Serial2 RX=3`
  - `Serial2 TX=40`
- Aligned newer S3 project flashing to the vendor 8MB board settings.
- Added flash helpers for:
  - stock newer-kit UNO
  - stock newer-kit S3
  - project newer-kit UNO
  - S3 serial diagnostics
- Verified:
  - WROVER path on LAN/AP
  - newer S3 vendor baseline
  - newer S3 project firmware on LAN
  - browser controls and telemetry flow
