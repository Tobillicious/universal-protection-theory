# IR-46 — Clocked service with an explicitly bounded stall budget

This source-level theorem composes two independently checked components:

- **IR-44:** service can be reached in a finite number of COMPLETED
  controlled events when productive events strictly lower a rank,
  nonproductive events do not raise it, and actual stalls are bounded.
- **IR-41:** the elapsed duration of those real physical events has
  an upper bound only when the actual event completion clock is
  authentic and every relevant inter-event delay is bounded.

For a genuinely completed trace of exactly `rank(start) + maxStalls`
events, with no more than `maxStalls` real stalls, the composed
result proves safety, service, and the deadline:

`time(trace.length) <= time(0) + (rank(start)+maxStalls)*maxDelay`.

This is a **conditional implication**, not an assertion that the
events execute at all. The theorem also works for longer completed
traces, but then the elapsed-time upper bound uses the actual longer
length; it does not silently promise the shorter deadline.

The negative result explicitly reuses the original IR-41 late-clock
counterexample: bounded event count is compatible with arbitrarily
late service when no maximum real inter-event time is established.

### Open physical obligations

Complete effect/event coverage, an actual maximal-stall measurement
(including faults and failover), a valid productive-event classifier,
authenticated event timestamps, maximum step latency and guaranteed
progress/completion. The original full UPT feasible ordering and X3
are unchanged. No physical system or universal outcome is certified.
