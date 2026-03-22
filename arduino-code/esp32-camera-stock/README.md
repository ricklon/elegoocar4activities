# ESP32 Camera Stock Baselines

This directory preserves stock vendor ESP32 camera firmware baselines inside the project workspace.

## Purpose

- keep official/vendor ESP32 camera firmware separate from the project working copy
- provide known-good hardware-specific baselines for WROVER and S3 investigations
- make it easier to compare project changes against the correct board family

## Included Baselines

- `wrover/ESP32_CameraServer_AP_simple/`
  - stock simplified WROVER camera/socket firmware copied from the ELEGOO package
- `wrover/ESP32_CameraServer_AP_20220120/`
  - older stock WROVER firmware copied from the ELEGOO package
- `s3/ESP32_CameraServer_AP_2023_V1.3_vendor_s3/`
  - authoritative stock S3 baseline copied from the ELEGOO 2024.01.30 package
  - matches the newer ESP32-S3-WROOM-1 camera kits
- `s3/ESP32_CameraServer_AP_simple_vendor_s3/`
  - older provisional local-vendor S3 baseline kept only for archival comparison

## Project Working Copy

- `arduino-code/esp32-camera/ESP32_CameraServer_AP_simple/`
  - project-modified firmware used for current development

## Notes

- the stock WROVER trees should stay unchanged unless we add explicit archival notes
- the `ESP32_CameraServer_AP_2023_V1.3_vendor_s3` tree is now the preferred S3 stock baseline for newer kits
- the older `ESP32_CameraServer_AP_simple_vendor_s3` tree is retained only as an archival reference
- the preferred project S3 working copy should follow the vendor V1.3 wiring assumptions for newer kits, including `Serial2 RX=3` and `TX=40`
