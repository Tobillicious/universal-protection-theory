import PhysicalBridges.PhysicalSemanticLastMileGates
import PhysicalBridges.GAndNoEFullSixTraceAssembly

/-!
# Original-six G / no-absolute-E at EVERY covered physical step

7 November 2026 — source-only assembly from already merged #403 and #404.

Unlike a single realized trace, this module universally quantifies over all
steps of an independently specified physical relation. It constructs no
"physical" relation by declaring its steps safe or X3-compliant.

The actual-world assertion STILL needs separate discharge of:
  * hCoverage : CompleteWEventCoverage ... positiveWholeU
  * hReflection : ForwardRealEventReflection ... sixDiagonalRoles ...
Neither can be inferred from the fact that an internal W simulation runs.
The full ALL-ethics, nontrivial real-universe genesis and source-installation
arguments are not claimed by this local theorem.

No original-X3 predicates, the Koru, holding policy, source dynamics,
or existing proofs are modified. No new axioms.
-/

namespace PhysicalBridges.FullPhysicalDomainGuardianAssembly

open PhysicalBridges.Koru
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.PhysicalSemanticLastMileGates
open PhysicalBridges.TotalEOriginalX3Bridge

/-- Every actual step of the independently supplied physical domain:
the same positive whole-U source has intrinsic Koru distinction, its
source advances under exact W, every genuinely owed particular has ALL
six original X3 duties, and actual absolute E is impossible.

This is conditional on external physical COVERAGE and authentic FORWARD
REFLECTION, not on a selected trace and not on an assumed X3 conclusion. -/
theorem every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed) :
    ∀ s t, physicalStep s t →
      koru (sourceWholeWeb (source s))
        (trackedPosition 2 (stage s))
        (trackedPosition 3 (stage s)) ∧
      source t = objectiveStep (source s) ∧
      (∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced s t p) ∧
      ¬ AbsoluteE
        (fun e : S × S => physicalStep e.1 e.2) (s, t) := by
  intro s t hPhysical
  obtain ⟨_, hBefore, hAfter, hNext⟩ := hCoverage s t hPhysical
  have hKoru :
      koru (sourceWholeWeb (source s))
        (trackedPosition 2 (stage s))
        (trackedPosition 3 (stage s)) := by
    rw [hBefore]
    exact (positive_whole_Koru_and_all_six_source_duties
      (stage s)).1
  have hW : source t = objectiveStep (source s) := by
    calc
      source t = objectiveAt positiveWholeU (stage t) := hAfter
      _ = objectiveStep (objectiveAt positiveWholeU (stage s)) := by
        rw [hNext]
        rfl
      _ = objectiveStep (source s) := by rw [hBefore]
  refine ⟨hKoru, hW, ?_, no_absolute_E
    (fun e : S × S => physicalStep e.1 e.2) (s, t)⟩
  intro p hp
  exact (complete_coverage_and_authentic_reflection_force_original_six
    physicalStep modeledStep source stage carrier r owed
    hCoverage hReflection s t hPhysical p hp).2

/-- The global event-domain consequence of the full-six certificate.
For every actual physical event and independently owed particular, there
is no original-six failure; separately no event can be Absolute E.

This statement quantifies over ALL events of physicalStep, not merely the
chosen realized trace of #402/#403. Whether physicalStep exhausts ALL
physical reality is itself an independently grounded scope obligation. -/
theorem physical_domain_has_no_original_six_violation_or_absolute_E
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed) :
    (∀ e : S × S,
      ¬ ActualX3Violation
        (fun e : S × S => physicalStep e.1 e.2)
        (fun (_ : S × S) p => owed p)
        (fun (e : S × S) p =>
          OriginalX3 r.continues r.authorized r.free
            r.restrained r.maximal r.provenanced e.1 e.2 p) e) ∧
    (∀ e : S × S,
      ¬ AbsoluteE
        (fun e : S × S => physicalStep e.1 e.2) e) := by
  constructor
  · intro e hViolation
    rcases hViolation with ⟨hPhysical, p, hp, hBad⟩
    have hAll :=
      every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
        physicalStep modeledStep source stage carrier r owed
        hCoverage hReflection e.1 e.2 hPhysical
    exact hBad (hAll.2.2.1 p hp)
  · intro e
    exact no_absolute_E
      (fun e : S × S => physicalStep e.1 e.2) e

#print axioms every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
#print axioms physical_domain_has_no_original_six_violation_or_absolute_E

end PhysicalBridges.FullPhysicalDomainGuardianAssembly
