/-
Snuffy — Canon Edition 4.2 working: the concatenated memory decodes its record
unless its block fails (§23.8; the identification of physical failure with the
recursive failure predicate).

A level-`k` block stores a record from an alphabet `A`. The outer code encodes
a symbol into seven symbols with pairwise Hamming distance at least three, and
its decoder returns a nearest codeword. The record is encoded recursively onto
the `7^k` physical locations (`encodeRec`) and decoded recursively, each level
decoding its seven sub-blocks and then the outer code (`decodeRec`). A fault
set `F` lets the stored value at every location of `F` be arbitrary.

  * outer_decodes — a received seven-symbol word within Hamming distance one of
    a codeword decodes to that codeword's symbol.
  * decodes_unless_fails — if the block does not fail (`Concatenated.Fails`),
    recursive decoding returns the original record, whatever values the faulty
    locations hold.
  * decoding_failure_le — the probability that some corruption of the faulty
    locations defeats decoding is at most the probability that the block fails,
    hence at most `(21p)^{2^k}/21` under local stochastic noise
    (`Concatenated.concatenated_threshold`).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Concatenated
import Mathlib.InformationTheory.Hamming

open Finset

namespace Snuffy.ConcatenatedDecoding

open Snuffy.Concatenated Snuffy.Threshold

variable {A : Type*} [DecidableEq A]

/-- **The outer code corrects one symbol.** -/
theorem outer_decodes (enc : A → Fin 7 → A) (dec : (Fin 7 → A) → A)
    (hdist : ∀ a b, a ≠ b → 3 ≤ hammingDist (enc a) (enc b))
    (hnear : ∀ y a, hammingDist y (enc (dec y)) ≤ hammingDist y (enc a))
    (y : Fin 7 → A) (r : A) (hy : hammingDist y (enc r) ≤ 1) : dec y = r := by
  by_contra hne
  have h1 : hammingDist y (enc (dec y)) ≤ 1 := (hnear y r).trans hy
  have h2 := hammingDist_triangle (enc (dec y)) y (enc r)
  have h3 := hdist (dec y) r hne
  rw [hammingDist_comm (enc (dec y)) y] at h2
  omega

/-- Recursive encoding of a record onto the `7^k` locations. -/
def encodeRec (enc : A → Fin 7 → A) : (k : ℕ) → A → Loc k → A
  | 0, r => fun _ => r
  | k + 1, r => fun a => encodeRec enc k (enc r (a 0)) (Fin.tail a)

/-- Recursive decoding: decode each sub-block, then the outer code. -/
def decodeRec (dec : (Fin 7 → A) → A) : (k : ℕ) → (Loc k → A) → A
  | 0, y => y Fin.elim0
  | k + 1, y => dec fun i => decodeRec dec k fun a => y (Fin.cons i a)

theorem mem_sub {k : ℕ} (F : Finset (Loc (k + 1))) (i : Fin 7) (a : Loc k) :
    a ∈ sub F i ↔ Fin.cons i a ∈ F := by
  simp [sub]

/-- **Decoding succeeds unless the block fails.** -/
theorem decodes_unless_fails (enc : A → Fin 7 → A) (dec : (Fin 7 → A) → A)
    (hdist : ∀ a b, a ≠ b → 3 ≤ hammingDist (enc a) (enc b))
    (hnear : ∀ y a, hammingDist y (enc (dec y)) ≤ hammingDist y (enc a)) :
    ∀ (k : ℕ) (F : Finset (Loc k)) (r : A) (y : Loc k → A), ¬ Fails k F →
      (∀ a, a ∉ F → y a = encodeRec enc k r a) → decodeRec dec k y = r := by
  intro k
  induction k with
  | zero =>
      intro F r y hF hy
      have hempty : F = ∅ := Finset.not_nonempty_iff_eq_empty.mp hF
      have hloc : (Fin.elim0 : Loc 0) ∉ F := by simp [hempty]
      simp only [decodeRec]
      rw [hy _ hloc]
      rfl
  | succ k ih =>
      intro F r y hF hy
      classical
      simp only [Fails, not_exists, not_and] at hF
      -- every sub-block that does not fail decodes to its outer-code symbol
      have hsub : ∀ i, ¬ Fails k (sub F i) →
          decodeRec dec k (fun a => y (Fin.cons i a)) = enc r i := by
        intro i hi
        refine ih (sub F i) (enc r i) _ hi fun a ha => ?_
        rw [mem_sub] at ha
        rw [hy _ ha]
        simp [encodeRec]
      -- at most one sub-block fails
      have hone : (univ.filter fun i => Fails k (sub F i)).card ≤ 1 := by
        rw [Finset.card_le_one]
        intro i hi j hj
        by_contra hij
        simp only [mem_filter, mem_univ, true_and] at hi hj
        exact hF i j hij hi hj
      have hham : hammingDist (fun i => decodeRec dec k fun a => y (Fin.cons i a)) (enc r) ≤ 1 := by
        refine le_trans (Finset.card_le_card ?_) hone
        intro i hi
        simp only [mem_filter, mem_univ, true_and] at hi ⊢
        by_contra hni
        exact hi (hsub i hni)
      exact outer_decodes enc dec hdist hnear _ r hham

/-- **Decoding failure is a block failure.** The probability that some
corruption of the faulty locations defeats decoding is at most
`(21p)^{2^k}/21` under local stochastic noise. -/
theorem decoding_failure_le (enc : A → Fin 7 → A) (dec : (Fin 7 → A) → A)
    (hdist : ∀ a b, a ≠ b → 3 ≤ hammingDist (enc a) (enc b))
    (hnear : ∀ y a, hammingDist y (enc (dec y)) ≤ hammingDist y (enc a))
    (k : ℕ) (r : A) (μ : FaultLaw (Loc k)) {p : ℝ} (hp0 : 0 ≤ p)
    (hμ : LocalStochastic μ p)
    [DecidablePred (Fails k)]
    [DecidablePred fun F : Finset (Loc k) => ∃ y : Loc k → A,
      (∀ a, a ∉ F → y a = encodeRec enc k r a) ∧ decodeRec dec k y ≠ r] :
    prob μ (fun F => ∃ y : Loc k → A,
      (∀ a, a ∉ F → y a = encodeRec enc k r a) ∧ decodeRec dec k y ≠ r) ≤
      (21 * p) ^ (2 ^ k) / 21 := by
  refine le_trans ?_ (concatenated_threshold k μ hp0 hμ)
  refine sum_le_sum fun F _ => ?_
  split_ifs with h1 h2
  · exact le_rfl
  · exfalso
    obtain ⟨y, hy, hne⟩ := h1
    exact hne (decodes_unless_fails enc dec hdist hnear k F r y h2 hy)
  · exact μ.nonneg F
  · exact le_rfl

end Snuffy.ConcatenatedDecoding
