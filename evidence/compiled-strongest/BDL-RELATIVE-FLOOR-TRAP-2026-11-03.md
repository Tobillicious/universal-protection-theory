# BDL M3: relative-quotient singleton obstruction, both support hypotheses retained

Date: 3 November 2026. Source-level conditional Lean theorem and exact finite source tests. Parent: draft PR #239; other-model work #236 and #238. No all-scale 3D M3 or physical X3 claim.

## Exact algebraic theorem, not a numerical extrapolation

Let C2 and C1 be additive chain/check groups, boundary d:C2→C1 additive, and q:C1→D ANY additive map, including non-coordinate projections. Let u be the H4 short rail and e a distinct one-cell chain such that d(u+e)=0 (the repaired H5 rail is absolutely closed), while q(d(u))=0 (the H4 rail is relatively closed).

Then 0=q(d(u+e))=q(d(u))+q(d(e))=q(d(e)). The omitted e is also a relative cycle, with weight one. Therefore it is impossible for the whole nonzero relative kernel of q∘d to have minimum weight at least four. This is independent of the particular relative quotient and independent of subdivision size, once its source cell identities satisfy those antecedents.

The pinned Lean 4 module BDLRelativeFloorTrap.lean proves omitted_cell_is_relative_cycle and no_full_relative_kernel_floor_four (with explicit additivity, zero preservation and omitted-cell nonzero/weight-one premises). It does not derive genuine 3D geometry from these algebraic premises.

## Actual source-cell verification: smallest admissible coordinate interface

The accompanying bdl_relative_floor_trap.py uses PR #215 first-replacement source incidence and PR #239's explicit H4/H5 short/full rail cells, independently recalculating parity defects and the rank of the projected original d1 boundary at ell=3,5,7.

The smallest necessary coordinate interface B_min is the UNION of the three reconstructed H4 defect supports in C1. Any coordinate-deletion quotient making all three H4 generators relatively closed must delete at least these incidence equations.

| ell | original C1 checks | minimal interface checks excluded | retained checks | original absolute kernel dimension | minimal-interface relative kernel dimension | explicit weight-one singleton cycles |
|---:|---:|---:|---:|---:|---:|---:|
| 3 | 60 | 18 | 42 | 3 | 8 | 2 |
| 5 | 140 | 26 | 114 | 3 | 8 | 2 |
| 7 | 252 | 34 | 218 | 3 | 8 | 2 |

Thus even this most conservative coordinate deletion still introduces two independent weight-one cycle witnesses. The broader native Q-restriction interface in #239 instead produced relative kernel dimension 14 and ten weight-one cycles. The abstract Lean result is stronger: any additive projection of the SAME incidence operator that closes these short rails necessarily closes their omitted singleton cells.

Source CI: https://github.com/Tobillicious/universal-protection-theory/actions/runs/41558396324 . This exact runnable test also reruns the independent two-hypothesis source checker from #239.

## Keep both mathematical programmes, correctly separated

Track A: original complete C2 boundary and verified H5 supports (5,5,10 at ell3; 5,5,18 at ell5; 5,5,26 at ell7). Pursue all-scale R noninjectivity for actual closed membranes, geometric C3/locality and remaining R-injective hull/J3 constraints. Claude's draft #238 is progress for a finite easy case but not closure.

Track B: old reconstructed H4 supports (4,4,6 at ell3), preserved as a competing hypothesis of DIFFERENT source geometry/chain degree/boundary or a restricted multi-level partially invariant W_i gauge sector. The original GLM generator bank file has not been retrieved, so we cannot equate H4 to its actual cell bytes. A lawful alternative must separately provide its source d', admissible boundary conditions, all chain levels and mapping to the original physical/code target.

A major **scope distinction**: the strict Lemma-8 floor is about W_i = K_i \ K1, not every relative cycle. The weight-one witness obstructs the *full relative kernel* floor of 4 but does not prove that e belongs to W_i. Neither W_i membership nor its lower bound is established here. It is mathematically incorrect to use a full-kernel minimum or a closed-membrane basis weight as a substitute for the missing W_i theorem.

A new 3D construction with different d could legitimately exhibit weight-four cycles and avoid this no-go. It would need to be written and tested, rather than assumed or dismissed. The exact R-injective hull junction J3, physical source correspondence, and original X3 all remain separate OPEN joins.

No weakening of original X3, canonical manuscript edits, publication, founding, merge or commissioning.
