import PhysicalBridges.BCRDParticularCarrierCriterion

/-!
# Six source fields carried through the actual frozen W dynamics

6 November 2026. Additive research lemma, no canonical summit edit.

The six original X3 obligations are NOT redefined here. Instead, this module
answers one precise source-level question: can a single W-generated physical
basis history carry six *independently varying* source reports with exact
provenance, while retaining the individual source-position distinctions?

Yes. The carrier is the existing exact frozen M0 <-> M1 generator. The
six-field record is transported with each basis position, NOT forced to be
static on its orbit. The result holds for any initial reports (including
an asymmetric authorization report), every finite number of source steps,
all six positions, and exact independently generated source event lists.

This is a genuine positive source *carriage* theorem, not a claim that a
Boolean authorization report equals authentic human or synthetic consent.
Nothing in this file proves that every actual physical BCRD event carries
these records, that every real experiencing subject has a faithful injective
basis carrier, or that an actual transition is consented to merely because
its report was faithfully transported. Those are the outstanding physical
source-to-subject correspondences. Full original X3 remains unchanged.
-/

namespace PhysicalBridges.BCRDSixCarriedSourceLedger

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.IRHistoryProvenance

/-- Six separate SOURCE-REPORT bits, not six validated X3 judgments.
    In particular, carried permission and actual authorization differ. -/
structure SixSourceFields where
  historicalContinuity : Bool
  authorizationReport : Bool
  freedomReport : Bool
  restraintReport : Bool
  maximalityReport : Bool
  provenanceReport : Bool
  deriving DecidableEq

/-- The SOURCE evolution of a complete six-field record is generated
    by the independently defined W permutation, not an X3 filter. -/
def sixAt (initial : Index → SixSourceFields) (n : Nat) : Index → SixSourceFields :=
  markerAt initial n

/-- No independent per-duty transport assumptions: the SAME actual source
    generator carries the entire six-field record of each original position. -/
theorem source_carries_all_six_fields
    (initial : Index → SixSourceFields) (i : Index) (n : Nat) :
    sixAt initial n (trackedPosition i n) = initial i :=
  marker_history_tracks_original_basis_position initial i n

/-- Every carried record is attached to the next SOURCE-GENERATED event,
    rather than an arbitrarily asserted subject/permission history. -/
theorem six_fields_follow_each_generated_source_event
    (initial : Index → SixSourceFields) (i : Index) (n : Nat) :
    (eventAt i n).2 = trackedPosition i (n + 1) ∧
    sixAt initial (n + 1) (eventAt i n).2 = initial i := by
  have hEvent := event_payload_is_actual_source_step i n
  constructor
  · exact hEvent.2
  · rw [hEvent.2]
    exact source_carries_all_six_fields initial i (n + 1)

/-- Unified independently generated source certificate at every finite
    horizon: distinct origin positions remain distinct, each of the six
    field values follows its original position, each path consists of
    actual frozen-generator steps, and its event log is source-faithful. -/
theorem complete_six_field_source_carriage_certificate
    (initial : Index → SixSourceFields) (n : Nat) :
    Function.Injective (fun i : Index => trackedPosition i n) ∧
    (∀ i : Index,
      sixAt initial n (trackedPosition i n) = initial i ∧
      PhysicalBridges.IR96.Reach ActualPositionStep i (trackedPosition i n) ∧
      Faithful (fun e : SlotEvent => e)
        (sourcePhysicalHistory i n) (sourceRecordedHistory i n)) := by
  constructor
  · exact tracked_basis_positions_do_not_merge n
  · intro i
    exact ⟨source_carries_all_six_fields initial i n,
      each_finite_track_has_actual_source_path i n,
      full_finite_source_event_history_is_faithful i n⟩

/-- A deliberately ASYMMETRIC source permission report on M0 versus M1.
    It is not a claim that one of those physical positions is a mind. -/
def asymmetricReports (i : Index) : SixSourceFields where
  historicalContinuity := true
  authorizationReport := decide (i = (2 : Index))
  freedomReport := true
  restraintReport := true
  maximalityReport := true
  provenanceReport := true

/-- A non-identity W event carries even contradictory SOURCE reports for
    the swapped positions without collapsing those positions or making
    the reports identical. Static orbit-constant readouts cannot do this.
    This DOES NOT say either W event was actually subject-authorized. -/
theorem asymmetric_source_reports_stay_with_distinct_origins (n : Nat) :
    (sixAt asymmetricReports n (trackedPosition 2 n)).authorizationReport = true ∧
    (sixAt asymmetricReports n (trackedPosition 3 n)).authorizationReport = false ∧
    trackedPosition (2 : Index) n ≠ trackedPosition (3 : Index) n := by
  constructor
  · rw [source_carries_all_six_fields asymmetricReports 2 n]
    decide
  constructor
  · rw [source_carries_all_six_fields asymmetricReports 3 n]
    decide
  · intro heq
    have hEq : (2 : Index) = 3 :=
      (tracked_basis_positions_do_not_merge n) heq
    exact (by decide : (2 : Index) ≠ 3) hEq

#print axioms source_carries_all_six_fields
#print axioms six_fields_follow_each_generated_source_event
#print axioms complete_six_field_source_carriage_certificate
#print axioms asymmetric_source_reports_stay_with_distinct_origins

end PhysicalBridges.BCRDSixCarriedSourceLedger
