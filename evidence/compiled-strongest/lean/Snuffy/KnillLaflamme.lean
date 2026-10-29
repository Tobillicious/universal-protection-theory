/-
Snuffy — Canon Edition 4.2 working: the Knill–Laflamme conditions for a
stabilizer code, from its distance (review objection 7.1).

The setting is any complex algebra with an involution — the operators on a
patch's physical Hilbert space. Each stabilizer generator `S` is a Hermitian
involution; its spectral projection is `(1 + S)/2`, and the code projector `P`
satisfies `S P = P = P S` for every generator. Every error product is Pauli:
it commutes or anticommutes with each generator.

  * spectral_projection — `(1 + S)/2` is idempotent and fixed by `S` on both
    sides when `S² = 1`.
  * sandwich_anticomm — an operator anticommuting with a generator is
    annihilated by the code projector: `P E P = 0`.
  * sandwich_scalar — an operator acting on the code space as the scalar `c`
    satisfies `P E P = c P`.
  * knill_laflamme_of_distance — for errors of weight at most `t` with
    `2t < d`, where distance `d` means that every operator of weight below `d`
    commuting with all generators acts on the code space as a scalar, every
    pair satisfies the Knill–Laflamme identity `P E_i† E_j P = α_ij P`.
    Logical operators are excluded by the distance hypothesis, not by the case
    split.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.Star.Basic
import Mathlib.Analysis.Complex.Basic

namespace Snuffy.KnillLaflamme

variable {A : Type*} [Ring A] [Algebra ℂ A]

theorem eq_zero_of_eq_neg {x : A} (h : x = -x) : x = 0 := by
  have h2 : (2 : ℂ) • x = 0 := by rw [two_smul]; nth_rewrite 2 [h]; exact add_neg_cancel x
  have : x = (2 : ℂ)⁻¹ • ((2 : ℂ) • x) := by rw [smul_smul]; norm_num
  rw [this, h2, smul_zero]

/-- The spectral projection of an involution. -/
theorem spectral_projection {S : A} (hS : S * S = 1) :
    let Q := (2 : ℂ)⁻¹ • (1 + S)
    Q * Q = Q ∧ S * Q = Q ∧ Q * S = Q := by
  intro Q
  have hSQ : S * Q = Q := by
    simp only [Q, mul_smul_comm, mul_add, mul_one, hS, add_comm]
  have hQS : Q * S = Q := by
    simp only [Q, smul_mul_assoc, add_mul, one_mul, hS, add_comm]
  refine ⟨?_, hSQ, hQS⟩
  calc Q * Q = (2 : ℂ)⁻¹ • ((1 + S) * Q) := by simp only [Q, smul_mul_assoc]
    _ = (2 : ℂ)⁻¹ • (Q + Q) := by rw [add_mul, one_mul, hSQ]
    _ = Q := by rw [← two_smul ℂ Q, smul_smul]; norm_num

/-- **Anticommuting errors are annihilated by the code projector.** -/
theorem sandwich_anticomm {P S E : A} (hSP : S * P = P) (hPS : P * S = P)
    (hanti : E * S = -(S * E)) : P * E * P = 0 := by
  apply eq_zero_of_eq_neg
  calc P * E * P = P * E * (S * P) := by rw [hSP]
    _ = P * (E * S) * P := by simp only [mul_assoc]
    _ = -(P * S * E * P) := by rw [hanti]; simp only [mul_neg, neg_mul, mul_assoc]
    _ = -(P * E * P) := by rw [hPS]

/-- **Operators acting as a scalar on the code space.** -/
theorem sandwich_scalar {P E : A} (hPP : P * P = P) {c : ℂ} (hc : E * P = c • P) :
    P * E * P = c • P := by
  rw [mul_assoc, hc, mul_smul_comm, hPP]

variable [StarRing A]

/-- **The Knill–Laflamme identities from the code distance.** -/
theorem knill_laflamme_of_distance {κ ι : Type*} (P : A) (hPP : P * P = P) (S : κ → A)
    (hSP : ∀ k, S k * P = P) (hPS : ∀ k, P * S k = P)
    (weight : A → ℕ) (hsub : ∀ a b : A, weight (star a * b) ≤ weight a + weight b)
    (hpauli : ∀ F k, F * S k = S k * F ∨ F * S k = -(S k * F))
    {d t : ℕ} (hdist : ∀ F, weight F < d → (∀ k, F * S k = S k * F) → ∃ c : ℂ, F * P = c • P)
    (E : ι → A) (hE : ∀ i, weight (E i) ≤ t) (htd : 2 * t < d) :
    ∀ i j, ∃ α : ℂ, P * (star (E i) * E j) * P = α • P := by
  intro i j
  have hw : weight (star (E i) * E j) < d := by
    have := hsub (E i) (E j); have := hE i; have := hE j; omega
  by_cases hcomm : ∀ k, star (E i) * E j * S k = S k * (star (E i) * E j)
  · obtain ⟨c, hc⟩ := hdist _ hw hcomm
    exact ⟨c, sandwich_scalar hPP hc⟩
  · push Not at hcomm
    obtain ⟨k, hk⟩ := hcomm
    have hanti := (hpauli _ k).resolve_left hk
    exact ⟨0, by rw [sandwich_anticomm (hSP k) (hPS k) hanti, zero_smul]⟩

end Snuffy.KnillLaflamme
