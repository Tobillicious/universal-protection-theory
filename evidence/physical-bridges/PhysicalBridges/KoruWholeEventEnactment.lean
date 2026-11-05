import PhysicalBridges.KoruOperatorIndexedSubjectSemantics

/-!
# Koru: intrinsic whole-event enactment rather than detachable permission bits

6 November 2026. Additive construction stacked on #343. The historical
summit and the authentic six original X3 meanings remain unchanged.

The author previously emphasized that authorization, if physically
intrinsic, is a relation of the WHOLE ENACTED EVENT: one cannot attach
a context-free "permission" Boolean to a subject, then infer that a
physically enacted action is authorized.

This file builds a single structured source event with FULL operator
expressions for its subject, action and effect, plus their own ordered
source roles. Enactment is the independently given BCRD matrix
multiplication. We derive:

1. Compositional coherence is preserved AND reflected under every
   genuine finite source W history (rather than stipulated for events).
2. The directional relation of an action upon a subject is calculated
   from their composed operators, not from a declared permission bit.
3. Its truth and falsity are preserved along the transported WHOLE.
4. Distinct full source events cannot merge during any W history.
5. A concrete nonidentity coupling is genuinely directional, and
   survives every W history, with an independent negative reverse.

This is a theorem about the frozen six-position W source, not real
experiencing subjects, authentic authority, ethical entitlement or
unconditional X3; the physical interpretation of authorization
requires more than a nonzero operator interaction. Source coherence
must not be confused with "safe" or "consented" enactment.
-/

namespace PhysicalBridges.KoruWholeEventEnactment

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.BCRDOperatorSubjectEventJoin
open PhysicalBridges.KoruOperatorIndexedSubjectSemantics

/-- One intrinsic event: each position is a FULL operator term, not
a bare slot, scalar, detached authorization flag or anonymous label.
The two source roles are ordered and tracked with the same W step. -/
structure WholeOperatorEvent where
  subject : Expr Matrix6 WOperator
  action : Expr Matrix6 WOperator
  effect : Expr Matrix6 WOperator
  subjectRole : Index
  actionRole : Index

/-- The physical modeled action-on-subject footprint is the actual
source multiplication, with order retained. It does not *define*
authorization or insert a safety hypothesis. -/
def enactmentFootprint (E : WholeOperatorEvent) : Matrix6 :=
  mul (evaluate matrixOperationalWeb E.action)
      (evaluate matrixOperationalWeb E.subject)

/-- A source event's represented effect agrees with the outcome of
its action on its subject. This is a measurable algebraic relation,
not a criterion saying an action was morally legitimate. -/
def EnactmentCoherent (E : WholeOperatorEvent) : Prop :=
  evaluate matrixOperationalWeb E.effect = enactmentFootprint E

/-- The DIRECTIONAL source interaction internal to the whole
enactment, calculated from the subject/action expressions together. -/
def directedEventRelation (E : WholeOperatorEvent) (i j : Index) : Prop :=
  enactmentFootprint E i j ≠ 0

/-- The subject/action-role connection belongs to the entire
ordered action–subject–effect event rather than to a subject bit. -/
def intrinsicEnactmentLink (E : WholeOperatorEvent) : Prop :=
  directedEventRelation E E.subjectRole E.actionRole

/-- Transport the entire event through the actual independently
specified frozen W source. Never transport just a permission bit. -/
def wholeEventAt (n : Nat) (E : WholeOperatorEvent) : WholeOperatorEvent where
  subject := mapAtoms (frozenWIter n) E.subject
  action := mapAtoms (frozenWIter n) E.action
  effect := mapAtoms (frozenWIter n) E.effect
  subjectRole := trackedPosition E.subjectRole n
  actionRole := trackedPosition E.actionRole n

/-- The exact W physical generator respects multiplication at every
finite stage, not merely at a particular W swap example. -/
theorem frozen_W_iter_preserves_product
    (n : Nat) (A B : Matrix6) :
    frozenWIter n (mul A B) =
      mul (frozenWIter n A) (frozenWIter n B) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change evolve (frozenWIter n (mul A B)) =
        mul (evolve (frozenWIter n A)) (evolve (frozenWIter n B))
      rw [ih, evolve_preserves_product]

