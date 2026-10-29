import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Normalize measured peer and private-evidence bandwidths into a
specified mixing rule, then derive the operational bias threshold.
This does not assume that every physical scheduler uses that rule. -/
namespace GeminiThirteenBandwidth
noncomputable section

theorem normalized_susceptibility (peer sensory : ℝ)
    (peerNonnegative : 0 ≤ peer) (sensoryPositive : 0 < sensory) :
    0 ≤ peer/(peer+sensory) ∧ peer/(peer+sensory)<1 := by
  have positive : 0 < peer+sensory := by linarith
  exact ⟨div_nonneg peerNonnegative positive.le,
    (div_lt_iff₀ positive).mpr (by linarith)⟩

theorem exact_bandwidth_sensitivity (peer sensory anchorAccess : ℝ)
    (peerNonnegative : 0 ≤ peer) (sensoryPositive : 0 < sensory)
    (anchorPositive : 0 < anchorAccess) :
    (1-peer/(peer+sensory))/(1-peer/(peer+sensory)+peer/(peer+sensory)*anchorAccess)=
      sensory/(sensory+anchorAccess*peer) := by
  have total : peer+sensory ≠ 0 := by linarith
  have evidence : sensory+anchorAccess*peer ≠ 0 := by
    nlinarith [mul_nonneg anchorPositive.le peerNonnegative]
  have weights := normalized_susceptibility peer sensory peerNonnegative sensoryPositive
  have leftPositive : 0 < 1-peer/(peer+sensory)+peer/(peer+sensory)*anchorAccess := by
    nlinarith [mul_nonneg weights.1 anchorPositive.le]
  apply (div_eq_div_iff (ne_of_gt leftPositive) evidence).mpr
  field_simp
  ring

theorem finite_positive_sensory_access_remains (peer sensory anchorAccess : ℝ)
    (peerNonnegative : 0 ≤ peer) (sensoryPositive : 0 < sensory)
    (anchorNonnegative : 0 ≤ anchorAccess) :
    0 < sensory/(sensory+anchorAccess*peer) := by
  exact div_pos sensoryPositive (by nlinarith [mul_nonneg anchorNonnegative peerNonnegative])

theorem bandwidth_bias_threshold (peer sensory anchorAccess tolerance : ℝ)
    (peerNonnegative : 0 ≤ peer) (sensoryPositive : 0 < sensory)
    (anchorPositive : 0 < anchorAccess) (toleranceBelowOne : tolerance < 1) :
    tolerance ≤ anchorAccess*peer/(sensory+anchorAccess*peer) ↔
      tolerance/(anchorAccess*(1-tolerance)) ≤ peer/sensory := by
  have denominator : 0 < sensory+anchorAccess*peer := by
    nlinarith [mul_nonneg anchorPositive.le peerNonnegative]
  have thresholdDenominator : 0 < anchorAccess*(1-tolerance) :=
    mul_pos anchorPositive (sub_pos.mpr toleranceBelowOne)
  rw [le_div_iff₀ denominator,div_le_div_iff₀ thresholdDenominator sensoryPositive]
  constructor <;> intro h <;> nlinarith

end
end GeminiThirteenBandwidth

