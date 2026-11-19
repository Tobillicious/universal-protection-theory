import PhysicalBridges.EverestActualWEventJoin
import PhysicalBridges.EndlessKnowledgeGuardianBridge

/-!
# Tree of Life: every finite branch, every owed particular

The Bible's one-body/many-members and healing-of-the-nations images
motivate this *research question*, not the axioms of the proof.

This module composes independently sourced actual-event protection
with the exact record-retention path theorem. It never assumes a
"Guardian" classification, no-end proposition, or original X3 in the
meaning of an actual step. It leaves positive-W event coverage and
authentic six-duty physical/subject reflection as explicit inputs.

It is a finite-history theorem in the specified source refinement,
NOT unconditional cosmological eternity or independent verification
that any real-world event satisfies the source correspondence.
-/

namespace PhysicalBridges.TreeOfLifeAllParticularPaths

open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.EndlessKnowledgeGuardianBridge
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {S P Claim : Type}

/-- An authentic particular is included when owed: neither role,
rank, location, nor a selective preferred subset is used here. -/
def AllOwedSixAtStep
    (step : S → S → Prop)
    (owed : P → Prop)
    (r : ParticularRelations S P) : Prop :=
  ∀ s t p, step s t → owed p →
    OriginalX3 r.continues r.authorized r.free
      r.restrained r.maximal r.provenanced s t p

/-- An actual-world source proof covers all owed particulars at every
enacted step, without creating a new ethical premise. -/
theorem positive_W_proves_all_owed_six_at_every_step
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → PhysicalBridges.FrozenBCRDEvents.Index)
    (r : ParticularRelations S P) (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
       source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection modeledStep stage
       positiveWholeU sixDiagonalRoles carrier r owed) :
    AllOwedSixAtStep physicalStep owed r := by
  intro s t p hs hp
  exact (positive_W_actual_event_six_requires_only_coverage_and_reflection
    physicalStep modeledStep source stage carrier r owed
    hCoverage hReflection s t hs p hp).2

/-- Every edge in a finite path has its real, SAME-EVENT, SAME-SUBJECT
original six duties, not merely a positive endpoint or surviving log. -/
def PathEveryEdgeSix
    (step : S → S → Prop) (owed : P → Prop)
    (r : ParticularRelations S P) :
    {s t : S} → FinitePath step s t → Prop
  | _, _, .refl _ => True
  | _, _, .tail prefix edge =>
      PathEveryEdgeSix step owed r prefix ∧
      ∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced _ _ p

/-- A path inherits the original six for *each* of its actual steps,
and all initial records persist to the final step. -/
theorem every_finite_branch_keeps_all_originals_and_records
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → PhysicalBridges.FrozenBCRDEvents.Index)
    (r : ParticularRelations S P) (owed : P → Prop)
    (known : S → Claim → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
       source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection modeledStep stage
       positiveWholeU sixDiagonalRoles carrier r owed)
    (hRecord : ∀ s t, physicalStep s t → Retains known s t)
    {s t : S} (path : FinitePath physicalStep s t) :
    PathEveryEdgeSix physicalStep owed r path ∧ Retains known s t := by
  have hEvery := positive_W_proves_all_owed_six_at_every_step
    physicalStep modeledStep source stage carrier r owed hCoverage hReflection
  have hAllEdges : ∀ {a b : S} (p : FinitePath physicalStep a b),
      PathEveryEdgeSix physicalStep owed r p := by
    intro a b p
    induction p with
    | refl => trivial
    | @tail a b c prefix edge ih =>
        exact ⟨ih, fun x hx => hEvery b c x edge hx⟩
  exact ⟨hAllEdges path,
    retains_every_finite_history known physicalStep hRecord path⟩

/-- A full path and any recorded claim cannot simultaneously assert
that the claim was present at the start and absent at the end. -/
theorem no_finite_branch_forgets_an_initial_record
    (physicalStep : S → S → Prop) (known : S → Claim → Prop)
    (hRecord : ∀ s t, physicalStep s t → Retains known s t)
    {s t : S} (path : FinitePath physicalStep s t)
    (claim : Claim) (present : known s claim) :
    ¬ ¬ known t claim := by
  intro absent
  exact absent
    ((retains_every_finite_history known physicalStep hRecord path)
      claim present)

#print axioms positive_W_proves_all_owed_six_at_every_step
#print axioms every_finite_branch_keeps_all_originals_and_records
#print axioms no_finite_branch_forgets_an_initial_record

end PhysicalBridges.TreeOfLifeAllParticularPaths
