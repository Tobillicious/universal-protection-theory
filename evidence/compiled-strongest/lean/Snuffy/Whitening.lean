/-
Snuffy — Canon Edition v4.1: correlated Gaussian noise by whitening — block 5
of the Gaussian maximum-entropy bound (§11).

The channel of §11 is Y = s(X) + Z with Z ~ N(0, Σ), Σ positive definite (the
canon's Σ_h ≥ σ² I). With the whitening matrix B = (√Σ)⁻¹:

  * mutualInfo_map_snd_equiv, mutualInfo_kernel_map_equiv — mutual information
    is invariant under measurable equivalences of the output.
  * pi_eq_map_eSucc, vecChan_apply — the vector kernel of block 4c is the product
    of independent Gaussians.
  * multivariateGaussian_one_eq_pi — N(m, I) is the product of N(m_i, 1).
  * whiten — B · N(μ, Σ) = N(Bμ, I), exactly (B √Σ = I).
  * correlated_channel_bound — I(X ; Y) ≤ Σ_i ½ ln(1 + Var (B s(X))_i): the
    Gaussian maximum-entropy bound for correlated noise, every input law on a
    standard Borel space included.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.GaussianVector
import Mathlib.Probability.Distributions.Gaussian.Multivariate

open MeasureTheory ProbabilityTheory InformationTheory Matrix WithLp Finset
open scoped ENNReal NNReal MatrixOrder

namespace Snuffy.Whitening

open Snuffy.GaussianVector Snuffy.GaussianChannelGen

/-! ## Mutual information is invariant under output equivalences -/

section Invariance

variable {α β γ : Type*} [MeasurableSpace α] [MeasurableSpace β] [MeasurableSpace γ]

theorem mutualInfo_map_snd_equiv (J : Measure (α × β)) [IsFiniteMeasure J] (e : β ≃ᵐ γ) :
    Snuffy.Information.mutualInfo (J.map (Prod.map id e)) = Snuffy.Information.mutualInfo J := by
  have hg : Measurable (Prod.map (id : α → α) e) := measurable_id.prodMap e.measurable
  have hfst : (J.map (Prod.map id e)).fst = J.fst := by
    rw [Measure.fst, Measure.map_map measurable_fst hg]
    rfl
  have hsnd : (J.map (Prod.map id e)).snd = J.snd.map e := by
    rw [Measure.snd, Measure.map_map measurable_snd hg, Measure.snd,
      Measure.map_map e.measurable measurable_snd]
    rfl
  unfold Snuffy.Information.mutualInfo
  rw [hfst, hsnd]
  have hprod : J.fst.prod (J.snd.map e) = (J.fst.prod J.snd).map (Prod.map id e) := by
    rw [← Measure.map_prod_map J.fst J.snd measurable_id e.measurable, Measure.map_id]
  rw [hprod]
  exact Snuffy.KLAdditivity.klDiv_map_equiv
    (MeasurableEquiv.prodCongr (MeasurableEquiv.refl α) e) J (J.fst.prod J.snd)

theorem mutualInfo_kernel_map_equiv (P : Measure α) [IsFiniteMeasure P] (κ : Kernel α β)
    [IsMarkovKernel κ] (e : β ≃ᵐ γ) :
    Snuffy.Information.mutualInfo (P ⊗ₘ κ.map e) = Snuffy.Information.mutualInfo (P ⊗ₘ κ) := by
  rw [Measure.compProd_map e.measurable]
  exact mutualInfo_map_snd_equiv _ e

end Invariance

/-! ## The vector kernel is a product of independent Gaussians -/

theorem pi_eq_map_eSucc {n : ℕ} (μ : Fin (n + 1) → Measure ℝ) [∀ i, SigmaFinite (μ i)] :
    Measure.pi μ = ((μ 0).prod (Measure.pi fun i : Fin n => μ i.succ)).map (eSucc n).symm := by
  have h := (measurePreserving_piFinSuccAbove μ 0).map_eq
  simp only [Fin.succAbove_zero] at h
  have h' : (Measure.pi μ).map (eSucc n) = (μ 0).prod (Measure.pi fun i : Fin n => μ i.succ) := h
  rw [← h', Measure.map_map (eSucc n).symm.measurable (eSucc n).measurable,
    MeasurableEquiv.symm_comp_self, Measure.map_id]

theorem vecChan_apply {α : Type*} [MeasurableSpace α] (v : ℝ≥0) :
    ∀ (n : ℕ) (w : Fin n → α → ℝ) (hw : ∀ i, Measurable (w i)) (x : α),
    vecChan v n w hw x = Measure.pi (fun i => gaussianReal (w i x) v)
  | 0, w, hw, x => by
    rw [Measure.pi_of_empty (x := fun i => Fin.elim0 i)]
    rfl
  | n + 1, w, hw, x => by
    have := isMarkov_vecChan v n (fun i => w i.succ) (fun i => hw i.succ)
    show ((chanW (w 0) (hw 0) v ×ₖ vecChan v n (fun i => w i.succ) (fun i => hw i.succ)).map
      (eSucc n).symm) x = _
    rw [Kernel.map_apply _ (eSucc n).symm.measurable, Kernel.prod_apply, chanW_apply,
      vecChan_apply v n (fun i => w i.succ) (fun i => hw i.succ) x, pi_eq_map_eSucc]

/-! ## Multivariate Gaussians: identity covariance and whitening -/

section Gaussian

variable {n : ℕ}

/-- `N(m, I)` is the product of independent `N(m_i, 1)`. -/
theorem multivariateGaussian_one_eq_pi (m : EuclideanSpace ℝ (Fin n)) :
    multivariateGaussian m 1
      = (Measure.pi fun i => gaussianReal (ofLp m i) 1).map (toLp 2) := by
  rw [multivariateGaussian, CFC.sqrt_one, map_one, ← map_pi_eq_stdGaussian,
    Measure.map_map (by fun_prop) (by fun_prop)]
  have hcomp : (fun x : EuclideanSpace ℝ (Fin n) =>
        m + (1 : EuclideanSpace ℝ (Fin n) →L[ℝ] EuclideanSpace ℝ (Fin n)) x) ∘ toLp 2
      = toLp 2 ∘ (fun x : Fin n → ℝ => fun i => ofLp m i + x i) := by
    funext x
    simp only [Function.comp_apply]
    ext i
    simp
  rw [hcomp, ← Measure.map_map (by fun_prop) (by fun_prop),
    Measure.pi_map_pi (fun i => (measurable_const_add (ofLp m i)).aemeasurable)]
  congr 2
  funext i
  rw [gaussianReal_map_const_add, zero_add]

variable {S : Matrix (Fin n) (Fin n) ℝ}

/-- The whitening matrix `(√Σ)⁻¹`. -/
noncomputable def wht (S : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := (CFC.sqrt S)⁻¹

theorem isUnit_det_sqrt (hS : S.PosDef) : IsUnit (CFC.sqrt S).det := by
  have h0 : (0 : Matrix (Fin n) (Fin n) ℝ) ≤ S := hS.posSemidef.nonneg
  have hsq : CFC.sqrt S * CFC.sqrt S = S := CFC.sqrt_mul_sqrt_self S h0
  have hdet : S.det ≠ 0 := hS.det_pos.ne'
  rw [isUnit_iff_ne_zero]
  intro h
  apply hdet
  rw [← hsq, det_mul, h, zero_mul]

theorem wht_mul_sqrt (hS : S.PosDef) : wht S * CFC.sqrt S = 1 :=
  nonsing_inv_mul _ (isUnit_det_sqrt hS)

theorem sqrt_mul_wht (hS : S.PosDef) : CFC.sqrt S * wht S = 1 :=
  mul_nonsing_inv _ (isUnit_det_sqrt hS)

theorem toEuclideanCLM_mul_apply (A C : Matrix (Fin n) (Fin n) ℝ) (x : EuclideanSpace ℝ (Fin n)) :
    toEuclideanCLM (𝕜 := ℝ) A (toEuclideanCLM (𝕜 := ℝ) C x) = toEuclideanCLM (𝕜 := ℝ) (A * C) x := by
  rw [map_mul]
  rfl

/-- **Whitening.** `(√Σ)⁻¹ · N(μ, Σ) = N((√Σ)⁻¹ μ, I)`. -/
theorem whiten (hS : S.PosDef) (μ : EuclideanSpace ℝ (Fin n)) :
    (multivariateGaussian μ S).map (toEuclideanCLM (𝕜 := ℝ) (wht S))
      = multivariateGaussian (toEuclideanCLM (𝕜 := ℝ) (wht S) μ) 1 := by
  rw [multivariateGaussian, multivariateGaussian, Measure.map_map (by fun_prop) (by fun_prop),
    CFC.sqrt_one, map_one]
  congr 1
  funext x
  simp only [Function.comp_apply, map_add,
    toEuclideanCLM_mul_apply, wht_mul_sqrt hS, map_one]

/-- Whitening as a measurable equivalence of the output space. -/
noncomputable def whtEquiv (hS : S.PosDef) : EuclideanSpace ℝ (Fin n) ≃ᵐ EuclideanSpace ℝ (Fin n) where
  toFun := toEuclideanCLM (𝕜 := ℝ) (wht S)
  invFun := toEuclideanCLM (𝕜 := ℝ) (CFC.sqrt S)
  left_inv x := by
    show toEuclideanCLM (𝕜 := ℝ) (CFC.sqrt S) (toEuclideanCLM (𝕜 := ℝ) (wht S) x) = x
    rw [toEuclideanCLM_mul_apply, sqrt_mul_wht hS, map_one]; rfl
  right_inv x := by
    show toEuclideanCLM (𝕜 := ℝ) (wht S) (toEuclideanCLM (𝕜 := ℝ) (CFC.sqrt S) x) = x
    rw [toEuclideanCLM_mul_apply, wht_mul_sqrt hS, map_one]; rfl
  measurable_toFun := (toEuclideanCLM (𝕜 := ℝ) (wht S)).continuous.measurable
  measurable_invFun := (toEuclideanCLM (𝕜 := ℝ) (CFC.sqrt S)).continuous.measurable

end Gaussian

/-! ## The correlated-noise channel -/

section Channel

variable {α : Type*} [MeasurableSpace α] {n : ℕ}

/-- The channel `x ↦ N(s x, Σ)` on `ℝⁿ`. -/
noncomputable def corrChan (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s)
    (S : Matrix (Fin n) (Fin n) ℝ) : Kernel α (EuclideanSpace ℝ (Fin n)) where
  toFun x := multivariateGaussian (s x) S
  measurable' := measurable_multivariateGaussian.comp (hs.prodMk measurable_const)

theorem corrChan_apply (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s)
    (S : Matrix (Fin n) (Fin n) ℝ) (x : α) : corrChan s hs S x = multivariateGaussian (s x) S := rfl

instance (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s) (S : Matrix (Fin n) (Fin n) ℝ) :
    IsMarkovKernel (corrChan s hs S) :=
  ⟨fun x => by rw [corrChan_apply]; infer_instance⟩

/-- The whitened signal coordinates `w_i(x) = ((√Σ)⁻¹ s(x))_i`. -/
noncomputable def whtSignal (s : α → EuclideanSpace ℝ (Fin n)) (S : Matrix (Fin n) (Fin n) ℝ)
    (i : Fin n) (x : α) : ℝ :=
  ofLp (toEuclideanCLM (𝕜 := ℝ) (wht S) (s x)) i

theorem measurable_whtSignal (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s)
    (S : Matrix (Fin n) (Fin n) ℝ) (i : Fin n) : Measurable (whtSignal s S i) := by
  unfold whtSignal
  have h1 : Measurable fun x => toEuclideanCLM (𝕜 := ℝ) (wht S) (s x) :=
    (toEuclideanCLM (𝕜 := ℝ) (wht S)).continuous.measurable.comp hs
  exact ((measurable_pi_apply i).comp (WithLp.measurable_ofLp 2 _)).comp h1

/-- **The Gaussian maximum-entropy bound with correlated noise.** For any input
law on a standard Borel space, signal `s`, and positive-definite noise
covariance `Σ`, with whitened signals of finite second moment,
`I(X ; s(X) + Z) ≤ Σ_i ½ ln(1 + Var ((√Σ)⁻¹ s(X))_i)`. -/
theorem correlated_channel_bound [StandardBorelSpace α] [Nonempty α] (P : Measure α)
    [IsProbabilityMeasure P] (s : α → EuclideanSpace ℝ (Fin n)) (hs : Measurable s)
    {S : Matrix (Fin n) (Fin n) ℝ} (hS : S.PosDef)
    (hX : ∀ i, MemLp (whtSignal s S i) 2 P) :
    Snuffy.Information.mutualInfo (P ⊗ₘ corrChan s hs S)
      ≤ ENNReal.ofReal (∑ i, Real.log (1 + varW P (whtSignal s S) i) / 2) := by
  have hw := measurable_whtSignal s hs S
  have := isMarkov_vecChan (1 : ℝ≥0) n (whtSignal s S) hw
  rw [← mutualInfo_kernel_map_equiv P (corrChan s hs S) (whtEquiv hS)]
  have hk : (corrChan s hs S).map (whtEquiv hS)
      = (vecChan 1 n (whtSignal s S) hw).map (MeasurableEquiv.toLp 2 (Fin n → ℝ)) := by
    ext x : 1
    rw [Kernel.map_apply _ (whtEquiv hS).measurable,
      Kernel.map_apply _ (MeasurableEquiv.toLp 2 (Fin n → ℝ)).measurable, corrChan_apply,
      vecChan_apply]
    show (multivariateGaussian (s x) S).map (toEuclideanCLM (𝕜 := ℝ) (wht S)) = _
    rw [whiten hS, multivariateGaussian_one_eq_pi]
    rfl
  rw [hk, mutualInfo_kernel_map_equiv]
  have h := vector_channel_bound (v := 1) one_ne_zero P n (whtSignal s S) hw hX
  simpa only [NNReal.coe_one, div_one] using h

end Channel

end Snuffy.Whitening
