# IR-28 — Quorum-certified record no-fork joins history provenance

The original `ControllerFinality.lean` already proves that two
authenticated quorum certificates at one log position cannot assign
different event histories, given n = 3f+1, fault <= f, both 2f+1
quorums, honest durable-prefix semantics and a shared roster.

Rather than duplicating that result, this module imports it directly
and composes it with IR-26's new append-only origin-labeled records:

- same-position certified event histories agree;
- with the same record origin, the *entire records* agree;
- if each physical history was faithfully encoded in its record,
  the two physical origins and their encoded event streams agree.

The negative control shows that a noninjective physical event encoder
can map two genuinely different physical histories to the same
record stream. An additional injectivity/detection certificate would
be necessary before concluding exact physical event equality.

**Crucially unproved:** actual cryptographic signature and wire-codec
correctness, PBFT replica deployment, trusted roster, fault bound,
physical effect-channel completeness, independent audit and subjective
identity semantics. Neither this lemma nor `#print axioms` discharges
those explicit theorem hypotheses. No X3 changes.

## Additional exact-event correspondence gate

A correct observer-based event identity detector (in the precise sense of the
original `CodexObservation.identity_detector_implies_injective` theorem)
forces the event encoding to be injective. A new source-level lemma lifts
equality of encoded event lists to equality of *modeled* physical-event
lists. Combined with certified record equality and IR-26's `Faithful`
relation, this proves equality of the entire modeled physical history
(origin and event sequence). Without the detector's correctness, the
negative lossy-encoder counterexample still applies.

These extra hypotheses are not experimentally verified for real
instruments and do not imply subjective personal continuity.
