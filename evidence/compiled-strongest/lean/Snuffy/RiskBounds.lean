import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-! Correct finite weighted Markov bound and correlated-event bound.
The work-tail control distinguishes large exp(-beta W) from small values. -/
namespace GeminiThirteenRisk
noncomputable section
open scoped BigOperators

theorem weighted_markov {I : Type*} [Fintype I] (event : Finset I)
    (p z : I → ℝ) (threshold : ℝ)
    (positive : 0 < threshold) (pNonnegative : ∀ i, 0 ≤ p i)
    (zNonnegative : ∀ i, 0 ≤ z i)
    (moment : ∑ i, p i*z i=1)
    (largeOnEvent : ∀ i ∈ event, threshold ≤ z i) :
    ∑ i ∈ event, p i ≤ 1/threshold := by
  have weighted : threshold*(∑ i ∈ event, p i) ≤ ∑ i ∈ event, p i*z i := by
    rw [Finset.mul_sum]
    apply Finset.sum_le_sum
    intro i hi
    simpa only [mul_comm threshold] using
      mul_le_mul_of_nonneg_left (largeOnEvent i hi) (pNonnegative i)
  have total : (∑ i ∈ event, p i*z i) ≤ ∑ i, p i*z i :=
    Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ event)
      (fun i _ _ => mul_nonneg (pNonnegative i) (zNonnegative i))
  apply (le_div_iff₀ positive).mpr
  rw [moment] at total
  nlinarith

theorem event_mass_mono {I : Type*} (small large : Finset I) (p : I → ℝ)
    (subset : small ⊆ large) (nonnegative : ∀ i, 0 ≤ p i) :
    (∑ i ∈ small, p i) ≤ ∑ i ∈ large, p i :=
  Finset.sum_le_sum_of_subset_of_nonneg subset (fun i _ _ => nonnegative i)

theorem intersection_mass_le_each {I : Type*} [DecidableEq I]
    (first second : Finset I) (p : I → ℝ) (nonnegative : ∀ i, 0 ≤ p i) :
    (∑ i ∈ first∩second, p i) ≤
      min (∑ i ∈ first, p i) (∑ i ∈ second, p i) := by
  apply le_min
  · exact event_mass_mono _ _ p Finset.inter_subset_left nonnegative
  · exact event_mass_mono _ _ p Finset.inter_subset_right nonnegative

/-- Z=exp(-beta W_diss). E[Z]=1, but the event Z=1/2 has
probability 3/4, greater than 1/2. Thus the claimed positive-work
tail bound does not follow from Jarzynski's exponential moment. -/
theorem positive_work_tail_control :
    (3/4:ℝ)+1/4=1 ∧
    (3/4:ℝ)*(1/2)+(1/4)*(5/2)=1 ∧
    (1/2:ℝ)<3/4 := by norm_num

/-- Local conditional bounds compose without an independence premise.
Here joint n is the probability of the first n events; the physical
model supplies the history-conditional one-step upper bounds. -/
theorem dependent_chain_bound (joint bound : Nat → ℝ)
    (initial : joint 0 ≤ 1) (nonnegative : ∀ i, 0 ≤ bound i)
    (localBound : ∀ i, joint (i+1) ≤ bound i*joint i) (n : Nat) :
    joint n ≤ ∏ i ∈ Finset.range n, bound i := by
  induction n with
  | zero => simpa using initial
  | succ n ih =>
      calc
        joint (n+1) ≤ bound n*joint n := localBound n
        _ ≤ bound n*(∏ i ∈ Finset.range n, bound i) := mul_le_mul_of_nonneg_left ih (nonnegative n)
        _ = ∏ i ∈ Finset.range (n+1), bound i := by rw [Finset.prod_range_succ,mul_comm]

end
end GeminiThirteenRisk

