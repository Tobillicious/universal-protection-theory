# Observation and release: what a snapshot may safely forget

The round-4 faults are instances of two different mathematical issues: information lost by a state projection, and information lost by sampling only at endpoints. `ContextualObservation.lean` separates them.

Let a deterministic implementation have states S, action alphabet A and transition `step:S×A→S`. Let `obs:S→O` be the state exposed to a release check.

**Continuation criterion.** Equal observations imply equal observations after every finite future action word if and only if equal observations are preserved by each single action. The forward direction chooses a one-action word; the reverse direction is induction on the word. The equivalence is proved in Lean without axioms.

This is a precise way to justify hiding a cache or implementation field. A reachable-state invariant can weaken the obligation: prove the invariant is preserved and the one-action congruence holds for states satisfying it. The file proves that version too.

An irrelevant cache flag can be omitted because the future logical transition ignores it. Durable deduplication IDs cannot be omitted in the source crash model: two states with the same displayed outputs and different IDs emit different outputs on the next recovery. The file gives a concrete such counterexample. The conclusion is not that every bit of hardware must be exposed; it is that the chosen abstraction needs a continuation proof.

**Identity monitoring.** A monitor that sees only pairs of projected states and is sound and complete for full state identity forces the projection to be injective. This follows from comparing any two states with the same observation against the monitor's unchanged-state verdict. That theorem is checked in Lean. Full physical identity is stronger than contextual equivalence, so it should not be imposed without saying which property is intended.

**Sampling.** Even the identity projection at tick boundaries misses a nontrivial internal cycle s→t→s. The net endpoint is unchanged while work occurred. An immutable per-transition trace can detect it at the chosen granularity; a monotone append-only history can also exclude certain rollback cycles. Neither follows merely from calling a tick-end tuple a snapshot. The trusted event source, its coverage and the atomicity granularity are part of the monitor contract.

For a hold, separate at least these questions:

1. Did any new lived commit or external effect occur while held?
2. Did the committed lived log and ordered effect history survive release?
3. Is the released durable state related to the undisturbed state by a continuation-safe relation?
4. Does the claimed physical execution granularity correspond to those abstract events?

The previous finite checker repairs question 2 for its displayed fields. The forgotten-ID witness violates question 3; the transient-cycle witness addresses the scope of question 1. A logical reconstruction convention can permit cache work without a new lived commit, but that is a declared abstraction, not evidence of absent physical execution.

The candidate durable-log construction developed alongside this note uses a one-pending-step invariant and a monotone sink cursor. Its guarantees remain conditional on durable storage, trusted fencing and atomic sink commitment; no physical or subjective-life conclusion is inferred.
