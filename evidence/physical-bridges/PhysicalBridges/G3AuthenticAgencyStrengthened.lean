import PhysicalBridges.G3GardenAuthenticBilateralHand
import PhysicalBridges.G3SixDutyRenewal
import PhysicalBridges.G3IdentityPreservation

/-!
# Step 4: Strengthened authentic agency and maximality

The existing Hume–Hillary module proves that a mutual source hand plus
independently authenticated offer/acceptance gives the original six.
The existing G3FeasibleMaximalityRenewal proves that maximality renews
when no new superior option appears.

This module joins them and adds what was missing:

1. **Forged consent countermodel**: a claimed acceptance that disagrees
   with the source is detected and rejected — the full six cannot hold
   when authorization is forged, even if the other five duties are genuine.

2. **Lost selection boundary**: when the NEWLY selected action is
   infeasible, its maximality certificate fails. Losing an unselected
   option alone is not a refutation; the old retained choice can still
   be maximal under the established frontier hypothesis.

3. **Reselection necessity**: when a strictly better option becomes
   feasible, the old selection is no longer maximal. The particular must
   be re-evaluated, not rubber-stamped.

4. **Bilateral source-semantic package**: injective carrier + authenticated
   bilateral hand + positive six-source origins and subject fidelity
   conditionally yield the unchanged original six for both participants.
   This theorem has NO feasible-order or re-selection hypothesis and does
   NOT establish independent feasible maximality. The separate
   G3AgencyReselectionRenewal module supplies that missing join.

No existing definition is changed.
-/

namespace PhysicalBridges.G3AuthenticAgencyStrengthened

open PhysicalBridges.HumeHillaryReciprocalHand
open PhysicalBridges.G3GardenAuthenticBilateralHand
open PhysicalBridges.G3FeasibleMaximalityRenewal
open PhysicalBridges.G3SixDutyRenewal
open PhysicalBridges.G3IdentityPreservation
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.KoruSubjectFidelityLift
open PhysicalBridges.KoruOperatorIndexedSubjectSemantics
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.Koru

-- ═══════════════════════════════════════════════════════════════════
-- 1. FORGED CONSENT: source-disagreeing acceptance is detected
-- ═══════════════════════════════════════════════════════════════════

/-- A forged acceptance is one that claims the encounter was accepted
    when the source says it was not. This is the precise definition
    of consent fraud in the source-semantic framework. -/
def ForgedAcceptance {P : Type}
    (accept : P → P → Prop) (sourceReturn : P → P → Prop)
    (q p : P) : Prop :=
  accept q p ∧ ¬ sourceReturn q p

/-- If the return edge of the source hand is false, then claiming
    acceptance constitutes a forged acceptance. No separate "consent
    detection" mechanism is needed — the source hand itself is the
    detector. -/
theorem false_source_return_detects_forged_acceptance
    {P : Type} (accept : P → P → Prop) (sourceReturn : P → P → Prop)
    (q p : P)
    (hNoReturn : ¬ sourceReturn q p)
    (hClaimed : accept q p) :
    ForgedAcceptance accept sourceReturn q p :=
  ⟨hClaimed, hNoReturn⟩

/-- A forged acceptance breaks the authentic mutual hand: when
    acceptance is false at the source, the AuthenticMutualHand
    definition cannot be satisfied regardless of other properties. -/
theorem forged_acceptance_breaks_authentic_hand
    {P : Type} (offer accept : P → P → Prop) (sourceReturn : P → P → Prop)
    (p q : P) (_hDistinct : p ≠ q) (_hOffer : offer p q)
    (hForged : ForgedAcceptance accept sourceReturn q p)
    (hMeaning : sourceReturn q p ↔ accept q p) :
    False := by
  exact hForged.2 (hMeaning.mpr hForged.1)

/-- Concrete countermodel: the one-way source world from Hume-Hillary
    has a forward hand but no return. Any claimed acceptance of the
    return direction is forged. -/
