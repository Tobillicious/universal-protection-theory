import PhysicalBridges.BCRDComplexM3dStage
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 19 — within-event complex carrier nonmerging and actual-subject gap

2026-11-04. B.1 source/history correspondence frontier.

The prior physical-source fixture followed exact complex stages:
  W, C_LM, U_MR6, C_LM
on the six-dimensional algebraic complex source. Here we test ALL SIX
initial basis candidates at EACH stage boundary, instead of silently
reusing a W-only position tracker that fails on coherent superpositions.

The first theorem is a genuine finite SOURCE result, using source-pinned
operator matrices and exact rational-surd arithmetic. Six distinct
initial basis vectors remain distinguishable by at least one complex
amplitude at each modeled stage boundary. Consequently ANY independently
justified injection of candidate labels into these six initial slots
remains injective in their full complex state signatures. The
injection, however, is not supplied by the source.

The second theorem is an independent representational test: two toy
interpretations can have the IDENTICAL COMPLETE complex stage history
and disagree about continuity of an experiencing particular. Therefore
no decoder from *only* this modeled finite quantum history can decide
authentic subject-continuity on that unrestricted interpretation domain.
A proposed external observation must distinguish the two readings.

The status bit is expressly an unconstrained toy interpretation, NOT
a physical experiment, a coherent physical theory of consciousness, a
real harm event, or proof that no richer BCRD law could justify identity.

The source W is a SEPARATE endogenous update; concatenating it with the
literal C_LM · U_MR6 · C_LM compound is an explicitly CONSTRUCTED stage
sequence, not a claim about actual observed BCRD occurrence.

B.1 physical-subject correspondence remains open. Authorization, freedom,
restraint, maximality, provenance and original-X3 stay independently open.
-/

namespace PhysicalBridges.BCRDComplexCarrierAudit

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage

/-- Five exact snapshot boundaries for the constructed source sequence,
including the initial state and all four subsequent complex stages. -/
inductive SourceMoment where
  | start
  | afterW
  | afterLM
  | afterMR
  | afterFinalLM
deriving DecidableEq, Repr

def stagesAt : SourceMoment → List SourceStage
  | .start => []
  | .afterW => [.endogenousW]
  | .afterLM => [.endogenousW, .enabledLM]
  | .afterMR => [.endogenousW, .enabledLM, .middleRight]
  | .afterFinalLM => [.endogenousW, .enabledLM, .middleRight, .enabledLM]

/-- Full algebraic complex amplitude vector, never a collapsed
source basis position or a free semantic subject label. -/
def snapshot (moment : SourceMoment) (origin : Index) : State :=
  runStages (stagesAt moment) (basis origin)

/-- Two source candidates are distinguishable if a complex amplitude
differs at SOME basis coordinate; this is extensional state inequality
with a concrete finite-coordinate witness. -/
def SeparableAt (moment : SourceMoment) (i j : Index) : Prop :=
  ∃ coordinate : Index, snapshot moment i coordinate ≠ snapshot moment j coordinate

/-- Source-derived finite result for ALL source basis candidates and
ALL five stage boundaries. Every pair of distinct initial source
basis positions retains a distinguishable full complex state.
Exactly source-defined matrices, no subject semantics or floating
point involved. -/
/-- Concrete SOURCE-DERIVED distinguishing readout coordinate for
each initial basis candidate at every exact stage. Every origin has a
coordinate whose amplitude differs from that of every other origin.
The numbers below are checked, not relied on as axioms. -/
def witnessingCoordinate : SourceMoment → Index → Index
  | .start, i => i
  | .afterW, i => permutation i
  | .afterLM, i =>
      if i = 2 then 1 else if i = 3 then 2 else i
  | .afterMR, i =>
      if i = 2 then 1 else if i = 3 then 2
      else if i = 4 then 2 else if i = 5 then 3 else i
  | .afterFinalLM, i =>
      if i = 2 then 1 else if i = 3 then 2
      else if i = 4 then 2 else if i = 5 then 1 else i

/-- Kernel checks for each stage verify the explicit source
readout design, without existential decision procedures. -/
theorem designated_coordinate_separates_every_source_origin
    (moment : SourceMoment) :
    ∀ a b : Index, a ≠ b →
      snapshot moment a (witnessingCoordinate moment a) ≠
        snapshot moment b (witnessingCoordinate moment a) := by
  cases moment
  all_goals decide +kernel

