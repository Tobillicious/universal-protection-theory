import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Explicit comparison results supporting Gemini X3/X5/X7, D1/D2/D4, Joint 4,
and C1. Utilities, probabilities and cost models are named rather than inferred
from an agent's intelligence or from termination alone.
-/
namespace UPTDecisionAndScale
open scoped BigOperators

theorem weighted_outcome_dominance {I : Type} [Fintype I]
    (weight kept rival : I → ℝ) (positive : ∀ i, 0 ≤ weight i)
    (dominates : ∀ i, rival i ≤ kept i) :
    (∑ i, weight i*rival i) ≤ ∑ i, weight i*kept i := by
  exact Finset.sum_le_sum (fun i _ => mul_le_mul_of_nonneg_left (dominates i) (positive i))

/-- A preservation option is instrumentally preferable when its survival gain
times continuation value exceeds its complete maintenance overhead. -/
theorem continuation_gain_pays_overhead
    (survivalKept survivalRival continuation overhead : ℝ)
    (_positiveValue : 0 < continuation)
    (advantage : overhead < (survivalKept-survivalRival)*continuation) :
    survivalRival*continuation < survivalKept*continuation-overhead := by nlinarith

theorem finite_branch_payoff_bound {I : Type} [Fintype I]
    (probability payoff : I → ℝ) (ceiling : ℝ)
    (positive : ∀ i, 0 ≤ probability i) (normalized : ∑ i, probability i = 1)
    (bounded : ∀ i, payoff i ≤ ceiling) :
    (∑ i, probability i*payoff i) ≤ ceiling := by
  calc (∑ i, probability i*payoff i) ≤ ∑ i, probability i*ceiling :=
      Finset.sum_le_sum (fun i _ => mul_le_mul_of_nonneg_left (bounded i) (positive i))
    _ = ceiling := by rw [← Finset.sum_mul, normalized, one_mul]

/-- Finite-duration reward cannot stay positive as duration vanishes under a
uniform finite reward-rate bound. This is the explicit linear estimate. -/
theorem duration_reward_bound (duration rate epsilon reward : ℝ)
    (ratePositive : 0 < rate) (durationSmall : duration ≤ epsilon/rate)
    (metered : reward ≤ rate*duration) : reward ≤ epsilon := by
  have h := (le_div_iff₀ ratePositive).mp durationSmall
  nlinarith

theorem efficiency_gain_pays_cost (saved overhead legacyYield : ℝ)
    (gains : overhead < saved) : legacyYield < legacyYield+saved-overhead := by linarith

/-- A pointwise strictly dominant action is a best response to every mixture of
opponent actions with normalized nonnegative probabilities. -/
theorem dominant_action_survives_mixture {I : Type} [Fintype I]
    (probability preferred rival : I → ℝ) (margin : ℝ)
    (positive : ∀ i, 0 ≤ probability i) (normalized : ∑ i, probability i = 1)
    (gap : ∀ i, rival i+margin ≤ preferred i) :
    (∑ i, probability i*rival i)+margin ≤ ∑ i, probability i*preferred i := by
  have h := weighted_outcome_dominance probability preferred (fun i => rival i+margin) positive gap
  simpa [mul_add, Finset.sum_add_distrib, ← Finset.sum_mul, normalized] using h

/-- Bounded work per node and per edge gives a linear operation count on a
bounded-degree graph. The bounds must describe the actual verifier algorithm. -/
theorem local_verifier_cost (nodes edges degree nodeCost edgeCost : Nat)
    (sparse : edges ≤ degree*nodes) :
    nodes*nodeCost+edges*edgeCost ≤ nodes*(nodeCost+degree*edgeCost) := by
  nlinarith [Nat.mul_le_mul_right edgeCost sparse]

/-- A simple convex allocation objective: squared deviations exactly measure
the excess cost above the even allocation. Strictly positive scale makes the
equal split the unique optimum. The physical cost law is stated explicitly. -/
theorem two_provider_unique_balanced_cost (x total base scale : ℝ) (hs : 0 < scale) :
    base+scale*(total^2/2) ≤ base+scale*(x^2+(total-x)^2) ∧
    (base+scale*(x^2+(total-x)^2)=base+scale*(total^2/2) ↔ x=total/2) := by
  have identity : x^2+(total-x)^2 = total^2/2+2*(x-total/2)^2 := by ring
  rw [identity]
  constructor
  · nlinarith [sq_nonneg (x-total/2)]
  · constructor
    · intro equal
      have productZero : scale*(x-total/2)^2=0 := by nlinarith only [equal]
      have squareZero := (mul_eq_zero.mp productZero).resolve_left (ne_of_gt hs)
      nlinarith only [squareZero]
    · intro equal
      rw [equal]
      ring

end UPTDecisionAndScale

