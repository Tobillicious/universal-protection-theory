/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTAdequacy.lean`, sha256 `898aa02fd803916f978c0c4e8f27f57acfa37c19f406645f1a583a8fc74c0f14`).
Namespace `UPTAdequacy` renamed to `Snuffy.Book.UPTAdequacy` for the canon's joint audit; statements and proofs unchanged. -/

/-
Definitional adequacy (the "semantic gap"): independently stated forms of the key definitions provably agree.
Definitions are repeated verbatim from UPTLaw.lean, UPTLawLex.lean and UPTRestraint.lean. Core Lean 4 only.
1. The canonical order: the recursive definition equals the English one ("at the first stage where the two
   options differ, the strictly larger one wins; later stages count only when all earlier stages are equal").
2. Life first, in the order itself: no improvement ever costs an existing life; with lives equal, none costs
   existing freedom; an option that loses an existing life is never better, whatever else it gains.
3. Restraint three ways: restrainable = needlessly ends someone (U1's notion) = not aligned among the agent's
   own options.
-/
namespace Snuffy.Book.UPTAdequacy

universe u v

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
def Equiv {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s
def LexBetter {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => False
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexBetter ks o p)
def Aligned {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ SSub (key o) (key p)
def Needless {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) (x : α) : Prop :=
  ¬ key o x ∧ ∃ p, F p ∧ Sub (key o) (key p) ∧ key p x
def Restrainable {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop) : Prop :=
  ∃ b, A b ∧ SSub a b

/-! ### 1. The canonical order is the "first differing stage" order -/

/-- **The recursive definition is the English one.** `p` is better than `o` exactly when the stage list splits
as `pre ++ k :: post`, the two options are equal at every stage in `pre`, and `p` keeps strictly more at `k`. -/
theorem lex_iff_first_difference {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o p : O), LexBetter ks o p ↔
      ∃ pre k post, ks = pre ++ k :: post ∧ (∀ k', k' ∈ pre → Equiv (k' o) (k' p)) ∧ SSub (k o) (k p)
  | [], o, p => by
    constructor
    · intro h; exact absurd h id
    · intro ⟨pre, k, post, heq, _, _⟩
      cases pre <;> simp at heq
  | k :: ks, o, p => by
    constructor
    · intro h
      cases h with
      | inl hs => exact ⟨[], k, ks, rfl, ⟨(fun k' hk' => by cases hk'), hs⟩⟩
      | inr he =>
        obtain ⟨pre, k', post, heq, hpre, hs⟩ := (lex_iff_first_difference ks o p).mp he.2
        refine ⟨k :: pre, k', post, by rw [heq]; rfl, ?_, hs⟩
        intro k'' hk''
        cases hk'' with
        | head => exact he.1
        | tail _ hmem => exact hpre k'' hmem
    · intro ⟨pre, k', post, heq, hpre, hs⟩
      cases pre with
      | nil =>
        simp only [List.nil_append, List.cons.injEq] at heq
        obtain ⟨h1, _⟩ := heq
        subst h1; exact Or.inl hs
      | cons h t =>
        simp only [List.cons_append, List.cons.injEq] at heq
        obtain ⟨h1, h2⟩ := heq
        subst h1
        refine Or.inr ⟨hpre _ List.mem_cons_self, (lex_iff_first_difference ks o p).mpr ⟨t, k', post, h2, ?_, hs⟩⟩
        intro k'' hk''; exact hpre k'' (List.mem_cons_of_mem _ hk'')

/-! ### 2. "Life first", read off the order -/

/-- Any improvement in a stagewise order keeps everything the first stage kept. -/
theorem lex_keeps_first_stage {α : Type u} {O : Type v} (k : O → α → Prop) (ks : List (O → α → Prop)) (o p : O)
    (h : LexBetter (k :: ks) o p) : Sub (k o) (k p) := by
  cases h with
  | inl hs => exact hs.1
  | inr he => exact he.1.1

/-- **No improvement ever costs an existing life.** Under the canonical order (existing kept alive, existing
kept free, new made alive, new made free), every option that is better keeps alive everyone the other kept alive. -/
theorem improvement_never_costs_a_life {α : Type u} {O : Type v} (aliveE freeE aliveN freeN : O → α → Prop)
    (o p : O) (h : LexBetter [aliveE, freeE, aliveN, freeN] o p) : Sub (aliveE o) (aliveE p) :=
  lex_keeps_first_stage aliveE _ o p h

/-- **With lives equal, no improvement costs existing freedom.** -/
theorem improvement_never_costs_existing_freedom {α : Type u} {O : Type v} (aliveE freeE aliveN freeN : O → α → Prop)
    (o p : O) (h : LexBetter [aliveE, freeE, aliveN, freeN] o p) (heq : Equiv (aliveE o) (aliveE p)) :
    Sub (freeE o) (freeE p) := by
  cases h with
  | inl hs => exact absurd heq.2 hs.2
  | inr he => exact lex_keeps_first_stage freeE _ o p he.2

/-- **Losing an existing life is never better, whatever else is gained** (the author's ruling U3, read off the
order): if `p` fails to keep alive someone `o` keeps alive, `p` is not better than `o`, however much more it
offers beings not yet made or in freedom. -/
theorem losing_a_life_is_never_better {α : Type u} {O : Type v} (aliveE freeE aliveN freeN : O → α → Prop)
    (o p : O) (hlose : ¬ Sub (aliveE o) (aliveE p)) : ¬ LexBetter [aliveE, freeE, aliveN, freeN] o p :=
  fun h => hlose (improvement_never_costs_a_life aliveE freeE aliveN freeN o p h)

/-! ### 3. Restraint, three ways -/

/-- **Restrainable = needlessly ends someone.** Judged from the agent's own options, an act is restrainable
exactly when some particular it ends is needlessly ended (U1's notion, with options as the sets they keep). -/
theorem restrainable_iff_needless {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop) :
    Restrainable A a ↔ ∃ x, Needless A (fun o => o) a x := by
  constructor
  · intro ⟨b, hb, hsub, hns⟩
    apply Classical.byContradiction
    intro hno
    apply hns
    intro x hbx
    apply Classical.byContradiction
    intro hax
    exact hno ⟨x, hax, b, hb, hsub, hbx⟩
  · intro ⟨x, hax, b, hb, hsub, hbx⟩
    exact ⟨b, hb, hsub, fun hba => hax (hba x hbx)⟩

/-- **Restrainable = not aligned.** For an act among the agent's own options, it is restrainable exactly when
it is not aligned there. -/
theorem restrainable_iff_not_aligned {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop) (ha : A a) :
    Restrainable A a ↔ ¬ Aligned A (fun o => o) a := by
  constructor
  · intro ⟨b, hb, hs⟩ hal; exact hal.2 b hb hs
  · intro hnal
    apply Classical.byContradiction
    intro hnr
    apply hnal
    exact ⟨ha, fun b hb hs => hnr ⟨b, hb, hs⟩⟩

end Snuffy.Book.UPTAdequacy
