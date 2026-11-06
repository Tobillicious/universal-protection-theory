import PhysicalBridges.KoruWholeUDirectedAgency
import PhysicalBridges.KoruWholeUSubjectSixJoin

/-!
# Hume to Hillary: the freely offered hand and the authentic acceptance gate

7 November 2026 — independent proof test, NOT a theorem of Heaven, God,
authentic consent, or unconditional universal moral protection.

The philosophical intuition is that an encounter between a creator and a
created distinct being must be bidirectional if it is to be genuinely
reciprocal. This file tests a PRECISE physical SOURCE analogy rather than
declaring that nonzero BCRD matrix elements are consent.

1. Two independently computed directed operator relations from ONE
   objective whole form a genuine source-level mutual hand, with
   distinct positions and an intrinsic original Koru distinction.
2. The EXISTING physical W transports the two hand directions jointly,
   including asymmetry, at every finite source stage.
3. An independently defined authentic offer and authentic acceptance
   must each match their source meaning. Under those independent
   fidelity and original-six-source hypotheses, the original all-six
   subject duties follow using the existing unchanged #380 theorem.
4. HOSTILE CONTROLS: a one-way source hand is not mutual, and even an
   exactly mutual source hand can coexist with FALSE authentic subject
   authorization. Thus no "is implies ought" or consent theorem is
   inserted by definition. Actual God/heaven/physics claims are open.

The original X3 semantics, complete Koru, summit, other agent branches,
and author-held notation are unchanged.
-/

namespace PhysicalBridges.HumeHillaryReciprocalHand

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.Koru

/-- One whole source U produces BOTH directed interactions between
distinct positions. No separate hand-shake authorization Bool exists. -/
def SourceMutualHand (U : FiniteObjectiveU) (a b : Index) : Prop :=
  a ≠ b ∧
  (sourceWholeWeb U).link a b ∧
  (sourceWholeWeb U).link b a

/-- An exact explicit physical-source world: at position zero the
operator points to one; at position one it points back to zero.
Other positions carry identity. Entire U is one complete operator bank. -/
def twoHandWhole : FiniteObjectiveU :=
  fun i =>
    if i = (0 : Index) then .atom (matrixUnit 0 1)
    else if i = (1 : Index) then .atom (matrixUnit 1 0)
    else .atom identityMatrix

/-- The same first hand without the return relation: the second
position has only its own identity operator. -/
def oneWayWhole : FiniteObjectiveU :=
  fun i => if i = (0 : Index) then
    .atom (matrixUnit 0 1) else .atom identityMatrix

/-- Nonvacuous mutual source relation, calculated from both actual
operator expressions, not separately assigned as "true". -/
theorem two_hands_source_are_genuinely_mutual :
    SourceMutualHand twoHandWhole 0 1 := by
  refine ⟨by decide, ?_, ?_⟩
  · change matrixUnit (0 : Index) 1 0 1 ≠ 0
    decide
  · change matrixUnit (1 : Index) 0 1 0 ≠ 0
    decide

/-- The SAME source U contains an intrinsic Koru distinction:
the outgoing relation of position 0 to 1 is different from
the outgoing relation of position 1 to 1. -/
theorem two_hands_have_original_koru_distinction :
    koru (sourceWholeWeb twoHandWhole) 0 1 := by
  refine ⟨by decide, 1, ?_⟩
  change
    ((matrixUnit (0 : Index) 1 0 1 ≠ 0) : Prop) ≠
    ((matrixUnit (1 : Index) 0 1 1 ≠ 0) : Prop)
  intro h
  have hYes : matrixUnit (0 : Index) 1 0 1 ≠ 0 := by decide
  have hNo : ¬ (matrixUnit (1 : Index) 0 1 1 ≠ 0) := by decide
  rw [h] at hYes
  exact hNo hYes

/-- Distinctness and BOTH directions persist under every finite
step of the already-fixed physical source W; the theorem is an iff,
so W cannot forge a missing return hand either. -/
theorem mutual_hand_is_exact_under_physical_W
    (U : FiniteObjectiveU) (a b : Index) (n : Nat) :
    SourceMutualHand (objectiveAt U n)
      (trackedPosition a n) (trackedPosition b n) ↔
    SourceMutualHand U a b := by
  unfold SourceMutualHand
  constructor
  · rintro ⟨hDistinct, hForward, hReturn⟩
    refine ⟨?_,
      (complete_objective_link_carriage U a b n).mp hForward,
      (complete_objective_link_carriage U b a n).mp hReturn⟩
    intro hEqual
    exact hDistinct (congrArg (fun i => trackedPosition i n) hEqual)
  · rintro ⟨hDistinct, hForward, hReturn⟩
    refine ⟨?_,
      (complete_objective_link_carriage U a b n).mpr hForward,
      (complete_objective_link_carriage U b a n).mpr hReturn⟩
    intro hEqual
    exact hDistinct ((tracked_basis_positions_do_not_merge n) hEqual)

