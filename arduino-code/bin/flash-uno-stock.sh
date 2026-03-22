#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKETCH_DIR="$ROOT_DIR/arduino-code/arduino-uno-stock/SmartRobotCarV4.0_V1_20230201"
BUILD_DIR="${BUILD_DIR:-/tmp/arduino-build-uno-stock}"
FQBN="arduino:avr:uno"
PORT="${1:-/dev/ttyUSB0}"

if [[ -x "$HOME/mymachine/bin/arduino-cli" ]]; then
  ARDUINO_CLI="$HOME/mymachine/bin/arduino-cli"
elif command -v arduino-cli >/dev/null 2>&1; then
  ARDUINO_CLI="$(command -v arduino-cli)"
else
  echo "arduino-cli not found" >&2
  exit 1
fi

echo "Using arduino-cli: $ARDUINO_CLI"
echo "Sketch: $SKETCH_DIR"
echo "Build dir: $BUILD_DIR"
echo "Port: $PORT"
echo "FQBN: $FQBN"

"$ARDUINO_CLI" compile --build-path "$BUILD_DIR" --fqbn "$FQBN" "$SKETCH_DIR"
"$ARDUINO_CLI" upload -p "$PORT" --fqbn "$FQBN" --input-dir "$BUILD_DIR" "$SKETCH_DIR"

echo "Stock UNO flash complete."
