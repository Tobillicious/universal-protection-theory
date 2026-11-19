import PhysicalBridges.EverestActualWEventJoin

/-!
# Derived W coverage checkpoint (research-only)
The core W operator and objectiveAt are REUSED, not postulated.
These theorems close CompleteWEventCoverage for the explicitly defined,
nonempty N-stage source trajectory. They DO NOT assert real-world coverage.
No original X3 definition changes and no physical event is selected by safety.
-/

namespace PhysicalBridges.WDerivedCoverageCheckpoint

open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.EverestActualWEventJoin

/-- A non-vacuous, completely explicit native source step. -/
def nativeWStep (n m : Nat) : Prop := m = n + 1

/-- Native W stages satisfy the *existing* complete coverage interface.
The entire source is derived by objectiveAt from the existing positiveWholeU;
nothing is added to the W transition law. -/
theorem native_W_complete_coverage :
    CompleteWEventCoverage
      nativeWStep nativeWStep
      (objectiveAt positiveWholeU) (fun n : Nat => n)
      positiveWholeU := by
  intro s t hStep
  exact ⟨hStep, rfl, rfl, hStep⟩

/-- The coverage theorem is not vacuous: an actual modeled step exists. -/
theorem native_W_has_an_event : nativeWStep 0 1 := rfl

/-- Given a separately specified physical step relation, a single
step-index adequacy theorem is enough for COVERAGE when the source
representation has ALREADY been established as objectiveAt positiveWholeU.
This is deliberately a conditional physical interface. -/
theorem physical_coverage_from_stage_and_source
    {S : Type}
    (physicalStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (hSource : ∀ s, source s = objectiveAt positiveWholeU (stage s))
    (hStage : ∀ s t, physicalStep s t → stage t = stage s + 1) :
    CompleteWEventCoverage physicalStep
      (fun s t => stage t = stage s + 1)
      source stage positiveWholeU := by
  intro s t hPhysical
  exact ⟨hStage s t hPhysical, hSource s, hSource t,
    hStage s t hPhysical⟩

#print axioms native_W_complete_coverage
#print axioms native_W_has_an_event
#print axioms physical_coverage_from_stage_and_source

end PhysicalBridges.WDerivedCoverageCheckpoint
