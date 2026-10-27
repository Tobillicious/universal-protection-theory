/-
IR-18: nonnegative scalar safety is often TWO-SIDED. A system that never
overshoots an upper hazard threshold may nevertheless run out of essential
energy, time margin, retained substrate, or a minimum identity-bearing
resource. This theorem guards both ends of a declared physical interval.
Real physical quantities and appropriate interval definitions remain open.
-/
import PhysicalBridges.IRAggregateBudget

namespace PhysicalBridges.IRTwoSidedGuard

/-- Sensor uncertainty and signed (bounded increase/decrease) dynamics.
Nat avoids assumptions about physically negative quantities: the lower
direction is expressed as current <= post + maximum possible loss. -/
theorem guarded_interval_sound
    (observed epsilon increase loss lower upper current post : Nat)
    (hSensorHigh : current ≤ observed + epsilon)
    (hSensorLow : observed ≤ current + epsilon)
    (hIncrease : post ≤ current + increase)
    (hLoss : current ≤ post + loss)
    (hGateHigh : observed + epsilon + increase ≤ upper)
    (hGateLow : lower + epsilon + loss ≤ observed) :
    lower ≤ post ∧ post ≤ upper := by
  omega

/-- Robust two-sided safety for arbitrarily many finite modeled
interactions is conditional on TWO aggregate charge bounds. -/
theorem aggregate_two_sided_guard_sound
    (increaseCharges lossCharges : List Nat)
    (observed epsilon maxIncrease maxLoss lower upper current post : Nat)
    (hUpBudget : increaseCharges.sum ≤ maxIncrease)
    (hDownBudget : lossCharges.sum ≤ maxLoss)
    (hSensorHigh : current ≤ observed + epsilon)
    (hSensorLow : observed ≤ current + epsilon)
    (hUpDynamics : post ≤ current + increaseCharges.sum)
    (hDownDynamics : current ≤ post + lossCharges.sum)
    (hHighGate : observed + epsilon + maxIncrease ≤ upper)
    (hLowGate : lower + epsilon + maxLoss ≤ observed) :
    lower ≤ post ∧ post ≤ upper := by
  have hUp : post ≤ current + maxIncrease := by omega
  have hDown : current ≤ post + maxLoss := by omega
  exact guarded_interval_sound observed epsilon maxIncrease maxLoss lower upper
    current post hSensorHigh hSensorLow hUp hDown hHighGate hLowGate

/-- Upper-hazard protection alone can deplete a resource needed for
continued life, even when every upper-bound sensor premise holds. -/
theorem upper_only_permits_terminal_depletion :
    ∃ (lower upper observed current post loss : Nat),
      lower ≤ current ∧
      current ≤ observed ∧
      observed ≤ current ∧
      post ≤ current ∧
      current ≤ post + loss ∧
      observed ≤ upper ∧
      ¬ lower ≤ post := by
  refine ⟨1, 100, 1, 1, 0, 1, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> decide

/-- If the certified guard's thresholds themselves are mutually
inconsistent, the instrument cannot simultaneously permit an effect:
the correct conclusion is infeasibility, not an invented safe option. -/
theorem impossible_margin_has_no_accepted_observation
    (lower upper epsilon increase loss : Nat)
    (hImpossible : upper < lower + 2 * epsilon + increase + loss) :
    ¬ ∃ observed : Nat,
      lower + epsilon + loss ≤ observed ∧
      observed + epsilon + increase ≤ upper := by
  intro ⟨observed, hLow, hHigh⟩
  omega

#print axioms guarded_interval_sound
#print axioms aggregate_two_sided_guard_sound
#print axioms upper_only_permits_terminal_depletion
#print axioms impossible_margin_has_no_accepted_observation
end PhysicalBridges.IRTwoSidedGuard
