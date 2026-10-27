/-
IR-71: Preserve positive mandatory rights/continuations as a BASE,
rather than erroneously assuming that all physical feasibility is
downward closed. The original original UPTExist two-stage LexBetter
order is unchanged and all feasible outcomes satisfying the
mandatory base are compared.

For arbitrary cross-stage finite forbidden patterns, if the
mandatory baseline itself is feasible, two infinite greedy phases
extend it to an original-order maximal feasible retention outcome.
This does not prove a physically feasible mandatory baseline exists,
or that scalar retention captures original historical continuity.
-/
import PhysicalBridges.IRFiniteRefutationCriterion

namespace PhysicalBridges.IRMandatoryBaselineMaximality
open IRCoupledFinitaryTwoStage

/-- The full feasible family has an explicit POSITIVE mandatory
retention duty. It is NOT downward closed in the whole powerset,
unlike the earlier finite forbidden pattern predicate. -/
def RequiredFeasible
    (forbidden : List Fact → Prop)
    (required : Outcome) (s : Outcome) : Prop :=
  IRCoupledFinitaryTwoStage.Feasible forbidden s ∧
    UPTExist.Sub required s

noncomputable def firstProtected
    (forbidden : List Fact → Prop) (required : Outcome) : Outcome :=
  phaseLimit forbidden required false

noncomputable def finalProtected
    (forbidden : List Fact → Prop) (required : Outcome) : Outcome :=
  phaseLimit forbidden (firstProtected forbidden required) true

theorem first_protected_feasible
    (forbidden : List Fact → Prop) (required : Outcome)
    (hRequired : IRCoupledFinitaryTwoStage.Feasible forbidden required) :
    IRCoupledFinitaryTwoStage.Feasible forbidden
      (firstProtected forbidden required) := by
  exact phaseLimit_feasible forbidden required false hRequired

theorem final_protected_feasible
    (forbidden : List Fact → Prop) (required : Outcome)
    (hRequired : IRCoupledFinitaryTwoStage.Feasible forbidden required) :
    IRCoupledFinitaryTwoStage.Feasible forbidden
      (finalProtected forbidden required) := by
  exact phaseLimit_feasible forbidden
    (firstProtected forbidden required) true
    (first_protected_feasible forbidden required hRequired)

theorem final_protected_contains_required
    (forbidden : List Fact → Prop) (required : Outcome) :
    UPTExist.Sub required
      (finalProtected forbidden required) := by
  exact UPTExist.Sub.trans
    (phaseLimit_contains_base forbidden required false)
    (phaseLimit_contains_base forbidden
      (firstProtected forbidden required) true)

theorem first_protected_base_or_higher
    (forbidden : List Fact → Prop) (required : Outcome)
    (fact : Fact)
    (h : firstProtected forbidden required fact) :
    required fact ∨ fact.1 = false := by
  by_cases hHigher : fact.1 = false
  · exact Or.inr hHigher
  · exact Or.inl
      (phaseLimit_no_cross forbidden required false
        fact hHigher h)

theorem final_first_priority_iff
    (forbidden : List Fact → Prop) (required : Outcome)
    (k : Nat) :
    finalProtected forbidden required (false,k) ↔
      firstProtected forbidden required (false,k) := by
  constructor
  · exact phaseLimit_no_cross forbidden
      (firstProtected forbidden required) true (false,k) (by simp)
  · exact phaseLimit_contains_base forbidden
      (firstProtected forbidden required) true (false,k)

/-- No full-feasible outcome satisfying the original mandatory
protections can STRICTLY increase retained first-priority facts.
The proof permits arbitrary CROSS-STAGE finite conflicts. -/
theorem no_required_first_improver
    (forbidden : List Fact → Prop) (required other : Outcome)
    (hOther : RequiredFeasible forbidden required other)
    (hStrict : UPTExist.SSub
      (firstKey (finalProtected forbidden required))
      (firstKey other)) :
    False := by
  apply hStrict.2
  intro k hk
  by_cases hChosen :
      finalProtected forbidden required (false,k)
  · exact hChosen
  · have hCandidate :
        IRCoupledFinitaryTwoStage.Feasible forbidden
          (fun fact =>
            firstProtected forbidden required fact ∨
            fact = (false,k)) := by
      apply IRCoupledFinitaryTwoStage.feasible_downward
        forbidden other
        (fun fact =>
          firstProtected forbidden required fact ∨
          fact = (false,k)) hOther.1
      intro fact hf
      rcases hf with hFirst | hEq
      · have hKind := first_protected_base_or_higher
          forbidden required fact hFirst
        rcases hKind with hBaseline | hHigher
        · exact hOther.2 fact hBaseline
        · cases fact with
          | mk b n =>
              subst b
              exact hStrict.1 n
                ((final_first_priority_iff forbidden required n).2
                  hFirst)
      · subst fact
        exact hk
    have hAdmitted := phase_cannot_add_missing
      forbidden required false k hCandidate
    exact False.elim (hChosen
      ((final_first_priority_iff forbidden required k).2
        hAdmitted))

