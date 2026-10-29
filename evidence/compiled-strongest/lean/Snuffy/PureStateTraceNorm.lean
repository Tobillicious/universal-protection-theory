/-
Snuffy — Canon Edition 4.2 working: the pure-state trace-distance identity
(§23.3; G.13).

The trace norm of a Hermitian matrix is the sum of the absolute values of its
eigenvalues. For unit vectors `ψ, φ` and `A = |ψ⟩⟨ψ| − |φ⟩⟨φ|`,

  ‖A‖₁ = 2 √(1 − |⟨ψ, φ⟩|²).

  * sum_sq_eigenvalues — `Σ λᵢ² = Tr(A²)` for a Hermitian matrix (spectral
    theorem).
  * eigenvalue_cube — if `A³ = c A`, every eigenvalue satisfies `λ³ = c λ`.
  * pure_cube — `(|ψ⟩⟨ψ| − |φ⟩⟨φ|)³ = (1 − |⟨ψ, φ⟩|²)(|ψ⟩⟨ψ| − |φ⟩⟨φ|)`.
  * pure_trace_sq — `Tr(A²) = 2(1 − |⟨ψ, φ⟩|²)`.
  * pure_trace_norm — the identity. With `PureStateDistance.pure_infidelity_le`
    it gives `‖A‖₁ ≤ 2‖ψ − φ‖` for unit state vectors.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.LinearAlgebra.Matrix.Trace

open Matrix

namespace Snuffy.PureStateTraceNorm

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- The trace norm of a Hermitian matrix. -/
noncomputable def traceNorm {A : Matrix n n ℂ} (hA : A.IsHermitian) : ℝ :=
  ∑ i, |hA.eigenvalues i|

theorem sum_sq_eigenvalues {A : Matrix n n ℂ} (hA : A.IsHermitian) :
    ((∑ i, hA.eigenvalues i ^ 2 : ℝ) : ℂ) = trace (A * A) := by
  set U : Matrix n n ℂ := (hA.eigenvectorUnitary : Matrix n n ℂ)
  set D : Matrix n n ℂ := diagonal (RCLike.ofReal ∘ hA.eigenvalues)
  have hs : A = U * D * star U := by
    have h := hA.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    exact h
  have hUU : star U * U = 1 := Unitary.coe_star_mul_self hA.eigenvectorUnitary
  have hAA : A * A = U * (D * D) * star U := by
    rw [hs]
    calc U * D * star U * (U * D * star U) = U * D * (star U * U) * D * star U := by
          simp only [Matrix.mul_assoc]
      _ = U * (D * D) * star U := by rw [hUU, Matrix.mul_one]; simp only [Matrix.mul_assoc]
  rw [hAA, trace_mul_cycle, ← Matrix.mul_assoc, hUU, Matrix.one_mul, diagonal_mul_diagonal,
    trace_diagonal]
  push_cast
  refine Finset.sum_congr rfl fun i _ => ?_
  simp [Function.comp, sq]

theorem eigenvalue_cube {A : Matrix n n ℂ} (hA : A.IsHermitian) {c : ℝ}
    (h3 : A * A * A = (c : ℂ) • A) (i : n) :
    hA.eigenvalues i ^ 3 = c * hA.eigenvalues i := by
  set v : n → ℂ := ⇑(hA.eigenvectorBasis i)
  set l : ℝ := hA.eigenvalues i
  have hv : A *ᵥ v = (l : ℂ) • v := by
    rw [hA.mulVec_eigenvectorBasis i]
    rfl
  have hne : v ≠ 0 := by
    intro h0
    have h1 := (hA.eigenvectorBasis).orthonormal.1 i
    have : (hA.eigenvectorBasis i) = 0 := by
      ext j
      exact congrFun h0 j
    rw [this, norm_zero] at h1
    exact zero_ne_one h1
  have h2 : A *ᵥ (A *ᵥ v) = ((l : ℂ) ^ 2) • v := by
    rw [hv, mulVec_smul, hv, smul_smul, sq]
  have h3' : A *ᵥ (A *ᵥ (A *ᵥ v)) = ((l : ℂ) ^ 3) • v := by
    rw [h2, mulVec_smul, hv, smul_smul]
    ring_nf
  have hlhs : (A * A * A) *ᵥ v = ((l : ℂ) ^ 3) • v := by
    rw [← mulVec_mulVec, ← mulVec_mulVec]
    exact h3'
  have hcA : ((c : ℂ) • A) *ᵥ v = (c : ℂ) • (A *ᵥ v) := by
    ext j
    simp [mulVec, dotProduct, Finset.mul_sum, mul_assoc]
  have hrhs : ((c : ℂ) • A) *ᵥ v = ((c : ℂ) * l) • v := by
    rw [hcA, hv, smul_smul]
  have heq : ((l : ℂ) ^ 3) • v = ((c : ℂ) * l) • v := by
    rw [← hlhs, ← hrhs, h3]
  have hsc : (l : ℂ) ^ 3 = (c : ℂ) * l := by
    by_contra hneq
    apply hne
    have h0 : ((l : ℂ) ^ 3 - (c : ℂ) * l) • v = 0 := by rw [sub_smul, heq, sub_self]
    exact (smul_eq_zero.mp h0).resolve_left (sub_ne_zero.mpr hneq)
  exact_mod_cast hsc

