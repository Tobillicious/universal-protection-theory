import PhysicalBridges.IRX3CompulsoryCut
import PhysicalBridges.IR105AuthorizationIndependence

/-!
IR-106: the existing IR-75 cut-work inequality is compatible with
a transition that is accounted for but not authorized.
This is a logical compatibility witness, not a complete BCRD model.
-/
namespace PhysicalBridges.IR106

open IRX3CompulsoryCut
open IR105

theorem cut_work_bound_compatible_with_unauthorized_termination :
    BoundaryComplete forced ∧
    ¬ X3Transition forced ∧
    (1 * areaIndex 1 1) * 1 ≤ 1 * 1 := by
  constructor
  · rfl
  constructor
  · intro h
    cases h with
    | inl h => cases h
    | inr h => cases h
  · decide

/-- The IR-75 resource bound is obtained from its premises even for
a protocol classified as unauthorized by the independent subject model. -/
theorem cut_work_converse_does_not_test_authorization :
    ¬ X3Transition forced ∧
    (1 * areaIndex 1 1) * 1 ≤ 1 * 1 := by
  constructor
  · intro h
    cases h with
    | inl h => cases h
    | inr h => cases h
  · exact x3_decoder_converse_to_compulsory_cut_work
      1 0 1 1 1 1 1 1 1 1
      (by decide)
      (by decide)
      (by decide)
      (by decide)

end PhysicalBridges.IR106
