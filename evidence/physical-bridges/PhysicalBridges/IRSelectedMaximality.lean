/-
IR-17: weaken an unnecessarily strong IR-7 / IR-10 global maximality
interface without changing the original UPT order or original feasible set.

Cofinality of the WHOLE safe menu is SUFFICIENT but not NECESSARY for
the selected safe policy to be globally maximal. The exact missing
condition is: the selected outcome has no excluded feasible improver.
-/
import PhysicalBridges.IRSafeMaximality

namespace PhysicalBridges.IRSelectedMaximality
universe u v
variable {P : Type u} {O : Type v}

def NoExcludedImprover
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O) (selected : O) : Prop :=
  ∀ other, full other → other ∉ safe →
    ¬ UPTExist.LexBetter keys selected other

/-- Only improvement upon the SELECTED output needs checking; insisting
that every excluded feasible candidate be dominated by something inside
the safety menu is an unnecessary stronger test. -/
theorem selected_safety_maximal_lifts_globally
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O)
    (included : ∀ o, o ∈ safe → full o)
    (selected : O)
    (hLocal : UPTExist.LexAlignedL (fun o => o ∈ safe) keys selected)
    (hNoOutside : NoExcludedImprover keys full safe selected) :
    UPTExist.LexAlignedL full keys selected := by
  refine ⟨included selected hLocal.1, ?_⟩
  intro other feasible better
  by_cases hin : other ∈ safe
  · exact hLocal.2 other hin better
  · exact hNoOutside other feasible hin better

/-- Original cofinality hypothesis is one way to discharge the weaker
selected-level exclusion test; the reverse need not hold. -/
theorem cofinal_implies_selected_no_outside_improver
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O) (selected : O)
    (hLocal : UPTExist.LexAlignedL (fun o => o ∈ safe) keys selected)
    (hCofinal : IRSafeMaximality.Cofinal full safe keys) :
    NoExcludedImprover keys full safe selected := by
  intro other feasible outside better
  obtain ⟨witness, hw, hdom⟩ := hCofinal other feasible outside
  have hb := UPTExist.lex_trans keys selected other witness better hdom
  exact hLocal.2 witness hw hb

/-- A selected outcome can have a REALISING observation-uniform policy
without every candidate in the menu admitting such a policy. This is
sufficient to connect this selected option to UPT global maximality. -/
theorem selected_realisation_suffices
    {Obs : Type} {A : Type}
    (keys : List (O → P → Prop)) (full : O → Prop) (safe : List O)
    (included : ∀ o, o ∈ safe → full o)
    (selected : O) (policy : Obs → A)
    (realises : (Obs → A) → O → Prop)
    (hLocal : UPTExist.LexAlignedL (fun o => o ∈ safe) keys selected)
    (hNoOutside : NoExcludedImprover keys full safe selected)
    (hRealises : realises policy selected) :
    realises policy selected ∧
      UPTExist.LexAlignedL full keys selected :=
  ⟨hRealises, selected_safety_maximal_lifts_globally
    keys full safe included selected hLocal hNoOutside⟩

/-- Two distinct Bool singleton-retention sets are incomparable. -/
def incomparable (choice item : Bool) : Prop := choice = item

private theorem incomparable_not_better (a b : Bool) (hne : a ≠ b) :
    ¬ UPTExist.LexBetter
      ([incomparable] : List (Bool → Bool → Prop)) a b := by
  have noSub : ¬ UPTExist.Sub (incomparable a) (incomparable b) := by
    intro h
    have hb : b = a := h a rfl
    exact hne hb.symm
  intro hBetter
  cases hBetter with
  | inl hs => exact noSub hs.1
  | inr hs => exact noSub hs.1.1

/-- Global maximality survives omission of an INCOMPARABLE optimum, so
global cofinality is sufficient but NOT logically necessary. -/
theorem cofinality_is_not_necessary :
    UPTExist.LexAlignedL (fun _ : Bool => True)
      ([incomparable] : List (Bool → Bool → Prop)) true ∧
    ¬ IRSafeMaximality.Cofinal
      (fun _ : Bool => True) [true]
      ([incomparable] : List (Bool → Bool → Prop)) := by
  constructor
  · refine ⟨trivial, ?_⟩
    intro p hp hBetter
    cases p with
    | false =>
        exact incomparable_not_better true false (by decide) hBetter
    | true =>
        exact UPTExist.lex_irrefl _ true hBetter
  · intro hCofinal
    have outside : false ∉ ([true] : List Bool) := by decide
    obtain ⟨q, hq, hBetter⟩ := hCofinal false trivial outside
    have hqTrue : q = true := by simpa using hq
    subst q
    exact incomparable_not_better false true (by decide) hBetter

/-- A singleton safety menu may exclude a strictly better full-feasible
outcome. Then being safe-menu maximal is not full-UPT maximal. -/
def dominates (choice item : Bool) : Prop := choice = true ∧ item = true

private theorem excluded_strict_improvement :
    UPTExist.LexBetter ([dominates] : List (Bool → Bool → Prop))
      false true := by
  apply Or.inl
  constructor
  · intro x hx
    have impossible : false = true := hx.1
    exact False.elim ((by decide : false ≠ true) impossible)
  · intro hBack
    have hx := hBack true ⟨rfl, rfl⟩
    exact (by decide : false ≠ true) hx.1

theorem local_maximum_need_not_be_global :
    UPTExist.LexAlignedL (fun c : Bool => c ∈ [false])
      ([dominates] : List (Bool → Bool → Prop)) false ∧
    ¬ UPTExist.LexAlignedL (fun _ : Bool => True)
      ([dominates] : List (Bool → Bool → Prop)) false := by
  constructor
  · refine ⟨by simp, ?_⟩
    intro p hp hBetter
    have hpFalse : p = false := by simpa using hp
    subst p
    exact UPTExist.lex_irrefl _ false hBetter
  · intro hGlobal
    exact hGlobal.2 true trivial excluded_strict_improvement

#print axioms selected_safety_maximal_lifts_globally
#print axioms cofinal_implies_selected_no_outside_improver
#print axioms selected_realisation_suffices
#print axioms cofinality_is_not_necessary
#print axioms local_maximum_need_not_be_global
end PhysicalBridges.IRSelectedMaximality
