/-!
IR-93A: A generic global transition composition kernel.

This module proves only the logical composition step. Concrete adapters to
IR-92, IR-49 and physical refinements remain explicit proof obligations.
-/
namespace PhysicalBridges.IR93

variable {State : Type}

structure Components (State : Type) where
  host : State → Prop
  physical : State → Prop
  journal : State → Prop
  escrow : State → Prop
  authority : State → Prop
  serviceAccounting : State → Prop

def Holds (c : Components State) (s : State) : Prop :=
  c.host s ∧ c.physical s ∧ c.journal s ∧
  c.escrow s ∧ c.authority s ∧ c.serviceAccounting s

theorem compose_step (c : Components State) (step : State → State → Prop)
    (preserves : ∀ s t, step s t → Holds c s → Holds c t)
    {s t : State} (hst : step s t) (hs : Holds c s) :
    Holds c t := preserves s t hst hs

theorem compose_trace (c : Components State) (step : State → State → Prop)
    (preserves : ∀ s t, step s t → Holds c s → Holds c t)
    (run : Nat → State)
    (run_step : ∀ n, step (run n) (run (n + 1)))
    (initial : Holds c (run 0)) :
    ∀ n, Holds c (run n) := by
  intro n
  induction n with
  | zero => exact initial
  | succ n ih => exact preserves (run n) (run (n + 1)) (run_step n) ih

/-- A transition-class cover and preservation per class imply global preservation. -/
theorem covered_step (c : Components State)
    (step : State → State → Prop) (classes : Type)
    (classStep : classes → State → State → Prop)
    (covered : ∀ s t, step s t → ∃ k, classStep k s t)
    (each_preserves : ∀ k s t, classStep k s t → Holds c s → Holds c t) :
    ∀ s t, step s t → Holds c s → Holds c t := by
  intro s t hst hs
  obtain ⟨k, hk⟩ := covered s t hst
  exact each_preserves k s t hk hs

end PhysicalBridges.IR93