theorem all_six_basis_candidates_separate_through_every_stage
    (moment : SourceMoment) (i j : Index) (hDistinct : i ≠ j) :
    SeparableAt moment i j := by
  exact ⟨witnessingCoordinate moment i,
    designated_coordinate_separates_every_source_origin moment i j hDistinct⟩

/-- Any INDEPENDENTLY SUPPLIED injective mapping of candidate
particular labels to initial basis slots remains injective in
source-state AMPLITUDE readouts at every complex stage. This
preserves a candidate physical signature, not a lived subject. -/
theorem complex_stage_carriers_remain_injective
    {P : Type} (sourceSlot : P → Index)
    (hInitiallyDistinct : Function.Injective sourceSlot)
    (moment : SourceMoment) :
    Function.Injective (fun p : P => snapshot moment (sourceSlot p)) := by
  intro p q hSnapshots
  by_cases hpq : p = q
  · exact hpq
  · have hSlots : sourceSlot p ≠ sourceSlot q := by
      intro heq
      exact hpq (hInitiallyDistinct heq)
    obtain ⟨coord, hDiff⟩ :=
      all_six_basis_candidates_separate_through_every_stage
        moment (sourceSlot p) (sourceSlot q) hSlots
    exact False.elim (hDiff (congrFun hSnapshots coord))

/-- Complete five-snapshot complex MODEL trajectory of an initial
basis candidate; this is a source-derived signal, not a measurement. -/
def completeComplexHistory (origin : Index) : SourceMoment → State :=
  fun moment => snapshot moment origin

/-- Hypothetical semantic interpretation. The *continuity* value is
NOT inferred from a physical law: it is deliberately unconstrained
to stress-test the exact source readout's ability to decide it. -/
structure SubjectInterpretation where
  sourceOrigin : Index
  subjectActuallyContinues : Bool

def physicalComplexReadout (x : SubjectInterpretation) :
    SourceMoment → State :=
  completeComplexHistory x.sourceOrigin

def illustrativeContinues : SubjectInterpretation := ⟨2,true⟩
def illustrativeDoesNotContinue : SubjectInterpretation := ⟨2,false⟩

theorem same_complete_complex_source_history :
    physicalComplexReadout illustrativeContinues =
      physicalComplexReadout illustrativeDoesNotContinue := rfl

theorem opposing_hypothetical_subject_readings :
    illustrativeContinues.subjectActuallyContinues ≠
      illustrativeDoesNotContinue.subjectActuallyContinues := by decide

/-- Under UNRESTRICTED hypothetical subject interpretations,
even a perfect readout of the COMPLETE finite complex source history
cannot by itself decide authentic experiential continuation. This
is an IR132 information/semantic underdetermination result, NOT
a physically real loss-of-continuity construction. -/
theorem no_source_complex_history_only_subject_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder
      physicalComplexReadout SubjectInterpretation.subjectActuallyContinues := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      physicalComplexReadout SubjectInterpretation.subjectActuallyContinues
      hDecoder
  exact opposing_hypothetical_subject_readings
    (hFiber illustrativeContinues illustrativeDoesNotContinue
      same_complete_complex_source_history)

/-- A proposed genuinely independent subject-specific observation
must at least distinguish two hypothetical interpretations that
share the complete source history but disagree on continuation. -/
def enrichedComplexReadout {E : Type}
    (extra : SubjectInterpretation → E) (x : SubjectInterpretation) :=
  (physicalComplexReadout x, extra x)

theorem any_exact_subject_correspondence_observation_must_separate
    {E : Type} (extra : SubjectInterpretation → E)
    (hExact : PhysicalBridges.IR132.ExactDecoder
      (enrichedComplexReadout extra)
      SubjectInterpretation.subjectActuallyContinues) :
    extra illustrativeContinues ≠ extra illustrativeDoesNotContinue := by
  intro hExtra
  have hSame :
      enrichedComplexReadout extra illustrativeContinues =
        enrichedComplexReadout extra illustrativeDoesNotContinue := by
    simp only [enrichedComplexReadout, same_complete_complex_source_history, hExtra]
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (enrichedComplexReadout extra)
      SubjectInterpretation.subjectActuallyContinues hExact
  exact opposing_hypothetical_subject_readings
    (hFiber illustrativeContinues illustrativeDoesNotContinue hSame)

#print axioms all_six_basis_candidates_separate_through_every_stage
#print axioms complex_stage_carriers_remain_injective
#print axioms no_source_complex_history_only_subject_decoder
#print axioms any_exact_subject_correspondence_observation_must_separate

end PhysicalBridges.BCRDComplexCarrierAudit
