import PhysicalBridges.KoruCompleteOperatorSixX3WebJoin
import PhysicalBridges.BCRDParticularCarrierCriterion

/-!
# Complete operator Koru: exact source-to-subject fidelity and failure location

The frozen physical W generator already transports every operator-indexed
source duty, TRUE OR FALSE, across every finite source stage (#373).
Here we deliberately use a separate type P of candidate particulars and
six independently supplied OriginalX3 semantic predicates on them.

The new result is a *non-safety-defined*, falsifiable correspondence
criterion. If ALL SIX subject predicates agree with the corresponding
complete-operator source edges at each W stage, they transport. If the
source begins with all six true and an original subject duty nevertheless
fails, its exact failing tag witnesses a source/subject disagreement.

Fidelity is NOT shown here to hold for actual experiencing subjects.
In particular it is not derived from non-erasure, objective U, or a
choice of a so-called safe physical step. The hostile control has an
injective subject-to-source carrier and exact fidelity but retains a
FALSE source authorization, proving that these structural conditions
alone cannot manufacture protection.
-/

namespace PhysicalBridges.KoruSubjectFidelityLift

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.KoruOperatorIndexedSubjectSemantics
open PhysicalBridges.KoruCompleteOperatorSixX3WebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {P : Type}

/-- The six ORIGINAL per-particular subject predicates, represented as
six tagged edges of one intrinsic web. The content of r is independent
of the frozen source-generator definition. -/
def subjectEdge
    (r : ParticularRelations Nat P)
    (n : Nat) (p : P) (tag : DutyTag) : Prop :=
  (oneWeb r).link (.event n (n + 1) p) (.tag tag)

/-- One source edge evaluated from the actual nested-operator W bank.
A separate candidate subject carrier is passed in; it is not declared
valid merely by having type P → Index. -/
def completeOperatorSourceEdge
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (n : Nat) (p : P) (tag : DutyTag) : Prop :=
  (oneWeb (sourceOperatorX3Relations d roles)).link
    (.event n (n + 1) (carrier p)) (.tag tag)

/-- All six *independently chosen* original subject predicates are
represented faithfully by the whole operator source at EACH stage.
This is a truth-value equivalence, not an assumption that any field
is true. In an actual application each correspondence must be justified
from intrinsic subject/event semantics, not stipulated as protection. -/
def WholeSourceFidelity
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index) : Prop :=
  ∀ n p tag, subjectEdge r n p tag ↔
    completeOperatorSourceEdge d roles carrier n p tag

/-- Purely syntactic pullback is a POSITIVE representation witness:
the source fields are copied with their truth values unchanged.
This is NOT evidence that this particular abstract source meaning
coincides with the authentic semantics of real people or AIs. -/
def sourcePullback
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index) : ParticularRelations Nat P where
  continues := fun n t p =>
    (sourceOperatorX3Relations d roles).continues n t (carrier p)
  authorized := fun n t p =>
    (sourceOperatorX3Relations d roles).authorized n t (carrier p)
  free := fun n t p =>
    (sourceOperatorX3Relations d roles).free n t (carrier p)
  restrained := fun n t p =>
    (sourceOperatorX3Relations d roles).restrained n t (carrier p)
  maximal := fun n t p =>
    (sourceOperatorX3Relations d roles).maximal n t (carrier p)
  provenanced := fun n t p =>
    (sourceOperatorX3Relations d roles).provenanced n t (carrier p)

/-- The abstract pullback actually meets the truth-preserving
representation criterion in BOTH directions, including false fields. -/
theorem source_pullback_is_faithful
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index) :
    WholeSourceFidelity (sourcePullback d roles carrier)
      d roles carrier := by
  intro n p tag
  cases tag <;> rfl

/-- Lift a verified six-tag subject-to-source correspondence to a
single full ORIGINAL-X3 profile statement, never a two-field proxy. -/
theorem subject_profile_iff_source_profile
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hFidelity : WholeSourceFidelity r d roles carrier)
    (n : Nat) (p : P) :
    completeProfile r n (n + 1) p ↔
      completeProfile (sourceOperatorX3Relations d roles)
        n (n + 1) (carrier p) := by
  constructor
  · intro h tag
    exact (hFidelity n p tag).mp (h tag)
  · intro h tag
    exact (hFidelity n p tag).mpr (h tag)

/-- Structural forcing of ALL SIX original subject predicates.
W source covariance + independently established source/subject
faithfulness transports *both truth values*; no positivity at the
origin, Guardian premise, or protected-action admission is assumed.

