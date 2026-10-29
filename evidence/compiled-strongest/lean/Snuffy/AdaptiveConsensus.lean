import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Gemini H7 in an explicit adaptive consensus protocol. Each update mixes a
row-stochastic neighbour estimate with a measured anchor. The error estimate
allows arbitrary history-dependent weights, with a uniform sensor-error bound.
-/
namespace UPTAdaptiveConsensus
open scoped BigOperators

theorem weighted_error_bound {I : Type} [Fintype I]
    (weight error : I → ℝ) (bound : ℝ)
    (positive : ∀ i, 0 ≤ weight i) (normalized : ∑ i, weight i = 1)
    (bounded : ∀ i, |error i| ≤ bound) :
    |∑ i, weight i * error i| ≤ bound := by
  calc
    |∑ i, weight i * error i| ≤ ∑ i, |weight i * error i| :=
      Finset.abs_sum_le_sum_abs _ _
    _ = ∑ i, weight i * |error i| := by
      apply Finset.sum_congr rfl
      intro i _
      rw [abs_mul, abs_of_nonneg (positive i)]
    _ ≤ ∑ i, weight i * bound := Finset.sum_le_sum (fun i _ =>
      mul_le_mul_of_nonneg_left (bounded i) (positive i))
    _ = bound := by rw [← Finset.sum_mul, normalized, one_mul]

theorem anchored_update_error {I : Type} [Fintype I]
    (weight error : I → ℝ) (alpha measurementError bound sensorBound : ℝ)
    (ha : 0 ≤ alpha) (ha1 : alpha ≤ 1)
    (positive : ∀ i, 0 ≤ weight i) (normalized : ∑ i, weight i = 1)
    (bounded : ∀ i, |error i| ≤ bound) (sensor : |measurementError| ≤ sensorBound) :
    |(1-alpha)*(∑ i, weight i*error i) + alpha*measurementError| ≤
      (1-alpha)*bound+alpha*sensorBound := by
  have neighbour := weighted_error_bound weight error bound positive normalized bounded
  calc
    |(1-alpha)*(∑ i, weight i*error i) + alpha*measurementError| ≤
      |(1-alpha)*(∑ i, weight i*error i)| + |alpha*measurementError| := abs_add_le _ _
    _ = (1-alpha)*|∑ i, weight i*error i|+alpha*|measurementError| := by
      rw [abs_mul, abs_of_nonneg (by linarith : 0 ≤ 1-alpha), abs_mul, abs_of_nonneg ha]
    _ ≤ (1-alpha)*bound+alpha*sensorBound :=
      add_le_add (mul_le_mul_of_nonneg_left neighbour (by linarith))
        (mul_le_mul_of_nonneg_left sensor ha)

def evolution {I : Type} [Fintype I]
    (weights : Nat → I → I → ℝ) (measurement : Nat → I → ℝ)
    (alpha : ℝ) (initial : I → ℝ) : Nat → I → ℝ
  | 0, i => initial i
  | n+1, i => (1-alpha)*(∑ j, weights n i j * evolution weights measurement alpha initial n j)
      +alpha*measurement n i

/-- Error contracts to the sensor-error floor, uniformly over arbitrary
time-varying row-stochastic communication. No independent-noise premise is used. -/
theorem adaptive_history_error_bound {I : Type} [Fintype I]
    (weights : Nat → I → I → ℝ) (measurement : Nat → I → ℝ)
    (alpha initialBound sensorBound : ℝ) (initial : I → ℝ)
    (ha : 0 ≤ alpha) (ha1 : alpha ≤ 1)
    (positive : ∀ n i j, 0 ≤ weights n i j)
    (normalized : ∀ n i, ∑ j, weights n i j = 1)
    (sensor : ∀ n i, |measurement n i| ≤ sensorBound)
    (start : ∀ i, |initial i| ≤ initialBound) :
    ∀ n i, |evolution weights measurement alpha initial n i| ≤
      (1-alpha)^n * initialBound+sensorBound*(1-(1-alpha)^n) := by
  intro n
  induction n with
  | zero => intro i; simpa [evolution] using start i
  | succ n ih =>
      intro i
      have step := anchored_update_error (weights n i)
        (evolution weights measurement alpha initial n) alpha (measurement n i)
        ((1-alpha)^n*initialBound+sensorBound*(1-(1-alpha)^n)) sensorBound
        ha ha1 (positive n i) (normalized n i) ih (sensor n i)
      simpa only [evolution] using step.trans_eq (by rw [pow_succ]; ring)

end UPTAdaptiveConsensus

