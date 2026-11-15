import PhysicalBridges.GuardianCreatorConditionalJoin

/-!
# Conditional Genesis creator: continuing responsibility and nonempty owed scope

This additive follow-up to merged #500 does not rename God, assume a creator,
change Complete Koru, or replace the original six X3 predicates.

The previous theorem proves all six duties for *owed* particulars on a
modeled Genesis event, given independent physical and semantic premises and
a causal author witness. It does not itself show that any particular is owed,
nor that the author bears responsibility for the transition.

Here the additional hypotheses are separately stated:
* an actually owed subject exists on every proposed boundary;
* physical authorship implies accountable responsibility on that very edge.

These are NOT inferred from W, right-handedness, existence, or a title such
as "God". The theorem then produces one accountable causal author, one
genuinely owed-and-protected subject, and all six unchanged duties for every
owed particular of the same physical Genesis event.

No conclusion about the actual universe, future actions of the author,
divinity, consciousness, or unconditionally universal protection is asserted.
-/

namespace PhysicalBridges.GuardianCreatorResponsibilityJoin

open PhysicalBridges.GuardianCreatorConditionalJoin
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.CathedralFullX3Assembly

universe u v
variable {P : Type u} {Author : Type v}

/-- Accountable guardianship of one real event: the author's own
responsibility, plus every original X3 obligation for every owed subject.
This is deliberately scoped to the transition, not all actions of an author. -/
def AccountableGuardianAt
    (responsible : Author → ActualState → ActualState → Prop)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P)
    (a : Author) (s t : ActualState) : Prop :=
  responsible a s t ∧ ProtectsAllOwedAtGenesis owed r s t

/-- Completes the nonvacuous, author-responsibility seam without
pretending either added physical premise follows from source evolution.
The creator and the protected owed subject refer to the SAME boundary. -/
theorem conditional_accountable_guardian_creator_at_each_genesis
    (M : Nat) (physical : SourceRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P)
    (authors responsible : Author → ActualState → ActualState → Prop)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical)
    (hIdentity : ∀ s t p, combinedStep M s t → owed s t p →
      IdentityAndProvenance r s t p)
    (hAgency : ∀ s t p, combinedStep M s t → owed s t p →
      AgencyAndFreedom r s t p)
    (hSteward : ∀ s t p, combinedStep M s t → owed s t p →
      RestraintAndMaximality r s t p)
    (hAuthor : ∀ e o U,
      physical ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) →
      ∃ a : Author,
        PhysicallyAuthors authors a
          ((e, M, o), U) ((e + 1, 0, o), objectiveStep U))
    (hResponsible : ∀ a s t,
      PhysicallyAuthors authors a s t → responsible a s t)
    (hOwed : ∀ e o U, ∃ p : P,
      owed ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) p) :
    ∀ e o U, ∃ a : Author,
      physical ((e, M, o), U)
        ((e + 1, 0, o), objectiveStep U) ∧
      PhysicallyAuthors authors a
        ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) ∧
      AccountableGuardianAt responsible owed r a
        ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) ∧
      (∃ p : P,
        owed ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) p ∧
        OriginalSixAt r
          ((e, M, o), U) ((e + 1, 0, o), objectiveStep U) p) := by
  have hBase :=
    conditional_guardian_creator_at_each_genesis
      M physical owed r authors hRef hTotal
      hIdentity hAgency hSteward hAuthor
  intro e o U
  obtain ⟨a, hPhysical, hAuthored, hSix⟩ := hBase e o U
  obtain ⟨p, hp⟩ := hOwed e o U
  exact ⟨a, hPhysical, hAuthored,
    ⟨hResponsible a _ _ hAuthored, hSix⟩,
    ⟨p, hp, hSix p hp⟩⟩

/-- Hostile logical control: a causal-author label alone does NOT
entail accountability. This keeps the independent responsibility premise
visible even where a physical Genesis step is available. -/
theorem authorship_does_not_logically_force_responsibility :
    ∃ (authors responsible : Unit → ActualState → ActualState → Prop),
      (∃ a : Unit,
        PhysicallyAuthors authors a
          ((0, 0, true), ordinaryObjective)
          ((1, 0, true), objectiveStep ordinaryObjective)) ∧
      (¬ ∃ a : Unit, responsible a
          ((0, 0, true), ordinaryObjective)
          ((1, 0, true), objectiveStep ordinaryObjective)) := by
  refine ⟨(fun _ _ _ => True), (fun _ _ _ => False), ?_, ?_⟩
  · exact ⟨(), trivial⟩
  · intro h
    obtain ⟨_, hFalse⟩ := h
    exact hFalse

#print axioms conditional_accountable_guardian_creator_at_each_genesis
#print axioms authorship_does_not_logically_force_responsibility

end PhysicalBridges.GuardianCreatorResponsibilityJoin