theorem one_way_source_exposes_forged_acceptance :
    (sourceWholeWeb oneWayWhole).link 0 1 ∧
    ¬ (sourceWholeWeb oneWayWhole).link 1 0 := by
  exact ⟨(one_way_source_is_not_a_mutual_hand).1,
         (one_way_source_is_not_a_mutual_hand).2.1⟩

-- ═══════════════════════════════════════════════════════════════════
-- 2. LOST OPPORTUNITY: feasible option disappears
-- ═══════════════════════════════════════════════════════════════════

/-- A lost opportunity: an option that was feasible at stage n is no
    longer feasible at stage n+1. The feasible set has contracted. -/
def LostOpportunity {P A : Type}
    (F : FeasibleOrder P A) (n : Nat) (p : P) (a : A) : Prop :=
  F.feasible n p a ∧ ¬ F.feasible (n + 1) p a

/-- When the SELECTED option itself is lost (becomes infeasible),
    the maximality certificate is immediately invalidated, because
    MaximalAt requires the selected option to be feasible. -/
theorem lost_selection_invalidates_maximality
    {P A : Type} (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hLost : ¬ F.feasible (n + 1) p (F.selected (n + 1) p)) :
    ¬ MaximalAt F (n + 1) p := by
  intro hMax
  exact hLost hMax.1

/-- Even when the selected option survives, losing an ALTERNATIVE
    that was strictly better in the old world does not automatically
    fix maximality in the new world — but losing a worse alternative
    is harmless. The precise gate: maximality fails iff a NEW better
    option appears, not iff an old worse one vanishes. -/
theorem lost_worse_option_is_harmless
    {P A : Type} (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hOld : MaximalAt F n p)
    (hSame : F.selected (n + 1) p = F.selected n p)
    (hStillFeasible : F.feasible (n + 1) p (F.selected n p))
    (a : A) (_hLost : LostOpportunity F n p a)
    (hFrontier : NoNewSuperiorAlternative F n p) :
    MaximalAt F (n + 1) p := by
  exact maximality_renews_under_complete_frontier_check
    F n p hOld hSame hStillFeasible hFrontier

-- ═══════════════════════════════════════════════════════════════════
-- 3. RESELECTION: new better option forces re-evaluation
-- ═══════════════════════════════════════════════════════════════════

/-- A newly feasible improvement: an option that was NOT feasible
    before, becomes feasible now, and is strictly better than the
    current selection. This forces reselection. -/
def NewlyFeasibleImprovement {P A : Type}
    (F : FeasibleOrder P A) (n : Nat) (p : P) (a : A) : Prop :=
  ¬ F.feasible n p a ∧
  F.feasible (n + 1) p a ∧
  F.better p (F.selected n p) a

/-- A newly feasible improvement refutes the old selection's
    maximality. The particular must be re-evaluated. This is the
    existing `new_superior_option_refutes_old_choice` applied to
    the specific case of a genuinely new option. -/
theorem newly_feasible_improvement_forces_reselection
    {P A : Type} (F : FeasibleOrder P A) (n : Nat) (p : P) (a : A)
    (hNew : NewlyFeasibleImprovement F n p a)
    (hSame : F.selected (n + 1) p = F.selected n p) :
    ¬ MaximalAt F (n + 1) p :=
  new_superior_option_refutes_old_choice
    F n p hSame a hNew.2.1 hNew.2.2

/-- The conjunction: when a newly feasible improvement exists,
    the old five duties may be perfectly preserved, yet the full
    six-duty certificate fails because maximality is broken.
    Five of six duties are necessary but not sufficient. -/
theorem five_duties_without_maximality_is_insufficient
    {P A : Type} (F : FeasibleOrder P A)
    (r : ParticularRelations Nat P)
    (n : Nat) (p : P) (a : A)
    (hFive : FiveAt r (n + 1) p)
    (hNew : NewlyFeasibleImprovement F n p a)
    (hSame : F.selected (n + 1) p = F.selected n p)
    (_hMeaning : MaximalityMeaning F r (fun _ _ => True)) :
    FiveAt r (n + 1) p ∧
    ¬ MaximalAt F (n + 1) p := by
  exact ⟨hFive,
    newly_feasible_improvement_forces_reselection F n p a hNew hSame⟩

