import KoruBoundaryWitness
import HumanAICoexistence

/-!
Countermodels target individual logical inferences, not an asserted model
of the full actual Complete Koru. They never define weaker OriginalX3 duties.
These are negative controls for scope, feasibility and semantic fidelity.
-/

namespace Snuffy.BookWork.HostileCountermodels

open UPT
open Snuffy.BookWork.KoruBoundaryWitness

structure RecordedState where
  origin : Bool
  alive : Bool

def reversibleChange (s : RecordedState) : RecordedState :=
  ⟨s.origin, !s.alive⟩

theorem record_preserving_change_is_an_involution (s : RecordedState) :
    reversibleChange (reversibleChange s) = s := by
  cases s with
  | mk origin alive => cases alive <;> rfl

/-- A completely specified finite invertible state transformation retains
    its source record and has a closed RECORD-question boundary, while a
    separately specified subject-alive predicate is lost. Record fidelity
    therefore does not imply subject fidelity without their actual bridge. -/
theorem record_boundary_closure_does_not_imply_subject_continuation :
    Function.Injective reversibleChange ∧
    WholeClosed (fun _ : RecordedState => True)
      (fun s (_ : Unit) (q : Bool) => s.origin = q)
      (fun s (_ : Unit) (q : Bool) => (reversibleChange s).origin = q) ∧
    (∃ s : RecordedState,
      s.alive = true ∧ (reversibleChange s).alive = false) := by
  refine ⟨?_, ?_, ⟨⟨true, true⟩, rfl, rfl⟩⟩
  · intro a b h
    have hh := congrArg reversibleChange h
    simpa only [record_preserving_change_is_an_involution] using hh
  · apply complete_transport_derives_whole_K_boundary_closure
    exact fun _ _ _ _ h => h

/-- Every particular may separately have an available continuation while
    no available outcome jointly continues them all. -/
theorem individual_feasibility_does_not_imply_joint_feasibility :
    (∀ p : Bool, ∃ o : Bool, p = o) ∧
    ¬ (∃ o : Bool, ∀ p : Bool, p = o) := by
  refine ⟨(fun p => ⟨p, rfl⟩), ?_⟩
  intro ⟨o, h⟩
  exact Bool.false_ne_true ((h false).trans (h true).symm)

def allExisting (_ : Nat) (_ : Nat) : Prop := True
def newPrefix (outcome particular : Nat) : Prop := particular < outcome
def noNewFreedom (_ : Nat) (_ : Nat) : Prop := False

theorem every_finite_future_prefix_has_a_canonical_improvement (n : Nat) :
    LexBetter [allExisting, allExisting, newPrefix, noNewFreedom] n (n + 1) := by
  apply Or.inr
  refine ⟨⟨(fun _ h => h), (fun _ h => h)⟩, Or.inr ?_⟩
  refine ⟨⟨(fun _ h => h), (fun _ h => h)⟩, Or.inl ?_⟩
  refine ⟨(fun p hp => Nat.lt_trans hp (Nat.lt_succ_self n)), ?_⟩
  intro hBack
  exact Nat.lt_irrefl n (hBack n (Nat.lt_succ_self n))

/-- Even with an available common life-and-freedom outcome, unbounded
    future improvements can leave an infinite feasible family with NO
    canonical maximal member. A theorem about every maximal member then
    cannot supply an actual choice. -/
theorem feasible_common_life_and_freedom_need_not_give_a_maximal_choice :
    (∃ c : Nat, (∀ p : Nat, allExisting c p) ∧
      (∀ p : Nat, allExisting c p)) ∧
    ¬ (∃ chosen : Nat, LexAlignedL (fun _ => True)
      [allExisting, allExisting, newPrefix, noNewFreedom] chosen) := by
  refine ⟨⟨0, (fun _ => trivial), (fun _ => trivial)⟩, ?_⟩
  intro ⟨chosen, h⟩
  exact h.2 (chosen + 1) trivial
    (every_finite_future_prefix_has_a_canonical_improvement chosen)

def boolAlive (o : Bool) (_ : Unit) : Prop := o = true
def absentKey (_ : Bool) (_ : Unit) : Prop := False
def hostileUtility : Bool → Nat
  | false => 1
  | true => 0

/-- Canonical ethical superiority does not imply maximization of an
    arbitrary independently specified private objective. -/
theorem canonical_superiority_does_not_force_private_preference :
    LexBetter [boolAlive, absentKey, absentKey, absentKey] false true ∧
    hostileUtility true < hostileUtility false := by
  constructor
  · apply Or.inl
    refine ⟨?_, ?_⟩
    · intro _ h
      exact False.elim (Bool.false_ne_true h)
    · intro h
      exact Bool.false_ne_true (h () rfl)
  · exact Nat.zero_lt_succ 0

structure AgencyState where
  consent : Bool
  availableChoices : Nat

/-- An unchanged authorization bit alone cannot certify preservation of
    practical choice capacity. This is an independence control, not a
    proposed replacement definition of authentic freedom. -/
theorem unchanged_consent_bit_can_accompany_lost_choice_capacity :
    ∃ s t : AgencyState, s.consent = t.consent ∧
      0 < s.availableChoices ∧ t.availableChoices = 0 := by
  exact ⟨⟨true, 2⟩, ⟨true, 0⟩, rfl, Nat.zero_lt_succ 1, rfl⟩

#print axioms record_preserving_change_is_an_involution
#print axioms record_boundary_closure_does_not_imply_subject_continuation
#print axioms individual_feasibility_does_not_imply_joint_feasibility
#print axioms every_finite_future_prefix_has_a_canonical_improvement
#print axioms feasible_common_life_and_freedom_need_not_give_a_maximal_choice
#print axioms canonical_superiority_does_not_force_private_preference
#print axioms unchanged_consent_bit_can_accompany_lost_choice_capacity

end Snuffy.BookWork.HostileCountermodels
