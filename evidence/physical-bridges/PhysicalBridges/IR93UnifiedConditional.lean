/-!
IR-93D: logical join of the three IR-93 interfaces.
This does not discharge the concrete physical, service or original-feasible
correspondence assumptions.
-/
import PhysicalBridges.IR93GlobalComposition
import PhysicalBridges.IR93BoundedService
import PhysicalBridges.IR93OriginalOrderJoin

namespace PhysicalBridges.IR93D

variable {State Outcome : Type}

theorem unified_conditional
    (c : PhysicalBridges.IR93.Components State)
    (step : State → State → Prop)
    (run : Nat → State)
    (preserves : ∀ s t, step s t →
      PhysicalBridges.IR93.Holds c s → PhysicalBridges.IR93.Holds c t)
    (run_step : ∀ n, step (run n) (run (n + 1)))
    (initial : PhysicalBridges.IR93.Holds c (run 0))
    (feasible : Outcome → Prop)
    (better : Outcome → Outcome → Prop)
    (chosen : Outcome)
    (chosen_feasible : feasible chosen)
    (no_improver : ∀ y, feasible y → ¬ better y chosen)
    (progressBound stallBudget stepDuration elapsedSteps elapsedTime : Nat)
    (step_bound : elapsedSteps ≤ progressBound * (stallBudget + 1))
    (time_bound : elapsedTime ≤ elapsedSteps * stepDuration) :
    (∀ n, PhysicalBridges.IR93.Holds c (run n)) ∧
    PhysicalBridges.IR93Order.Maximal feasible better chosen ∧
    elapsedTime ≤ progressBound * (stallBudget + 1) * stepDuration := by
  refine ⟨?_, ?_, ?_⟩
  · exact PhysicalBridges.IR93.compose_trace c step preserves run run_step initial
  · exact PhysicalBridges.IR93Order.maximal_of_no_improver
      feasible better chosen chosen_feasible no_improver
  · exact PhysicalBridges.IR93Service.bounded_elapsed
      progressBound stallBudget stepDuration elapsedSteps
      step_bound elapsedTime time_bound

end PhysicalBridges.IR93D
