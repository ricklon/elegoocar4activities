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
- `s3/ESP32_CameraServer_AP_simple_local_vendor/`
  - provisional stock S3 baseline copied from the local vendor-provided classroom project bundle
  - this is not yet confirmed against a public official upstream URL

## Project Working Copy

- `arduino-code/esp32-camera/ESP32_CameraServer_AP_simple/`
  - project-modified firmware used for current development

## Notes

- the stock WROVER trees should stay unchanged unless we add explicit archival notes
- the S3 tree here is a local-vendor baseline, not a public-official baseline
- if a public official S3 package is found later, it should replace or sit beside this provisional S3 baseline with clear labeling
