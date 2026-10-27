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
