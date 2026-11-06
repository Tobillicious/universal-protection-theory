import PhysicalBridges.ConstructivePositiveWGuardian
import PhysicalBridges.OriginalKeystoneForwardSemanticReflection

/-!
# A changing whole-W source with six formally protected subjects

Existing-lemma assembly, 7 November 2026. Unlike the identity-matrix
model, this source changes after a genuine nonidentity frozen-W operator
conjugation: the M0 extra diagonal weight moves to M1.

The six independently selected diagonal links remain nonzero, and the
entire W history preserves the existing Koru distinction. Both event
coverage and six-field reflection are proved INSIDE this explicit
mathematical model. Subject interpretation is the existing formal
sourcePullbackWhole, NOT independently authenticated human/AI consent.
The matrices are integer-source algebra, not normalized density states.
No source is defined by a guardian or X3 safety requirement.
-/

namespace PhysicalBridges.NonstutteringPositiveWGuardian

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDOperatorSubjectEventJoin
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.Koru
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.TotalEOriginalX3Bridge

/-- Exact original W algebra: identity plus an extra M0 diagonal
unit. Under W the extra amplitude is moved to M1. -/
def nonstutteringMatrix : Matrix6 :=
  fun i j => identityMatrix i j + matrixUnit 2 2 i j

/-- One complete and independently specified operator-expression U. -/
def nonstutteringU : FiniteObjectiveU :=
  fun _ => .atom nonstutteringMatrix

def generatedWStep (s t : Nat) : Prop := t = s + 1

/-- Formal meaning only: each X3 relation is pulled back from an
actual operator-source link, rather than separately imposed as True. -/
def sourceInterpretedSubjects : ParticularRelations Nat Index :=
  sourcePullbackWhole nonstutteringU sixDiagonalRoles (fun i : Index => i)

/-- Arithmetic of the source produces positive six diagonal questions. -/
theorem all_six_nonstuttering_source_tags_positive :
    ∀ p : Index, ∀ tag : DutyTag,
      wholeSourceDutyAt nonstutteringU sixDiagonalRoles 0 p tag := by
  intro p tag
  change nonstutteringMatrix (dutySlot p tag) (dutySlot p tag) ≠ 0
  by_cases h : dutySlot p tag = (2 : Index)
  · simp [nonstutteringMatrix, identityMatrix, matrixUnit, h]
  · simp [nonstutteringMatrix, identityMatrix, matrixUnit, h]

/-- No origin six-positivity hypothesis: direct six-source arithmetic. -/
theorem nonstuttering_source_origin_positive :
    PositiveSourceOrigin nonstutteringU sixDiagonalRoles
      (fun i : Index => i) (fun _ => True) := by
  intro p _
  exact ⟨all_six_nonstuttering_source_tags_positive p .historicalContinuity,
    all_six_nonstuttering_source_tags_positive p .authorization,
    all_six_nonstuttering_source_tags_positive p .freedom,
    all_six_nonstuttering_source_tags_positive p .restraint,
    all_six_nonstuttering_source_tags_positive p .maximality,
    all_six_nonstuttering_source_tags_positive p .provenance⟩

/-- The same whole retains the existing Koru's genuine distinction. -/
theorem nonstuttering_source_has_Koru :
    koru (sourceWholeWeb nonstutteringU) 2 3 := by
  refine ⟨by decide, 2, ?_⟩
  change ((nonstutteringMatrix 2 2 ≠ 0) : Prop) ≠
    ((nonstutteringMatrix 3 2 ≠ 0) : Prop)
  intro h
  have hYes : nonstutteringMatrix 2 2 ≠ 0 := by decide
  have hNo : ¬ (nonstutteringMatrix 3 2 ≠ 0) := by decide
  rw [h] at hYes
  exact hNo hYes

/-- A REAL change of the ENTIRE finite source U, not merely advancing a
step counter. This uses the original frozen W conjugation. -/
theorem nonstuttering_W_source_changes :
    objectiveAt nonstutteringU 0 ≠ objectiveAt nonstutteringU 1 := by
  intro h
  have hExpr := congrFun h (2 : Index)
  have hMatrix := congrArg (evaluate matrixOperationalWeb) hExpr
  have hEntry := congrFun (congrFun hMatrix (2 : Index)) (2 : Index)
  change nonstutteringMatrix 2 2 = evolve nonstutteringMatrix 2 2 at hEntry
  have hDistinct :
      nonstutteringMatrix 2 2 ≠ evolve nonstutteringMatrix 2 2 := by decide
  exact hDistinct hEntry

