import PhysicalBridges.EverestActualWEventJoin
import PhysicalBridges.BCRDWitnessedSourceRefinement

/-!
# Exact remaining Q.E.D. gates — assembly of existing source results

7 November 2026. No new physics, no changed Koru, no revised X3.

The positive complete-source W witness already proves SIX source duty facts at
origin, for every source position. The old three-way failure-localization
theorem can therefore be strengthened FOR THIS CONCRETE SOURCE to an exact
TWO-way gate:

An independently actual original-six violation means either
(1) full W event coverage is false, or (2) the authentic physical-to-subject
forward reflection is false. The positive origin branch is impossible.

Separate existing hostile controls show why *both* premises need independent
evidence: a source-valid path can exist with no real-world execution, and six
positive source fields can coexist with a different independent subject
interpretation. These are abstract independence tests, NOT demonstrated actual
harmful human/AI events or disproofs of any richer physical ontology.

No source theorem is strengthened by name only; every premise is displayed.
-/

namespace PhysicalBridges.PhysicalSemanticLastMileGates

open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.BCRDWitnessedSourceRefinement
open PhysicalBridges.BCRDValidatedCausalLog

/-- When source positivity is already derived from the source operator,
the ONLY remaining independent obligations are complete physical-event
coverage and authentic forward reflection. A physical original-six violation
refutes at least one of those two, not a third unfounded 'origin' claim. -/
theorem any_real_original_six_violation_refutes_coverage_or_reflection
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p)
    (hViolation : ¬ OriginalX3 r.continues r.authorized r.free
      r.restrained r.maximal r.provenanced s t p) :
    ¬ CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU ∨
    ¬ ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed := by
  have hThree :=
    physical_violation_refutes_a_named_join
      physicalStep modeledStep source stage positiveWholeU
      sixDiagonalRoles carrier r owed
      s t hPhysical p hOwed hViolation
  rcases hThree with hCoverage | hOrigin | hReflection
  · exact Or.inl hCoverage
  · have hPositive :
        PositiveSourceOrigin positiveWholeU sixDiagonalRoles carrier owed :=
      fun p _ => all_six_source_fields_true_at_origin (carrier p)
    exact False.elim (hOrigin hPositive)
  · exact Or.inr hReflection

/-- A model-valid path does not, even logically, establish actual
execution; positive W-source truth does not itself fix an independently
supplied subject interpretation. Neither control is claimed to be a
physically realized counterexample to the full author's ontology. -/
theorem the_two_last_mile_gates_are_independent_of_source_formalism :
    (VerifiedSourcePath 2 [(2, 3)] 3 ∧
      ¬ WitnessedTrace noPhysicalWorldStep identityReadout
        2 [(2, 3)] 3) ∧
    ¬ ForwardSemanticReflection positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization
      (fun _ => True) := by
  exact ⟨model_source_validity_is_strictly_weaker_than_execution,
    positive_whole_without_authentic_forward_reflection⟩

/-- Positive completion route under the two individually stated obligations.
All six original-X3 fields and exact W advancement on every relevant
physical event follow. No prior premise asserts OriginalX3 directly. -/
theorem complete_coverage_and_authentic_reflection_force_original_six
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p) :
    source t = objectiveStep (source s) ∧
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced s t p :=
  positive_W_actual_event_six_requires_only_coverage_and_reflection
    physicalStep modeledStep source stage carrier r owed
    hCoverage hReflection s t hPhysical p hOwed

#print axioms any_real_original_six_violation_refutes_coverage_or_reflection
#print axioms the_two_last_mile_gates_are_independent_of_source_formalism
#print axioms complete_coverage_and_authentic_reflection_force_original_six

end PhysicalBridges.PhysicalSemanticLastMileGates
