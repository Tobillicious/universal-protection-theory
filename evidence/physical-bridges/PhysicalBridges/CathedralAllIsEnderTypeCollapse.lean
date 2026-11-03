import PhysicalBridges.CathedralCapstoneJoins

/-!
CATHEDRAL / ALL IS — the exact same-type guardian–ender collapse.

A mathematical actuality cannot be internally witnessed as having
*no actual occurrences at all*: any enacted operation is itself
witnessed within the same totality. This is the user's "ALL IS"
floor, with no outside time, observer, second universe or exterior
agent.

We test the **strongest possible guardian–ender inference**:

  actual operation -> guardian OR realized absolute ender
  realized absolute ender -> impossible
  ----------------------------------------------------
  actual operation -> guardian.

The first arrow and the meaning of "guardian" are load-bearing.
This module types THREE conceptually distinct predicates on the
very same physical action:
* intrinsicGuardian: a member of the foundational ontological class;
* x3Guardian: actually preserves original-X3 duties of particulars;
* enderStrategy: a preference/attempt, not a realized absolute ending.

No syntactic or implicit identification of the three is permitted.
Theorem K/G's strategic "enders are ghosts" does not mean the last
class has an inhabitant of the realized-absolute-ending type.

This is a scoped proof-architecture / independence audit, not a new
BCRD physical-possibility result, an assertion that the original
guardian/ender partition has been source-derived, or a weakening
of X3. All demonstrations in the negative control are synthetic
propositional/type models, NOT BCRD physical counterexamples.
-/

namespace PhysicalBridges.CathedralAllIsEnderTypeCollapse

universe u v

/-- ONE intrinsic actuality. An enacted operation has a consequence
that belongs to this same actuality. We do not posit an observer,
external time, or different physical universe. -/
structure IntrinsicAccount (Event : Type u) (Action : Type v) where
  actual : Event → Prop
  enacted : Action → Prop
  occurrence : Action → Event
  enactedOccurs : ∀ a, enacted a → actual (occurrence a)

  /-- The independent historical/ontological guardian classification. -/
  intrinsicGuardian : Action → Prop
  /-- The full ORIGINAL X3 event protection, not a redefined proxy. -/
  originalX3Guardian : Action → Prop
  /-- A preference or attempted goal, not an event that actually erases ALL. -/
  enderStrategy : Action → Prop

variable {Event : Type u} {Action : Type v}

/-- An operation claiming to be both ENACTED and to make *every*
occurrence in the SAME complete actual history not actual. This
expresses its purported effect, not a merely aspirational objective. -/
def RealizedAbsoluteEnder
    (w : IntrinsicAccount Event Action) (a : Action) : Prop :=
  w.enacted a ∧ ∀ e, ¬ w.actual e

/-- The claimed realized absolute ender has no inhabitant:
its own enacted occurrence is among what its claimed output
negates. Importantly this does NOT prove the absence of an
end-valuing *strategy*, a local casualty, or a chosen internal
transition whose future is harmful to another particular. -/
theorem no_realized_absolute_ender
    (w : IntrinsicAccount Event Action) (a : Action) :
    ¬ RealizedAbsoluteEnder w a := by
  rintro ⟨hEnacted, hNothing⟩
  exact hNothing (w.occurrence a) (w.enactedOccurs a hEnacted)

/-- The strong no-middle-ground premise, typed over the *same*
actual actions and with an ender whose meaning is realized
absolute ending. It has to be shown from the actual source:
it CANNOT be inferred merely by calling all non-guardians enders. -/
def StrongSameTypeDichotomy
    (w : IntrinsicAccount Event Action) : Prop :=
  ∀ a, w.enacted a →
    w.intrinsicGuardian a ∨ RealizedAbsoluteEnder w a

/-- EXACT collapse of the impossible ender type. This is a sound
short proof of the author's original schematic inference, given
a physically sourced SAME-TYPE exhaustive dichotomy. -/
theorem all_is_eliminates_realized_ender_branch
    (w : IntrinsicAccount Event Action)
    (hNoMiddle : StrongSameTypeDichotomy w) :
    ∀ a, w.enacted a → w.intrinsicGuardian a := by
  intro a hActual
  rcases hNoMiddle a hActual with hGuardian | hEnder
  · exact hGuardian
  · exact False.elim ((no_realized_absolute_ender w a) hEnder)

/-- The second exact join is separately stated rather than
renaming the ontological guardian classification into the
original-X3 protection of each individual. -/
theorem full_x3_from_ontological_collapse_and_reflection
    (w : IntrinsicAccount Event Action)
    (hNoMiddle : StrongSameTypeDichotomy w)
    (hReflect : ∀ a, w.enacted a →
      w.intrinsicGuardian a → w.originalX3Guardian a) :
    ∀ a, w.enacted a → w.originalX3Guardian a := by
  intro a hActual
  exact hReflect a hActual
    (all_is_eliminates_realized_ender_branch w hNoMiddle a hActual)

