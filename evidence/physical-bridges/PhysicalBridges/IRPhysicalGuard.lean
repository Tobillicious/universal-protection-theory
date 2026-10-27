/-
IR-1R: Post-effect physical-guard soundness.
These are arithmetic consequences of explicitly supplied observational,
transition and application-time assumptions. They do NOT assert that a
real sensor, plant, identity criterion, or effect boundary satisfies them.
-/
namespace PhysicalBridges.IRPhysicalGuard

/-- A sufficient post-effect safety condition, including the effect itself.
All values are conservative nonnegative integral upper bounds in a common unit. -/
theorem post_effect_guard_sound
    (observed epsilon drift jump threshold actualSample actualAfter : Nat)
    (hObservation : actualSample ≤ observed + epsilon)
    (hEvolution : actualAfter ≤ actualSample + drift + jump)
    (hGate : observed + epsilon + drift + jump ≤ threshold) :
    actualAfter ≤ threshold := by
  omega

/-- A guard that omits the admitted effect's jump can accept an unsafe step.
This is a countermodel to the uncorrected pre-effect-only claim. -/
theorem omitted_jump_counterexample :
    ∃ observed drift jump threshold actualSample actualAfter : Nat,
      actualSample ≤ observed ∧
      actualAfter ≤ actualSample + drift + jump ∧
      observed + drift ≤ threshold ∧
      ¬ actualAfter ≤ threshold := by
  refine ⟨0, 0, 1, 0, 0, 1, ?_, ?_, ?_, ?_⟩ <;> decide

/-- Two properly guarded consecutive actions preserve the same threshold. -/
theorem sequential_post_effect_safety
    (threshold before middle after : Nat)
    (firstBound : middle ≤ threshold)
    (secondBound : after ≤ threshold) :
    middle ≤ threshold ∧ after ≤ threshold :=
  ⟨firstBound, secondBound⟩

#print axioms post_effect_guard_sound
#print axioms omitted_jump_counterexample
#print axioms sequential_post_effect_safety
end PhysicalBridges.IRPhysicalGuard
