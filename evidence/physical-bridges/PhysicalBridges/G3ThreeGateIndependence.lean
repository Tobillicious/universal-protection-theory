import PhysicalBridges.G3PreQGComplete
import PhysicalBridges.PhysicalSemanticLastMileGates

/-!
# Backwards summit — independence of the last three physical gates

We reuse exact existing G3 physical-event coverage and authentic forward
reflection definitions, rather than inventing a second semantics.

1. Complete coverage and authentic reflection can hold without any physical
   next step. The countermodel's physical and modeled event relations are
   empty, so this is intentionally a *vacuity diagnostic*.
2. In a nonterminal, actually populated W-covered world, the original-six
   subject predicates may still deny authorization. Thus nontermination
   and exact W coverage do not force independently authentic reflection.

These are logical models identifying where independent physical/ethical
evidence must enter. Neither is asserted to describe the actual universe.
No Koru, PureG, original X3, or GoodConquersEvil definitions are changed.
-/

namespace PhysicalBridges.G3ThreeGateIndependence

open PhysicalBridges.G3PreQGComplete
open PhysicalBridges.PhysicalSemanticLastMileGates
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

/-- Negative control A: an empty event relation on a nonempty state type. -/
def noPhysicalSuccessor (_ _ : Unit) : Prop := False

/-- Coverage is vacuously true when there are no physical events. -/
theorem empty_steps_have_complete_coverage :
    CompleteWEventCoverage noPhysicalSuccessor noPhysicalSuccessor
      (fun _ : Unit => positiveWholeU) (fun _ : Unit => 0)
      positiveWholeU := by
  intro s t hs
  exact False.elim hs

/-- Reflection is also vacuously true without modeled events, even if
    all the subject predicates are false. -/
theorem empty_steps_have_forward_reflection :
    ForwardRealEventReflection noPhysicalSuccessor
      (fun _ : Unit => 0) positiveWholeU sixDiagonalRoles
      (fun _ : Unit => (0 : Index))
      ({ continues := fun _ _ _ => False
         authorized := fun _ _ _ => False
         free := fun _ _ _ => False
         restrained := fun _ _ _ => False
         maximal := fun _ _ _ => False
         provenanced := fun _ _ _ => False } :
        ParticularRelations Unit Unit)
      (fun _ : Unit => True) := by
  intro s t p tag hs
  exact False.elim hs

/-- No state has a successor in the same model. -/
theorem empty_steps_are_terminal :
    ¬ (∀ s : Unit, ∃ t : Unit, noPhysicalSuccessor s t) := by
  intro h
  obtain ⟨t, ht⟩ := h ()
  exact ht

/-- Negative control B: a populated, nonterminal W trajectory. -/
def forwardNatStep (s t : Nat) : Prop := t = s + 1

def forwardSource (n : Nat) : FiniteObjectiveU :=
  objectiveAt positiveWholeU n

/-- Every state has a physical next step. -/
theorem forward_nat_is_nonterminal :
    ∀ s : Nat, ∃ t : Nat, forwardNatStep s t := by
  intro s
  exact ⟨s + 1, rfl⟩

/-- The whole positive W source is correctly represented on EVERY
    actual successor event, with actual nonempty steps. -/
theorem forward_nat_has_complete_W_coverage :
    CompleteWEventCoverage forwardNatStep forwardNatStep
      forwardSource (fun n => n) positiveWholeU := by
  intro s t ht
  exact ⟨ht, rfl, rfl, ht⟩

/-- An independent subject interpretation that withholds authorization.
    This intentionally does not rename physical source links as consent. -/
def noAuthorizationSubjects : ParticularRelations Nat Unit where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

/-- Even with real model steps and exact whole-W coverage, authentic
    forward reflection is not automatic. -/
theorem covered_nonterminal_world_can_fail_reflection :
    ¬ ForwardRealEventReflection forwardNatStep (fun n => n)
      positiveWholeU sixDiagonalRoles
      (fun _ : Unit => (0 : Index)) noAuthorizationSubjects
      (fun _ : Unit => True) := by
  intro hReflection
  have hAll :=
    complete_coverage_and_authentic_reflection_force_original_six
      forwardNatStep forwardNatStep forwardSource
      (fun n => n) (fun _ : Unit => (0 : Index))
      noAuthorizationSubjects (fun _ : Unit => True)
      forward_nat_has_complete_W_coverage hReflection
      0 1 rfl () trivial
  exact hAll.2.authorization

/-- Joint witness: physical nontermination and complete source coverage
    are satisfied, yet independent authentic subject reflection fails. -/
theorem continuation_and_coverage_do_not_force_reflection :
    (∀ s : Nat, ∃ t : Nat, forwardNatStep s t) ∧
    CompleteWEventCoverage forwardNatStep forwardNatStep
      forwardSource (fun n => n) positiveWholeU ∧
    ¬ ForwardRealEventReflection forwardNatStep (fun n => n)
      positiveWholeU sixDiagonalRoles
      (fun _ : Unit => (0 : Index)) noAuthorizationSubjects
      (fun _ : Unit => True) := by
  exact ⟨forward_nat_is_nonterminal,
    forward_nat_has_complete_W_coverage,
    covered_nonterminal_world_can_fail_reflection⟩

#print axioms empty_steps_have_complete_coverage
#print axioms empty_steps_have_forward_reflection
#print axioms empty_steps_are_terminal
#print axioms forward_nat_is_nonterminal
#print axioms forward_nat_has_complete_W_coverage
#print axioms covered_nonterminal_world_can_fail_reflection
#print axioms continuation_and_coverage_do_not_force_reflection

end PhysicalBridges.G3ThreeGateIndependence
