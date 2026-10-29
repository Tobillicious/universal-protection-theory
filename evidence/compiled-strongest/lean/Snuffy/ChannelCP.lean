/-
Snuffy — Canon Edition 4.2 working: the completed decoder is completely
positive (G.1; G.13).

For an encoder `E`, the completed decoder is
`D(σ) = E†σE + Tr((I − EE†)σ) ρ₀` (`ChannelExtension.ext`). Its amplification
by any reference register `R` acts on a joint input `Y` block by block:
`(D ⊗ id)(Y)` has `(r, r')` block `D(Y_{r r'})`.

  * amp_eq — `(D ⊗ id)(Y) = (E† ⊗ I_R) Y (E† ⊗ I_R)† + ρ₀ ⊗ T(Y)`, where
    `T(Y)_{r r'} = Tr((I − EE†) Y_{r r'})`.
  * mp_posSemidef — `T(Y)` is positive semidefinite whenever `Y` is: with
    `I − EE† = B†B`, it is a sum of compressions of `(B ⊗ I) Y (B ⊗ I)†`.
  * decoder_completely_positive — for every finite reference `R`, `D ⊗ id`
    maps positive semidefinite inputs to positive semidefinite outputs, when
    `E†E = I` and `ρ₀` is positive semidefinite.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ChannelExtension
import Mathlib.Analysis.Matrix.Order

open Matrix
open scoped ComplexOrder Kronecker MatrixOrder

namespace Snuffy.ChannelCP

open Snuffy.ChannelExtension

variable {N M R : Type*} [Fintype N] [Fintype M] [Fintype R]
  [DecidableEq N] [DecidableEq M] [DecidableEq R]

/-- The `(r, r')` block of a joint input. -/
def block (Y : Matrix (N × R) (N × R) ℂ) (r r' : R) : Matrix N N ℂ :=
  fun b a => Y (b, r) (a, r')

/-- The amplified decoder `D ⊗ id`. -/
noncomputable def amp (E : Matrix N M ℂ) (ρ₀ : Matrix M M ℂ) (Y : Matrix (N × R) (N × R) ℂ) :
    Matrix (M × R) (M × R) ℂ :=
  fun x x' => ext E ρ₀ (block Y x.2 x'.2) x.1 x'.1

/-- The measure-and-prepare weights. -/
noncomputable def mpT (P : Matrix N N ℂ) (Y : Matrix (N × R) (N × R) ℂ) : Matrix R R ℂ :=
  fun r r' => trace (P * block Y r r')

