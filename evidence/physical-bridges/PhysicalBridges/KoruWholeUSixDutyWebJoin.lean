import PhysicalBridges.KoruObjectiveWholeU
import PhysicalBridges.KoruSixOriginalRelationsOneWeb

/-!
# One physically sourced objective U: six internal duties without six external report bits

7 November 2026; additive complete-Koru source result.

This uses ONE complete six-position operator-expression object U, with
independently fixed W evolution from KoruObjectiveWholeU. Every one of the
six tagged original-X3-shaped SOURCE relations is evaluated directly
from that SAME objective whole's operator-derived relational web. A
duty-specific pair of source positions selects an internal question; it
does not supply the answer, an authorization Boolean, a guardian label,
or an allowed-action definition.

The six fields feed unchanged OriginalX3Full.OriginalX3 and the faithful
KoruSixOriginalRelationsOneWeb encoding. Exact W carriage of the whole
operator web gives bidirectional preservation for every tagged duty,
its complete six-field profile, and ALL owed source positions. A
nontrivial asymmetric operator witness shows positive relation and
negative authorization-style relation can coexist in the same U; W
does not manufacture consent from nonemptiness or source preservation.

Scope: these six fields have original-X3 SHAPE but SOURCE meaning.
Position pairs are not authenticated human/synthetic particular
histories; an intrinsic source link is not automatically actual consent.
This is not the independent universal physical/subject correspondence
required by HillaryRouteABSummit for actual UPT. Nothing here asserts
all actual physical evolution is the finite frozen W bank.
-/

namespace PhysicalBridges.KoruWholeUSixDutyWebJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.Koru
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

/-- Source locations for all six duty questions, at every source
particular. These select which genuine internal links to inspect; they
do not stipulate whether the links hold. -/
abbrev SourceDutyRoles := Index → DutyTag → Index × Index

/-- Every answer is calculated from ONE objective, nested-operator
expression U, after n actual modeled W microsteps. The two question
positions are both transported by the same independent source law. -/
def wholeSourceDutyAt
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (n : Nat) (p : Index) (tag : DutyTag) : Prop :=
  (sourceWholeWeb (objectiveAt U n)).link
    (trackedPosition ((roles p tag).1) n)
    (trackedPosition ((roles p tag).2) n)

/-- Exact preservation AND reflection of every SOURCE link, even if
initially false. Follows from the one objective U whole, not from
per-duty chosen truth labels or the requirement to protect anything. -/
theorem each_whole_U_source_duty_is_exact
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (p : Index) (tag : DutyTag) (n : Nat) :
    wholeSourceDutyAt U roles n p tag ↔
      wholeSourceDutyAt U roles 0 p tag := by
  change
    (sourceWholeWeb (objectiveAt U n)).link
        (trackedPosition ((roles p tag).1) n)
        (trackedPosition ((roles p tag).2) n) ↔
      (sourceWholeWeb U).link (roles p tag).1 (roles p tag).2
  exact complete_objective_link_carriage U
    (roles p tag).1 (roles p tag).2 n

/-- Faithful six-fold source interpretation of the UNCHANGED
OriginalX3 type. All relations use the same original U and exactly
the physically evolved source operator family. -/
def wholeSourceOriginalSixRelations
    (U : FiniteObjectiveU) (roles : SourceDutyRoles) :
    ParticularRelations Nat Index where
  continues := fun n _ p => wholeSourceDutyAt U roles n p .historicalContinuity
  authorized := fun n _ p => wholeSourceDutyAt U roles n p .authorization
  free := fun n _ p => wholeSourceDutyAt U roles n p .freedom
  restrained := fun n _ p => wholeSourceDutyAt U roles n p .restraint
  maximal := fun n _ p => wholeSourceDutyAt U roles n p .maximality
  provenanced := fun n _ p => wholeSourceDutyAt U roles n p .provenance

/-- The exact six-component original-X3 structural type on one source
transition for one source position. This is NOT authentic physical X3. -/
def wholeSourceSixAt
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (n : Nat) (p : Index) : Prop :=
  let r := wholeSourceOriginalSixRelations U roles
  OriginalX3 r.continues r.authorized r.free
    r.restrained r.maximal r.provenanced n (n + 1) p

/-- A complete original-six profile in one tagged source web is
equivalent across EVERY frozen-W stage to the full profile at origin.
No initial positive six-profile, selected action policy, or E/G
protection premise is assumed. -/
theorem one_objective_whole_six_source_truth_iff_origin
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (p : Index) (n : Nat) :
    wholeSourceSixAt U roles n p ↔
      wholeSourceSixAt U roles 0 p := by
  let r := wholeSourceOriginalSixRelations U roles
  have hTagNow : ∀ tag : DutyTag,
      (oneWeb r).link (.event n (n + 1) p) (.tag tag) ↔
        wholeSourceDutyAt U roles n p tag := by
    intro tag
    cases tag <;> rfl
  have hTagOrigin : ∀ tag : DutyTag,
      (oneWeb r).link (.event 0 1 p) (.tag tag) ↔
        wholeSourceDutyAt U roles 0 p tag := by
    intro tag
    cases tag <;> rfl
  have hProfile :
      completeProfile r n (n + 1) p ↔ completeProfile r 0 1 p := by
    constructor
    · intro h tag
      exact (hTagOrigin tag).mpr
        ((each_whole_U_source_duty_is_exact U roles p tag n).mp
          ((hTagNow tag).mp (h tag)))
    · intro h tag
      exact (hTagNow tag).mpr
        ((each_whole_U_source_duty_is_exact U roles p tag n).mpr
          ((hTagOrigin tag).mp (h tag)))
  exact
    (complete_profile_iff_original_x3 r n (n + 1) p).symm.trans
      (hProfile.trans (complete_profile_iff_original_x3 r 0 1 p))

