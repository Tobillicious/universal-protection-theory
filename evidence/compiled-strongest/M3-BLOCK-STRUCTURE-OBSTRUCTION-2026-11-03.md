# M3 block-structure obstruction — l_i does not instantiate on PR #215's complex (3 November 2026)

Faithful attempt at `WARMSTART-M3-LEXI-DEFINITION` §7 step 1 (blocks
`E_i = bits / ∼₂` via degree-2 checks, `|e| ≤ 3`). Tool: `tools/bdl_blocks.py`
(CI-gated). This is a **reconciliation question**, not a computed hull.

## Finding

The paper's block quotient **does not instantiate** on PR #215's reconstructed
complex, under either candidate identification:

1. **Literal reading (bits = C¹, degree-2 checks via `d1`):** there are **no
   degree-2 checks at all.** C⁰-check degrees are 3–6; C²-check degrees are 3–5
   (both levels, ℓ=3,5). So `∼₂` is empty and every block is a singleton
   (`|e|=1`) — the quotient is trivial and `l_i` degenerates.
2. **Refinement (bits = Q-vertices, degree-2 checks = Q-edges):** blocks are the
   Q-rail connected components, sizes **4 (ℓ=3) → 6 (ℓ=5) → 8 (ℓ=7)** (plus a
   size-6→10→14 component) — they **grow with ℓ**, violating the paper's
   `|e| ≤ 3`.

Neither reproduces the paper's bounded `|e| ≤ 3` block-spins.

## Root cause

The paper's blocks come from degree-2 checks ("the Tanner-square q1/q2
structure"). In the seed, the qubit **q2 is shared** across all four Tanner
faces `(x0,q0,z0,q2),(x0,q1,z1,q2),(x1,q3,z0,q2),(x1,q4,z1,q2)`, so every
z-check is incident to **three** qubits (e.g. z0 → q0,q2,q3), i.e. degree 3, not
2. After subdivision the minimum check degree stays 3. There is no degree-2
structure to quotient by.

## What this means (honest)

- `l_i` (hull-size in blocks) **cannot be computed** on this complex until the
  block structure is reconciled. The hull-decrease work (§7 steps 3–4) is
  blocked on this, not on the hull algorithm.
- A **support-size stand-in is not a workaround** — it was already (correctly)
  refused, and the margins it produced (61–224) were the tell.

## Reconciliation question (for the lane holding the BDLT source)

Given the CSS complex has no degree-2 checks, what are `Λ_{B,(2i)}` and the
degree-2 checks **in terms of our cells**, under the Rep/Par ↔ X/Z remapping?
Candidates to confirm against the paper:
- Is `Λ_B` a specific **sub-space** of C¹ (e.g. only one of {xe, qv}) with a
  different check incidence that yields degree-2 and `|e| ≤ 3`?
- Does the block structure live in the paper's **graph-replacement** layer
  (Rep star `K_b` / Par piece `K^T_{b′}`) rather than the CSS chain complex's
  check degrees — i.e. does PR #215 need to expose that layer separately?
- Or is a **different seed** (without a shared qubit, so z-checks are degree-2)
  required for the finite instances to carry the paper's block structure?

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_blocks.py` — prints the
check-degree distributions and qv/qe block sizes; asserts the obstruction holds
reproducibly (fails if a degree-2 check appears or qv/qe blocks become `≤3`,
either of which would mean the structure — and this analysis — has changed).
