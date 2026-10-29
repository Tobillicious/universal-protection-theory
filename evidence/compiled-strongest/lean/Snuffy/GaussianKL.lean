/-
Snuffy — Canon Edition v4.1: the Kullback–Leibler divergence between real
Gaussians in closed form — the first block of the Gaussian maximum-entropy
bound of §11 (machine-checked).

For variances v₁, v₂ > 0:

  * rnDeriv_gaussian_gaussian — dN(m₁,v₁)/dN(m₂,v₂) = pdf₁/pdf₂ almost
    everywhere.
  * llr_gaussian_gaussian — the log-likelihood ratio is the explicit
    quadratic ½ ln(v₂/v₁) − (x − m₁)²/(2v₁) + (x − m₂)²/(2v₂).
  * integral_sq_sub_gaussian — ∫ (x − m)² dN(m₁, v₁) = v₁ + (m₁ − m)².
  * klDiv_gaussian_gaussian —
      KL(N(m₁,v₁) ‖ N(m₂,v₂)) = ½ (ln(v₂/v₁) + (v₁ + (m₁ − m₂)²)/v₂ − 1).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.InformationTheory.KullbackLeibler.Basic

open MeasureTheory ProbabilityTheory Real
open scoped ENNReal NNReal

namespace Snuffy.GaussianKL

variable {m₁ m₂ : ℝ} {v₁ v₂ : ℝ≥0}

