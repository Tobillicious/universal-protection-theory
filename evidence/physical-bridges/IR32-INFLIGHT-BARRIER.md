# IR-32 — In-flight effects and the physical barrier

IR-31 correctly requires closed admissions and an empty actuator queue.
But a distributed physical pipeline may also contain accepted commands
between dispatch and arrival at that queue.

This module models a separate `inFlight` list and transport-arrival
transition as well as `pending` actuator work, `closed` admission,
`landed` physical effects, and the original UPTFence gate.

Lean proves a nonlanding invariant for **all modeled finite interleavings**
only after:
1. Admission is atomically closed.
2. Every already-sent/in-flight command has drained or been safely canceled.
3. Every actuator-pending effect has drained or been safely canceled.

It joins that invariant with the original UPTFence source theorem.
Counterexamples demonstrate why an apparently empty actuator queue is
insufficient when a delayed message can still arrive, and why empty
backlogs do not help if admission remains open.

**Physical obligations remain:** actual enumeration of every transport,
queue, effect pathway, device failover/retry and hidden message; barrier
acknowledgement freshness and ordering; epoch authentication; measured
delay bounds; and correct physical event semantics. This is a discrete,
closed, synthetic model and not evidence that a deployment meets the
three conditions.
