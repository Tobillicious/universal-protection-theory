import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith

/-! Finite TOTAL energy bounds paid transition count. It does not identify
budget exhaustion with successful convergence. Residual bounds are proved
on the actual metric/update map, with pre/post update indexing explicit. -/
namespace GeminiBridgeH6
noncomputable section
open scoped BigOperators

theorem charged_transition_bound (n : Nat) (price energy : ℝ)
    (cost : Nat → ℝ) (positive : 0 < price)
    (charged : ∀ i < n, price ≤ cost i)
    (paid : ∑ i ∈ Finset.range n, cost i ≤ energy) :
    n ≤ Nat.floor (energy / price) := by
  have lower : (n:ℝ)*price ≤ ∑ i ∈ Finset.range n, cost i := by
    calc
      (n:ℝ)*price = ∑ _i ∈ Finset.range n, price := by simp
      _ ≤ ∑ i ∈ Finset.range n, cost i := by
        apply Finset.sum_le_sum
        intro i hi
        exact charged i (Finset.mem_range.mp hi)
  apply Nat.le_floor
  exact (le_div_iff₀ positive).mpr (lower.trans paid)

theorem no_infinite_paid_run (price energy : ℝ) (positive : 0 < price) :
    ¬ (∀ n : Nat, (n:ℝ)*price ≤ energy) := by
  intro allPaid
  obtain ⟨n, hn⟩ := exists_nat_gt (energy/price)
  have excessive : energy < (n:ℝ)*price := (div_lt_iff₀ positive).mp hn
  exact (not_lt_of_ge (allPaid n)) excessive

theorem budget_exhaustion_need_not_be_fixed (state : Bool) :
    (!state) ≠ state := by
  cases state <;> decide

variable {S : Type*} [PseudoMetricSpace S]

theorem current_residual_bound (R : S → S) (fixed state : S) (k : ℝ)
    (belowOne : k < 1) (isFixed : R fixed = fixed)
    (contract : ∀ x y, dist (R x) (R y) ≤ k*dist x y) :
    dist state fixed ≤ dist state (R state)/(1-k) := by
  have contraction := contract state fixed
  rw [isFixed] at contraction
  have triangle := dist_triangle state (R state) fixed
  apply (le_div_iff₀ (sub_pos.mpr belowOne)).mpr
  nlinarith

theorem next_residual_bound (R : S → S) (fixed state : S) (k : ℝ)
    (nonnegative : 0 ≤ k) (belowOne : k < 1) (isFixed : R fixed = fixed)
    (contract : ∀ x y, dist (R x) (R y) ≤ k*dist x y) :
    dist (R state) fixed ≤ k*dist state (R state)/(1-k) := by
  have contraction := contract state fixed
  rw [isFixed] at contraction
  calc
    dist (R state) fixed ≤ k*dist state fixed := contraction
    _ ≤ k*(dist state (R state)/(1-k)) :=
      mul_le_mul_of_nonneg_left
        (current_residual_bound R fixed state k belowOne isFixed contract) nonnegative
    _ = k*dist state (R state)/(1-k) := by rw [mul_div_assoc]

end
end GeminiBridgeH6

