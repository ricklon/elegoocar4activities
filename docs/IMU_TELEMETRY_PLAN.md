# IMU Telemetry Plan

Last updated: 2026-03-21

This plan defines the next work to expose UNO IMU data through the existing car protocol so `wifi-control-ui` can display it.

## Current State

### UNO

The current UNO firmware already includes MPU6050 support:

- initialized in `ApplicationFunctionSet_Init()`
- calibrated at startup
- used internally for yaw feedback in straight-line motion control

Relevant code:

- `ApplicationFunctionSet_xxx0.cpp`
- `MPU6050_getdata.cpp`
- `MPU6050_getdata.h`

Current limitation:

- no serial command returns IMU data to the ESP32 or bridge
- the helper currently exposes only integrated yaw via `MPU6050_dveGetEulerAngles(float *Yaw)`
- raw accel/gyro values are not surfaced through the command protocol

### ESP32

The ESP32 firmware is already a transparent relay for brace-delimited frames:

- forwards non-heartbeat TCP frames to UNO
- forwards UNO reply frames back to the TCP client

Current implication:

- no ESP32 protocol redesign is required if UNO replies stay in the existing `{TAG_value}` format

### Bridge

The bridge currently polls:

- `N=21` ultrasonic
- `N=22` IR sensors
- `N=23` ground status

Current limitation:

- it does not send IMU probes
- it does not parse IMU reply tags

### UI

The UI still shows IMU as unavailable:

- `IMU Tilt/Accel: not exposed`

## Recommended Protocol Shape

Use one new UNO command family:

- `N=24` for IMU telemetry

Use `D1` as a sub-selector and preserve the existing `{H_value}` reply style.

Recommended first version:

- `{"N":24,"D1":1,"H":"AX"}` -> `{AX_<value>}`
- `{"N":24,"D1":2,"H":"AY"}` -> `{AY_<value>}`
- `{"N":24,"D1":3,"H":"AZ"}` -> `{AZ_<value>}`
- `{"N":24,"D1":4,"H":"GX"}` -> `{GX_<value>}`
- `{"N":24,"D1":5,"H":"GY"}` -> `{GY_<value>}`
- `{"N":24,"D1":6,"H":"GZ"}` -> `{GZ_<value>}`
- `{"N":24,"D1":7,"H":"YW"}` -> `{YW_<value>}`

Rationale:

- minimal bridge changes
- minimal parser changes
- consistent with current `N/H/D` contract
- allows raw sensor bring-up before computed angles or visualization work

## Scope Recommendation

Phase 1 should expose:

- raw accelerometer axes
- raw gyroscope axes
- current integrated yaw used by the firmware

Phase 1 should not expose yet:

- fused roll/pitch
- DMP output
- high-rate streaming

Reason:

- the existing firmware already has a yaw path
- raw values are enough to validate sensor wiring, scaling, sign, and update cadence
- keeping replies single-value reduces risk and simplifies debugging

## Implementation Plan

### Phase 1. UNO firmware

Goal:

- expose IMU data through the serial command parser

Steps:

1. Extend `MPU6050_getdata` to provide a raw read helper for all six axes.
2. Add a new command declaration in `ApplicationFunctionSet_xxx0.h`:
   - `CMD_IMUModuleStatus_xxx0(uint8_t is_get);`
3. Implement `CMD_IMUModuleStatus_xxx0()` in `ApplicationFunctionSet_xxx0.cpp`.
4. Add `case 24` to `ApplicationFunctionSet_SerialPortDataAnalysis()`.
5. Keep replies in `{TAG_value}` form using the existing `H` field as the reply tag.

Recommended selector mapping:

- `1`: accel X
- `2`: accel Y
- `3`: accel Z
- `4`: gyro X
- `5`: gyro Y
- `6`: gyro Z
- `7`: yaw

Notes:

- do not change existing command ids
- do not change existing reply grammar
- avoid adding a multi-field JSON reply for the first iteration

### Phase 2. ESP32 validation

Goal:

- confirm the relay path handles the new IMU replies without firmware redesign

Steps:

1. Verify the ESP32 forwards `{AX_...}` / `{GX_...}` / `{YW_...}` unchanged.
2. Confirm negative numbers pass through cleanly.
3. Confirm the extra poll traffic does not destabilize the socket heartbeat.

Expected code changes:

- likely none

### Phase 3. Bridge support

Goal:

- poll IMU data and normalize it into browser telemetry

Steps:

1. Add IMU probes to `probesForMode()`.
2. Start conservative:
   - manual mode only first
   - lower frequency than drive commands
3. Extend `processCarFrame()` mappings:
   - `AX` -> `imuAx`
   - `AY` -> `imuAy`
   - `AZ` -> `imuAz`
   - `GX` -> `imuGx`
   - `GY` -> `imuGy`
   - `GZ` -> `imuGz`
   - `YW` -> `imuYaw`

Recommendation:

- add IMU polling only in manual mode first
- after validation, decide whether auto modes should also receive IMU polling

### Phase 4. UI support

Goal:

- display live IMU telemetry in the dashboard

Steps:

1. Extend initial telemetry state with:
   - `imuAx`
   - `imuAy`
   - `imuAz`
   - `imuGx`
   - `imuGy`
   - `imuGz`
   - `imuYaw`
2. Replace the `IMU Tilt/Accel not exposed` placeholder with real values.
3. Start with a raw telemetry panel.
4. Add derived teaching views only after raw values are stable.

### Phase 5. Documentation and validation

Goal:

- make the new protocol change explicit across the project

Steps:

1. Update `docs/SYSTEM_PROTOCOL.md`
2. Update `docs/FIRMWARE_COMPAT_CHECKLIST.md`
3. Add a short IMU note to `README.md` or quickstart docs if user-visible
4. Verify end-to-end:
   - UNO compile
   - ESP32 compile unchanged
   - bridge receives new frames
   - UI displays live IMU values

## Risks

### Poll rate and serial bandwidth

The bridge already polls frequently. Adding 6 to 7 new probes per cycle could create unnecessary load.

Mitigation:

- start with manual mode only
- use a reduced IMU polling cadence
- add yaw first if bandwidth becomes an issue

### Sensor semantics

Raw MPU6050 values are not immediately user-friendly.

Mitigation:

- expose raw values first for correctness
- document units and scale later
- only add “tilt” presentation after validation

### Drift

Current yaw is integrated from gyro Z and will drift over time.

Mitigation:

- document `YW` as relative yaw, not absolute orientation
- keep raw gyro values available alongside it

## Recommended First Deliverable

The first coding milestone should be:

- UNO supports `N=24`
- bridge polls `YW` plus raw gyro/accel in manual mode
- UI shows a basic IMU telemetry card

That gives a usable end-to-end slice without committing to a more complex fusion or visualization design too early.
