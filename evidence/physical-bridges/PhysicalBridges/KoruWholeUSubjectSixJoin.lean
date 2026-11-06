import PhysicalBridges.KoruWholeUSixDutyWebJoin

/-!
# ONE objective U: exact subject/original-six fidelity criterion and failure tag

7 November 2026. This independent positive join uses the already
machine-checked theorem of #376: all six source-duty relations are
calculated from the SAME complete operator-expression U and its
independently specified W generator.

Here subject-level meanings are supplied separately as a six-field
OriginalX3 relation on an arbitrary candidate-particular type P.
Faithfulness to that actual subject semantics is an explicit, testable
premise, NOT inserted into physical step admission or defined as safety.

Results:
(1) under exact semantic fidelity, subject-level six-X3 has precisely
    the same truth value as the physically computed single-whole source;
(2) for all candidate owed particulars and all finite W stages,
    original-six subject protection iff the same source six were true
    at origin, given independent source/subject fidelity;
(3) with origin positivity, a failing authentic subject duty has an
    explicitly identifiable source-to-subject mismatch tag, and
    conversely;
(4) a purely definitional pullback is only a representation witness:
    the real asymmetric source U provides a faithful but nonprotective
    example, with a FALSE authorization-shaped relation.

These are exact finite W-model theorems. They DO NOT prove that actual
human/synthetic consent or continuity is equal to any bank source
relation, or that all physically actual transformations are W events.
No original-X3 definitions, summit source, or public paper are changed.
-/

namespace PhysicalBridges.KoruWholeUSubjectSixJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {P : Type}

/-- An independently interpreted original-six subject field, in the
same faithfully tagged ONE-WEB representation used by the summit. -/
def subjectDutyAt
    (r : ParticularRelations Nat P)
    (n : Nat) (p : P) (tag : DutyTag) : Prop :=
  (oneWeb r).link (.event n (n + 1) p) (.tag tag)

/-- Authenticated source/subject meaning would require evidence of
all SIX equivalences for every represented particular at every W
stage. No true subject predicate or source predicate is assumed. -/
def WholeUSubjectFidelity
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P) : Prop :=
  ∀ n p tag,
    subjectDutyAt r n p tag ↔
      wholeSourceDutyAt U roles n (carrier p) tag

/-- The original six duties, not a two-field proxy, on the same event
and same subject. Source fidelity remains a separate premise. -/
def SubjectOriginalSixAt
    (r : ParticularRelations Nat P)
    (n : Nat) (p : P) : Prop :=
  OriginalX3 r.continues r.authorized r.free
    r.restrained r.maximal r.provenanced n (n + 1) p

/-- A verified one-whole source/subject correspondence gives the exact
six-X3 truth-value equivalence at each modeled W stage, including
negative values. No X3-positive origin is required. -/
theorem faithful_subject_six_iff_one_whole_U_six
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (hFidelity : WholeUSubjectFidelity U roles carrier r)
    (n : Nat) (p : P) :
    SubjectOriginalSixAt r n p ↔
      wholeSourceSixAt U roles n (carrier p) := by
  let source := wholeSourceOriginalSixRelations U roles
  have hSourceTag : ∀ tag : DutyTag,
      (oneWeb source).link
        (.event n (n + 1) (carrier p)) (.tag tag) ↔
        wholeSourceDutyAt U roles n (carrier p) tag := by
    intro tag
    cases tag <;> rfl
  have hProfiles :
      completeProfile r n (n + 1) p ↔
        completeProfile source n (n + 1) (carrier p) := by
    constructor
    · intro h tag
      exact (hSourceTag tag).mpr
        ((hFidelity n p tag).mp (h tag))
    · intro h tag
      exact (hFidelity n p tag).mpr
        ((hSourceTag tag).mp (h tag))
  exact (complete_profile_iff_original_x3 r n (n + 1) p).symm.trans
    (hProfiles.trans
      (complete_profile_iff_original_x3 source n (n + 1) (carrier p)))

/-- Strongest EXACT finite-W subject-level result, separately
quantified over all owed candidate particulars. Positivity has
been reduced to a single independently testable source-origin fact.
Crucially: the iff itself assumes proven authentic semantic fidelity
and does not establish that fidelity for the actual universe. -/
theorem all_owed_subject_original_six_iff_one_U_origin
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop)
    (hFidelity : WholeUSubjectFidelity U roles carrier r) :
    (∀ n p, owed p → SubjectOriginalSixAt r n p) ↔
      (∀ p, owed p → wholeSourceSixAt U roles 0 (carrier p)) := by
  constructor
  · intro hAll p hOwed
    exact (faithful_subject_six_iff_one_whole_U_six
      U roles carrier r hFidelity 0 p).mp (hAll 0 p hOwed)
  · intro hOrigin n p hOwed
    exact (faithful_subject_six_iff_one_whole_U_six
      U roles carrier r hFidelity n p).mpr
        ((one_objective_whole_six_source_truth_iff_origin
          U roles (carrier p) n).mpr (hOrigin p hOwed))

