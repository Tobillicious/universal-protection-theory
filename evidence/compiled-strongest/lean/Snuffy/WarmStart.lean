/-
Snuffy — Canon Edition 4.2 working: a warm start keeps the stationary failure
bound for all time (quantum-coherence holding branch; the initialisation
problem in its correct form).

For a CSS stabilizer Hamiltonian under Davies dynamics with Pauli jump
operators, the syndrome configuration evolves as a classical Markov chain
whose stationary law `π` is the thermal syndrome distribution. A prepared
initial law `μ` is a warm start with constant `C` when `μ ≤ C π` pointwise.
That is the max-divergence condition, `D_max(μ‖π) ≤ log C`.

  * warm_start — a warm start stays dominated: at every time
    `μ Kᵗ ≤ C π` pointwise.
  * warm_start_event — every event `A`, in particular "the syndrome is
    unstable under the decoder", has probability at most `C · π(A)` at every
    time. With `C = poly(n)` and `π(unstable) ≤ e^{−Θ(n^η)}`
    (arXiv:2605.10943, Theorem 2.6), the stationary bound survives intact.

The empty syndrome is not a warm start, since its constant is
`1/π(∅) = e^{Θ(n)}`. The remaining problem is to prepare a warm start with a
polynomial constant: to sample the metacheck-constrained thermal syndrome
distribution within a polynomial pointwise ratio. With independent
generators that distribution is a product, and exact preparation is a
classical sample followed by a layer of Pauli operators.

The fibre lemmas below use the actual coarse marginal, rather than the
unrenormalised coarse Gibbs law. They also construct a stationary heat-bath
kernel for any partition of the globally valid finite state space. Neither
stationarity nor bounded local energy proves a mixing rate. The final two
lemmas give the pointwise conversion with the indispensable probability
floor: an absolute error at most that floor yields a factor-two warm start.
The BDL all-level mixing/sampling certificate remains an application to
establish, not a premise declared discharged by these algebraic lemmas.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold

open Finset

namespace Snuffy.WarmStart

variable {S : Type*} [Fintype S]

/-- One step of the chain with kernel `K`, acting on a law. -/
def step (K : S → S → ℝ) (μ : S → ℝ) : S → ℝ := fun y => ∑ x, μ x * K x y

