/-
Snuffy — Canon Edition v4.1: the paid reflection certificate, machine-checked
(working argument §8).

For a contraction `R` with constant `0 ≤ k < 1` on a complete metric space and
iterates `s_{n+1} = R s_n`:

  * residual_certificate — d(s_{n+1}, s*) ≤ (k/(1 − k)) d(s_n, s_{n+1}): the
    residual of the update just performed certifies the returned state.
  * apriori_error — d(s_n, s*) ≤ kⁿ a₀ / (1 − k), a₀ = d(s₀, s₁).
  * stopping_count — with 0 < k and a₀ > 0, the paid update count
    N = max{1, ⌈ln(ε(1 − k)/a₀)/ln k⌉} guarantees d(s_n, s*) ≤ ε for all n ≥ N.
  * zero_constant_fixed — with k = 0 the first update is already fixed.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Topology.MetricSpace.Contracting
import Mathlib.Analysis.SpecialFunctions.Log.Basic

open Function NNReal

namespace Snuffy.Reflection

variable {X : Type*} [MetricSpace X] {k : ℝ≥0} {R : X → X}

/-- **Residual certificate.** The update just performed certifies the returned
state: `d(s_{n+1}, s*) ≤ (k / (1 − k)) · d(s_n, s_{n+1})`. -/
theorem residual_certificate [CompleteSpace X] [Nonempty X] (hR : ContractingWith k R)
    (s₀ : X) (n : ℕ) :
    dist (R^[n + 1] s₀) (ContractingWith.fixedPoint R hR)
      ≤ k / (1 - k) * dist (R^[n] s₀) (R^[n + 1] s₀) := by
  have hk1 : (0 : ℝ) < 1 - k := sub_pos.mpr (by exact_mod_cast hR.1)
  have h1 := hR.dist_fixedPoint_le (R^[n + 1] s₀)
  have h2 : dist (R^[n + 1] s₀) (R (R^[n + 1] s₀)) ≤ k * dist (R^[n] s₀) (R^[n + 1] s₀) := by
    have := hR.2.dist_le_mul (R^[n] s₀) (R^[n + 1] s₀)
    rw [iterate_succ_apply' R n s₀] at this ⊢
    exact this
  calc dist (R^[n + 1] s₀) (ContractingWith.fixedPoint R hR)
      ≤ dist (R^[n + 1] s₀) (R (R^[n + 1] s₀)) / (1 - k) := h1
    _ ≤ k * dist (R^[n] s₀) (R^[n + 1] s₀) / (1 - k) := div_le_div_of_nonneg_right h2 hk1.le
    _ = k / (1 - k) * dist (R^[n] s₀) (R^[n + 1] s₀) := by ring

/-- **A-priori error.** `d(s_n, s*) ≤ kⁿ a₀ / (1 − k)`. -/
theorem apriori_error [CompleteSpace X] [Nonempty X] (hR : ContractingWith k R) (s₀ : X)
    (n : ℕ) :
    dist (R^[n] s₀) (ContractingWith.fixedPoint R hR) ≤ (k : ℝ) ^ n * dist s₀ (R s₀) / (1 - k) := by
  have h := hR.apriori_dist_iterate_fixedPoint_le s₀ n
  rwa [mul_comm (dist s₀ (R s₀))] at h

/-- **Paid stopping count.** With `0 < k < 1`, `a₀ = d(s₀, R s₀) > 0` and target
`ε > 0`, every `n ≥ N = max{1, ⌈ln(ε(1 − k)/a₀)/ln k⌉}` has `d(s_n, s*) ≤ ε`. -/
theorem stopping_count [CompleteSpace X] [Nonempty X] (hR : ContractingWith k R)
    (hk0 : 0 < (k : ℝ)) (s₀ : X) {ε : ℝ} (hε : 0 < ε) (ha : 0 < dist s₀ (R s₀)) :
    ∀ n ≥ max 1 ⌈Real.log (ε * (1 - k) / dist s₀ (R s₀)) / Real.log k⌉₊,
      dist (R^[n] s₀) (ContractingWith.fixedPoint R hR) ≤ ε := by
  intro n hn
  set a := dist s₀ (R s₀)
  have hk1 : (k : ℝ) < 1 := by exact_mod_cast hR.1
  have h1k : (0 : ℝ) < 1 - k := sub_pos.mpr hk1
  set x := ε * (1 - k) / a with hx_def
  have hx : 0 < x := div_pos (mul_pos hε h1k) ha
  have hpow : (k : ℝ) ^ n ≤ x := by
    by_cases hx1 : 1 ≤ x
    · exact (pow_le_one₀ hk0.le hk1.le).trans hx1
    · rw [not_le] at hx1
      have hlogk : Real.log k < 0 := Real.log_neg hk0 hk1
      have hceil : Real.log x / Real.log k ≤ n := by
        have h1 : Real.log x / Real.log k ≤ ⌈Real.log x / Real.log k⌉₊ := Nat.le_ceil _
        have h2 : (⌈Real.log x / Real.log k⌉₊ : ℝ) ≤ n := by
          exact_mod_cast le_trans (le_max_right _ _) hn
        linarith
      have hmul : (n : ℝ) * Real.log k ≤ Real.log x := (div_le_iff_of_neg hlogk).mp hceil
      rw [← Real.log_pow] at hmul
      exact (Real.log_le_log_iff (pow_pos hk0 n) hx).mp hmul
  calc dist (R^[n] s₀) (ContractingWith.fixedPoint R hR)
      ≤ (k : ℝ) ^ n * a / (1 - k) := apriori_error hR s₀ n
    _ ≤ x * a / (1 - k) := by
        apply div_le_div_of_nonneg_right _ h1k.le
        exact mul_le_mul_of_nonneg_right hpow ha.le
    _ = ε := by rw [hx_def]; field_simp

/-- **Zero constant.** A contraction with constant `0` is constant, so the first
update is already a fixed point. -/
theorem zero_constant_fixed (hR : ContractingWith 0 R) (s₀ : X) : IsFixedPt R (R s₀) := by
  have h := hR.2.dist_le_mul (R s₀) s₀
  simp only [NNReal.coe_zero, zero_mul] at h
  exact dist_le_zero.mp h

end Snuffy.Reflection
