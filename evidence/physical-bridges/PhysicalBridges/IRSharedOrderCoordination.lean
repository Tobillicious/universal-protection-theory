/-
Referee check: common UPT lexicographic partial order does not imply
a unique globally maximal choice or a common deterministic outcome.
The full original feasible family and comparator are unchanged.
-/
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRSharedOrderCoordination

def key : Bool → Bool → Prop :=
  PhysicalBridges.IRSelectedMaximality.incomparable
def full (_ : Bool) : Prop := True
def priorities : List (Bool → Bool → Prop) := [key]

/-- Two incomparable singleton-retention choices cannot be a strict
improvement over each other in the original lexicographic order. -/
theorem no_strict_improvement_between_choices (a b : Bool) :
    ¬ UPTExist.LexBetter priorities a b := by
  intro h
  change UPTExist.SSub (key a) (key b) ∨
    (UPTExist.Equiv (key a) (key b) ∧ False) at h
  rcases h with hs | ⟨_, hf⟩
  · have hba : b = a := hs.1 a rfl
    have hback : UPTExist.Sub (key b) (key a) := by
      intro x hx
      change b = x at hx
      change a = x
      exact hba.symm.trans hx
    exact hs.2 hback
  · exact hf

/-- Both distinct choices are maximal in the FULL original family. -/
theorem both_choices_globally_maximal :
    UPTExist.LexAlignedL full priorities true ∧
    UPTExist.LexAlignedL full priorities false := by
  constructor
  · exact ⟨trivial, fun b _ => no_strict_improvement_between_choices true b⟩
  · exact ⟨trivial, fun b _ => no_strict_improvement_between_choices false b⟩

theorem full_maximality_not_unique :
    ∃ a b : Bool, a ≠ b ∧
      UPTExist.LexAlignedL full priorities a ∧
      UPTExist.LexAlignedL full priorities b := by
  exact ⟨true, false, by decide,
    both_choices_globally_maximal.1,
    both_choices_globally_maximal.2⟩

/-- One deterministic output cannot physically equal both incompatible
maximal choices. This does not imply the agents have different values. -/
theorem one_policy_cannot_output_both_choices :
    ¬ ∃ p : Unit → Bool, p () = true ∧ p () = false := by
  rintro ⟨p, ha, hb⟩
  have contra : (true : Bool) = false := ha.symm.trans hb
  cases contra

/-- Uniqueness of maximal selection, if independently proved, does
suffice for common outcome choice. It does NOT follow from maximality. -/
theorem unique_maximum_implies_common_choice
    {O : Type} {P : Type}
    (feasible : O → Prop) (keys : List (O → P → Prop))
    (selected a b : O)
    (hUnique : ∀ o, UPTExist.LexAlignedL feasible keys o → o = selected)
    (ha : UPTExist.LexAlignedL feasible keys a)
    (hb : UPTExist.LexAlignedL feasible keys b) :
    a = b :=
  (hUnique a ha).trans (hUnique b hb).symm

#print axioms no_strict_improvement_between_choices
#print axioms both_choices_globally_maximal
#print axioms full_maximality_not_unique
#print axioms one_policy_cannot_output_both_choices
#print axioms unique_maximum_implies_common_choice
end PhysicalBridges.IRSharedOrderCoordination
