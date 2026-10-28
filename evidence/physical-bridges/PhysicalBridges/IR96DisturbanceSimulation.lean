import PhysicalBridges.IR95SharedStateRefinement

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
        safetyReflects wn q hrel' (sourcePreserves wm wn hsrc hsafe)⟩

end PhysicalBridges.IR96
