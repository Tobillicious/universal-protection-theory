import PhysicalBridges.CathedralCutGuardianCriterion

/-!
Interventional BCRD-source forcing (conditional).
This file does NOT assert that real BCRD satisfies the premises.
Source Allowed, Step and original protected predicate are independently
supplied. We derive a common cut action from ACTION-INDEXED response
congruence and pointwise viability, rather than assuming a cut guardian.
-/
namespace PhysicalBridges.CathedralInterventionalForcing

open CathedralCutGuardianCriterion

universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- A source action admits at least one harmful modeled successor.
The failure signal must be independently physically defined and
observable before it can count as an actual BCRD cut response. -/
def BadSuccessor (step : S → A → S → Prop)
    («protected» : S → Prop) (s : S) (a : A) : Prop :=
  ∃ t, step s a t ∧ ¬ «protected» t

/-- Equality of both response bits for every physically identical
action on protected states sharing a cut. This is an explicit
physical-source premise, NOT a derived BCRD measurement theorem. -/
def InterventionResponseComplete (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop) : Prop :=
  ∀ s t a, observe s = observe t →
    «protected» s → «protected» t →
    (allowed s a ↔ allowed t a) ∧
    (BadSuccessor step «protected» s a ↔
      BadSuccessor step «protected» t a)

/-- A representative's independently available safe action transfers
to every state of its cut fibre. No guardian is a premise. -/
theorem intervention_complete_pointwise_viable_forces_guardian
    [Inhabited A]
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (hComplete : InterventionResponseComplete observe step allowed «protected»)
    (hViable : ∀ s, «protected» s →
      ∃ a, GuardAction step allowed «protected» s a) :
    ExistsCutGuardian observe step allowed «protected» := by
  apply (guardian_exists_iff_fibre_has_common_action
    observe step allowed «protected»).mpr
  intro o
  classical
  by_cases hSome : ∃ s, observe s = o ∧ «protected» s
  · obtain ⟨s, hsObs, hsP⟩ := hSome
    obtain ⟨a, ha⟩ := hViable s hsP
    refine ⟨a, ?_⟩
    intro t htObs htP
    have hSame : observe s = observe t := hsObs.trans htObs.symm
    obtain ⟨hAllowed, hBad⟩ := hComplete s t a hSame hsP htP
    refine ⟨hAllowed.mp ha.1, ?_⟩
    intro u hStep
    by_contra hNot
    have hBadT : BadSuccessor step «protected» t a :=
      ⟨u, hStep, hNot⟩
    obtain ⟨v, hvStep, hvNot⟩ : BadSuccessor step «protected» s a :=
      hBad.mpr hBadT
    exact hvNot (ha.2 v hvStep)
  · refine ⟨default, ?_⟩
    intro t htObs htP
    exact False.elim (hSome ⟨t, htObs, htP⟩)

/-- Actual cut factorization is the stronger source-facing premise.
Pointwise viability remains an independent physical obligation. -/
theorem source_factorized_responses_force_guardian
    [Inhabited A]
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (permissionAtCut : O → A → Prop) (failureAtCut : O → A → Prop)
    (hPermission : ∀ s a, allowed s a ↔ permissionAtCut (observe s) a)
    (hFailure : ∀ s a, BadSuccessor step «protected» s a ↔
       failureAtCut (observe s) a)
    (hViable : ∀ s, «protected» s →
      ∃ a, GuardAction step allowed «protected» s a) :
    ExistsCutGuardian observe step allowed «protected» := by
  apply intervention_complete_pointwise_viable_forces_guardian
    observe step allowed «protected» ?_ hViable
  intro s t a hSame _ _
  constructor
  · calc
      allowed s a ↔ permissionAtCut (observe s) a := hPermission s a
      _ ↔ permissionAtCut (observe t) a := by rw [hSame]
      _ ↔ allowed t a := (hPermission t a).symm
  · calc
      BadSuccessor step «protected» s a ↔
          failureAtCut (observe s) a := hFailure s a
      _ ↔ failureAtCut (observe t) a := by rw [hSame]
      _ ↔ BadSuccessor step «protected» t a := (hFailure t a).symm

/-!
Pairwise obstruction tests are INCOMPLETE when the action set
has three or more members: every pair can share an action while
all three have no common action.
-/
inductive ThreeState where
  | first | second | third
  deriving DecidableEq

inductive ThreeAction where
  | a | b | c
  deriving DecidableEq

def threeSafe : ThreeState → ThreeAction → Prop
  | .first, .a => True
  | .first, .b => True
  | .second, .b => True
  | .second, .c => True
  | .third, .a => True
  | .third, .c => True
  | _, _ => False

theorem every_pair_shares_action :
    (∃ a, threeSafe .first a ∧ threeSafe .second a) ∧
    (∃ a, threeSafe .first a ∧ threeSafe .third a) ∧
    (∃ a, threeSafe .second a ∧ threeSafe .third a) := by
  exact ⟨⟨.b, trivial, trivial⟩,
         ⟨.a, trivial, trivial⟩,
         ⟨.c, trivial, trivial⟩⟩

theorem no_three_way_common_action :
    ¬ ∃ a, threeSafe .first a ∧
      threeSafe .second a ∧ threeSafe .third a := by
  rintro ⟨a, h1, h2, h3⟩
  cases a with
  | a => exact h2
  | b => exact h3
  | c => exact h1

end PhysicalBridges.CathedralInterventionalForcing
