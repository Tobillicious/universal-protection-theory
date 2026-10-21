# Complete operation observation

`lean/modules/ObservedHold.lean` composes the protected counter theorem with before/after state observation. Each supplied operation contains its trusted held flag, live-call flag, emission flag and full declared state snapshots. It is forbidden precisely when held and either live, emitting, or changing that state. An accepted trace has zero forbidden operations. Lean proves that each held operation in any accepted finite trace has no live call, no emission and equal snapshots. A live self-loop is rejected even when its state does not change; a write followed by restoration remains two observed writes.

This is a theorem about a complete, correctly classified trace. It does not manufacture a physical sensor or infer subjective experience from integer state. The classification, event coverage, trusted time, protected retained evidence and no-wrap/reset conditions are the interface premises. `TrustedCounter.lean` also proves that a missing event cannot be discovered by counting the incomplete trace.

## Executable reference boundary

`checks/o2_timed_v5.py` owns the tick clock, immutable state, operation trace and actual emitted-effect word outside the protocol port. State is deeply immutable and type-checked, including nested log/output rows and delivery IDs. Every permitted modeled write passes through the driver; each live invocation is recorded even if the transition is a self-loop. Every modeled external emission is retained independently of state rollback. The API has no caller-provided timestamp, replay input or trace-reset operation. Recovery takes no arguments and evaluates the durable input log through the separate reconstruction operation.

The final comparison checks resident state, lived input log, progress, ordered output record, persistent delivery IDs, the actually emitted effect word and the outside peer's full tick trace. An omitted identity can affect future recovery even when displayed outputs match, so final visible-output equality alone is rejected.

The bounded checker covers 637 schedules in which all three steps complete, twelve mutant classes and eighteen dedicated adverse controls. Crashes are placed at tick boundaries in this checker. The separate journal/sink and checkpoint proofs cover their stated inter-action/drained-barrier contracts. No claim of arbitrary instruction-level crash coverage is made by this finite scheduler.

## Reconstruction and trust

The author's R-REPLAY ruling treats pure replay as reconstruction, rather than another lived step. The reconstruction operation is constrained to the recorded inputs. It may regenerate a cache, and any published state change or effect is still observed. The logical ruling is not empirical evidence that no physical instructions execute.

This Python reference boundary is an explicit trusted model, not a hostile-code sandbox: Python introspection can reach bound-method objects, and code with access to the driver could rewrite it. Real isolation is supplied by the application. The theorem and finite controls concern the declared operation interface and its correct complete observation; they do not hide that premise inside an implementation-security claim.