/-- The Radon–Nikodym derivative between two nondegenerate real Gaussians is the
ratio of their densities, almost everywhere. -/
theorem rnDeriv_gaussian_gaussian (hv₂ : v₂ ≠ 0) :
    (gaussianReal m₁ v₁).rnDeriv (gaussianReal m₂ v₂)
      =ᵐ[volume] fun x => (gaussianPDF m₂ v₂ x)⁻¹ * gaussianPDF m₁ v₁ x := by
  have h := Measure.rnDeriv_withDensity_right (gaussianReal m₁ v₁) volume
    (measurable_gaussianPDF m₂ v₂).aemeasurable
    (Filter.Eventually.of_forall fun x => (gaussianPDF_pos m₂ hv₂ x).ne')
    (Filter.Eventually.of_forall fun x => gaussianPDF_ne_top)
  rw [← gaussianReal_of_var_ne_zero m₂ hv₂] at h
  filter_upwards [h, rnDeriv_gaussianReal m₁ v₁] with x hx hx'
  rw [hx, hx']

/-- Logarithm of a nondegenerate Gaussian density. -/
theorem log_gaussianPDFReal (m : ℝ) {v : ℝ≥0} (hv : v ≠ 0) (x : ℝ) :
    Real.log (gaussianPDFReal m v x) = -(Real.log (2 * π * v)) / 2 - (x - m) ^ 2 / (2 * v) := by
  have hvpos : (0 : ℝ) < v := by positivity
  have hpos : 0 < 2 * π * (v : ℝ) := by positivity
  rw [gaussianPDFReal_def, Real.log_mul (inv_ne_zero (Real.sqrt_pos.mpr hpos).ne')
    (Real.exp_pos _).ne', Real.log_inv, Real.log_sqrt hpos.le, Real.log_exp]
  ring

/-- **Log-likelihood ratio between real Gaussians.** -/
theorem llr_gaussian_gaussian (hv₁ : v₁ ≠ 0) (hv₂ : v₂ ≠ 0) :
    llr (gaussianReal m₁ v₁) (gaussianReal m₂ v₂)
      =ᵐ[gaussianReal m₁ v₁] fun x =>
        Real.log ((v₂ : ℝ) / v₁) / 2 - (x - m₁) ^ 2 / (2 * v₁) + (x - m₂) ^ 2 / (2 * v₂) := by
  have hv₁pos : (0 : ℝ) < v₁ := by positivity
  have hv₂pos : (0 : ℝ) < v₂ := by positivity
  filter_upwards [(gaussianReal_absolutelyContinuous m₁ hv₁).ae_le (rnDeriv_gaussian_gaussian hv₂)]
    with x hx
  rw [llr_def]
  simp only
  rw [hx, ENNReal.toReal_mul, ENNReal.toReal_inv, toReal_gaussianPDF, toReal_gaussianPDF,
    Real.log_mul (inv_ne_zero (gaussianPDFReal_pos m₂ v₂ x hv₂).ne')
      (gaussianPDFReal_pos m₁ v₁ x hv₁).ne',
    Real.log_inv, log_gaussianPDFReal m₁ hv₁, log_gaussianPDFReal m₂ hv₂,
    Real.log_div hv₂pos.ne' hv₁pos.ne',
    Real.log_mul (by positivity : (2 * π : ℝ) ≠ 0) hv₁pos.ne',
    Real.log_mul (by positivity : (2 * π : ℝ) ≠ 0) hv₂pos.ne']
  ring

/-- Second moment about any point: `∫ (x − m)² dN(m₁, v₁) = v₁ + (m₁ − m)²`. -/
theorem integral_sq_sub_gaussian (m : ℝ) :
    ∫ x, (x - m) ^ 2 ∂gaussianReal m₁ v₁ = v₁ + (m₁ - m) ^ 2 := by
  have hint1 : Integrable (fun x : ℝ => x) (gaussianReal m₁ v₁) :=
    (memLp_id_gaussianReal 1).integrable le_rfl
  have hint2 : Integrable (fun x : ℝ => (x - m₁) ^ 2) (gaussianReal m₁ v₁) :=
    ((memLp_id_gaussianReal 2).sub (memLp_const m₁)).integrable_sq
  have hvar : ∫ x, (x - m₁) ^ 2 ∂gaussianReal m₁ v₁ = v₁ := by
    have h := variance_fun_id_gaussianReal (μ := m₁) (v := v₁)
    rw [variance_eq_integral measurable_id'.aemeasurable, integral_id_gaussianReal] at h
    exact h
  have hexp : ∀ x : ℝ, (x - m) ^ 2 = (x - m₁) ^ 2 + 2 * (m₁ - m) * x + ((m₁ - m) ^ 2 - 2 * (m₁ - m) * m₁) := by
    intro x; ring
  rw [integral_congr_ae (Filter.Eventually.of_forall hexp)]
  have hE : Integrable (fun x : ℝ => (x - m₁) ^ 2 + 2 * (m₁ - m) * x) (gaussianReal m₁ v₁) :=
    hint2.add (hint1.const_mul _)
  have hF : Integrable (fun x : ℝ => 2 * (m₁ - m) * x) (gaussianReal m₁ v₁) := hint1.const_mul _
  rw [integral_add hE (integrable_const _), integral_add hint2 hF, integral_const_mul, hvar,
    integral_id_gaussianReal, integral_const, probReal_univ, one_smul]
  ring

/-- **KL divergence between real Gaussians.** -/
theorem klDiv_gaussian_gaussian (hv₁ : v₁ ≠ 0) (hv₂ : v₂ ≠ 0) :
    (InformationTheory.klDiv (gaussianReal m₁ v₁) (gaussianReal m₂ v₂)).toReal
      = (Real.log ((v₂ : ℝ) / v₁) + ((v₁ : ℝ) + (m₁ - m₂) ^ 2) / v₂ - 1) / 2 := by
  have hv₁pos : (0 : ℝ) < v₁ := by positivity
  have hv₂pos : (0 : ℝ) < v₂ := by positivity
  have hac : gaussianReal m₁ v₁ ≪ gaussianReal m₂ v₂ :=
    (gaussianReal_absolutelyContinuous m₁ hv₁).trans (gaussianReal_absolutelyContinuous' m₂ hv₂)
  rw [InformationTheory.toReal_klDiv_of_measure_eq hac (by simp),
    integral_congr_ae (llr_gaussian_gaussian hv₁ hv₂)]
  have hsq : ∀ m, Integrable (fun x : ℝ => (x - m) ^ 2) (gaussianReal m₁ v₁) := fun m =>
    ((memLp_id_gaussianReal 2).sub (memLp_const m)).integrable_sq
  have hA : Integrable (fun x : ℝ => Real.log ((v₂ : ℝ) / v₁) / 2 - (x - m₁) ^ 2 / (2 * v₁))
      (gaussianReal m₁ v₁) := (integrable_const _).sub ((hsq m₁).div_const _)
  have hB : Integrable (fun x : ℝ => (x - m₂) ^ 2 / (2 * v₂)) (gaussianReal m₁ v₁) :=
    (hsq m₂).div_const _
  have hC : Integrable (fun _ : ℝ => Real.log ((v₂ : ℝ) / v₁) / 2) (gaussianReal m₁ v₁) :=
    integrable_const _
  have hD : Integrable (fun x : ℝ => (x - m₁) ^ 2 / (2 * v₁)) (gaussianReal m₁ v₁) :=
    (hsq m₁).div_const _
  rw [integral_add hA hB, integral_sub hC hD, integral_const, probReal_univ, one_smul,
    integral_div, integral_div, integral_sq_sub_gaussian, integral_sq_sub_gaussian]
  field_simp
  ring

end Snuffy.GaussianKL
