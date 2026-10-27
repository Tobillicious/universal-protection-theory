/-
IR-28: combine the unchanged original UPTController quorum
no-equivocation theorem with the IR-26 append-only history model.
No cryptographic signature or replica network is implemented here;
fault, authenticated-vote and common-prefix premises stay explicit.
-/
import ControllerFinality
import PhysicalBridges.IRHistoryProvenance

namespace PhysicalBridges.IRCertifiedProvenance
variable {Origin Code : Type}

/-- Same-origin, same-position quorum-certified records with sufficient
honest replica intersection have equal entire modeled event sequences. -/
theorem certified_provenance_sequences_agree
    (roster : List Nat) (fault leftVote rightVote : Nat → Bool) (f : Nat)
    (left right : IRHistoryProvenance.RecordedHistory Origin Code)
    (durable : Nat → List Code)
    (faultBound : UPTController.tally fault roster ≤ f)
    (rosterSize : roster.length = 3 * f + 1)
    (leftQuorum : 2 * f + 1 ≤ UPTController.tally leftVote roster)
    (rightQuorum : 2 * f + 1 ≤ UPTController.tally rightVote roster)
    (leftAuthentic : ∀ r, r ∈ roster → fault r = false →
      leftVote r = true →
      UPTController.Prefix left.events (durable r))
    (rightAuthentic : ∀ r, r ∈ roster → fault r = false →
      rightVote r = true →
      UPTController.Prefix right.events (durable r))
    (samePosition : left.events.length = right.events.length) :
    left.events = right.events := by
  exact UPTController.certificates_do_not_equivocate
    roster fault leftVote rightVote f left.events right.events durable
    faultBound rosterSize leftQuorum rightQuorum
    leftAuthentic rightAuthentic samePosition

/-- An event sequence certificate and matching named origin together rule
out record forks in this exact append-only record representation. -/
theorem certified_provenance_records_equal
    (roster : List Nat) (fault leftVote rightVote : Nat → Bool) (f : Nat)
    (left right : IRHistoryProvenance.RecordedHistory Origin Code)
    (durable : Nat → List Code)
    (faultBound : UPTController.tally fault roster ≤ f)
    (rosterSize : roster.length = 3 * f + 1)
    (leftQuorum : 2 * f + 1 ≤ UPTController.tally leftVote roster)
    (rightQuorum : 2 * f + 1 ≤ UPTController.tally rightVote roster)
    (leftAuthentic : ∀ r, r ∈ roster → fault r = false →
      leftVote r = true →
      UPTController.Prefix left.events (durable r))
    (rightAuthentic : ∀ r, r ∈ roster → fault r = false →
      rightVote r = true →
      UPTController.Prefix right.events (durable r))
    (samePosition : left.events.length = right.events.length)
    (sameOrigin : left.origin = right.origin) :
    left = right := by
  have hEvents := certified_provenance_sequences_agree
    roster fault leftVote rightVote f left right durable
    faultBound rosterSize leftQuorum rightQuorum
    leftAuthentic rightAuthentic samePosition
  cases left with
  | mk o1 e1 =>
      cases right with
      | mk o2 e2 =>
          cases sameOrigin
          cases hEvents
          rfl

/-- Canonical record agreement plus per-physical-history faithfulness
establishes equality of their *encoded* physical histories. It does not
prove equality of physical event sequences if the encoder loses data. -/
theorem certified_physical_history_encodings_agree
    {E : Type} (encode : E → Code)
    (roster : List Nat) (fault leftVote rightVote : Nat → Bool) (f : Nat)
    (leftPhysics rightPhysics : IRHistoryProvenance.PhysicalHistory Origin E)
    (left right : IRHistoryProvenance.RecordedHistory Origin Code)
    (durable : Nat → List Code)
    (hFaithLeft : IRHistoryProvenance.Faithful encode leftPhysics left)
    (hFaithRight : IRHistoryProvenance.Faithful encode rightPhysics right)
    (faultBound : UPTController.tally fault roster ≤ f)
    (rosterSize : roster.length = 3 * f + 1)
    (leftQuorum : 2 * f + 1 ≤ UPTController.tally leftVote roster)
    (rightQuorum : 2 * f + 1 ≤ UPTController.tally rightVote roster)
    (leftAuthentic : ∀ r, r ∈ roster → fault r = false →
      leftVote r = true →
      UPTController.Prefix left.events (durable r))
    (rightAuthentic : ∀ r, r ∈ roster → fault r = false →
      rightVote r = true →
      UPTController.Prefix right.events (durable r))
    (samePosition : left.events.length = right.events.length)
    (sameOrigin : left.origin = right.origin) :
    leftPhysics.origin = rightPhysics.origin ∧
      leftPhysics.events.map encode = rightPhysics.events.map encode := by
  have hRecord := certified_provenance_records_equal
    roster fault leftVote rightVote f left right durable
    faultBound rosterSize leftQuorum rightQuorum
    leftAuthentic rightAuthentic samePosition sameOrigin
  constructor
  · calc
      leftPhysics.origin = left.origin := hFaithLeft.1.symm
      _ = right.origin := by rw [hRecord]
      _ = rightPhysics.origin := hFaithRight.1
  · calc
      leftPhysics.events.map encode = left.events := hFaithLeft.2.symm
      _ = right.events := by rw [hRecord]
      _ = rightPhysics.events.map encode := hFaithRight.2

