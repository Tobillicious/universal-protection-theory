/-
Snuffy — Canon Edition v4.1: guard 1 in its quantum form — Landauer's bound
for density matrices under unitary coupling to a thermal bath (Reeb–Wolf),
machine-checked (§18 stroke III; canon §8.1 guard 1; §23.8).

States are density matrices (positive semidefinite, trace one) on finite-
dimensional Hilbert spaces; the entropy is the von Neumann entropy
S(ρ) = −Σ λ log λ over the eigenvalues of ρ.

  * vnEnt_congr, vnEnt_unitary_conj, vnEnt_diagonal — the entropy depends only
    on the characteristic polynomial: unitary invariance, diagonal states.
  * vnEnt_le_diag — pinching: for every orthonormal basis, S(ρ) is at most the
    Shannon entropy of the diagonal of ρ in that basis.
  * vnEnt_le_energy, vnEnt_gibbsState — the quantum Gibbs bound
    S(ρ) ≤ β Tr(ρH) + ln Z, with equality at the Gibbs state.
  * ptrA_conj, ptrB_conj — partial traces in a product basis.
  * vnEnt_init — S(ρ_A ⊗ γ) = S(ρ_A) + S(γ).
  * quantum_landauer — for every unitary coupling W of a register in state ρ_A
    to a bath in its Gibbs state γ, S(ρ_A) − S(ρ′_A) ≤ β ΔQ_B, where
    ΔQ_B = Tr(ρ′_B H) − Tr(γ H) (Reeb–Wolf).
  * quantum_guard_one — βQ_B ≥ I_M + D_err + δ_I whenever the unitary reset
    removes that much von Neumann entropy from the register: the canon's
    guard 1 in its quantum form.
  * quantum_cycle_work_floor — `ThermoLedger.cycle_work_floor` with quantum
    guard 1 derived.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Landauer
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Analysis.Matrix.PosDef
import Mathlib.Analysis.Matrix.Order
import Mathlib.Analysis.Convex.Jensen
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic

open Matrix Finset Real
open scoped ComplexOrder

namespace Snuffy.QuantumLandauer

open Snuffy.Landauer

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ## Von Neumann entropy -/

/-- The von Neumann entropy `S(A) = Σ negMulLog(λ_i)` of a Hermitian matrix. -/
noncomputable def vnEnt {A : Matrix n n ℂ} (hA : A.IsHermitian) : ℝ :=
  ∑ i, negMulLog (hA.eigenvalues i)

theorem vnEnt_eq_roots {A : Matrix n n ℂ} (hA : A.IsHermitian) :
    vnEnt hA = (A.charpoly.roots.map fun z : ℂ => negMulLog z.re).sum := by
  rw [hA.roots_charpoly_eq_eigenvalues, Multiset.map_map]
  unfold vnEnt Finset.sum
  congr 1

/-- The entropy depends only on the characteristic polynomial. -/
theorem vnEnt_congr {A B : Matrix n n ℂ} (hA : A.IsHermitian) (hB : B.IsHermitian)
    (h : A.charpoly = B.charpoly) : vnEnt hA = vnEnt hB := by
  rw [vnEnt_eq_roots, vnEnt_eq_roots, h]

