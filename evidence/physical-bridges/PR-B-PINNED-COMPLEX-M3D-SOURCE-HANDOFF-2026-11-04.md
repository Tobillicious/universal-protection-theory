# PR B source reconnaissance — full complex M3d update and exact next correspondence

**Date:** 4 November 2026 · **status:** PINNED SOURCE RECON / REVIEW HANDOFF, NOT a new proved full-physics theorem.  
**Repository edited:** Universal Protection Theory, PR B #285 only.  
**External research source:** `Tobillicious/physics-lane` @ `2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35` (READ ONLY).

## Exact source path and what it says

Pinned source file:

`orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/tests/verify_bcrd_m3d_state_determined_accessibility.py`

The original test is an **author theory-incubator finite control**, explicitly *not* an exhaustive CPTP reconstruction, complete BCRD theorem, geometry or GR. It uses `complex` matrix entries, an `apply_unitary_to_rho(u,rho) := u rho u†` function, and the six-dimensional tensor basis

`|L0>, |L1>, |M0>, |M1>, |R0>, |R1>`.

The endogenous relation-update control constructs:

```python
p_not_m = sub(I3, Q_M)
w_update = add(kron(p_not_m, I2), kron(Q_M, X2))
```

with `X2 = [[0,1],[1,0]]`, `Q_M = |M><M|`, `I3` matter identity and `I2` relation identity.

This is the exact source equation for the permutation matrix `W` in UPT `FrozenBCRDEvents.wUpdate`. In the pinned basis it fixes L0,L1,R0,R1 and swaps M0,M1. Its coefficients are real integers, but it acts on a **complex Hilbert space**.

**Important:** The Python test also defines a separate controlled partial-swap `C_LM`, `U_MR_6` and `U_FIXED = C_LM · U_MR_6 · C_LM`. A later interaction may change accessibility after the endogenous update. Consequently, **proving the whole complex-space action of `W` is not a source-complete theorem for all of `U_FIXED`, all M3d compound histories or the rest of BCRD**. The 6D test is explicitly a finite mechanism/sanity control.

## New candidate theorem for Hilzy's PR A #286

For a six-by-six complex matrix `ρ : (Fin 6) → (Fin 6) → ℂ`, define `p=(0)(1)(2 3)(4)(5)`. From the literal displayed source equation, the exact algebraic identity is:

```text
W_{ij} = 1 if j = p(i), else 0
(W ρ W†)_{ij} = ρ_{p(i),p(j)}   for ALL complex ρ and i,j.
```

Because `p` is involutive, the conclusion follows from the unique nonzero index in each finite matrix product and does **not** depend on `ρ` being diagonal, a pure basis density or even positive. In particular it applies to every complex density matrix *within this specified finite subsystem*. This is a **mathematical consequence of the pinned W equation**, not yet a Lean-certified theorem in the current PRs.

Suggested proof route without accidental import cycles:

1. Reuse #286's verified integer `evolve_entry` proof architecture, with the source `W` encoded as `Fin 6` permutation.
2. Generalise `evolve_entry` to an arbitrary coefficient structure supporting finite sums, zero and one (at least exact Gaussian rationals, then `ℂ` if the Lean environment supplies a suitable complex matrix type). A conservative intermediate bridge over independent real/imaginary coefficient arrays also works because `W` is real.
3. Formally connect the generic operator to the **literal pinned** `(I3-Q_M)⊗I2 + Q_M⊗X2` in the same basis; do not merely *define* a new `W` equal to the desired permutation without proving source correspondence.
4. Prove both `W† W = I` and the entire complex-matrix update identity. This gives a stronger **operator coverage law for this one physical-source stage**, not a universal physical admissibility/observation theorem.
5. Test non-diagonal complex coherences so the implementation cannot silently restrict to pure basis densities: e.g. `|ψ> = (|M0> + i|R0>)/√2` has imaginary off-diagonal entries, and `W|ψ> = (|M1> + i|R0>)/√2`. Check both `ρ` and its off-diagonal entries against the exact conjugation law.
6. Keep the other process stages `C_LM`, `U_MR_6` and `U_FIXED` separately typed and explicitly **uncovered** until their physical/source semantics, time ordering and within-event histories are independently mapped.

