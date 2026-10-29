/-
Snuffy — Canon Edition 4.2 working: weighted fault rates push forward to edge
rates (review objection 7.2, tightening the explicit threshold).

Circuit-level depolarizing noise gives each (location, Pauli) fault its own
rate: `p/15` for each two-qubit Pauli after a CNOT, `p/3` for each
single-qubit Pauli, and `p` for a measurement flip. A law is weighted local
stochastic with rates `r` when every set of faults is entirely present with
probability at most the product of their rates.

  * push_weighted — the induced law on detector-graph edge sets is weighted
    local stochastic with edge rate `q e = Σ_{φ x = e} r x`.
  * push_uniform — if every edge rate is at most `qmax`, the edge law is
    local stochastic at rate `qmax`: the hypothesis `fail_le_geometric`
    takes.

For the rotated surface code with the standard schedule, the enumeration
gives `qmax ≤ 6.27 p` (relevant X type) and `4.53 p` (Z type), in place of
the unweighted count `52 p`.

  * rate_iff — `2 Δ √(c p) < 1 ↔ p < 1/(4 Δ² c)` for `Δ, c > 0`.
  * tightened_threshold — with the weighted edge rate `c = 94/15` and the
    walk bound `Δ = 987/100 = 9.87`, the ratio of `fail_le_geometric` is
    below one exactly when `p < 1/(4 · 9.87² · 94/15)`, about `4.09 × 10⁻⁴`.
    The walk bound is rigorous: the maximum over all 400 interior vertices
    of the self-avoiding walk count at length 8 is
    `c₈ = 89270654 ≤ 9.87⁸`, and counts are submultiplicative, so walks of
    every length are at most `c₈ · 9.87^L`. The exact count is
    `checks/obj7-detector-graph/threshold_saw.c`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.EdgeLaw

open Finset

namespace Snuffy.WeightedEdgeLaw

open Snuffy.Threshold Snuffy.EdgeLaw

variable {Loc E : Type*} [Fintype Loc] [DecidableEq Loc] [Fintype E] [DecidableEq E]

/-- Weighted local stochastic noise. -/
def LocalStochasticW (μ : FaultLaw Loc) (r : Loc → ℝ) : Prop :=
  ∀ S : Finset Loc, prob μ (fun F => S ⊆ F) ≤ ∏ x ∈ S, r x

/-- **Weighted rates push forward to edge rates.** -/
theorem push_weighted (μ : FaultLaw Loc) (r : Loc → ℝ)
    (hμ : LocalStochasticW μ r) (φ : Loc → E) :
    LocalStochasticW (pushLaw μ φ) (fun e => ∑ x ∈ univ.filter (fun x => φ x = e), r x) := by
  intro S
  rw [prob_push]
  set fib : S → Finset Loc := fun e => univ.filter fun ℓ => φ ℓ = e.1
  set secs := Fintype.piFinset fib
  have hinj : ∀ g ∈ secs, Function.Injective g := by
    intro g hg a b hab
    have ha := (mem_filter.mp (Fintype.mem_piFinset.mp hg a)).2
    have hb := (mem_filter.mp (Fintype.mem_piFinset.mp hg b)).2
    exact Subtype.ext (by rw [← ha, ← hb, hab])
  have hpt : ∀ F, (if S ⊆ F.image φ then μ.P F else 0) ≤
      ∑ g ∈ secs, if univ.image g ⊆ F then μ.P F else 0 := by
    intro F
    split_ifs with hS
    · have hch : ∀ e : S, ∃ ℓ ∈ F, φ ℓ = e.1 := fun e => mem_image.mp (hS e.2)
      choose g hgF hgφ using hch
      have hg : g ∈ secs := Fintype.mem_piFinset.mpr fun e => mem_filter.mpr ⟨mem_univ _, hgφ e⟩
      have hsub : univ.image g ⊆ F := by
        intro ℓ hℓ; obtain ⟨e, -, rfl⟩ := mem_image.mp hℓ; exact hgF e
      have := single_le_sum (f := fun g => if univ.image g ⊆ F then μ.P F else 0)
        (fun g _ => by split_ifs <;> simp [μ.nonneg F]) hg
      simp only [hsub, ↓reduceIte] at this
      exact this
    · exact sum_nonneg fun g _ => by split_ifs <;> simp [μ.nonneg F]
  calc prob μ (fun F => S ⊆ F.image φ)
      ≤ ∑ F, ∑ g ∈ secs, (if univ.image g ⊆ F then μ.P F else 0) := sum_le_sum fun F _ => hpt F
    _ = ∑ g ∈ secs, prob μ (fun F => univ.image g ⊆ F) := by rw [sum_comm]; rfl
    _ ≤ ∑ g ∈ secs, ∏ e : S, r (g e) := by
        refine sum_le_sum fun g hg => ?_
        have := hμ (univ.image g)
        rwa [prod_image (fun a _ b _ h => hinj g hg h)] at this
    _ = ∏ e : S, ∑ x ∈ fib e, r x := (prod_univ_sum fib (fun e x => r x)).symm
    _ = ∏ e ∈ S, ∑ x ∈ univ.filter (fun x => φ x = e), r x :=
        prod_coe_sort S (fun e => ∑ x ∈ univ.filter (fun x => φ x = e), r x)

