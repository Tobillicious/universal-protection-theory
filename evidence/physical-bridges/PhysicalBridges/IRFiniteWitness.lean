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
theorem fragile_safe_not_viable :
    safe .fragile ∧
    ¬ IRKernelConstruction.Approx step safe 1 .fragile := by
  decide

/-- The origin is a genuinely viable member of the computed kernel. -/
theorem kernel_nonempty :
    IRKernelConstruction.Approx step safe 1 .origin := by
  decide

/-- A real, finite witness that one pruning step has reached a fixed point.
No 'stable' parameter is assumed in this example. -/
theorem certified_stable_at_one :
    ∀ s : Place,
      IRKernelConstruction.Prune step
        (IRKernelConstruction.Approx step safe 1) s ↔
      IRKernelConstruction.Approx step safe 1 s := by
  intro s
  cases s <;> decide

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