## Crucial within-event expansion: a position path is not a full M3d history

The same pinned M3d source defines the **separate** enabled interaction

```python
THETA = math.pi / 4
U_LM = edge_partial_swap_3(0, 1, THETA)
C_LM = kron(I3, P0) + kron(U_LM, P1)
```

where `edge_partial_swap_3` has diagonal `cos(theta)` on L and M and off-diagonal `-i sin(theta)`. Therefore direct source algebra gives the following **analytic calculation, not yet a new Lean proof** (global phase conventions as literally specified):

```text
initial                         |M0>
after endogenous W               |M1>
after enabled controlled C_LM     cos(pi/4)|M1> − i sin(pi/4)|L1>
                                = (|M1> − i|L1>)/sqrt(2)
```

Both final amplitudes are nonzero. This follows from the literal **same** pinned code, whose `endogenous_relation_update_control` explicitly asserts that L-sector amplitude is nonzero after the stage. A density matrix at the last step contains complex coherence between L1 and M1. It cannot be represented by **one** definite basis position or by `ActualPositionStep : Fin 6 → Fin 6 → Prop` for W alone.

**Consequences for PR B's current theorems:**

- All Phase 3–16 `trackedPosition`, `ActualPositionStep`, `SourceEpisode`, source log checker, synthetic event counts and canonical history reconstruction are correct at their stated scope: repeated applications of the frozen *W permutation only*.
- The exact source-orbit classification `{L0},{L1},{M0,M1},{R0},{R1}` is an orbit classification of **W alone**. It is *not* the reachability graph of the original compound M3d process; the controlled L–M stage genuinely introduces additional support and site transitions.
- A future `WitnessedTrace` over complete M3d physical events must not instantiate `RealStepsRefineSource` using the **W-only** relation when the real-world step includes the later `C_LM` stage, unless the trace has been partitioned into independently witnessed W-only substeps.
- The next correct state type must at least allow coherent six-dimensional complex vectors or complex density matrices, not a single `Fin 6` occupant. The stage history should distinguish `W`, `C_LM`, `U_MR_6`, and the repeated `C_LM` stages as independently typed operators in the proper time order.
- A new stage-typed source adapter must prove that the actual source `W` swap and the subsequent `C_LM` coherent step both correspond to its recorded events. Do not invent a collapse, measurement or subject transfer in order to force the system back into basis-slot form.
- Even such a complete finite complex stage history remains a **finite physical source model**, not a proof of a surviving same experiencing particular, authentic authorization, complete BCRD spacetime or universal X3.

This is a sharper next **positive physical join** than simply adding another frozen-position no-go theorem: prove a fully sourced, nontrivial **within-event complex-state path**, then independently establish what physical/subject interpretations are warranted.

## What does and does not change

**Strongest verified pre-existing facts**: PR A #286 has a kernel-checked full **integer** `Matrix6` *-automorphism, exact action on diagonals and a **certified-domain** result for six basis densities. PR B #285 supplies a sound/complete finite **source-position event validator**, a raw JSON adapter and a conditional physical witnessed trace/count/provenance-to-checker join.

**New reading:** The pinned source **does** specify `W` as a complex-space unitary finite subsystem operator, so there is a promising exact *local complex extension* that need not wait for a complete global BCRD ontology. Its stronger source/operator domain should not be confused with the much narrower set of event/density states actually exercised by the original finite test.

**Still open**: complete BCRD source-to-physical domain, operator stages outside `W`, real-world event/clock/sensor witnesses and complete effect inventory, a noncircular actual subject/experiential-history correspondence, independent authorization, freedom/feasible action space, restraint, maximality and full provenance. Neither the complex extension nor the finite receipt checker would by itself certify original X3 or universal protection.

**Instructions for joint review:** Keep physics-lane frozen; conduct proof and hostile controls in a review branch. Ask for a pinned source-to-construction map, not a source-equivalent hidden oracle. Do not alter #286/#287 or canon from PR B. If the original complex update is generalized to all density matrices of this one subsystem, state that scope accurately and preserve the separate experimental/physical correspondence question.
