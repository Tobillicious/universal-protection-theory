/-
Snuffy — syndrome-controlled thermal encoding with an arbitrary reference.

For orthogonal syndrome isometries E_s and normalized classical weights q,
encoding is sum_s q_s E_s rho E_s†. The matching decoder sums the branch
compressions E_s† sigma E_s. Their composition is the identity on every
operator, and also on every joint logical-reference operator.

The actual application takes E_s to be the fixed decoder's Pauli syndrome
representative after the codespace encoder. No unknown logical input is
replaced by a default state, and no arbitrary Stinespring trace-out identity
is asserted. The sampler's density bound is a separate construction.
-/

import Snuffy.ChannelExtension

open Matrix Finset
open scoped Kronecker

namespace Snuffy.ThermalEncoding

variable {S N M : Type*} [Fintype S] [Fintype N] [Fintype M]
  [DecidableEq S] [DecidableEq M]

noncomputable def encode (E : S → Matrix N M ℂ) (q : S → ℂ)
    (ρ : Matrix M M ℂ) : Matrix N N ℂ :=
  ∑ s, q s • (E s * ρ * (E s)ᴴ)

noncomputable def decode (E : S → Matrix N M ℂ) (σ : Matrix N N ℂ) : Matrix M M ℂ :=
  ∑ s, (E s)ᴴ * σ * E s

omit [Fintype S] in
/-- Distinct syndrome branches are orthogonal; the matching branch returns
the entire logical operator. -/
theorem branch_compression (E : S → Matrix N M ℂ)
    (hE : ∀ s t, (E s)ᴴ * E t = if s = t then 1 else 0)
    (ρ : Matrix M M ℂ) (s t : S) :
    (E s)ᴴ * (E t * ρ * (E t)ᴴ) * E s = if s = t then ρ else 0 := by
  calc
    (E s)ᴴ * (E t * ρ * (E t)ᴴ) * E s
        = ((E s)ᴴ * E t) * ρ * ((E t)ᴴ * E s) := by simp only [Matrix.mul_assoc]
    _ = if s = t then ρ else 0 := by
      rw [hE s t, hE t s]
      by_cases h : s = t
      · subst t
        simp
      · simp [h, Ne.symm h]

/-- A normalized syndrome mixture has an exact logical left inverse. -/
theorem recovers (E : S → Matrix N M ℂ)
    (hE : ∀ s t, (E s)ᴴ * E t = if s = t then 1 else 0)
    (q : S → ℂ) (hq : ∑ s, q s = 1) (ρ : Matrix M M ℂ) :
    decode E (encode E q ρ) = ρ := by
  unfold decode encode
  simp_rw [Matrix.mul_sum, Matrix.sum_mul, Matrix.mul_smul, Matrix.smul_mul, branch_compression E hE]
  simp only [smul_ite, smul_zero, Finset.sum_ite_eq, Finset.mem_univ, ite_true]
  rw [← Finset.sum_smul, hq, one_smul]

variable {R : Type*} [Fintype R] [DecidableEq R]

omit [Fintype S] [Fintype M] in
/-- Orthogonal syndrome isometries remain orthogonal after adjoining any
reference register. -/
theorem kron_orthogonal (E : S → Matrix N M ℂ)
    (hE : ∀ s t, (E s)ᴴ * E t = if s = t then 1 else 0) (s t : S) :
    (E s ⊗ₖ (1 : Matrix R R ℂ))ᴴ * (E t ⊗ₖ (1 : Matrix R R ℂ)) =
      if s = t then 1 else 0 := by
  rw [conjTranspose_kronecker, conjTranspose_one, ← mul_kronecker_mul, hE s t, Matrix.one_mul]
  by_cases h : s = t <;> simp [h]

/-- The decoded channel is the identity on every joint logical-reference
state, including arbitrary entangled inputs. -/
theorem recovers_reference (E : S → Matrix N M ℂ)
    (hE : ∀ s t, (E s)ᴴ * E t = if s = t then 1 else 0)
    (q : S → ℂ) (hq : ∑ s, q s = 1) (ρ : Matrix (M × R) (M × R) ℂ) :
    decode (fun s => E s ⊗ₖ (1 : Matrix R R ℂ))
      (encode (fun s => E s ⊗ₖ (1 : Matrix R R ℂ)) q ρ) = ρ :=
  recovers _ (kron_orthogonal E hE) q hq ρ

end Snuffy.ThermalEncoding