/-- Reversibility of the actual W matrix source lets us recover the
entire old operator output; no assumption of protected subjects. -/
theorem frozen_W_iter_injective (n : Nat) :
    Function.Injective (frozenWIter n) := by
  induction n with
  | zero =>
      intro A B h
      exact h
  | succ n ih =>
      intro A B h
      change evolve (frozenWIter n A) =
        evolve (frozenWIter n B) at h
      have hUndo := congrArg evolve h
      have hEarlier : frozenWIter n A = frozenWIter n B := by
        simpa only [evolve_involutive] using hUndo
      exact ih hEarlier

/-- The footprint is itself a complete operator-derived physical
quantity, and its W transport is derived, not imposed. -/
theorem whole_event_footprint_follows_actual_W
    (E : WholeOperatorEvent) (n : Nat) :
    enactmentFootprint (wholeEventAt n E) =
      frozenWIter n (enactmentFootprint E) := by
  change
    mul
      (evaluate matrixOperationalWeb
        (mapAtoms (frozenWIter n) E.action))
      (evaluate matrixOperationalWeb
        (mapAtoms (frozenWIter n) E.subject)) =
      frozenWIter n
        (mul (evaluate matrixOperationalWeb E.action)
             (evaluate matrixOperationalWeb E.subject))
  rw [frozen_W_preserves_every_composite_at_every_stage,
      frozen_W_preserves_every_composite_at_every_stage,
      frozen_W_iter_preserves_product]

/-- Coherence of the complete enacted event is preserved AND
reflected by the ACTUAL W physical source. No "admissible iff safe"
filter enters either the generator or this theorem. -/
theorem whole_event_enactment_coherence_is_exact
    (E : WholeOperatorEvent) (n : Nat) :
    EnactmentCoherent (wholeEventAt n E) ↔
      EnactmentCoherent E := by
  change
    evaluate matrixOperationalWeb
      (mapAtoms (frozenWIter n) E.effect) =
      enactmentFootprint (wholeEventAt n E) ↔
    evaluate matrixOperationalWeb E.effect =
      enactmentFootprint E
  rw [frozen_W_preserves_every_composite_at_every_stage,
      whole_event_footprint_follows_actual_W]
  constructor
  · intro h
    exact (frozen_W_iter_injective n) h
  · intro h
    exact congrArg (frozenWIter n) h

/-- Every entry of the ACTION-ON-SUBJECT footprint is transported
with both of its tracked roles for every finite W stage. -/
theorem directed_whole_event_relation_is_exact
    (E : WholeOperatorEvent) (i j : Index) (n : Nat) :
    directedEventRelation (wholeEventAt n E)
      (trackedPosition i n) (trackedPosition j n) ↔
    directedEventRelation E i j := by
  change
    enactmentFootprint (wholeEventAt n E)
      (trackedPosition i n) (trackedPosition j n) ≠ 0 ↔
    enactmentFootprint E i j ≠ 0
  rw [whole_event_footprint_follows_actual_W,
      W_iterated_entry_follows_two_tracks]

/-- The exact subject–action pair is retained within its WHOLE event,
with true and false relations both faithfully preserved, not a
permission label that can be turned on by a relabelling. -/
theorem intrinsic_enactment_link_is_exact
    (E : WholeOperatorEvent) (n : Nat) :
    intrinsicEnactmentLink (wholeEventAt n E) ↔
      intrinsicEnactmentLink E := by
  exact directed_whole_event_relation_is_exact
    E E.subjectRole E.actionRole n