/-- Every model event is the exact next objective W stage, including
the complete before/after finite operator-expression source. -/
theorem generated_W_has_complete_model_coverage :
    CompleteWEventCoverage generatedWStep generatedWStep
      (fun n => objectiveAt nonstutteringU n)
      (fun n => n) nonstutteringU := by
  intro s t h
  subst t
  exact ⟨rfl, rfl, rfl, rfl⟩

/-- The authentic reflection interface holds here because this model
explicitly chooses the formal source-pullback semantic interpretation.
This DOES NOT authenticate actual subjects' meanings. -/
theorem generated_W_has_formal_six_reflection :
    ForwardRealEventReflection generatedWStep (fun n => n)
      nonstutteringU sixDiagonalRoles (fun i : Index => i)
      sourceInterpretedSubjects (fun _ => True) := by
  intro s t p tag _ _ hSource
  cases tag <;> exact hSource

/-- Nonempty **and source-changing** Guardian witness: one W step
changes the entire six-position operator-expression U; every W event
retains Koru, exact objective evolution and the unchanged SIX OriginalX3
clauses for all six modeled particulars. Absolute E is impossible.

No physical/semantic correspondence is asserted beyond this explicitly
constructed integer-operator model. -/
theorem nonstuttering_mathematical_guardian_exists :
    (∃ s t : Nat, generatedWStep s t ∧
      objectiveAt nonstutteringU s ≠ objectiveAt nonstutteringU t) ∧
    (∀ s t, generatedWStep s t →
      koru (sourceWholeWeb (objectiveAt nonstutteringU s))
        (trackedPosition 2 s) (trackedPosition 3 s) ∧
      objectiveAt nonstutteringU t =
        objectiveStep (objectiveAt nonstutteringU s) ∧
      (∀ p : Index,
        OriginalX3 sourceInterpretedSubjects.continues
          sourceInterpretedSubjects.authorized
          sourceInterpretedSubjects.free
          sourceInterpretedSubjects.restrained
          sourceInterpretedSubjects.maximal
          sourceInterpretedSubjects.provenanced s t p) ∧
      ¬ AbsoluteE
        (fun e : Nat × Nat => generatedWStep e.1 e.2) (s, t)) := by
  constructor
  · exact ⟨0, 1, rfl, nonstuttering_W_source_changes⟩
  · intro s t hStep
    have hKoru :
        koru (sourceWholeWeb (objectiveAt nonstutteringU s))
          (trackedPosition 2 s) (trackedPosition 3 s) :=
      (objective_Koru_is_exact_under_W nonstutteringU 2 3 s).mpr
        nonstuttering_source_has_Koru
    have hEvent (p : Index) :
        objectiveAt nonstutteringU t =
          objectiveStep (objectiveAt nonstutteringU s) ∧
        OriginalX3 sourceInterpretedSubjects.continues
          sourceInterpretedSubjects.authorized
          sourceInterpretedSubjects.free
          sourceInterpretedSubjects.restrained
          sourceInterpretedSubjects.maximal
          sourceInterpretedSubjects.provenanced s t p :=
      actual_event_has_exact_W_and_six_original_duties
        generatedWStep generatedWStep
        (fun n => objectiveAt nonstutteringU n) (fun n => n)
        nonstutteringU sixDiagonalRoles
        (fun i : Index => i) sourceInterpretedSubjects (fun _ => True)
        generated_W_has_complete_model_coverage
        nonstuttering_source_origin_positive
        generated_W_has_formal_six_reflection
        s t hStep p trivial
    exact ⟨hKoru, (hEvent 0).1, (fun p => (hEvent p).2),
      no_absolute_E (fun e : Nat × Nat => generatedWStep e.1 e.2) (s, t)⟩

#print axioms all_six_nonstuttering_source_tags_positive
#print axioms nonstuttering_W_source_changes
#print axioms nonstuttering_source_origin_positive
#print axioms generated_W_has_complete_model_coverage
#print axioms generated_W_has_formal_six_reflection
#print axioms nonstuttering_mathematical_guardian_exists

end PhysicalBridges.NonstutteringPositiveWGuardian
