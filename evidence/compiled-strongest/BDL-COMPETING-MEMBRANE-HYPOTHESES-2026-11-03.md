# BDL M3 disputed generator supports — TWO hypotheses, same source, exact boundary tests

Date: 3 November 2026
Status: **finite exact source reconstruction and counterchecks, no all-scale 3D Lemma-13 closure**.
Depends on draft BDL PRs #215, #226, #228, #232, #234, #236. No X3 or canonical manuscript changes.

## 0. Interpret the numbers before comparing them

- **4,4,6** was the old generator-bank *support-size* hypothesis at subdivision ell=3, cited in the original reconciliation. The bank's original full vector listing is NOT currently present in this repository; H4 below is an explicitly labelled **reconstruction from its written rail/seam description**, not a claim to have recovered the original bytes.
- **5,5,10** are the verified *absolute closed-membrane basis support sizes* for this particular PR #215 level-1 cochain complex at ell=3.
- **3,5,7** are the tested subdivision sizes **ell = 2L+1**, not a third generator-weight sequence.
- At ell=5 and 7, the source-valid absolute basis grows to **5,5,18** and **5,5,26**; the modelled old short-seam family grows to **4,4,10** and **4,4,14**.

This PR does NOT assume that "a 4-support chain is universally impossible." It tests whether the named short-support rows are absolute cycles of the *specified* source boundary, and explores one genuinely different (relative/interface) reading of them.

## 1. Hypothesis A — original full-source absolute closed membranes

The source model is the PR #215 actual Tanner seed and the explicit R_X replacement. Every candidate is enumerated as real C2 cells. The exact absolute boundary ∂₂ is computed **directly and independently from every C1→C2 incidence of the source complex**:

    ∂₂(v)[q] = XOR_{z∈support(v)} [z∈δ¹(q)].

A closed membrane is one with **zero defect at EVERY C1 cell**. This is basis-independent.

Explicit H4 reconstructed candidate at ell=3:
- Short z0 rail: old zv(z0,t=0,1) and q0/q2 vertical q-edges, weight 4.
- Short z1 rail: old zv(z1,t=0,1) and q1/q2 vertical q-edges, weight 4.
- Short q2 cap: four original q2 seam faces and only two q2 vertical q-edges, weight 6.

H5:
- Full z0 rail: add the omitted q3 vertical q-edge (weight 5).
- Full z1 rail: add the omitted q4 vertical q-edge (weight 5).
- Full q2 cap: add every remaining q2 rail q-edge along the subdivided source seam (weight 10 at ell=3).

**Exact observed boundary defects** in H4 versus H5, and source-independent kernel crosscheck:

| ell | H4 support weights | H4 defect counts | H5 support weights | H5 defect counts | Absolute ker ∂₂ dimension | Minimum weight of any nonzero absolute cycle |
|---:|---:|---:|---:|---:|---:|---:|
| 3 | 4,4,6 | 3,3,12 | 5,5,10 | 0,0,0 | 3 | 5 |
| 5 | 4,4,10 | 3,3,20 | 5,5,18 | 0,0,0 | 3 | 5 |
| 7 | 4,4,14 | 3,3,28 | 5,5,26 | 0,0,0 | 3 | 5 |

The short rail defects are not just the omitted q3/q4 qv endpoints: each also leaves a genuine **xe source restriction edge** unmatched. The short seam cap leaves C1 qv and xe defects. Removing only endpoint Q-vertices does NOT make these candidates relative cycles.

The script obtains complete kernel dimension **independently** by a fresh GF(2) row-rank on every original C1 check; it verifies that the three explicitly listed H5 cycles are independent and hence span the complete 3-dimensional kernel. It also enumerates ALL seven nonzero vectors of the independently generated full kernel and compares their weights. For ell=3 those are **[5,5,10,10,13,13,16]**; for ell=5 **[5,5,10,18,21,21,24]**. No absolute weight-4 cycle exists in this declared complex.

**Disposition A:** In the specific absolute C2/∂₂ sector used by #215/#226, reconstructed H4 is not closed and H5 is exact. This is stronger than a preference about which basis to print, but narrower than ruling out another sector or geometry.

## 2. Hypothesis B — a relative/interface-cycle interpretation

