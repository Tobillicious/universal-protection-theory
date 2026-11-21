import PhysicalBridges.SummitBCRDReversibility

/-!
# Reversible source orbits: the exact additional condition for stagewise protection

4 November 2026. Independent review increment stacked on PR #274.
No canonical manuscript or publication change. This does NOT establish X3.

A reversible physical update is an invertible map. It preserves the
recoverability of whole states, but not every independently defined
state predicate at every stage. The exact extra step is ORBIT CONSTANCY:
the predicate must be invariant along the update's actual orbits.

This module proves the criterion for any involution, and tests it on
the *literal frozen M3d witness*. A site-occupancy label changes under
the actual source update although the state is fully reversible.
Site occupancy is not a person or subjective continuation; the negative
control only blocks an invalid implication from reversibility to
arbitrary per-stage semantic protection.

The original full six-component X3 goal is unchanged. The missing
positive bridge is to prove, from independent original subject
semantics, that each owed X3 component is constant along actual
physical source orbits (or to prove a stronger step invariant).
-/

namespace PhysicalBridges.SummitReversibleOrbitCriterion

open FrozenBCRDEvents
open PhysicalBridges.SummitBCRDReversibility

/-- For an involution, forward preservation of a state property is
equivalent to constancy across both directions of each two-step
orbit. Invertibility alone is not that invariance. -/
theorem involution_preserves_iff_orbit_constant
    {S : Type} (f : S → S) (P : S → Prop)
    (hInv : ∀ s, f (f s) = s) :
    (∀ s, P s → P (f s)) ↔ (∀ s, P s ↔ P (f s)) := by
  constructor
  · intro hStep s
    constructor
    · exact hStep s
    · intro hAfter
      have hBack : P (f (f s)) := hStep (f s) hAfter
      rw [hInv s] at hBack
      exact hBack
  · intro hOrbit s hBefore
    exact (hOrbit s).mp hBefore

/-- A fixed-site occupancy diagnostic, deliberately NOT an original
X3 predicate. Source reversibility does not imply that a fixed
basis-site occupancy is present at every intermediate stage. -/
def atM0 (rho : Matrix6) : Prop := rho 2 2 = 1

/-- Real frozen source witness: the reversible step changes the
fixed-site occupancy label, then reverses on a further step.
This is not a claim about a living person. -/
theorem frozen_witness_reversible_but_site_label_changes :
    BCRDIdentityCharge.FrozenM3dStep densityBefore densityAfter ∧
    atM0 densityBefore ∧
    ¬ atM0 densityAfter ∧
    evolve densityAfter = densityBefore := by
  refine ⟨BCRDIdentityCharge.source_transition, ?_, ?_,
          BCRDIdentityCharge.source_witness_is_reversible⟩
  · rfl
  · intro h
    have h01 : (0 : Int) = 1 := h
    exact (show (0 : Int) ≠ 1 from by decide) h01

/-- Hence the M3d update does not automatically preserve every
state predicate, even though it is reversible on the witness. -/
theorem reversible_source_does_not_preserve_every_stage_property :
    ¬ (∀ rho : Matrix6, atM0 rho → atM0 (evolve rho)) := by
  intro hAll
  have hBefore : atM0 densityBefore := by rfl
  have hAfter : atM0 (evolve densityBefore) := hAll densityBefore hBefore
  have hEq : evolve densityBefore = densityAfter := by
    exact (show densityAfter = evolve densityBefore from
      BCRDIdentityCharge.source_transition).symm
  rw [hEq] at hAfter
  have h01 : (0 : Int) = 1 := hAfter
  exact (show (0 : Int) ≠ 1 from by decide) h01

/-- On ALL 36 source matrix-unit orbits, stagewise preservation is
equivalent to orbit constancy, not merely implied by it. The converse
uses the actual frozen permutation action and its involution theorem. -/
theorem frozen_basis_step_preserves_iff_orbit_constant
    (P : Matrix6 → Prop) :
    (∀ i j : Index,
      P (matrixUnit i j) → P (evolve (matrixUnit i j))) ↔
    (∀ i j : Index,
      P (matrixUnit i j) ↔ P (evolve (matrixUnit i j))) := by
  constructor
  · intro hForward i j
    constructor
    · exact hForward i j
    · intro hAfter
      have hOne : evolve (matrixUnit i j) =
          matrixUnit (permutation i) (permutation j) := by
        funext a b
        exact BCRDIdentityCharge.source_action_on_all_matrix_units i j a b
      have hP : P (matrixUnit (permutation i) (permutation j)) := by
        rw [hOne] at hAfter
        exact hAfter
      have hBack := hForward (permutation i) (permutation j) hP
      have hTwo : evolve (matrixUnit (permutation i) (permutation j)) =
          matrixUnit i j := by
        have hInv := source_generator_reverses_basis_states i j
        rw [hOne] at hInv
        exact hInv
      rw [hTwo] at hBack
      exact hBack
  · intro hOrbit i j hP
    exact (hOrbit i j).mp hP

#print axioms involution_preserves_iff_orbit_constant
#print axioms frozen_witness_reversible_but_site_label_changes
#print axioms reversible_source_does_not_preserve_every_stage_property
#print axioms frozen_basis_step_preserves_iff_orbit_constant

end PhysicalBridges.SummitReversibleOrbitCriterion
