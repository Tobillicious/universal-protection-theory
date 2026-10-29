import Mathlib

/-!
# Continuation predicates with care and exchange (Part XI.5 item 3, repaired schema)

The hostile referee of 29 October 2026 observed that `ContinuationPredicate`'s
`author = self` condition makes every act of care by another break continuation,
against the author's definition ("settled by itself in exchange with what is around
it"). This schema separates three roles of an event:

* `subject` — whose history the event belongs to;
* `author` — whose activity produced it (a carer may author an event of my history);
* `director` — who settled what was done.

Continuation (`LaterStage`) requires every added event to be of the particular's own
history (`subject = self`). Freedom (`FreeStage`) additionally requires every added
event to be directed by the particular itself (ruling 3). Care by another, directed by
the particular, keeps both (`care_keeps_freedom`). A copy whose history begins with
its making is not a later stage (`copy_not_laterStage`); identifying the true subject
of an event is the physical provenance each class supplies.
-/

namespace Snuffy.ContinuationSubject

variable {A : Type*}

structure Event (A : Type*) where
  subject : A
  author : A
  director : A

def LaterStage (self : A) (a b : List (Event A)) : Prop :=
  a <+: b ∧ ∀ e ∈ b.drop a.length, e.subject = self

def FreeStage (self : A) (a b : List (Event A)) : Prop :=
  LaterStage self a b ∧ ∀ e ∈ b.drop a.length, e.director = self

theorem laterStage_refl (self : A) (a : List (Event A)) : LaterStage self a a :=
  ⟨List.prefix_refl a, fun e he => by simp at he⟩

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

/-- A copy is another history (D60). -/
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

/-- A split continues in both branches. -/
theorem split_continues_both (self : A) (a s₁ s₂ : List (Event A))
    (h₁ : ∀ e ∈ s₁, e.subject = self) (h₂ : ∀ e ∈ s₂, e.subject = self) :
    LaterStage self a (a ++ s₁) ∧ LaterStage self a (a ++ s₂) :=
  ⟨⟨List.prefix_append a s₁, fun e he => h₁ e (by simpa using he)⟩,
   ⟨List.prefix_append a s₂, fun e he => h₂ e (by simpa using he)⟩⟩

/-- **Care by another keeps continuation and freedom**, when the cared-for
particular directs it. -/
theorem care_keeps_freedom (self carer : A) (a : List (Event A)) :
    FreeStage self a (a ++ [⟨self, carer, self⟩]) :=
  ⟨⟨List.prefix_append a _, fun e he => by simp at he; rw [he]⟩,
   fun e he => by simp at he; rw [he]⟩

/-- Taking direction is an ending to that degree (ruling 3). -/
theorem directed_by_other_not_free (self : A) (a b : List (Event A))
    (e : Event A) (he : e ∈ b.drop a.length) (hdir : e.director ≠ self) :
    ¬ FreeStage self a b :=
  fun h => hdir (h.2 e he)

/-- A faithful hold preserves continuation (released lived history = undisturbed). -/
theorem faithful_hold_preserves (self : A) (a released ideal : List (Event A))
    (hfaithful : released = ideal) :
    LaterStage self a released ↔ LaterStage self a ideal := by
  rw [hfaithful]

end Snuffy.ContinuationSubject
