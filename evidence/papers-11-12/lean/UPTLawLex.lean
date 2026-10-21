/-
  UPT law: closing O-8 (the canonical four-stage lexicographic order) and the structural half of O-4.
  Claude (Opus 5.5), 21 October 2026. Core Lean 4 only. Definitions from `UPTLaw.lean` are repeated verbatim.
-/
namespace UPT

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

/-- No needless loss at any stage: at stage 1 among all feasible options, at stage 2 among those equal at
    stage 1, and so on. -/
def NoNeedlessAtEveryStage {α : Type u} {O : Type v} : (O → Prop) → List (O → α → Prop) → O → Prop
  | _, [], _ => True
  | F, k :: ks, o => (∀ x, ¬ Needless F k o x) ∧
      NoNeedlessAtEveryStage (fun p => F p ∧ Equiv (k o) (k p)) ks o

/-- **O-8 (c), U1 for the canonical order.** An agent aligned in the canonical order never needlessly loses
    anything at any stage. -/
theorem lex_U1 {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (F : O → Prop) (o : O), LexAlignedL F ks o → NoNeedlessAtEveryStage F ks o
  | [], _, _, _ => trivial
  | k :: ks, F, o, h => by
    refine ⟨U1 F k o ⟨h.1, fun p hp hs => h.2 p hp (Or.inl hs)⟩, ?_⟩
    apply lex_U1 ks
    refine ⟨⟨h.1, Sub.refl _, Sub.refl _⟩, fun p hp hl => h.2 p hp.1 (Or.inr ⟨hp.2, hl⟩)⟩

/-- **Legacy, freedom-first.** Kept for the record: this instance uses the order that preceded the
    life-first ruling. The adopted canonical order is life first; its instance is UPTLawLife.canonical_life_first_U1.
    Original note: **O-8 (d), the canonical four-stage instance**: existing kept free, existing kept alive, new made free,
    new made alive. -/
theorem freedom_first_U1_legacy {α : Type u} {O : Type v} (F : O → Prop) (freeE aliveE freeN aliveN : O → α → Prop) (o : O)
    (h : LexAlignedL F [freeE, aliveE, freeN, aliveN] o) :
    NoNeedlessAtEveryStage F [freeE, aliveE, freeN, aliveN] o :=
  lex_U1 _ F o h

/-- **O-4 (structural half).** An option that is maximal among the feasible options keeping everything standby
    keeps is aligned in the whole family, and keeps everything standby keeps. Zorn's lemma supplies such an
    option in any family whose chains above standby have upper bounds; finite families always have one. -/
theorem guard_maximal_above {α : Type u} {O : Type v} (F : O → Prop) (k : O → α → Prop) (s m : O)
    (hm : F m) (hsm : Sub (k s) (k m))
    (hmax : ∀ p, F p → Sub (k s) (k p) → ¬ SSub (k m) (k p)) : Aligned F k m ∧ Sub (k s) (k m) :=
  ⟨⟨hm, fun p hp hss => hmax p hp (Sub.trans hsm hss.1) hss⟩, hsm⟩

end UPT
