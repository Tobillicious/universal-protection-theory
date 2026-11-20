import PhysicalBridges.G3AuthenticAgencyStrengthened

/-!
# Pre-QG: a genuine reselected choice can become maximal

The earlier G3FeasibleMaximalityRenewal proof covers UNCHANGED
selections. G3AuthenticAgencyStrengthened supplies negative controls
when improved alternatives arrive, but its named full agency theorem
does not itself use a FeasibleOrder or a reselection certificate.

This additive theorem closes the positive RESELECTION case conditionally,
without presuming MaximalAt at the new step. Starting from an OLD
MaximalAt certificate, a genuinely improved newly chosen action,
transitivity of a separately supplied strict better relation, and
the independently testable frontier condition that any feasible
action BETTER THAN THE NEW CHOICE was already feasible at the prior
step, we DERIVE maximality of the replacement.

This works even if the old selected option is now infeasible. It does
not claim the better relation is an objective human ethical order
or that it is faithfully derived from physical evolution.

A concrete two-choice growing world witnesses the resulting positive
maximality theorem. The bilateral Hume-Hillary result is joined to
the derived mathematical maximality for both owed participants,
without changing the ORIGINAL six duty meanings. A real physical
semantic bridge remains a separate requirement.

No new QG statement, no previous theorem weakened, and no new axioms.
-/

namespace PhysicalBridges.G3AgencyReselectionRenewal

open PhysicalBridges.G3FeasibleMaximalityRenewal
open PhysicalBridges.G3AuthenticAgencyStrengthened
open PhysicalBridges.G3GardenAuthenticBilateralHand
open PhysicalBridges.HumeHillaryReciprocalHand
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.Koru

variable {P A : Type}

/-- The chosen improvement is genuine relative to the previous
selected option, rather than a new label with no comparison. -/
def ImprovedChoice (F : FeasibleOrder P A) (n : Nat) (p : P) : Prop :=
  F.better p (F.selected n p) (F.selected (n + 1) p)

/-- The independently auditable frontier rule for a RESELECTED choice:
an alternative better than the NEW selection, if feasible now,
must have already been feasible at the preceding stage. Unlike
NoNewSuperiorAlternative, this test compares against the NEW choice. -/
def NoFreshSuperiorToReselection
    (F : FeasibleOrder P A) (n : Nat) (p : P) : Prop :=
  ∀ a, F.feasible (n + 1) p a →
    F.better p (F.selected (n + 1) p) a →
      F.feasible n p a

/-- Transitivity is a separate mathematical property of the
comparison relation; the FeasibleOrder structure alone does
not assert it. -/
def BetterTransitive (F : FeasibleOrder P A) : Prop :=
  ∀ p a b c, F.better p a b → F.better p b c → F.better p a c

/-- Positive re-selection theorem: an old maximal choice, a new
feasible and strictly improved selected choice, order transitivity
and the frontier check relative to the NEW selection suffice for
new maximality. Notice there is no hSame, nor any hMaxAtNew premise,
and the old selected choice may have become infeasible. -/
theorem improved_reselection_renews_maximality
    (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hOld : MaximalAt F n p)
    (hNewFeasible : F.feasible (n + 1) p (F.selected (n + 1) p))
    (hImprove : ImprovedChoice F n p)
    (hTrans : BetterTransitive F)
    (hNewFrontier : NoFreshSuperiorToReselection F n p) :
    MaximalAt F (n + 1) p := by
  constructor
  · exact hNewFeasible
  · intro a ha hBetterNew
    have hEarlier : F.feasible n p a :=
      hNewFrontier a ha hBetterNew
    have hBetterOld : F.better p (F.selected n p) a :=
      hTrans p (F.selected n p) (F.selected (n + 1) p) a
        hImprove hBetterNew
    exact (hOld.2 a hEarlier) hBetterOld

/-- If an already maximal old choice is replaced by a better one,
there can be no feasible OLD alternative that is better than the
new choice; a counterexample to the new choice MUST evade the
frontier check. -/
theorem improved_choice_failure_exposes_new_frontier
    (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hOld : MaximalAt F n p)
    (hNewFeasible : F.feasible (n + 1) p (F.selected (n + 1) p))
    (hImprove : ImprovedChoice F n p)
    (hTrans : BetterTransitive F)
    (hFailure : ¬ MaximalAt F (n + 1) p) :
    ¬ NoFreshSuperiorToReselection F n p := by
  intro hFrontier
  exact hFailure (improved_reselection_renews_maximality
    F n p hOld hNewFeasible hImprove hTrans hFrontier)

/-- Concrete real finite re-selection test: there is one feasible
option at stage 0, a better option arrives at stage 1, and
the selector changes to the new option rather than staying stuck. -/
def twoOptionReselection : FeasibleOrder Unit Bool where
  feasible := fun n _ a => if n = 0 then a = false else True
  better := fun _ old new => old = false ∧ new = true
  selected := fun n _ => if n = 0 then false else true