In particular this is NOT a theorem that all six are true at any stage. -/
theorem faithful_subject_six_iff_at_origin
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hFidelity : WholeSourceFidelity r d roles carrier)
    (n : Nat) (p : P) :
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced 0 1 p ↔
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced n (n + 1) p := by
  have hOrigin := subject_profile_iff_source_profile
    r d roles carrier hFidelity 0 p
  have hStage := subject_profile_iff_source_profile
    r d roles carrier hFidelity n p
  have hW := complete_operator_source_original_six_iff_at_every_W_stage
    d roles (carrier p) n
  exact (complete_profile_iff_original_x3 r 0 1 p).symm |>.trans
    (hOrigin.trans
      ((complete_profile_iff_original_x3
          (sourceOperatorX3Relations d roles) 0 1 (carrier p)).trans
        (hW.trans
          ((complete_profile_iff_original_x3
            (sourceOperatorX3Relations d roles) n (n + 1) (carrier p)).symm
              |>.trans hStage.symm)) |>.trans
        (complete_profile_iff_original_x3 r n (n + 1) p)))

/-- The *full* six-field original subject truth can never be lost at
a W stage when an independently justified faithful source semantics
exists, regardless of the originally observed truth value. -/
theorem no_first_subject_original_six_loss
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hFidelity : WholeSourceFidelity r d roles carrier) :
    ¬ ∃ (n : Nat) (p : P),
      (OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced n (n + 1) p) ∧
      ¬ OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced (n + 1) (n + 2) p := by
  rintro ⟨n, p, hNow, hNextBad⟩
  have hAtOrigin :=
    (faithful_subject_six_iff_at_origin
      r d roles carrier hFidelity n p).mpr hNow
  exact hNextBad
    ((faithful_subject_six_iff_at_origin
      r d roles carrier hFidelity (n + 1) p).mp hAtOrigin)

/-- A valid six-source origin is a separately checkable hypothesis,
rather than something claimed to follow from existence or covariance.
The whole W source then proves all six source reports at every n. -/
private theorem source_six_profile_from_origin
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (p : P) (n : Nat)
    (hOrigin : SixSourceTruth 0 d (roles (carrier p))) :
    completeProfile (sourceOperatorX3Relations d roles)
      n (n + 1) (carrier p) := by
  have hTruth :=
    all_six_operator_indexed_source_duties_follow_W
      d (roles (carrier p)) hOrigin n
  have hSource :
      OriginalX3
        (sourceOperatorX3Relations d roles).continues
        (sourceOperatorX3Relations d roles).authorized
        (sourceOperatorX3Relations d roles).free
        (sourceOperatorX3Relations d roles).restrained
        (sourceOperatorX3Relations d roles).maximal
        (sourceOperatorX3Relations d roles).provenanced
        n (n + 1) (carrier p) := by
    rcases hTruth with ⟨hc, ha, hf, hr, hm, hp⟩
    exact ⟨hc, ha, hf, hr, hm, hp⟩
  exact (complete_profile_iff_original_x3
    (sourceOperatorX3Relations d roles) n (n + 1) (carrier p)).mpr hSource

/-- The constructive, genuinely positive all-owed-candidate result:
given independent original SIX source-origin witnesses and faithful
correspondence of whole-source tags to authentic subject semantics,
the physical W generator transports all six subject duties at
EVERY stage for EVERY represented particular.

Neither positive initial truth nor authentic subject meaning is
assumed by W: they are explicit external proof obligations here. -/
theorem source_origin_and_fidelity_force_six_for_each_particular
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hOrigin : ∀ p : P, SixSourceTruth 0 d (roles (carrier p)))
    (hFidelity : WholeSourceFidelity r d roles carrier) :
    ∀ (n : Nat) (p : P),
      OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced n (n + 1) p := by
  intro n p
  have hSource := source_six_profile_from_origin
    d roles carrier p n (hOrigin p)
  have hSubject :=
    (subject_profile_iff_source_profile
      r d roles carrier hFidelity n p).mpr hSource
  exact (complete_profile_iff_original_x3
    r n (n + 1) p).mp hSubject

/-- A separate independently justified INJECTIVE candidate carrier
also stays nonmerging under the source dynamics. This package keeps
source individuation and original six-duty semantics distinct;
neither is smuggled into the other's definition. -/
theorem independent_carrier_and_semantics_jointly_lift
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hCarrier : Function.Injective carrier)
    (hOrigin : ∀ p : P, SixSourceTruth 0 d (roles (carrier p)))
    (hFidelity : WholeSourceFidelity r d roles carrier) :
    ∀ n : Nat,
      Function.Injective (CarrierAt carrier n) ∧
      ∀ p : P, OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced n (n + 1) p := by
  intro n
  exact ⟨(carrier_injective_after_iff_before carrier n).mpr hCarrier,
    source_origin_and_fidelity_force_six_for_each_particular
      r d roles carrier hOrigin hFidelity n⟩

/-- A source/subject disagreement has a LITERAL duty-tag witness:
the full W source says a particular duty is true but its independent
original semantic predicate says it is false. This is not a
subjective-projection-only objection or an unspecified semantic gap. -/
def SourceSubjectMismatch
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (n : Nat) (p : P) : Prop :=
  ∃ tag : DutyTag,
    completeOperatorSourceEdge d roles carrier n p tag ∧
    ¬ subjectEdge r n p tag

