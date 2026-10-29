/-
Snuffy — Canon Edition v4.1: complete workload and timing, and the bounded
range of the calibrated channel, machine-checked (working argument §§7, 11).

  * fifo_certificate — Proposition 6: for a nonpreemptive FIFO lane with
    releases r_i, actual demands a_i ≤ b_i, inherited completion C₀ ≤ F₀ and
    no unaccounted blocking, every completion satisfies C_i ≤ F_i where
    F_i = max(r_i, F_{i−1}) + b_i; every admitted deadline with F_i ≤ d_i is met.
  * fifo_tight — at upper demands the certificate is attained exactly.
  * serial_certificate — the serial-stage double induction:
    U_{i,k} = max(U_{i,k−1}, U_{i−1,k}) + τ_k(b_{i,k}) bounds every completion.
  * range_variance_bound — §11: a coordinate confined to an interval of width
    Λ/n has variance at most Λ²/(4n²); m active coordinates contribute at most
    m Λ²/(4n²) (discharges the range hypothesis of `AreaBridge.channel_cap`).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Probability.Moments.Variance
import Mathlib.Algebra.Order.Group.MinMax

open MeasureTheory ProbabilityTheory Finset

namespace Snuffy.Workload

/-! ## The FIFO completion certificate (Proposition 6) -/

/-- The certified finish recurrence `F_{i+1} = max(r_{i+1}, F_i) + b_{i+1}`. -/
def finish (F₀ : ℝ) (r b : ℕ → ℝ) : ℕ → ℝ
  | 0 => F₀
  | i + 1 => max (r (i + 1)) (finish F₀ r b i) + b (i + 1)

/-- **Proposition 6.** If actual completions obey the work-conserving FIFO law
`C_{i+1} ≤ max(r_{i+1}, C_i) + a_{i+1}` (no unaccounted blocking or idle
delay), with `C₀ ≤ F₀` and `a_i ≤ b_i`, then `C_i ≤ F_i` for every `i`. -/
theorem fifo_certificate {F₀ : ℝ} {r a b C : ℕ → ℝ} (h0 : C 0 ≤ F₀)
    (hlaw : ∀ i, C (i + 1) ≤ max (r (i + 1)) (C i) + a (i + 1)) (hab : ∀ i, a i ≤ b i) :
    ∀ i, C i ≤ finish F₀ r b i := by
  intro i
  induction i with
  | zero => exact h0
  | succ i ih =>
    calc C (i + 1) ≤ max (r (i + 1)) (C i) + a (i + 1) := hlaw i
      _ ≤ max (r (i + 1)) (finish F₀ r b i) + b (i + 1) :=
          add_le_add (max_le_max le_rfl ih) (hab (i + 1))

/-- Every admitted deadline is met: `F_i ≤ d_i` implies `C_i ≤ d_i`. -/
theorem fifo_deadlines {F₀ : ℝ} {r a b C d : ℕ → ℝ} (h0 : C 0 ≤ F₀)
    (hlaw : ∀ i, C (i + 1) ≤ max (r (i + 1)) (C i) + a (i + 1)) (hab : ∀ i, a i ≤ b i)
    (hd : ∀ i, finish F₀ r b i ≤ d i) : ∀ i, C i ≤ d i :=
  fun i => (fifo_certificate h0 hlaw hab i).trans (hd i)

/-- **Tightness.** With equality in the FIFO law, `C₀ = F₀` and every demand at
its upper bound, the certificate is attained exactly. -/
theorem fifo_tight {F₀ : ℝ} {r b C : ℕ → ℝ} (h0 : C 0 = F₀)
    (hlaw : ∀ i, C (i + 1) = max (r (i + 1)) (C i) + b (i + 1)) :
    ∀ i, C i = finish F₀ r b i := by
  intro i
  induction i with
  | zero => exact h0
  | succ i ih => rw [hlaw i, ih]; rfl

/-! ## Serial stages: the double induction -/