/-- **A warm start stays dominated at every time.** -/
theorem warm_start (K : S → S → ℝ) (hK : ∀ x y, 0 ≤ K x y) (π μ : S → ℝ)
    (hπ : step K π = π) {C : ℝ} (hμ : ∀ x, μ x ≤ C * π x) :
    ∀ t y, (step K)^[t] μ y ≤ C * π y := by
  intro t
  induction t with
  | zero => exact hμ
  | succ t ih =>
      intro y
      rw [Function.iterate_succ_apply']
      calc step K ((step K)^[t] μ) y = ∑ x, (step K)^[t] μ x * K x y := rfl
        _ ≤ ∑ x, C * π x * K x y := sum_le_sum fun x _ => mul_le_mul_of_nonneg_right (ih x) (hK x y)
        _ = C * step K π y := by unfold step; rw [mul_sum]; refine sum_congr rfl fun x _ => by ring
        _ = C * π y := by rw [hπ]

/-- **Every event keeps the stationary bound up to the warm-start constant.** -/
theorem warm_start_event (K : S → S → ℝ) (hK : ∀ x y, 0 ≤ K x y) (π μ : S → ℝ)
    (hπ : step K π = π) {C : ℝ} (hμ : ∀ x, μ x ≤ C * π x) (A : Finset S) (t : ℕ) :
    ∑ y ∈ A, (step K)^[t] μ y ≤ C * ∑ y ∈ A, π y := by
  rw [mul_sum]
  exact sum_le_sum fun y _ => warm_start K hK π μ hπ hμ t y

section Fibres

variable {T : Type*} [DecidableEq T]

/-- The actual push-forward mass of a coarse state. -/
def fibre_mass (r : S → T) (π : S → ℝ) (c : T) : ℝ :=
  ∑ x, if r x = c then π x else 0

/-- The fine conditional within a coarse fibre; empty fibres receive zero. -/
noncomputable def fibre_conditional (r : S → T) (π : S → ℝ) (c : T) (x : S) : ℝ :=
  if r x = c then π x / fibre_mass r π c else 0

/-- Assemble a fine law from a coarse proposal and a conditional kernel. -/
def assemble [Fintype T] (q : T → ℝ) (L : T → S → ℝ) (x : S) : ℝ := ∑ c, q c * L c x

/-- Every occupied fibre of a strictly positive law has positive mass. -/
theorem fibre_mass_pos (r : S → T) (π : S → ℝ) (hπ : ∀ x, 0 < π x) (x : S) :
    0 < fibre_mass r π (r x) := by
  have hn : ∀ y ∈ (univ : Finset S),
      0 ≤ if r y = r x then π y else 0 := by
    intro y _
    split_ifs
    · exact le_of_lt (hπ y)
    · exact le_refl 0
  have hterm : π x ≤ fibre_mass r π (r x) := by
    simpa [fibre_mass] using single_le_sum hn (mem_univ x)
  exact lt_of_lt_of_le (hπ x) hterm

/-- Disintegration is exact only with the actual coarse marginal. -/
theorem fibre_reassembly [Fintype T] (r : S → T) (π : S → ℝ) (hπ : ∀ x, 0 < π x) (x : S) :
    assemble (fibre_mass r π) (fibre_conditional r π) x = π x := by
  unfold assemble
  rw [sum_eq_single (r x)]
  · simp only [fibre_conditional, ite_true]
    have hn := ne_of_gt (fibre_mass_pos r π hπ x)
    field_simp
  · intro c _ hc
    simp [fibre_conditional, Ne.symm hc]
  · simp

/-- Coarse and fine one-sided pointwise factors multiply. This is the
reverse-sampler estimate for the renormalised measure. -/
theorem reverse_sampler_bound [Fintype T] (r : S → T) (π : S → ℝ) (hπ : ∀ x, 0 < π x)
    (q : T → ℝ) (hq : ∀ c, 0 ≤ q c) (L : T → S → ℝ) {C D : ℝ} (hD : 0 ≤ D)
    (hcoarse : ∀ c, q c ≤ C * fibre_mass r π c)
    (hfine : ∀ c x, L c x ≤ D * fibre_conditional r π c x) (x : S) :
    assemble q L x ≤ (C * D) * π x := by
  have hc (c : T) : 0 ≤ fibre_conditional r π c x := by
    unfold fibre_conditional
    split_ifs with h
    · rw [← h]
      exact div_nonneg (le_of_lt (hπ x)) (le_of_lt (fibre_mass_pos r π hπ x))
    · exact le_refl 0
  calc
    assemble q L x ≤ ∑ c, q c * (D * fibre_conditional r π c x) :=
      sum_le_sum fun c _ => mul_le_mul_of_nonneg_left (hfine c x) (hq c)
    _ ≤ ∑ c, (C * fibre_mass r π c) * (D * fibre_conditional r π c x) :=
      sum_le_sum fun c _ => mul_le_mul_of_nonneg_right (hcoarse c) (mul_nonneg hD (hc c))
    _ = (C * D) * assemble (fibre_mass r π) (fibre_conditional r π) x := by
      unfold assemble
      rw [mul_sum]
      exact sum_congr rfl fun c _ => by ring
    _ = (C * D) * π x := by rw [fibre_reassembly r π hπ x]

/-- A heat-bath row samples exactly within its partition class. Choosing
the class by the outside configuration preserves every global constraint
already encoded in the state type S. -/
theorem heat_bath_normalized (r : S → T) (π : S → ℝ) (hπ : ∀ x, 0 < π x) (x : S) :
    ∑ y, fibre_conditional r π (r x) y = 1 := by
  calc
    (∑ y, fibre_conditional r π (r x) y)
        = (∑ y, if r y = r x then π y else 0) / fibre_mass r π (r x) := by
      simp only [div_eq_mul_inv, sum_mul]
      refine sum_congr rfl fun y _ => ?_
      unfold fibre_conditional
      split_ifs <;> simp [div_eq_mul_inv]
    _ = 1 := div_self (ne_of_gt (fibre_mass_pos r π hπ x))

/-- Exact Gibbs resampling preserves the target law. This proves
stationarity, not convergence from an arbitrary initial preparation. -/
theorem heat_bath_stationary (r : S → T) (π : S → ℝ) (hπ : ∀ x, 0 < π x) :
    step (fun x y => fibre_conditional r π (r x) y) π = π := by
  have balance (x y : S) :
      π x * fibre_conditional r π (r x) y =
        π y * fibre_conditional r π (r y) x := by
    by_cases h : r x = r y
    · simp only [fibre_conditional, h, ite_true]
      ring
    · simp [fibre_conditional, h, Ne.symm h]
  funext y
  calc
    step (fun x y => fibre_conditional r π (r x) y) π y
        = ∑ x, π y * fibre_conditional r π (r y) x :=
      sum_congr rfl fun x _ => balance x y
    _ = π y * ∑ x, fibre_conditional r π (r y) x := (mul_sum _ _ _).symm
    _ = π y := by rw [heat_bath_normalized r π hπ y, mul_one]

end Fibres

omit [Fintype S] in
/-- Absolute probability error converts to a density factor only after
division by a positive probability floor. -/
theorem pointwise_from_absolute (π μ : S → ℝ) {m δ : ℝ} (hm : 0 < m) (hδ : 0 ≤ δ)
    (hfloor : ∀ x, m ≤ π x) (herror : ∀ x, |μ x - π x| ≤ δ) (x : S) :
    μ x ≤ (1 + δ / m) * π x := by
  have hdiff : μ x - π x ≤ δ := (le_abs_self _).trans (herror x)
  have hscaled : δ ≤ δ / m * π x := by
    calc
      δ = δ / m * m := (div_mul_cancel₀ δ (ne_of_gt hm)).symm
      _ ≤ δ / m * π x :=
        mul_le_mul_of_nonneg_left (hfloor x) (div_nonneg hδ (le_of_lt hm))
  nlinarith

/-- Once a mixing estimate reaches the target's probability floor,
the prepared law is a factor-two warm start for every later time. -/
theorem warm_start_from_mixing (K : S → S → ℝ) (hK : ∀ x y, 0 ≤ K x y) (π μ₀ : S → ℝ)
    (hπ : step K π = π) {m δ : ℝ} (hfloor : ∀ x, m ≤ π x) (hδ : δ ≤ m) (s : ℕ)
    (herror : ∀ x, |(step K)^[s] μ₀ x - π x| ≤ δ) :
    ∀ t x, (step K)^[t] ((step K)^[s] μ₀) x ≤ 2 * π x := by
  apply warm_start K hK π ((step K)^[s] μ₀) hπ
  intro x
  have hdiff : (step K)^[s] μ₀ x - π x ≤ δ := (le_abs_self _).trans (herror x)
  have hf := hfloor x
  linarith

end Snuffy.WarmStart
