/-
Snuffy — Canon Edition 4.2 working: the explicit threshold from the length-9
walk count (review objection 7.2; G.20).

The exact maximum, over all interior vertices of the relevant d = 9
detector graph, of the self-avoiding walk count at length 9 is
`c₉ = 763504745` (`checks/obj7-detector-graph/threshold_saw.c`). Counts are
submultiplicative, so walks of every length are at most `c₉ · 9.71^L`.

  * walk_bound_9 — `c₉ ≤ 9.71⁹`.
  * threshold_9 — with the weighted edge rate `94/15`, the ratio of
    `Threshold.fail_le_geometric` is below one exactly when
    `p < 1/(4 · 9.71² · 94/15)` (`WeightedEdgeLaw.rate_iff`).
  * threshold_9_value — this exceeds `4.2 × 10⁻⁴`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.WeightedEdgeLaw

namespace Snuffy.WalkBound9

/-- **The length-9 walk bound.** -/
theorem walk_bound_9 : (763504745 : ℝ) ≤ (971 / 100) ^ 9 := by norm_num

/-- **The explicit threshold at walk bound 9.71.** -/
theorem threshold_9 {p : ℝ} (hp : 0 ≤ p) :
    2 * (971 / 100) * Real.sqrt ((94 / 15) * p) < 1 ↔
      p < 1 / (4 * (971 / 100) ^ 2 * (94 / 15)) :=
  Snuffy.WeightedEdgeLaw.rate_iff (by norm_num) (by norm_num) hp

/-- **The threshold exceeds `4.2 × 10⁻⁴`.** -/
theorem threshold_9_value : (42 : ℝ) / 100000 < 1 / (4 * (971 / 100) ^ 2 * (94 / 15)) := by
  norm_num

end Snuffy.WalkBound9
