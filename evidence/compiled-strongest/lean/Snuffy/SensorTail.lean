/-
Snuffy — Canon Edition v4.1: bridge 2, the event-to-probability step for
trustworthy observations (Chernoff form).

  * sensor_tail — if the tampering-induced error `Z = Y − X` has a moment
    generating function bounded by `exp(σ²θ²/2 + Cθ)` at the Chernoff point
    `θ* = (δ − C)/σ²` (sensor noise variance `σ²`, adversarial shift `C`),
    then for every verification threshold `δ > C` the false-acceptance
    probability satisfies `P(Z ≥ δ) ≤ exp(−(δ − C)²/(2σ²))`.

  * sensor_law_tail — the moment bound derived from the installation law
    `Y = X + W + A`: ambient noise `W` sub-Gaussian with variance proxy `σ²`
    and a tampering shift `A ≤ C` at every outcome (adaptive or correlated
    with the noise, no independence needed). Then `P(Y − X ≥ δ) ≤
    exp(−(δ − C)²/(2σ²))` for every `δ > C`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Probability.Moments.Basic

open MeasureTheory ProbabilityTheory Real

namespace Snuffy.SensorTail

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]

/-- **Bridge 2, Chernoff form.** A sub-Gaussian sensor error with adversarial
shift `C` is accepted above threshold `δ > C` with probability at most
`exp(−(δ − C)²/(2σ²))`. -/
theorem sensor_tail (Z : Ω → ℝ) {σ C δ : ℝ} (hσ : 0 < σ) (hδ : C < δ)
    (h_int : Integrable (fun ω => exp ((δ - C) / σ ^ 2 * Z ω)) μ)
    (hmgf : mgf Z μ ((δ - C) / σ ^ 2) ≤
      exp (σ ^ 2 * ((δ - C) / σ ^ 2) ^ 2 / 2 + C * ((δ - C) / σ ^ 2))) :
    μ.real {ω | δ ≤ Z ω} ≤ exp (-(δ - C) ^ 2 / (2 * σ ^ 2)) := by
  have hσ2 : 0 < σ ^ 2 := by positivity
  set θ := (δ - C) / σ ^ 2 with hθ
  have hθ0 : 0 ≤ θ := div_nonneg (by linarith) hσ2.le
  calc μ.real {ω | δ ≤ Z ω} ≤ exp (-θ * δ) * mgf Z μ θ :=
        measure_ge_le_exp_mul_mgf δ hθ0 h_int
    _ ≤ exp (-θ * δ) * exp (σ ^ 2 * θ ^ 2 / 2 + C * θ) :=
        mul_le_mul_of_nonneg_left hmgf (exp_pos _).le
    _ = exp (-(δ - C) ^ 2 / (2 * σ ^ 2)) := by
        rw [← exp_add]
        congr 1
        rw [hθ]
        field_simp
        ring

/-- **Bridge 2 from the installation law.** With `Z = W + A`, `W` sub-Gaussian
(`σ²`) and the tampering shift bounded by `C` at every outcome, the
false-acceptance probability above `δ > C` is at most `exp(−(δ − C)²/(2σ²))`. -/
theorem sensor_law_tail (W A : Ω → ℝ) {σ C δ : ℝ} (hσ : 0 < σ) (hδ : C < δ)
    (hA : ∀ ω, A ω ≤ C)
    (hW_int : Integrable (fun ω => exp ((δ - C) / σ ^ 2 * W ω)) μ)
    (hZ_int : Integrable (fun ω => exp ((δ - C) / σ ^ 2 * (W ω + A ω))) μ)
    (hW : mgf W μ ((δ - C) / σ ^ 2) ≤ exp (σ ^ 2 * ((δ - C) / σ ^ 2) ^ 2 / 2)) :
    μ.real {ω | δ ≤ W ω + A ω} ≤ exp (-(δ - C) ^ 2 / (2 * σ ^ 2)) := by
  set θ := (δ - C) / σ ^ 2 with hθ
  have hθ0 : 0 ≤ θ := div_nonneg (by linarith) (by positivity)
  have hpt : ∀ ω, exp (θ * (W ω + A ω)) ≤ exp (θ * C) * exp (θ * W ω) := by
    intro ω
    rw [← exp_add]
    exact exp_le_exp.mpr (by nlinarith [hA ω])
  have hmgf : mgf (fun ω => W ω + A ω) μ θ ≤ exp (σ ^ 2 * θ ^ 2 / 2 + C * θ) := by
    calc mgf (fun ω => W ω + A ω) μ θ = ∫ ω, exp (θ * (W ω + A ω)) ∂μ := rfl
      _ ≤ ∫ ω, exp (θ * C) * exp (θ * W ω) ∂μ :=
          integral_mono hZ_int (hW_int.const_mul _) hpt
      _ = exp (θ * C) * mgf W μ θ := by rw [integral_const_mul]; rfl
      _ ≤ exp (θ * C) * exp (σ ^ 2 * θ ^ 2 / 2) :=
          mul_le_mul_of_nonneg_left hW (exp_pos _).le
      _ = exp (σ ^ 2 * θ ^ 2 / 2 + C * θ) := by rw [← exp_add]; ring_nf
  exact sensor_tail (fun ω => W ω + A ω) hσ hδ hZ_int hmgf

end Snuffy.SensorTail
