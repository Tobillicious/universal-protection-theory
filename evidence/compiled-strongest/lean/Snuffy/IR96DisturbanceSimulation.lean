import Snuffy.IR95SharedStateRefinement

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR96DisturbanceSimulation.lean` at main `740abbb` (sha256 `568aab46deaaa56022363c3a9b2be6905f7a66137050e7f1c80b7925368028b1`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-! IR-96: disturbance-aware forward simulation for modeled physical steps.
All simulation and safety-reflection premises remain explicit. -/
namespace PhysicalBridges.IR96

universe u v
variable {W : Type u} {P : Type v}

inductive Reach (step : P → P → Prop) : P → P → Prop where
  | refl (p : P) : Reach step p p
  | tail {p q r : P} : Reach step p q → step q r → Reach step p r

theorem robust_reach
    (R : W → P → Prop)
    (sourceStep : W → W → Prop)
    (physicalStep : P → P → Prop)
    (matchPhysical : ∀ w p p',
      R w p → physicalStep p p' →
      ∃ w', sourceStep w w' ∧ R w' p')
    (safeSource : W → Prop)
    (safePhysical : P → Prop)
    (sourcePreserves : ∀ w w',
      sourceStep w w' → safeSource w → safeSource w')
    (safetyReflects : ∀ w p,
      R w p → safeSource w → safePhysical p)
    (w : W) (p q : P)
    (initialRelation : R w p)
    (initialSafety : safeSource w)
    (execution : Reach physicalStep p q) :
    ∃ w', R w' q ∧ safeSource w' ∧ safePhysical q := by
  induction execution generalizing w with
  | refl =>
      exact ⟨w, initialRelation, initialSafety,
        safetyReflects w p initialRelation initialSafety⟩
  | tail earlier step ih =>
      obtain ⟨wm, hrel, hsafe, _⟩ := ih w initialRelation initialSafety
      obtain ⟨wn, hsrc, hrel'⟩ :=
        matchPhysical wm _ _ hrel step
      exact ⟨wn, hrel', sourcePreserves wm wn hsrc hsafe,
        safetyReflects wn _ hrel' (sourcePreserves wm wn hsrc hsafe)⟩

end PhysicalBridges.IR96
