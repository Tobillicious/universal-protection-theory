import PhysicalBridges.G3BCRDMicroscopicCandidate
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# One-law G3: exact non-vacuity and subject-interpretation gate

Find-before-build: combines the genuine BCRD frozen W law with
BCRDOperatorSubjectGap, BCRDAuthorizationFreedomBoundary,
G3QGInterpretationNecessity and IR132 exact-fibre criteria.

Previous toy examples showed specific source laws fail to settle the
truth of independently attached subject interpretations. This module
proves a GENERAL equivalence: a physical relation on any state type can
satisfy ALL unchanged original-six duty predicates for EVERY arbitrary
subject interpretation on Unit iff it has NO physical events.

Consequently, a NONEMPTY genuine physical dynamics can only entail
all-six if the independent physical-subject meaning relation is fixed
and justified; universal quantification over arbitrary semantic
annotations makes the desired implication impossible.

The readout decoder lemma then specifies the exact NON-ETHICAL
structural gate: a physical observation can determine a Boolean
subject-level fact iff that fact is constant on observation fibres.
This guarantees *identifiability*, not correctness, positivity, or
consent. Those must be independently evidenced.

Does NOT rule out a complete law of quantum gravity, and is NOT the
one universal law requested: it identifies a condition that any
independent law must genuinely discharge.
-/

namespace PhysicalBridges.G3OneLawNonvacuityGate

open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.G3BCRDMicroscopicCandidate

variable {S : Type}

/-- The six-field test with NO restrictions on interpretations:
all mathematically possible assignments of the six duty fields,
not just source-admissible or physically meaningful assignments. -/
def UniversalAcrossArbitrarySubjects (physicalStep : S → S → Prop) : Prop :=
  ∀ r : ParticularRelations S Unit,
    ∀ s t, physicalStep s t →
      OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced s t ()

/-- An explicit independently assigned subject interpretation that
has NO authorization at any event; no physics or protection is built
into its definition. -/
def unapprovedAtEveryEvent : ParticularRelations S Unit where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

/-- The exact non-vacuity obstruction for ANY physical state type:
universal six-X3 over *all unrestricted subject interpretations* is
equivalent to NO physically actual events whatsoever. No classical
choice, empirical premise or BCRD physics assumption is needed. -/
theorem all_unrestricted_six_iff_no_events
    (physicalStep : S → S → Prop) :
    UniversalAcrossArbitrarySubjects physicalStep ↔
      (∀ s t, ¬ physicalStep s t) := by
  constructor
  · intro h s t hs
    have hSix := h unapprovedAtEveryEvent s t hs
    exact hSix.authorization
  · intro h r s t hs
    exact False.elim (h s t hs)

/-- Any nonempty dynamics cannot give original-six for all arbitrary
subject readings: it must independently restrict/identify what counts
as an authentic interpretation. -/
theorem any_actual_event_refutes_unrestricted_six
    (physicalStep : S → S → Prop)
    (hWitness : ∃ s t, physicalStep s t) :
    ¬ UniversalAcrossArbitrarySubjects physicalStep := by
  intro hAll
  obtain ⟨s, t, hs⟩ := hWitness
  exact ((all_unrestricted_six_iff_no_events physicalStep).mp hAll) s t hs

/-- The old frozen W source includes an independent actual event.
Therefore it cannot fix arbitrary authentic semantics even though
the same source law is deterministic, reversible and total. -/
theorem real_BCRD_W_event_refutes_unrestricted_original_six :
    ¬ UniversalAcrossArbitrarySubjects
      (S := PhysicalBridges.BCRDActualRelationalFrame.SourceState)
      WSourcePhysicalLaw := by
  apply any_actual_event_refutes_unrestricted_six WSourcePhysicalLaw
  exact W_law_enacts_a_nonidentity_step.elim
    (fun s t h => ⟨s, t, h.1⟩)

/-- Independently justified semantic readout: its exact mathematical
identifiability from observable physical data, **not** a protection
assertion. The existing IR132 fibre criterion gives the necessary and
sufficient structural test, including an exact decoder existence
theorem for Bool-valued semantic measurements. -/
theorem subject_fact_reconstructible_iff_physically_fibre_constant
    {W O : Type}
    (observed : W → O)
    (subjectFact : W → Bool) :
    PhysicalBridges.IR132.ExactDecoder observed subjectFact ↔
      PhysicalBridges.IR132.FiberConstant observed subjectFact :=
  PhysicalBridges.IR132.exact_decoder_iff_fiber_constant observed subjectFact

/-- Even if the source readout is mathematically exact, this result
forces equal labels only for equal readouts. It never forces a
specific *positive* authorization label or authentic consent. -/
theorem exact_semantic_decoder_cannot_disagree_on_one_readout
    {W O : Type}
    (observed : W → O) (subjectFact : W → Bool)
    (hDecoder : PhysicalBridges.IR132.ExactDecoder observed subjectFact)
    (w v : W) (hSame : observed w = observed v) :
    subjectFact w = subjectFact v :=
  (PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
    observed subjectFact hDecoder) w v hSame

#print axioms all_unrestricted_six_iff_no_events
#print axioms any_actual_event_refutes_unrestricted_six
#print axioms real_BCRD_W_event_refutes_unrestricted_original_six
#print axioms subject_fact_reconstructible_iff_physically_fibre_constant
#print axioms exact_semantic_decoder_cannot_disagree_on_one_readout

end PhysicalBridges.G3OneLawNonvacuityGate
