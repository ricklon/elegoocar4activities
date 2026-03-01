# STEM Activity Cards (IR Remote Only)

This deck is for classrooms using the bundled IR remote only.

No phone pairing, Wi-Fi join, bridge, or web dashboard is required.

## When To Use This Deck

- You want the fastest setup with no network steps.
- You need offline operation.
- You want activities compatible with stock firmware + IR control path.

## Quick Start (No App, No Pairing)

1. Power on the car.
2. Confirm fresh batteries in car and IR remote.
3. Point remote at the car's IR receiver and test motion keys.
4. Run activities.

## IR Button Mapping (From Current UNO Firmware)

Firmware source:
- `ApplicationFunctionSet_IRrecv`: `arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050/ApplicationFunctionSet_xxx0.cpp`
- IR decode map: `arduino-code/arduino-uno/SmartRobotCarV4.0_V1_20230201_TB6612_MPU6050/DeviceDriverSet_xxx0.cpp`

Behavior map:
- `Up` -> forward
- `Down` -> backward
- `Left` -> left turn
- `Right` -> right turn
- `OK` -> standby/stop
- `1` -> line follow mode
- `2` -> obstacle mode
- `3` -> follow mode
- `4` -> line threshold up (only in line mode)
- `5` -> line threshold reset to default (only in line mode)
- `6` -> line threshold down (only in line mode)
- `7` -> speed up
- `8` -> reset speed to high default
- `9` -> speed down

Notes:
- Arrow-direction driving is time-limited in firmware and returns to standby if no repeat input arrives.
- Remote shell labels can vary; use behavior tests above if printed labels differ.

## Safety Baseline (All Activities)

1. Keep cars on floor tracks only.
2. Assign one student as safety stop operator (`OK` button).
3. Keep a clear perimeter around the course.
4. Use lightweight obstacles only.

## Card 1: Remote Driving Precision

- `Grade Band`: 3-8
- `Time`: 15-20 min
- `Mode`: Manual (arrows)
- `Task`:
  1. Tape a start line and 3 parking boxes.
  2. Drive from start and stop inside each box.
  3. Run 5 rounds and count successful stops.
- `Success Criteria`:
  - 3/5 or better clean stops.

## Card 2: Speed Step Investigation

- `Grade Band`: 4-9
- `Time`: 20 min
- `Mode`: Manual (arrows + `7/8/9`)
- `Task`:
  1. Run a fixed straight distance at low, medium, and high remote speed.
  2. Record time and stopping overshoot for each level.
  3. Compare control precision vs speed.
- `Success Criteria`:
  - Team identifies best speed setting for control vs pace.

## Card 3: Line Follow Tuning Lab

- `Grade Band`: 5-10
- `Time`: 20-30 min
- `Mode`: Line Follow (`1`, then `4/5/6` tuning)
- `Task`:
  1. Build a high-contrast track with one curve.
  2. Start line follow and observe performance.
  3. Adjust threshold using `4` or `6`, retest, and compare.
- `Success Criteria`:
  - Team documents one threshold setting that improves reliability.

## Card 4: Obstacle Reliability Runs

- `Grade Band`: 5-10
- `Time`: 20-30 min
- `Mode`: Obstacle (`2`)
- `Task`:
  1. Build three obstacle layouts (easy/medium/hard).
  2. Run each layout three times.
  3. Log collisions, near misses, and successful avoids.
- `Success Criteria`:
  - Team identifies which layout constraints reduce failures.

## Card 5: Follow Mode Procedure

- `Grade Band`: 6-12
- `Time`: 20-30 min
- `Mode`: Follow (`3`)
- `Task`:
  1. Run three trials with different leader distances/speeds.
  2. Record where follow behavior is reliable vs unreliable.
  3. Write a short "best practice" guide for the leader.
- `Success Criteria`:
  - Team creates a repeatable 4-5 step follow procedure.

## Card 6: IR Mission Relay (Capstone)

- `Grade Band`: 6-12
- `Time`: 30-40 min
- `Mode`: Manual + one auto mode
- `Task`:
  1. Complete a mission course with one manual segment and one auto segment.
  2. Run once, identify failures, then run again with one improvement.
  3. Present what changed and why it worked.
- `Success Criteria`:
  - Second run improves completion quality or time.

## Evidence Collection Without App/UI

Use a paper log sheet:
- Trial number
- Selected mode
- Speed setting (low/med/high; note button presses)
- Completion time
- Errors (collision, off track, stall)
- Reflection notes

Optional:
- Video record runs for replay and discussion.

## Assessment Rubric (Quick)

- `4 - Exceeds`: repeatable method, clear evidence, strong reflection.
- `3 - Meets`: complete trials and evidence-backed claims.
- `2 - Approaching`: partial data or unclear method.
- `1 - Beginning`: limited completion and weak evidence.
