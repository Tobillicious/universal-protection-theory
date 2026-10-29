/-
Snuffy — Canon Edition 4.2 working: the completed boundary decoder (G.1).

For an isometric encoder `E` (`E†E = I`) and a fixed code state `ρ₀`, the
decoder on all boundary inputs is

  D(σ) = E†σE + Tr((I − EE†)σ) ρ₀.

  * ext_recovers — `D(EρE†) = ρ` for every code operator `ρ`.
  * kron_isometry, ext_recovers_reference — with any reference register `R`,
    `E ⊗ I_R` is again an isometry and the extended decoder returns every
    joint code–reference state: reference correlations are retained.
  * ext_trace — `D` is trace preserving when `Tr ρ₀ = 1`.
  * ext_posSemidef — `D` maps positive semidefinite inputs to positive
    semidefinite outputs when `ρ₀` is positive semidefinite.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.Kronecker
import Mathlib.Analysis.Complex.Basic

open Matrix
open scoped ComplexOrder Kronecker

namespace Snuffy.ChannelExtension

variable {N M : Type*} [Fintype N] [Fintype M] [DecidableEq N] [DecidableEq M]

/-- The completed decoder. -/
noncomputable def ext (E : Matrix N M ℂ) (ρ₀ : Matrix M M ℂ) (σ : Matrix N N ℂ) : Matrix M M ℂ :=
  Eᴴ * σ * E + trace ((1 - E * Eᴴ) * σ) • ρ₀

theorem ext_recovers {E : Matrix N M ℂ} (hE : Eᴴ * E = 1) (ρ₀ ρ : Matrix M M ℂ) :
    ext E ρ₀ (E * ρ * Eᴴ) = ρ := by
  unfold ext
  have h1 : Eᴴ * (E * ρ * Eᴴ) * E = ρ := by
    calc Eᴴ * (E * ρ * Eᴴ) * E = (Eᴴ * E) * ρ * (Eᴴ * E) := by simp only [Matrix.mul_assoc]
      _ = ρ := by rw [hE, Matrix.one_mul, Matrix.mul_one]
  have h3 : E * Eᴴ * (E * ρ * Eᴴ) = E * ρ * Eᴴ := by
    calc E * Eᴴ * (E * ρ * Eᴴ) = E * (Eᴴ * E) * ρ * Eᴴ := by simp only [Matrix.mul_assoc]
      _ = E * ρ * Eᴴ := by rw [hE, Matrix.mul_one]
  have h2 : (1 - E * Eᴴ) * (E * ρ * Eᴴ) = 0 := by
    rw [Matrix.sub_mul, Matrix.one_mul, h3, sub_self]
  rw [h1, h2, trace_zero, zero_smul, add_zero]

variable {R : Type*} [Fintype R] [DecidableEq R]

omit [Fintype M] [DecidableEq N] in
theorem kron_isometry {E : Matrix N M ℂ} (hE : Eᴴ * E = 1) :
    (E ⊗ₖ (1 : Matrix R R ℂ))ᴴ * (E ⊗ₖ (1 : Matrix R R ℂ)) = 1 := by
  rw [conjTranspose_kronecker, conjTranspose_one, ← mul_kronecker_mul, hE, Matrix.one_mul,
    one_kronecker_one]

theorem ext_recovers_reference {E : Matrix N M ℂ} (hE : Eᴴ * E = 1)
    (ρ₀ ρ : Matrix (M × R) (M × R) ℂ) :
    ext (E ⊗ₖ (1 : Matrix R R ℂ)) ρ₀
      ((E ⊗ₖ (1 : Matrix R R ℂ)) * ρ * (E ⊗ₖ (1 : Matrix R R ℂ))ᴴ) = ρ :=
  ext_recovers (kron_isometry hE) ρ₀ ρ

omit [DecidableEq M] in
theorem ext_trace (E : Matrix N M ℂ) {ρ₀ : Matrix M M ℂ} (hρ₀ : trace ρ₀ = 1)
    (σ : Matrix N N ℂ) : trace (ext E ρ₀ σ) = trace σ := by
  unfold ext
  rw [trace_add, trace_smul, hρ₀, smul_eq_mul, mul_one, Matrix.sub_mul, Matrix.one_mul,
    trace_sub, trace_mul_comm (Eᴴ * σ) E, ← Matrix.mul_assoc]
  abel

theorem ext_posSemidef {E : Matrix N M ℂ} (hE : Eᴴ * E = 1) {ρ₀ : Matrix M M ℂ}
    (hρ₀ : ρ₀.PosSemidef) {σ : Matrix N N ℂ} (hσ : σ.PosSemidef) :
    (ext E ρ₀ σ).PosSemidef := by
  unfold ext
  set P : Matrix N N ℂ := 1 - E * Eᴴ with hP
  have hPh : Pᴴ = P := by
    rw [hP, conjTranspose_sub, conjTranspose_one, conjTranspose_mul, conjTranspose_conjTranspose]
  have hPP : P * P = P := by
    have h3 : E * Eᴴ * (E * Eᴴ) = E * Eᴴ := by
      calc E * Eᴴ * (E * Eᴴ) = E * (Eᴴ * E) * Eᴴ := by simp only [Matrix.mul_assoc]
        _ = E * Eᴴ := by rw [hE, Matrix.mul_one]
    rw [hP, Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.one_mul,
      Matrix.mul_one, h3]
    abel
  have htr : trace (P * σ) = trace (P * σ * Pᴴ) := by
    rw [hPh, trace_mul_comm (P * σ) P, ← Matrix.mul_assoc, hPP]
  have hc : 0 ≤ trace (P * σ) := by
    rw [htr]
    exact (hσ.mul_mul_conjTranspose_same P).trace_nonneg
  exact (hσ.conjTranspose_mul_mul_same E).add (hρ₀.smul hc)

end Snuffy.ChannelExtension
