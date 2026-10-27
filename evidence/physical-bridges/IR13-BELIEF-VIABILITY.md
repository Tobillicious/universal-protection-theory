# IR-13 — The partial-observation viability kernel belongs to beliefs, not just states

IR-6 demonstrates that viable individual physical states may require
incompatible actions when their observations coincide. IR-9's greatest
full-state viability kernel consequently cannot automatically be
implemented by a partially informed guardian.

The repaired construction uses **belief states** (sets of currently
possible physical states). After a selected action, each actual observed
output induces a distinct updated belief. The pruning operator retains
a belief only if there exists ONE action whose every *physically possible*
next-observation belief remains in the prior candidate family.

Lean proves monotonicity, a greatest invariant belief family at a
**certified fixed point**, construction of a policy depending on the
current belief, membership of the actual next physical state in the
updated belief, and one-step physical safety provided every accepted
belief consists of safe states.

**Unproved:** actual observation-model soundness, physical
transition completeness, correct initial beliefs, arrival of
observations, real-time computational feasibility, finite-state
termination, nonempty kernel and existence of safe policies for a
particular instrument. A controller's belief may depend on all its
prior observations; this is not simply an instantaneous sensor law.

No published sources or X3 priorities have been changed.
