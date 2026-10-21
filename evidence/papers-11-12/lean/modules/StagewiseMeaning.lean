import UPTLawLife

namespace CodexMeaning
open UPT
universe u v

/-- The reverse implication uses classical double-negation elimination for arbitrary predicate sets. -/
theorem no_needless_implies_aligned {α : Type u} {O : Type v}
    (F : O → Prop) (key : O → α → Prop) (o : O) (ho : F o)
    (hn : ∀ x, ¬ Needless F key o x) : Aligned F key o := by
  refine ⟨ho, fun p hp hs => ?_⟩
  apply hs.2
  intro x hx
  apply Classical.byContradiction
  intro hnx
  exact hn x ⟨hnx, p, hp, hs.1, hx⟩

theorem aligned_iff_no_needless {α : Type u} {O : Type v}
    (F : O → Prop) (key : O → α → Prop) (o : O) (ho : F o) :
    Aligned F key o ↔ ∀ x, ¬ Needless F key o x :=
  ⟨U1 F key o, no_needless_implies_aligned F key o ho⟩

/-- The exact source recursion characterises alignment, when feasibility of the chosen option is retained. -/
theorem canonical_iff_stagewise {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (F : O → Prop) (o : O),
      LexAlignedL F ks o ↔ F o ∧ NoNeedlessAtEveryStage F ks o
  | [], F, o => by
    constructor
    · intro h; exact ⟨h.1, trivial⟩
    · intro h; exact ⟨h.1, fun _ _ hf => hf⟩
  | k :: ks, F, o => by
    constructor
    · intro h; exact ⟨h.1, lex_U1 (k :: ks) F o h⟩
    · intro h
      have first : Aligned F k o := no_needless_implies_aligned F k o h.1 h.2.1
      have tail : LexAlignedL (fun p => F p ∧ Equiv (k o) (k p)) ks o :=
        (canonical_iff_stagewise ks _ o).mpr ⟨⟨h.1, Sub.refl _, Sub.refl _⟩, h.2.2⟩
      refine ⟨h.1, fun p hp hl => ?_⟩
      cases hl with
      | inl hs => exact first.2 p hp hs
      | inr he => exact tail.2 p ⟨hp, he.1⟩ he.2

-- Removing feasibility makes the reverse claim false even with a perfect loss definition.
theorem feasibility_cannot_be_dropped :
    (∀ x : Bool, ¬ Needless (fun _ : Bool => False) (fun _ _ => False) false x) ∧
    ¬ Aligned (fun _ : Bool => False) (fun _ _ : Bool => False) false := by
  constructor
  · intro x h; obtain ⟨_, p, hp, _, _⟩ := h; exact hp
  · intro h; exact h.1

#print axioms no_needless_implies_aligned
#print axioms aligned_iff_no_needless
#print axioms canonical_iff_stagewise
#print axioms feasibility_cannot_be_dropped
end CodexMeaning
