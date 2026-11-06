import PhysicalBridges.CathedralCapstoneJoins
import PhysicalBridges.EverestActualWEventJoin

/-!
# Existing-proof assembly: faithful holding × Hillary on ONE realized history

7 November 2026. This module introduces NO new physical model, no new
ethical definition, and no original-six-X3 replacement. It simply composes
two already checked branches on the SAME indexed realized physical history:

* CathedralCapstoneJoins.capstone_enacted_history_protected:
  faithfully enacted common-safe actions retain the protected invariant.
  This is the original reasons-OR-holding architecture's enacted-action lane.
* EverestActualWEventJoin.positive_W_actual_event_six_requires_only_coverage_and_reflection:
  a separately designated physical step that is covered by the positive
  complete W source and faithfully interpreted forwards satisfies ALL SIX
  authentic OriginalX3 predicates on that SAME before/after event, for
  EVERY owed particular. Positive source origin is already proved for the
  concrete positiveWholeU, not assumed in these assembly theorems.

The first theorem takes actual physical trace membership independently;
the second derives that membership from independently stated refinement of
each enacted guarded source action. There is NO demand that an adversarial
mind voluntarily agree with the protection policy.

The joins hEnacts, hPhysical / hRefines, hCoverage, and hReflection retain
their real meanings and are explicit. A safeState predicate is NOT defined
as original X3, and no original X3 condition is built into step admission.
An arbitrary real installation, all authentic subject meanings, all-ethics
Hume/Archimedes scope, and all real physics are NOT certified by these
conditional theorem compositions. No theorem statement from the imports
is changed.
-/

namespace PhysicalBridges.HillaryHoldingSameHistoryAssembly

open PhysicalBridges.CathedralCapstoneJoins
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FrozenBCRDEvents

/-- One exact realized history simultaneously satisfies: (1) the faithful
holding invariant at every stage, (2) physically computed whole-W source
evolution on every actual event, (3) all six unmodified original-X3 duties
on that very event and for every independently owed particular.

No one of hEnacts, hPhysical, hCoverage or hReflection follows merely from
a model's existence. This proof assembles their already existing results. -/
theorem holding_and_original_six_on_same_realized_history
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
    (hPhysical : ∀ n, physicalStep (realized n) (realized (n + 1)))
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed) :
    (∀ n, safeState (realized n)) ∧
    (∀ n, source (realized (n + 1)) =
      objectiveStep (source (realized n))) ∧
    (∀ n p, owed p →
      OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced (realized n) (realized (n + 1)) p) := by
  refine ⟨?_, ?_, ?_⟩
  · exact capstone_enacted_history_protected
      observe sourceStep allowed safeState realized hStart hEnacts
  · intro n
    obtain ⟨_, hBefore, hAfter, hNext⟩ :=
      hCoverage (realized n) (realized (n + 1)) (hPhysical n)
    calc
      source (realized (n + 1)) =
          objectiveAt positiveWholeU (stage (realized (n + 1))) := hAfter
      _ = objectiveStep (objectiveAt positiveWholeU (stage (realized n))) := by
        rw [hNext]
        rfl
      _ = objectiveStep (source (realized n)) := by rw [hBefore]
  · intro n p hp
    exact (positive_W_actual_event_six_requires_only_coverage_and_reflection
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection (realized n) (realized (n + 1))
      (hPhysical n) p hp).2

/-- Same entire trace certificate, now with physical membership DERIVED from
a common real-source refinement relation. This removes the independent
per-index hPhysical argument without pretending the physical refinement
itself has been independently authenticated for every device or universe. -/
theorem holding_and_original_six_from_enacted_physical_refinement
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
    (∀ n p, owed p →
      OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced (realized n) (realized (n + 1)) p) := by
  have hPhysical : ∀ n, physicalStep (realized n) (realized (n + 1)) := by
    intro n
    obtain ⟨a, hStep, _⟩ := hEnacts n
    exact hRefines (realized n) a (realized (n + 1)) hStep
  exact holding_and_original_six_on_same_realized_history
    observe sourceStep allowed safeState realized
    physicalStep modeledStep source stage carrier r owed
    hStart hEnacts hPhysical hCoverage hReflection

#print axioms holding_and_original_six_on_same_realized_history
#print axioms holding_and_original_six_from_enacted_physical_refinement

end PhysicalBridges.HillaryHoldingSameHistoryAssembly
