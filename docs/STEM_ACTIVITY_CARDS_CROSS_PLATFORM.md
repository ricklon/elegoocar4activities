# STEM Activity Cards (Cross-Platform Deck)

This deck is designed to work with either:
- the original ELEGOO app, or
- this project dashboard (`wifi-control-ui`).

The core tasks only require driving controls, camera view, and mode selection that both control paths support.

## Use This Deck When

- You have mixed classroom setups (some teams on stock app, some on dashboard).
- You want comparable outcomes regardless of control interface.
- You want optional data extensions for teams using `wifi-control-ui`.

## Safety Baseline (All Cards)

1. Keep cars on floor tracks only.
2. Assign a safety operator with immediate stop responsibility.
3. Use soft obstacles and clear boundary zones.
4. Pause activity immediately if behavior is unpredictable.

## Card 1: Precision Parking Challenge

- `Grade Band`: 3-8
- `Time`: 15-20 min
- `Modes`: Manual driving only
- `Big Idea`: Control inputs affect precision and repeatability.
- `Materials`:
  - Tape start line
  - 3 parking boxes (tape squares)
- `Task`:
  1. Start at the same line each trial.
  2. Drive into each box and stop fully inside.
  3. Run 5 rounds and count successful parks.
- `Success Criteria`:
  - At least 3/5 successful parks.
- `Optional Dashboard Extension`:
  - Compare joystick vs keyboard success rates.

## Card 2: Slalom and Turning Radius

- `Grade Band`: 4-9
- `Time`: 20-25 min
- `Modes`: Manual driving only
- `Big Idea`: Turning constraints shape path planning.
- `Materials`:
  - 6 cones/cups
  - Tape measure
- `Task`:
  1. Build a slalom with equal cone spacing.
  2. Run the course 3 times without touching cones.
  3. Reduce spacing until failures increase.
- `Success Criteria`:
  - Team identifies minimum reliable cone spacing.
- `Optional Dashboard Extension`:
  - Log run times and compare with command interval settings.

## Card 3: Line-Follow Track Reliability

- `Grade Band`: 4-10
- `Time`: 20-30 min
- `Modes`: Line Follow
- `Big Idea`: Sensor-based autonomy depends on environment quality.
- `Materials`:
  - High-contrast track tape
  - Curves and one intersection
- `Task`:
  1. Test on straight, curve, and intersection segments.
  2. Record where line-follow succeeds or loses track.
  3. Improve the track (contrast, smooth curves, spacing) and retest.
- `Success Criteria`:
  - Reliability improves after track redesign.
- `Optional Dashboard Extension`:
  - Capture snapshots of successful and failing segments.

## Card 4: Obstacle Course Reaction Test

- `Grade Band`: 5-10
- `Time`: 20-30 min
- `Modes`: Obstacle
- `Big Idea`: Autonomous behavior has trigger limits.
- `Materials`:
  - Soft obstacles (foam blocks, empty boxes)
  - Floor distance markers
- `Task`:
  1. Place obstacles at different positions and spacing.
  2. Run obstacle mode 5 times.
  3. Record collisions, near misses, and successful avoids.
- `Success Criteria`:
  - Team reports obstacle layouts that are most/least reliable.
- `Optional Dashboard Extension`:
  - Use CSV telemetry to estimate response distance bands.

## Card 5: Follow-the-Leader Procedure Design

- `Grade Band`: 6-12
- `Time`: 20-30 min
- `Modes`: Follow
- `Big Idea`: Good procedures improve autonomous outcomes.
- `Materials`:
  - One target object or leader badge
  - Safe walking lane
- `Task`:
  1. Run three follow trials with different leader speeds/distances.
  2. Document what the leader should do for best tracking.
  3. Write a team "best practice" procedure (5 steps max).
- `Success Criteria`:
  - Team produces a repeatable follow procedure.
- `Optional Dashboard Extension`:
  - Pair procedure notes with distance telemetry observations.

## Card 6: Mission Relay (Capstone)

- `Grade Band`: 6-12
- `Time`: 30-40 min
- `Modes`: Manual + one auto mode
- `Big Idea`: Engineering teams combine control, autonomy, and iteration.
- `Materials`:
  - Course sections: start zone, slalom, line segment, obstacle zone, finish
- `Task`:
  1. Complete a mission with one required manual section and one required auto section.
  2. Run once, review failures, adjust strategy, run again.
  3. Present one design change that improved performance.
- `Success Criteria`:
  - Second run shows measurable improvement.
- `Optional Dashboard Extension`:
  - Include one chart/table from CSV export in the team report.

## Evidence and Assessment (Common)

- `Beginning`: task attempted, limited evidence.
- `Developing`: some repeat trials, partial explanation.
- `Proficient`: repeatable method, evidence-backed conclusion.
- `Advanced`: compares alternatives and explains tradeoffs clearly.

## Teacher Notes

- Keep team roles consistent per run: driver, safety lead, recorder, analyst.
- Rotate control platform across sessions so students experience both interfaces.
- Grade for method quality and reflection, not just fastest completion.