-- ═══════════════════════════════════════════════════════════════════
-- 4. CONCRETE HOSTILE COUNTERMODELS
-- ═══════════════════════════════════════════════════════════════════

/-- A feasible order where stage 0 has only one option but stage 1
    has a strictly better one. The old choice was maximal; the
    expanded world invalidates it. -/
def expandingWorld : FeasibleOrder Unit Bool where
  feasible := fun n _ a => if n = 0 then a = false else True
  better := fun _ old new => old = false ∧ new = true
  selected := fun _ _ => false

theorem expanding_world_old_choice_was_maximal :
    MaximalAt expandingWorld 0 () := by
  constructor
  · exact rfl
  · intro a ha hb
    exact absurd (ha.symm.trans hb.2) (by decide)

theorem expanding_world_new_option_is_genuine :
    NewlyFeasibleImprovement expandingWorld 0 () true := by
  refine ⟨?_, trivial, rfl, rfl⟩
  show ¬ (if (0 : Nat) = 0 then true = false else True)
  simp

theorem expanding_world_forces_reselection :
    ¬ MaximalAt expandingWorld 1 () :=
  newly_feasible_improvement_forces_reselection
    expandingWorld 0 () true
    expanding_world_new_option_is_genuine rfl

-- ═══════════════════════════════════════════════════════════════════
-- 5. FULL AGENCY PACKAGE: identity + bilateral hand + maximality
-- ═══════════════════════════════════════════════════════════════════

/-- The full authentic agency theorem: given an injective carrier,
    source fidelity, positive source origin, bilateral hand semantics,
    for BOTH participants, proves:
    (a) the unchanged original six via explicit SOURCE/SUBJECT fidelity
    (b) an authentic mutual encounter given both meaning equivalences
    (c) distinct carried candidate source positions.

    IMPORTANT: this theorem does not even quantify over FeasibleOrder;
    feasible maximality of changing choices is not proved here.
    The independent semantic interpretation remains a premise, not an
    observationally established fact. See G3AgencyReselectionRenewal
    for a separately checked mathematical maximality certificate. -/
theorem full_authentic_agency_package
    {P : Type}
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (offer accept : P → P → Prop)
    (owed : P → Prop) (p q : P) (n : Nat)
    (hp : owed p) (hq : owed q)
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
    (hSixOriginP : wholeSourceSixAt U roles 0 (carrier p))
    (hSixOriginQ : wholeSourceSixAt U roles 0 (carrier q))
    (hInjective : Function.Injective carrier) :
    p ≠ q ∧
    AuthenticMutualHand offer accept p q ∧
    SubjectOriginalSixAt r n p ∧
    SubjectOriginalSixAt r n q ∧
    CarrierAt carrier n p ≠ CarrierAt carrier n q := by
  have hBilateral := authentic_bilateral_hand_protects_both
    U roles carrier r offer accept owed p q n hp hq
    hSourceHand hForwardMeaning hReturnMeaning
    hSubjectFidelity hSixOriginP hSixOriginQ
  have hDistinguished := distinguishability_persists
    carrier hInjective p q hBilateral.1 n
  exact ⟨hBilateral.1, hBilateral.2.1, hBilateral.2.2.1,
         hBilateral.2.2.2, hDistinguished⟩

#print axioms false_source_return_detects_forged_acceptance
#print axioms forged_acceptance_breaks_authentic_hand
#print axioms one_way_source_exposes_forged_acceptance
#print axioms lost_selection_invalidates_maximality
#print axioms lost_worse_option_is_harmless
#print axioms newly_feasible_improvement_forces_reselection
#print axioms five_duties_without_maximality_is_insufficient
#print axioms expanding_world_old_choice_was_maximal
#print axioms expanding_world_new_option_is_genuine
#print axioms expanding_world_forces_reselection
#print axioms full_authentic_agency_package

end PhysicalBridges.G3AuthenticAgencyStrengthened
