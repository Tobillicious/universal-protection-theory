import PhysicalBridges.IR105AuthorizationIndependence

/-!
IR-107: reversible, bijective dynamics do not guarantee continuation.
The swap is an explicit finite permutation; the labels of states
carry a subject-continuity interpretation not derived from physics.
-/
namespace PhysicalBridges.IR107

def swap (b : Bool) : Bool := !b

theorem swap_involution (b : Bool) : swap (swap b) = b := by
  cases b <;> rfl

theorem reversible_transition_can_end_subject :
    (∀ b : Bool, swap (swap b) = b) ∧
    swap true = false := by
  constructor
  · exact swap_involution
  · rfl

/-- Even bijective evolution on the full state space does not
preserve a particular predicate marking active subject continuity. -/
theorem no_universal_continuity_from_reversibility :
    ¬ (∀ b : Bool, b = true → swap b = true) := by
  intro h
  have bad := h true rfl
  cases bad

end PhysicalBridges.IR107