/-- ALL owed source positions share the exact source result; no
particular was selected in advance, but owedness here is still a
modeled source relation, not a census of actual experiencing minds. -/
def AllOwedWholeSourceSix
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (owed : Index → Prop) (n : Nat) : Prop :=
  ∀ p, owed p → wholeSourceSixAt U roles n p

theorem all_owed_whole_U_six_source_truth_iff_origin
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (owed : Index → Prop) (n : Nat) :
    AllOwedWholeSourceSix U roles owed n ↔
      AllOwedWholeSourceSix U roles owed 0 := by
  constructor
  · intro h p hp
    exact (one_objective_whole_six_source_truth_iff_origin
      U roles p n).mp (h p hp)
  · intro h p hp
    exact (one_objective_whole_six_source_truth_iff_origin
      U roles p n).mpr (h p hp)

/-- NO first physical-W source loss of a complete previously true
original-six profile, for any owed SOURCE particular; no 'safe'
transition relation is used to prove this. -/
theorem no_first_whole_U_six_source_profile_loss
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (owed : Index → Prop) :
    ¬ ∃ n p, owed p ∧ wholeSourceSixAt U roles n p ∧
        ¬ wholeSourceSixAt U roles (n + 1) p := by
  rintro ⟨n, p, hp, hNow, hBad⟩
  have hOrigin :=
    (one_objective_whole_six_source_truth_iff_origin
      U roles p n).mp hNow
  exact hBad
    ((one_objective_whole_six_source_truth_iff_origin
      U roles p (n + 1)).mpr hOrigin)

/-- Six NON-IDENTICAL, genuine source questions can be asked of the
same whole. Here five test the real M0->M1 matrix-unit edge while
authorization tests its distinct reverse edge. Nothing labels either
answer as allowed or safe in advance. -/
def asymmetricDutyRoles : SourceDutyRoles :=
  fun _ tag =>
    if tag = .authorization then
      ((3 : Index), (2 : Index))
    else
      ((2 : Index), (3 : Index))

/-- Concrete material asymmetry: actual operator-derived source edge
is present, its distinct reverse edge absent. This is a nontrivial
complete-object U witness, not six separately chosen Booleans. -/
theorem same_whole_has_positive_link_but_no_reverse
    (n : Nat) (p : Index) :
    wholeSourceDutyAt KoruWitnessObjective asymmetricDutyRoles
        n p .historicalContinuity ∧
    ¬ wholeSourceDutyAt KoruWitnessObjective asymmetricDutyRoles
        n p .authorization := by
  have hPositive :
      wholeSourceDutyAt KoruWitnessObjective asymmetricDutyRoles
        0 p .historicalContinuity := by
    change matrixUnit (2 : Index) 3 2 3 ≠ 0
    decide
  have hNegative :
      ¬ wholeSourceDutyAt KoruWitnessObjective asymmetricDutyRoles
        0 p .authorization := by
    change ¬ (matrixUnit (2 : Index) 3 3 2 ≠ 0)
    decide
  exact ⟨(each_whole_U_source_duty_is_exact
      KoruWitnessObjective asymmetricDutyRoles p
      .historicalContinuity n).mpr hPositive,
    fun h => hNegative
      ((each_whole_U_source_duty_is_exact
        KoruWitnessObjective asymmetricDutyRoles p
        .authorization n).mp h)⟩

/-- This genuinely source-derived, distinguished Koru whole DOES NOT
forge the missing authorization-style relation by W evolution.
Conservation of a complete truth cannot independently make it true. -/
theorem actual_whole_Koru_and_absent_source_authorization_coexist
    (n : Nat) (p : Index) :
    koru (sourceWholeWeb (objectiveAt KoruWitnessObjective n))
      (trackedPosition 2 n) (trackedPosition 3 n) ∧
    ¬ wholeSourceSixAt KoruWitnessObjective asymmetricDutyRoles n p := by
  constructor
  · exact genuine_Koru_distinction_survives_entire_W_history n
  · intro hX3
    have hAuth : wholeSourceDutyAt KoruWitnessObjective asymmetricDutyRoles
        n p .authorization := hX3.authorization
    exact (same_whole_has_positive_link_but_no_reverse n p).2 hAuth

#print axioms each_whole_U_source_duty_is_exact
#print axioms one_objective_whole_six_source_truth_iff_origin
#print axioms all_owed_whole_U_six_source_truth_iff_origin
#print axioms no_first_whole_U_six_source_profile_loss
#print axioms same_whole_has_positive_link_but_no_reverse
#print axioms actual_whole_Koru_and_absent_source_authorization_coexist

end PhysicalBridges.KoruWholeUSixDutyWebJoin