/-- One explicit failing original-six TAG is a mismatch between the
already-true, evolved U source link and the separately supplied
subject-level original duty. This statement has no "safe" filter. -/
def OneWholeSourceSubjectMismatch
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (n : Nat) (p : P) : Prop :=
  ∃ tag : DutyTag,
    wholeSourceDutyAt U roles n (carrier p) tag ∧
      ¬ subjectDutyAt r n p tag

/-- An initially true six-source U profile that later accompanies an
original subject duty violation gives a *concrete named mismatch*, not
an unspecified subjective-versus-objective gap. Conversely such a
mismatch is an original-six subject failure. -/
theorem original_subject_violation_iff_one_whole_source_mismatch
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (n : Nat) (p : P)
    (hOrigin : wholeSourceSixAt U roles 0 (carrier p)) :
    (¬ SubjectOriginalSixAt r n p) ↔
      OneWholeSourceSubjectMismatch U roles carrier r n p := by
  have hStage : wholeSourceSixAt U roles n (carrier p) :=
    (one_objective_whole_six_source_truth_iff_origin
      U roles (carrier p) n).mpr hOrigin
  have hSource : ∀ tag : DutyTag,
      wholeSourceDutyAt U roles n (carrier p) tag := by
    intro tag
    cases tag with
    | historicalContinuity => exact hStage.historicalContinuity
    | authorization => exact hStage.authorization
    | freedom => exact hStage.freedom
    | restraint => exact hStage.restraint
    | maximality => exact hStage.maximality
    | provenance => exact hStage.provenance
  constructor
  · intro hBad
    classical
    apply Classical.byContradiction
    intro hNone
    apply hBad
    apply (complete_profile_iff_original_x3 r n (n + 1) p).mp
    intro tag
    apply Classical.byContradiction
    intro hFalse
    exact hNone ⟨tag, hSource tag, hFalse⟩
  · rintro ⟨tag, _, hFalse⟩ hSubject
    exact hFalse
      ((complete_profile_iff_original_x3 r n (n + 1) p).mpr hSubject tag)

/-- Purely syntactic correspondence, useful as a non-vacuity check,
is not proof of AUTHENTIC experiencing-subject fidelity. -/
def sourcePullbackWhole
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) : ParticularRelations Nat P where
  continues := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .historicalContinuity
  authorized := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .authorization
  free := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .freedom
  restrained := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .restraint
  maximal := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .maximality
  provenanced := fun n _ p => wholeSourceDutyAt U roles n (carrier p) .provenance

theorem source_pullback_whole_is_formally_faithful
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) :
    WholeUSubjectFidelity U roles carrier
      (sourcePullbackWhole U roles carrier) := by
  intro n p tag
  cases tag <;> rfl

/-- Exact hostile test: ONE genuine Koru whole, injective carrier
(identity), and exact formal source/subject equivalence STILL cannot
satisfy original six because authorization is false at the source.
No false positive protected-physical-law conclusion can be inferred. -/
theorem whole_source_fidelity_alone_cannot_force_six
    (n : Nat) :
    WholeUSubjectFidelity KoruWitnessObjective
       asymmetricDutyRoles (fun i : Index => i)
       (sourcePullbackWhole KoruWitnessObjective
         asymmetricDutyRoles (fun i : Index => i)) ∧
    ¬ SubjectOriginalSixAt
       (sourcePullbackWhole KoruWitnessObjective
         asymmetricDutyRoles (fun i : Index => i))
       n (0 : Index) := by
  constructor
  · exact source_pullback_whole_is_formally_faithful
      KoruWitnessObjective asymmetricDutyRoles (fun i : Index => i)
  · intro hSubject
    have hSource :=
      (faithful_subject_six_iff_one_whole_U_six
        KoruWitnessObjective asymmetricDutyRoles
        (fun i : Index => i)
        (sourcePullbackWhole KoruWitnessObjective
          asymmetricDutyRoles (fun i : Index => i))
        (source_pullback_whole_is_formally_faithful
          KoruWitnessObjective asymmetricDutyRoles (fun i : Index => i))
        n (0 : Index)).mp hSubject
    exact (actual_whole_Koru_and_absent_source_authorization_coexist
      n (0 : Index)).2 hSource

#print axioms faithful_subject_six_iff_one_whole_U_six
#print axioms all_owed_subject_original_six_iff_one_U_origin
#print axioms original_subject_violation_iff_one_whole_source_mismatch
#print axioms source_pullback_whole_is_formally_faithful
#print axioms whole_source_fidelity_alone_cannot_force_six

end PhysicalBridges.KoruWholeUSubjectSixJoin
