/-
Theorem R1 (cardinality-refined protection), proposed in review, 22 October 2026: counting lives among options the
canonical order leaves incomparable is COMPATIBLE with the law. In every finite nonempty family some option is
canonically maximal AND keeps alive as many existing beings as any feasible option.
- `count_refined_maximal`: for any irreflexive, transitive `better` along which a count never falls.
- `canonical_count_refined`: the canonical life-first order, counting existing beings kept alive.
- `counting_is_an_extra_principle`: keeping {A} and keeping {B, C} are both canonically maximal, so the law alone
  does not choose the larger; counting is an additional principle, not a consequence of U1.
Whether the law adopts counting is the author's ruling; this file proves only that it can. Core Lean 4 only.
-/
namespace UPTCount

universe u v

/-! ### A general finite selection lemma -/

/-- Some element of a nonempty list maximises `c`. -/
theorem exists_max {O : Type v} (c : O → Nat) : ∀ (F : List O), F ≠ [] → ∃ m, m ∈ F ∧ ∀ p, p ∈ F → c p ≤ c m
  | [], h => absurd rfl h
  | [x], _ => ⟨x, List.mem_singleton_self x, fun p hp => by rw [List.mem_singleton.mp hp]; exact Nat.le_refl _⟩
  | x :: y :: ys, _ => by
    obtain ⟨m, hm, hmax⟩ := exists_max c (y :: ys) (List.cons_ne_nil y ys)
    by_cases h : c m ≤ c x
    · refine ⟨x, List.mem_cons_self, fun p hp => ?_⟩
      rcases List.mem_cons.mp hp with rfl | hp
      · exact Nat.le_refl _
      · exact Nat.le_trans (hmax p hp) h
    · refine ⟨m, List.mem_cons_of_mem x hm, fun p hp => ?_⟩
      rcases List.mem_cons.mp hp with rfl | hp
      · exact Nat.le_of_lt (Nat.lt_of_not_le h)
      · exact hmax p hp

/-- A nonempty list has an element with no strictly better element in the list. -/
theorem exists_maximal {O : Type v} (better : O → O → Prop) (irr : ∀ o, ¬ better o o)
    (trans : ∀ a b c, better a b → better b c → better a c) :
    ∀ (F : List O), F ≠ [] → ∃ m, m ∈ F ∧ ∀ p, p ∈ F → ¬ better m p
  | [], h => absurd rfl h
  | [x], _ => ⟨x, List.mem_singleton_self x, fun p hp => by rw [List.mem_singleton.mp hp]; exact irr x⟩
  | x :: y :: ys, _ => by
    obtain ⟨m, hm, hmax⟩ := exists_maximal better irr trans (y :: ys) (List.cons_ne_nil y ys)
    by_cases h : better m x
    · refine ⟨x, List.mem_cons_self, fun p hp hxp => ?_⟩
      rcases List.mem_cons.mp hp with rfl | hp
      · exact irr _ hxp
      · exact hmax p hp (trans m x p h hxp)
    · refine ⟨m, List.mem_cons_of_mem x hm, fun p hp hmp => ?_⟩
      rcases List.mem_cons.mp hp with rfl | hp
      · exact h hmp
      · exact hmax p hp hmp

/-- **R1, general form.** If `better` is a strict partial order and the count `c` never falls along it, some option
of a finite nonempty family is maximal for `better` and has the largest count in the family. -/
theorem count_refined_maximal {O : Type v} (better : O → O → Prop) (irr : ∀ o, ¬ better o o)
    (trans : ∀ a b c, better a b → better b c → better a c) (c : O → Nat)
    (mono : ∀ o p, better o p → c o ≤ c p) (F : List O) (hF : F ≠ []) :
    ∃ m, m ∈ F ∧ (∀ p, p ∈ F → c p ≤ c m) ∧ (∀ p, p ∈ F → ¬ better m p) := by
  obtain ⟨t, ht, htop⟩ := exists_max c F hF
  let Fs := F.filter (fun o => decide (c o = c t))
  have hFs : Fs ≠ [] := by
    intro he
    have : t ∈ Fs := List.mem_filter.mpr ⟨ht, by simp⟩
    rw [he] at this; exact absurd this (List.not_mem_nil)
  obtain ⟨m, hm, hmax⟩ := exists_maximal better irr trans Fs hFs
  have hmF : m ∈ F := (List.mem_filter.mp hm).1
  have hmc : c m = c t := by simpa using (List.mem_filter.mp hm).2
  refine ⟨m, hmF, fun p hp => hmc ▸ htop p hp, fun p hp hmp => ?_⟩
  have h1 := mono m p hmp
  have h2 := htop p hp
  have hpc : c p = c t := by omega
  exact hmax p (List.mem_filter.mpr ⟨hp, by simp [hpc]⟩) hmp

