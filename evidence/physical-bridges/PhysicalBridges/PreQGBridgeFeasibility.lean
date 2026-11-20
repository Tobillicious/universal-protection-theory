import PhysicalBridges.FullPhysicalDomainGuardianAssembly
import PhysicalBridges.G3KoruShapeAdversarialGate
import PhysicalBridges.G3InductiveCompleteness
import PhysicalBridges.G3ExactMismatchClosure

/-!
# Pre-QG bridge feasibility: unlimited finite-stage propagation

Research-only additive proof. This tests the compositional route from the
already-checked full-event-domain theorem to every stage of an arbitrarily
long physical trajectory. It does NOT discharge either of the two independent
physical/semantic inputs, prove that the actual universe instantiates them,
assert physical genesis or cosmological nontermination, or authorize effects.

The path (run : Nat → S) and its physical-step witness are inputs. Thus the
theorem is not an existence claim for an eternal physical worldline.

No changes to OriginalX3, Koru, source dynamics or existing theorems.
-/

namespace PhysicalBridges.PreQGBridgeFeasibility

open PhysicalBridges.Koru
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.TotalEOriginalX3Bridge
open PhysicalBridges.FullPhysicalDomainGuardianAssembly

/-- If every actual step is independently covered by the faithful source,
and authentic reflection is independently true, then no stage on ANY supplied
infinite physical path can violate an original six duty for an owed particular
or instantiate the already-defined AbsoluteE.

Proof reuses the existing universal physical-domain theorem, not a new
Guardian predicate. The run input does not establish that the actual physical
universe has an unending trajectory. -/
theorem every_future_step_protected_if_physical_and_authentic
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (run : Nat → S)
    (hRun : ∀ n, physicalStep (run n) (run (n + 1))) :
    ∀ n,
      (∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced
          (run n) (run (n + 1)) p) ∧
      ¬ AbsoluteE
        (fun e : S × S => physicalStep e.1 e.2)
        (run n, run (n + 1)) := by
  intro n
  have h :=
    every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection (run n) (run (n + 1)) (hRun n)
  exact ⟨h.2.2.1, h.2.2.2⟩

/-- A total, independently specified physical successor rule determines a
trajectory from EVERY initial state. This is not Complete Koru and this
function is not asserted to exist for actual cosmology. -/
def physicalOrbit {S : Type} (advance : S → S) (s0 : S) : Nat → S
  | 0 => s0
  | n + 1 => advance (physicalOrbit advance s0 n)

/-- Every initial physical state has a protected continuation at every
finite time index if physical progress, COMPLETE coverage, and AUTHENTIC
six-duty reflection have each been independently established.

This strengthens the previously proven bridge by not requiring a chosen
infinite path as an additional input: the separately supplied global
successor rule generates paths from all starts. It still cannot derive
that successor rule, actual-world coverage, or authentic meaning. -/
theorem every_initial_state_has_protected_future_if_progress_and_reflection
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (advance : S → S)
    (hProgress : ∀ s, physicalStep s (advance s)) :
    ∀ s0 n,
      (∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced
          (physicalOrbit advance s0 n)
          (physicalOrbit advance s0 (n + 1)) p) ∧
      ¬ AbsoluteE
        (fun e : S × S => physicalStep e.1 e.2)
        (physicalOrbit advance s0 n,
         physicalOrbit advance s0 (n + 1)) := by
  intro s0 n
  exact every_future_step_protected_if_physical_and_authentic
    physicalStep modeledStep source stage carrier r owed
    hCoverage hReflection (physicalOrbit advance s0)
    (by
      intro k
      change physicalStep (physicalOrbit advance s0 k)
        (advance (physicalOrbit advance s0 k))
      exact hProgress _) n

#print axioms every_initial_state_has_protected_future_if_progress_and_reflection

/-- Infinite observed-step witnesses rule out vacuous termination *along the
supplied path*. They are not manufactured by event-level protection. -/
theorem supplied_infinite_path_has_successor_at_each_stage
    {S : Type}
    (physicalStep : S → S → Prop)
    (run : Nat → S)
    (hRun : ∀ n, physicalStep (run n) (run (n + 1))) :
    ∀ n, ∃ t, physicalStep (run n) t := by
  intro n
  exact ⟨run (n + 1), hRun n⟩

/-- Negative control: a proposition about *every existing transition*
can be true for a system with no transitions. Therefore a universal
event-level safety theorem alone cannot imply physical eternal progress. -/
theorem all_event_closure_does_not_force_a_successor :
    ∃ step : Unit → Unit → Prop,
      (∀ s t, step s t → False) ∧
      ¬ (∃ t, step () t) := by
  refine ⟨(fun _ _ => False), ?_, ?_⟩
  · intro s t h
    exact h
  · intro h
    exact h.elim (fun _ ht => ht)

#print axioms supplied_infinite_path_has_successor_at_each_stage
#print axioms all_event_closure_does_not_force_a_successor

-- Check the existing negative control: valid operator shape is not consent.
#check PhysicalBridges.G3KoruShapeAdversarialGate.shape_cannot_by_itself_force_original_six
-- New stages require new witnesses; this is not automatic physical coverage.
#check PhysicalBridges.G3InductiveCompleteness.COMPLETENESS_IS_INDUCTIVE
#check PhysicalBridges.G3InductiveCompleteness.one_missing_step_witness_breaks_completeness
-- Authentic all-six correspondence remains independently testable.
#check PhysicalBridges.G3ExactMismatchClosure.all_owed_X3_iff_no_source_subject_mismatch

#print axioms every_future_step_protected_if_physical_and_authentic

end PhysicalBridges.PreQGBridgeFeasibility
