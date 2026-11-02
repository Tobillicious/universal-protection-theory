# Frozen BCRD identity-charge audit: an exact candidate failure

2 November 2026. PR #205 research continuation. **Candidate joint-parity conservation: refuted on the frozen M3d event. Original X3.1 continuation or an actual identity ender: unresolved.**

## Frozen question and authority

Test whether the actual frozen M1–M7 controls support a source-grounded non-local identity charge conserved by every admitted event. The frozen source is `Tobillicious/physics-lane` at `2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35`; PR #205 starts this continuation at `6d60cc097fbef07d64fb064bbef43b6114e3c844`.

This is an exact source-model audit. It does not change either frozen source, introduce a physical transition, demote a physical distinction to gauge, or promote a finite source control to a physical-universe theorem. The negative scientific classification is **SCOPE_LIMITING** for the proposed charge extension and **UNRESOLVED** for the original X3.1 subject-continuation claim.

The claim tested, before interpreting the output, is:

\[
\mathrm{ConservedStep}(\mathrm{Step},\mathcal L)
\;:=\;\forall\rho,\rho',\quad
\mathrm{Step}(\rho,\rho')\Rightarrow\mathcal L(\rho)=\mathcal L(\rho').
\]

No generator parameter is tuned. The candidate is selected from the source's existing joint matter–relation parity, rather than defined as a constant or transported along its own evolution. The falsification control is an exact endogenous relation update already present in the frozen source. All relevant operator entries and the witness are integers; no floating-point tolerance is used for the conservation counterexample.

## What the frozen M1–M7 source actually provides

All **68 files** under the frozen BCRD directory were loaded and checked against their Git blob hashes. They include **34 Python files and zero Lean files**. The manifest records every blob SHA and SHA-256.

M1–M7 are a programme of heterogeneous event, algebra, reconstruction and deformation controls, rather than seven constructors of one defined transition relation:

- M1/M2 compare predictive and ledger algebras in two-site and three-site quantum sectors and spectator extensions.
- M3 includes port intervention tests and a six-dimensional qutrit–relation-qubit state-controlled process, plus its explicit endogenous relation-update control.
- M4 is a gauge-by-operational-indistinguishability target/control; it supplies no general historical-particular identity predicate.
- M5/M6 include several current-algebra and relational-generator architectures. Their invariants are architecture-specific.
- M7 supplies moment quotients, calibrated intervention anchors, parity sectors and regular/singular deformation strata, with a separate four-spin extension.

There is no frozen Lean `M1M7State`, complete common `AdmissibleStep`, or source-identified particular/history map on those models. This audit therefore does not present a new tagged union or a substitute dynamics as the original state space. A universal positive Lean proof against pre-existing M1–M7 definitions cannot be run: those Lean definitions do not exist in this frozen tree.

The new formalization instead translates one literal source event and an existing source charge into exact operator tables, with source conformance checks. A single admitted event is sufficient to reject a proposed uniform conservation extension that includes that event and candidate. This does not make different experimental architectures physically interchangeable.

## Candidate non-local charge

The [frozen M6 symmetry-protected model](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/tests/verify_bcrd_m6_symmetry_protected_relational_escape.py) constructs

\[
C=(Q_A+Q_B-Q_C)\otimes\sigma_z,
\qquad\mathcal L(\rho)=\operatorname{Tr}(\rho C).
\]

This is the joint parity used in the [frozen M7 sector construction](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M7-TIER0-OPERATIONAL-DEFORMATION-ALGEBROID.md). It depends jointly on matter and the relational register. It is a candidate for a non-local identity charge, not an established identity of a particular subject.

In the source's Kronecker order

\[
(|L0\rangle,|L1\rangle,|M0\rangle,|M1\rangle,|R0\rangle,|R1\rangle),
\]

using the corresponding ordered qutrit coordinates \(A,B,C\), the operator is

\[
C=\operatorname{diag}(1,-1,1,-1,-1,1).
\]

The exact source generators \(H_1,H_2\) in the symmetry-protected architecture satisfy \([C,H_1]=[C,H_2]=0\). The Lean module checks both integer-entry commutator identities. It does not claim the endogenous M3d update belongs to that restricted M7 generator algebra.

This architecture distinction is already documented in [M5→M6, “Locking-class projectors are not automatically physical charges”](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M5-M6-TWO-GATE-ORBIT-AND-REDUCTION.md): relational-register updates can invalidate invariants of a restricted commuting-current architecture. The new contribution here is its exact source-linked kernel certificate, not a newly discovered general physical no-go.

## The actual frozen transition witness