/-- The pure-state difference. -/
def pureDiff (ψ φ : n → ℂ) : Matrix n n ℂ :=
  vecMulVec ψ (star ψ) - vecMulVec φ (star φ)

omit [Fintype n] [DecidableEq n] in
theorem pureDiff_hermitian (ψ φ : n → ℂ) : (pureDiff ψ φ).IsHermitian := by
  unfold pureDiff Matrix.IsHermitian
  rw [conjTranspose_sub, conjTranspose_vecMulVec, conjTranspose_vecMulVec, star_star, star_star]

section Pure

variable (ψ φ : n → ℂ)

omit [Fintype n] [DecidableEq n] in
theorem vmv_smul (u x : n → ℂ) (a : ℂ) : vecMulVec u (a • x) = a • vecMulVec u x := by
  ext i j
  simp [vecMulVec, mul_left_comm]

omit [DecidableEq n] in
theorem star_dot_swap : star φ ⬝ᵥ ψ = star (star ψ ⬝ᵥ φ) := by
  simp only [dotProduct, star_sum, Pi.star_apply, star_mul', star_star]
  exact Finset.sum_congr rfl fun i _ => mul_comm _ _

variable {ψ φ} (hψ : star ψ ⬝ᵥ ψ = 1) (hφ : star φ ⬝ᵥ φ = 1)
include hψ hφ

theorem pure_cube :
    pureDiff ψ φ * pureDiff ψ φ * pureDiff ψ φ =
      ((1 - Complex.normSq (star ψ ⬝ᵥ φ) : ℝ) : ℂ) • pureDiff ψ φ := by
  set P := vecMulVec ψ (star ψ)
  set Q := vecMulVec φ (star φ)
  set t : ℂ := ((Complex.normSq (star ψ ⬝ᵥ φ) : ℝ) : ℂ)
  have hzt : (star ψ ⬝ᵥ φ) * star (star ψ ⬝ᵥ φ) = t := by
    rw [Complex.star_def, Complex.mul_conj]
  have hzt' : star (star ψ ⬝ᵥ φ) * (star ψ ⬝ᵥ φ) = t := by rw [mul_comm]; exact hzt
  have hPP : P * P = P := by
    rw [vecMulVec_mul_vecMulVec, hψ, one_smul]
  have hQQ : Q * Q = Q := by
    rw [vecMulVec_mul_vecMulVec, hφ, one_smul]
  have hPQP : P * Q * P = t • P := by
    rw [vecMulVec_mul_vecMulVec, vmv_smul, Matrix.smul_mul, vecMulVec_mul_vecMulVec, vmv_smul,
      smul_smul, star_dot_swap ψ φ, hzt]
  have hQPQ : Q * P * Q = t • Q := by
    rw [vecMulVec_mul_vecMulVec, vmv_smul, Matrix.smul_mul, vecMulVec_mul_vecMulVec, vmv_smul,
      smul_smul, star_dot_swap ψ φ, hzt']
  have hPQQ : P * Q * Q = P * Q := by rw [Matrix.mul_assoc, hQQ]
  have hQPP : Q * P * P = Q * P := by rw [Matrix.mul_assoc, hPP]
  have hPPQ : P * P * Q = P * Q := by rw [hPP]
  have hQQP : Q * Q * P = Q * P := by rw [hQQ]
  have hPPP : P * P * P = P := by rw [hPP, hPP]
  have hQQQ : Q * Q * Q = Q := by rw [hQQ, hQQ]
  unfold pureDiff
  calc (P - Q) * (P - Q) * (P - Q)
      = P * P * P - P * P * Q - P * Q * P + P * Q * Q - Q * P * P + Q * P * Q
          + Q * Q * P - Q * Q * Q := by noncomm_ring
    _ = P - P * Q - t • P + P * Q - Q * P + t • Q + Q * P - Q := by
        rw [hPPP, hPPQ, hPQP, hPQQ, hQPP, hQPQ, hQQP, hQQQ]
    _ = ((1 - Complex.normSq (star ψ ⬝ᵥ φ) : ℝ) : ℂ) • (P - Q) := by
        rw [Complex.ofReal_sub, Complex.ofReal_one, sub_smul, one_smul, smul_sub]
        abel

omit [DecidableEq n] in
theorem pure_trace_sq :
    trace (pureDiff ψ φ * pureDiff ψ φ) = 2 * ((1 - Complex.normSq (star ψ ⬝ᵥ φ) : ℝ) : ℂ) := by
  set z := star ψ ⬝ᵥ φ
  have hP : trace (vecMulVec ψ (star ψ)) = 1 := by
    rw [trace_vecMulVec, dotProduct_comm, hψ]
  have hQ : trace (vecMulVec φ (star φ)) = 1 := by
    rw [trace_vecMulVec, dotProduct_comm, hφ]
  have hPQ : trace (vecMulVec ψ (star ψ) * vecMulVec φ (star φ)) =
      ((Complex.normSq z : ℝ) : ℂ) := by
    rw [vecMulVec_mul_vecMulVec, vmv_smul, trace_smul, trace_vecMulVec, dotProduct_comm ψ (star φ),
      star_dot_swap ψ φ, smul_eq_mul, Complex.star_def, Complex.mul_conj]
  have hQP : trace (vecMulVec φ (star φ) * vecMulVec ψ (star ψ)) =
      ((Complex.normSq z : ℝ) : ℂ) := by
    rw [trace_mul_comm]; exact hPQ
  have hPP : vecMulVec ψ (star ψ) * vecMulVec ψ (star ψ) = vecMulVec ψ (star ψ) := by
    rw [vecMulVec_mul_vecMulVec, hψ, one_smul]
  have hQQ : vecMulVec φ (star φ) * vecMulVec φ (star φ) = vecMulVec φ (star φ) := by
    rw [vecMulVec_mul_vecMulVec, hφ, one_smul]
  unfold pureDiff
  rw [sub_mul, mul_sub, mul_sub, hPP, hQQ, trace_sub, trace_sub, trace_sub, hP, hQ, hPQ, hQP]
  push_cast
  ring

/-- **The pure-state trace-distance identity.** -/
theorem pure_trace_norm :
    traceNorm (pureDiff_hermitian ψ φ) = 2 * Real.sqrt (1 - Complex.normSq (star ψ ⬝ᵥ φ)) := by
  set hA := pureDiff_hermitian ψ φ
  set c : ℝ := 1 - Complex.normSq (star ψ ⬝ᵥ φ)
  have hcube := eigenvalue_cube hA (pure_cube hψ hφ)
  have hsq : ∑ i, hA.eigenvalues i ^ 2 = 2 * c := by
    have h := sum_sq_eigenvalues hA
    rw [pure_trace_sq hψ hφ] at h
    exact_mod_cast h
  have hc0 : 0 ≤ c := by
    have : 0 ≤ ∑ i, hA.eigenvalues i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
    linarith
  set s := Real.sqrt c
  have hs0 : 0 ≤ s := Real.sqrt_nonneg c
  have hss : s * s = c := Real.mul_self_sqrt hc0
  have hterm : ∀ i, |hA.eigenvalues i| * s = hA.eigenvalues i ^ 2 := by
    intro i
    have h : hA.eigenvalues i ^ 3 = c * hA.eigenvalues i := hcube i
    have hcases : hA.eigenvalues i = 0 ∨ hA.eigenvalues i ^ 2 = c := by
      by_cases h0 : hA.eigenvalues i = 0
      · exact Or.inl h0
      · right
        have : hA.eigenvalues i * (hA.eigenvalues i ^ 2 - c) = 0 := by ring_nf; linarith
        rcases mul_eq_zero.mp this with h1 | h1
        · exact absurd h1 h0
        · linarith
    rcases hcases with h0 | h2
    · rw [h0]; simp
    · have habs : |hA.eigenvalues i| = s := by
        rw [← Real.sqrt_sq_eq_abs, h2]
      rw [habs, hss, h2]
  unfold traceNorm
  rcases eq_or_lt_of_le hs0 with hs | hs
  · -- s = 0: every eigenvalue vanishes
    have hc : c = 0 := by rw [← hss, ← hs, mul_zero]
    have hzero : ∀ i, hA.eigenvalues i = 0 := by
      intro i
      have h : hA.eigenvalues i ^ 3 = c * hA.eigenvalues i := hcube i
      rw [hc, zero_mul] at h
      exact pow_eq_zero_iff (by norm_num) |>.mp h
    simp [hzero, ← hs]
  · have hsum : (∑ i, |hA.eigenvalues i|) * s = 2 * s * s := by
      rw [Finset.sum_mul]
      simp_rw [hterm]
      rw [hsq, ← hss]
      ring
    have := mul_right_cancel₀ hs.ne' hsum
    linarith

end Pure

end Snuffy.PureStateTraceNorm
