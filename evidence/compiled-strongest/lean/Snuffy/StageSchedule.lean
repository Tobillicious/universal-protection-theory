/-
Snuffy — Canon Edition 4.2 working: accounting for the doubling schedule of a
passive memory whose stages are joined by transfers (quantum-coherence
holding branch; pātai 4).

Stage `j` holds the record for duration `2^j` in a code of size `n_j`, and
then transfers it into the code of stage `j + 1`. For a passive memory with
`‖Φ_t∘Enc − Enc‖₁ ≤ t · exp(−c n^η)` (arXiv:2605.10943, Theorem 1.1), the
stage's holding failure is at most `2^j · exp(−c n_j^η)`, which the duration
factor makes explicit. It is below `ε / 2^(j+2)` once
`c n_j^η ≥ (2j + 2) ln 2 + ln(1/ε)`.

  * total_with_transfers — if each stage's holding and transfer failures are
    each at most `ε / 2^(j+2)`, the total failure over every number of
    stages is at most `ε`.
  * stage_cost_le — per-stage cost `(a + b j)^κ`, polynomial in the stage's
    code size, sums over `J` stages to at most `J (a + b J)^κ`. With
    `J = log₂ t + 1` this is polylogarithmic in age.

The transfer gadget itself, with failure at most `ε / 2^(j+2)` and cost
polynomial in `n_{j+1}`, is the remaining input (pātai 1–3).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.PassiveReference

open Finset

namespace Snuffy.StageSchedule

/-- **Holding and transfer failures over all stages stay at most `ε`.** -/
theorem total_with_transfers {ε : ℝ} (hε : 0 ≤ ε) (J : ℕ) (hold xfer : ℕ → ℝ)
    (hh : ∀ j, hold j ≤ ε / 2 ^ (j + 2)) (hx : ∀ j, xfer j ≤ ε / 2 ^ (j + 2)) :
    ∑ j ∈ range J, (hold j + xfer j) ≤ ε := by
  calc ∑ j ∈ range J, (hold j + xfer j) ≤ ∑ j ∈ range J, ε / 2 ^ (j + 1) := by
        refine sum_le_sum fun j _ => ?_
        have h2 : ε / 2 ^ (j + 2) + ε / 2 ^ (j + 2) = ε / 2 ^ (j + 1) := by
          rw [pow_succ 2 (j + 1)]; field_simp; ring
        linarith [hh j, hx j]
    _ ≤ ε := Snuffy.PassiveReference.total_failure_le hε J

/-- **Polynomial per-stage cost sums to a polylogarithm of age.** -/
theorem stage_cost_le (a b κ J : ℕ) : ∑ j ∈ range J, (a + b * j) ^ κ ≤ J * (a + b * J) ^ κ := by
  calc ∑ j ∈ range J, (a + b * j) ^ κ ≤ ∑ _j ∈ range J, (a + b * J) ^ κ :=
        sum_le_sum fun j hj => Nat.pow_le_pow_left
          (Nat.add_le_add_left (Nat.mul_le_mul_left b (mem_range.mp hj).le) a) κ
    _ = J * (a + b * J) ^ κ := by rw [sum_const, card_range, smul_eq_mul]

end Snuffy.StageSchedule
