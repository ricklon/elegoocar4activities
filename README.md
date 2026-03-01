# ELEGOO Smart Robot Car V4.0 - Classroom FPV Control

[Smart Robot Car Kit V4.0 (With Camera)](https://us.elegoo.com/products/elegoo-smart-robot-car-kit-v-4-0)

This repository is a classroom-focused control stack for the ELEGOO Smart Robot Car V4.0.
It combines curated firmware copies with a browser FPV dashboard and a local bridge service.

## Start Here

- For classroom bring-up: `docs/QUICKSTART.md`
- For protocol/system behavior: `docs/SYSTEM_PROTOCOL.md`
- For project context: `docs/PROJECT_OVERVIEW.md`
- For UI usage details: `wifi-control-ui/README.md`
- For firmware layout and compile notes: `arduino-code/README.md`

## Docs Index

- [Quickstart](docs/QUICKSTART.md)
- [System Protocol](docs/SYSTEM_PROTOCOL.md)
- [Project Overview](docs/PROJECT_OVERVIEW.md)
- [Arduino CLI Guide](docs/ARDUINO_CLI_GUIDE.md)
- [ESP32-S3 Troubleshooting](docs/ESP32_S3_TROUBLESHOOTING.md)
- [Licensing](docs/LICENSING.md)

## What This Project Adds

- Browser-based FPV driving (joystick, D-pad, keyboard)
- Explicit mode workflow (`FPV / Manual`, `Line Follow`, `Obstacle`, `Follow`)
- Live telemetry + challenge cards for activities
- Session recording (CSV) + image snapshots
- Bridge process that adapts browser WebSocket traffic to car TCP protocol

## Runtime Topology

1. Browser UI <-> WebSocket bridge (`ws://<host>:8787`)
2. Bridge <-> ESP32 socket (`192.168.4.1:100`)
3. ESP32 <-> UNO over UART
4. Camera stream (`http://192.168.4.1:81/stream`)

## Repository Layout

- `wifi-control-ui/`
  - React/Vite dashboard
  - Bridge server at `wifi-control-ui/server/bridge.mjs`
- `arduino-code/`
  - Curated UNO and ESP32 firmware used by this project
- `docs/`
  - Quickstart, protocol, overview, troubleshooting, and licensing docs

## Quick Dev Run (UI + Bridge)

Preferred (one command):

```bash
cd wifi-control-ui
npm install
npm run car
```

Aliases: `npm run classroom`, `npm run start-car`

If you want manual split terminals instead:

```bash
# terminal A
cd wifi-control-ui
npm run bridge

# terminal B
cd wifi-control-ui
npm run dev -- --host
```

Open the Vite URL (typically `http://localhost:5173`), then use:
- Bridge Host:Port = `localhost:8787`
- Car Host = `192.168.4.1`
- Car TCP Port = `100`

## Basic Car Connection (Fast Path)

1. Power on the car.
2. Join the car Wi-Fi network (`ELEGOO-...`) on your laptop/phone.
3. Start the app from `wifi-control-ui` with `npm run car`.
4. Open the UI URL shown in terminal (typically `http://localhost:5173`).
5. In the UI, click `Connect Bridge + Car` and verify:
   - `Bridge: online`
   - `Car TCP: online`
   - camera stream visible

## Activities

More classroom activities and mode-based workflows are documented in:
- [docs/QUICKSTART.md](docs/QUICKSTART.md)
- [docs/PROJECT_OVERVIEW.md](docs/PROJECT_OVERVIEW.md)
- [wifi-control-ui/STUDENT_QUICKSTART.md](wifi-control-ui/STUDENT_QUICKSTART.md)

## Notes

- `N22` polling is intentionally disabled in auto modes to avoid UNO mode disruption.
- ESP32 heartbeat frame (`{Heartbeat}`) must be echoed by the bridge.
- Obstacle threshold in current stock UNO firmware is 20 cm.

## License

This project follows upstream ELEGOO licensing intent for derived firmware/materials, while preserving third-party component licenses.

See `docs/LICENSING.md` for details.