/-- Same encoded event stream does not imply same physical event stream
for a lossy encoder, even in an otherwise faithfully recorded model. -/
theorem noninjective_event_encoder_counterexample :
    ∃ a b : List Bool,
      a ≠ b ∧ a.map (fun _ : Bool => ()) =
        b.map (fun _ : Bool => ()) := by
  refine ⟨[false], [true], ?_, ?_⟩
  · decide
  · rfl

/-- An observation-based, correct event identity detector implies that
the event encoder is injective. Reuses the unchanged ContextualObservation
source theorem: correct detection is an EXPLICIT strong premise. -/
theorem event_encoding_injective_of_correct_detector
    {E : Type} (encode : E → Code) (monitor : Code → Code → Bool)
    (correct : ∀ a b, monitor (encode a) (encode b) = false ↔ a = b) :
    Function.Injective encode := by
  intro a b he
  exact CodexObservation.identity_detector_implies_injective
    encode monitor correct a b he

/-- Lift equality of encoded events to physical-event list equality, but
ONLY when every pair of physical event constructors is distinguishable. -/
theorem physical_event_lists_equal_of_correct_detector
    {E : Type} (encode : E → Code) (monitor : Code → Code → Bool)
    (correct : ∀ a b, monitor (encode a) (encode b) = false ↔ a = b)
    (left right : List E) (same : left.map encode = right.map encode) :
    left = right := by
  have injective := event_encoding_injective_of_correct_detector
    encode monitor correct
  induction left generalizing right with
  | nil =>
      cases right with
      | nil => rfl
      | cons e es => cases same
  | cons e es ih =>
      cases right with
      | nil => cases same
      | cons f fs =>
          simp only [List.map_cons, List.cons.injEq] at same
          obtain ⟨hHead, hTail⟩ := same
          have he : e = f := injective hHead
          have ht : es = fs := ih fs hTail
          cases he
          cases ht
          rfl

/-- If two independently written records are already certified identical,
and each record faithfully encodes its physical origin/event history,
a correct event-identity detector lifts equality to the entire MODELED
physical histories. This is not a proof of consciousness or real-world
subject continuity. -/
theorem full_modeled_history_equality_from_certified_record
    {E : Type} (encode : E → Code)
    (monitor : Code → Code → Bool)
    (correct : ∀ a b, monitor (encode a) (encode b) = false ↔ a = b)
    (left right : IRHistoryProvenance.PhysicalHistory Origin E)
    (leftRecord rightRecord : IRHistoryProvenance.RecordedHistory Origin Code)
    (hl : IRHistoryProvenance.Faithful encode left leftRecord)
    (hr : IRHistoryProvenance.Faithful encode right rightRecord)
    (hCertified : leftRecord = rightRecord) : left = right := by
  have hOrig : left.origin = right.origin := by
    calc
      left.origin = leftRecord.origin := hl.1.symm
      _ = rightRecord.origin := by rw [hCertified]
      _ = right.origin := hr.1
  have hEncoded : left.events.map encode = right.events.map encode := by
    calc
      left.events.map encode = leftRecord.events := hl.2.symm
      _ = rightRecord.events := by rw [hCertified]
      _ = right.events.map encode := hr.2
  have hEvents := physical_event_lists_equal_of_correct_detector
    encode monitor correct left.events right.events hEncoded
  cases left with
  | mk originLeft eventsLeft =>
    cases right with
    | mk originRight eventsRight =>
        cases hOrig
        cases hEvents
        rfl

#print axioms event_encoding_injective_of_correct_detector
#print axioms physical_event_lists_equal_of_correct_detector
#print axioms full_modeled_history_equality_from_certified_record

#print axioms certified_provenance_sequences_agree
#print axioms certified_provenance_records_equal
#print axioms certified_physical_history_encodings_agree
#print axioms noninjective_event_encoder_counterexample
end PhysicalBridges.IRCertifiedProvenance
