# Membrane-exactness toolkit — verified premises for M3 (3 November 2026)

Three **finite, GF(2)-exact** facts on PR #215's reconstructed complex, each
with a stated scope. This document proves **none** of the M3 lemmas (cube-layer
exactness for all ℓ, hull-decrease, the 3D Appendix-B analogue). It establishes
measured premises, demonstrates a homological fact, and corrects an enumeration
error. Tool: `tools/bdl_cube_layer.py` (stdlib only; CI-gated, fails closed).

Grading: the implementation's **cochain** grading throughout
(C⁰ →δ⁰ C¹ →δ¹ C²), per the membrane-exactness audit's defect #2.

## 1. Closed-membrane generators (ker ∂₂) — verified

`ker ∂₂ = {v ∈ C² : vᵀδ¹ = 0}` has **dim 3** at every scale/level measured
(ℓ=3,5,7 level 1; ℓ=3,5 level 2), with one logical qubit throughout — matching
the audit's rank table. The three level-1 generators are the z0 / z1 rail loops
and the q2 seam cap.

> **Correction:** a prior bank enumeration (`GENERATORS.md`) listed the rail
> loops at support 4 (rails q0,q2 at z0). Those exact sets are **not closed**
> (`vᵀδ¹ ≠ 0`): z0 is incident to q0, q2 **and q3**, so the verified loop has
> support 5 (rails q0,q2,q3 + the two z0 vertices); z1 likewise (q1,q2,q4); the
> q2 seam cap is support 10 (4 seam faces + 6 q2-edges). Basis is non-unique,
> but "the listed support-4 set is not a cycle" is basis-independent.

## 2. Cube-layer homology: the logical is invariant — demonstrated

A rank-3 cube layer `δ²: C²→C³` gives `δ²δ¹ = 0` and drives **H² : 3 → 0**
(every closed membrane becomes exact) while **H¹ = 1 is unchanged** at ℓ=3,5,7
(level 1) and ℓ=3,5 (level 2).

Because `δ²` never touches `δ⁰,δ¹`, `H¹ = ker δ¹/im δ⁰` (the one logical qubit)
is **mathematically invariant** under any cube layer. The three generators are
H² = coker δ¹ Z-stabiliser **redundancies**, not logical operators.
**Consequence:** fill all three; the boundary-annulus excision proposed in the
audit's defect #3 is unnecessary under cochain grading (its own defect #2).

> **Scope — important.** This `δ²` is the **kernel-transpose** (C³ = one cell
> per generator). It demonstrates the *homological* facts above and nothing
> more. It is **not** a local/geometric `δ²`. Whether the genuine 3D cells of
> the subdivided complex realise this with **bounded-support ∂₃** is the open
> M3 content (the 3D Appendix-B analogue) and is **not claimed here**.

## 3. Interaction graph Q_i — bounded-degree locality measured

On the Z-check interaction graph (`z ~ z'` iff they share a qubit):

| | level 1 (ℓ=3,5,7) | level 2 (ℓ=3,5) |
| --- | --- | --- |
| D_Z (max degree) | **10**, constant in ℓ | 8, constant in ℓ |
| D_X (max degree) | **5**, constant in ℓ | 16, constant in ℓ |
| check support / qubit degree | ≤ 4 / ≤ 4 | ≤ 5 / ≤ 4 |

- **Bounded-degree locality holds and is ℓ-independent** — the premise
  Theorem 4 + Appendix A (dimension-generic) require, now measured on the real
  complex.
- **D is per-level, not global** (≈10 → ≈16): the `D` in `A_ℓ = 240Dℓ²` is a
  per-level `D_i`; the hull analysis must carry it.
- **`dim C²(level 1) = 8L²+20L+10 ≈ 2ℓ²`** (exact through ℓ=11): the complex is
  **2D as built**, so the 3D structure (cover ~ ℓ³) is confirmed-absent — it is
  the open "3D transfer" work item, not already present.

## Open (named — not in this PR)

1. Geometric/local `∂₃` of bounded support (the cube layer proper) — needs the
   3D cell structure.
2. Coarse-shadow map R; hull function `l_i`; the **3D hull-decrease Lemma 13**.
3. Cover-constant `A_ℓ` scaling in the 3D-thickened construction (ℓ² → ℓ³).

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_cube_layer.py` — prints JSON to
stdout, asserts every invariant above, exits non-zero on any failure (verified
to fail closed on an injected under-filled cube layer).
