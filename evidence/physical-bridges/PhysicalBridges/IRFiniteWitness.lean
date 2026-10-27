/-
IR-16: a concrete finite transition system with an EXPLICITLY evaluated
nonempty stabilized viability kernel. Unlike IR-9 and IR-14's generic
rank/fixed-point contracts, no abstract stability parameter is used here.
This is a finite *test model*, not a physical plant certificate.
-/
import PhysicalBridges.IRKernelConstruction

namespace PhysicalBridges.IRFiniteWitness

inductive Place
  | origin
  | fragile
  | failed
  deriving DecidableEq, Repr

def safe : Place → Prop
  | .failed => False
  | _ => True

/-- At origin, choose false to stay at origin, true to visit a fragile
state. From fragile every action enters failed on the next step. -/
def step : Place → Bool → Unit → Place
  | .origin, false, _ => .origin
  | .origin, true, _ => .fragile
  | .fragile, _, _ => .failed
  | .failed, _, _ => .failed

/-- The fragile state is safe NOW, but is not one-step viable. -/
theorem fragile_not_viable :
    ¬ IRKernelConstruction.Approx step safe 1 .fragile := by
  intro h
  change safe .fragile ∧
    (∃ a : Bool, ∀ d : Unit, safe (step .fragile a d)) at h
  obtain ⟨_, a, ha⟩ := h
  have bad : safe .failed := by
    simpa [step] using ha ()
  exact bad

theorem fragile_safe_not_viable :
    safe .fragile ∧
    ¬ IRKernelConstruction.Approx step safe 1 .fragile :=
  ⟨trivial, fragile_not_viable⟩

/-- The origin is a genuinely viable member of the computed kernel. -/
theorem kernel_nonempty :
    IRKernelConstruction.Approx step safe 1 .origin := by
  change safe .origin ∧
    (∃ a : Bool, ∀ d : Unit, safe (step .origin a d))
  refine ⟨trivial, false, ?_⟩
  intro d
  cases d
  trivial

theorem failed_not_viable :
    ¬ IRKernelConstruction.Approx step safe 1 .failed := by
  intro h
  change safe .failed ∧
    (∃ a : Bool, ∀ d : Unit, safe (step .failed a d)) at h
  exact h.1

/-- Explicit calculation of a nonempty fixed point, no assumed stability. -/
theorem certified_stable_at_one :
    ∀ s : Place,
      IRKernelConstruction.Prune step
        (IRKernelConstruction.Approx step safe 1) s ↔
      IRKernelConstruction.Approx step safe 1 s := by
  intro s
  cases s with
  | origin =>
      constructor
      · intro h; exact h.1
      · intro h
        refine ⟨h, false, ?_⟩
        intro d
        cases d
        exact h
  | fragile =>
      constructor
      · intro h; exact False.elim (fragile_not_viable h.1)
      · intro h; exact False.elim (fragile_not_viable h)
  | failed =>
      constructor
      · intro h; exact False.elim (failed_not_viable h.1)
      · intro h; exact False.elim (failed_not_viable h)

/-- In this explicit model the calculated kernel is the GREATEST safe,
robustly invariant state subset. Derived from the general IR-9 theorem. -/
theorem computed_kernel_greatest :
    IRKernelConstruction.Inside
      (IRKernelConstruction.Approx step safe 1) safe ∧
    (∀ s, IRKernelConstruction.Approx step safe 1 s →
      ∃ a : Bool, ∀ d : Unit,
        IRKernelConstruction.Approx step safe 1 (step s a d)) ∧
    (∀ I : Place → Prop,
      IRKernelConstruction.Inside I safe →
      (∀ s, I s → ∃ a : Bool, ∀ d : Unit, I (step s a d)) →
      IRKernelConstruction.Inside I
        (IRKernelConstruction.Approx step safe 1)) :=
  IRKernelConstruction.stabilised_approx_is_greatest_invariant
    step safe 1 certified_stable_at_one

/-- The same concrete witness has a policy safe along every finite
disturbance trace. There is no claim about unknown external dynamics. -/
theorem computed_kernel_policy_exists :
    ∃ policy : Place → Bool,
      ∀ trace s,
        IRKernelConstruction.Approx step safe 1 s →
        safe (PhysicalBridges.IRViability.run step policy s trace) :=
  IRKernelConstruction.stable_kernel_safe_at_every_finite_trace
    step safe 1 certified_stable_at_one

#print axioms fragile_safe_not_viable
#print axioms kernel_nonempty
#print axioms certified_stable_at_one
#print axioms computed_kernel_greatest
#print axioms computed_kernel_policy_exists
end PhysicalBridges.IRFiniteWitness
