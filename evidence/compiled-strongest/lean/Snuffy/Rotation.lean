/-
Snuffy — Canon Edition v4.1: rotating the output — stage 1 of the exact
log-det form of the Gaussian channel bound (§11).

  * multivariateGaussian_one_map_isometry — an orthogonal map U sends N(m, I) to
    N(U m, I): white noise stays white under rotation.
  * rotated_channel_bound — for every orthogonal U of the output space,
    I(X ; s(X) + Z) ≤ Σ_i ½ ln(1 + Var (U (√Σ)⁻¹ s(X))_i).

Choosing U to diagonalise the covariance of the whitened signal turns the sum
into ½ ln det(I + Cov) (stage 2).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Whitening

open MeasureTheory ProbabilityTheory InformationTheory Matrix WithLp Finset
open scoped ENNReal NNReal MatrixOrder

namespace Snuffy.Rotation

open Snuffy.GaussianVector Snuffy.Whitening

variable {n : ℕ}

/-- **White noise stays white under rotation.** -/
theorem multivariateGaussian_one_map_isometry
    (U : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) (m : EuclideanSpace ℝ (Fin n)) :
    (multivariateGaussian m 1).map U = multivariateGaussian (U m) 1 := by
  rw [multivariateGaussian, multivariateGaussian, CFC.sqrt_one, map_one,
    Measure.map_map U.continuous.measurable (by fun_prop)]
  have hcomp : (U ∘ fun x : EuclideanSpace ℝ (Fin n) =>
        m + (1 : EuclideanSpace ℝ (Fin n) →L[ℝ] EuclideanSpace ℝ (Fin n)) x)
      = (fun x => U m + (1 : EuclideanSpace ℝ (Fin n) →L[ℝ] EuclideanSpace ℝ (Fin n)) x) ∘ U := by
    funext x
    simp only [Function.comp_apply, map_add]
    rfl
  rw [hcomp, ← Measure.map_map (by fun_prop) U.continuous.measurable, stdGaussian_map]

/-- The rotation as a measurable equivalence. -/
noncomputable def rotEquiv (U : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) :
    EuclideanSpace ℝ (Fin n) ≃ᵐ EuclideanSpace ℝ (Fin n) :=
  U.toContinuousLinearEquiv.toHomeomorph.toMeasurableEquiv

variable {α : Type*} [MeasurableSpace α]

/-- The rotated, whitened signal coordinates `(U (√Σ)⁻¹ s(x))_i`. -/
noncomputable def rotSignal (U : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (s : α → EuclideanSpace ℝ (Fin n)) (S : Matrix (Fin n) (Fin n) ℝ) (i : Fin n) (x : α) : ℝ :=
  ofLp (U (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x))) i

theorem measurable_rotSignal (U : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s) (S : Matrix (Fin n) (Fin n) ℝ)
    (i : Fin n) : Measurable (rotSignal U s S i) := by
  unfold rotSignal
  have h1 : Measurable fun x => U (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x)) :=
    U.continuous.measurable.comp ((toEuclideanCLM (𝕜 := ℝ) (wht S)).continuous.measurable.comp hs)
  exact ((measurable_pi_apply i).comp (WithLp.measurable_ofLp 2 _)).comp h1

/-- **The rotated channel bound.** For every orthogonal map `U` of the output
space, `I(X ; s(X) + Z) ≤ Σ_i ½ ln(1 + Var (U (√Σ)⁻¹ s(X))_i)`. -/
theorem rotated_channel_bound [StandardBorelSpace α] [Nonempty α] (P : Measure α)
    [IsProbabilityMeasure P] (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s)
    {S : Matrix (Fin n) (Fin n) ℝ} (hS : S.PosDef)
    (U : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (hX : ∀ i, MemLp (rotSignal U s S i) 2 P) :
    Snuffy.Information.mutualInfo (P ⊗ₘ corrChan s hs S)
      ≤ ENNReal.ofReal (∑ i, Real.log (1 + varW P (rotSignal U s S) i) / 2) := by
  have hw := measurable_rotSignal U s hs S
  have := isMarkov_vecChan (1 : ℝ≥0) n (rotSignal U s S) hw
  have : IsMarkovKernel ((corrChan s hs S).map (whtEquiv hS)) :=
    Kernel.IsMarkovKernel.map _ (whtEquiv hS).measurable
  rw [← mutualInfo_kernel_map_equiv P (corrChan s hs S) (whtEquiv hS),
    ← mutualInfo_kernel_map_equiv P _ (rotEquiv U)]
  have hk : ((corrChan s hs S).map (whtEquiv hS)).map (rotEquiv U)
      = (vecChan 1 n (rotSignal U s S) hw).map (MeasurableEquiv.toLp 2 (Fin n → ℝ)) := by
    ext x : 1
    rw [Kernel.map_apply _ (rotEquiv U).measurable, Kernel.map_apply _ (whtEquiv hS).measurable,
      Kernel.map_apply _ (MeasurableEquiv.toLp 2 (Fin n → ℝ)).measurable, corrChan_apply,
      vecChan_apply]
    show ((multivariateGaussian (s x) S).map (toEuclideanCLM (𝕜 := ℝ) (wht S))).map U = _
    rw [whiten hS, multivariateGaussian_one_map_isometry, multivariateGaussian_one_eq_pi]
    rfl
  rw [hk, mutualInfo_kernel_map_equiv]
  have h := vector_channel_bound (v := 1) one_ne_zero P n (rotSignal U s S) hw hX
  simpa only [NNReal.coe_one, div_one] using h

end Snuffy.Rotation
