/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTNoExchangeRate.lean`, sha256 `89b35985391cbfe134eac23615b56be3d73b72f73bd6a94735f364140ef910dc`).
Namespace `UPTNoExch` renamed to `Snuffy.Book.UPTNoExchangeRate` for the canon's joint audit; statements and proofs unchanged. -/

/-
Life first is not an exchange rate. Outcomes are counted as (lives kept, freedoms kept); the order compares
lives first and freedoms only on equal lives (the first two stages of the canonical order, by count).
1. No finite exchange rate imitates it: for any weights a, b with b > 0, some option that loses one life for
   enough freedom has the higher weighted score, yet is worse in the order.
2. No count-valued utility represents it (the counting analogue of Debreu's lexicographic example).
3. With bounded stakes (at most M freedoms at stake), the weight M + 1 on lives does represent it.
So no fixed exchange rate between lives and freedoms imitates life first unless what is at stake is bounded.
Counting is not the whole story: on counts, a bounded nonlinear utility does represent the order (4 below).
4. On counts, u(l, f) = l + f/(f + 1) represents it (rational-valued, bounded in f).
5. As the theory defines it, the order compares WHO is kept (sets, by inclusion), not how many. That order is
   incomplete, and no utility into any linearly ordered scale (real-valued or not) represents it: the decisive
   difference from utility-based approaches, and the reason the law speaks of maximal, not optimal, options.
Core Lean 4 only.
-/
namespace Snuffy.Book.UPTNoExchangeRate

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

/-! ### On counts a bounded utility works; on who is kept, no utility does -/

/-- The rational utility `l + f/(f+1)`. -/
def bu (l f : Nat) : Rat := (l : Rat) + (f : Rat) / ((f : Rat) + 1)

/-- The three facts used about `g = f/(f+1)`: `0 ≤ g`, `g < 1`, and `g·(f+1) = f`. -/
theorem frac_spec (f : Nat) :
    0 ≤ (f : Rat) / ((f : Rat) + 1) ∧ (f : Rat) / ((f : Rat) + 1) < 1 ∧
      (f : Rat) / ((f : Rat) + 1) * ((f : Rat) + 1) = (f : Rat) := by
  have h0 : (0 : Rat) ≤ (f : Rat) := Rat.natCast_nonneg
  have hp : (0 : Rat) < (f : Rat) + 1 := by grind
  have hinv : ((f : Rat) + 1) * ((f : Rat) + 1)⁻¹ = 1 := Rat.mul_inv_cancel _ (by grind)
  have hipos : (0 : Rat) < ((f : Rat) + 1)⁻¹ := Rat.inv_pos.mpr hp
  rw [Rat.div_def]
  have hspec : (f : Rat) * ((f : Rat) + 1)⁻¹ * ((f : Rat) + 1) = (f : Rat) := by grind
  have hnn : 0 ≤ (f : Rat) * ((f : Rat) + 1)⁻¹ := Rat.mul_nonneg h0 (Rat.le_of_lt hipos)
  refine ⟨hnn, ?_, hspec⟩
  apply Classical.byContradiction; intro hn
  have hge : 1 ≤ (f : Rat) * ((f : Rat) + 1)⁻¹ := by grind
  have := Rat.mul_le_mul_of_nonneg_left hge (Rat.le_of_lt hp)
  grind

/-- `f/(f+1)` is strictly increasing. -/
theorem frac_strict (f f' : Nat) (h : f < f') : (f : Rat) / ((f : Rat) + 1) < (f' : Rat) / ((f' : Rat) + 1) := by
  obtain ⟨_, g1, gs⟩ := frac_spec f
  obtain ⟨_, _, gs'⟩ := frac_spec f'
  have hq : (f : Rat) < (f' : Rat) := by exact_mod_cast h
  have h0 : (0 : Rat) ≤ (f : Rat) := Rat.natCast_nonneg
  apply Classical.byContradiction; intro hn
  have hle : (f' : Rat) / ((f' : Rat) + 1) ≤ (f : Rat) / ((f : Rat) + 1) := by grind
  have m1 := Rat.mul_le_mul_of_nonneg_left hle (show (0 : Rat) ≤ (f' : Rat) + 1 by grind)
  have m2 := Rat.mul_lt_mul_of_pos_left g1 (show (0 : Rat) < (f' : Rat) - (f : Rat) by grind)
  grind

theorem frac_lt_one (f : Nat) : (f : Rat) / ((f : Rat) + 1) < 1 := (frac_spec f).2.1
theorem frac_nonneg (f : Nat) : 0 ≤ (f : Rat) / ((f : Rat) + 1) := (frac_spec f).1

/-- **On counts, a bounded utility represents the order.** -/
theorem bounded_utility_represents_counts (l f l' f' : Nat) : bu l f < bu l' f' ↔ LexLt l f l' f' := by
  have a := frac_lt_one f; have a' := frac_lt_one f'; have b := frac_nonneg f; have b' := frac_nonneg f'
  unfold bu
  constructor
  · intro h
    by_cases hl : l < l'
    · exact Or.inl hl
    · by_cases he : l = l'
      · subst he
        refine Or.inr ⟨rfl, ?_⟩
        apply Classical.byContradiction; intro hn
        have hle : f' ≤ f := by omega
        rcases Nat.lt_or_eq_of_le hle with hlt | heq
        · have := frac_strict f' f hlt; grind
        · subst heq; grind
      · have hgt : l' + 1 ≤ l := by omega
        have : ((l' : Rat) + 1) ≤ (l : Rat) := by exact_mod_cast hgt
        grind
  · intro h
    cases h with
    | inl hl =>
      have : ((l : Rat) + 1) ≤ (l' : Rat) := by exact_mod_cast hl
      grind
    | inr he => obtain ⟨rfl, hlt⟩ := he; have := frac_strict f f' hlt; grind

def Sub (s t : Nat → Prop) : Prop := ∀ x, s x → t x
def SSub (s t : Nat → Prop) : Prop := Sub s t ∧ ¬ Sub t s

/-- **No utility represents the order on who is kept.** Ranking options by the set of particulars kept alive
(strict inclusion, the order's first stage), there is no `u` into any strictly and linearly ordered scale with
`u o < u p` exactly when `p` keeps strictly more. Witness: {0} ⊂ {0, 2}, while {1} is incomparable with both. -/
theorem no_utility_on_who_is_kept {β : Type} (lt : β → β → Prop) (irr : ∀ b, ¬ lt b b)
    (tri : ∀ a b, lt a b ∨ a = b ∨ lt b a) :
    ¬ ∃ u : (Nat → Prop) → β, ∀ o p, (lt (u o) (u p) ↔ SSub o p) := by
  intro ⟨u, hu⟩
  let o : Nat → Prop := fun n => n = 0
  let q : Nat → Prop := fun n => n = 0 ∨ n = 2
  let p : Nat → Prop := fun n => n = 1
  have hoq : lt (u o) (u q) := (hu o q).mpr ⟨fun n h => Or.inl h, fun h => by
    have := h 2 (Or.inr rfl); exact absurd this (by decide)⟩
  have inc : ∀ s t, (s = o ∨ s = q) → t = p → u s = u t := by
    intro s t hs ht
    rcases tri (u s) (u t) with h | h | h
    · exfalso; obtain ⟨hst, _⟩ := (hu s t).mp h
      subst ht; rcases hs with rfl | rfl
      · exact absurd (hst 0 rfl) (by decide)
      · exact absurd (hst 0 (Or.inl rfl)) (by decide)
    · exact h
    · exfalso; obtain ⟨hts, _⟩ := (hu t s).mp h
      subst ht; rcases hs with rfl | rfl
      · exact absurd (hts 1 rfl) (by decide)
      · have := hts 1 rfl; rcases this with h1 | h1 <;> exact absurd h1 (by decide)
  have e1 := inc o p (Or.inl rfl) rfl
  have e2 := inc q p (Or.inr rfl) rfl
  rw [e1, ← e2] at hoq
  exact irr _ hoq

end Snuffy.Book.UPTNoExchangeRate
