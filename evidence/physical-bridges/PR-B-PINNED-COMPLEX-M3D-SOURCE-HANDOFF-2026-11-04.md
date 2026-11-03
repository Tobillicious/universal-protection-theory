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

## What does and does not change

**Strongest verified pre-existing facts**: PR A #286 has a kernel-checked full **integer** `Matrix6` *-automorphism, exact action on diagonals and a **certified-domain** result for six basis densities. PR B #285 supplies a sound/complete finite **source-position event validator**, a raw JSON adapter and a conditional physical witnessed trace/count/provenance-to-checker join.

**New reading:** The pinned source **does** specify `W` as a complex-space unitary finite subsystem operator, so there is a promising exact *local complex extension* that need not wait for a complete global BCRD ontology. Its stronger source/operator domain should not be confused with the much narrower set of event/density states actually exercised by the original finite test.

**Still open**: complete BCRD source-to-physical domain, operator stages outside `W`, real-world event/clock/sensor witnesses and complete effect inventory, a noncircular actual subject/experiential-history correspondence, independent authorization, freedom/feasible action space, restraint, maximality and full provenance. Neither the complex extension nor the finite receipt checker would by itself certify original X3 or universal protection.

**Instructions for joint review:** Keep physics-lane frozen; conduct proof and hostile controls in a review branch. Ask for a pinned source-to-construction map, not a source-equivalent hidden oracle. Do not alter #286/#287 or canon from PR B. If the original complex update is generalized to all density matrices of this one subsystem, state that scope accurately and preserve the separate experimental/physical correspondence question.
