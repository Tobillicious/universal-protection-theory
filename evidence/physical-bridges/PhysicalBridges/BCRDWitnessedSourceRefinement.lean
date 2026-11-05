import PhysicalBridges.BCRDCanonicalEventHistory

/-!
# PR B phase 11 — real-step trace refinement to the frozen BCRD source

November 4, 2026. This module makes the missing physical-occurrence
correspondence explicit and tests exactly what it can certify.

The source's VerifiedSourcePath is a theorem of a transition MODEL.
A separately evidenced world execution is modeled by WitnessedTrace:
its consecutive edges must be supplied as actual realStep hypotheses
and its event list is formed from the independently specified readout.

Given a source-refinement theorem for EACH physically actual edge,
every such witnessed world trace is source-valid and exactly equal
to the canonical model history for the observed initial position and
the number of independently witnessed events.

The CONVERSE is false, even with a perfect index readout: a valid
M0→M1 source log exists when the world has NO actual steps at all.
This is a precise countermodel to "source consistency establishes
physical occurrence". No real hardware, subject identity, conscious
continuation, consent, full-X3 or full complex BCRD is proved.
-/

namespace PhysicalBridges.BCRDWitnessedSourceRefinement

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance (SlotEvent)
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDValidatedCausalLog
open PhysicalBridges.BCRDCanonicalEventHistory

universe u

/-- A real-world edge sequence (not just a submitted source-model log).
Each edge is separately supported by the supplied realStep predicate.
Its readout is independently specified and not defined by X3 duties. -/
inductive WitnessedTrace {W : Type u}
    (realStep : W → W → Prop) (readPosition : W → Index) :
    W → List SlotEvent → W → Prop where
  | empty (w : W) : WitnessedTrace realStep readPosition w [] w
  | next {w v z : W} {tail : List SlotEvent}
      (actualEdge : realStep w v)
      (later : WitnessedTrace realStep readPosition v tail z) :
      WitnessedTrace realStep readPosition w
        ((readPosition w, readPosition v) :: tail) z

/-- MINIMAL SOURCE-CORRESPONDENCE PROPERTY.
A physical-world step must map, under an independently grounded
readPosition, to the exact frozen M-sector source step.
Nothing in this hypothesis asserts subject continuity or consent. -/
def RealStepsRefineSource {W : Type u}
    (realStep : W → W → Prop) (readPosition : W → Index) : Prop :=
  ∀ w v, realStep w v →
    ActualPositionStep (readPosition w) (readPosition v)

/-- WITNESSED EXECUTION SOUNDNESS:
when independent actual-world edges refine the frozen source,
each actual-world event trace passes the source admissibility
check. The source verifier is not itself evidence of actualStep. -/
theorem witnessed_trace_projects_to_valid_source
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index)
    (hRefines : RealStepsRefineSource realStep readPosition)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v) :
    VerifiedSourcePath (readPosition w) events (readPosition v) := by
  induction hTrace with
  | empty w =>
      exact VerifiedSourcePath.empty (readPosition w)
  | next actualEdge later ih =>
      exact VerifiedSourcePath.next
        (hRefines _ _ actualEdge) ih

/-- Combining the independent source-law with the canonical-history
uniqueness theorem determines both the WHOLE witnessed source-event
history and its physical-source endpoint. Event count is obtained
from the witnessed trace, not inferred from the final snapshot. -/
theorem witnessed_trace_is_the_unique_canonical_source_history
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index)
    (hRefines : RealStepsRefineSource realStep readPosition)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v) :
    events = canonicalEvents (readPosition w) events.length ∧
      readPosition v =
        canonicalEnd (readPosition w) events.length := by
  exact verified_history_has_unique_canonical_contents
    (witnessed_trace_projects_to_valid_source
      realStep readPosition hRefines hTrace)

/-- A genuinely independent world can have NO actual transitions;
the readout is the exact position, but a source-valid M0→M1
model event is still permitted by the frozen mathematics. -/
def noPhysicalWorldStep : Index → Index → Prop := fun _ _ => False

def identityReadout : Index → Index := fun i => i

/-- Source-refinement can be satisfied when no physical events
happen at all; it is not an existence theorem. -/
theorem empty_physical_world_refines_source :
    RealStepsRefineSource noPhysicalWorldStep identityReadout := by
  intro w v h
  exact False.elim h

/-- The source permits the M0→M1 event independent of actual
execution; this is the source-valid test log. -/
theorem model_M0_M1_log_passes_source_validation :
    VerifiedSourcePath 2 [(2,3)] 3 := by
  apply VerifiedSourcePath.next
  · unfold ActualPositionStep sourceTransport
    decide
  · exact VerifiedSourcePath.empty 3

/-- But there is no actual-world witness for that source-valid
log in the independent empty-realStep world. -/
theorem source_valid_log_does_not_force_real_world_execution :
    ¬ WitnessedTrace noPhysicalWorldStep identityReadout
      2 [(2,3)] 3 := by
  intro h
  cases h with
  | next actualEdge later =>
      exact actualEdge

