#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKETCH_PATH="$ROOT_DIR/arduino-code/esp32-camera-stock/s3/ESP32_CameraServer_AP_2023_V1.3_vendor_s3"
DEFAULT_PORT="/dev/ttyACM0"
FQBN="esp32:esp32:esp32s3:FlashSize=8M,PartitionScheme=default_8MB,PSRAM=opi,CDCOnBoot=cdc"

if [[ -x "$HOME/mymachine/bin/arduino-cli" ]]; then
  ARDUINO_CLI="$HOME/mymachine/bin/arduino-cli"
elif command -v arduino-cli >/dev/null 2>&1; then
  ARDUINO_CLI="$(command -v arduino-cli)"
else
  echo "arduino-cli not found" >&2
  exit 1
fi

PORT="${1:-$DEFAULT_PORT}"

echo "Using arduino-cli: $ARDUINO_CLI"
echo "Sketch: $SKETCH_PATH"
echo "Port: $PORT"
echo "FQBN: $FQBN"

"$ARDUINO_CLI" compile --fqbn "$FQBN" "$SKETCH_PATH"
"$ARDUINO_CLI" upload -p "$PORT" --fqbn "$FQBN" "$SKETCH_PATH"

echo "Vendor ESP32-S3 flash complete."
