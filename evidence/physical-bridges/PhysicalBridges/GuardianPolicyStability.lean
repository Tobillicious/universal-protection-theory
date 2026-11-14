import Mathlib.Order.Basic

/-!
# Guardian policy stability — a precise fixed-point kernel lemma

This theorem concerns **policies in a partial order**, not the author's Complete
Koru (a whole-relational physical node/correspondence, NOT a unary map), and not
a theorem that the universe or all agents necessarily implement G.

The hypotheses are independently auditable: the policy is feasible, dominates
every feasible alternative, and the update preserves feasibility and does not
lower the policy in the specified order. The original six-X3 semantics and
physical implementation of that order are NOT derived here.

It is a mathematical brick suitable for *conditional* G policy stability;
it must not be used to claim the universal physical Guardian fixed point.
-/

namespace PhysicalBridges.GuardianPolicyStability

variable {Policy : Type*} [PartialOrder Policy]

/-- Greatest among an explicitly specified feasible family, in an externally
specified partial order. No moral conclusions are built into this definition. -/
def GreatestFeasible (feasible : Policy → Prop) (g : Policy) : Prop :=
  feasible g ∧ ∀ q, feasible q → q ≤ g

/-- A greatest feasible policy is stationary under any feasible, nondecreasing
update. In particular, a putative "improvement" cannot strictly improve it. -/
theorem greatest_feasible_fixed_of_nondecreasing
    {feasible : Policy → Prop} {g : Policy} {update : Policy → Policy}
    (hg : GreatestFeasible feasible g)
    (hfeasible : feasible (update g))
    (hnondecreasing : g ≤ update g) :
    update g = g := by
  apply le_antisymm
  · exact hg.2 (update g) hfeasible
  · exact hnondecreasing

/-- Every finite iterate of a feasible, nondecreasing policy update leaves a
greatest feasible starting policy unchanged, provided these two properties
hold for every feasible input. -/
theorem greatest_feasible_fixed_at_every_iteration
    {feasible : Policy → Prop} {g : Policy} {update : Policy → Policy}
    (hg : GreatestFeasible feasible g)
    (hfeasible : ∀ p, feasible p → feasible (update p))
    (hnondecreasing : ∀ p, feasible p → p ≤ update p) :
    ∀ n : Nat, (update^[n]) g = g := by
  have hfixed : update g = g :=
    greatest_feasible_fixed_of_nondecreasing hg (hfeasible g hg.1)
      (hnondecreasing g hg.1)
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simp [Function.iterate_succ_apply', ih, hfixed]

end PhysicalBridges.GuardianPolicyStability
