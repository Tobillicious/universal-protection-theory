# IR-17: selected-level improvement exclusion replaces strong global cofinality

PR #7 and #10 use a **cofinality** premise requiring every full-feasible
candidate omitted by the safety menu to be strictly dominated by a member
of the safe menu. That condition is sufficient but often unnecessarily
strong (e.g., two incompatible but incomparable preservation maxima).

Here the verified replacement for a **given selected safe-menu maximum** is:

- chosen is maximal in the safety menu;
- chosen is feasible in the original full family; and
- **there is no strictly better originally feasible option outside
  the safe menu**.

Then chosen is maximal under the ORIGINAL unmodified UPT stagewise
order, even if the safe menu is not cofinal.

The source-level Lean proof imports IR-7 and `UPTExistence`, with no
definition changes. It also proves original cofinality implies the weaker
selected-level condition, but not conversely. An explicit finite
two-incomparable-maxima countermodel establishes non-necessity.

A second independent repair makes clear that only the ACTUALLY selected
outcome requires a supplied realising policy for the conclusion—rather
than asserting every conceivable eligible menu outcome is implemented.

**Remaining obligation**: derive the no-excluded-improver property from
original physical feasibility without narrowing the original feasible
set, and exhibit a real observation-uniform selected policy. This PR
does not infer those from mathematical maximality.
