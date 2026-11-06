import PhysicalBridges.HillaryHoldingSameHistoryAssembly
import PhysicalBridges.TotalEOriginalX3Bridge

/-!
# House on rock: enacted holding + original six + Total-E on the SAME trace

Assembly of existing theorem sources only; 7 November 2026.

This module joins the protected-history theorem in
HillaryHoldingSameHistoryAssembly with the independent exact original-X3 /
Total-E equivalence in TotalEOriginalX3Bridge.

Important scopes:
* ActualTraceEvent is the chosen REALIZED consecutive-event relation. It is
  defined from the history itself, not from a protection, guardian, source-tag,
  or OriginalX3 condition.
* The input already proves the unchanged six OriginalX3 fields for each
  independently owed particular on each such event.
* Therefore no such trace event is an ActualX3Violation. The existing
  total_E_bridge_iff_no_actual_x3_violation then provides the *equivalent*
  scoped Total-E formulation. This is NOT an independent physical derivation
  of the strong G/E dichotomy or of the full universe's physical event set.
* The complete W physical-coverage, enacted source-step refinement, and
  authentic forward-reflection premises remain exactly as in the imports.
* No new physics, ethical axioms, time model, or duty definitions.
-/

namespace PhysicalBridges.HillaryHoldingTotalETraceAssembly

open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.HillaryHoldingSameHistoryAssembly
open PhysicalBridges.TotalEOriginalX3Bridge
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.FrozenBCRDEvents

/-- The consecutive events of an independently supplied realized history.
Crucially, X3 and guardian admissibility play no role in this definition. -/
def ActualTraceEvent {S : Type} (realized : Nat → S) (e : S × S) : Prop :=
  ∃ n, e = (realized n, realized (n + 1))

/-- Existing full-six facts on the same trace directly discharge the
ActualX3Violation predicate on precisely that trace, for ALL owed P. -/
theorem original_six_on_trace_excludes_actual_x3_violation
    {S P : Type}
    (realized : Nat → S)
    (r : ParticularRelations S P) (owed : P → Prop)
    (hSix : ∀ n p, owed p →
      OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced
        (realized n) (realized (n + 1)) p) :
    ∀ e : S × S,
      ¬ ActualX3Violation (ActualTraceEvent realized)
        (fun _ p => owed p)
        (fun e p =>
          OriginalX3 r.continues r.authorized r.free
            r.restrained r.maximal r.provenanced e.1 e.2 p) e := by
  intro e hViolation
  rcases hViolation with ⟨⟨n, he⟩, p, hp, hBad⟩
  subst e
  exact hBad (hSix n p hp)

/-- The original holding highway and exact positive-W Hillary event theorem
are placed on ONE history, then the existing Total-E iff is applied.

The Total-E conclusion is an equivalent way of reporting no violations on
this already-protected trace. It supplies NO new independent actual-world
E/G ontology premise. The physical and semantic hypotheses are unchanged. -/
theorem enacted_holding_hillary_total_E_trace_seam
    {S P O A : Type}
    (observe : S → O) (sourceStep : S → A → S → Prop)
    (allowed : S → A → Prop) (safeState : S → Prop)
    (realized : Nat → S)
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hStart : safeState (realized 0))
    (hEnacts : ∀ n : Nat, ∃ a : A,
      sourceStep (realized n) a (realized (n + 1)) ∧
      ∀ s, observe s = observe (realized n) → safeState s →
        allowed s a ∧ ∀ t, sourceStep s a t → safeState t)
    (hRefines : ∀ s a t, sourceStep s a t → physicalStep s t)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed) :
    (∀ n, safeState (realized n)) ∧
    (∀ n, source (realized (n + 1)) =
      objectiveStep (source (realized n))) ∧
    (∀ e : S × S,
      ¬ ActualX3Violation (ActualTraceEvent realized)
        (fun _ p => owed p)
        (fun e p =>
          OriginalX3 r.continues r.authorized r.free
            r.restrained r.maximal r.provenanced e.1 e.2 p)) ∧
    (∀ e : S × S,
      ActualX3Violation (ActualTraceEvent realized)
        (fun _ p => owed p)
        (fun e p =>
          OriginalX3 r.continues r.authorized r.free
            r.restrained r.maximal r.provenanced e.1 e.2 p) e →
      AbsoluteE (ActualTraceEvent realized) e) := by
  have assembled :=
    holding_and_original_six_from_enacted_physical_refinement
      observe sourceStep allowed safeState realized
      physicalStep modeledStep source stage carrier r owed
      hStart hEnacts hRefines hCoverage hReflection
  have noViolation :=
    original_six_on_trace_excludes_actual_x3_violation
      realized r owed assembled.2.2
  exact ⟨assembled.1, assembled.2.1, noViolation,
    (total_E_bridge_iff_no_actual_x3_violation
      (ActualTraceEvent realized)
      (fun (_ : S × S) p => owed p)
      (fun e p => OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced e.1 e.2)).mpr
      noViolation⟩

#print axioms original_six_on_trace_excludes_actual_x3_violation
#print axioms enacted_holding_hillary_total_E_trace_seam

end PhysicalBridges.HillaryHoldingTotalETraceAssembly
