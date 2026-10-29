/-
Snuffy — Canon Edition v4.1: the calibrated information-to-area bridge,
machine-checked (working argument §11).

  * logdet_le_trace — for every positive semidefinite W (real or complex),
    ln det(I + W) ≤ tr W: on the eigenvalues μ of I + W, ln μ ≤ μ − 1.
  * channel_cap — the per-use cap: from the Gaussian maximum-entropy bound
    I ≤ (1/(2 ln 2)) ln det(I + W), the calibrated gain/noise bound
    tr W ≤ (g²/σ²) tr K and the range bound tr K ≤ m Λ²/(4n²),
    I ≤ m g² Λ² / (8 σ² ln 2 · n²) bits per use.
  * required_traffic — a deadline-bounded recovery needing Δ₀ bits through a
    cut of rate at most m K_rate / n forces m ≥ θ₀ n, θ₀ = Δ₀/(τ_max K_max).
  * area_power — with n(r) ≥ a r^(d_G − 1) boundary nodes and charged power p₀
    per active node, P(r) ≥ p₀ θ₀ a r^(d_G − 1).

The Gaussian maximum-entropy bound (Shannon), the variance of a bounded
coordinate (≤ width²/4) and the error-flag bound defining Δ₀ (Fano) are the
standard inputs, carried as named hypotheses.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.Matrix.PosDef
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

open Matrix Finset
open scoped ComplexOrder

namespace Snuffy.AreaBridge

variable {n : Type*} [Fintype n] [DecidableEq n] {𝕜 : Type*} [RCLike 𝕜]

/-- **log det ≤ trace.** For positive semidefinite `W`, `ln det(I + W) ≤ tr W`. -/
theorem logdet_le_trace (W : Matrix n n 𝕜) (hW : W.PosSemidef) :
    Real.log (RCLike.re (1 + W).det) ≤ RCLike.re W.trace := by
  have hP : (1 + W).PosDef := Matrix.PosDef.add_posSemidef Matrix.PosDef.one hW
  have hpos : ∀ i, 0 < hP.1.eigenvalues i := hP.eigenvalues_pos
  have hdet : RCLike.re (1 + W).det = ∏ i, hP.1.eigenvalues i := by
    rw [hP.1.det_eq_prod_eigenvalues, ← RCLike.ofReal_prod, RCLike.ofReal_re]
  have htr : RCLike.re W.trace = ∑ i, (hP.1.eigenvalues i - 1) := by
    have h1 : (1 + W).trace = ∑ i, (hP.1.eigenvalues i : 𝕜) := hP.1.trace_eq_sum_eigenvalues
    rw [trace_add, trace_one] at h1
    have h2 := congrArg RCLike.re h1
    rw [map_add, RCLike.natCast_re, ← RCLike.ofReal_sum, RCLike.ofReal_re] at h2
    rw [sum_sub_distrib, sum_const, card_univ, nsmul_eq_mul, mul_one]
    linarith
  rw [hdet, htr, Real.log_prod (fun i _ => (hpos i).ne')]
  exact sum_le_sum fun i _ => Real.log_le_sub_one_of_pos (hpos i)

/-- **Per-use channel cap.** -/
theorem channel_cap {I g σ m nn Λ : ℝ} (W K : Matrix n n 𝕜) (hW : W.PosSemidef)
    (hσ : 0 < σ) (hn : 0 < nn)
    (hmaxent : I ≤ 1 / (2 * Real.log 2) * Real.log (RCLike.re (1 + W).det))
    (hsnr : RCLike.re W.trace ≤ g ^ 2 / σ ^ 2 * RCLike.re K.trace)
    (hrange : RCLike.re K.trace ≤ m * Λ ^ 2 / (4 * nn ^ 2)) (hg : 0 ≤ g ^ 2 / σ ^ 2) :
    I ≤ m * (g ^ 2 * Λ ^ 2 / (8 * σ ^ 2 * Real.log 2 * nn ^ 2)) := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos one_lt_two
  have hc : 0 ≤ 1 / (2 * Real.log 2) := by positivity
  have h1 := logdet_le_trace W hW
  calc I ≤ 1 / (2 * Real.log 2) * Real.log (RCLike.re (1 + W).det) := hmaxent
    _ ≤ 1 / (2 * Real.log 2) * (g ^ 2 / σ ^ 2 * (m * Λ ^ 2 / (4 * nn ^ 2))) := by
        apply mul_le_mul_of_nonneg_left _ hc
        exact h1.trans (hsnr.trans (mul_le_mul_of_nonneg_left hrange hg))
    _ = m * (g ^ 2 * Λ ^ 2 / (8 * σ ^ 2 * Real.log 2 * nn ^ 2)) := by
        field_simp
        ring

/-- **Uniform required traffic.** If successful recovery needs information rate
`J_req ≥ Δ₀/τ_max` through a cut carrying at most `m K_rate / n`, with
`0 < K_rate ≤ K_max`, then `m ≥ θ₀ n`, `θ₀ = Δ₀/(τ_max K_max)`. -/
theorem required_traffic {m nn J Δ₀ τ Kr Kmax : ℝ} (hn : 0 < nn) (hτ : 0 < τ) (hKr : 0 < Kr)
    (hKmax : Kr ≤ Kmax) (hΔ : 0 ≤ Δ₀) (hJ : Δ₀ / τ ≤ J) (hcut : J ≤ m * Kr / nn) :
    Δ₀ / (τ * Kmax) * nn ≤ m := by
  have hKmaxpos : 0 < Kmax := lt_of_lt_of_le hKr hKmax
  have h1 : nn * J ≤ m * Kr := by rwa [le_div_iff₀ hn, mul_comm] at hcut
  have h2 : Δ₀ / (τ * Kmax) * nn ≤ J / Kr * nn := by
    apply mul_le_mul_of_nonneg_right _ hn.le
    calc Δ₀ / (τ * Kmax) = Δ₀ / τ / Kmax := by rw [div_div]
      _ ≤ J / Kmax := div_le_div_of_nonneg_right hJ hKmaxpos.le
      _ ≤ J / Kr := div_le_div_of_nonneg_left
          (le_trans (div_nonneg hΔ hτ.le) hJ) hKr hKmax
  calc Δ₀ / (τ * Kmax) * nn ≤ J / Kr * nn := h2
    _ = nn * J / Kr := by ring
    _ ≤ m * Kr / Kr := div_le_div_of_nonneg_right h1 hKr.le
    _ = m := by field_simp

/-- **Area power.** With at least `a r^(d − 1)` boundary nodes, a required
active fraction `θ₀` and charged power `p₀` per active node, the standing
power is at least `p₀ θ₀ a r^(d − 1)`. -/
theorem area_power {P p₀ θ₀ a r d m nn : ℝ} (hp : 0 ≤ p₀) (hθ : 0 ≤ θ₀)
    (hnodes : a * r ^ (d - 1) ≤ nn) (hm : θ₀ * nn ≤ m) (hP : p₀ * m ≤ P) :
    p₀ * θ₀ * a * r ^ (d - 1) ≤ P := by
  calc p₀ * θ₀ * a * r ^ (d - 1) = p₀ * (θ₀ * (a * r ^ (d - 1))) := by ring
    _ ≤ p₀ * (θ₀ * nn) := by gcongr
    _ ≤ p₀ * m := by gcongr
    _ ≤ P := hP

end Snuffy.AreaBridge
