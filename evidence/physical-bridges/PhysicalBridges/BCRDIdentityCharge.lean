import PhysicalBridges.FrozenBCRDEvents

/-!
# Exact frozen-source candidate-charge obstruction

L is the source M6/M7 joint matter--relation parity, evaluated on the exact
integer-entry density matrices containing the actual M3d source witness.
The source matrix tables are checked against unchanged frozen Python code.

This is NOT a new universal M1--M7 state space or a semantic identity model.
It certifies a real source event's failure to conserve this candidate charge.
A change of C is not, by itself, an original-X3.1 ending of a particular.
No physical state, sector, intervention or orbit is declared gauge.
-/

namespace PhysicalBridges.BCRDIdentityCharge

open FrozenBCRDEvents

def ConservedStep {State Charge : Type} (step : State → State → Prop)
    (charge : State → Charge) : Prop :=
  ∀ s t, step s t → charge s = charge t

/-- The actual frozen M3d endogenous update, on exact integer-entry data. -/
def FrozenM3dStep (rho sigma : Matrix6) : Prop := sigma = evolve rho

/-- Candidate non-local source charge: the M6/M7 joint parity, not a
postulated subject label or a projector transported with its own state. -/
def L (rho : Matrix6) : Int := trace (mul rho jointParity)

/-- Actual normalized pure basis densities of the frozen six-state sector.
This restricts the witness, not the source's general physical state space. -/
def SourceBasisDensity (rho : Matrix6) : Prop :=
  ∃ i : Index, rho = matrixUnit i i

def SourceBasisStep (rho sigma : Matrix6) : Prop :=
  SourceBasisDensity rho ∧ SourceBasisDensity sigma ∧ FrozenM3dStep rho sigma

theorem source_W_is_unitary :
    ∀ i j, mul (transpose wUpdate) wUpdate i j = identityMatrix i j := by decide

theorem source_W_is_self_inverse :
    ∀ i j, mul wUpdate wUpdate i j = identityMatrix i j := by decide

theorem restricted_source_generators_commute_with_C :
    (∀ i j, mul jointParity h1 i j = mul h1 jointParity i j) ∧
    (∀ i j, mul jointParity h2 i j = mul h2 jointParity i j) := by decide

set_option maxRecDepth 8192 in
set_option maxHeartbeats 1600000 in
/-- All 36 matrix units: exact source permutation, including off-diagonals.
The Python conformance checker also checks their imaginary multiples using
the original complex-valued source update. -/
theorem source_action_on_all_matrix_units :
    ∀ i j a b, evolve (matrixUnit i j) a b =
      matrixUnit (permutation i) (permutation j) a b := by decide

/-- The source's literal |M,0> -> |M,1> transition. -/
theorem source_transition : FrozenM3dStep densityBefore densityAfter := by
  apply funext
  intro i
  apply funext
  intro j
  exact (by decide : ∀ i j, densityAfter i j = evolve densityBefore i j) i j

theorem source_densities_are_normalized :
    trace densityBefore = 1 ∧ trace densityAfter = 1 := by decide

theorem witness_densities_are_source_basis_states :
    SourceBasisDensity densityBefore ∧ SourceBasisDensity densityAfter :=
  ⟨⟨2, rfl⟩, ⟨3, rfl⟩⟩

theorem candidate_charge_changes :
    L densityBefore = 1 ∧ L densityAfter = -1 := by decide

/-- Explicit falsifying event for ConservedStep, with no new transition. -/
theorem candidate_charge_counterexample :
    ∃ rho sigma, FrozenM3dStep rho sigma ∧ L rho ≠ L sigma := by
  refine ⟨densityBefore, densityAfter, source_transition, ?_⟩
  exact (by decide : L densityBefore ≠ L densityAfter)

theorem not_conserved_joint_parity : ¬ ConservedStep FrozenM3dStep L := by
  intro h
  obtain ⟨rho, sigma, hStep, hDifferent⟩ := candidate_charge_counterexample
  exact hDifferent (h rho sigma hStep)

/-- Failure already occurs between the literal physical basis states in
the source; nonphysical integer matrices are unnecessary to the witness. -/
theorem not_conserved_on_source_basis : ¬ ConservedStep SourceBasisStep L := by
  intro h
  have hStep : SourceBasisStep densityBefore densityAfter :=
    ⟨witness_densities_are_source_basis_states.1,
      witness_densities_are_source_basis_states.2, source_transition⟩
  exact (by decide : L densityBefore ≠ L densityAfter)
    (h densityBefore densityAfter hStep)

theorem exact_Heisenberg_defect :
    mul (transpose wUpdate) (mul jointParity wUpdate) 2 2 = -1 ∧
      jointParity 2 2 = 1 := by decide

/-- The same source unitary reverses the witness. A parity change therefore
does not certify information erasure or an ending of a physical subject. -/
theorem source_witness_is_reversible : evolve densityAfter = densityBefore := by
  apply funext
  intro i
  apply funext
  intro j
  exact (by decide : ∀ i j, evolve densityAfter i j = densityBefore i j) i j

end PhysicalBridges.BCRDIdentityCharge
