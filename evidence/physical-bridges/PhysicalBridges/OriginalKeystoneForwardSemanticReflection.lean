import PhysicalBridges.OriginalKeystonePositiveWholeTest

/-!
# Original summit: exact minimal forward semantic reflection

The complete objective W source from #376 and the six-positive whole
from #386 preserve independently computed SOURCE relations. Their
positive status does not automatically imply authentic subject facts.

This module proves that source -> subject forward reflection (rather
than the unnecessarily stronger two-way semantic fidelity) is the
exact necessary-and-sufficient missing assumption for six-X3 protection
when the physical source origin is independently six-positive.
It explicitly does NOT derive this reflection from physical W/Koru.
Countercontrols prove it is strictly weaker than full two-way fidelity
and is not automatic even in the six-positive complete source model.

No original six-X3 field, physical dynamics, summit source, or
physical admissibility definition is changed. Theorems concern finite W.
-/

namespace PhysicalBridges.OriginalKeystoneForwardSemanticReflection

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {P : Type}

/-- The one-way physical source to independently interpreted subject
truth-transfer that suffices for actual six-X3 when source is positive. -/
def ForwardSemanticReflection
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop) : Prop :=
  ∀ n p, owed p →
    ∀ tag : DutyTag,
      wholeSourceDutyAt U roles n (carrier p) tag →
        subjectDutyAt r n p tag

/-- Unchanged original-six semantic conjunction is exactly six tags. -/
theorem subject_six_iff_all_six_tags
    (r : ParticularRelations Nat P) (n : Nat) (p : P) :
    SubjectOriginalSixAt r n p ↔
      ∀ tag : DutyTag, subjectDutyAt r n p tag := by
  constructor
  · intro h tag
    cases tag with
    | historicalContinuity => exact h.historicalContinuity
    | authorization => exact h.authorization
    | freedom => exact h.freedom
    | restraint => exact h.restraint
    | maximality => exact h.maximality
    | provenance => exact h.provenance
  · intro h
    exact ⟨h .historicalContinuity, h .authorization,
      h .freedom, h .restraint, h .maximality, h .provenance⟩

/-- Forward reflection exactly prohibits a positive-source/
negative-subject tag mismatch for every represented owed particular. -/
theorem forward_reflection_iff_no_source_subject_mismatch
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop) :
    ForwardSemanticReflection U roles carrier r owed ↔
      ∀ n p, owed p →
        ¬ OneWholeSourceSubjectMismatch U roles carrier r n p := by
  classical
  constructor
  · intro h n p hp
    rintro ⟨tag, hSource, hNotSubject⟩
    exact hNotSubject (h n p hp tag hSource)
  · intro h n p hp tag hSource
    apply Classical.byContradiction
    intro hNotSubject
    exact (h n p hp) ⟨tag, hSource, hNotSubject⟩

/-- Six independently positive SOURCE facts at the physical origin. -/
def PositiveSourceOrigin
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (owed : P → Prop) : Prop :=
  ∀ p, owed p → wholeSourceSixAt U roles 0 (carrier p)

/-- Actual W-source evolution transports every positive origin tag. -/
theorem positive_origin_transports_every_six_source_field
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (owed : P → Prop)
    (hOrigin : PositiveSourceOrigin U roles carrier owed)
    (n : Nat) (p : P) (hp : owed p) (tag : DutyTag) :
    wholeSourceDutyAt U roles n (carrier p) tag := by
  have hSix : wholeSourceSixAt U roles n (carrier p) :=
    (one_objective_whole_six_source_truth_iff_origin
      U roles (carrier p) n).mpr (hOrigin p hp)
  cases tag with
  | historicalContinuity => exact hSix.historicalContinuity
  | authorization => exact hSix.authorization
  | freedom => exact hSix.freedom
  | restraint => exact hSix.restraint
  | maximality => exact hSix.maximality
  | provenance => exact hSix.provenance

