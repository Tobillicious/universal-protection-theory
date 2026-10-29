/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTExistence.lean`, sha256 `87f3769a0d0ec1a2be9a906c5b5b840ad709911f73af7cb138fb50188520f343`).
Namespace `UPTExist` renamed to `Snuffy.Book.UPTExistence` for the canon's joint audit; statements and proofs unchanged. -/

/-
Existence of aligned options (Paper 12, section 3: the life guard's existence clause, and "real tragedies are
finite"). Definitions from UPTLaw.lean and UPTLawLex.lean are repeated verbatim. Core Lean 4 only.
- In every nonempty finite feasible family an aligned option exists, in the full canonical order and in
  the inclusion order. No premises.
- So in every finite situation some option loses nothing needlessly (with U1).
- In an infinite family this can fail: every option can needlessly lose something. A condition on infinite
  families cannot be dropped.
-/
namespace Snuffy.Book.UPTExistence

universe u v

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
theorem Sub.refl {α : Type u} (s : α → Prop) : Sub s s := fun _ h => h
theorem Sub.trans {α : Type u} {a b c : α → Prop} (h1 : Sub a b) (h2 : Sub b c) : Sub a c :=
  fun x hx => h2 x (h1 x hx)
def Aligned {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ SSub (key o) (key p)
def Needless {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) (x : α) : Prop :=
  ¬ key o x ∧ ∃ p, F p ∧ Sub (key o) (key p) ∧ key p x
theorem U1 {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O)
    (h : Aligned F key o) : ∀ x, ¬ Needless F key o x := by
  intro x hn
  obtain ⟨hnx, p, hp, hsub, hpx⟩ := hn
  exact h.2 p hp ⟨hsub, fun hback => hnx (hback x hpx)⟩
theorem SSub.trans_sub {α : Type u} {a b c : α → Prop} (h1 : SSub a b) (h2 : Sub b c) : SSub a c :=
  ⟨Sub.trans h1.1 h2, fun hca => h1.2 (Sub.trans h2 hca)⟩
theorem Sub.trans_ssub {α : Type u} {a b c : α → Prop} (h1 : Sub a b) (h2 : SSub b c) : SSub a c :=
  ⟨Sub.trans h1 h2.1, fun hca => h2.2 (Sub.trans hca h1)⟩
def Equiv {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s
def LexBetter {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => False
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexBetter ks o p)
theorem lex_irrefl {α : Type u} {O : Type v} : ∀ (ks : List (O → α → Prop)) (o : O), ¬ LexBetter ks o o
  | [], _, h => h
  | k :: ks, o, h => by
    cases h with
    | inl hs => exact hs.2 (Sub.refl _)
    | inr he => exact lex_irrefl ks o he.2
theorem lex_trans {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o p q : O), LexBetter ks o p → LexBetter ks p q → LexBetter ks o q
  | [], _, _, _, h, _ => h
  | k :: ks, o, p, q, h1, h2 => by
    cases h1 with
    | inl s1 =>
      cases h2 with
      | inl s2 => exact Or.inl (SSub.trans_sub s1 s2.1)
      | inr e2 => exact Or.inl (SSub.trans_sub s1 e2.1.1)
    | inr e1 =>
      cases h2 with
      | inl s2 => exact Or.inl (Sub.trans_ssub e1.1.1 s2)
      | inr e2 =>
        exact Or.inr ⟨⟨Sub.trans e1.1.1 e2.1.1, Sub.trans e2.1.2 e1.1.2⟩, lex_trans ks o p q e1.2 e2.2⟩
def LexAlignedL {α : Type u} {O : Type v} (F : O → Prop) (ks : List (O → α → Prop)) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ LexBetter ks o p

/-- Generic: for any irreflexive, transitive relation, every element of a finite list can be climbed to an
element that nothing in the list strictly exceeds. -/
theorem climb {O : Type v} (R : O → O → Prop) (tr : ∀ a b c, R a b → R b c → R a c)
    (irr : ∀ o, ¬ R o o) : ∀ (L : List O) (b : O), ∃ m, (m = b ∨ m ∈ L) ∧ ∀ c, c ∈ L → ¬ R m c := by
  intro L
  induction L with
  | nil => intro b; exact ⟨b, Or.inl rfl, fun c hc => nomatch hc⟩
  | cons x L ih =>
    intro b
    obtain ⟨m, hmem, hmax⟩ := ih b
    by_cases hmx : R m x
    · refine ⟨x, Or.inr List.mem_cons_self, ?_⟩
      intro c hc hxc
      cases hc with
      | head => exact irr x hxc
      | tail _ hcL => exact hmax c hcL (tr m x c hmx hxc)
    · refine ⟨m, ?_, ?_⟩
      · cases hmem with
        | inl h => exact Or.inl h
        | inr h => exact Or.inr (List.mem_cons_of_mem x h)
      · intro c hc hmc
        cases hc with
        | head => exact hmx hmc
        | tail _ hcL => exact hmax c hcL hmc

/-- **Existence in the canonical order.** Every nonempty finite feasible family has an option aligned in
the full canonical (stagewise lexicographic) order. No premises. -/
theorem lex_aligned_exists {α : Type u} {O : Type v} (ks : List (O → α → Prop)) (L : List O)
    (hne : ∃ b, b ∈ L) : ∃ o, LexAlignedL (fun p => p ∈ L) ks o := by
  obtain ⟨b, hb⟩ := hne
  obtain ⟨m, hm, hmax⟩ := climb (LexBetter ks) (lex_trans ks) (lex_irrefl ks) L b
  refine ⟨m, ?_, fun p hp => hmax p hp⟩
  cases hm with
  | inl h => exact h ▸ hb
  | inr h => exact h

/-- **Existence in the inclusion order.** Every nonempty finite feasible family has an aligned option. -/
theorem aligned_exists {α : Type u} {O : Type v} (key : O → α → Prop) (L : List O)
    (hne : ∃ b, b ∈ L) : ∃ o, Aligned (fun p => p ∈ L) key o := by
  obtain ⟨b, hb⟩ := hne
  have tr : ∀ a b c : O, SSub (key a) (key b) → SSub (key b) (key c) → SSub (key a) (key c) :=
    fun _ _ _ h1 h2 => SSub.trans_sub h1 h2.1
  have irr : ∀ o : O, ¬ SSub (key o) (key o) := fun o h => h.2 (Sub.refl _)
  obtain ⟨m, hm, hmax⟩ := climb (fun o p => SSub (key o) (key p)) tr irr L b
  refine ⟨m, ?_, fun p hp => hmax p hp⟩
  cases hm with
  | inl h => exact h ▸ hb
  | inr h => exact h

/-- **Protection is achievable in every finite situation.** In every nonempty finite feasible family there
is an option that needlessly loses nothing. (Existence plus U1.) -/
theorem no_needless_choice_exists {α : Type u} {O : Type v} (key : O → α → Prop) (L : List O)
    (hne : ∃ b, b ∈ L) : ∃ o, o ∈ L ∧ ∀ x, ¬ Needless (fun p => p ∈ L) key o x := by
  obtain ⟨o, ho⟩ := aligned_exists key L hne
  exact ⟨o, ho.1, U1 _ key o ho⟩

/-- An unbounded chain: option n keeps exactly the particulars k ≤ n. -/
def chainKey : Nat → Nat → Prop := fun n k => k ≤ n

/-- **The finiteness condition cannot be dropped.** In this infinite feasible family every option needlessly
loses something (option n needlessly loses n + 1), so no option is aligned. -/
theorem infinite_family_forces_needless_loss : ∀ n, Needless (fun _ => True) chainKey n (n + 1) := by
  intro n
  exact ⟨Nat.not_succ_le_self n, n + 1, trivial, fun k hk => Nat.le_succ_of_le hk, Nat.le_refl _⟩

theorem infinite_family_has_no_aligned_option : ∀ n, ¬ Aligned (fun _ => True) chainKey n :=
  fun n h => U1 _ chainKey n h (n + 1) (infinite_family_forces_needless_loss n)

end Snuffy.Book.UPTExistence
