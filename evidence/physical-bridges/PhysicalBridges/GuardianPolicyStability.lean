import Init

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

variable {Policy : Type}

/-- Greatest among an explicitly specified feasible family, in an externally
specified partial order. No moral conclusions are built into this definition. -/
def GreatestFeasible (feasible : Policy → Prop) (precedes : Policy → Policy → Prop) (g : Policy) : Prop :=
  feasible g ∧ ∀ q, feasible q → precedes q g

/-- A greatest feasible policy is stationary under any feasible, nondecreasing
update. In particular, a putative "improvement" cannot strictly improve it. -/
theorem greatest_feasible_fixed_of_nondecreasing
    {feasible : Policy → Prop} {precedes : Policy → Policy → Prop}
    {g : Policy} {update : Policy → Policy}
    (hg : GreatestFeasible feasible precedes g)
    (hantisymm : ∀ a b, precedes a b → precedes b a → a = b)
    (hfeasible : feasible (update g))
    (hnondecreasing : precedes g (update g)) :
    update g = g := by
  exact hantisymm (update g) g (hg.2 (update g) hfeasible) hnondecreasing

/-- A repeated application is stationary as soon as the update fixes the
greatest feasible policy. This is a policy-level theorem, not a Koru iteration. -/
theorem greatest_feasible_update_twice
    {feasible : Policy → Prop} {precedes : Policy → Policy → Prop}
    {g : Policy} {update : Policy → Policy}
    (hg : GreatestFeasible feasible precedes g)
    (hantisymm : ∀ a b, precedes a b → precedes b a → a = b)
    (hfeasible : feasible (update g))
    (hnondecreasing : precedes g (update g)) :
    update (update g) = g := by
  rw [greatest_feasible_fixed_of_nondecreasing hg hantisymm hfeasible hnondecreasing]
  exact greatest_feasible_fixed_of_nondecreasing hg hantisymm hfeasible hnondecreasing

/-- Two greatest feasible policies coincide when the policy comparison is
antisymmetric. The order and feasibility semantics remain external inputs. -/
theorem greatest_feasible_unique
    {feasible : Policy → Prop} {precedes : Policy → Policy → Prop}
    {g h : Policy}
    (hg : GreatestFeasible feasible precedes g)
    (hh : GreatestFeasible feasible precedes h)
    (hantisymm : ∀ a b, precedes a b → precedes b a → a = b) :
    g = h := by
  exact hantisymm g h (hh.2 g hg.1) (hg.2 h hh.1)

/-- No feasible policy can be strictly above a greatest feasible policy.
Here strict improvement means precedence in one direction without the reverse. -/
theorem no_feasible_strict_improvement
    {feasible : Policy → Prop} {precedes : Policy → Policy → Prop}
    {g q : Policy}
    (hg : GreatestFeasible feasible precedes g)
    (hq : feasible q) :
    ¬ (precedes g q ∧ ¬ precedes q g) := by
  intro hstrict
  exact hstrict.2 (hg.2 q hq)

end PhysicalBridges.GuardianPolicyStability
