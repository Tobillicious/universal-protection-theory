/-
Life first is not an exchange rate. Outcomes are counted as (lives kept, freedoms kept); the order compares
lives first and freedoms only on equal lives (the first two stages of the canonical order, by count).
1. No finite exchange rate imitates it: for any weights a, b with b > 0, some option that loses one life for
   enough freedom has the higher weighted score, yet is worse in the order.
2. No count-valued utility represents it (the counting analogue of Debreu's lexicographic example).
3. With bounded stakes (at most M freedoms at stake), the weight M + 1 on lives does represent it.
So a weighted sum can imitate life first only when what is at stake is bounded; with scope all, nothing can.
Core Lean 4 only.
-/
namespace UPTNoExch

/-- `(l, f)` is worse than `(l', f')`: fewer lives, or equal lives and fewer freedoms. -/
def LexLt (l f l' f' : Nat) : Prop := l < l' ∨ (l = l' ∧ f < f')

/-- **No finite exchange rate.** For weights `a` (per life) and `b > 0` (per freedom), and any outcome with at
least one life, losing that life for `a + 1` more freedoms raises the weighted score, yet the result is worse
in the order. -/
theorem weighted_sum_trades_a_life (a b l f : Nat) (hb : 0 < b) :
    a * (l + 1) + b * f < a * l + b * (f + (a + 1)) ∧ LexLt l (f + (a + 1)) (l + 1) f := by
  refine ⟨?_, Or.inl (Nat.lt_succ_self l)⟩
  have h1 : a * (l + 1) = a * l + a := by rw [Nat.mul_succ]
  have h2 : b * (f + (a + 1)) = b * f + b * (a + 1) := Nat.mul_add b f (a + 1)
  have h3 : a + 1 ≤ b * (a + 1) := Nat.le_mul_of_pos_left (a + 1) hb
  omega

/-- A utility strictly increasing in freedoms at fixed lives grows at least as fast as the freedom count. -/
theorem grows (u : Nat → Nat → Nat) (hmono : ∀ l f, u l f < u l (f + 1)) : ∀ f, f ≤ u 0 f := by
  intro f
  induction f with
  | zero => exact Nat.zero_le _
  | succ f ih => have := hmono 0 f; omega

/-- **No count-valued utility represents life first.** There is no `u : lives → freedoms → Nat` that is
increasing in freedoms and ranks one life above every number of freedoms with no life. -/
theorem no_count_utility (u : Nat → Nat → Nat) (hmono : ∀ l f, u l f < u l (f + 1))
    (hlife : ∀ f, u 0 f < u 1 0) : False := by
  have := grows u hmono (u 1 0)
  have := hlife (u 1 0)
  omega

/-- In particular no utility faithful to the order exists: faithfulness forces both premises above. -/
theorem no_faithful_count_utility :
    ¬ ∃ u : Nat → Nat → Nat, ∀ l f l' f', (u l f < u l' f' ↔ LexLt l f l' f') := by
  intro ⟨u, hu⟩
  apply no_count_utility u
  · intro l f; exact (hu l f l (f + 1)).mpr (Or.inr ⟨rfl, Nat.lt_succ_self f⟩)
  · intro f; exact (hu 0 f 1 0).mpr (Or.inl Nat.zero_lt_one)

/-- **Bounded stakes.** When at most `M` freedoms are at stake, the weighted score `(M + 1)·lives + freedoms`
ranks outcomes exactly as the order does. -/
theorem bounded_stakes_represent (M l f l' f' : Nat) (hf : f ≤ M) (hf' : f' ≤ M) :
    (M + 1) * l + f < (M + 1) * l' + f' ↔ LexLt l f l' f' := by
  constructor
  · intro h
    by_cases hl : l < l'
    · exact Or.inl hl
    · by_cases he : l = l'
      · subst he; exact Or.inr ⟨rfl, by omega⟩
      · have hgt : l' + 1 ≤ l := by omega
        have := Nat.mul_le_mul_left (M + 1) hgt
        rw [Nat.mul_succ] at this
        omega
  · intro h
    cases h with
    | inl hl =>
      have := Nat.mul_le_mul_left (M + 1) (show l + 1 ≤ l' from hl)
      rw [Nat.mul_succ] at this
      omega
    | inr he => obtain ⟨rfl, hlt⟩ := he; omega

end UPTNoExch