/-- The serial-stage recurrence over jobs `i` and stages `k`, with stage-`k`
service bound `τ i k`, boundary values `U i 0 = start i` and
`U 0 k = lead k`. -/
def serial (start lead : ℕ → ℝ) (τ : ℕ → ℕ → ℝ) : ℕ → ℕ → ℝ
  | i, 0 => start i
  | 0, k + 1 => lead (k + 1)
  | i + 1, k + 1 => max (serial start lead τ (i + 1) k) (serial start lead τ i (k + 1))
      + τ (i + 1) (k + 1)

/-- **Serial-stage certificate.** If actual completions satisfy the stage law
`C_{i+1,k+1} ≤ max(C_{i+1,k}, C_{i,k+1}) + actual service` with actual service
at most `τ`, and the boundary completions are within the boundary values, then
every completion is within `U_{i,k}`. -/
theorem serial_certificate {start lead : ℕ → ℝ} {τ σ : ℕ → ℕ → ℝ} {C : ℕ → ℕ → ℝ}
    (hstart : ∀ i, C i 0 ≤ start i) (hlead : ∀ k, C 0 (k + 1) ≤ lead (k + 1))
    (hlaw : ∀ i k, C (i + 1) (k + 1) ≤ max (C (i + 1) k) (C i (k + 1)) + σ (i + 1) (k + 1))
    (hσ : ∀ i k, σ i k ≤ τ i k) :
    ∀ i k, C i k ≤ serial start lead τ i k := by
  intro i
  induction i with
  | zero =>
    intro k
    cases k with
    | zero => simp only [serial]; exact hstart 0
    | succ k => simp only [serial]; exact hlead k
  | succ i ih =>
    intro k
    induction k with
    | zero => simp only [serial]; exact hstart (i + 1)
    | succ k ihk =>
      calc C (i + 1) (k + 1) ≤ max (C (i + 1) k) (C i (k + 1)) + σ (i + 1) (k + 1) := hlaw i k
        _ ≤ max (serial start lead τ (i + 1) k) (serial start lead τ i (k + 1))
              + τ (i + 1) (k + 1) := add_le_add (max_le_max ihk (ih (k + 1))) (hσ _ _)
        _ = serial start lead τ (i + 1) (k + 1) := by simp only [serial]

/-! ## The bounded range of the calibrated channel (§11) -/

/-- **Range variance bound.** If, conditional on the history, each active
coordinate lies in an interval of width `Λ/n`, each has variance at most
`Λ²/(4n²)`, and the `m` active coordinates together at most `m Λ²/(4n²)`. -/
theorem range_variance_bound {Ω ι : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsProbabilityMeasure μ] (active : Finset ι) (X : ι → Ω → ℝ) (lo : ι → ℝ) {Λ n : ℝ}
    (hn : 0 < n) (hmeas : ∀ i ∈ active, AEMeasurable (X i) μ)
    (hrange : ∀ i ∈ active, ∀ᵐ ω ∂μ, X i ω ∈ Set.Icc (lo i) (lo i + Λ / n)) :
    ∑ i ∈ active, variance (X i) μ ≤ active.card * (Λ ^ 2 / (4 * n ^ 2)) := by
  have hone : ∀ i ∈ active, variance (X i) μ ≤ Λ ^ 2 / (4 * n ^ 2) := by
    intro i hi
    have h := variance_le_sq_of_bounded (hrange i hi) (hmeas i hi)
    have heq : ((lo i + Λ / n - lo i) / 2) ^ 2 = Λ ^ 2 / (4 * n ^ 2) := by
      field_simp
      ring
    rw [heq] at h
    exact h
  calc ∑ i ∈ active, variance (X i) μ ≤ ∑ _i ∈ active, Λ ^ 2 / (4 * n ^ 2) := sum_le_sum hone
    _ = active.card * (Λ ^ 2 / (4 * n ^ 2)) := by rw [sum_const, nsmul_eq_mul]

end Snuffy.Workload