/-- With the first priority exactly retained, all lower-priority
strict improvements are blocked by the second infinite phase. -/
theorem no_required_second_improver
    (forbidden : List Fact → Prop) (required other : Outcome)
    (hOther : RequiredFeasible forbidden required other)
    (hFirstEq : UPTExist.Equiv
      (firstKey (finalProtected forbidden required))
      (firstKey other))
    (hSecondStrict : UPTExist.SSub
      (secondKey (finalProtected forbidden required))
      (secondKey other)) :
    False := by
  apply hSecondStrict.2
  intro k hk
  by_cases hChosen :
      finalProtected forbidden required (true,k)
  · exact hChosen
  · have hCandidate :
        IRCoupledFinitaryTwoStage.Feasible forbidden
          (fun fact =>
            finalProtected forbidden required fact ∨
            fact = (true,k)) := by
      apply IRCoupledFinitaryTwoStage.feasible_downward
        forbidden other
        (fun fact =>
          finalProtected forbidden required fact ∨
          fact = (true,k)) hOther.1
      intro fact hf
      rcases hf with hF | heq
      · cases fact with
        | mk b n =>
            cases b with
            | false => exact hFirstEq.1 n hF
            | true => exact hSecondStrict.1 n hF
      · subst fact
        exact hk
    have hAdmitted := phase_cannot_add_missing
      forbidden (firstProtected forbidden required) true k hCandidate
    exact False.elim (hChosen hAdmitted)

/-- GENERIC coupled, full-feasible TWO-priority maximality with
positive mandatory retentions. These original positive rights are
NEVER deleted; unlike the original IR-66 empty-base construction,
we assume and retain a genuinely feasible mandatory baseline. -/
theorem required_baseline_full_feasible_original_lex_maximal
    (forbidden : List Fact → Prop) (required : Outcome)
    (hRequired :
      IRCoupledFinitaryTwoStage.Feasible forbidden required) :
    UPTExist.LexAlignedL
      (RequiredFeasible forbidden required)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (finalProtected forbidden required) := by
  refine ⟨⟨final_protected_feasible forbidden required hRequired,
    final_protected_contains_required forbidden required⟩, ?_⟩
  intro other hOther hBetter
  change
    UPTExist.SSub
      (firstKey (finalProtected forbidden required))
      (firstKey other) ∨
    (UPTExist.Equiv
      (firstKey (finalProtected forbidden required))
      (firstKey other) ∧
      (UPTExist.SSub
        (secondKey (finalProtected forbidden required))
        (secondKey other) ∨
        (UPTExist.Equiv
          (secondKey (finalProtected forbidden required))
          (secondKey other) ∧ False))) at hBetter
  rcases hBetter with hFirst | ⟨hFirstEq,hLater⟩
  · exact no_required_first_improver forbidden required other
      hOther hFirst
  · rcases hLater with hSecond | ⟨_,hImpossible⟩
    · exact no_required_second_improver forbidden required other
        hOther hFirstEq hSecond
    · exact hImpossible

/-- A physically motivated resource-capacity specialization. The
positive required baseline is independently ASSUMED feasible. No
permissible physical X3 protections may be dropped merely to make
the modeled capacity menu nonempty. -/
def RequiredResourceFeasible
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop)
    (required : Outcome) (s : Outcome) : Prop :=
  IRResourceDerivedClosure.CapacityFeasible
    weight capacity hard s ∧ UPTExist.Sub required s

theorem resource_capacity_plus_mandatory_baseline_maximal
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required : Outcome)
    (hRequired :
      IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard required) :
    UPTExist.LexAlignedL
      (RequiredResourceFeasible weight capacity hard required)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          weight capacity hard) required) := by
  have hOriginal :=
    required_baseline_full_feasible_original_lex_maximal
      (IRResourceDerivedClosure.DerivedForbidden
        weight capacity hard) required
      ((IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
        weight capacity hard required).mp hRequired)
  constructor
  · exact ⟨
      (IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
        weight capacity hard _).mpr hOriginal.1.1,
      hOriginal.1.2⟩
  · intro other hFeasible hBetter
    exact hOriginal.2 other
      ⟨(IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
        weight capacity hard other).mp hFeasible.1,
       hFeasible.2⟩ hBetter

/-- A mandatory duty is NOT downward closed in general. The new
construction handles that requirement without imposing hereditary
feasibility upon the entire original predicate. -/
theorem required_duty_is_genuinely_positive :
    ¬ (∀ larger smaller : Outcome,
      RequiredFeasible (fun _ => False)
        (fun f => f = (false,0)) larger →
      UPTExist.Sub smaller larger →
      RequiredFeasible (fun _ => False)
        (fun f => f = (false,0)) smaller) := by
  intro hDown
  have hLarger :
      RequiredFeasible (fun _ => False)
        (fun f => f = (false,0))
        (fun _ => True) := by
    constructor
    · intro xs hForbidden _
      exact hForbidden
    · intro f hf
      trivial
  have hSub : UPTExist.Sub
      (fun _ : Fact => False) (fun _ : Fact => True) := by
    intro f hf
    cases hf
  have hSmall := hDown (fun _ => True) (fun _ => False)
      hLarger hSub
  have hMust := hSmall.2 (false,0) rfl
  exact hMust

#print axioms first_protected_feasible
#print axioms final_protected_feasible
#print axioms final_protected_contains_required
#print axioms first_protected_base_or_higher
#print axioms final_first_priority_iff
#print axioms no_required_first_improver
#print axioms no_required_second_improver
#print axioms required_baseline_full_feasible_original_lex_maximal
#print axioms resource_capacity_plus_mandatory_baseline_maximal
#print axioms required_duty_is_genuinely_positive
end PhysicalBridges.IRMandatoryBaselineMaximality