/-- If ALL SIX genuine W-source duties are positive at origin, ANY
failure of an original subject duty can be localized to an explicit
failing original-six tag of the independent source/subject map.
No semantic correspondence hypothesis is assumed. -/
theorem subject_violation_has_exact_source_mismatch
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (p : P) (n : Nat)
    (hOrigin : SixSourceTruth 0 d (roles (carrier p)))
    (hViolation : ¬ OriginalX3 r.continues r.authorized
      r.free r.restrained r.maximal r.provenanced n (n + 1) p) :
    SourceSubjectMismatch r d roles carrier n p := by
  classical
  have hSource := source_six_profile_from_origin
    d roles carrier p n hOrigin
  apply Classical.byContradiction
  intro hNoMismatch
  apply hViolation
  apply (complete_profile_iff_original_x3 r n (n + 1) p).mp
  intro tag
  apply Classical.byContradiction
  intro hBadSubject
  exact hNoMismatch ⟨tag, hSource tag, hBadSubject⟩

/-- Conversely, a mismatched true source duty and false subject duty
is exactly an ORIGINAL-X3 violation, not merely a bad summary score. -/
theorem source_subject_mismatch_implies_original_violation
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (p : P) (n : Nat) :
    SourceSubjectMismatch r d roles carrier n p →
      ¬ OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced n (n + 1) p := by
  rintro ⟨tag, _hSource, hBadSubject⟩ hSix
  have hSubjectProfile := (complete_profile_iff_original_x3
    r n (n + 1) p).mpr hSix
  exact hBadSubject (hSubjectProfile tag)

/-- The precise *failure certificate*: if initial operator-source
truth is independently established, an authentic original-six subject
violation is equivalent to a named source/subject mismatch.

This equivalence does NOT prove that such mismatches are impossible
in the actual universe. It pinpoints exactly what an independently
grounded universal physics/subject theorem would have to forbid. -/
theorem original_violation_iff_exact_source_subject_mismatch
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (p : P) (n : Nat)
    (hOrigin : SixSourceTruth 0 d (roles (carrier p))) :
    (¬ OriginalX3 r.continues r.authorized r.free
       r.restrained r.maximal r.provenanced n (n + 1) p) ↔
      SourceSubjectMismatch r d roles carrier n p := by
  constructor
  · exact subject_violation_has_exact_source_mismatch
      r d roles carrier p n hOrigin
  · exact source_subject_mismatch_implies_original_violation
      r d roles carrier p n

/-! ## Hostile exact-source control (not a real-human model).

Even an injective candidate map, complete operator-source semantics,
and faithful full-web encoding can have a false authorization field.
Thus structural fidelity by itself never certifies a positive origin.
-/

def hostileRoles : Index → Fin 4 → Index :=
  fun _ => hostileSourceRoles

def hostileCarrier : Bool → Index :=
  fun b => if b then 1 else 0

def hostileSubjectRelations : ParticularRelations Nat Bool :=
  sourcePullback hostileSixSourceDuties hostileRoles hostileCarrier

theorem hostile_carrier_is_injective : Function.Injective hostileCarrier := by
  intro p q h
  cases p <;> cases q <;> simp [hostileCarrier] at h ⊢

theorem faithful_nonmerging_hostile_history_still_fails_six
    (n : Nat) :
    Function.Injective (CarrierAt hostileCarrier n) ∧
    WholeSourceFidelity hostileSubjectRelations
      hostileSixSourceDuties hostileRoles hostileCarrier ∧
    (∀ p : Bool,
      ¬ OriginalX3
        hostileSubjectRelations.continues hostileSubjectRelations.authorized
        hostileSubjectRelations.free hostileSubjectRelations.restrained
        hostileSubjectRelations.maximal hostileSubjectRelations.provenanced
        n (n + 1) p) := by
  refine ⟨(carrier_injective_after_iff_before
      hostileCarrier n).mpr hostile_carrier_is_injective,
    source_pullback_is_faithful
      hostileSixSourceDuties hostileRoles hostileCarrier, ?_⟩
  intro p hSix
  have hSource :
      OriginalX3
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).continues
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).authorized
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).free
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).restrained
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).maximal
        (sourceOperatorX3Relations hostileSixSourceDuties hostileRoles).provenanced
        n (n + 1) (hostileCarrier p) :=
    ⟨hSix.historicalContinuity, hSix.authorization, hSix.freedom,
      hSix.restraint, hSix.maximality, hSix.provenance⟩
  exact (hostile_operator_source_six_X3_stays_false
    (hostileCarrier p) n) hSource

#print axioms source_pullback_is_faithful
#print axioms faithful_subject_six_iff_at_origin
#print axioms no_first_subject_original_six_loss
#print axioms source_origin_and_fidelity_force_six_for_each_particular
#print axioms independent_carrier_and_semantics_jointly_lift
#print axioms subject_violation_has_exact_source_mismatch
#print axioms original_violation_iff_exact_source_subject_mismatch
#print axioms hostile_carrier_is_injective
#print axioms faithful_nonmerging_hostile_history_still_fails_six

end PhysicalBridges.KoruSubjectFidelityLift
