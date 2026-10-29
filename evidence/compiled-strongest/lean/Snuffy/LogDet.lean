/-
Snuffy — Canon Edition v4.1: the exact log-det form of the Gaussian channel
bound — stage 2 (§11).

For the whitened signal w = (√Σ)⁻¹ s(X) with covariance matrix C:

  * var_lincomb — Var(Σ_j c_j w_j) = cᵀ C c.
  * cov_isHermitian — C is symmetric.
  * rotSignal_eigen — rotating into an orthonormal basis b makes the i-th
    coordinate ⟨b_i, w⟩ = Σ_j (b_i)_j w_j.
  * var_rot_eq_eigenvalue — in C's eigenbasis each rotated coordinate has
    variance exactly the eigenvalue λ_i.
  * det_one_add — det(I + C) = Π_i (1 + λ_i).
  * logdet_channel_bound — I(X ; s(X) + Z) ≤ ½ ln det(I + C): the calibrated
    channel bound of §11 in its exact form,
    C = Cov((√Σ)⁻¹ s(X)) = Σ^(−1/2) Cov(s(X)) Σ^(−1/2).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Rotation
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic

open MeasureTheory ProbabilityTheory InformationTheory Matrix WithLp Finset Polynomial
open scoped ENNReal NNReal MatrixOrder RealInnerProductSpace

namespace Snuffy.LogDet

open Snuffy.GaussianVector Snuffy.Whitening Snuffy.Rotation

variable {α : Type*} [MeasurableSpace α] {n : ℕ} (P : Measure α) [IsProbabilityMeasure P]

/-- The covariance matrix of a vector signal. -/
noncomputable def cov (w : Fin n → α → ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  fun j k => ∫ x, (w j x - ∫ y, w j y ∂P) * (w k x - ∫ y, w k y ∂P) ∂P

omit [IsProbabilityMeasure P] in
theorem cov_isHermitian (w : Fin n → α → ℝ) : (cov P w).IsHermitian := by
  refine Matrix.IsHermitian.ext fun j k => ?_
  simp only [star_trivial, cov]
  congr 1
  funext x
  ring

/-- **Variance of a linear combination.** `Var(Σ_j c_j w_j) = cᵀ C c`. -/
theorem var_lincomb (w : Fin n → α → ℝ) (hX : ∀ j, MemLp (w j) 2 P) (c : Fin n → ℝ) :
    ∫ x, ((∑ j, c j * w j x) - ∫ y, (∑ j, c j * w j y) ∂P) ^ 2 ∂P = c ⬝ᵥ (cov P w *ᵥ c) := by
  set m : Fin n → ℝ := fun j => ∫ y, w j y ∂P with hm
  have hint : ∀ j, Integrable (w j) P := fun j => (hX j).integrable one_le_two
  have hmean : ∫ y, (∑ j, c j * w j y) ∂P = ∑ j, c j * m j := by
    rw [integral_finsetSum _ (fun j _ => (hint j).const_mul (c j))]
    exact sum_congr rfl fun j _ => integral_const_mul _ _
  have hd : ∀ j, MemLp (fun x => w j x - m j) 2 P := fun j => (hX j).sub (memLp_const _)
  have hprod : ∀ j k, Integrable (fun x => (w j x - m j) * (w k x - m k)) P := fun j k => by
    have := (hd j).integrable_mul (hd k)
    exact this
  rw [hmean]
  have hexp : ∀ x, ((∑ j, c j * w j x) - ∑ j, c j * m j) ^ 2
      = ∑ j, ∑ k, c j * c k * ((w j x - m j) * (w k x - m k)) := by
    intro x
    rw [← sum_sub_distrib, sq, sum_mul_sum]
    exact sum_congr rfl fun j _ => sum_congr rfl fun k _ => by ring
  simp_rw [hexp]
  rw [integral_finsetSum _ (fun j _ => integrable_finsetSum _ (fun k _ => (hprod j k).const_mul _))]
  have hinner : ∀ j, ∫ x, ∑ k, c j * c k * ((w j x - m j) * (w k x - m k)) ∂P
      = ∑ k, c j * c k * cov P w j k := by
    intro j
    rw [integral_finsetSum _ (fun k _ => (hprod j k).const_mul _)]
    exact sum_congr rfl fun k _ => integral_const_mul _ _
  simp_rw [hinner]
  simp only [dotProduct, mulVec, mul_sum]
  exact sum_congr rfl fun j _ => sum_congr rfl fun k _ => by ring

variable {s : α → EuclideanSpace ℝ (Fin n)} {S : Matrix (Fin n) (Fin n) ℝ}

omit [MeasurableSpace α] in
/-- Rotating into an orthonormal basis: the i-th coordinate is `⟨b_i, w⟩`. -/
theorem rotSignal_eigen (s : α → EuclideanSpace ℝ (Fin n)) (S : Matrix (Fin n) (Fin n) ℝ)
    (b : OrthonormalBasis (Fin n) ℝ (EuclideanSpace ℝ (Fin n))) (i : Fin n) (x : α) :
    rotSignal b.repr s S i x = ∑ j, b i j * whtSignal s S j x := by
  unfold rotSignal whtSignal
  have h := b.repr_apply_apply (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x)) i
  simp only [PiLp.inner_apply, RCLike.inner_apply, conj_trivial] at h
  rw [show ofLp (b.repr (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x))) i
    = b.repr (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x)) i from rfl, h]
  exact sum_congr rfl fun j _ => by rw [mul_comm]

