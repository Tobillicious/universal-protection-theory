/-
IR-2: Finite-event aggregate interference envelope.
There is deliberately NO bound on the number of agents, channels, or events.
The *sum of consequential influence* is required to satisfy a shared bound.
Physical coverage, accumulation and non-Zeno behaviour are NOT proved here.
-/
namespace PhysicalBridges.IRAggregateBudget

/-- If aggregate interference is charged within a common budget, safety does
not depend on the number of contributing events.  The event list is finite. -/
theorem aggregate_post_effect_safe
    (influences : List Nat)
    (observed epsilon drift jump budget threshold sample post : Nat)
    (hInfluence : influences.sum ≤ budget)
    (hObserved : sample ≤ observed + epsilon)
    (hEvolution : post ≤ sample + drift + influences.sum + jump)
    (hGate : observed + epsilon + drift + budget + jump ≤ threshold) :
    post ≤ threshold := by
  omega

/-- Conservation of a durable account bounds the accumulated spent charge. -/
theorem escrow_spent_bounded
    (free reserved spent initial : Nat)
    (hConserved : free + reserved + spent = initial) :
    spent ≤ initial := by
  omega

/-- When physical influence is no greater than the debit recorded for it,
an escrow invariant supplies the aggregate bound for the admitted events. -/
theorem charged_events_bounded
    (charges : List Nat) (free reserved spent initial : Nat)
    (hCharged : charges.sum ≤ spent)
    (hConserved : free + reserved + spent = initial) :
    charges.sum ≤ initial := by
  omega

/-- Merely asserting each event has a finite natural-number impact supplies
no uniform cap. A single arbitrarily large event is a countermodel. -/
theorem no_automatic_budget :
    ∀ budget : Nat, ∃ influences : List Nat, budget < influences.sum := by
  intro budget
  refine ⟨[budget + 1], ?_⟩
  simp

#print axioms aggregate_post_effect_safe
#print axioms escrow_spent_bounded
#print axioms charged_events_bounded
#print axioms no_automatic_budget
end PhysicalBridges.IRAggregateBudget
