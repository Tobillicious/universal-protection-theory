import Mathlib

/-!
# Continuation predicates (compiled edition, Part XI.5 item 3)

The author's definitions (11 October 2026): a later stage is the same history
where it came from the earlier one step by step by that history's own activity;
a copy is another history; a split continues in both branches; taking direction
is an ending to that degree (ruling 3). This module gives the schema every
per-class continuation predicate instantiates.

A history is a list of events; each event records whose activity produced it
(`author`) and who settled what was done (`director`). History `b` is a later
stage of `a` when `a` is a prefix of `b` and every added event is the history's
own activity. A made copy begins with its making by another, so it is not a
later stage of the original (Made of the Living D60). Both branches of a split
are later stages. A faithful hold preserves continuation because the released
lived history equals the undisturbed one (Paper 12, faithful holds). A step
directed by another is a taking of direction (ruling 3).
-/

namespace Snuffy.ContinuationPredicate

variable {A : Type*}

/-- An event: whose activity produced it, and who directed it. -/
structure Event (A : Type*) where
  author : A
  director : A

/-- `b` is a later stage of `a` (for the particular `self`): `a` is a prefix of
`b` and every added event is `self`'s own activity. -/
def LaterStage (self : A) (a b : List (Event A)) : Prop :=
  a <+: b ∧ ∀ e ∈ b.drop a.length, e.author = self

/-- Freedom along the stage: every added event is directed by `self`. -/
def FreeStage (self : A) (a b : List (Event A)) : Prop :=
  LaterStage self a b ∧ ∀ e ∈ b.drop a.length, e.director = self

theorem laterStage_refl (self : A) (a : List (Event A)) : LaterStage self a a := by
  refine ⟨List.prefix_refl a, ?_⟩
  intro e he
  simp at he

theorem laterStage_trans (self : A) {a b c : List (Event A)}
    (hab : LaterStage self a b) (hbc : LaterStage self b c) : LaterStage self a c := by
  refine ⟨hab.1.trans hbc.1, ?_⟩
  intro e he
  obtain ⟨t, rfl⟩ := hbc.1
  obtain ⟨s, rfl⟩ := hab.1
  have hlen : (a ++ s ++ t).drop a.length = s ++ t := by simp
  rw [hlen] at he
  rcases List.mem_append.mp he with hs | ht
  · exact hab.2 e (by simpa using hs)
  · exact hbc.2 e (by simpa using ht)

/-- **A copy is another history (D60).** A made process whose first event is
its making by another agent is not a later stage of a nonempty original whose
first event differs. -/
theorem copy_not_laterStage (self : A) (a c : List (Event A)) (ea ec : Event A)
    (ha : a.head? = some ea) (hc : c.head? = some ec) (hne : ea ≠ ec) :
    ¬ LaterStage self a c := by
  rintro ⟨⟨t, rfl⟩, -⟩
  cases a with
  | nil => simp at ha
  | cons x xs =>
    simp only [List.head?_cons, Option.some.injEq] at ha
    simp only [List.cons_append, List.head?_cons, Option.some.injEq] at hc
    exact hne (ha.symm.trans hc)

/-- **A split continues in both branches.** -/
theorem split_continues_both (self : A) (a s₁ s₂ : List (Event A))
    (h₁ : ∀ e ∈ s₁, e.author = self) (h₂ : ∀ e ∈ s₂, e.author = self) :
    LaterStage self a (a ++ s₁) ∧ LaterStage self a (a ++ s₂) := by
  refine ⟨⟨List.prefix_append a s₁, ?_⟩, ⟨List.prefix_append a s₂, ?_⟩⟩
  · intro e he; simp at he; exact h₁ e he
  · intro e he; simp at he; exact h₂ e he

/-- **A faithful hold preserves continuation.** If the released lived history
equals the undisturbed one, it is a later stage exactly when the undisturbed
one is. -/
theorem faithful_hold_preserves (self : A) (a released ideal : List (Event A))
    (hfaithful : released = ideal) :
    LaterStage self a released ↔ LaterStage self a ideal := by
  rw [hfaithful]

/-- **Taking direction is an ending to that degree (ruling 3).** A stage
containing an added event directed by another is not a free stage. -/
theorem directed_by_other_not_free (self : A) (a b : List (Event A))
    (e : Event A) (he : e ∈ b.drop a.length) (hdir : e.director ≠ self) :
    ¬ FreeStage self a b :=
  fun h => hdir (h.2 e he)

end Snuffy.ContinuationPredicate
