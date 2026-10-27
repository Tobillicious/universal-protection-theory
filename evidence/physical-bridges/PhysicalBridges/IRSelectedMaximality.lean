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

/-- Closed finite counterexample: two incomparable full maxima.
Retaining only one can preserve FULL maximality without cofinality:
the excluded option is neither strictly better nor strictly worse. -/
def incomparable (choice item : Bool) : Prop := choice = item

theorem cofinality_is_not_necessary :
    UPTExist.LexAlignedL (fun _ : Bool => True)
      ([incomparable] : List (Bool → Bool → Prop)) true ∧
    ¬ IRSafeMaximality.Cofinal
      (fun _ : Bool => True) [true]
      ([incomparable] : List (Bool → Bool → Prop)) := by
  decide

/-- The prior warning is real in the opposite direction too: a safe-menu
maximum can fail to be globally maximal when a feasible excluded
candidate strictly improves on it. -/
def dominates (choice item : Bool) : Prop := choice = true ∧ item = true

theorem local_maximum_need_not_be_global :
    UPTExist.LexAlignedL (fun c : Bool => c ∈ [false])
      ([dominates] : List (Bool → Bool → Prop)) false ∧
    ¬ UPTExist.LexAlignedL (fun _ : Bool => True)
      ([dominates] : List (Bool → Bool → Prop)) false := by
  decide

#print axioms selected_safety_maximal_lifts_globally
#print axioms cofinal_implies_selected_no_outside_improver
#print axioms selected_realisation_suffices
#print axioms cofinality_is_not_necessary
#print axioms local_maximum_need_not_be_global
end PhysicalBridges.IRSelectedMaximality
