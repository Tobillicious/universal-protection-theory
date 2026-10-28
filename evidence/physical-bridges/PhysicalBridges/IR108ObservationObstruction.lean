import PhysicalBridges.IR105AuthorizationIndependence

/-!
IR-108: recovered Codex/Gemini gauntlet question.
An observation-equivalence class can contain two states with disjoint
safe-action sets. No observation-only controller can preserve both.
This is a finite epistemic obstruction, not a full BCRD countermodel.
-/
namespace PhysicalBridges.IR108

inductive HiddenState where
  | left
  | right
  deriving DecidableEq

inductive Action where
  | chooseLeft
  | chooseRight
  deriving DecidableEq

def observation (_ : HiddenState) : Bool := true

def Safe : HiddenState → Action → Prop
  | .left, .chooseLeft => True
  | .right, .chooseRight => True
  | _, _ => False

theorem same_observation :
    observation .left = observation .right := rfl

theorem each_state_has_safe_action :
    ∀ s : HiddenState, ∃ a : Action, Safe s a := by
  intro s
  cases s with
  | left => exact ⟨.chooseLeft, trivial⟩
  | right => exact ⟨.chooseRight, trivial⟩

theorem no_common_safe_action :
    ¬ ∃ a : Action, Safe .left a ∧ Safe .right a := by
  intro h
  rcases h with ⟨a, hl, hr⟩
  cases a with
  | chooseLeft => exact hr
  | chooseRight => exact hl

theorem no_observation_only_safe_policy :
    ¬ ∃ policy : Bool → Action,
      ∀ s : HiddenState, Safe s (policy (observation s)) := by
  intro h
  rcases h with ⟨policy, hp⟩
  apply no_common_safe_action
  exact ⟨policy true, hp .left, hp .right⟩

end PhysicalBridges.IR108