/-! ### The canonical order (definitions as in UPTLawLex.lean) -/

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
def Equiv {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s
def LexBetter {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => False
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexBetter ks o p)

theorem lex_irrefl {α : Type u} {O : Type v} : ∀ (ks : List (O → α → Prop)) (o : O), ¬ LexBetter ks o o
  | [], _, h => h
  | k :: ks, o, h => by
    rcases h with h | h
    · exact h.2 h.1
    · exact lex_irrefl ks o h.2

theorem lex_trans {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (a b c : O), LexBetter ks a b → LexBetter ks b c → LexBetter ks a c
  | [], _, _, _, h, _ => h
  | k :: ks, a, b, c, h1, h2 => by
    rcases h1 with h1 | h1 <;> rcases h2 with h2 | h2
    · exact Or.inl ⟨fun x hx => h2.1 x (h1.1 x hx), fun hca => h1.2 (fun x hx => hca x (h2.1 x hx))⟩
    · exact Or.inl ⟨fun x hx => h2.1.1 x (h1.1 x hx), fun hca => h1.2 (fun x hx => hca x (h2.1.1 x hx))⟩
    · exact Or.inl ⟨fun x hx => h2.1 x (h1.1.1 x hx), fun hca => h2.2 (fun x hx => h1.1.1 x (hca x hx))⟩
    · exact Or.inr ⟨⟨fun x hx => h2.1.1 x (h1.1.1 x hx), fun x hx => h1.1.2 x (h2.1.2 x hx)⟩,
        lex_trans ks a b c h1.2 h2.2⟩

/-- Count of the beings in `U` that a set keeps. -/
def count {α : Type u} (U : List α) (s : α → Prop) [DecidablePred s] : Nat := (U.filter (fun x => decide (s x))).length

theorem count_mono {α : Type u} (U : List α) (s t : α → Prop) [DecidablePred s] [DecidablePred t]
    (h : Sub s t) : count U s ≤ count U t := by
  induction U with
  | nil => simp [count]
  | cons x U ih =>
    by_cases hs : s x
    · have ht : t x := h x hs
      simp [count, hs, ht] at ih ⊢; omega
    · by_cases ht : t x <;> simp [count, hs, ht] at ih ⊢ <;> omega

/-- **R1 for the canonical life-first order.** Over a finite list `U` of existing beings and a finite nonempty
family `F`, some option is canonically maximal and keeps alive as many beings of `U` as any feasible option. -/
theorem canonical_count_refined {α : Type u} {O : Type v} (U : List α)
    (aliveE freeE aliveN freeN : O → α → Prop) [∀ o, DecidablePred (aliveE o)] (F : List O) (hF : F ≠ []) :
    ∃ m, m ∈ F ∧ (∀ p, p ∈ F → count U (aliveE p) ≤ count U (aliveE m)) ∧
      (∀ p, p ∈ F → ¬ LexBetter [aliveE, freeE, aliveN, freeN] m p) := by
  apply count_refined_maximal (LexBetter [aliveE, freeE, aliveN, freeN]) (lex_irrefl _) (lex_trans _)
    (fun o => count U (aliveE o)) _ F hF
  intro o p h
  apply count_mono
  rcases h with h | h
  · exact h.1
  · exact h.1.1

/-! ### Counting is an extra principle -/

inductive Being | a | b | c deriving DecidableEq

/-- **The referee's pair.** Keeping {A} and keeping {B, C} are each canonically maximal (neither is better), though
the second keeps more: U1 alone does not choose it. -/
theorem counting_is_an_extra_principle :
    let X : Being → Prop := fun x => x = .a
    let Y : Being → Prop := fun x => x ≠ .a
    ¬ LexBetter [fun (s : Being → Prop) => s] X Y ∧ ¬ LexBetter [fun (s : Being → Prop) => s] Y X := by
  intro X Y
  constructor
  · intro h
    rcases h with h | h
    · exact absurd (h.1 Being.a rfl) (fun hy => hy rfl)
    · exact absurd (h.1.1 Being.a rfl) (fun hy => hy rfl)
  · intro h
    rcases h with h | h
    · exact Being.noConfusion (h.1 Being.b (fun e => Being.noConfusion e))
    · exact Being.noConfusion (h.1.1 Being.b (fun e => Being.noConfusion e))

end UPTCount
