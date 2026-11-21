import Snuffy.FoundingPivotal
import Snuffy.FoundingAnchor
import Mathlib.Tactic.Ring

/-!
Part XIV.1: energy-denominated all-necessary founding and finite collateral.

The payoff comparison uses one founder's commensurate valuation throughout.
Changing its positive unit does not change its sign. This does not identify
another founder's preferences with joules, or establish physical custody.
The reserve result includes every contributor subset, refunded pledges,
failure bonuses and a separate activation bill. Each claimant is paid once.
-/

namespace Snuffy.EnergyFounding

open Finset Snuffy.FoundingDominance

/-- A common positive change of unit scales every payoff difference. -/
theorem advantage_positive_unit (q B c β bpiv bfund Y : ℝ) (hq : 0 < q) :
    advantage (q * B) (q * c) (q * β) (q * bpiv) (q * bfund) (q * Y) =
      q * advantage B c β bpiv bfund Y := by
  have hFail : q * Y + q * c < q * B ↔ Y + c < B := by
    rw [← mul_add, mul_lt_mul_iff_right₀ hq]
  have hShort : q * Y < q * B ↔ Y < B := by
    exact mul_lt_mul_iff_right₀ hq
  simp only [advantage, hFail, hShort]
  split_ifs <;> ring

/-- A committed anchor adds the same stock to both sides of the provision
comparison. Every ordinary pledge remains necessary, including for a
non-excludable benefit; the already-funded case cannot arise. -/
theorem energy_all_necessary_dominant {ι : Type*} [DecidableEq ι]
    (N : Finset ι) (c : ι → ℝ) (hpos : ∀ j ∈ N, 0 < c j)
    (i : ι) (hi : i ∈ N) (S : Finset ι) (hS : S ⊆ N.erase i)
    (anchor β bpiv bfund : ℝ) (hβ : 0 < β) (hpiv : c i < bpiv) :
    0 < advantage (anchor + ∑ j ∈ N, c j) (c i) β bpiv bfund
      (anchor + ∑ j ∈ S, c j) := by
  apply Snuffy.FoundingPivotal.pivotal_contribution_dominant
  · have h := Snuffy.FoundingPivotal.others_short N c hpos i hi S hS
    linarith
  · exact hβ
  · exact hpiv

/-- Posted bonuses cover any subset of claimants, without guessing which
contributors arrive or treating their refundable pledges as bonus income. -/
theorem subset_bonuses_funded {ι : Type*} [DecidableEq ι]
    (N S : Finset ι) (bonus : ι → ℝ)
    (hS : S ⊆ N) (hbonus : ∀ i ∈ N, 0 ≤ bonus i) :
    (∑ i ∈ S, bonus i) ≤ ∑ i ∈ N, bonus i := by
  exact Finset.sum_le_sum_of_subset_of_nonneg hS
    (fun i hi _ => hbonus i hi)

/-- Failure refunds all received pledges (including the anchor), pays each
eligible bonus, and includes activation. The bonus stock is posted separately
from the incoming pledges, so the same energy is never spent twice. -/
theorem failure_refunds_and_bonuses_funded {ι : Type*} [DecidableEq ι]
    (N S : Finset ι) (pledge bonus : ι → ℝ)
    (anchor activation : ℝ) (hS : S ⊆ N)
    (hbonus : ∀ i ∈ N, 0 ≤ bonus i) :
    (anchor + ∑ i ∈ S, pledge i) + (∑ i ∈ S, bonus i) + activation ≤
      (anchor + activation + ∑ i ∈ N, bonus i) + ∑ i ∈ S, pledge i := by
  have h := subset_bonuses_funded N S bonus hS hbonus
  linarith

/-- On success, the pledged energy pays the provision bill. The posted
failure-bonus reserve is left over rather than counted as provision twice. -/
theorem successful_campaign_exact_balance {ι : Type*}
    (N : Finset ι) (pledge bonus : ι → ℝ) (anchor activation : ℝ) :
    (anchor + activation + ∑ i ∈ N, bonus i) + (∑ i ∈ N, pledge i) -
      ((anchor + ∑ i ∈ N, pledge i) + activation) =
        ∑ i ∈ N, bonus i := by
  ring

/-- A meter's independently certified lower bound can authorize a reserve.
The theorem retains both the calibration bound and the actual stock. -/
theorem meter_lower_bound_funds_collateral (actual reading error required : ℝ)
    (hMeter : |actual - reading| ≤ error)
    (hGate : required ≤ reading - error) : required ≤ actual := by
  have hLower := (abs_le.mp hMeter).1
  linarith

/-- The anchor's own margin stays a per-founder obligation. Energy units
do not manufacture an incentive; this reuses the established comparison. -/
theorem energy_anchor_margin (benefit pledge activation : ℝ) :
    0 < Snuffy.FoundingAnchor.anchorPayoff benefit pledge activation ↔
      pledge + activation < benefit :=
  Snuffy.FoundingAnchor.anchor_founds_iff benefit pledge activation

end Snuffy.EnergyFounding