theorem two_option_old_was_maximal :
    MaximalAt twoOptionReselection 0 () := by
  constructor
  · exact rfl
  · intro a ha hb
    have haFalse : a = false := ha
    have haTrue : a = true := hb.2
    exact Bool.noConfusion (haFalse.symm.trans haTrue)

theorem two_option_reselection_improves :
    ImprovedChoice twoOptionReselection 0 () := by
  exact ⟨rfl, rfl⟩

theorem two_option_order_is_transitive :
    BetterTransitive twoOptionReselection := by
  intro p a b c hab hbc
  obtain ⟨_, hbTrue⟩ := hab
  obtain ⟨hbFalse, _⟩ := hbc
  exact False.elim ((by decide : (true : Bool) ≠ false)
    (hbTrue.symm.trans hbFalse))

theorem two_option_no_new_superior_to_reselection :
    NoFreshSuperiorToReselection twoOptionReselection 0 () := by
  intro a _ h
  exact False.elim ((by decide : (true : Bool) ≠ false) h.1)

theorem two_option_new_choice_is_maximal :
    MaximalAt twoOptionReselection 1 () := by
  exact improved_reselection_renews_maximality
    twoOptionReselection 0 ()
    two_option_old_was_maximal
    (by trivial)
    two_option_reselection_improves
    two_option_order_is_transitive
    two_option_no_new_superior_to_reselection

/-- Extend the existing unchanged Hume-Hillary bilateral hand package
by genuine feasible maximality of two participants AFTER re-selection.
The authentic subject-level original six remain derived conditionally
via the existing independent source/subject fidelity theorem, not
from mathematical order alone. -/
theorem bilateral_hand_and_renewed_feasible_maximality
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (offer accept : P → P → Prop)
    (owed : P → Prop) (p q : P) (n : Nat)
    (hp : owed p) (hq : owed q)
    (hSourceHand : SourceMutualHand U (carrier p) (carrier q))
    (hForwardMeaning :
      (sourceWholeWeb (objectiveAt U (n + 1))).link
        (trackedPosition (carrier p) (n + 1))
        (trackedPosition (carrier q) (n + 1)) ↔ offer p q)
    (hReturnMeaning :
      (sourceWholeWeb (objectiveAt U (n + 1))).link
        (trackedPosition (carrier q) (n + 1))
        (trackedPosition (carrier p) (n + 1)) ↔ accept q p)
    (hSubjectFidelity : WholeUSubjectFidelity U roles carrier r)
    (hSixOriginP : wholeSourceSixAt U roles 0 (carrier p))
    (hSixOriginQ : wholeSourceSixAt U roles 0 (carrier q))
    (hInjective : Function.Injective carrier)
    (F : FeasibleOrder P A)
    (hOldP : MaximalAt F n p) (hOldQ : MaximalAt F n q)
    (hFeasibleP : F.feasible (n + 1) p (F.selected (n + 1) p))
    (hFeasibleQ : F.feasible (n + 1) q (F.selected (n + 1) q))
    (hImproveP : ImprovedChoice F n p)
    (hImproveQ : ImprovedChoice F n q)
    (hTrans : BetterTransitive F)
    (hFrontierP : NoFreshSuperiorToReselection F n p)
    (hFrontierQ : NoFreshSuperiorToReselection F n q) :
    AuthenticMutualHand offer accept p q ∧
    SubjectOriginalSixAt r (n + 1) p ∧
    SubjectOriginalSixAt r (n + 1) q ∧
    MaximalAt F (n + 1) p ∧
    MaximalAt F (n + 1) q ∧
    CarrierAt carrier (n + 1) p ≠
      CarrierAt carrier (n + 1) q := by
  have hHand := full_authentic_agency_package
    U roles carrier r offer accept owed p q (n + 1)
    hp hq hSourceHand hForwardMeaning hReturnMeaning
    hSubjectFidelity hSixOriginP hSixOriginQ hInjective
  have hMaxP := improved_reselection_renews_maximality
    F n p hOldP hFeasibleP hImproveP hTrans hFrontierP
  have hMaxQ := improved_reselection_renews_maximality
    F n q hOldQ hFeasibleQ hImproveQ hTrans hFrontierQ
  exact ⟨hHand.2.1, hHand.2.2.1, hHand.2.2.2.1,
    hMaxP, hMaxQ, hHand.2.2.2.2⟩

#print axioms improved_reselection_renews_maximality
#print axioms improved_choice_failure_exposes_new_frontier
#print axioms two_option_old_was_maximal
#print axioms two_option_reselection_improves
#print axioms two_option_order_is_transitive
#print axioms two_option_no_new_superior_to_reselection
#print axioms two_option_new_choice_is_maximal
#print axioms bilateral_hand_and_renewed_feasible_maximality

end PhysicalBridges.G3AgencyReselectionRenewal