/-- **Unitary invariance.** `S(U A U*) = S(A)`. -/
theorem vnEnt_unitary_conj {A U : Matrix n n ℂ} (hA : A.IsHermitian)
    (hU : U ∈ unitaryGroup n ℂ) (h' : (U * A * star U).IsHermitian) : vnEnt h' = vnEnt hA :=
  vnEnt_congr _ _ (by rw [charpoly_mul_comm, ← mul_assoc, mem_unitaryGroup_iff'.mp hU, one_mul])

/-- A diagonal state has the Shannon entropy of its diagonal. -/
theorem vnEnt_diagonal (d : n → ℝ) (h : (diagonal fun i => (d i : ℂ)).IsHermitian) :
    vnEnt h = ∑ i, negMulLog (d i) := by
  rw [vnEnt_eq_roots, charpoly_diagonal, Polynomial.roots_prod _ _
    (by simp [Finset.prod_ne_zero_iff, Polynomial.X_sub_C_ne_zero])]
  simp only [Polynomial.roots_X_sub_C, Multiset.bind_singleton, Multiset.map_map]
  unfold Finset.sum
  congr 1

/-! ## Pinching -/

/-- The diagonal of `W D W*` for a real diagonal `D`. -/
theorem diag_conj (W : Matrix n n ℂ) (μ : n → ℝ) (k : n) :
    ((W * diagonal (fun j => (μ j : ℂ)) * star W) k k).re = ∑ j, Complex.normSq (W k j) * μ j := by
  rw [mul_apply, Complex.re_sum]
  refine sum_congr rfl fun j _ => ?_
  rw [mul_diagonal, star_apply, Complex.star_def, mul_right_comm, Complex.mul_conj]
  norm_cast

theorem row_normSq_sum {W : Matrix n n ℂ} (hW : W ∈ unitaryGroup n ℂ) (k : n) :
    ∑ j, Complex.normSq (W k j) = 1 := by
  have h := diag_conj W (fun _ => 1) k
  simp only [Complex.ofReal_one, mul_one] at h
  rw [show (diagonal fun _ : n => (1 : ℂ)) = 1 from diagonal_one, Matrix.mul_one,
    mem_unitaryGroup_iff.mp hW, one_apply_eq, Complex.one_re] at h
  exact h.symm

theorem col_normSq_sum {W : Matrix n n ℂ} (hW : W ∈ unitaryGroup n ℂ) (j : n) :
    ∑ k, Complex.normSq (W k j) = 1 := by
  have h := row_normSq_sum (Unitary.star_mem hW) j
  simpa [star_apply, Complex.star_def, Complex.normSq_conj] using h

/-- **Pinching.** For every unitary `V` (an orthonormal basis), the von Neumann
entropy is at most the Shannon entropy of the diagonal of `ρ` in that basis. -/
theorem vnEnt_le_diag {ρ : Matrix n n ℂ} (hρ : ρ.PosSemidef) {V : Matrix n n ℂ}
    (hV : V ∈ unitaryGroup n ℂ) :
    vnEnt hρ.1 ≤ ∑ k, negMulLog ((star V * ρ * V) k k).re := by
  set μ := hρ.1.eigenvalues
  set U : Matrix n n ℂ := (hρ.1.eigenvectorUnitary : Matrix n n ℂ)
  have hU : U ∈ unitaryGroup n ℂ := hρ.1.eigenvectorUnitary.2
  have hspec : ρ = U * diagonal (fun j => (μ j : ℂ)) * star U := by
    conv_lhs => rw [hρ.1.spectral_theorem, Unitary.conjStarAlgAut_apply]
    rfl
  set W := star V * U
  have hW : W ∈ unitaryGroup n ℂ := mul_mem (Unitary.star_mem hV) hU
  have hd : ∀ k, ((star V * ρ * V) k k).re = ∑ j, Complex.normSq (W k j) * μ j := by
    intro k
    rw [← diag_conj]
    congr 2
    rw [hspec, star_mul, star_star]
    simp only [W, Matrix.mul_assoc]
  have hμ : ∀ j, 0 ≤ μ j := hρ.eigenvalues_nonneg
  have hjen : ∀ k, ∑ j, Complex.normSq (W k j) * negMulLog (μ j)
      ≤ negMulLog (∑ j, Complex.normSq (W k j) * μ j) := by
    intro k
    have := concaveOn_negMulLog.le_map_sum (t := univ) (w := fun j => Complex.normSq (W k j))
      (p := μ) (fun j _ => Complex.normSq_nonneg _) (row_normSq_sum hW k)
      (fun j _ => Set.mem_Ici.mpr (hμ j))
    simpa [smul_eq_mul] using this
  calc vnEnt hρ.1 = ∑ j, negMulLog (μ j) := rfl
    _ = ∑ k, ∑ j, Complex.normSq (W k j) * negMulLog (μ j) := by
        rw [sum_comm]
        refine sum_congr rfl fun j _ => ?_
        rw [← sum_mul, col_normSq_sum hW, one_mul]
    _ ≤ ∑ k, negMulLog (∑ j, Complex.normSq (W k j) * μ j) := sum_le_sum fun k _ => hjen k
    _ = ∑ k, negMulLog ((star V * ρ * V) k k).re := by simp only [hd]

omit [DecidableEq n] in
/-- The pinched diagonal is a probability law when `Tr ρ = 1`. -/
theorem diag_nonneg {ρ : Matrix n n ℂ} (hρ : ρ.PosSemidef) (V : Matrix n n ℂ) (k : n) : 0 ≤ ((star V * ρ * V) k k).re := by
  have := (hρ.conjTranspose_mul_mul_same V).diag_nonneg (i := k)
  rw [← star_eq_conjTranspose] at this
  exact (Complex.nonneg_iff.mp this).1

theorem diag_sum {ρ : Matrix n n ℂ} {V : Matrix n n ℂ} (hV : V ∈ unitaryGroup n ℂ) :
    ∑ k, ((star V * ρ * V) k k).re = (trace ρ).re := by
  rw [← Complex.re_sum]
  change (trace (star V * ρ * V)).re = _
  rw [trace_mul_cycle, mem_unitaryGroup_iff.mp hV, one_mul]

/-! ## The quantum Gibbs bound -/

section Gibbs

variable {H : Matrix n n ℂ} (hH : H.IsHermitian) (b : ℝ)

/-- The eigenbasis of the bath Hamiltonian. -/
noncomputable abbrev UH : Matrix n n ℂ := (hH.eigenvectorUnitary : Matrix n n ℂ)

theorem UH_mem : UH hH ∈ unitaryGroup n ℂ := hH.eigenvectorUnitary.2

theorem H_spec : H = UH hH * diagonal (fun j => (hH.eigenvalues j : ℂ)) * star (UH hH) := by
  conv_lhs => rw [hH.spectral_theorem, Unitary.conjStarAlgAut_apply]
  rfl

/-- Energy in the eigenbasis: `Re Tr(ρH) = Σ_k ⟨u_k, ρ u_k⟩ ε_k`. -/
theorem energy_eq (ρ : Matrix n n ℂ) :
    (trace (ρ * H)).re = ∑ k, ((star (UH hH) * ρ * UH hH) k k).re * hH.eigenvalues k := by
  conv_lhs => rw [H_spec hH]
  rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, trace_mul_cycle, ← Matrix.mul_assoc, trace,
    Complex.re_sum]
  refine sum_congr rfl fun k _ => ?_
  rw [diag_apply, mul_diagonal]
  simp

variable [Nonempty n]

/-- **Quantum Gibbs bound.** `S(ρ) ≤ β Re Tr(ρH) + ln Z` for every density matrix. -/
theorem vnEnt_le_energy {ρ : Matrix n n ℂ} (hρ : ρ.PosSemidef) (htr : (trace ρ).re = 1) :
    vnEnt hρ.1 ≤ b * (trace (ρ * H)).re + log (partition b hH.eigenvalues) := by
  set d : n → ℝ := fun k => ((star (UH hH) * ρ * UH hH) k k).re
  have h1 := vnEnt_le_diag hρ (UH_mem hH)
  have h2 := ent_le_energy b hH.eigenvalues d (fun k => diag_nonneg hρ (UH hH) k)
    (by rw [← htr]; exact diag_sum (UH_mem hH))
  rw [energy_eq hH]
  exact h1.trans h2

/-- The Gibbs state `γ = U diag(e^{−βε}/Z) U*`. -/
noncomputable def gibbsState : Matrix n n ℂ :=
  UH hH * diagonal (fun j => (gibbs b hH.eigenvalues j : ℂ)) * star (UH hH)

theorem gibbsState_posSemidef : (gibbsState hH b).PosSemidef := by
  unfold gibbsState
  have hD : (diagonal fun j => (gibbs b hH.eigenvalues j : ℂ)).PosSemidef :=
    PosSemidef.diagonal fun j => by
      show (0 : ℂ) ≤ _
      exact Complex.zero_le_real.mpr (gibbs_pos b hH.eigenvalues j).le
  simpa [star_eq_conjTranspose] using hD.mul_mul_conjTranspose_same (UH hH)

theorem gibbsState_trace : (trace (gibbsState hH b)).re = 1 := by
  unfold gibbsState
  rw [trace_mul_cycle, mem_unitaryGroup_iff'.mp (UH_mem hH), one_mul, trace_diagonal,
    Complex.re_sum]
  simpa using gibbs_sum_one b hH.eigenvalues

omit [Nonempty n] in
theorem gibbsState_diag :
    star (UH hH) * gibbsState hH b * UH hH = diagonal fun j => (gibbs b hH.eigenvalues j : ℂ) := by
  unfold gibbsState
  simp only [← Matrix.mul_assoc, mem_unitaryGroup_iff'.mp (UH_mem hH), one_mul]
  rw [Matrix.mul_assoc, mem_unitaryGroup_iff'.mp (UH_mem hH), mul_one]

theorem gibbsState_trace' : trace (gibbsState hH b) = 1 := by
  unfold gibbsState
  rw [trace_mul_cycle, mem_unitaryGroup_iff'.mp (UH_mem hH), one_mul, trace_diagonal]
  exact_mod_cast gibbs_sum_one b hH.eigenvalues

omit [Nonempty n] in
/-- The Gibbs state's energy `Re Tr(γH) = Σ γ_k ε_k`. -/
theorem gibbsState_energy :
    (trace (gibbsState hH b * H)).re = ∑ k, gibbs b hH.eigenvalues k * hH.eigenvalues k := by
  rw [energy_eq hH, gibbsState_diag]
  refine sum_congr rfl fun k _ => ?_
  rw [diagonal_apply_eq, Complex.ofReal_re]

/-- **The Gibbs state saturates the bound.** `S(γ) = β Re Tr(γH) + ln Z`. -/
theorem vnEnt_gibbsState :
    vnEnt (gibbsState_posSemidef hH b).1
      = b * (trace (gibbsState hH b * H)).re + log (partition b hH.eigenvalues) := by
  have hD : (diagonal fun j => (gibbs b hH.eigenvalues j : ℂ)).IsHermitian :=
    isHermitian_diagonal_of_self_adjoint _ (by ext j; simp [Complex.conj_ofReal])
  rw [show vnEnt (gibbsState_posSemidef hH b).1 = vnEnt hD from
    vnEnt_unitary_conj hD (UH_mem hH) _, vnEnt_diagonal, ← ent, ent_gibbs, gibbsState_energy]

end Gibbs

/-! ## Partial traces -/

section Bipartite

open scoped Kronecker

variable {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]

/-- Partial trace over the bath: the register's reduced state. -/
def ptrA (ρ : Matrix (α × β) (α × β) ℂ) : Matrix α α ℂ := fun i i' => ∑ k, ρ (i, k) (i', k)

/-- Partial trace over the register: the bath's reduced state. -/
def ptrB (ρ : Matrix (α × β) (α × β) ℂ) : Matrix β β ℂ := fun k k' => ∑ i, ρ (i, k) (i, k')

omit [Fintype α] [DecidableEq α] [DecidableEq β] in
theorem ptrA_isHermitian {ρ : Matrix (α × β) (α × β) ℂ} (hρ : ρ.IsHermitian) :
    (ptrA ρ).IsHermitian := by
  refine IsHermitian.ext fun i i' => ?_
  simp only [ptrA, star_sum]
  exact sum_congr rfl fun k _ => hρ.apply (i, k) (i', k)

omit [Fintype α] [DecidableEq α] in
theorem sum_star_mul_eq {Q : Matrix β β ℂ} (hQ : Q * star Q = 1) (c c' : β) :
    ∑ k, star (Q c k) * Q c' k = if c' = c then 1 else 0 := by
  have := congrFun (congrFun hQ c') c
  simp only [mul_apply, star_apply, one_apply] at this
  rw [← this]
  exact sum_congr rfl fun k _ => mul_comm _ _

omit [DecidableEq α] in
/-- Summing the conjugated diagonal over the bath gives the register's reduced
state in the register basis. -/
theorem ptrA_conj (ρ : Matrix (α × β) (α × β) ℂ) (P : Matrix α α ℂ) {Q : Matrix β β ℂ}
    (hQ : Q * star Q = 1) (i : α) :
    ∑ k, (star (P ⊗ₖ Q) * ρ * (P ⊗ₖ Q)) (i, k) (i, k) = (star P * ptrA ρ * P) i i := by
  simp only [kroneckerMap_apply, star_mul', mul_apply, star_apply, ptrA]
  simp only [Fintype.sum_prod_type, sum_mul, mul_sum]
  conv_lhs =>
    rw [sum_comm]
    enter [2, a']
    rw [sum_comm]
    enter [2, c']
    rw [sum_comm]
    enter [2, a]
    rw [sum_comm]
  conv_lhs =>
    enter [2, a']
    rw [sum_comm]
    enter [2, a]
    rw [sum_comm]
  refine sum_congr rfl fun a' _ => sum_congr rfl fun a _ => sum_congr rfl fun c _ => ?_
  have hk : ∀ c', ∑ k, star (P a i) * star (Q c k) * ρ (a, c) (a', c') * (P a' i * Q c' k)
      = star (P a i) * ρ (a, c) (a', c') * P a' i * ∑ k, star (Q c k) * Q c' k := by
    intro c'
    rw [mul_sum]
    exact sum_congr rfl fun k _ => by ring
  simp only [hk, sum_star_mul_eq hQ, mul_ite, mul_one, mul_zero, sum_ite_eq', mem_univ, ite_true]

omit [DecidableEq β] in
/-- Summing the conjugated diagonal over the register gives the bath's reduced
state in the bath basis. -/
theorem ptrB_conj (ρ : Matrix (α × β) (α × β) ℂ) {P : Matrix α α ℂ} (Q : Matrix β β ℂ)
    (hP : P * star P = 1) (k : β) :
    ∑ i, (star (P ⊗ₖ Q) * ρ * (P ⊗ₖ Q)) (i, k) (i, k) = (star Q * ptrB ρ * Q) k k := by
  simp only [kroneckerMap_apply, star_mul', mul_apply, star_apply, ptrB]
  simp only [Fintype.sum_prod_type, sum_mul, mul_sum]
  conv_lhs =>
    rw [sum_comm]
    enter [2, a']
    rw [sum_comm]
    enter [2, c']
    rw [sum_comm]
    enter [2, a]
    rw [sum_comm]
  conv_lhs => rw [sum_comm]
  conv_lhs =>
    enter [2, c']
    rw [sum_comm]
    enter [2, a]
    rw [sum_comm]
  conv_lhs =>
    enter [2, c']
    rw [sum_comm]
  refine sum_congr rfl fun c' _ => sum_congr rfl fun c _ => sum_congr rfl fun a _ => ?_
  have hi : ∀ a', ∑ i, star (P a i) * star (Q c k) * ρ (a, c) (a', c') * (P a' i * Q c' k)
      = star (Q c k) * ρ (a, c) (a', c') * Q c' k * ∑ i, star (P a i) * P a' i := by
    intro a'
    rw [mul_sum]
    exact sum_congr rfl fun i _ => by ring
  simp only [hi, sum_star_mul_eq hP, mul_ite, mul_one, mul_zero, sum_ite_eq', mem_univ, ite_true]

/-! ## Landauer's bound for density matrices -/

variable [Nonempty β] {H : Matrix β β ℂ} (hH : H.IsHermitian) (b : ℝ)

/-- The joint state after the unitary `W`, from `ρ_A ⊗ γ`. -/
noncomputable def finalState (ρA : Matrix α α ℂ) (W : Matrix (α × β) (α × β) ℂ) :
    Matrix (α × β) (α × β) ℂ :=
  W * (ρA ⊗ₖ gibbsState hH b) * star W

variable {ρA : Matrix α α ℂ} (hρA : ρA.PosSemidef) (htrA : trace ρA = 1)
  {W : Matrix (α × β) (α × β) ℂ} (hW : W ∈ unitaryGroup (α × β) ℂ)

omit [DecidableEq α] in
include hρA in
theorem init_posSemidef : (ρA ⊗ₖ gibbsState hH b).PosSemidef :=
  hρA.kronecker (gibbsState_posSemidef hH b)

omit [DecidableEq α] in
include hρA in
theorem finalState_posSemidef : (finalState hH b ρA W).PosSemidef := by
  have := (init_posSemidef hH b hρA).mul_mul_conjTranspose_same W
  simpa [finalState, star_eq_conjTranspose] using this

include htrA hW in
theorem finalState_trace : trace (finalState hH b ρA W) = 1 := by
  unfold finalState
  rw [trace_mul_cycle, mem_unitaryGroup_iff'.mp hW, one_mul, trace_kronecker, htrA,
    gibbsState_trace', one_mul]

include hρA htrA in
/-- **Entropy of the initial product state.** `S(ρ_A ⊗ γ) = S(ρ_A) + H(γ)`. -/
theorem vnEnt_init :
    vnEnt (init_posSemidef hH b hρA).1 = vnEnt hρA.1 + ent (gibbs b hH.eigenvalues) := by
  set μ := hρA.1.eigenvalues
  set g := gibbs b hH.eigenvalues
  set UA : Matrix α α ℂ := (hρA.1.eigenvectorUnitary : Matrix α α ℂ)
  have hUA : UA ∈ unitaryGroup α ℂ := hρA.1.eigenvectorUnitary.2
  have hspec : ρA = UA * diagonal (fun j => (μ j : ℂ)) * star UA := by
    conv_lhs => rw [hρA.1.spectral_theorem, Unitary.conjStarAlgAut_apply]
    rfl
  set V := UA ⊗ₖ UH hH
  have hV : V ∈ unitaryGroup (α × β) ℂ := kronecker_mem_unitary hUA (UH_mem hH)
  set D : Matrix (α × β) (α × β) ℂ := diagonal fun z => ((μ z.1 * g z.2 : ℝ) : ℂ)
  have he : ρA ⊗ₖ gibbsState hH b = V * D * star V := by
    rw [hspec, gibbsState, mul_kronecker_mul, mul_kronecker_mul, diagonal_kronecker_diagonal,
      star_eq_conjTranspose, star_eq_conjTranspose, star_eq_conjTranspose,
      conjTranspose_kronecker]
    simp only [D, V, Complex.ofReal_mul]
    rfl
  have hD : D.IsHermitian :=
    isHermitian_diagonal_of_self_adjoint _ (by ext z; simp [Complex.conj_ofReal])
  have hμ1 : ∑ i, μ i = 1 := by
    have h := hρA.1.trace_eq_sum_eigenvalues
    rw [htrA] at h
    have h' : ((∑ i, μ i : ℝ) : ℂ) = 1 := by push_cast; exact h.symm
    exact_mod_cast h'
  rw [vnEnt_congr _ hD (by rw [he, charpoly_mul_comm, ← Matrix.mul_assoc,
    mem_unitaryGroup_iff'.mp hV, one_mul]), vnEnt_diagonal, Fintype.sum_prod_type]
  have hg1 : ∑ i, g i = 1 := gibbs_sum_one b hH.eigenvalues
  simp only [negMulLog_mul, sum_add_distrib, ← mul_sum, ← sum_mul, hg1, hμ1, one_mul]
  rw [vnEnt, ent, add_comm]

/-- Heat delivered to the bath: `ΔQ_B = Re Tr(ρ′_B H) − Re Tr(γ H)`. -/
noncomputable def qheat (ρA : Matrix α α ℂ) (W : Matrix (α × β) (α × β) ℂ) : ℝ :=
  (trace (ptrB (finalState hH b ρA W) * H)).re - (trace (gibbsState hH b * H)).re

include hρA htrA hW in
/-- **Landauer's bound for density matrices (Reeb–Wolf).** For any unitary
coupling `W` of a register in state `ρ_A` to a bath in its Gibbs state,
`S(ρ_A) − S(ρ′_A) ≤ β ΔQ_B`. -/
theorem quantum_landauer :
    vnEnt hρA.1 - vnEnt (ptrA_isHermitian (finalState_posSemidef hH b hρA (W := W)).1)
      ≤ b * qheat hH b ρA W := by
  set ρ' := finalState hH b ρA W
  have hρ' : ρ'.PosSemidef := finalState_posSemidef hH b hρA
  have htr' : trace ρ' = 1 := finalState_trace hH b htrA hW
  set hA' := ptrA_isHermitian hρ'.1
  set UA : Matrix α α ℂ := (hA'.eigenvectorUnitary : Matrix α α ℂ)
  have hUA : UA ∈ unitaryGroup α ℂ := hA'.eigenvectorUnitary.2
  set V := UA ⊗ₖ UH hH
  have hV : V ∈ unitaryGroup (α × β) ℂ := kronecker_mem_unitary hUA (UH_mem hH)
  set d : α × β → ℝ := fun z => ((star V * ρ' * V) z z).re
  have hd0 : ∀ z, 0 ≤ d z := fun z => diag_nonneg hρ' V z
  have hd1 : ∑ z, d z = 1 := by
    rw [diag_sum hV, htr', Complex.one_re]
  -- pinching and subadditivity
  have h1 : vnEnt hρ'.1 ≤ ent d := vnEnt_le_diag hρ' hV
  have h2 : ent d ≤ ent (margA d) + ent (margB d) := ent_le_ent_marg d hd0 hd1
  -- register marginal = spectrum of ρ′_A
  have hdiagA : star UA * ptrA ρ' * UA = diagonal fun j => (hA'.eigenvalues j : ℂ) := by
    have := hA'.conjStarAlgAut_star_eigenvectorUnitary
    rw [Unitary.conjStarAlgAut_apply, Unitary.coe_star, star_star] at this
    exact this
  have hmA : ∀ i, margA d i = hA'.eigenvalues i := by
    intro i
    simp only [margA, d]
    rw [← Complex.re_sum, ptrA_conj ρ' UA (mem_unitaryGroup_iff.mp (UH_mem hH)), hdiagA,
      diagonal_apply_eq, Complex.ofReal_re]
  have h3 : ent (margA d) = vnEnt hA' := by
    unfold ent vnEnt
    simp only [hmA]
  -- bath marginal obeys the Gibbs bound
  have hmB : ∀ k, margB d k = ((star (UH hH) * ptrB ρ' * UH hH) k k).re := by
    intro k
    simp only [margB, d]
    rw [← Complex.re_sum, ptrB_conj ρ' (UH hH) (mem_unitaryGroup_iff.mp hUA)]
  have hmB0 : ∀ k, 0 ≤ margB d k := fun k => sum_nonneg fun i _ => hd0 _
  have hmB1 : ∑ k, margB d k = 1 := by rw [sum_margB]; exact hd1
  have h4 := ent_le_energy b hH.eigenvalues (margB d) hmB0 hmB1
  have hE : ∑ k, margB d k * hH.eigenvalues k = (trace (ptrB ρ' * H)).re := by
    rw [energy_eq hH]
    simp only [hmB]
  -- the initial entropy
  have h5 : vnEnt hρ'.1 = vnEnt hρA.1 + ent (gibbs b hH.eigenvalues) := by
    rw [← vnEnt_init hH b hρA htrA]
    exact vnEnt_unitary_conj _ hW _
  have h6 : ent (gibbs b hH.eigenvalues)
      = b * (trace (gibbsState hH b * H)).re + log (partition b hH.eigenvalues) := by
    rw [ent_gibbs, gibbsState_energy]
  unfold qheat
  rw [hE] at h4
  linarith

include hρA htrA hW in
/-- **Guard 1 (canon §8.1) for quantum registers.** If the unitary reset
removes at least `I_M + D_err + δ_I` nats of von Neumann entropy from the
register, the bath absorbs them: `Q_B / k_BT ≥ I_M + D_err + δ_I`. -/
theorem quantum_guard_one {kT IM Derr δI : ℝ} (hb : b = 1 / kT)
    (hexport : IM + Derr + δI ≤ vnEnt hρA.1
      - vnEnt (ptrA_isHermitian (finalState_posSemidef hH b hρA (W := W)).1)) :
    qheat hH b ρA W / kT ≥ IM + Derr + δI := by
  have h := quantum_landauer hH b hρA htrA hW
  subst hb
  rw [div_mul_eq_mul_div, one_mul] at h
  linarith

include hρA htrA hW in
/-- **Cycle work floor with quantum guard 1 derived.** -/
theorem quantum_cycle_work_floor {kT IM Derr δI η C Wc : ℝ} (hkT : 0 < kT) (hb : b = 1 / kT)
    (hexport : IM + Derr + δI ≤ vnEnt hρA.1
      - vnEnt (ptrA_isHermitian (finalState_posSemidef hH b hρA (W := W)).1))
    (hcharge : Wc ≥ qheat hH b ρA W + (1 - η) * C) :
    Wc ≥ kT * (IM + Derr + δI) + (1 - η) * C :=
  Snuffy.ThermoLedger.cycle_work_floor hkT (quantum_guard_one hH b hρA htrA hW hb hexport) hcharge

end Bipartite

end Snuffy.QuantumLandauer
