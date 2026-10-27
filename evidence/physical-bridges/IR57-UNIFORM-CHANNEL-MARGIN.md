# IR-57 — Uniform physical margin across unrestricted instruments

**Source lead:** *A Lattice Preservation Calculus*, Zenodo
10.5281/zenodo.23599528. The earlier source-level audit associated
with that archived work proposed UC-1: bounded consequential channel
degree and uniformly bounded impact imply a population-independent
local effect margin. This does NOT follow merely from each individual
coupling being finite.

This source-level Lean module imports the unchanged IR-2 aggregation
and IR-53/54 sample-age / apply-time guard sources. It proves:

1. Every finite list with per-channel cap W has total effect at most
   length*W.
2. A uniform maximum degree D implies a common **per-agent** effect
   budget D*W, no matter how large the Agent type is.
3. On every agent, a complete trusted physical channel inventory,
   actual bounded sample-to-effect rise, sensor error and check-at-
   application gate imply that the actual post-effect physical
   quantity respects that agent's safety threshold.

The theorem is uniform over any Agent type: it does not require a
finite population, and it does NOT impose a total systemwide sum bound.
Such a total would require an additional physical resource / volume /
sparsity argument.

Negative controls: degree 1 with unbounded single-channel weight
breaks any proposed uniform cap; channel weight ≤1 without a
degree cap also admits arbitrarily large aggregate effects.

**OPEN:** whether a real physical plant has complete known channels,
uniform maximum consequential degree, calibrated maximum weight,
trusted fresh sensors and final physical effect checks. The proof is
an implication, not empirical evidence or an actual instrument.

This does not verify the archived record's `zero_breach_bound` as
an unconditional impossibility statement, nor complete the separate
escrow/liquidation trigger or X3 joint-realisation joins.