/-- **In the eigenbasis each coordinate's variance is the eigenvalue.** -/
theorem var_rot_eq_eigenvalue (hX : ∀ j, MemLp (whtSignal s S j) 2 P) (i : Fin n) :
    varW P (rotSignal (cov_isHermitian P (whtSignal s S)).eigenvectorBasis.repr s S) i
      = (cov_isHermitian P (whtSignal s S)).eigenvalues i := by
  set hC := cov_isHermitian P (whtSignal s S)
  set b := hC.eigenvectorBasis
  unfold varW
  simp only [rotSignal_eigen s S b i]
  rw [var_lincomb P _ hX, hC.mulVec_eigenvectorBasis i, dotProduct_smul, smul_eq_mul]
  have hnorm : ⇑(b i) ⬝ᵥ ⇑(b i) = 1 := by
    have h1 : ⟪b i, b i⟫ = 1 := by
      rw [real_inner_self_eq_norm_sq, b.orthonormal.1 i, one_pow]
    simp only [PiLp.inner_apply, RCLike.inner_apply, conj_trivial] at h1
    simp only [dotProduct]
    rw [← h1]
  rw [show hC.eigenvectorBasis i = b i from rfl, hnorm, mul_one]

/-- **det(I + C) = Π (1 + λ_i)** for a symmetric matrix. -/
theorem det_one_add (C : Matrix (Fin n) (Fin n) ℝ) (hC : C.IsHermitian) :
    (1 + C).det = ∏ i, (1 + hC.eigenvalues i) := by
  have h1 := eval_charpoly C (-1)
  rw [hC.charpoly_eq] at h1
  simp only [eval_prod, eval_sub, eval_X, eval_C, RCLike.ofReal_real_eq_id, id] at h1
  have hscal : Matrix.scalar (Fin n) (-1 : ℝ) - C = -(1 + C) := by
    ext i j
    simp only [Matrix.scalar_apply, Matrix.sub_apply, Matrix.neg_apply, Matrix.add_apply,
      Matrix.diagonal_apply, Matrix.one_apply]
    split_ifs <;> ring
  rw [hscal, det_neg, Fintype.card_fin] at h1
  have hprod : ∏ i, (-1 - hC.eigenvalues i) = (-1) ^ n * ∏ i, (1 + hC.eigenvalues i) := by
    rw [show ((-1 : ℝ)) ^ n = ∏ _i : Fin n, (-1 : ℝ) by simp, ← prod_mul_distrib]
    exact prod_congr rfl fun i _ => by ring
  rw [hprod] at h1
  exact (mul_left_cancel₀ (pow_ne_zero _ (by norm_num)) h1).symm

/-- **The exact log-det form of the Gaussian channel bound (§11).** For any
input law on a standard Borel space, signal `s`, positive-definite noise
covariance `Σ`, and whitened signal of finite second moment with covariance
matrix `C = Cov((√Σ)⁻¹ s(X))`, `I(X ; s(X) + Z) ≤ ½ ln det(I + C)`. -/
theorem logdet_channel_bound [StandardBorelSpace α] [Nonempty α] (hs : Measurable s)
    (hS : S.PosDef) (hX : ∀ j, MemLp (whtSignal s S j) 2 P) :
    Snuffy.Information.mutualInfo (P ⊗ₘ corrChan s hs S)
      ≤ ENNReal.ofReal (Real.log (1 + cov P (whtSignal s S)).det / 2) := by
  set hC := cov_isHermitian P (whtSignal s S)
  set b := hC.eigenvectorBasis
  have hXr : ∀ i, MemLp (rotSignal b.repr s S i) 2 P := fun i => by
    have hfun : rotSignal b.repr s S i = fun x => ∑ j, b i j * whtSignal s S j x :=
      funext (rotSignal_eigen s S b i)
    rw [hfun]
    exact memLp_finsetSum _ fun j _ => (hX j).const_mul _
  have h := rotated_channel_bound P s hs hS b.repr hXr
  have hvar : ∀ i, varW P (rotSignal b.repr s S) i = hC.eigenvalues i :=
    var_rot_eq_eigenvalue P hX
  simp_rw [hvar] at h
  refine h.trans (le_of_eq ?_)
  have hpos : ∀ i, 0 < 1 + hC.eigenvalues i := fun i => by
    have := varW_nonneg P (rotSignal b.repr s S) i
    rw [hvar i] at this
    linarith
  rw [det_one_add _ hC, Real.log_prod (fun i _ => (hpos i).ne'), sum_div]

end Snuffy.LogDet
