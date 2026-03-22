#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKETCH_PATH="$ROOT_DIR/arduino-code/esp32-diagnostics/ESP32_S3_SerialDiag/ESP32_S3_SerialDiag.ino"
DEFAULT_PORT="/dev/ttyACM0"
FQBN="esp32:esp32:esp32s3:FlashSize=8M,PartitionScheme=default_8MB,PSRAM=opi,CDCOnBoot=cdc"

find_arduino_cli() {
  if [[ -x "${HOME}/mymachine/bin/arduino-cli" ]]; then
    printf '%s\n' "${HOME}/mymachine/bin/arduino-cli"
    return 0
  fi
  if command -v arduino-cli >/dev/null 2>&1; then
    command -v arduino-cli
    return 0
  fi
  printf 'Could not find arduino-cli in ~/mymachine/bin or PATH.\n' >&2
  return 1
}

PORT="${1:-$DEFAULT_PORT}"
ARDUINO_CLI="$(find_arduino_cli)"

printf 'Using arduino-cli: %s\n' "$ARDUINO_CLI"
printf 'Sketch: %s\n' "$SKETCH_PATH"
printf 'Port: %s\n' "$PORT"
printf 'FQBN: %s\n' "$FQBN"

"$ARDUINO_CLI" compile --fqbn "$FQBN" "$SKETCH_PATH"
"$ARDUINO_CLI" upload -p "$PORT" --fqbn "$FQBN" "$SKETCH_PATH"

printf 'ESP32-S3 serial diagnostic flash complete.\n'
