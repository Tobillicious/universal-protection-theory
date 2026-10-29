import Mathlib

/-!
# Funding a growing bill to the horizon (Part XI hypothesis 4 repair)

Gate C-∞ prices a constant bill. The wavefront's boundary bill grows, so the
endowment form needs the present value of a growing bill. With return `r ≥ 0` the
balance evolves as `e' = (1 + r)(e - b t)`. `pv k t` is the present value at time `t`
of the next `k` bills, defined backward: `pv 0 t = 0`, `pv (k+1) t = b t + pv k (t+1)/(1+r)`.

* `endowment_suffices` — an endowment at least `pv k t` pays every one of the next
  `k` bills on time;
* `polynomial_bill_summable` — for a polynomially growing bill and `r > 0` the
  discounted bills are summable, so the infinite-horizon endowment is finite.
-/

namespace Snuffy.GrowingBill

variable (b : ℕ → ℝ) (r : ℝ)

/-- Present value at time `t` of the next `k` bills. -/
noncomputable def pv : ℕ → ℕ → ℝ
  | 0, _ => 0
  | k + 1, t => b t + pv k (t + 1) / (1 + r)

/-- Balance after `j` epochs, starting with `e` at time `t`. -/
noncomputable def bal (e : ℝ) (t : ℕ) : ℕ → ℝ
  | 0 => e
  | j + 1 => bal ((1 + r) * (e - b t)) (t + 1) j

theorem pv_nonneg (hb : ∀ t, 0 ≤ b t) (hr : 0 ≤ r) : ∀ k t, 0 ≤ pv b r k t := by
  intro k
  induction k with
  | zero => intro t; simp [pv]
  | succ k ih =>
    intro t
    simp only [pv]
    have := ih (t + 1)
    have h1 : 0 < 1 + r := by linarith
    have := div_nonneg this h1.le
    linarith [hb t]

/-- **An endowment at the present value pays every bill.** -/
theorem endowment_suffices (hb : ∀ t, 0 ≤ b t) (hr : 0 ≤ r) :
    ∀ k t e, pv b r k t ≤ e → ∀ j < k, b (t + j) ≤ bal b r e t j := by
  intro k
  induction k with
  | zero => intro t e _ j hj; exact absurd hj (Nat.not_lt_zero j)
  | succ k ih =>
    intro t e he j hj
    have h1 : 0 < 1 + r := by linarith
    have hpv : pv b r (k + 1) t = b t + pv b r k (t + 1) / (1 + r) := rfl
    have hrest := pv_nonneg b r hb hr k (t + 1)
    cases j with
    | zero =>
      simp only [bal, Nat.add_zero]
      have : 0 ≤ pv b r k (t + 1) / (1 + r) := div_nonneg hrest h1.le
      linarith
    | succ j =>
      have hnext : pv b r k (t + 1) ≤ (1 + r) * (e - b t) := by
        have h2 : pv b r k (t + 1) / (1 + r) ≤ e - b t := by linarith
        rw [div_le_iff₀ h1] at h2
        linarith
      have := ih (t + 1) ((1 + r) * (e - b t)) hnext j (Nat.lt_of_succ_lt_succ hj)
      rw [show t + (j + 1) = t + 1 + j by omega]
      exact this

/-- A polynomially growing bill, discounted at `r > 0`, is summable. -/
theorem polynomial_bill_summable (k : ℕ) (hr : 0 < r) :
    Summable (fun t : ℕ => (t : ℝ) ^ k * ((1 + r)⁻¹) ^ t) := by
  have h1 : 0 < 1 + r := by linarith
  have hlt : ‖(1 + r)⁻¹‖ < 1 := by
    rw [Real.norm_eq_abs, abs_of_pos (inv_pos.mpr h1)]
    exact inv_lt_one_of_one_lt₀ (by linarith)
  exact summable_pow_mul_geometric_of_norm_lt_one k hlt

end Snuffy.GrowingBill
