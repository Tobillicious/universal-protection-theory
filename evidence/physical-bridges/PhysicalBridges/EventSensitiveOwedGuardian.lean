import PhysicalBridges.PhysicalSemanticLastMileGates

/-!
# Event-sensitive owedness: exact interface lift

Additive theorem. Does not change OriginalX3 or Koru.
The universal forward reflection premise below is intentionally stronger than
the fixed-roster premise. It is NOT derived from physical laws here.
This makes event-dependent owedness visible in the conclusion without
pretending that a fixed roster independently captures every owed subject.
-/

namespace PhysicalBridges.EventSensitiveOwedGuardian

open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.PhysicalSemanticLastMileGates
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

/-- A genuine event-sensitive owedness predicate is supplied independently.
If coverage and source-to-subject reflection hold for every particular,
then the original six duties hold for every particular owed at any event.

The `fun _ => True` roster is an intentionally strong *premise* of the
reflection theorem, not an assertion that all real-world subjects have
been authenticated. Physical interpretation remains a separate obligation. -/
theorem every_event_owed_particular_has_original_six
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owedAt : S → S → P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflectionAll : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r
      (fun _ => True))
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (_hOwed : owedAt s t p) :
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced s t p := by
  exact (complete_coverage_and_authentic_reflection_force_original_six
    physicalStep modeledStep source stage carrier r
    (fun _ => True) hCoverage hReflectionAll s t hPhysical p True.intro).2

#print axioms every_event_owed_particular_has_original_six

end PhysicalBridges.EventSensitiveOwedGuardian
