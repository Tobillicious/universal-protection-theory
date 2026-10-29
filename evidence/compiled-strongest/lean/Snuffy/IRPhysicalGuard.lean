
/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRPhysicalGuard.lean` at main `740abbb` (sha256 `8477d78f13013e12fe89a1239fa5ef8bf3bcf0c4254a8e08bf07996ae3fa3714`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
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

end PhysicalBridges.IRPhysicalGuard
