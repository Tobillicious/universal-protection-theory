/-
Snuffy — Canon Edition v4.1: bridge 7, the consensus contraction in bandwidth
terms.

With peer rate `R ≥ 0`, private sensory rate `B > 0` and anchor access
`0 < a ≤ 1`, the scheduler's peer weight is `w = R/(R + B)`
(`BandwidthReflection`). The actual Friedkin–Johnsen update (`BridgeH7`) then
contracts with constant `k = R(1 − a)/(R + B) ∈ [0, 1)`, has a unique fixed
point, and every run approaches it as `kⁿ` (`bandwidth_contraction`).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.BridgeH7

namespace Snuffy.ConsensusRate

open GeminiBridgeH7

/-- **Bridge 7.** The consensus update with bandwidth-normalised peer weight is
a contraction with constant `R(1 − a)/(R + B) < 1`, and every run converges to
the unique fixed point geometrically at that rate. -/
theorem bandwidth_contraction {R B a : ℝ} (hR : 0 ≤ R) (hB : 0 < B) (ha : 0 < a)
    (haOne : a ≤ 1) (anchor evidence initial : ℝ) :
    rate a (R / (R + B)) = R * (1 - a) / (R + B) ∧
      0 ≤ rate a (R / (R + B)) ∧ rate a (R / (R + B)) < 1 ∧
      (∀ s, step a (R / (R + B)) anchor evidence s = s →
        s = equilibrium a (R / (R + B)) anchor evidence) ∧
      ∀ n, run a (R / (R + B)) anchor evidence initial n
          - equilibrium a (R / (R + B)) anchor evidence =
        rate a (R / (R + B)) ^ n
          * (initial - equilibrium a (R / (R + B)) anchor evidence) := by
  have hRB : 0 < R + B := by linarith
  have hw0 : 0 ≤ R / (R + B) := div_nonneg hR hRB.le
  have hw1 : R / (R + B) ≤ 1 := (div_le_one hRB).mpr (by linarith)
  have hb := rate_bounds a _ ha haOne hw0 hw1
  have hd : denominator a (R / (R + B)) ≠ 0 :=
    (denominator_positive a _ ha haOne hw0 hw1).ne'
  refine ⟨by unfold rate; ring, hb.1, hb.2, fun s hs => fixed_point_unique a _ anchor evidence s hd hs,
    fun n => exact_transient a _ anchor evidence initial hd n⟩

end Snuffy.ConsensusRate
