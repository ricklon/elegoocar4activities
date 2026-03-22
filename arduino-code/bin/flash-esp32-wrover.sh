#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKETCH_PATH="$ROOT_DIR/arduino-code/esp32-camera/ESP32_CameraServer_AP_simple/ESP32_CameraServer_AP_simple.ino"
DEFAULT_PORT="/dev/ttyUSB0"
FQBN="esp32:esp32:esp32:PartitionScheme=huge_app,PSRAM=enabled"

resolve_arduino_cli() {
  if [[ -x "${HOME}/mymachine/bin/arduino-cli" ]]; then
    printf '%s\n' "${HOME}/mymachine/bin/arduino-cli"
    return
  fi
  if command -v arduino-cli >/dev/null 2>&1; then
    command -v arduino-cli
    return
  fi
  if [[ -x "$ROOT_DIR/arduino-code/arduino-uno/bin/arduino-cli" ]]; then
    printf '%s\n' "$ROOT_DIR/arduino-code/arduino-uno/bin/arduino-cli"
    return
  fi
  printf 'Could not find arduino-cli in ~/mymachine/bin, PATH, or arduino-code/arduino-uno/bin.\n' >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage: flash-esp32-wrover.sh [port]

Compiles and uploads the project ESP32-WROVER camera firmware.

Arguments:
  port    Serial port to use for upload. Default: /dev/ttyUSB0

Examples:
  arduino-code/bin/flash-esp32-wrover.sh
  arduino-code/bin/flash-esp32-wrover.sh /dev/ttyUSB1
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

PORT="${1:-$DEFAULT_PORT}"
ARDUINO_CLI="$(resolve_arduino_cli)"

printf 'Using arduino-cli: %s\n' "$ARDUINO_CLI"
printf 'Sketch: %s\n' "$SKETCH_PATH"
printf 'Port: %s\n' "$PORT"
printf 'FQBN: %s\n' "$FQBN"

"$ARDUINO_CLI" compile --fqbn "$FQBN" "$SKETCH_PATH"
"$ARDUINO_CLI" upload -p "$PORT" --fqbn "$FQBN" "$SKETCH_PATH"

printf 'ESP32-WROVER flash complete.\n'
