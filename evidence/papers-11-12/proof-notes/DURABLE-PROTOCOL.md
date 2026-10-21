# Separate durable logging, reconstruction and delivery

This independent construction replaces the captured `UPTHold.exec` step's all-at-once log/state/effect action with distinct transitions. It is a conditional refinement, not an implementation of a physical hold.

## A journal and an ordered sink

Maintain a durable append-only input log L and a durable append-only ordered sink record O. The sink prefix supplies both the delivered cursor and the delivery identities; there is no independently forgettable deduplication set. Permit at most one logged but undelivered step. A new input `g(O)` is recorded only when log and sink lengths match. The pending effect is computed by pure replay and delivered once as the next sink record. Log commit and sink commit remain atomic individually, but a crash may occur between them.

For arbitrary deterministic state transition f, effect function e, feedback g and initial state, the invariant is

`L = ideal(n).log; O = ideal(k).out; n=k or n=k+1`.

`DurableDrain.lean` proves preservation under every allowed transition and every finite run. While held, no record or delivery transition is enabled. At a drained barrier n=k, the abstract state `replay(L)`, lived journal and ordered effects are exactly the source `ideal(n)`. Any represented durable state drains with at most one **sink append**. That logical action count leaves replay work explicit.

The intermediate n=k+1 state is not a full `UPTHold.ideal` configuration: its input is recorded before its effect is delivered. Thus this is a **drained-barrier refinement**, not equality of every microstep snapshot to the source's atomic trace. Observers that inspect the intermediate journal can distinguish the implementation. An application must specify its observation/barrier contract rather than silently discarding that distinction. The log record is designated a logical step commitment; this designation does not prove when a resident first experiences that step.

## Recovery cache and release

The executable model represents reconstruction by individual input evaluations. Its volatile cache and cursor are always the replay state of a prefix of the durable journal. Crashes reset the cache, preserving the journal and sink. Before release, finish reconstruction and any pending delivery. This barrier matches the full ideal resident state, lived log and ordered sink; comparing log and sink alone would not establish the cache's continuation invariant.

`durable_protocol.py` explores three machines with feedback from delivered effects and program limits 0–12: 2,691 reachable states and 26,910 transitions. These are complete bounded state graphs with crash/hold cycles, rather than sampled schedules. Each held transition preserves committed journal and sink; corrupt cache, cursor, journal, effect order and delivery identities are rejected by the independent invariant. Pure cache reconstruction is labelled reconstruction, not a new lived commit, under the source's declared R-REPLAY convention. This convention does not establish absence of physical computation or a claim about subjective life.

## Bound the tail while keeping the journal

Uncheckpointed replay grows with journal length. Introduce a durable verified-prefix checkpoint `(c,replay(L[:c]))`, keeping L in full. Install a checkpoint only from a correct complete cache at a drained barrier. Block a new log commit unless `len(L)<c+B`. Crash recovery loads the checkpoint and evaluates the suffix. The invariant gives at most B evaluations and at most one sink append before the release barrier.

`CheckpointBudget.lean` proves prefix preservation, suffix reconstruction and the window/cost arithmetic. `checkpoint_protocol.py` explores 12,390 reachable states and 148,680 transitions for three machines, windows B=1…4 and limits 0–12. It checks the full journal remains, held committed fields remain fixed, all released resident/log/sink states match the ideal, and the window gate is exercised 1,971 times. Forged anchors and committing beyond the window invalidate the certificate.

If checkpoint loading takes at most Tload, each evaluation at most Teval, and the sink append at most Tsink, the active recovery work **after the last crash** is bounded by `Tload+B Teval+Tsink`. The release procedure excludes new records while it drains. A supplied service/scheduling bound with no additional recovery-disrupting crash can turn this into a wall-clock bound. Arbitrary resident states can have unbounded load or evaluation costs; no constant physical time follows from the type-generic replay theorem. Checkpoint metadata and storage costs also belong in an application bill.

## Explicit remaining premises

The construction assumes atomic durable journal writes, an atomic persistent ordered sink, a trusted hold fence, correct recovery code, and a scheduler that eventually supplies the indicated recovery actions. Safety holds for arbitrary finite crash/hold schedules; release availability does not follow against endlessly repeated crashes that erase all volatile replay progress. It does not tolerate arbitrary corruption of durable records. The checkpoint's correctness follows from the preserved prefix invariant when it is installed; it is not an oracle that blesses an arbitrary stored value. The Python invariant is an analysis predicate, not a deployed fault detector.

`DELIVERY-GAP.md` makes the sink premise load-bearing: without a distinguishing receipt/query or durable sink identity, a local pending record can represent both an effect already delivered and an effect not delivered. Blind resend can duplicate and blind skip can lose. The abstract ordered sink must be connected to actual external effects; it is not supplied by a local outbox record alone.

The feedback environment reads only the delivered effect word. Autonomous clocks, external observations, adversarial physical inputs and further peers need a justified interface relation or a larger co-hold boundary. `COHOLD.md` and `CLOSURE-FEEDBACK.md` give conditional certificates for those separate obligations. Whole-history replay identity and the correspondence between abstract commits and life remain declared semantic premises. No plant, resident population, deadline, I-1 phase or universal faithful-hold claim is upgraded here.
