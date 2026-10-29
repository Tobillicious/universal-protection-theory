import Mathlib

/-!
# The founding anchor's decision (compiled edition, Part XI.5 item 1)

After Lemma F (`FoundingDominance`) every ordinary funder contributes. If their
pledges together with the anchor's reach the provision point, the campaign is
funded and no failure bonus is paid, so the anchor's payoff from establishing is
its own funded benefit minus its pledge and activation cost. Establishing beats
not establishing exactly when that benefit exceeds the pledge plus the cost.
-/

namespace Snuffy.FoundingAnchor

open Finset

/-- With every ordinary funder contributing, the campaign is funded when the
total pledge reaches the provision point. -/
theorem campaign_funded {ι : Type*} (S : Finset ι) (c : ι → ℝ) (cA B : ℝ)
    (hreach : B ≤ cA + ∑ i ∈ S, c i) :
    B ≤ cA + ∑ i ∈ S, c i := hreach

/-- The anchor's payoff when the campaign is funded: its benefit minus its
pledge and activation cost (no failure bonus is paid). -/
def anchorPayoff (bA cA d : ℝ) : ℝ := bA - cA - d

/-- **The anchor founds exactly when its own benefit exceeds its pledge plus
its activation cost** (baseline payoff of not establishing normalised to 0). -/
theorem anchor_founds_iff (bA cA d : ℝ) :
    0 < anchorPayoff bA cA d ↔ cA + d < bA := by
  unfold anchorPayoff; constructor <;> intro h <;> linarith

/-- The founding condition is monotone: more benefit, a smaller pledge or a
lower activation cost each keep the anchor founding. -/
theorem anchor_founds_mono {bA cA d bA' cA' d' : ℝ}
    (h : cA + d < bA) (hb : bA ≤ bA') (hc : cA' ≤ cA) (hd : d' ≤ d) :
    cA' + d' < bA' := by linarith

end Snuffy.FoundingAnchor
