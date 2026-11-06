import PhysicalBridges.KoruWholeUSubjectSixJoin

/-!
# Original summit keystone stress test: SIX positive source duties in ONE complete U

7 November 2026. A stronger first-violation test than an isolated Boolean
relation countermodel, specifically against the independent full-operator-
expression objective U of KoruObjectiveWholeU (merged #376 / #380).

Positive result: exhibit ONE physical W objective source with a nontrivial
Koru distinction, with six DISTINCT intrinsic source-link questions per
particular, each true at origin and hence at EVERY source stage. The
actual finite W evolution itself carries every link; no safe-action
policy or protection premise appears in its evolution.

Independent semantic test: the same fully positive physical source
coexists logically with separately interpreted six-field ORIGINAL-X3
subject predicates lacking authorization, unless a source-to-subject
semantic fidelity law is additionally established. The exact tag of
the mismatch can be produced by the already-merged #380 theorem.

Scope is deliberate: subject interpretation is unconstrained here.
This is NOT a physically feasible harmful human/AI BCRD event, NOT a
refutation of the author's stronger complete objective ontology, and
NOT an identification of source matrix links with actual consent.
It tests whether the CURRENT one-U source theorems, unaided, have
proved the historical keystone (they have not). The next candidate
must independently prove the authentic semantic correspondence,
actual source applicability, and initial positive protection.
No original summit/X3/cosmology files are modified.
-/

namespace PhysicalBridges.OriginalKeystonePositiveWholeTest

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.Koru

/-- The six duties select six DIFFERENT positions in the original
whole, rotated by the subject position. These are six different
internal source questions, not six external true/safe Boolean bits. -/
def dutyOffset : DutyTag → Nat
  | .historicalContinuity => 0
  | .authorization => 1
  | .freedom => 2
  | .restraint => 3
  | .maximality => 4
  | .provenance => 5

def dutySlot (p : Index) (tag : DutyTag) : Index :=
  ⟨(p.val + dutyOffset tag) % 6, Nat.mod_lt _ (by decide)⟩

def sixDiagonalRoles : SourceDutyRoles :=
  fun p tag => (dutySlot p tag, dutySlot p tag)

/-- Every position of ONE whole contains the full identity operator.
Its internal operator relation has six diagonal links and genuinely
distinguishes different positions; it is NOT a chosen safe transition. -/
def positiveWholeU : FiniteObjectiveU :=
  fun _ => .atom identityMatrix

/-- Every one of six independently selected physical-source questions
is initially true for EVERY source particular, with no initial-X3
assumption, because each sampled identity-operator diagonal is nonzero. -/
theorem all_six_tagged_source_facts_are_positive_at_origin :
    ∀ p : Index, ∀ tag : DutyTag,
      wholeSourceDutyAt positiveWholeU sixDiagonalRoles 0 p tag := by
  change ∀ p : Index, ∀ tag : DutyTag,
    identityMatrix (dutySlot p tag) (dutySlot p tag) ≠ 0
  decide

/-- Source positivity on all six slots entails the unchanged six-field
OriginalX3 SHAPE, strictly at the physical-source meaning. -/
theorem all_six_source_fields_true_at_origin (p : Index) :
    wholeSourceSixAt positiveWholeU sixDiagonalRoles 0 p := by
  exact ⟨all_six_tagged_source_facts_are_positive_at_origin p .historicalContinuity,
    all_six_tagged_source_facts_are_positive_at_origin p .authorization,
    all_six_tagged_source_facts_are_positive_at_origin p .freedom,
    all_six_tagged_source_facts_are_positive_at_origin p .restraint,
    all_six_tagged_source_facts_are_positive_at_origin p .maximality,
    all_six_tagged_source_facts_are_positive_at_origin p .provenance⟩

/-- The independently specified physical W generator transports
these six POSITIVE source truths for ALL source particulars forever
in the model. No first false source duty is possible in this world. -/
theorem positive_source_six_for_every_position_and_stage
    (n : Nat) (p : Index) :
    wholeSourceSixAt positiveWholeU sixDiagonalRoles n p := by
  exact (one_objective_whole_six_source_truth_iff_origin
    positiveWholeU sixDiagonalRoles p n).mpr
      (all_six_source_fields_true_at_origin p)

/-- The same physically specified source genuinely has the Koru's
nontrivial internal distinction (not simply a nonempty set). -/
theorem positive_source_has_genuine_Koru :
    koru (sourceWholeWeb positiveWholeU) 2 3 := by
  refine ⟨by decide, 2, ?_⟩
  change
    ((identityMatrix (2 : Index) 2 ≠ 0) : Prop) ≠
      ((identityMatrix (3 : Index) 2 ≠ 0) : Prop)
  intro h
  have hYes : identityMatrix (2 : Index) 2 ≠ 0 := by decide
  have hNo : ¬ (identityMatrix (3 : Index) 2 ≠ 0) := by decide
  rw [h] at hYes
  exact hNo hYes

/-- Genuine articulated Koru and ALL six independently sourced
positive duty fields coexist at EVERY physical W stage. -/
theorem positive_whole_Koru_and_all_six_source_duties
    (n : Nat) :
    koru (sourceWholeWeb (objectiveAt positiveWholeU n))
      (trackedPosition 2 n) (trackedPosition 3 n) ∧
    ∀ p : Index, wholeSourceSixAt positiveWholeU sixDiagonalRoles n p := by
  exact ⟨(objective_Koru_is_exact_under_W
      positiveWholeU 2 3 n).mpr positive_source_has_genuine_Koru,
    positive_source_six_for_every_position_and_stage n⟩

/-- The original duties are NOT defined as the source entries: they
can be independently interpreted. This interpretation has five
positive fields but false authorization; it serves only as a
semantic-independence control, not a claim about actual people. -/
def independentNoAuthorization : ParticularRelations Nat Index where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

theorem independent_subject_six_fails_authorization
    (n : Nat) (p : Index) :
    ¬ SubjectOriginalSixAt independentNoAuthorization n p := by
  intro h
  exact h.authorization

/-- Every true six-duty positive source profile has a named source-to-
subject mismatch in this independently interpreted scenario. This is
the exact obligation the original summit's proposed whole-to-subject
inversion must prove impossible for ACTUAL subjects and actual physics. -/
theorem precise_authorization_mismatch_of_positive_whole
    (n : Nat) (p : Index) :
    OneWholeSourceSubjectMismatch
      positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization n p := by
  exact (original_subject_violation_iff_one_whole_source_mismatch
      positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization n p
      (all_six_source_fields_true_at_origin p)).mp
    (independent_subject_six_fails_authorization n p)

/-- The strongest finite one-U physical facts CURRENTLY on main
do not entail all six duties for an independently interpreted
unconstrained subject relation. The burden is authentic correspondence;
the positive physical source itself is sound and nontrivial. -/
theorem positive_complete_source_does_not_force_unconstrained_subject_six :
    (∀ n p, wholeSourceSixAt positiveWholeU sixDiagonalRoles n p) ∧
    koru (sourceWholeWeb positiveWholeU) 2 3 ∧
    (∀ n p, ¬ SubjectOriginalSixAt independentNoAuthorization n p) := by
  exact ⟨positive_source_six_for_every_position_and_stage,
    positive_source_has_genuine_Koru,
    independent_subject_six_fails_authorization⟩

/-- Even with exact source positivity, a complete U does not supply a
fidelity proof for every arbitrary subject interpretation by itself.
This is an exact, non-vacuous theorem about the current source model,
not a final verdict on the author's richer physical ontology. -/
theorem whole_source_fidelity_is_not_automatic_for_arbitrary_semantics :
    ¬ WholeUSubjectFidelity positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization := by
  intro hFidelity
  have hOrigin : ∀ p : Index, True →
      wholeSourceSixAt positiveWholeU sixDiagonalRoles 0 p :=
    fun p _ => all_six_source_fields_true_at_origin p
  have hAll :=
    (all_owed_subject_original_six_iff_one_U_origin
      positiveWholeU sixDiagonalRoles
      (fun i : Index => i) independentNoAuthorization
      (fun _ => True) hFidelity).mpr hOrigin
  exact (independent_subject_six_fails_authorization 0 0) (hAll 0 0 trivial)

#print axioms all_six_tagged_source_facts_are_positive_at_origin
#print axioms positive_source_six_for_every_position_and_stage
#print axioms positive_source_has_genuine_Koru
#print axioms positive_whole_Koru_and_all_six_source_duties
#print axioms precise_authorization_mismatch_of_positive_whole
#print axioms positive_complete_source_does_not_force_unconstrained_subject_six
#print axioms whole_source_fidelity_is_not_automatic_for_arbitrary_semantics

end PhysicalBridges.OriginalKeystonePositiveWholeTest
