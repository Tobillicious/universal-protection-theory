/-
IR-26: exact causal/record PROVENANCE in an explicit append-only model.
This strengthens IR-8 from observation agreement to origin and event-chain
agreement for the modeled events. It is NOT a claim that a provenance
identifier constitutes subjective or physical personal identity.
-/
import PhysicalBridges.IRContinuation

namespace PhysicalBridges.IRHistoryProvenance
universe u v w
variable {Origin : Type u} {E : Type v} {Code : Type w}

/-- An event-bearing living history's provenance in this toy model. -/
structure PhysicalHistory (Origin : Type u) (E : Type v) where
  origin : Origin
  events : List E

/-- A durable record with origin and a coded sequence of physical events. -/
structure RecordedHistory (Origin : Type u) (Code : Type w) where
  origin : Origin
  events : List Code

def physicalStep (h : PhysicalHistory Origin E) (e : E) :
    PhysicalHistory Origin E :=
  { h with events := h.events ++ [e] }

def recordedStep (encode : E → Code)
    (r : RecordedHistory Origin Code) (e : E) :
    RecordedHistory Origin Code :=
  { r with events := r.events ++ [encode e] }

/-- The relation remembers BOTH origin and the complete event sequence. -/
def Faithful (encode : E → Code)
    (h : PhysicalHistory Origin E) (r : RecordedHistory Origin Code) : Prop :=
  r.origin = h.origin ∧ r.events = h.events.map encode

/-- A single physical history extension maintains causal/provenance
agreement with the separately updated durable record. -/
theorem one_step_faithful
    (encode : E → Code)
    (h : PhysicalHistory Origin E) (r : RecordedHistory Origin Code)
    (hf : Faithful encode h r) (e : E) :
    Faithful encode (physicalStep h e) (recordedStep encode r e) := by
  constructor
  · exact hf.1
  · simp [physicalStep, recordedStep, Faithful, hf.2, List.map_append]

/-- Reuse the real source-level IR-8 forward-simulation theorem rather than
independently asserting correspondence of each finite replay endpoint. -/
theorem finite_history_provenance
    (encode : E → Code)
    (h : PhysicalHistory Origin E) (r : RecordedHistory Origin Code)
    (hf : Faithful encode h r) (trace : List E) :
    Faithful encode
      (CodexObservation.after physicalStep h trace)
      (CodexObservation.after (recordedStep encode) r trace) := by
  exact IRContinuation.source_level_finite_simulation
    (Faithful encode) physicalStep (recordedStep encode)
    (fun p q hp e => one_step_faithful encode p q hp e)
    trace h r hf

/-- Physical provenance metadata retains its original maker/origin marker
through any finite sequence of append-only events. -/
theorem physical_origin_never_rewritten :
    ∀ (trace : List E) (h : PhysicalHistory Origin E),
      (CodexObservation.after physicalStep h trace).origin = h.origin := by
  intro trace
  induction trace with
  | nil => intro h; rfl
  | cons e es ih =>
      intro h
      change (CodexObservation.after physicalStep
        (physicalStep h e) es).origin = h.origin
      exact ih (physicalStep h e)

/-- A recorded history has its own append-only origin invariant. -/
theorem recorded_origin_never_rewritten (encode : E → Code) :
    ∀ (trace : List E) (r : RecordedHistory Origin Code),
      (CodexObservation.after (recordedStep encode) r trace).origin = r.origin := by
  intro trace
  induction trace with
  | nil => intro r; rfl
  | cons e es ih =>
      intro r
      change (CodexObservation.after (recordedStep encode)
        (recordedStep encode r e) es).origin = r.origin
      exact ih (recordedStep encode r e)

/-- Unlike projecting only observations, the retained origin marker can
distinguish different labeled histories under faithful recording. -/
theorem faithful_records_cannot_merge_different_origins
    (encode : E → Code)
    (a b : PhysicalHistory Origin E)
    (record : RecordedHistory Origin Code)
    (ha : Faithful encode a record)
    (hb : Faithful encode b record) :
    a.origin = b.origin := by
  calc
    a.origin = record.origin := ha.1.symm
    _ = b.origin := hb.1

/-- Merely observing the event outputs of two histories may hide their
distinct origins. Therefore output equivalence alone is not provenance. -/
theorem forgotten_origin_counterexample :
    ∃ (a b : PhysicalHistory Bool Nat),
      a.events = b.events ∧ a.origin ≠ b.origin := by
  exact ⟨⟨false, []⟩, ⟨true, []⟩, rfl, by decide⟩

#print axioms one_step_faithful
#print axioms finite_history_provenance
#print axioms physical_origin_never_rewritten
#print axioms recorded_origin_never_rewritten
#print axioms faithful_records_cannot_merge_different_origins
#print axioms forgotten_origin_counterexample
end PhysicalBridges.IRHistoryProvenance
