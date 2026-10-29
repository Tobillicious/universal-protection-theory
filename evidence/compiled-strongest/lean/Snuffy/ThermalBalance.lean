import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Tactic.Linarith

/-! Gemini P-THERM / Joint 2: a continuous intra-epoch estimate from an actual
integral balance law, followed by a buffer deadline certificate. Net extraction
is already included in `net`; all rates and times use compatible units.
-/
namespace UPTThermalBalance
open MeasureTheory Set

theorem intra_epoch_integral_bound
    (entropy net : ℝ → ℝ) (start time rate : ℝ)
    (forward : start ≤ time)
    (integrable : IntervalIntegrable net volume start time)
    (production : ∀ u ∈ Icc start time, net u ≤ rate)
    (balance : entropy time=entropy start+∫ u in start..time, net u) :
    entropy time ≤ entropy start+rate*(time-start) := by
  have comparison := intervalIntegral.integral_mono_on forward integrable
    (intervalIntegrable_const : IntervalIntegrable (fun _ : ℝ => rate) volume start time)
    production
  rw [intervalIntegral.integral_const] at comparison
  simp only [smul_eq_mul] at comparison
  rw [balance]
  linarith only [comparison]

theorem repair_before_buffer_exhaustion
    (entropy net : ℝ → ℝ) (start time rate horizon ceiling : ℝ)
    (forward : start ≤ time) (within : time-start ≤ horizon) (rateNonnegative : 0 ≤ rate)
    (integrable : IntervalIntegrable net volume start time)
    (production : ∀ u ∈ Icc start time, net u ≤ rate)
    (balance : entropy time=entropy start+∫ u in start..time, net u)
    (headroom : entropy start+rate*horizon ≤ ceiling) :
    entropy time ≤ ceiling := by
  have bounded := intra_epoch_integral_bound entropy net start time rate forward
    integrable production balance
  have duration := mul_le_mul_of_nonneg_left within rateNonnegative
  linarith

end UPTThermalBalance