omit [DecidableEq N] in
/-- Entries of a Kronecker-amplified product. -/
theorem kron_entry {N' : Type*} [Fintype N'] (K : Matrix N' N ℂ) (L : Matrix N' N ℂ)
    (Y : Matrix (N × R) (N × R) ℂ) (c c' : N') (r r' : R) :
    ((K ⊗ₖ (1 : Matrix R R ℂ)) * Y * (L ⊗ₖ (1 : Matrix R R ℂ))ᴴ) (c, r) (c', r') =
      (K * block Y r r' * Lᴴ) c c' := by
  rw [conjTranspose_kronecker, conjTranspose_one]
  simp only [Matrix.mul_apply, Fintype.sum_prod_type, kroneckerMap_apply, one_apply, block,
    mul_ite, mul_one, mul_zero, ite_mul, zero_mul, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, ite_true, Finset.sum_mul]

omit [DecidableEq M] in
theorem amp_eq (E : Matrix N M ℂ) (ρ₀ : Matrix M M ℂ) (Y : Matrix (N × R) (N × R) ℂ) :
    amp E ρ₀ Y = (Eᴴ ⊗ₖ (1 : Matrix R R ℂ)) * Y * (Eᴴ ⊗ₖ (1 : Matrix R R ℂ))ᴴ +
      ρ₀ ⊗ₖ mpT (1 - E * Eᴴ) Y := by
  ext ⟨m, r⟩ ⟨m', r'⟩
  rw [Matrix.add_apply, kron_entry, conjTranspose_conjTranspose, kroneckerMap_apply]
  simp only [amp, mpT, Snuffy.ChannelExtension.ext, Matrix.add_apply, Matrix.smul_apply,
    smul_eq_mul]
  ring

/-- Compression of a joint matrix to the `c`-row of its first factor. -/
def compress (c : N) : Matrix (N × R) R ℂ := fun x r => if x = (c, r) then 1 else 0

theorem compress_entry (Z : Matrix (N × R) (N × R) ℂ) (c : N) (r r' : R) :
    (((compress (R := R) c)ᴴ * Z * compress (R := R) c : Matrix R R ℂ)) r r' = Z (c, r) (c, r') := by
  simp only [Matrix.mul_apply, conjTranspose_apply, compress, apply_ite star, star_one, star_zero,
    ite_mul, one_mul, zero_mul, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ,
    ite_true]

theorem mp_posSemidef {P : Matrix N N ℂ} (hP : P.PosSemidef) {Y : Matrix (N × R) (N × R) ℂ}
    (hY : Y.PosSemidef) : (mpT P Y).PosSemidef := by
  obtain ⟨B, rfl⟩ := CStarAlgebra.nonneg_iff_eq_star_mul_self.mp hP.nonneg
  set Bk : Matrix (N × R) (N × R) ℂ := B ⊗ₖ (1 : Matrix R R ℂ)
  have hZ : (Bk * Y * Bkᴴ).PosSemidef := hY.mul_mul_conjTranspose_same Bk
  have hsum : mpT (star B * B) Y =
      ∑ c, ((compress (R := R) c)ᴴ * (Bk * Y * Bkᴴ) * compress (R := R) c : Matrix R R ℂ) := by
    ext r r'
    rw [Matrix.sum_apply]
    simp_rw [compress_entry, Bk, kron_entry]
    simp only [mpT, star_eq_conjTranspose]
    rw [Matrix.mul_assoc, trace_mul_comm, trace]
    rfl
  rw [hsum]
  exact Matrix.posSemidef_sum _ fun c _ => hZ.conjTranspose_mul_mul_same (compress (R := R) c)

/-- **The completed decoder is completely positive.** -/
theorem decoder_completely_positive {E : Matrix N M ℂ} (hE : Eᴴ * E = 1) {ρ₀ : Matrix M M ℂ}
    (hρ₀ : ρ₀.PosSemidef) {Y : Matrix (N × R) (N × R) ℂ} (hY : Y.PosSemidef) :
    (amp E ρ₀ Y).PosSemidef := by
  rw [amp_eq]
  have hP : (1 - E * Eᴴ).PosSemidef := by
    have hPh : (1 - E * Eᴴ)ᴴ = 1 - E * Eᴴ := by
      rw [conjTranspose_sub, conjTranspose_one, conjTranspose_mul, conjTranspose_conjTranspose]
    have hPP : (1 - E * Eᴴ) * (1 - E * Eᴴ) = 1 - E * Eᴴ := by
      have h3 : E * Eᴴ * (E * Eᴴ) = E * Eᴴ := by
        calc E * Eᴴ * (E * Eᴴ) = E * (Eᴴ * E) * Eᴴ := by simp only [Matrix.mul_assoc]
          _ = E * Eᴴ := by rw [hE, Matrix.mul_one]
      rw [Matrix.sub_mul, Matrix.mul_sub, Matrix.mul_sub, Matrix.one_mul, Matrix.one_mul,
        Matrix.mul_one, h3]
      abel
    have := posSemidef_conjTranspose_mul_self (1 - E * Eᴴ)
    rwa [hPh, hPP] at this
  exact (hY.mul_mul_conjTranspose_same _).add (hρ₀.kronecker (mp_posSemidef hP hY))

end Snuffy.ChannelCP
