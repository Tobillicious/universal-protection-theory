namespace Snuffy.G1Complete

inductive FaultType where
  | None : FaultType
  | EnvironmentalNoise : FaultType
  | UncertifiedInjection : FaultType
  | BoundaryViolation : FaultType
  deriving Repr, DecidableEq

structure EventNode where
  eventId : Nat
  timestamp : Nat
  fault : FaultType
  isClosed : Bool
  deriving Repr, DecidableEq

abbrev EventTrace := List EventNode

def G1_Compliant (trace : EventTrace) : Prop :=
  ∀ e ∈ trace, e.fault = FaultType.None → e.isClosed = true

theorem g1_append_safe (trace : EventTrace) (e : EventNode)
    (h_trace : G1_Compliant trace)
    (h_safe : e.fault = FaultType.None → e.isClosed = true) :
    G1_Compliant (trace ++ [e]) := by
  intro x hx
  rw [List.mem_append, List.mem_singleton] at hx
  rcases hx with h_in | h_eq
  · exact h_trace x h_in
  · subst h_eq
    exact h_safe

end Snuffy.G1Complete