An alternative source hypothesis can explicitly choose a subspace B⊆C1 of *interface cells* and ask for ∂₂(v)∈B, equivalently zero parity after projection C1→C1/B. That is a **different boundary problem**. Unlike a posteriori choosing exactly the defect cells, our experimental interface B is specified **in advance from source construction**:

- All Q-vertex cells at old Z endpoint copies;
- All X-edge cells lying in the native Q restriction subcells (the actual Y_q edges in the X replacement).

This source-labelled interface is mathematically unambiguous, and is **not asserted to be a physically valid relative boundary, a boundary condition in the published 3D model or a valid replacement for the original absolute code**. A full relative chain complex would also have to specify/verify its other boundary spaces and their source semantics.

**Both candidate families are closed MODULO this B**, but the cost is substantial:

| ell | Source C1 checks | Interface checks removed from ∂₂ test | Checks retained | Absolute kernel dimension | Hypothetical projected/relative kernel dimension |
|---:|---:|---:|---:|---:|---:|
| 3 | 60 | 32 | 28 | 3 | 14 |
| 5 | 140 | 48 | 92 | 3 | 14 |
| 7 | 252 | 64 | 188 | 3 | 14 |

By design B is tied to the source Y_q restrictions **before** inspecting either candidate's defects. Both H4 and H5 close modulo that interface. That establishes **an algebraically consistent route on a different, explicitly weakened incidence system**; it does not imply either is a lawful membrane generator of the original unchanged code.

The larger kernel (14 rather than 3) means the H4 vectors are now only a small part of a much larger relative solution space. The minimum nonzero weight and relevant partially-invariant chain sector under that alternative must be independently established. One cannot transplant the old H4 weight 4 into the Lemma-8 floor without proving that the correct W_i=K_i\K1 sector has that floor.

## 3. Junction bound is a SEPARATE unresolved problem

PR #236 finds actual source degrees for the existing level-1/level-2 complexes:

| Candidate J3 interpretation | Level 1 | Level 2 | Consequence if using absolute floor 5 |
|---|---:|---:|---|
| Bit-to-region fan-out | 4 | 4 | +1 margin, conditional on identifying the right hull junction |
| C2 check degree | 4 | 5 | +1, then 0 margin |
| C0 check degree | 5 | 6 | 0, then -1 margin |

**None of these degree measurements proves which is the genuine R-injective hull confinement constant**. Moreover the strict 2D Lemma-8 lower bound is on the partially invariant 1-chain sector W_i, NOT on the absolute closed-membrane kernel whose minimum here is 5. The latter is a distinct tested quantity; this source of possible floor conflation is still OPEN.

The new PR #238 reports finite progress on the R-noninjective easy case of hull decrease, without claiming the difficult R-injective case or resolving J3; it is complementary and does not settle the support dispute.

## 4. Reproduce, counterexamples, next independent decisions

    python3 evidence/compiled-strongest/tools/bdl_competing_membrane_supports.py

CI archives FULL EXACT vector-cell supports and defect-cell names for both families, not just numerical counts. The same workflow reruns Claude's own independent bdl_weight_floor.py and bdl_junction_margin.py. It fails if either candidate's source relation, kernel dimension, weight/defect structure or prior independent measurements change.

**Next decisions before promoting either alternative**:
1. Recover the precise original GLM generator bank vector list (not currently in this repo). Check its actual C2 cell names verbatim, then distinguish it from our reconstructed H4 short-rail/short-cap hypothesis.
2. If the 4-support route is intended as a *relative* source cycle, identify the **actual source-prescribed boundary/interface B** from the 3D physical construction and show the original X3 target and logical K_i sectors survive that quotient. Our B is only an exploration.
3. Prove the correct partially invariant W_i floor AND the precise R-injective hull constant J3 for the genuinely 3D source at all hierarchy levels. A possible 4 floor with a J3 of 4 would NOT close the required strict inequality.
4. Resolve the missing local 3D C3 structure: the algebraic cube layer from #226 does not supply the geometric/physical cell complex.

This is a fair, falsifiable comparison of **two hypotheses**, not a vote for a particular model. No universal physical UPT, original-X3 closure, fixed-temperature efficient sampler or all-scale BDL source verification is asserted.
