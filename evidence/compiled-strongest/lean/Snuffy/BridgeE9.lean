import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! Local protection through the detection interval, the exact wave-race
margin, and the non-injectivity of the actual directed-cycle incidence
operator. Timing and conservation are kept as separate mechanisms. -/
namespace GeminiBridgeE9
noncomputable section

theorem reaction_before_damage (distance signalSpeed harmSpeed reroute : ℝ)
    (positiveSignal : 0 < signalSpeed) (positiveHarm : 0 < harmSpeed) :
    distance/signalSpeed+reroute < distance/harmSpeed ↔
      reroute < distance*(signalSpeed-harmSpeed)/(harmSpeed*signalSpeed) := by
  have gap : distance/harmSpeed-distance/signalSpeed =
      distance*(signalSpeed-harmSpeed)/(harmSpeed*signalSpeed) := by
    field_simp
  rw [← gap]
  constructor <;> intro h <;> linarith

theorem positive_propagation_margin (distance signalSpeed harmSpeed : ℝ)
    (positiveDistance : 0 < distance) (positiveHarm : 0 < harmSpeed)
    (faster : harmSpeed < signalSpeed) :
    0 < distance*(signalSpeed-harmSpeed)/(harmSpeed*signalSpeed) := by
  exact div_pos (mul_pos positiveDistance (sub_pos.mpr faster))
    (mul_pos positiveHarm (lt_trans positiveHarm faster))

/-- The local reserve covers every instant before completed reaction,
not only the final tick or the first alarm. -/
theorem local_buffer_covers_entire_reaction
    (buffer production detect reroute elapsed : ℝ)
    (productionNonnegative : 0 ≤ production)
    (covered : production*(detect+reroute) ≤ buffer)
    (beforeReaction : elapsed ≤ detect+reroute) :
    0 ≤ buffer-production*elapsed := by
  have consumption := mul_le_mul_of_nonneg_left beforeReaction productionNonnegative
  linarith

theorem escrow_prevents_pre_detection_application (detect commit applied : ℝ)
    (escrow : detect ≤ commit) (afterCommit : commit ≤ applied) : detect ≤ applied :=
  le_trans escrow afterCommit

/-- Boundary of the directed cycle 0->1->2->0, with its three edge flows. -/
def boundary (f01 f12 f20 : ℝ) : ℝ × ℝ × ℝ :=
  (f01-f20,f12-f01,f20-f12)

theorem incidence_has_circulation_kernel (circulation : ℝ) :
    boundary circulation circulation circulation=(0,0,0) := by
  simp [boundary]

theorem lost_circulation_need_not_change_divergence :
    boundary 1 1 1=boundary 0 0 0 ∧
    ((1,1,1) : ℝ × ℝ × ℝ) ≠ (0,0,0) := by
  norm_num [boundary]

end
end GeminiBridgeE9

