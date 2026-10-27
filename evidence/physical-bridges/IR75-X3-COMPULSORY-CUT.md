# IR-75 — Original X3 compulsory-cut traffic: exact sufficient join and sharp countermodels

**Original archived source:** X3-DERIVATIONS.md §§5–6 and LATEST-SUBMISSION-REVIEW.md §1 in `Snuffy-X3-Korero-Preservation-2026-10-24.zip`. This does not rewrite the original maximal X3 claim.

## Mathematical bridge proved in Lean

Let area index be `radius^(dimension-1)`. Let target information be T, initial decoder side-information S, cross-cut new information Q, active edges m, maximum information per active edge during the certified window c, minimum paid power per active edge p, and actual power P.

Three independent premises yield the theorem:

- **A real recovery converse:** `S + q0*area ≤ T`, for every successful admitted decoder and all initial correlated side information.
- **Information accounting and cut capacity:** `T ≤ S + Q` and `Q ≤ m*c` (or `Q ≤ m*c*tau` if c is a per-tick ceiling and tau is the independently verified deadline).
- **Active-edge power floor:** `m*p ≤ P` for every admitted physical mechanism.

Then `(q0*area)*p ≤ P*c` exactly, without division or a tacit positive denominator. This gives area-scaling power ONLY IF a genuinely positive q0 and the others are physically derived uniformly. Quantifying the theorem over **all admitted protocols** is essential for bounding minimum successful recovery work rather than the cost of one selected algorithm.

## Real adversarial controls

1. Even an arbitrarily large *available* cut does not compel every edge to be active: one bit can cross one active edge at unit cost regardless of available cut size.
2. If a decoder's true initial correlated side information already contains the required historical information, no new cross-cut traffic need be paid. The original archive explicitly requires all retained records, bath modes, side information and shared entanglement to be inventoried.

The theorem does **not** derive area-scaling new information demand from cut size, a stationary H8 conserved-routing identity, a Lieb–Robinson bound or a general BCRD law. That recovery converse is the very step originally missing. Unit scales and quantum information factors (such as `2 ln(dim M)`) must be reconciled to any real channel.

**Status:** exact conditional mathematical implication plus countermodels, pinned Lean/axiom audit; universal physical compulsory area traffic remains OPEN.