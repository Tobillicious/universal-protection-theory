import PhysicalBridges.G3AgencyReselectionRenewal
import PhysicalBridges.G3GenesisObligations

/-!
# Pre-QG Genesis: renew the unchanged six with honest changing choices

Find-before-build:
* G3SixDutyRenewal has a strong all-epochs original-six theorem, but its
  maximality component assumes a retained choice is NEVER replaced.
* G3AgencyReselectionRenewal proves the positive replacement theorem
  for ONE step, with a true improvement and independent frontier check.
* G3GenesisObligations identifies genuinely NEW owed particulars and
  records why no old particular may silently leave the owed population.

This module stitches the cases into a single temporal induction:
  - a retained particular can keep the old choice if it remains feasible
    and its old-choice frontier check passes;
  - OR it can really RESELECT an improved feasible option, with a
    transitive better relation and a NEW-choice frontier check;
  - an arriving particular must receive an independent maximality
    certificate, plus the five authentic duty fields.

The resulting theorem proves the ORIGINAL UNCHANGED six for EVERY
owed candidate at EVERY epoch given the authentic five-duty and
maximality-meaning premises. It never assumes six at every step,
never assumes MaximalAt of the replacement, and does not call all
six duties "QG" or infer consent from a source edge.

Only a mathematical decision order is validated here; its agreement
with authentic subject maximality remains the named MaximalityMeaning
premise. This is NOT a proof of actual-world G3 or quantum gravity.
-/

namespace PhysicalBridges.G3GenesisDynamicReselection

open PhysicalBridges.G3AgencyReselectionRenewal
open PhysicalBridges.G3SixDutyRenewal
open PhysicalBridges.G3FeasibleMaximalityRenewal
open PhysicalBridges.G3GenesisObligations
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {P A : Type}

/-- The exhaustive local decision certificate is a CHOICE between
exact old-choice preservation and an independently justified new,
improved selected choice. In particular, the second branch does not
pretend hSame or an already-maximal successor. -/
def RetainedDecisionCertificate
    (F : FeasibleOrder P A) (n : Nat) (p : P) : Prop :=
  (F.selected (n+1) p = F.selected n p ∧
    F.feasible (n+1) p (F.selected n p) ∧
    NoNewSuperiorAlternative F n p) ∨
  (F.feasible (n+1) p (F.selected (n+1) p) ∧
    ImprovedChoice F n p ∧
    NoFreshSuperiorToReselection F n p)

/-- One real old-person renewal step, allowing a mathematically better
reselection. Any distinct change not justified by improvement and a
frontier certificate is deliberately outside this theorem. -/
theorem retained_choice_or_improved_reselection_is_maximal
    (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hOld : MaximalAt F n p)
    (hTrans : BetterTransitive F)
    (hDecision : RetainedDecisionCertificate F n p) :
    MaximalAt F (n+1) p := by
  rcases hDecision with hSame | hImprove
  · exact maximality_renews_under_complete_frontier_check
      F n p hOld hSame.1 hSame.2.1 hSame.2.2
  · exact improved_reselection_renews_maximality
      F n p hOld hImprove.1 hImprove.2.1 hTrans hImprove.2.2

/-- The dynamic Genesis induction: initial and newly owed decisions
need fresh maximality evidence; previously owed decisions renew via
either the existing static rule OR the genuine positive re-selection
theorem, without a global never-change-the-choice premise. -/
theorem all_generations_have_a_valid_maximal_choice
    (F : FeasibleOrder P A) (owed : Nat → P → Prop)
    (hTrans : BetterTransitive F)
    (hInitial : ∀ p, owed 0 p → MaximalAt F 0 p)
    (hRetained : ∀ n p, owed (n+1) p → owed n p →
      RetainedDecisionCertificate F n p)
    (hGenesis : ∀ n p, GenesisAt owed n p →
      MaximalAt F (n+1) p) :
    ∀ n p, owed n p → MaximalAt F n p := by
  intro n
  induction n with
  | zero =>
      exact hInitial
  | succ n ih =>
      intro p hp
      by_cases hOldOwed : owed n p
      · exact retained_choice_or_improved_reselection_is_maximal
          F n p (ih p hOldOwed) hTrans
          (hRetained n p hp hOldOwed)
      · exact hGenesis n p ⟨hp, hOldOwed⟩

