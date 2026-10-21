# Full canonical dominance: exact boundary

This note originated in the independent continuation after the round-4 read. The full-order premise was subsequently adopted in Claude's v1.5 and is retained in this separate repair candidate; no value ruling is re-decided.

Let `a(ω)` and `h(ω)` be outcomes, and let `≤L` be the non-strict four-stage inclusion-lexicographic preorder. Equality here includes equal stage keys even when the outcome representation has other fields. `CanonicalDominance.lean` defines this preorder, proves reflexivity/transitivity and proves that it is stage-key equality or the source's strict `LexBetter`.

For **all upward events**, the following conditions are equivalent:

1. For every upward U and state ω, a(ω)∈U implies h(ω)∈U.
2. For every ω, a(ω)≤L h(ω).

The forward implication takes the principal upset of a(ω): U={z:a(ω)≤L z}. Reflexivity puts a(ω) in U, and event preservation puts h(ω) there. The reverse implication is the definition of upward closure. This equivalence is checked in Lean without axioms.

Thus a full statewise canonical improvement is sufficient for stochastic dominance under every probability for which these events are measurable. Conversely, when principal upsets and Dirac state laws are available—as in the finite model—dominance under **every** state law forces that statewise comparison. This does not assert an equivalence for a restricted event sigma-algebra that fails to separate the relevant outcomes.

For one **fixed** probability, statewise improvement is sufficient, but need not be necessary. Swapping two equally weighted states leaves the outcome distribution identical even when the paired states are not ordered. The independent finite scan finds 626 two-world action pairs with half/half stochastic dominance and without statewise comparison. No physical necessity is inferred from the universal-law criterion.

## The round-4 counterexample is an open parameter family

Use states false, real-1, real-2 with probabilities q,r,s, where q+r+s=1 and r,s>0. Set

- H=(2,2) on false and (2,1) on both real states;
- A=(2,2) on false and real-1 and (2,0) on real-2.

H is nonlethal in every state and satisfies the proposed alive-top/false-release definition. The upward both-free event has probabilities q and q+r; the upward both-alive event has probabilities 1 and 1−s. Neither action dominates the other. This holds throughout the indicated parameter triangle, rather than only at one numerical point. Adding the original standby and strike does not remove A's undominated status.

Two worlds suffice if A may be lethal on the false-alarm branch: H(false)=(2,2), H(real)=(2,1), A(false)=(2,0), A(real)=(2,2), with positive mass on both branches and more real mass. The three-world example has the additional desirable property that A also preserves full freedom on false alarms. A one-world example with a nonlethal H and lethal A cannot produce this trade: strict alive-set improvement decides the comparison immediately.

## Strictness

Under pointwise full-order improvement, if a positive-probability branch strictly improves, the principal upset of its improved outcome gives a positive event gap in a finite outcome model. Branches with zero probability cannot establish strict stochastic dominance. The original three-action E7 strictness condition p>0 remains correct.

`mass_mono` checks the finite weighted upward-event implication using natural atomic weights. Normalising a common positive total gives the corresponding rational probability inequality. The general probability interpretation and the strict-event argument are analytical here; the file does not pretend to contain a measure library.

## Evidence

`checks/dominance.py` checks 81 outcome comparisons, all 6,561 two-world action pairs, 680 interior three-world counterexamples and the fixed-law distinction. `lean/modules/CanonicalDominance.lean` supplies the general logical preorder/event lemmas. A sufficient candidate replacement for the generalized E7 premise is improvement of the full canonical outcome in every state. The active preprint retains the adopted full-order premise and keeps the feasible-repair alternative conditional.
