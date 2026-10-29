import Snuffy.IR105AuthorizationIndependence

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR108ObservationObstruction.lean` at main `740abbb` (sha256 `f14dd503e8b6247bd80c74c845d82fcfa2183542ffcf9291f88a85dec540a5a5`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

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
