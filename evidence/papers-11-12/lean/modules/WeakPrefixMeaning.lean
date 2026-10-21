import StagewiseMeaning

namespace CodexWeakPrefix
open UPT CodexMeaning
universe u v

/-- An alternative definition permits competitors preserving (rather than equalling) prior keys,
    while retaining the full current-stage containment in Needless. -/
def NoWeakPrefixNeedless {α : Type u} {O : Type v} :
    (O → Prop) → List (O → α → Prop) → O → Prop
  | _, [], _ => True
  | F, k :: ks, o => (∀ x, ¬ Needless F k o x) ∧
      NoWeakPrefixNeedless (fun p => F p ∧ Sub (k o) (k p)) ks o

/-- Weak prior containment also characterises global alignment. At an aligned option, any feasible
    prior-key improvement is already excluded, so every preserving competitor actually ties that key. -/
theorem canonical_iff_weak_prefix {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (F : O → Prop) (o : O),
      LexAlignedL F ks o ↔ F o ∧ NoWeakPrefixNeedless F ks o
  | [], F, o => by
    constructor
    · intro h; exact ⟨h.1,trivial⟩
    · intro h; exact ⟨h.1,fun _ _ hf => hf⟩
  | k :: ks, F, o => by
    constructor
    · intro h
      have head : Aligned F k o := ⟨h.1,fun p hp hs => h.2 p hp (Or.inl hs)⟩
      have tail : LexAlignedL (fun p => F p ∧ Sub (k o) (k p)) ks o := by
        refine ⟨⟨h.1,Sub.refl _⟩,?_⟩
        intro p hp hb
        have back : Sub (k p) (k o) := by
          apply Classical.byContradiction
          intro hn
          exact head.2 p hp.1 ⟨hp.2,hn⟩
        exact h.2 p hp.1 (Or.inr ⟨⟨hp.2,back⟩,hb⟩)
      exact ⟨h.1,U1 F k o head,((canonical_iff_weak_prefix ks _ o).mp tail).2⟩
    · intro h
      have head : Aligned F k o := no_needless_implies_aligned F k o h.1 h.2.1
      have tail : LexAlignedL (fun p => F p ∧ Sub (k o) (k p)) ks o :=
        (canonical_iff_weak_prefix ks _ o).mpr ⟨⟨h.1,Sub.refl _⟩,h.2.2⟩
      refine ⟨h.1,fun p hp hl => ?_⟩
      cases hl with
      | inl hs => exact head.2 p hp hs
      | inr he => exact tail.2 p ⟨hp,he.1.1⟩ he.2

#print axioms canonical_iff_weak_prefix
end CodexWeakPrefix
