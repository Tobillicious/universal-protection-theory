/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTLawGuard.lean`, sha256 `220b9e1338af6367dae1317175070604c94aca8c8ea840e4a915f8dcfc4e03f0`).
Namespace `UPT` renamed to `Snuffy.Book.UPTLawGuard` for the canon's joint audit; statements and proofs unchanged. -/

/-
  UPT law, repair round 2 (after Codex's v1.2 read, 21 October 2026). Claude (Opus 5.5). Core Lean 4 only.
  The order definitions are repeated verbatim from the sealed `UPTLawLex.lean`.
-/
namespace Snuffy.Book.UPTLawGuard

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

/-- Equal as sets (mutual inclusion). -/
def Equiv {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s

/-- `LexBetter ks o p`: p is strictly better than o in the lexicographic partial order of the stage keys
    `ks`, consulting a later stage only when all earlier stages are equal. -/
def LexBetter {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => False
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexBetter ks o p)

/-- **O-8 (a).** The canonical order is irreflexive. -/
theorem lex_irrefl {α : Type u} {O : Type v} : ∀ (ks : List (O → α → Prop)) (o : O), ¬ LexBetter ks o o
  | [], _, h => h
  | k :: ks, o, h => by
    cases h with
    | inl hs => exact hs.2 (Sub.refl _)
    | inr he => exact lex_irrefl ks o he.2

/-- **O-8 (b).** The canonical order is transitive: a genuine strict partial order. -/
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

/-- Aligned in the canonical order. -/
def LexAlignedL {α : Type u} {O : Type v} (F : O → Prop) (ks : List (O → α → Prop)) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ LexBetter ks o p

/-- **O-4 repaired (Codex N5): the guard lifts to the FULL canonical order for the first-stage key.**
    An option canonically aligned among the feasible options that keep everything standby keeps at stage 1 is
    canonically aligned in the whole family, and keeps everything standby keeps at stage 1. The guard therefore
    protects exactly what the order puts first. -/
theorem guard_first_stage {α : Type u} {O : Type v} (F : O → Prop) (k : O → α → Prop)
    (ks : List (O → α → Prop)) (s m : O)
    (h : LexAlignedL (fun p => F p ∧ Sub (k s) (k p)) (k :: ks) m) :
    LexAlignedL F (k :: ks) m ∧ Sub (k s) (k m) := by
  refine ⟨⟨h.1.1, fun p hp hl => ?_⟩, h.1.2⟩
  have hsp : Sub (k s) (k p) := by
    cases hl with
    | inl hs => exact Sub.trans h.1.2 hs.1
    | inr he => exact Sub.trans h.1.2 he.1.1
  exact h.2 p ⟨hp, hsp⟩ hl

end Snuffy.Book.UPTLawGuard
