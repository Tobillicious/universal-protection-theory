/-
Snuffy — Canon Edition 4.2 working: reliability against age, and the
logarithm that a distance schedule leaves in the bill (review objection 7.2,
7.4).

  * cubic_spacetime_rate — on the spacetime decoding graph of phenomenological
    noise (data and measurement faults on the cubic lattice, coordination six,
    non-backtracking branching `Δ = 5`), the contraction ratio of
    `Threshold.fail_le_geometric` is `2 · 5 · √p`, and it is below one exactly
    when `p < 1/100`.
  * log_distance_schedule — with `V ≤ K t^d` locations and contraction ratio
    `0 < r < 1`, any distance `D ≥ log(K t^d / ε) / (−log r)` gives
    `V r^D ≤ ε`: a logarithmic distance schedule holds the global failure
    below `ε` at every age.
  * log_factor_not_absorbed — no age-independent `C` satisfies
    `t^d log t ≤ C t^d` for all `t ≥ 1`. A bill with a logarithmic overhead
    per location is not `O(t^d)`; it must be removed by construction, not by
    bounding.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Sqrt

namespace Snuffy.AgeReliability

/-- **The cubic spacetime contraction ratio.** -/
theorem cubic_spacetime_rate {p : ℝ} :
    2 * 5 * Real.sqrt p < 1 ↔ p < 1 / 100 := by
  have h : 2 * 5 * Real.sqrt p < 1 ↔ Real.sqrt p < 1 / 10 := by constructor <;> intro h <;> linarith
  rw [h, Real.sqrt_lt' (by norm_num)]
  constructor <;> intro h <;> nlinarith

/-- **A logarithmic distance schedule holds global failure at every age.** -/
theorem log_distance_schedule {V K ε r t : ℝ} {d D : ℕ} (hK : 0 < K) (ht : 0 < t) (hε : 0 < ε)
    (hr0 : 0 < r) (hr1 : r < 1) (hV : V ≤ K * t ^ d)
    (hD : Real.log (K * t ^ d / ε) / (-Real.log r) ≤ D) :
    V * r ^ D ≤ ε := by
  have hlogr : Real.log r < 0 := Real.log_neg hr0 hr1
  have hKt : 0 < K * t ^ d := by positivity
  have hrD : r ^ D ≤ ε / (K * t ^ d) := by
    have h1 : Real.log (K * t ^ d / ε) ≤ D * (-Real.log r) := by
      rwa [div_le_iff₀ (by linarith)] at hD
    have h2 : (D : ℝ) * Real.log r ≤ Real.log (ε / (K * t ^ d)) := by
      rw [Real.log_div hε.ne' hKt.ne', Real.log_div hKt.ne' hε.ne'] at *; linarith
    calc r ^ D = Real.exp (D * Real.log r) := by
          rw [← Real.rpow_natCast, Real.rpow_def_of_pos hr0, mul_comm]
      _ ≤ Real.exp (Real.log (ε / (K * t ^ d))) := Real.exp_le_exp.mpr h2
      _ = ε / (K * t ^ d) := Real.exp_log (by positivity)
  calc V * r ^ D ≤ (K * t ^ d) * (ε / (K * t ^ d)) :=
        mul_le_mul hV hrD (by positivity) (by positivity)
    _ = ε := by field_simp

/-- **A logarithmic overhead is not absorbed into an age-independent constant.** -/
theorem log_factor_not_absorbed (d : ℕ) (C : ℝ) :
    ∃ t : ℝ, 1 ≤ t ∧ C * t ^ d < t ^ d * Real.log t := by
  refine ⟨Real.exp (|C| + 1), ?_, ?_⟩
  · exact Real.one_le_exp (by positivity)
  · rw [Real.log_exp]
    have hpos : 0 < Real.exp (|C| + 1) ^ d := by positivity
    have : C < |C| + 1 := by linarith [le_abs_self C]
    nlinarith

end Snuffy.AgeReliability
