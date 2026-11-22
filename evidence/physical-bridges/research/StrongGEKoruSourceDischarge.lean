import PhysicalBridges.EverestActualWEventJoin
import PhysicalBridges.EndlessKnowledgeGuardianBridge
import PhysicalBridges.TotalEOriginalX3Bridge

/-!
# Complete Koru / objective Time Koru strong G/E — source discharge test

Additive composition, not a redefinition of Koru. It derives the
original six duties for physical steps from the existing independently
specified positive-W source coverage and authentic semantic reflection.
Record retention is separate. A hostile control proves that even
strictly growing records alone do not force authorization.
-/

namespace PhysicalBridges.StrongGEKoruSourceDischarge

open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.EndlessKnowledgeGuardianBridge
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {S P Claim : Type}

/-- Exact positive-W source to authentic original-six AND retained
objective record on the same actual step. The physical correspondence
remains explicit and is not claimed to hold for every real event. -/
theorem actual_source_warrant_and_objective_history_jointly_protect
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → PhysicalBridges.FrozenBCRDEvents.Index) (r : ParticularRelations S P)
    (owed : P → Prop) (known : S → Claim → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage PhysicalBridges.OriginalKeystonePositiveWholeTest.positiveWholeU)
    (hReflection : ForwardRealEventReflection modeledStep stage
      PhysicalBridges.OriginalKeystonePositiveWholeTest.positiveWholeU PhysicalBridges.OriginalKeystonePositiveWholeTest.sixDiagonalRoles carrier r owed)
    (hRetention : ∀ s t, physicalStep s t → Retains known s t)
    (s t : S) (hPhysical : physicalStep s t) :
    (∀ p, owed p →
      OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced s t p) ∧
    Retains known s t ∧
    ¬ PhysicalBridges.TotalEOriginalX3Bridge.AbsoluteE
       (fun e : S × S => physicalStep e.1 e.2) (s, t) := by
  refine ⟨?_, hRetention s t hPhysical, ?_⟩
  · intro p hp
    exact (positive_W_actual_event_six_requires_only_coverage_and_reflection
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection s t hPhysical p hp).2
  · exact PhysicalBridges.TotalEOriginalX3Bridge.no_absolute_E
      (fun e : S × S => physicalStep e.1 e.2) (s, t)

/-- Native positive-source truth and authentic semantic reflection
exclude any local X3 violation. The bridge is NOT independent of
the reflection hypothesis: the remaining actual-world premise is
explicit and has not been relabelled as absolute E. -/
theorem native_source_excludes_every_local_six_violation
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → PhysicalBridges.FrozenBCRDEvents.Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage PhysicalBridges.OriginalKeystonePositiveWholeTest.positiveWholeU)
    (hReflection : ForwardRealEventReflection modeledStep stage
      PhysicalBridges.OriginalKeystonePositiveWholeTest.positiveWholeU PhysicalBridges.OriginalKeystonePositiveWholeTest.sixDiagonalRoles carrier r owed) :
    ∀ s t p, physicalStep s t → owed p →
      ¬ (¬ OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced s t p) := by
  intro s t p hstep hp hbad
  exact hbad
    (positive_W_actual_event_six_requires_only_coverage_and_reflection
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection s t hstep p hp).2

/-- Countermodel: forward increment with strictly growing retained
causal records but with independently false authorization. This is
a formal independence control, not an actual BCRD physical event. -/
def hostileRelations : ParticularRelations Nat Unit where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

theorem strictly_growing_record_can_coexist_with_original_x3_failure :
    recordAdvance 0 1 ∧
    Retains recordedBy 0 1 ∧
    ¬ Retains recordedBy 1 0 ∧
    ¬ OriginalX3 hostileRelations.continues
      hostileRelations.authorized hostileRelations.free
      hostileRelations.restrained hostileRelations.maximal
      hostileRelations.provenanced 0 1 () := by
  have hGrowth := every_advance_has_a_new_record 0
  refine ⟨hGrowth.1, hGrowth.2.1, hGrowth.2.2, ?_⟩
  intro hX3
  exact hX3.authorization

#print axioms actual_source_warrant_and_objective_history_jointly_protect
#print axioms native_source_excludes_every_local_six_violation
#print axioms strictly_growing_record_can_coexist_with_original_x3_failure

end PhysicalBridges.StrongGEKoruSourceDischarge
