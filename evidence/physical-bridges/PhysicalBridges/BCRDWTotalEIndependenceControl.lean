import PhysicalBridges.BCRDActualRelationalFrame
import PhysicalBridges.TotalEOriginalX3Bridge
import PhysicalBridges.OriginalX3Full

/-!
# The frozen BCRD W generator: no-exteriority is not by itself all-six-X3 forcing

A **source-faithful** finite control of the precise proposed inference:

  BCRD source transition + internal reciprocal relations + exact relational
  covariance + impossible AbsoluteE
      => every independently interpreted original-X3 duty?

The source step used here is **literally** the frozen BCRD M-sector W
permutation, not a fictional Boolean dynamics. We use an independently
specified, FALSE-in-one-state *candidate authorization readout*, deliberately
not built into the ActualStep source relation. Thus the real source can step
while that readout is false, without violating its covariance or producing
AbsoluteE. This refutes that proposed implication FROM THOSE PRECISE INPUTS.

This is NOT an independent proof that genuine subject consent has been
physically identified with a source-value readout, or that *complete* BCRD
permits an unauthorized actual event. It is a minimal **join-obligation
control**: physical authorization/reflection needs its own source theorem.
No Hilbert space, external universe, new axiom, guardian predicate in the
source step, or weakened definition of OriginalX3 is used.
-/

namespace PhysicalBridges.BCRDWTotalEIndependenceControl

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDActualRelationalFrame
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.TotalEOriginalX3Bridge

/-- An independently selected nonconstant six-position source state. -/
def witness : SourceState :=
  fun i => if i = 3 then 1 else 0

/-- Actual source transition, unchanged from the frozen BCRD W generator. -/
def sourceEvent (s t : SourceState) : Prop :=
  ActualStep s SourceEvent.mSectorSwap t

/-- Reciprocity of the independently read, same-value source relation. -/
def Reciprocal (s : SourceState) : Prop :=
  ∀ i j : Index, RelationBefore s i j ↔ RelationBefore s j i

theorem reciprocal_at_every_source_state (s : SourceState) : Reciprocal s := by
  intro i j
  constructor <;> intro h <;> exact h.symm

/-- A particular candidate semantic readout, NOT a proof of real consent. -/
def candidateAuthorized (s : SourceState) : Prop :=
  s 2 = 1

def otherDuty (_s _t : SourceState) (_p : Unit) : Prop := True

def candidateAuthorization (s _t : SourceState) (_p : Unit) : Prop :=
  candidateAuthorized s

/-- The actual ORIGINAL six-field structure, with one independent
candidate semantic field; five other duties are true to isolate the issue. -/
def candidateOriginalX3 (s t : SourceState) (p : Unit) : Prop :=
  OriginalX3 otherDuty candidateAuthorization otherDuty
    otherDuty otherDuty otherDuty s t p

theorem W_step_is_actual :
    sourceEvent witness (step witness) := by
  rfl

theorem W_step_moves_source_data :
    witness 2 = 0 ∧ (step witness) 2 = 1 := by
  decide

theorem W_step_is_not_identity : witness ≠ step witness := by
  intro h
  have hAt2 := congrArg (fun s : SourceState => s 2) h
  have hDiff : witness 2 ≠ (step witness) 2 := by decide
  exact hDiff hAt2

/-- Covariance is the pre-existing exact BCRD source theorem, not
axiomatized or fabricated for this countercontrol. -/
theorem W_step_is_relationally_covariant :
    ∀ i j : Index,
      RelationBefore witness i j ↔
      RelationAfter (step witness) (Transport i) (Transport j) := by
  exact relational_covariance witness (step witness)
    SourceEvent.mSectorSwap rfl

theorem candidate_authorization_fails :
    ¬ candidateAuthorized witness := by
  change ¬ witness 2 = 1
  decide

theorem candidate_original_X3_fails :
    ¬ candidateOriginalX3 witness (step witness) () := by
  intro h
  exact candidate_authorization_fails h.authorization

/-- Exact scoped result: all source relations are internal (Fin 6);
the W step is actual, nontrivial, reciprocal and relationally covariant;
AbsoluteE is impossible as in PR #319; nevertheless a separately
interpreted candidate OriginalX3 authorization field is false.

This does NOT test a stronger `BoundaryComplete` law if such a law
derives specifically **authorization-preserving generator constraints**.
That stronger theorem must be supplied independently by BCRD. -/
theorem source_W_no_exterior_does_not_alone_force_X3 :
    (∀ e : SourceState × SourceState,
      ¬ AbsoluteE (fun q : SourceState × SourceState =>
        sourceEvent q.1 q.2) e) ∧
    (∃ s t : SourceState,
      sourceEvent s t ∧
      s ≠ t ∧
      Reciprocal s ∧ Reciprocal t ∧
      (∀ i j : Index,
        RelationBefore s i j ↔
        RelationAfter t (Transport i) (Transport j)) ∧
      ¬ candidateOriginalX3 s t ()) := by
  constructor
  · intro e
    exact no_absolute_E
      (fun q : SourceState × SourceState => sourceEvent q.1 q.2) e
  · refine ⟨witness, step witness,
      W_step_is_actual,
      W_step_is_not_identity,
      reciprocal_at_every_source_state witness,
      reciprocal_at_every_source_state (step witness),
      W_step_is_relationally_covariant,
      candidate_original_X3_fails⟩

#print axioms reciprocal_at_every_source_state
#print axioms W_step_is_actual
#print axioms W_step_is_not_identity
#print axioms W_step_is_relationally_covariant
#print axioms candidate_original_X3_fails
#print axioms source_W_no_exterior_does_not_alone_force_X3

end PhysicalBridges.BCRDWTotalEIndependenceControl