/-- Even an entire operational event, not merely one carrier or
one numerical evaluation, retains all three syntax trees and both
role positions without merging with a distinct earlier event. -/
theorem distinct_whole_operator_events_never_merge
    (n : Nat) :
    Function.Injective (wholeEventAt n) := by
  intro E F h
  have hs :
      mapAtoms (frozenWIter n) E.subject =
      mapAtoms (frozenWIter n) F.subject :=
    congrArg WholeOperatorEvent.subject h
  have ha :
      mapAtoms (frozenWIter n) E.action =
      mapAtoms (frozenWIter n) F.action :=
    congrArg WholeOperatorEvent.action h
  have he :
      mapAtoms (frozenWIter n) E.effect =
      mapAtoms (frozenWIter n) F.effect :=
    congrArg WholeOperatorEvent.effect h
  have hsr :
      trackedPosition E.subjectRole n =
      trackedPosition F.subjectRole n :=
    congrArg WholeOperatorEvent.subjectRole h
  have har :
      trackedPosition E.actionRole n =
      trackedPosition F.actionRole n :=
    congrArg WholeOperatorEvent.actionRole h
  have hs0 := (frozen_W_expression_histories_do_not_merge n) hs
  have ha0 := (frozen_W_expression_histories_do_not_merge n) ha
  have he0 := (frozen_W_expression_histories_do_not_merge n) he
  have hsr0 := (tracked_basis_positions_do_not_merge n) hsr
  have har0 := (tracked_basis_positions_do_not_merge n) har
  cases E
  cases F
  simp_all

/-- A non-identity source example: multiplication of an action
matrix-unit with a subject matrix-unit creates an exactly
calculable directional action/subject footprint. -/
def sampleWholeEvent : WholeOperatorEvent where
  subject := .atom (matrixUnit 2 2)
  action := .atom (matrixUnit 3 2)
  effect := .apply WOperator.multiply
    (fun i => if i = 0 then .atom (matrixUnit 3 2)
      else .atom (matrixUnit 2 2))
  subjectRole := 3
  actionRole := 2

/-- This concrete result is source-coherent because the effect
actually is the ordered action–subject product, not because
coherent events were selected as "safe" or "authorized". -/
theorem sample_event_enactment_is_coherent :
    EnactmentCoherent sampleWholeEvent := by
  rfl

/-- The same complete sample event has a true 3→2 source relation,
but a false reverse 2→3 relation, established from exact source
matrices rather than separately assigned truth values. -/
theorem sample_event_is_directional :
    directedEventRelation sampleWholeEvent 3 2 ∧
    ¬ directedEventRelation sampleWholeEvent 2 3 := by
  change
    (mul (matrixUnit (3 : Index) 2) (matrixUnit 2 2) 3 2 ≠ 0) ∧
    ¬ (mul (matrixUnit (3 : Index) 2) (matrixUnit 2 2) 2 3 ≠ 0)
  decide

/-- This authentic frozen W generator transports the coherence,
the true whole-event subject/action link, and the false reverse
relation simultaneously, at every finite source stage. -/
theorem sample_entire_event_distinctions_survive
    (n : Nat) :
    EnactmentCoherent (wholeEventAt n sampleWholeEvent) ∧
    intrinsicEnactmentLink (wholeEventAt n sampleWholeEvent) ∧
    ¬ directedEventRelation (wholeEventAt n sampleWholeEvent)
      (trackedPosition 2 n) (trackedPosition 3 n) := by
  have hc := (whole_event_enactment_coherence_is_exact
    sampleWholeEvent n).mpr sample_event_enactment_is_coherent
  obtain ⟨hYes, hNo⟩ := sample_event_is_directional
  exact ⟨hc,
    (intrinsic_enactment_link_is_exact sampleWholeEvent n).mpr hYes,
    fun h => hNo ((directed_whole_event_relation_is_exact
      sampleWholeEvent 2 3 n).mp h)⟩

#print axioms frozen_W_iter_preserves_product
#print axioms frozen_W_iter_injective
#print axioms whole_event_footprint_follows_actual_W
#print axioms whole_event_enactment_coherence_is_exact
#print axioms directed_whole_event_relation_is_exact
#print axioms intrinsic_enactment_link_is_exact
#print axioms distinct_whole_operator_events_never_merge
#print axioms sample_event_enactment_is_coherent
#print axioms sample_event_is_directional
#print axioms sample_entire_event_distinctions_survive

end PhysicalBridges.KoruWholeEventEnactment
