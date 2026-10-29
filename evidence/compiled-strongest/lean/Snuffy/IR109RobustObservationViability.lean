import Snuffy.IR108ObservationObstruction

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR109RobustObservationViability.lean` at main `740abbb` (sha256 `72eadbfc9e02d6ac00129532a45121ba793e9ca6a5c0df58b35042a9ec611b85`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-109: robust observation-class safety and inductive viability.
A controller must choose an action safe for every state compatible
with its observation, and the successor must remain viable.
This is a conditional abstract control theorem, not a derivation
of physical sensing or actuator completeness from BCRD.
-/
namespace PhysicalBridges.IR109

universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

def RobustAt (observe : S → O) (safe : S → A → Prop)
    (o : O) (a : A) : Prop :=
  ∀ s, observe s = o → safe s a

theorem robust_policy_safe
    (observe : S → O) (safe : S → A → Prop)
    (policy : O → A)
    (hRobust : ∀ o, RobustAt observe safe o (policy o))
    (s : S) : safe s (policy (observe s)) :=
  hRobust (observe s) s rfl

def ViableStep (step : S → A → S → Prop)
    (viable : S → Prop) (s : S) (a : A) : Prop :=
  ∀ t, step s a t → viable t

theorem robust_viability_step
    (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) (policy : O → A)
    (hRobust : ∀ o s, observe s = o → viable s →
      ViableStep step viable s (policy o))
    {s t : S} (hs : viable s)
    (hstep : step s (policy (observe s)) t) :
    viable t :=
  hRobust (observe s) s rfl hs t hstep

inductive PolicyReach (step : S → A → S → Prop)
    (policy : O → A) (observe : S → O) : S → S → Prop where
  | refl (s : S) : PolicyReach step policy observe s s
  | tail {s t v : S} :
      PolicyReach step policy observe s t →
      step t (policy (observe t)) v →
      PolicyReach step policy observe s v

theorem robust_viability_all_finite_traces
    (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) (policy : O → A)
    (hRobust : ∀ o s, observe s = o → viable s →
      ViableStep step viable s (policy o))
    {s t : S} (hTrace : PolicyReach step policy observe s t)
    (hs : viable s) : viable t := by
  induction hTrace with
  | refl => exact hs
  | tail earlier edge ih =>
      exact robust_viability_step observe step viable policy
        hRobust ih edge

end PhysicalBridges.IR109
