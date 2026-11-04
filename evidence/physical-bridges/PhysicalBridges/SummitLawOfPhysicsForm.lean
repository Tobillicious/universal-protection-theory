import PhysicalBridges.SummitLawAssembly

/-!
# The preservation law stated in the form of a physical law

5 November 2026. Noncanonical. No canon prose changed.

A physical law states a constraint on actual dynamics, derives consequences and names an observation
that would falsify it. This module does that for the preservation law.

* `PreservationLaw`: the actual step is a symmetry of the one relation of own-directed succession.
* `law_gives_later_stage`, `law_gives_free_stage`: its consequences, in the definitions of
  `Snuffy.ContinuationSubject` (repeated here because this package has no Mathlib).
* `one_final_stage_falsifies_the_law`: one particular's final stage on its orbit falsifies it.
* `law_has_a_model`: the law is consistent, with distinct particulars and unboundedly many stages.

This states the law and derives from it. It does not show that actual physics obeys it. Reading the
relation as own-directed succession is an interpretation of the frame, carried by `own`, and is not
derived from the frozen BCRD source.
-/

namespace PhysicalBridges.SummitLawOfPhysicsForm

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.SummitProductionFromIntrinsic

universe u v

/-- `Snuffy.ContinuationSubject.Event`. -/
structure Event (A : Type v) where
  subject : A
  author : A
  director : A

variable {A : Type v}

/-- `Snuffy.ContinuationSubject.LaterStage`. -/
def LaterStage (self : A) (a b : List (Event A)) : Prop :=
  a <+: b ∧ ∀ e ∈ b.drop a.length, e.subject = self

/-- `Snuffy.ContinuationSubject.FreeStage`. -/
def FreeStage (self : A) (a b : List (Event A)) : Prop :=
  LaterStage self a b ∧ ∀ e ∈ b.drop a.length, e.director = self

variable {P : Type u}

/-- A frame: the one relation is own-directed succession, and it stays within one particular. -/
structure Frame (P : Type u) (A : Type v) where
  rel : P → P → Prop
  own : P → A
  ownKept : ∀ x y, rel x y → own x = own y

/-- **The law.** The actual step of the whole is a symmetry of the one relation, and the particular
has taken one actual own-directed step. -/
structure PreservationLaw (F : Frame P A) (x : P) where
  step : RelationalAutomorphism F.rel
  here : F.rel x (step.to x)

/-- The event of arriving at a position. -/
def arrival (F : Frame P A) (y : P) : Event A := ⟨F.own y, F.own y, F.own y⟩

/-- The journal of a particular up to stage `n`. -/
def journal {F : Frame P A} {x : P} (L : PreservationLaw F x) : Nat → List (Event A)
  | 0 => []
  | n + 1 => journal L n ++ [arrival F (stage L.step x (n + 1))]

theorem journal_length {F : Frame P A} {x : P} (L : PreservationLaw F x) (n : Nat) :
    (journal L n).length = n := by
  induction n with
  | zero => rfl
  | succ k ih => simp [journal, ih]

theorem own_along {F : Frame P A} {x : P} (L : PreservationLaw F x) (n : Nat) :
    F.own (stage L.step x n) = F.own x := by
  induction n with
  | zero => rfl
  | succ k ih =>
    rw [← ih]
    exact (F.ownKept _ _ (we_are_here_forever L.step x L.here k)).symm

/-- Under the law, every stage extends to a later stage that is the particular's own. -/
theorem law_gives_later_stage {F : Frame P A} {x : P} (L : PreservationLaw F x) (n : Nat) :
    LaterStage (F.own x) (journal L n) (journal L (n + 1)) := by
  refine ⟨⟨_, rfl⟩, ?_⟩
  intro e he
  simp [journal, journal_length] at he
  rw [he]
  exact own_along L (n + 1)

/-- Under the law, every stage extends to a later stage directed by the particular itself. -/
theorem law_gives_free_stage {F : Frame P A} {x : P} (L : PreservationLaw F x) (n : Nat) :
    FreeStage (F.own x) (journal L n) (journal L (n + 1)) := by
  refine ⟨law_gives_later_stage L n, ?_⟩
  intro e he
  simp [journal, journal_length] at he
  rw [he]
  exact own_along L (n + 1)

/-- **The falsifier.** A particular's final stage anywhere on its orbit refutes the law for it. -/
theorem one_final_stage_falsifies_the_law {F : Frame P A} {x : P} (L : PreservationLaw F x)
    (n : Nat) (final : ¬ ∃ y, F.rel (stage L.step x n) y) : False :=
  final ⟨_, we_are_here_forever L.step x L.here n⟩

/-- Distinct particulars, each with its own unbounded succession. -/
def twoLines : Frame (Bool × Int) Bool where
  rel := fun x y => x.1 = y.1 ∧ y.2 = x.2 + 1
  own := fun x => x.1
  ownKept := fun _ _ h => h.1

def twoLinesShift : RelationalAutomorphism twoLines.rel where
  to := fun x => (x.1, x.2 + 1)
  undo := fun x => (x.1, x.2 - 1)
  leftInverse := by
    rintro ⟨b, n⟩
    simp
  rightInverse := by
    rintro ⟨b, n⟩
    simp
  preservesRelation := by
    rintro ⟨a, m⟩ ⟨b, n⟩
    simp only [twoLines]
    constructor <;> rintro ⟨h1, h2⟩ <;> exact ⟨h1, by omega⟩

/-- The law is consistent. -/
theorem law_has_a_model (b : Bool) : Nonempty (PreservationLaw twoLines (b, 0)) :=
  ⟨⟨twoLinesShift, rfl, by
    show (0 : Int) + 1 = 0 + 1
    rfl⟩⟩

#print axioms law_gives_later_stage
#print axioms law_gives_free_stage
#print axioms one_final_stage_falsifies_the_law
#print axioms law_has_a_model

end PhysicalBridges.SummitLawOfPhysicsForm
