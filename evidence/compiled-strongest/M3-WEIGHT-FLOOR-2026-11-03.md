# M3 weight floor — closed-membrane minimum weight = 5 (corrects 4,4,6 → 5,5,10)

Delivers Lemma-13 input #3 (the weight floor) on the corrected route of
`WARMSTART-M3-BLOCK-RECONCILIATION-2026-11-03.md`, and **corrects a propagated
numeric error** in that doc's testable hypothesis. Tool: `tools/bdl_weight_floor.py`
(CI-gated, exact). No Lean claim.

## The correction

The reconciliation doc's hypothesis reads: *"closed-membrane kernel generators
with supports 4, 4, 6 — consistent with a 3D weight floor of 4."* Those are
GLM's `GENERATORS.md` numbers, which **PR #231/#226 already proved are not closed
membranes** (the support-4 sets have odd boundary overlap). The corrected,
verified quantity:

| ℓ | ker ∂₂ dim | basis supports | min nonzero closed-membrane weight |
| --- | --- | --- | --- |
| 3 | 3 | **5, 5, 10** | **5** |
| 5 | 3 | 5, 5, 18 | **5** |
| 7 | 3 | 5, 5, 26 | **5** |

Computed exactly as the minimum Hamming weight over all `2³−1` nonzero
combinations of a verified `ker ∂₂` basis. The two rail-loop generators stay
weight 5; the seam cap grows (10→18→26); the **minimum is 5 and constant**.

## Why this strengthens, not weakens, the route

Lemma 13's contradiction (reconciliation §"corrected route" step 3) wants
`weight floor > J₃`. With the corrected floor **5** (not 4) and the 2D junction
constant `J₃ = 3`, the margin is **5 > 3**, larger than the `4 > 3` the doc
assumed. The constant-in-ℓ behaviour is exactly what the lemma needs (the floor
must not degrade with scale). So the propagated error was pessimistic; the real
numbers help.

## Scope (honest)

This is the `ker ∂₂` (closed-membrane / Z-metacheck) minimum weight — the
quantity the reconciliation's **hypothesis** uses. The strict Lemma-8 floor is
on the `𝒲_i = K_i∖K₁` 1-chain sector; `bdl_code_distance.py` gives the related
1-chain number `d_Z = 4` (exact at ℓ=3). The precise `𝒲_i` floor still needs the
multi-level `K_i` structure. What is corrected and established here: the
closed-membrane floor is **5**, constant, not 4/`{4,4,6}`.

## Next on the corrected route (not in this PR)
- **J₃**: the 3D junction constant — operationally needs the `R`-injective hull,
  so it follows the native `l_i^{3D}` build.
- **`l_i^{3D}`**: smallest connected hull in the 3D generator-interaction graph
  (with Definition-2 overlap enrichment), then shadow-monotonicity + strict-
  decrease on the three generators. *The centerpiece; next.*

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_weight_floor.py` — JSON with
supports and the floor; asserts floor ≥ 4, constant, and rail-loop supports
`[5,5]` (fails if the 4,4,6 error regresses).