/-- Precise summit obligation, without redefining any original X3:
with positive source origin, one-way semantic reflection is EQUIVALENT
to universal original-six protection in this W source model.
This equivalence is not a discharge of the semantic premise. -/
theorem all_owed_original_six_iff_forward_reflection
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop)
    (hOrigin : PositiveSourceOrigin U roles carrier owed) :
    (∀ n p, owed p → SubjectOriginalSixAt r n p) ↔
      ForwardSemanticReflection U roles carrier r owed := by
  constructor
  · intro hAll n p hp tag _
    exact (subject_six_iff_all_six_tags r n p).mp (hAll n p hp) tag
  · intro hForward n p hp
    apply (subject_six_iff_all_six_tags r n p).mpr
    intro tag
    exact hForward n p hp tag
      (positive_origin_transports_every_six_source_field
        U roles carrier owed hOrigin n p hp tag)

/-- Any first original-six violation after positive physical-source
origin is exactly a real source/subject mismatch on one of six tags. -/
theorem first_original_six_violation_iff_source_subject_mismatch
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop)
    (hOrigin : PositiveSourceOrigin U roles carrier owed) :
    (∃ n p, owed p ∧ ¬ SubjectOriginalSixAt r n p) ↔
      (∃ n p, owed p ∧
        OneWholeSourceSubjectMismatch U roles carrier r n p) := by
  constructor
  · rintro ⟨n, p, hp, hBad⟩
    exact ⟨n, p, hp,
      (original_subject_violation_iff_one_whole_source_mismatch
        U roles carrier r n p (hOrigin p hp)).mp hBad⟩
  · rintro ⟨n, p, hp, hMismatch⟩
    exact ⟨n, p, hp,
      (original_subject_violation_iff_one_whole_source_mismatch
        U roles carrier r n p (hOrigin p hp)).mpr hMismatch⟩

/-- Two-way source/subject fidelity implies the strictly weaker
one-way physical-to-subject claim needed for protection. -/
theorem whole_fidelity_implies_forward_reflection
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop)
    (hFidelity : WholeUSubjectFidelity U roles carrier r) :
    ForwardSemanticReflection U roles carrier r owed := by
  intro n p _ tag hSource
  exact (hFidelity n p tag).mpr hSource

/-- Logical negative control, not an authenticated real subject. -/
def allTrueCandidate : ParticularRelations Nat Index where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => True
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

/-- Strictness: one-way holds but full two-way fidelity fails for
a real asymmetric W-source whole with an authorization-shaped
source link that is false. -/
theorem forward_reflection_is_strictly_weaker_than_whole_fidelity :
    ForwardSemanticReflection KoruWitnessObjective asymmetricDutyRoles
      (fun i : Index => i) allTrueCandidate (fun _ => True) ∧
    ¬ WholeUSubjectFidelity KoruWitnessObjective asymmetricDutyRoles
      (fun i : Index => i) allTrueCandidate := by
  constructor
  · intro n p _ tag _
    cases tag <;> trivial
  · intro hFidelity
    have hSubject :
        subjectDutyAt allTrueCandidate 0 (0 : Index) .authorization := trivial
    have hSource :=
      (hFidelity 0 (0 : Index) .authorization).mp hSubject
    exact (same_whole_has_positive_link_but_no_reverse 0 (0 : Index)).2 hSource

/-- The positive six-source whole cannot by itself establish the
additional one-way reflection for arbitrary subject semantics. -/
theorem positive_whole_without_authentic_forward_reflection :
    ¬ ForwardSemanticReflection positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization
      (fun _ => True) := by
  intro hForward
  have hSource :
      wholeSourceDutyAt positiveWholeU sixDiagonalRoles
        0 (0 : Index) .authorization :=
    all_six_tagged_source_facts_are_positive_at_origin
      (0 : Index) .authorization
  have hSubject :=
    hForward 0 (0 : Index) trivial .authorization hSource
  exact hSubject

#print axioms subject_six_iff_all_six_tags
#print axioms forward_reflection_iff_no_source_subject_mismatch
#print axioms positive_origin_transports_every_six_source_field
#print axioms all_owed_original_six_iff_forward_reflection
#print axioms first_original_six_violation_iff_source_subject_mismatch
#print axioms whole_fidelity_implies_forward_reflection
#print axioms forward_reflection_is_strictly_weaker_than_whole_fidelity
#print axioms positive_whole_without_authentic_forward_reflection

end PhysicalBridges.OriginalKeystoneForwardSemanticReflection