/-- **Uniformly bounded edge rates give local stochastic edge noise.** -/
theorem push_uniform (μ : FaultLaw Loc) (r : Loc → ℝ) (hr : ∀ x, 0 ≤ r x)
    (hμ : LocalStochasticW μ r) (φ : Loc → E) {qmax : ℝ}
    (hq : ∀ e, ∑ x ∈ univ.filter (fun x => φ x = e), r x ≤ qmax) :
    LocalStochastic (pushLaw μ φ) qmax := by
  intro S
  calc prob (pushLaw μ φ) (fun F => S ⊆ F) ≤ ∏ e ∈ S, ∑ x ∈ univ.filter (fun x => φ x = e), r x :=
        push_weighted μ r hμ φ S
    _ ≤ ∏ _e ∈ S, qmax := prod_le_prod₀ (fun e _ => sum_nonneg fun x _ => hr x) (fun e _ => hq e)
    _ = qmax ^ S.card := prod_const _

/-- **The contraction ratio in closed form.** -/
theorem rate_iff {Δ c p : ℝ} (hΔ : 0 < Δ) (hc : 0 < c) (hp : 0 ≤ p) :
    2 * Δ * Real.sqrt (c * p) < 1 ↔ p < 1 / (4 * Δ ^ 2 * c) := by
  have hk : 0 < 4 * Δ ^ 2 * c := by positivity
  rw [lt_div_iff₀ hk]
  constructor
  · intro h
    have h0 : 0 ≤ 2 * Δ * Real.sqrt (c * p) := by positivity
    have hsq : (2 * Δ * Real.sqrt (c * p)) ^ 2 < 1 := by nlinarith
    rw [mul_pow, mul_pow, Real.sq_sqrt (by positivity)] at hsq
    nlinarith
  · intro h
    have hsq : (2 * Δ * Real.sqrt (c * p)) ^ 2 < 1 := by
      rw [mul_pow, mul_pow, Real.sq_sqrt (by positivity)]; nlinarith
    have h0 : 0 ≤ 2 * Δ * Real.sqrt (c * p) := by positivity
    nlinarith

/-- **The tightened explicit threshold.** -/
theorem tightened_threshold {p : ℝ} (hp : 0 ≤ p) :
    2 * (987 / 100) * Real.sqrt ((94 / 15) * p) < 1 ↔
      p < 1 / (4 * (987 / 100) ^ 2 * (94 / 15)) :=
  rate_iff (by norm_num) (by norm_num) hp

/-- The walk bound: `c₈ = 89270654 ≤ 9.87⁸`. -/
theorem walk_bound : (89270654 : ℝ) ≤ (987 / 100) ^ 8 := by norm_num

/-- The threshold exceeds `4 × 10⁻⁴`. -/
theorem threshold_value : (4 : ℝ) / 10000 < 1 / (4 * (987 / 100) ^ 2 * (94 / 15)) := by norm_num

end Snuffy.WeightedEdgeLaw
