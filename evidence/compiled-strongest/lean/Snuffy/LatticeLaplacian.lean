/-
Snuffy — Canon Edition v4.1: bridge 11, the continuum step for the graph
Laplacian of the cubic lattice.

  * second_difference — if `F` is differentiable with derivative `F'` and
    `F'` is differentiable at `x` with derivative `a`, the lattice second
    difference `(F(x+h) − 2F(x) + F(x−h))/h²` tends to `a = F''(x)` as the
    spacing `h → 0` (Cauchy's mean value theorem; no Taylor remainder assumed).
  * lattice_laplacian — on the cubic lattice of spacing `h` in `d` dimensions,
    the graph Laplacian `Σᵢ (f(x+heᵢ) − 2f(x) + f(x−heᵢ))/h²` tends to the
    Laplacian `Σᵢ ∂ᵢ²f(x)`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.Calculus.Deriv.Pow

open Filter Topology Set

namespace Snuffy.LatticeLaplacian

/-- The symmetric slope of `F'` tends to `F''(x)`. -/
lemma symmetric_slope {F' : ℝ → ℝ} {a x : ℝ} (hF' : HasDerivAt F' a x) :
    Tendsto (fun c => (F' (x + c) - F' (x - c)) / (2 * c)) (𝓝[≠] 0) (𝓝 a) := by
  have hs := hasDerivAt_iff_tendsto_slope.mp hF'
  have hp : Tendsto (fun c : ℝ => x + c) (𝓝[≠] 0) (𝓝[≠] x) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ?_ ?_
    · exact tendsto_nhdsWithin_of_tendsto_nhds (by simpa using (tendsto_const_nhds (x := x)).add (tendsto_id (x := 𝓝 (0:ℝ))))
    · filter_upwards [self_mem_nhdsWithin] with c hc
      simpa using hc
  have hm : Tendsto (fun c : ℝ => x - c) (𝓝[≠] 0) (𝓝[≠] x) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ?_ ?_
    · exact tendsto_nhdsWithin_of_tendsto_nhds (by simpa using (tendsto_const_nhds (x := x)).sub (tendsto_id (x := 𝓝 (0:ℝ))))
    · filter_upwards [self_mem_nhdsWithin] with c hc
      simpa [sub_eq_self] using hc
  have hsum := ((hs.comp hp).add (hs.comp hm)).div_const 2
  rw [show (a + a) / 2 = a by ring] at hsum
  refine hsum.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with c hc
  have hc' : c ≠ 0 := hc
  simp only [Function.comp_apply, slope_def_field]
  rw [add_sub_cancel_left, sub_sub_cancel_left]
  field_simp
  ring

/-- Cauchy's mean value step: for `h > 0` the ratio equals a symmetric slope
at some `c ∈ (0, h)`. -/
lemma ratio_eq_slope {F F' : ℝ → ℝ} (hF : ∀ y, HasDerivAt F (F' y) y) (x : ℝ) {h : ℝ}
    (hh : 0 < h) : ∃ c ∈ Ioo 0 h,
      (F (x + h) - 2 * F x + F (x - h)) / h ^ 2 = (F' (x + c) - F' (x - c)) / (2 * c) := by
  set G : ℝ → ℝ := fun t => F (x + t) + F (x - t) - 2 * F x
  have hG : ∀ t, HasDerivAt G (F' (x + t) - F' (x - t)) t := by
    intro t
    have h1 := (hF (x + t)).comp t ((hasDerivAt_id t).const_add x)
    have h2 := (hF (x - t)).comp t ((hasDerivAt_id t).const_sub x)
    convert (h1.add h2).sub_const (2 * F x) using 1
    · funext s
      simp only [G, Function.comp_apply, Pi.add_apply]
    · ring
  have hk : ∀ t, HasDerivAt (fun t : ℝ => t ^ 2) (2 * t) t := fun t => by
    simpa using hasDerivAt_pow 2 t
  obtain ⟨c, hc, hcE⟩ := exists_ratio_hasDerivAt_eq_ratio_slope (fun t : ℝ => t ^ 2)
    (fun t => 2 * t) hh (continuous_pow 2).continuousOn (fun t _ => hk t) G
    (fun t => F' (x + t) - F' (x - t)) (fun t _ => (hG t).continuousAt.continuousWithinAt)
    (fun t _ => hG t)
  refine ⟨c, hc, ?_⟩
  have hc0 : c ≠ 0 := hc.1.ne'
  have hG0 : G 0 = 0 := by simp [G]; ring
  simp only [G] at hcE hG0
  rw [div_eq_div_iff (by positivity) (by positivity)]
  simp only [add_zero, sub_zero] at hcE
  nlinarith [hcE]

/-- **The lattice second difference tends to the second derivative.** -/
theorem second_difference {F F' : ℝ → ℝ} {a x : ℝ} (hF : ∀ y, HasDerivAt F (F' y) y)
    (hF' : HasDerivAt F' a x) :
    Tendsto (fun h => (F (x + h) - 2 * F x + F (x - h)) / h ^ 2) (𝓝[≠] 0) (𝓝 a) := by
  have hφ := symmetric_slope hF'
  rw [Metric.tendsto_nhdsWithin_nhds] at hφ ⊢
  intro ε hε
  obtain ⟨δ, hδ, hball⟩ := hφ ε hε
  refine ⟨δ, hδ, fun h hh hdist => ?_⟩
  have hh0 : h ≠ 0 := hh
  rw [Real.dist_eq, sub_zero] at hdist
  -- the ratio is even in h
  have heven : (F (x + h) - 2 * F x + F (x - h)) / h ^ 2
      = (F (x + |h|) - 2 * F x + F (x - |h|)) / |h| ^ 2 := by
    rcases le_or_gt 0 h with h0 | h0
    · rw [abs_of_nonneg h0]
    · rw [abs_of_neg h0, neg_sq, sub_neg_eq_add, ← sub_eq_add_neg]; ring
  obtain ⟨c, hc, hEq⟩ := ratio_eq_slope hF x (abs_pos.mpr hh0)
  rw [heven, hEq]
  apply hball (hc.1.ne')
  rw [Real.dist_eq, sub_zero, abs_of_pos hc.1]
  linarith [hc.2]

/-- **The cubic-lattice graph Laplacian tends to the Laplacian.** Along each
axis `i` the slice `Fᵢ` has derivative `Fᵢ'`, differentiable at the point with
second derivative `aᵢ`. -/
theorem lattice_laplacian {d : ℕ} (F F' : Fin d → ℝ → ℝ) (a : Fin d → ℝ) (x : Fin d → ℝ)
    (hF : ∀ i y, HasDerivAt (F i) (F' i y) y) (hF' : ∀ i, HasDerivAt (F' i) (a i) (x i)) :
    Tendsto (fun h => ∑ i, (F i (x i + h) - 2 * F i (x i) + F i (x i - h)) / h ^ 2)
      (𝓝[≠] 0) (𝓝 (∑ i, a i)) :=
  tendsto_finsetSum _ fun i _ => second_difference (hF i) (hF' i)

end Snuffy.LatticeLaplacian
