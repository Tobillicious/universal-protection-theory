import PhysicalBridges.BCRDParticularCarrierCriterion
import PhysicalBridges.IRHistoryProvenance

/-!
# PR B phase 7 — independently validate source-event logs

Inherited IR26 Faithful requires physical and recorded event lists
to match; it does NOT verify nominated events obey actual frozen
BCRD dynamics. This audit checks source admissibility independently.

Positive: every generated frozen history passes the source validator
and IR26 agreement. Hostile: two records can agree on an impossible
M0-to-R0 event, satisfying IR26 but failing source validation.

Admissible source logs still are NOT independent hardware evidence
that an event occurred, nor subject continuity, authentic consent,
or an original-X3 component.
-/

namespace PhysicalBridges.BCRDValidatedCausalLog

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.IRHistoryProvenance

/-- Arbitrary submitted event lists are valid only if each step
follows the exact frozen source operator's position mapping. -/
inductive VerifiedSourcePath : Index → List SlotEvent → Index → Prop where
  | empty (i : Index) : VerifiedSourcePath i [] i
  | next {i j k : Index} {tail : List SlotEvent}
      (sourceEdge : ActualPositionStep i j)
      (later : VerifiedSourcePath j tail k) :
      VerifiedSourcePath i ((i,j)::tail) k

theorem verified_path_append_actual
    {start middle finish : Index} {events : List SlotEvent}
    (h : VerifiedSourcePath start events middle)
    (hEdge : ActualPositionStep middle finish) :
    VerifiedSourcePath start (events ++ [(middle, finish)]) finish := by
  induction h with
  | empty i => exact VerifiedSourcePath.next hEdge (VerifiedSourcePath.empty finish)
  | next he rest ih => exact VerifiedSourcePath.next he ih

/-- The generator's exact event history passes the INDEPENDENT
source verifier, without assuming IR26 implies validity. -/
theorem generated_history_passes_source_path_verifier (i : Index) :
    ∀ n : Nat,
      VerifiedSourcePath i (sourcePhysicalHistory i n).events
        (trackedPosition i n) := by
  intro n
  induction n with
  | zero => exact VerifiedSourcePath.empty i
  | succ n ih =>
      have hStep : ActualPositionStep
          (trackedPosition i n) (trackedPosition i (n+1)) := rfl
      simpa only [sourcePhysicalHistory, physicalStep, eventAt,
        trackedPosition] using verified_path_append_actual ih hStep

theorem reach_transitive {i j k : Index}
    (hFirst : PhysicalBridges.IR96.Reach ActualPositionStep i j)
    (hLater : PhysicalBridges.IR96.Reach ActualPositionStep j k) :
    PhysicalBridges.IR96.Reach ActualPositionStep i k := by
  induction hLater with
  | refl => exact hFirst
  | tail previous edge ih => exact PhysicalBridges.IR96.Reach.tail ih edge

/-- Every submitted validated finite log implies actual-source
REACHABILITY (mathematical possibility, not observed execution). -/
theorem verified_source_path_implies_actual_source_reach
    {i j : Index} {events : List SlotEvent}
    (h : VerifiedSourcePath i events j) :
    PhysicalBridges.IR96.Reach ActualPositionStep i j := by
  induction h with
  | empty i => exact PhysicalBridges.IR96.Reach.refl i
  | next hEdge later ih =>
      exact reach_transitive
        (PhysicalBridges.IR96.Reach.tail
          (PhysicalBridges.IR96.Reach.refl _) hEdge) ih

theorem each_actual_source_edge_preserves_site
    (i j : Index) (h : ActualPositionStep i j) :
    i.val / 2 = j.val / 2 := by
  have hSite : ∀ x : Index,
      x.val / 2 = (sourceTransport x).val / 2 := by
    unfold sourceTransport
    decide
  unfold ActualPositionStep at h
  rw [h]
  exact hSite i

theorem all_source_reach_preserves_site
    {i j : Index}
    (h : PhysicalBridges.IR96.Reach ActualPositionStep i j) :
    i.val / 2 = j.val / 2 := by
  induction h with
  | refl => rfl
  | tail previous edge ih =>
      exact ih.trans (each_actual_source_edge_preserves_site _ _ edge)

/-- No M0-to-R0 path at any finite horizon under this generator. -/
theorem no_finite_source_path_M0_to_R0 :
    ¬ PhysicalBridges.IR96.Reach ActualPositionStep 2 4 := by
  intro h
  have hSite := all_source_reach_preserves_site h
  have hDiff : (2 : Index).val / 2 ≠ (4 : Index).val / 2 := by decide
  exact hDiff hSite

theorem forged_M0_to_R0_event_log_rejected :
    ¬ VerifiedSourcePath 2 [(2,4)] 4 := by
  intro h
  exact no_finite_source_path_M0_to_R0
    (verified_source_path_implies_actual_source_reach h)

/-- Nominated source and recorded event histories may match
perfectly while both contain a source-impossible event. -/
def forgedPhysicalHistory : PhysicalHistory Index SlotEvent :=
  ⟨2, [(2,4)]⟩

def forgedRecordedHistory : RecordedHistory Index SlotEvent :=
  ⟨2, [(2,4)]⟩

theorem IR26_fidelity_alone_accepts_forged_source_log :
    Faithful (fun e : SlotEvent => e)
      forgedPhysicalHistory forgedRecordedHistory :=
  ⟨rfl, rfl⟩

theorem IR26_faithful_forgery_rejected_by_source_verifier :
    ¬ VerifiedSourcePath forgedPhysicalHistory.origin
      forgedPhysicalHistory.events 4 :=
  forged_M0_to_R0_event_log_rejected

/-- Actual generator histories meet BOTH independent source-
admissibility and copied-event fidelity gates. They are still
internally generated, not independently sensor-authenticated. -/
theorem all_generated_finite_histories_pass_both_gates
    (i : Index) (n : Nat) :
    VerifiedSourcePath i (sourcePhysicalHistory i n).events
      (trackedPosition i n) ∧
    Faithful (fun e : SlotEvent => e)
      (sourcePhysicalHistory i n) (sourceRecordedHistory i n) :=
  ⟨generated_history_passes_source_path_verifier i n,
    full_finite_source_event_history_is_faithful i n⟩

#print axioms generated_history_passes_source_path_verifier
#print axioms verified_source_path_implies_actual_source_reach
#print axioms all_source_reach_preserves_site
#print axioms forged_M0_to_R0_event_log_rejected
#print axioms IR26_fidelity_alone_accepts_forged_source_log
#print axioms IR26_faithful_forgery_rejected_by_source_verifier
#print axioms all_generated_finite_histories_pass_both_gates

end PhysicalBridges.BCRDValidatedCausalLog
