# IR-31 — Atomic admission close + physical drain

Previous IR-30 established that a *fresh* quiescence acknowledgement is
sound within a model that forbids subsequent dispatch. The new IR-31
model makes that exclusion **part of its explicit executable transition
rules**, instead of leaving "no new dispatch" as an informal guarantee.

The modeled actuator state has independent `closed`, `pending`, and
`landed` fields as well as the unchanged original UPTFence gate.
Its dispatch transition rejects all commands while `closed`.
Its delivery transition can land already pending effects.

Lean proves that the conjunction (admission gate closed AND all
already accepted physical effects drained) is inductively invariant
under arbitrary finite interleavings of further close, dispatch and
delivery commands. It then composes this invariant with the *actual
UPTFence.raise_then_nothing_lands* source theorem.

Hostile witnesses prove **both** conditions are essential:
- A presently empty queue with admissions open can accept and deliver
  a physical effect moments later.
- A closed admission gate with outstanding pending effects can still
  deliver those effects after the hold.

There is no model of malformed commands, unauthorized physical bypass,
disconnected actuators, atomic write/ack handshakes, hardware races,
faulty queue enumeration or clock/channel semantics. A real instrument
must establish that the `closed` state is authoritative, atomic at the
physical effect boundary and covers *all* effect-producing dispatchers.

This is a synthetic source-level correctness proof, not evidence that
a physically implemented actuator has achieved finality.
