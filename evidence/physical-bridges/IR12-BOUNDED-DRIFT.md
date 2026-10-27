# IR-12 — Held-window bounded drift, rather than physical stasis

An idealized physical system has two separately evolving channels: the
gated effect register from IR-11 and an external physical process.

Lean checks that interleaved external drift does not affect the gated
channel's original target projection. The external process accumulates
exactly the modeled drift charges. Composed with the *unchanged*
`UPTControllerFence.certified_hold_nothing_lands`, any certified
held window has zero gated effect and a **total physical increase**
bounded by the external budget.

**Necessity control:** an external-drift event changes physical state
without writing to the controller target log. Consequently a verified
fence cannot imply that all physical dynamics stop.

The theorem does not derive a finite drift budget for hardware,
accommodate decreases or other directions of risk, model subjective
continuation, measure the relevant physical process or certify complete
channel coverage. It is a conditional physical-interface result.