The [original M3d function `endogenous_relation_update_control`](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/tests/verify_bcrd_m3d_state_determined_accessibility.py#L286) constructs

\[
W_{\rm update}=(I_3-Q_M)\otimes I_2+Q_M\otimes\sigma_x.
\]

Its exact basis permutation is \((0,1,3,2,4,5)\). The original function supplies both the input ket and its output:

\[
|M,0\rangle\longmapsto |M,1\rangle.
\]

Thus, for the normalized pure density matrices \(\rho_0=|M0\rangle\langle M0|\) and \(\rho_1=|M1\rangle\langle M1|\),

\[
\rho_1=W_{\rm update}\rho_0W_{\rm update}^{\dagger},
\qquad\mathcal L(\rho_0)=+1,\quad\mathcal L(\rho_1)=-1.
\]

Equivalently, the \((2,2)\) entry of \(W^{\dagger}CW\) is \(-1\), while that of \(C\) is \(+1\). This is a literal source-operator defect. Both densities have trace one and are the original physical basis states; an unphysical matrix is not used as the counterexample.

For comparison, the relation-zero population \(\operatorname{Tr}(\rho(I_3\otimes P_0))\) changes from one to zero on the same transition. The stronger joint parity also changes, so merely replacing a local register population with the banked joint parity does not repair uniform conservation across these controls.

## What Lean checks, exactly

`PhysicalBridges/FrozenBCRDEvents.lean` is generated from the matrices built inside the unchanged source functions. Its exact integer-entry tables contain \(W,C,H_1,H_2\), the relation-zero projector, their common matrix operations and the original basis densities.

This coefficient restriction does not replace the general complex density-state model: every matrix in the falsifying witness and every source operator used for it already has integer real entries. The checker additionally applies the original complex-valued source evolution to all **36 real matrix units and their 36 imaginary multiples**. The Lean theorem checks the action on all 36 matrix units, including every off-diagonal entry. No spatial state, imaginary coherence or phase is silently discarded to manufacture the counterexample.

`PhysicalBridges/BCRDIdentityCharge.lean` defines the exact `ConservedStep` predicate and proves:

- `source_W_is_unitary` and `source_W_is_self_inverse`;
- `restricted_source_generators_commute_with_C`;
- `source_action_on_all_matrix_units`;
- `source_transition` and `source_densities_are_normalized`;
- `candidate_charge_changes` and `candidate_charge_counterexample`;
- `not_conserved_joint_parity`;
- `not_conserved_on_source_basis`, restricting the witness to the literal normalized source basis densities;
- `exact_Heisenberg_defect`;
- `source_witness_is_reversible`.

The source equation is interpreted as its explicit \(W\rho W^{\dagger}\) transition, rather than a newly invented “erase” action. No physical premise, gauge demotion, transported identity projector, `sorry`, or replacement subject-active flag is introduced.

The package root imports this module and the prior guardian/cyclic modules so a default `lake build` includes them. Targeted elaboration, the default package build and the axiom checks are recorded in `bcrd-identity-charge-verification.json`.

## Why this is not an X3.1 ender certificate

The actual event is reversible: applying the same \(W\) again returns \(\rho_1\) to \(\rho_0\). A changed value of this candidate parity therefore does not establish information destruction, loss of a continuing particular, or loss of that particular's own activity or direction.

The [existing October particular-continuation source bridge](https://github.com/Tobillicious/universal-protection-theory/blob/6d60cc097fbef07d64fb064bbef43b6114e3c844/evidence/physical-bridges/OCT10-PARTICULAR-CONTINUATION-SOURCE-SEMANTIC-BRIDGE.md) already explains why parity conservation, an immutable label or a transported projector is not a physical identity certificate. `ContinuationSubject.LaterStage` separately tracks source-authored histories; the frozen M1–M7 controls supply no map from their matrices or moment states into that semantics.

Accordingly:

| Question | Result |
|---|---|
| Is the literal frozen M3d witness faithfully replayed? | Yes; unchanged source hashes and 72 complex matrix-unit checks |
| Is the candidate joint parity conserved by that event? | No; Lean-certified \(+1\to-1\) witness |
| Is restricted M6/M7 parity conservation contradicted? | No; its generator inventory excludes this M3d update |
| Does an M1–M7-wide extension preserving this same charge survive? | No, if it includes the exhibited source event under the stated coordinate identification |
| Has a different identity charge been ruled out? | No |
| Is an actual original-X3.1 ending or universal continuation proved? | No; source-validated subject/history correspondence and the common admissibility model remain unspecified |

## Full frozen-source replay and one retained failure

All 68 frozen files were hash-checked. Of the 34 Python files, the unrelated `verify_bcrd_structure_function_toy.py` was excluded from the event audit. The remaining **33 unmodified controls** were executed: **32 passed and one failed**.

The failure is the frozen `verify_bcrd_m6_tree_gauge_cycle_holonomy.py` comparison of sorted floating-point complex eigenvalues. In NumPy 1.26.4, tiny real-part perturbations reverse the sort order of the two eigenvalues. Unordered matching differs by approximately \(2.24\times10^{-16}\), and the characteristic-polynomial coefficients differ by approximately \(3.34\times10^{-16}\). This is classified **NUMERICAL_ARTEFACT** of the ordering test; the original failed output is retained and the frozen source is not patched. It is not used as evidence about identity conservation.

`bcrd-frozen-model-replay.json` preserves all replay outputs and that diagnosis. This report does not turn the 32 diagnostic passes into 32 proofs of physical identity conservation.

## Replay

From the repository root:

```bash
python3 evidence/physical-bridges/check_bcrd_identity_charge.py
cd evidence/physical-bridges
lake build
```

The two critical Python sources are vendored unchanged under `frozen-bcrd/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/`, with their original repository paths and hashes in the manifest. The checker verifies those bytes, reads the actual event matrices from the original functions, and rejects any divergence in the generated Lean tables. No network access is needed for this critical replay.

The result submitted to PR #205 is an exact **candidate-charge conservation obstruction**. A physical X3.1 conclusion requires an independently warranted identity/continuation interpretation and complete physical transition coverage; this audit supplies neither by definition.
