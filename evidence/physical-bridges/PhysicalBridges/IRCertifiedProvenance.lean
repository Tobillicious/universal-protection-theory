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

#print axioms certified_provenance_sequences_agree
#print axioms certified_provenance_records_equal
#print axioms certified_physical_history_encodings_agree
#print axioms noninjective_event_encoder_counterexample
end PhysicalBridges.IRCertifiedProvenance
