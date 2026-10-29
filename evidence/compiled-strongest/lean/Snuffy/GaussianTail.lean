/-
Snuffy — Canon Edition v4.1: the Gaussian tail of the moving carrier and the
assembled X3 delayed-recovery theorem, machine-checked (Summit 4, X3; working
argument §12).

  * gaussian_lower_tail — Chernoff for N(m, v): P(X ≤ r) ≤ exp(−(m − r)²/(2v))
    for r ≤ m, from Mathlib's Gaussian moment generating function.
  * carrier_tail — the drift–diffusion carrier X_t ~ N(ut, 2Dt):
    P(X_t ≤ r) ≤ exp(−(ut − r)²/(4Dt)).
  * necessary_radius_of_decoder — from the optimistic-decoder bound
    I_target ≤ I₀ · P(X_t ≤ r) (the classical-flag chain rule of §12), every
    successful radius satisfies r ≥ ut − c√t, c = 2√(D ln(I₀/I_target)).
  * x3_work_from_decoder — assembled: at unattended age t ≥ t_c every
    successful admitted recovery protocol pays at least
    (p'/(v d_G)) ((w(t − t_c))^(d_G) − r₀^(d_G)), which diverges.

The one input not compiled here is the optimistic-decoder chain-rule bound
itself (Shannon), carried as the hypothesis `hdecoder`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.RecoveryWork
import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Probability.Moments.Basic

open MeasureTheory ProbabilityTheory Real

namespace Snuffy.GaussianTail

/-- **Gaussian lower tail (Chernoff).** For `X ~ N(m, v)` with `v > 0` and
`r ≤ m`, `P(X ≤ r) ≤ exp(−(m − r)²/(2v))`. -/
theorem gaussian_lower_tail {m r : ℝ} {v : NNReal} (hv : 0 < (v : ℝ)) (hr : r ≤ m) :
    (gaussianReal m v).real {x | x ≤ r} ≤ exp (-(m - r) ^ 2 / (2 * v)) := by
  set t : ℝ := -((m - r) / v) with ht_def
  have ht : t ≤ 0 := neg_nonpos.mpr (div_nonneg (by linarith) hv.le)
  have h := measure_le_le_exp_mul_mgf (μ := gaussianReal m v) (X := id) r ht
    (by exact integrable_exp_mul_gaussianReal t)
  rw [mgf_id_gaussianReal, ← Real.exp_add] at h
  have hexp : -t * r + (m * t + (v : ℝ) * t ^ 2 / 2) = -(m - r) ^ 2 / (2 * v) := by
    rw [ht_def]
    field_simp
    ring
  rw [hexp] at h
  simpa using h

/-- The variance `2Dt` of the drift–diffusion carrier at age `t`. -/
noncomputable def carrierVar (D t : ℝ) (hD : 0 < D) (ht : 0 < t) : NNReal :=
  ⟨2 * D * t, by positivity⟩

/-- **Carrier tail.** For the carrier `X_t ~ N(ut, 2Dt)` and `r ≤ ut`,
`P(X_t ≤ r) ≤ exp(−(ut − r)²/(4Dt))`. -/
theorem carrier_tail {u D t r : ℝ} (hD : 0 < D) (ht : 0 < t) (hr : r ≤ u * t) :
    (gaussianReal (u * t) (carrierVar D t hD ht)).real {x | x ≤ r}
      ≤ exp (-(u * t - r) ^ 2 / (4 * D * t)) := by
  have hv : (0 : ℝ) < (carrierVar D t hD ht : ℝ) := by
    show 0 < 2 * D * t
    positivity
  have h := gaussian_lower_tail hv hr
  have h2 : (2 : ℝ) * (carrierVar D t hD ht : ℝ) = 4 * D * t := by
    show 2 * (2 * D * t) = 4 * D * t
    ring
  rwa [h2] at h

/-- **Necessary radius from the decoder bound.** If recovering `I_target`
within radius `r` is bounded by the optimistic decoder,
`I_target ≤ I₀ · P(X_t ≤ r)`, then `r ≥ ut − c√t` with
`c = 2√(D ln(I₀/I_target))`. -/
theorem necessary_radius_of_decoder {I0 It D u t r : ℝ} (hD : 0 < D) (ht : 0 < t)
    (hIt : 0 < It) (hItI0 : It ≤ I0)
    (hdecoder : It ≤ I0 * (gaussianReal (u * t) (carrierVar D t hD ht)).real {x | x ≤ r}) :
    u * t - 2 * Real.sqrt (D * Real.log (I0 / It)) * Real.sqrt t ≤ r := by
  have hI0 : 0 ≤ I0 := le_trans hIt.le hItI0
  exact Snuffy.RecoveryWork.necessary_radius hD ht hIt hItI0 fun hr =>
    hdecoder.trans (mul_le_mul_of_nonneg_left (carrier_tail hD ht hr.le) hI0)

/-- **X3, assembled.** With `c = 2√(D ln(I₀/I_target))`, `0 < w < u` and
`t_c = c²/(4w(u − w))`: at unattended age `t ≥ t_c`, any admitted recovery
protocol that succeeds at a radius `R` satisfying the decoder bound pays at
least `(p'/(v d)) ((w(t − t_c))^d − r₀^d)`. -/
theorem x3_work_from_decoder {I0 It D u w t R r0 v p' d : ℝ} (hD : 0 < D) (ht : 0 < t)
    (hIt : 0 < It) (hItI0 : It ≤ I0) (hw : 0 < w) (hwu : w < u)
    (htc : (2 * Real.sqrt (D * Real.log (I0 / It))) ^ 2 / (4 * w * (u - w)) ≤ t)
    (hdecoder : It ≤ I0 * (gaussianReal (u * t) (carrierVar D t hD ht)).real {x | x ≤ R})
    (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    (prot : Snuffy.RecoveryWork.RecoveryProtocol r0 v p' d) (hsucc : prot.Succeeds R) :
    p' / (v * d) * ((w * (t - (2 * Real.sqrt (D * Real.log (I0 / It))) ^ 2
        / (4 * w * (u - w)))) ^ d - r0 ^ d) ≤ prot.work := by
  have hR1 := necessary_radius_of_decoder hD ht hIt hItI0 hdecoder
  have hR2 := Snuffy.RecoveryWork.carrier_radius hw hwu ht.le hR1
  exact Snuffy.RecoveryWork.x3_delayed_recovery_work hd hv hp hw htc hR2 prot hsucc

end Snuffy.GaussianTail
