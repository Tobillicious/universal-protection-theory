import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Basic.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Snuffy.QuantumLandauer

namespace Snuffy.HamiltonianDecomposition

structure Hamiltonian where
  bulkTerm : Nat
  boundaryTerm : Nat
  interactionTerm : Nat

def totalHamiltonian (H : Hamiltonian) : Nat :=
  H.bulkTerm + H.boundaryTerm + H.interactionTerm

def confinementWell (boundaryPotential : Nat) : Nat :=
  boundaryPotential

theorem total_is_sum (H : Hamiltonian) :
    totalHamiltonian H = H.bulkTerm + H.boundaryTerm + H.interactionTerm := by
  rfl

theorem boundary_confinement_positive (V : Nat) (h : V > 0) :
    confinementWell V > 0 := h

/-- A concrete boundary/reservoir exchange on the ordered basis
|00>, |01>, |10>, |11>. The off-diagonal coupling transfers one charge. -/
def exchangeHamiltonian : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0, 0, 0, 0; 0, 0, 1, 0; 0, 1, 0, 0; 0, 0, 0, 0]

def boundaryCharge : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]

def reservoirCharge : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, 0; 0, 0, 0, 1]

def exchangeSwap : Matrix (Fin 4) (Fin 4) ℂ :=
  !![1, 0, 0, 0; 0, 0, 1, 0; 0, 1, 0, 0; 0, 0, 0, 1]

theorem exchange_hamiltonian_hermitian : exchangeHamiltonian.IsHermitian := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [exchangeHamiltonian]

theorem exchange_conserves_total_charge :
    exchangeHamiltonian * (boundaryCharge + reservoirCharge) =
      (boundaryCharge + reservoirCharge) * exchangeHamiltonian := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [exchangeHamiltonian, boundaryCharge, reservoirCharge,
      Matrix.mul_apply, Fin.sum_univ_succ]

theorem exchange_pumps_boundary :
    boundaryCharge * exchangeHamiltonian ≠ exchangeHamiltonian * boundaryCharge := by
  intro heq
  have h := congrArg (fun M : Matrix (Fin 4) (Fin 4) ℂ => M 1 2) heq
  norm_num [exchangeHamiltonian, boundaryCharge, Matrix.mul_apply, Fin.sum_univ_succ] at h

theorem exchange_swap_unitary : star exchangeSwap * exchangeSwap = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [exchangeSwap, Matrix.mul_apply, Fin.sum_univ_succ]

theorem exchange_swap_charge :
    star exchangeSwap * boundaryCharge * exchangeSwap = reservoirCharge := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [exchangeSwap, boundaryCharge, reservoirCharge,
      Matrix.mul_apply, Fin.sum_univ_succ]

theorem exchange_swap_total :
    star exchangeSwap * (boundaryCharge + reservoirCharge) * exchangeSwap =
      boundaryCharge + reservoirCharge := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [exchangeSwap, boundaryCharge, reservoirCharge,
      Matrix.mul_apply, Fin.sum_univ_succ]

section GuardedHistory

open Matrix Finset
open scoped Kronecker

variable {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]

omit [DecidableEq α] in
/-- Full reduced-state covariance, including off-diagonal coherences, for a
local unitary on the complementary factor. The history factor may include
an arbitrary reference, and the initial joint state need not factorize. -/
theorem partial_trace_local_conjugation (ρ : Matrix (α × β) (α × β) ℂ)
    (P : Matrix α α ℂ) {Q : Matrix β β ℂ} (hQ : Q * star Q = 1) :
    Snuffy.QuantumLandauer.ptrA (star (P ⊗ₖ Q) * ρ * (P ⊗ₖ Q)) =
      star P * Snuffy.QuantumLandauer.ptrA ρ * P := by
  ext i j
  simp only [Snuffy.QuantumLandauer.ptrA, kroneckerMap_apply, star_mul',
    mul_apply, star_apply]
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
  refine sum_congr rfl fun a' _ => sum_congr rfl fun a _ =>
    sum_congr rfl fun c _ => ?_
  have hk : ∀ c', ∑ k,
      star (P a i) * star (Q c k) * ρ (a, c) (a', c') * (P a' j * Q c' k) =
      star (P a i) * ρ (a, c) (a', c') * P a' j *
        ∑ k, star (Q c k) * Q c' k := by
    intro c'
    rw [mul_sum]
    exact sum_congr rfl fun k _ => by ring
  simp only [hk, Snuffy.QuantumLandauer.sum_star_mul_eq hQ,
    mul_ite, mul_one, mul_zero, sum_ite_eq', mem_univ, ite_true]

theorem guarded_history_reduced_state (ρ : Matrix (α × β) (α × β) ℂ)
    {Q : Matrix β β ℂ} (hQ : Q * star Q = 1) :
    Snuffy.QuantumLandauer.ptrA
      (star ((1 : Matrix α α ℂ) ⊗ₖ Q) * ρ * ((1 : Matrix α α ℂ) ⊗ₖ Q)) =
      Snuffy.QuantumLandauer.ptrA ρ := by
  simpa using partial_trace_local_conjugation ρ (1 : Matrix α α ℂ) hQ

end GuardedHistory

open scoped Kronecker in
/-- Swapping syndrome and reservoir registers preserves the complete history
and reference factor, for every initial correlation with those registers. -/
theorem syndrome_exchange_preserves_history {α : Type*}
    [Fintype α] [DecidableEq α]
    (ρ : Matrix (α × Fin 4) (α × Fin 4) ℂ) :
    Snuffy.QuantumLandauer.ptrA
      (star ((1 : Matrix α α ℂ) ⊗ₖ exchangeSwap) * ρ *
        ((1 : Matrix α α ℂ) ⊗ₖ exchangeSwap)) =
      Snuffy.QuantumLandauer.ptrA ρ := by
  have hself : star exchangeSwap = exchangeSwap := by
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num [exchangeSwap]
  apply guarded_history_reduced_state
  simpa only [hself] using exchange_swap_unitary

/-- The flushed syndrome's final charge is exactly the reservoir's initial
charge. The charge is transferred to the reservoir, not deleted from the
composite thermodynamic ledger. -/
theorem syndrome_exchange_charge (ρ : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix.trace (exchangeSwap * ρ * star exchangeSwap * boundaryCharge) =
      Matrix.trace (ρ * reservoirCharge) := by
  rw [show exchangeSwap * ρ * star exchangeSwap * boundaryCharge =
        exchangeSwap * (ρ * star exchangeSwap * boundaryCharge) by
      simp only [Matrix.mul_assoc],
    Matrix.trace_mul_comm,
    show ρ * star exchangeSwap * boundaryCharge * exchangeSwap =
        ρ * (star exchangeSwap * boundaryCharge * exchangeSwap) by
      simp only [Matrix.mul_assoc],
    exchange_swap_charge]

end Snuffy.HamiltonianDecomposition