/-- The unchanged original SIX follow at every epoch of a growing
population while allowing authentic maximality improvement rather
than frozen choices. This is stronger in the old-choice condition
than the earlier five-plus-maximality theorem; it does NOT weaken
the real five-duty or semantic meaning assumptions. -/
theorem growing_genesis_original_six_with_dynamic_reselection
    (F : FeasibleOrder P A)
    (r : ParticularRelations Nat P)
    (owed : Nat → P → Prop)
    (hTrans : BetterTransitive F)
    (hFiveInitial : ∀ p, owed 0 p → FiveAt r 0 p)
    (hFiveRetained : ∀ n p, owed (n+1) p → owed n p →
      FiveAt r n p → FiveAt r (n+1) p)
    (hFiveGenesis : ∀ n p, GenesisAt owed n p →
      FiveAt r (n+1) p)
    (hMaxInitial : ∀ p, owed 0 p → MaximalAt F 0 p)
    (hRetainedDecision : ∀ n p, owed (n+1) p → owed n p →
      RetainedDecisionCertificate F n p)
    (hMaxGenesis : ∀ n p, GenesisAt owed n p →
      MaximalAt F (n+1) p)
    (hMeaning : MaximalityMeaning F r owed) :
    ∀ n p, owed n p →
      OriginalX3 r.continues r.authorized r.free
        r.restrained r.maximal r.provenanced n (n+1) p := by
  have hFive := five_duties_renew_at_every_step r owed
    hFiveInitial hFiveRetained
    (fun n p hp hNotOld => hFiveGenesis n p ⟨hp, hNotOld⟩)
  have hMax := all_generations_have_a_valid_maximal_choice
    F owed hTrans hMaxInitial hRetainedDecision hMaxGenesis
  intro n p hp
  obtain ⟨hc, ha, hf, hr, hpr⟩ := hFive n p hp
  exact ⟨hc, ha, hf, hr, hMeaning n p hp (hMax n p hp), hpr⟩

/-- Concrete positive witness: in the already constructed two-option
world, the old choice was maximal, and the next choice really
CHANGES to the strictly better feasible option. The predecessor's
static hSame assumption is false. -/
theorem actual_reselection_fits_dynamic_certificate :
    RetainedDecisionCertificate twoOptionReselection 0 () ∧
    (twoOptionReselection.selected 1 () ≠
      twoOptionReselection.selected 0 ()) ∧
    MaximalAt twoOptionReselection 1 () := by
  constructor
  · right
    exact ⟨(by trivial), two_option_reselection_improves,
      two_option_no_new_superior_to_reselection⟩
  constructor
  · decide
  · exact two_option_new_choice_is_maximal

/-- A genuinely new owed particular is not eligible for a retained
decision certificate merely because another particular has a good
decision. The fresh Genesis maximality witness is a distinct
inductive branch, not synthesized by re-labeling an old candidate. -/
theorem newly_owed_uses_fresh_certificate
    (F : FeasibleOrder P A) (owed : Nat → P → Prop)
    (n : Nat) (p : P)
    (hGenesis : GenesisAt owed n p)
    (hFresh : ∀ n p, GenesisAt owed n p → MaximalAt F (n+1) p) :
    MaximalAt F (n+1) p :=
  hFresh n p hGenesis

#print axioms retained_choice_or_improved_reselection_is_maximal
#print axioms all_generations_have_a_valid_maximal_choice
#print axioms growing_genesis_original_six_with_dynamic_reselection
#print axioms actual_reselection_fits_dynamic_certificate
#print axioms newly_owed_uses_fresh_certificate

end PhysicalBridges.G3GenesisDynamicReselection