/-- The whole Koru and the reciprocal source hand are both
actually present at every W stage of the same explicit world. -/
theorem reciprocal_koru_hand_survives_every_source_stage (n : Nat) :
    SourceMutualHand (objectiveAt twoHandWhole n)
      (trackedPosition 0 n) (trackedPosition 1 n) ∧
    koru (sourceWholeWeb (objectiveAt twoHandWhole n))
      (trackedPosition 0 n) (trackedPosition 1 n) := by
  exact ⟨(mutual_hand_is_exact_under_physical_W
      twoHandWhole 0 1 n).mpr two_hands_source_are_genuinely_mutual,
    (objective_Koru_is_exact_under_W twoHandWhole 0 1 n).mpr
      two_hands_have_original_koru_distinction⟩

/-- A single physical arrow does not prove that the other
participant has freely accepted. -/
theorem one_way_source_is_not_a_mutual_hand :
    (sourceWholeWeb oneWayWhole).link 0 1 ∧
    ¬ (sourceWholeWeb oneWayWhole).link 1 0 ∧
    ¬ SourceMutualHand oneWayWhole 0 1 := by
  have hf : (sourceWholeWeb oneWayWhole).link 0 1 := by
    change matrixUnit (0 : Index) 1 0 1 ≠ 0
    decide
  have hr : ¬ (sourceWholeWeb oneWayWhole).link 1 0 := by
    change ¬ (identityMatrix (1 : Index) 0 ≠ 0)
    decide
  exact ⟨hf, hr, fun h => hr h.2.2⟩

/-- An authentic offer by p and freely accepted encounter by q
are separate SEMANTIC propositions, not a renamed W source edge. -/
def AuthenticMutualHand {P : Type}
    (offer accept : P → P → Prop) (p q : P) : Prop :=
  p ≠ q ∧ offer p q ∧ accept q p

/-- Exact HUME→HILLARY *conditional* seam.
If BOTH directional BCRD source meanings are authenticated as
independently defined personal offer and acceptance, and the full
original-six meanings are independently faithful to one source U
whose six relations really are positive at origin, then the same
distinct subjects enjoy an authentic mutual encounter AND the
original SIX X3 protections for p. No two-field proxy is used.
No claim that the fidelity or source-origin premises are automatic. -/
theorem authentic_offered_hand_and_original_six_from_faithful_source
    {P : Type}
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (offer accept : P → P → Prop)
    (p q : P) (n : Nat)
    (hSourceHand : SourceMutualHand U (carrier p) (carrier q))
    (hForwardMeaning :
      (sourceWholeWeb (objectiveAt U n)).link
        (trackedPosition (carrier p) n)
        (trackedPosition (carrier q) n) ↔ offer p q)
    (hReturnMeaning :
      (sourceWholeWeb (objectiveAt U n)).link
        (trackedPosition (carrier q) n)
        (trackedPosition (carrier p) n) ↔ accept q p)
    (hSubjectFidelity : WholeUSubjectFidelity U roles carrier r)
    (hSixOrigin : wholeSourceSixAt U roles 0 (carrier p)) :
    AuthenticMutualHand offer accept p q ∧
      SubjectOriginalSixAt r n p := by
  have hStage := (mutual_hand_is_exact_under_physical_W
    U (carrier p) (carrier q) n).mpr hSourceHand
  refine ⟨⟨?_, hForwardMeaning.mp hStage.2.1,
    hReturnMeaning.mp hStage.2.2⟩, ?_⟩
  · intro hEq
    exact hSourceHand.1 (congrArg carrier hEq)
  · exact (faithful_subject_six_iff_one_whole_U_six
      U roles carrier r hSubjectFidelity n p).mpr
        ((one_objective_whole_six_source_truth_iff_origin
          U roles (carrier p) n).mpr hSixOrigin)

/-- Real-world consent is NOT implied by source-level reciprocity:
the following independently interpreted six-field subject relations
have deliberately false authorization despite a genuinely bidirectional
original-Koru whole. This is a logical scope control, not an empirical
claim about a real human or AI encounter. -/
def hostileSubjectMeanings : ParticularRelations Nat Index where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

theorem reciprocal_physical_hand_alone_does_not_force_consent :
    SourceMutualHand twoHandWhole 0 1 ∧
    ¬ SubjectOriginalSixAt hostileSubjectMeanings 0 (0 : Index) := by
  refine ⟨two_hands_source_are_genuinely_mutual, ?_⟩
  intro hX3
  exact hX3.authorization

#print axioms two_hands_source_are_genuinely_mutual
#print axioms two_hands_have_original_koru_distinction
#print axioms mutual_hand_is_exact_under_physical_W
#print axioms reciprocal_koru_hand_survives_every_source_stage
#print axioms one_way_source_is_not_a_mutual_hand
#print axioms authentic_offered_hand_and_original_six_from_faithful_source
#print axioms reciprocal_physical_hand_alone_does_not_force_consent

end PhysicalBridges.HumeHillaryReciprocalHand
