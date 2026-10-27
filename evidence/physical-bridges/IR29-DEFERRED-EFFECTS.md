# IR-29 — Deferred effect arrival versus controller log finality

The original Snuffy `UPTFence` source already proves an admission-only
LOG check is unsafe: a queued log write must be checked at application.
Here the seam is **different**: a write may already have passed the
fence, entered an external physical actuator queue, and only then
produce physical consequences after a later certified hold.

This Lean model tracks:
- the unchanged source `UPTFence.St` controller gate;
- a *separate external pending-effects list*;
- a separate physically-landed effect counter.

It proves by an explicit counterexample that a held, unchanged log can
coexist with a later positive physical effect from the old backlog.
The original source-level `raise_then_nothing_lands` is reused to show
that the log remains held under its precise premises, while an already
pending external effect may still be delivered.

The repair provides two conditional routes:
- a genuinely quiescent external queue before the hold; or
- an independently implemented physical cancellation of prior queued
  effects, proved safe for the chosen actuator.

**Neither physical route is established for a real instrument.**
Eventual drain/completion, signed acknowledgements, actuator atomicity,
latency, unrecoverable effects and physical rollback semantics remain
hardware/interface obligations. No version of this proof claims that
a software gate can suspend unrelated natural processes.
