# Code distance (Lemma-8 floor input) + R is a set-map — 3 November 2026

Two Lemma-13 inputs computable **without** the block-structure reconciliation
(#231). Tool: `tools/bdl_code_distance.py` (CI-gated, exhaustive low-weight
search). No Lean claim.

## 1. Code distance vs the Lemma-8 weight floor

Lemma 13 step 4 (per `WARMSTART-M3-LEXI-DEFINITION` §5) uses a weight floor
`2^{n-i+1} = 4` at level 2. The code distance verifies/exceeds it:

| ℓ | d_X (X-logical) | d_Z (Z-logical) | meets floor 4 |
| --- | --- | --- | --- |
| 3 | **≥ 5** | **= 4** (exact) | ✅ (tight on Z-side) |
| 5 | ≥ 4 | ≥ 4 | ✅ |
| 7 | ≥ 4 | ≥ 4 | ✅ |

`d ≥ w` is proved by clearing all weights `1..w-1` by exhaustive search
(`ker δ¹ \ im δ⁰` for X; `ker δ⁰ᵀ \ im δ¹ᵀ` for Z). At ℓ=3 a genuine weight-4
Z-logical exists, so `d_Z = 4` exactly — the floor is **tight** at the finest
scale, which is the non-vacuous case.

### Honest scope
This is the **logical (K₁, fully gauge-invariant) distance** — a clean,
fundamental code property. The lemma's floor is on `𝒲_i = K_i ∖ K₁`
(*partially* gauge-invariant chains), which needs the multi-level
`K_i = ⋂_{s≥i} ker ∂₁⁽ˢ⁾` structure. That entangles with the same multi-level
reconciliation as the blocks (#231), so the exact `𝒲_i` floor is **not** claimed
here. What is established: the code's logical distance meets/exceeds 4 at every
scale measured, and is tight (=4) on the Z-side at ℓ=3.

## 2. R is a set-map, not a GF(2) chain map (resolves #228's caveat)

#228 flagged that R is mixed-grade and asked whether a faithful chain-map
treatment must account for X/Z duality. Answer, computed: **no — R is not a
chain map on cycles at all.** The GF(2) pushforward `R_*` of **every** level-2
closed membrane is **0** (ℓ=3,5): each maps to an even cover of level-1 cells
that cancels. This is consistent with the source (`§3`: `R(X) = {R(e')}` acts on
**supports**, as a set-map) and with the hull function (which counts blocks
touched, set-theoretically). So: do not seek chain-map structure for R; it is a
support coarse-graining.

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_code_distance.py` — JSON with the
distance lower bounds and the R set-map check; asserts `d_X,d_Z ≥ 4` at ℓ=3,5,7
and `R_* = 0`; exits non-zero on any violation. (~16 s.)
