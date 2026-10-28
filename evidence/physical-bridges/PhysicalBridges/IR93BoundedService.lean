/-! IR-93B: abstract deadline arithmetic; source-level service adapters pending. -/
namespace PhysicalBridges.IR93Service

/-- A rank budget bounds the number of progress steps; a per-progress
stall budget bounds total transitions. These numerical certificates must
be derived from an actual scheduler and rank in downstream adapters. -/
theorem bounded_elapsed
    (progressBound stallPerProgress stepDuration : Nat)
    (elapsedSteps : Nat)
    (hsteps : elapsedSteps ≤ progressBound * (stallPerProgress + 1))
    (elapsedTime : Nat)
    (htime : elapsedTime ≤ elapsedSteps * stepDuration) :
    elapsedTime ≤ progressBound * (stallPerProgress + 1) * stepDuration := by
  calc
    elapsedTime ≤ elapsedSteps * stepDuration := htime
    _ ≤ (progressBound * (stallPerProgress + 1)) * stepDuration :=
      Nat.mul_le_mul_right stepDuration hsteps
    _ = progressBound * (stallPerProgress + 1) * stepDuration := rfl

/-- A completion receipt is not physical delivery without a refinement
predicate; the implication is deliberately required as an argument. -/
theorem receipt_to_delivery {Receipt Delivered : Prop}
    (refines : Receipt → Delivered) (receipt : Receipt) : Delivered :=
  refines receipt

end PhysicalBridges.IR93Service
