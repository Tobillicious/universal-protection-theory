import PhysicalBridges.KoruOperatorHistoryProvenance

/-!
# Full-state BCRD source-step reflection: the operator is recoverable

Adds a positive non-circular algebraic result to the Koru/∆ source bridge:
for each of the FIVE exactly computed source-stage contexts of the pinned
BCRD M3d candidate, the three original source-stage operators W, C_LM
and U_MR6 produce PAIRWISE DISTINCT NEXT FULL SIX-ORIGIN COMPLEX TABLES.
Thus the action can be determined from genuine complete prior/next
source-amplitude data, not a postulated "authorization" or director bit.

A decoder is explicitly constructed by testing those three source-
computed possibilities, and its correctness is proved for all 5 × 3
modelled pairs. This strengthens #358: final state alone loses operator
provenance across nontrivial cycles, but authentic full-step source data
can recover WHICH model operator occurred in these contexts.

Mathematical linear-algebraic source code is NOT a claim that a Hilbert
space exists as an ontological container. No such space is postulated.
This does NOT identify an experiencing particular, prove real consent,
show the candidate stage system exhausts physical U, or close six X3.
-/

namespace PhysicalBridges.KoruFullStepOperatorReflection

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit

/-- Exact physical-source next-step full amplitude table computed by
a chosen member of the original pinned finite BCRD generator bank,
given the original five source-stage contexts. No semantic role input. -/
def fullSourceAfter (m : SourceMoment) (op : SourceStage) :
    Index → State :=
  fun origin => matVec (operatorFor op) (snapshot m origin)

/-- Three independently computed next wholes are different at ALL five
pinned complex-stage contexts. This is finite exact arithmetic, rather
than inserting distinct operator labels as an extra output field. -/
theorem three_real_source_operators_have_distinct_full_effects
    (m : SourceMoment) :
    fullSourceAfter m .endogenousW ≠ fullSourceAfter m .enabledLM ∧
    fullSourceAfter m .endogenousW ≠ fullSourceAfter m .middleRight ∧
    fullSourceAfter m .enabledLM ≠ fullSourceAfter m .middleRight := by
  cases m <;> decide +kernel

/-- Therefore the source-step image reflects the original actual
operator that generated it; no self-reported action/permission bit. -/
theorem full_source_step_reflects_which_operator
    (m : SourceMoment) :
    Function.Injective (fullSourceAfter m) := by
  intro a b hEq
  obtain ⟨hWL, hWM, hLM⟩ :=
    three_real_source_operators_have_distinct_full_effects m
  cases a <;> cases b
  · rfl
  · exact False.elim (hWL hEq)
  · exact False.elim (hWM hEq)
  · exact False.elim (hWL hEq.symm)
  · rfl
  · exact False.elim (hLM hEq)
  · exact False.elim (hWM hEq.symm)
  · exact False.elim (hLM hEq.symm)
  · rfl

/-- Decoder depends solely on the source-stage context and the ACTUAL
whole-complex next-step readout. It searches the *fixed original*
W/C_LM/U_MR6 operator bank; no subject-state oracle is supplied. -/
noncomputable def recoverPhysicalSourceOperator
    (m : SourceMoment) (readout : Index → State) : Option SourceStage := by
  classical
  exact
    if readout = fullSourceAfter m .endogenousW then
      some .endogenousW
    else if readout = fullSourceAfter m .enabledLM then
      some .enabledLM
    else if readout = fullSourceAfter m .middleRight then
      some .middleRight
    else none

/-- Positive exact action provenance: on all 15 independently source-
computed pairs (five prior contexts, three action operators), the
decoder recovers the specific action. This statement does NOT conflate
which operator acted with who authorised it. -/
theorem complete_source_step_has_exact_operator_decoder
    (m : SourceMoment) (op : SourceStage) :
    recoverPhysicalSourceOperator m (fullSourceAfter m op) = some op := by
  classical
  have ⟨hWL, hWM, hLM⟩ :=
    three_real_source_operators_have_distinct_full_effects m
  cases op with
  | endogenousW =>
      simp [recoverPhysicalSourceOperator]
  | enabledLM =>
      simp [recoverPhysicalSourceOperator, hWL.symm]
  | middleRight =>
      simp [recoverPhysicalSourceOperator, hWM.symm, hLM.symm]

/-- The source-operator decoder cannot be fooled by an input which
is exactly the next readout of another operator, as a mathematical
consequence of the actual complex source arithmetic. -/
theorem complete_source_step_cannot_misattribute_another_operator
    (m : SourceMoment) (actual reported : SourceStage)
    (hReadout :
      fullSourceAfter m actual = fullSourceAfter m reported) :
    actual = reported :=
  (full_source_step_reflects_which_operator m) hReadout

#print axioms three_real_source_operators_have_distinct_full_effects
#print axioms full_source_step_reflects_which_operator
#print axioms complete_source_step_has_exact_operator_decoder
#print axioms complete_source_step_cannot_misattribute_another_operator

end PhysicalBridges.KoruFullStepOperatorReflection
