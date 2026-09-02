---
description: Build a study guide for a topic, or refresh an existing guide
argument-hint: <topic> | refresh <path>
---

Load the `study-guide-builder` skill and follow it.

Arguments: `$ARGUMENTS`

- If the arguments start with `refresh`, the rest is a path to an existing guide. Run Refresh mode on it. Do not start the intake.
- Otherwise the arguments are the topic. Start Step 0, round 1, at once. Do not ask what the topic is. If the arguments are empty, ask for the topic as the first question of round 1.