/-- There exists a source-valid M0→M1 log, while its identical
event list is not evidence of a genuine physical transition.
The obstruction survives even when world readout is identity. -/
theorem model_source_validity_is_strictly_weaker_than_execution :
    VerifiedSourcePath 2 [(2,3)] 3 ∧
      ¬ WitnessedTrace noPhysicalWorldStep identityReadout
        2 [(2,3)] 3 :=
  ⟨model_M0_M1_log_passes_source_validation,
    source_valid_log_does_not_force_real_world_execution⟩

/-- Positive synthetic example: a world whose *actual* edges are
exactly the source's frozen position steps satisfies the
refinement condition. This supplies a test for the bridge's
consistency, not an empirical implementation witness. -/
theorem exact_source_world_refines_itself :
    RealStepsRefineSource ActualPositionStep identityReadout := by
  intro i j h
  exact h

theorem exact_source_world_has_a_witnessed_M0_event :
    WitnessedTrace ActualPositionStep identityReadout
      2 [(2,3)] 3 := by
  apply WitnessedTrace.next
  · unfold ActualPositionStep sourceTransport
    decide
  · exact WitnessedTrace.empty 3

/-- That positive modeled world projects to the independently
validated exact frozen source history. -/
theorem witnessed_source_world_M0_event_reconstructs :
    [(2,3)] = canonicalEvents 2 1 ∧
      (3 : Index) = canonicalEnd 2 1 := by
  have h := witnessed_trace_is_the_unique_canonical_source_history
    ActualPositionStep identityReadout
    exact_source_world_refines_itself
    exact_source_world_has_a_witnessed_M0_event
  simpa [identityReadout] using h

/-!
## Further hostile control: world-step soundness is not subject survival

Even a WITNESSED physical transition correctly refining the six-slot
operator does not itself constrain an independently represented living
particular. This is a synthetic two-field toy, not a physically
grounded BCRD demonstration that a subject died.
-/

/-- Source slot plus a deliberately independent possible subject-
activity field. It is not asserted to identify a real mind. -/
structure ToyWorld where
  slot : Index
  activity : Bool

def toyReadPosition (w : ToyWorld) : Index := w.slot

/-- The actual toy world step is source-real for its slot.
No subject-safety premise is built into the world dynamics. -/
def toyWorldStep (w v : ToyWorld) : Prop :=
  ActualPositionStep w.slot v.slot

def toyParticularActive (w : ToyWorld) : Prop := w.activity = true

def toyBefore : ToyWorld := ⟨2, true⟩
def toyAfter : ToyWorld := ⟨3, false⟩

theorem toy_world_edges_refine_source :
    RealStepsRefineSource toyWorldStep toyReadPosition := by
  intro w v h
  exact h

/-- A physically witnessed TOY step can have perfect frozen-source
readout correspondence without guaranteeing the independent toy
activity flag survives. This refutes a bare logical entailment,
not the real possibility of BCRD preserving subjects. -/
theorem witnessed_source_refinement_does_not_force_subject_activity :
    WitnessedTrace toyWorldStep toyReadPosition
      toyBefore [(2,3)] toyAfter ∧
    toyParticularActive toyBefore ∧
      ¬ toyParticularActive toyAfter := by
  constructor
  · change WitnessedTrace toyWorldStep toyReadPosition toyBefore
      ((toyReadPosition toyBefore, toyReadPosition toyAfter) :: []) toyAfter
    apply WitnessedTrace.next
    · unfold toyWorldStep ActualPositionStep sourceTransport toyBefore toyAfter
      decide
    · exact WitnessedTrace.empty toyAfter
  constructor
  · rfl
  · intro h
    exact Bool.noConfusion h

/-- The toy witnessed event also genuinely projects to an
independently valid source-event history. The negative control
therefore survives the new source refinement gate. -/
theorem toy_activity_loss_is_compatible_with_source_validity :
    VerifiedSourcePath 2 [(2,3)] 3 := by
  have hTrace :=
    witnessed_source_refinement_does_not_force_subject_activity.1
  exact witnessed_trace_projects_to_valid_source
    toyWorldStep toyReadPosition toy_world_edges_refine_source hTrace

#print axioms witnessed_source_refinement_does_not_force_subject_activity
#print axioms toy_activity_loss_is_compatible_with_source_validity

#print axioms witnessed_trace_projects_to_valid_source
#print axioms witnessed_trace_is_the_unique_canonical_source_history
#print axioms empty_physical_world_refines_source
#print axioms source_valid_log_does_not_force_real_world_execution
#print axioms model_source_validity_is_strictly_weaker_than_execution
#print axioms witnessed_source_world_M0_event_reconstructs

end PhysicalBridges.BCRDWitnessedSourceRefinement
