# IR-14 — Explicitly rank-certified termination of viability calculations

A descending fixed-point computation need not be declared to have
stabilised by fiat. If a **verified natural-valued rank** drops strictly
whenever the pruning operator changes its candidate, then the exact
fixed point is reached within at most the rank of the initial candidate.

The new Lean theorem uses strong induction and applies directly to
both IR-9's physical-state viability kernel and IR-13's
observation-history **belief-state** viability kernel.

**Remaining proof obligation:** provide a genuinely verified finite
rank for the selected real instrument/state representation, and prove
the strict-decrease property. Finiteness of the *physical state list*
alone does not establish that a particular implementation's beliefs,
timestamps, memory or actions are finite. This theorem makes the
termination condition finite and checkable once such a rank exists;
it does not supply it automatically.

Nonempty kernels, correct physical calibration, continuous-time
behavior and subjective identity remain independent.