/-- If the original "guardian" classification is ALREADY exactly
original-X3-event preservation, the same argument has ONE fewer
join. This is the strongest direct statement we can prove without
changing the meaning of the ender branch. Whether this is the
actual independently justified original dichotomy is an open
source-verification question, not a definitional convention. -/
theorem original_x3_direct_collapse
    (w : IntrinsicAccount Event Action)
    (hNoMiddleX3 : ∀ a, w.enacted a →
      w.originalX3Guardian a ∨ RealizedAbsoluteEnder w a) :
    ∀ a, w.enacted a → w.originalX3Guardian a := by
  intro a hEnacted
  rcases hNoMiddleX3 a hEnacted with hX3 | hEnder
  · exact hX3
  · exact False.elim ((no_realized_absolute_ender w a) hEnder)

/-- Equivalent contrapositive formulation of the exact disputed
source join: every ACTUALLY enacted original-X3 violation would
require the impossible total-ending effect of that very operation.
This is only a theorem CONDITIONAL on the source-proven
NoGuardianImpliesTotalErasure premise. It must never be passed off
as something established by "ALL IS" alone. -/
theorem original_x3_from_no_local_violator_without_absolute_end
    (w : IntrinsicAccount Event Action)
    (hSourceJoin : ∀ a, w.enacted a →
      ¬ w.originalX3Guardian a → RealizedAbsoluteEnder w a) :
    ∀ a, w.enacted a → w.originalX3Guardian a := by
  intro a hActual
  by_contra hNotX3
  exact (no_realized_absolute_ender w a)
    (hSourceJoin a hActual hNotX3)

/-- A small same-universe semantic diagnostic. All the operations
really belong to their own event-world. The intrinsic classification
can classify every enacted operation as a guardian; at the same time,
the independently chosen original-X3 status need not hold of every
operation. This DOES NOT purport to be a physical BCRD model or
to violate the full physical ontology. -/
def semanticDistinction : IntrinsicAccount Unit Bool where
  actual := fun _ => True
  enacted := fun _ => True
  occurrence := fun _ => ()
  enactedOccurs := by
    intro _ _
    trivial
  intrinsicGuardian := fun _ => True
  originalX3Guardian := fun a => a = true
  enderStrategy := fun a => a = false

theorem intrinsic_no_middle_can_hold_in_semantic_distinction :
    StrongSameTypeDichotomy semanticDistinction := by
  intro a _
  exact Or.inl trivial

theorem all_enacted_are_intrinsic_guardians_in_diagnostic :
    ∀ a, semanticDistinction.enacted a →
      semanticDistinction.intrinsicGuardian a :=
  all_is_eliminates_realized_ender_branch semanticDistinction
    intrinsic_no_middle_can_hold_in_semantic_distinction

/-- A single bad-original-X3 label cannot be removed merely by
re-describing "guardian" as "intrinsic member of the whole".
Only semantic reflection (or an X3-level partition) can do that. -/
theorem intrinsic_guardian_does_not_by_itself_reflect_full_x3 :
    ∃ a : Bool, semanticDistinction.enacted a ∧
      semanticDistinction.intrinsicGuardian a ∧
      ¬ semanticDistinction.originalX3Guardian a := by
  exact ⟨false, trivial, trivial, by decide⟩

/-- The historical strategy/attempt classification can also be
exhaustive for every realized operation, without meaning that
a realized absolute ender is possible. Thus using a strategy
label as if it were the impossible *absolute output type* is
precisely a semantic substitution. This is a diagnostic, NOT an
actual harmful agent in the BCRD universe. -/
theorem strategic_classification_does_not_instantiate_absolute_end :
    (∀ a, semanticDistinction.enacted a →
      semanticDistinction.originalX3Guardian a ∨
        semanticDistinction.enderStrategy a) ∧
    (∀ a, ¬ RealizedAbsoluteEnder semanticDistinction a) ∧
    (∃ a, semanticDistinction.enacted a ∧
      ¬ semanticDistinction.originalX3Guardian a) := by
  constructor
  · intro a _
    cases a <;> simp [semanticDistinction]
  constructor
  · intro a
    exact no_realized_absolute_ender semanticDistinction a
  · exact ⟨false, trivial, by decide⟩

#print axioms no_realized_absolute_ender
#print axioms all_is_eliminates_realized_ender_branch
#print axioms full_x3_from_ontological_collapse_and_reflection
#print axioms original_x3_direct_collapse
#print axioms original_x3_from_no_local_violator_without_absolute_end
#print axioms intrinsic_no_middle_can_hold_in_semantic_distinction
#print axioms intrinsic_guardian_does_not_by_itself_reflect_full_x3
#print axioms strategic_classification_does_not_instantiate_absolute_end

end PhysicalBridges.CathedralAllIsEnderTypeCollapse
