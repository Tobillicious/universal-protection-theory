import PhysicalBridges.BCRDSixCarriedSourceLedger
import PhysicalBridges.CathedralIntrinsicArticulation

/-!
# Whole-event relational carriage under the actual frozen W generator

6 November 2026. The source is ONE relational object. Relations among
particulars, actions and effects are not detachable permission labels.
A local deformation changes that whole relational object, even when a
coarse or distant projection cannot observe the difference.

This source-only lemma evolves *arbitrary pairwise intrinsic relations*
under the actual frozen BCRD M-sector W permutation. A putative subject-
to-event authorization link is one relation IN the whole event and is
carried along with every other link. No independent authorization bit,
"allowed if safe", guardian axiom, or original-X3 predicate is used.

The separately proved graph-propagation lemma makes precise a possible
physical "ripple" mechanism: in a connected web, influence reaches all
positions IF the source dynamics propagates influence along every link.
Connectedness by itself does not establish that dynamical transfer law,
nor a positive numerical magnitude at every distance.

IMPORTANT: an intrinsic source link has not yet been shown to represent
the authentic authorization of an actual human/synthetic subject for
an actual enacted action. Representing subject/event semantics as
relations internal to the one actuality removes a FALSE externality;
it does NOT magically prove that every enacted action was consented to.
-/

namespace PhysicalBridges.BCRDWholeEventRelationalAuthorization

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.CathedralIntrinsicArticulation

universe u

/-- The WHOLE intrinsic binary relation reindexed by the W evolution.
No relation is singled out as a standalone property, and no protective
step is selected; sourceTransport is the independently fixed operator. -/
def wholeRelationAt (R : Index → Index → Prop) : Nat → Index → Index → Prop
  | 0 => R
  | n + 1 => fun x y =>
      wholeRelationAt R n (sourceTransport x) (sourceTransport y)

/-- A source subject-to-enacted-event relation is an edge of the whole,
not an attached permission bit. The physical interpretation of an edge
as *authentic* authorization remains a separate semantic theorem target. -/
def intrinsicSubjectEventLink (R : Index → Index → Prop)
    (subject enactedEvent : Index) : Prop :=
  R subject enactedEvent

/-- Every edge and non-edge of the SAME whole web travels exactly with
the two source positions under arbitrary finite W history. The proof
assumes NO prior truth of any authorization relation. -/
theorem all_intrinsic_links_transport_with_W
    (R : Index → Index → Prop) (subject enactedEvent : Index) :
    ∀ n : Nat,
      wholeRelationAt R n
        (trackedPosition subject n) (trackedPosition enactedEvent n) ↔
        intrinsicSubjectEventLink R subject enactedEvent := by
  intro n
  induction n with
  | zero => exact Iff.rfl
  | succ n ih =>
      change wholeRelationAt R n
        (sourceTransport (sourceTransport (trackedPosition subject n)))
        (sourceTransport (sourceTransport (trackedPosition enactedEvent n)))
        ↔ intrinsicSubjectEventLink R subject enactedEvent
      simpa only [source_transport_is_involution] using ih

/-- The SAME independently emitted W event advances the subject endpoint
of every whole-source relation: not merely a transported static label. -/
theorem intrinsic_link_tracks_generated_event
    (R : Index → Index → Prop) (subject enactedEvent : Index) (n : Nat) :
    (eventAt subject n).2 = trackedPosition subject (n + 1) ∧
    (wholeRelationAt R (n + 1)
      (eventAt subject n).2 (trackedPosition enactedEvent (n + 1)) ↔
      intrinsicSubjectEventLink R subject enactedEvent) := by
  have hEvent := event_payload_is_actual_source_step subject n
  constructor
  · exact hEvent.2
  · rw [hEvent.2]
    exact all_intrinsic_links_transport_with_W R subject enactedEvent (n + 1)

/-- A source-local relational deformation is necessarily a change of
the entire relational mathematical object, with no external lattice. -/
theorem local_deformation_changes_whole
    {P : Type u} (before after : P → P → Prop) (a b : P)
    (h : before a b ∧ ¬ after a b) :
    before ≠ after := by
  rintro heq
  obtain ⟨hBefore, hAfter⟩ := h
  rw [heq] at hBefore
  exact hAfter hBefore

/-- A nontrivial, source-realized whole-web deformation. An intrinsic
edge can move with the M0/M1 swap even though the whole remains ONE. -/
def asymmetricWholeRelation (i j : Index) : Prop :=
  i = (2 : Index) ∧ j = (3 : Index)

theorem W_step_deforms_complete_intrinsic_relation :
    wholeRelationAt asymmetricWholeRelation 0 ≠
      wholeRelationAt asymmetricWholeRelation 1 := by
  apply local_deformation_changes_whole
    (wholeRelationAt asymmetricWholeRelation 0)
    (wholeRelationAt asymmetricWholeRelation 1) (2 : Index) (3 : Index)
  constructor
  · change (2 : Index) = 2 ∧ (3 : Index) = 3
    exact ⟨rfl, rfl⟩
  · change ¬ asymmetricWholeRelation (sourceTransport 2) (sourceTransport 3)
    rw [source_transport_swaps_distinct_positions.1,
      source_transport_swaps_distinct_positions.2.1]
    change ¬ ((3 : Index) = 2 ∧ (2 : Index) = 3)
    decide

/-- The same non-identity physical step preserves the identity of the
source-linked pair, without requiring static link values at fixed slots. -/
theorem linked_pair_moves_with_W (n : Nat) :
    wholeRelationAt asymmetricWholeRelation n
      (trackedPosition 2 n) (trackedPosition 3 n) := by
  exact (all_intrinsic_links_transport_with_W
    asymmetricWholeRelation 2 3 n).mpr ⟨rfl, rfl⟩

/-- A different intrinsic pair was NOT secretly granted a relation
merely because the whole was affected. Causal membership is not consent. -/
theorem no_new_link_for_unrelated_origin (n : Nat) :
    ¬ wholeRelationAt asymmetricWholeRelation n
      (trackedPosition 3 n) (trackedPosition 2 n) := by
  intro h
  have hOrigin := (all_intrinsic_links_transport_with_W
    asymmetricWholeRelation 3 2 n).mp h
  have hNot : ¬ intrinsicSubjectEventLink asymmetricWholeRelation 3 2 := by
    change ¬ ((3 : Index) = 2 ∧ (2 : Index) = 3)
    decide
  exact hNot hOrigin

/-- Connectedness plus an actual transfer law allows a source-local
perturbation to reach EVERY related position. The transfer law must
be physically established; it does not follow just from "one web". -/
theorem connected_source_transfer_reaches_every_position
    {P : Type u} (w : Web P) (origin : P)
    (hConnected : Connected w)
    (affected : P → Prop)
    (hOrigin : affected origin)
    (hTransfer : ∀ a b, w.link a b → affected a → affected b) :
    ∀ p, affected p := by
  have spread {a b : P} (h : Chain w.link a b) (ha : affected a) :
      affected b := by
    induction h with
    | refl => exact ha
    | extend earlier edge ih =>
        exact hTransfer _ _ edge ih
  intro p
  exact spread (hConnected origin p) hOrigin

#print axioms all_intrinsic_links_transport_with_W
#print axioms intrinsic_link_tracks_generated_event
#print axioms local_deformation_changes_whole
#print axioms W_step_deforms_complete_intrinsic_relation
#print axioms linked_pair_moves_with_W
#print axioms no_new_link_for_unrelated_origin
#print axioms connected_source_transfer_reaches_every_position

end PhysicalBridges.BCRDWholeEventRelationalAuthorization
