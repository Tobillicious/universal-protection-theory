/-
Snuffy — Canon Edition 4.2 working: indefinite holding of a classical
reference at fixed failure ε, with sublinear total cost (review objection 7,
item 5; holding).

The protector's reference record of a particular is stored passively and
rewritten at ages `2^j`. Stage `j` lasts `2^j`. Its barrier is chosen so that
the stage fails with probability at most `ε / 2^(j+1)`; a barrier
`k_B T (2 j ln 2 + ln(1/ε))` above the attempt scale suffices by Arrhenius,
so the stage's rewrite cost is affine in `j`. Comparing the particular with
the reference costs a constant per step, and a faulty comparison or false
repair is transient: the intact reference corrects it at the next comparison
(`E9SelfHealing`).

  * stages_cover — `J = log₂ t + 1` stages cover every age `t`.
  * total_failure_le — the failure over all stages is at most `ε`, for every
    number of stages: the failure does not grow with age.
  * total_rewrite_cost — the rewrite cost over `J` stages is at most
    `(a + b J) J`, which is `O(log² t)`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Data.Nat.Log

open Finset

namespace Snuffy.PassiveReference

/-- **The doubling stages cover every age.** -/
theorem stages_cover (t : ℕ) : t < ∑ j ∈ range (Nat.log 2 t + 1), 2 ^ j + 1 := by
  have h := Nat.lt_pow_succ_log_self (b := 2) (by norm_num) t
  have hg : ∑ j ∈ range (Nat.log 2 t + 1), 2 ^ j + 1 = 2 ^ (Nat.log 2 t + 1) := by
    have := Nat.geomSum_eq (m := 2) (by norm_num) (Nat.log 2 t + 1)
    omega
  omega

/-- **Failure over all stages stays at most `ε`.** -/
theorem total_failure_le {ε : ℝ} (hε : 0 ≤ ε) (J : ℕ) :
    ∑ j ∈ range J, ε / 2 ^ (j + 1) ≤ ε := by
  have hs : ∑ j ∈ range J, ((1 : ℝ) / 2) ^ j ≤ 2 := sum_geometric_two_le J
  calc ∑ j ∈ range J, ε / 2 ^ (j + 1) = ε / 2 * ∑ j ∈ range J, ((1 : ℝ) / 2) ^ j := by
        rw [mul_sum]; refine sum_congr rfl fun j _ => ?_
        rw [pow_succ, div_pow, one_pow]; field_simp
    _ ≤ ε / 2 * 2 := mul_le_mul_of_nonneg_left hs (by positivity)
    _ = ε := by ring

/-- **The total rewrite cost is `O(J²)`, so `O(log² t)`.** -/
theorem total_rewrite_cost (a b J : ℕ) : ∑ j ∈ range J, (a + b * j) ≤ (a + b * J) * J := by
  calc ∑ j ∈ range J, (a + b * j) ≤ ∑ _j ∈ range J, (a + b * J) :=
        sum_le_sum fun j hj => by
          have := mem_range.mp hj
          exact Nat.add_le_add_left (Nat.mul_le_mul_left b this.le) a
    _ = (a + b * J) * J := by rw [sum_const, card_range, smul_eq_mul, mul_comm]

end Snuffy.PassiveReference
