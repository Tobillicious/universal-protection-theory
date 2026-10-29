/-
Snuffy — Canon Edition v4.1: Halperin's theorem — the global meet of a whole
presentation as the limit of cyclic projections, machine-checked (Chapter 4,
H5; extends Summit 1 from two subspaces to any finite family).

For closed subspaces K₀, …, K_{k−1} of a Hilbert space with cyclic product
T = P_{K_{k−1}} ∘ ⋯ ∘ P_{K₀}, for every x

    Tⁿ x → P_{⋂ K_i} x     (in norm).

  * cyc, adj — the cyclic product and its adjoint product (reverse order).
  * norm_cyc_le, inner_cyc — contraction and adjointness.
  * mem_of_norm_adj_eq — if the adjoint product preserves the norm of w, every
    factor does, and w lies in every K_i (Pythagoras at each factor).
  * energy — ‖x − Tx‖² ≤ k (‖x‖² − ‖Tx‖²).
  * tendsto_iter_sub_succ — successive steps vanish.
  * tendsto_cyc_iter — Halperin's theorem.
  * presentation_detector — the H5 consistency detector for a whole
    presentation: the iterates collapse to 0 from every start iff ⨅ K_i = ⊥.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.HalperinDecay
import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
import Mathlib.Topology.Order.MonotoneConvergence

open Submodule InnerProductSpace Filter

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace Snuffy.Cyclic

/-! ## The cyclic product and its adjoint -/

/-- `cyc k K = P_{K (k−1)} ∘ ⋯ ∘ P_{K 0}`. -/
noncomputable def cyc : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection], E →L[ℂ] E
  | 0, _, _ => ContinuousLinearMap.id ℂ E
  | k + 1, K, _ => (K (Fin.last k)).starProjection.comp (cyc k (fun i => K i.castSucc))

/-- `adj k K = P_{K 0} ∘ ⋯ ∘ P_{K (k−1)}`, the adjoint of `cyc k K`. -/
noncomputable def adj : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection], E →L[ℂ] E
  | 0, _, _ => ContinuousLinearMap.id ℂ E
  | k + 1, K, _ => (adj k (fun i => K i.castSucc)).comp (K (Fin.last k)).starProjection

theorem cyc_succ_apply (k : ℕ) (K : Fin (k + 1) → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (x : E) :
    cyc (k + 1) K x = (K (Fin.last k)).starProjection (cyc k (fun i => K i.castSucc) x) := rfl

theorem adj_succ_apply (k : ℕ) (K : Fin (k + 1) → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (w : E) :
    adj (k + 1) K w = adj k (fun i => K i.castSucc) ((K (Fin.last k)).starProjection w) := rfl

theorem norm_cyc_le : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (x : E), ‖cyc k K x‖ ≤ ‖x‖
  | 0, _, _, _ => le_rfl
  | k + 1, K, _, x => by
    rw [cyc_succ_apply]
    exact (Snuffy.Halperin.norm_starProjection_apply_le _ _).trans (norm_cyc_le k _ x)

theorem norm_adj_le : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (w : E), ‖adj k K w‖ ≤ ‖w‖
  | 0, _, _, _ => le_rfl
  | k + 1, K, _, w => by
    rw [adj_succ_apply]
    exact (norm_adj_le k _ _).trans (Snuffy.Halperin.norm_starProjection_apply_le _ _)

theorem inner_cyc : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (z w : E),
    ⟪cyc k K z, w⟫_ℂ = ⟪z, adj k K w⟫_ℂ
  | 0, _, _, _, _ => rfl
  | k + 1, K, _, z, w => by
    rw [cyc_succ_apply, adj_succ_apply, inner_starProjection_left_eq_right, inner_cyc k _ z]

/-- Points of every subspace are fixed by the cyclic product. -/
theorem cyc_fix : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (x : E), (∀ i, x ∈ K i) → cyc k K x = x
  | 0, _, _, _, _ => rfl
  | k + 1, K, _, x, hx => by
    rw [cyc_succ_apply, cyc_fix k _ x (fun i => hx i.castSucc)]
    exact starProjection_eq_self_iff.mpr (hx _)

/-- Pythagoras at one factor: a projection preserving the norm fixes the vector. -/
private theorem fixed_of_norm_eq (K : Submodule ℂ E) [K.HasOrthogonalProjection] {w : E}
    (h : ‖K.starProjection w‖ = ‖w‖) : K.starProjection w = w := by
  have hp := Snuffy.Halperin.sq_pythagoras_step K w (zero_mem K)
  simp only [sub_zero] at hp
  rw [h] at hp
  have h0 : ‖w - K.starProjection w‖ ^ 2 = 0 := by linarith
  exact (sub_eq_zero.mp (norm_eq_zero.mp ((pow_eq_zero_iff two_ne_zero).mp h0))).symm

/-- If the adjoint product preserves the norm of `w`, then `w` lies in every
factor's subspace. -/
theorem mem_of_norm_adj_eq : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (w : E), ‖adj k K w‖ = ‖w‖ → ∀ i, w ∈ K i
  | 0, _, _, _, _ => fun i => Fin.elim0 i
  | k + 1, K, _, w, h => by
    rw [adj_succ_apply] at h
    have hP : ‖(K (Fin.last k)).starProjection w‖ = ‖w‖ :=
      le_antisymm (Snuffy.Halperin.norm_starProjection_apply_le _ _)
        (h ▸ norm_adj_le k _ _)
    have hfix := fixed_of_norm_eq (K (Fin.last k)) hP
    rw [hfix] at h
    have hrest := mem_of_norm_adj_eq k (fun i => K i.castSucc) w h
    intro i
    refine Fin.lastCases ?_ (fun j => hrest j) i
    exact starProjection_eq_self_iff.mp hfix

/-- **Energy inequality.** `‖x − Tx‖² ≤ k (‖x‖² − ‖Tx‖²)`. -/
theorem energy : ∀ (k : ℕ) (K : Fin k → Submodule ℂ E)
    [∀ i, (K i).HasOrthogonalProjection] (x : E),
    ‖x - cyc k K x‖ ^ 2 ≤ k * (‖x‖ ^ 2 - ‖cyc k K x‖ ^ 2)
  | 0, _, _, x => by simp [cyc]
  | k + 1, K, _, x => by
    set y := cyc k (fun i => K i.castSucc) x
    set P := (K (Fin.last k)).starProjection
    rw [cyc_succ_apply]
    have ih := energy k (fun i => K i.castSucc) x
    have hy : ‖y‖ ≤ ‖x‖ := norm_cyc_le k _ x
    have hpy := Snuffy.Halperin.sq_pythagoras_step (K (Fin.last k)) y (zero_mem _)
    simp only [sub_zero] at hpy
    -- a = ‖x − y‖, b = ‖y − P y‖, D₁ = ‖x‖² − ‖y‖², D₂ = ‖y‖² − ‖P y‖² = b²
    have htri : ‖x - P y‖ ≤ ‖x - y‖ + ‖y - P y‖ := by
      have := norm_add_le (x - y) (y - P y)
      rwa [sub_add_sub_cancel] at this
    have hD₁ : 0 ≤ ‖x‖ ^ 2 - ‖y‖ ^ 2 := by nlinarith [norm_nonneg y]
    have hsq : ‖x - P y‖ ^ 2 ≤ (‖x - y‖ + ‖y - P y‖) ^ 2 :=
      pow_le_pow_left₀ (norm_nonneg _) htri 2
    push_cast
    rcases Nat.eq_zero_or_pos k with hk | hk
    · subst hk
      have ha : ‖x - y‖ ^ 2 ≤ 0 := by simpa using ih
      have ha0 : ‖x - y‖ = 0 := by nlinarith [norm_nonneg (x - y)]
      rw [ha0, zero_add] at hsq
      simp only [Nat.cast_zero, zero_add, one_mul]
      linarith
    · have hkpos : (0 : ℝ) < k := by exact_mod_cast hk
      -- k (a + b)² ≤ (k + 1)(a² + k b²), i.e. (a − k b)² ≥ 0
      have hkey : (k : ℝ) * (‖x - y‖ + ‖y - P y‖) ^ 2
          ≤ ((k : ℝ) + 1) * (‖x - y‖ ^ 2 + k * ‖y - P y‖ ^ 2) := by
        nlinarith [sq_nonneg (‖x - y‖ - k * ‖y - P y‖)]
      have hbound : (k : ℝ) * ‖x - P y‖ ^ 2
          ≤ (k : ℝ) * (((k : ℝ) + 1) * (‖x‖ ^ 2 - ‖P y‖ ^ 2)) := by
        calc (k : ℝ) * ‖x - P y‖ ^ 2 ≤ (k : ℝ) * (‖x - y‖ + ‖y - P y‖) ^ 2 :=
              mul_le_mul_of_nonneg_left hsq hkpos.le
          _ ≤ ((k : ℝ) + 1) * (‖x - y‖ ^ 2 + k * ‖y - P y‖ ^ 2) := hkey
          _ ≤ ((k : ℝ) + 1) * (k * (‖x‖ ^ 2 - ‖y‖ ^ 2) + k * ‖y - P y‖ ^ 2) := by
              have : (0 : ℝ) ≤ (k : ℝ) + 1 := by linarith
              nlinarith
          _ = (k : ℝ) * (((k : ℝ) + 1) * (‖x‖ ^ 2 - ‖P y‖ ^ 2)) := by
              rw [hpy]; ring
      exact le_of_mul_le_mul_left hbound hkpos

/-! ## Iterates -/

section Iterates

variable {k : ℕ} (K : Fin k → Submodule ℂ E) [∀ i, (K i).HasOrthogonalProjection]

theorem iter_succ (n : ℕ) (x : E) : (cyc k K ^ (n + 1)) x = cyc k K ((cyc k K ^ n) x) := by
  rw [pow_succ']
  rfl

theorem iter_shift (n : ℕ) (z : E) : (cyc k K ^ n) (cyc k K z) = (cyc k K ^ (n + 1)) z := by
  rw [pow_succ]
  rfl

theorem norm_iter_le (n : ℕ) (x : E) : ‖(cyc k K ^ n) x‖ ≤ ‖x‖ := by
  induction n with
  | zero => simp
  | succ n ih => rw [iter_succ]; exact (norm_cyc_le k K _).trans ih

theorem iter_fix (n : ℕ) (x : E) (hx : ∀ i, x ∈ K i) : (cyc k K ^ n) x = x := by
  induction n with
  | zero => simp
  | succ n ih => rw [iter_succ, ih, cyc_fix k K x hx]

/-- **Successive steps vanish.** -/
theorem tendsto_iter_sub_succ (z : E) :
    Tendsto (fun n => (cyc k K ^ n) z - (cyc k K ^ (n + 1)) z) atTop (nhds 0) := by
  set a : ℕ → ℝ := fun n => ‖(cyc k K ^ n) z‖ ^ 2
  have hanti : Antitone a := by
    apply antitone_nat_of_succ_le
    intro n
    show ‖(cyc k K ^ (n + 1)) z‖ ^ 2 ≤ ‖(cyc k K ^ n) z‖ ^ 2
    rw [iter_succ]
    exact pow_le_pow_left₀ (norm_nonneg _) (norm_cyc_le k K _) 2
  have hbdd : BddBelow (Set.range a) := ⟨0, by rintro _ ⟨n, rfl⟩; positivity⟩
  have hlim := tendsto_atTop_ciInf hanti hbdd
  have hdiff : Tendsto (fun n => a n - a (n + 1)) atTop (nhds 0) := by
    simpa using hlim.sub (hlim.comp (tendsto_add_atTop_nat 1))
  have hsq : Tendsto (fun n => ‖(cyc k K ^ n) z - (cyc k K ^ (n + 1)) z‖ ^ 2) atTop (nhds 0) := by
    refine squeeze_zero (fun n => by positivity) (fun n => ?_) (by simpa using hdiff.const_mul (k : ℝ))
    have h := energy k K ((cyc k K ^ n) z)
    rw [← iter_succ] at h
    exact h
  rw [tendsto_iff_norm_sub_tendsto_zero]
  simp only [sub_zero]
  have := (Real.continuous_sqrt.tendsto 0).comp hsq
  simpa [Function.comp_def, Real.sqrt_sq (norm_nonneg _)] using this

/-- On the orthogonal complement of the intersection the iterates decay to 0. -/
theorem tendsto_zero_of_mem_orthogonal [CompleteSpace E] (y : E) (hy : y ∈ (⨅ i, K i)ᗮ) :
    Tendsto (fun n => (cyc k K ^ n) y) atTop (nhds 0) := by
  let M : Submodule ℂ E :=
    LinearMap.range ((ContinuousLinearMap.id ℂ E - cyc k K : E →L[ℂ] E) : E →ₗ[ℂ] E)
  have hT : ∀ z : E, ((ContinuousLinearMap.id ℂ E - cyc k K : E →L[ℂ] E) : E →ₗ[ℂ] E) z
      = z - cyc k K z := fun z => rfl
  have hMorth : Mᗮ ≤ ⨅ i, K i := by
    intro w hw
    have horth : ∀ z : E, ⟪z - cyc k K z, w⟫_ℂ = 0 :=
      fun z => (Submodule.mem_orthogonal M w).mp hw _ ⟨z, hT z⟩
    have key : ∀ z : E, ⟪z, w - adj k K w⟫_ℂ = 0 := by
      intro z
      have h := horth z
      rw [inner_sub_left, inner_cyc, sub_eq_zero] at h
      rw [inner_sub_right, h, sub_self]
    have hfix : adj k K w = w := by
      have h0 := inner_self_eq_zero.mp (key (w - adj k K w))
      exact (sub_eq_zero.mp h0).symm
    have hmem := mem_of_norm_adj_eq k K w (by rw [hfix])
    exact Submodule.mem_iInf _ |>.mpr hmem
  have hy_cl : y ∈ closure (M : Set E) := by
    have h1 : y ∈ Mᗮᗮ := Submodule.orthogonal_le hMorth hy
    rw [Submodule.orthogonal_orthogonal_eq_closure] at h1
    rw [← Submodule.topologicalClosure_coe]
    exact h1
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨u, huM, hdist⟩ := Metric.mem_closure_iff.mp hy_cl (ε / 2) (half_pos hε)
  obtain ⟨z, hz⟩ := LinearMap.mem_range.mp huM
  have hu : u = z - cyc k K z := by rw [← hz, hT]
  have hiter : ∀ n, (cyc k K ^ n) u = (cyc k K ^ n) z - (cyc k K ^ (n + 1)) z := by
    intro n
    rw [hu, map_sub, iter_shift]
  obtain ⟨N, hN⟩ :=
    Metric.tendsto_atTop.mp (tendsto_iter_sub_succ K z) (ε / 2) (half_pos hε)
  refine ⟨N, fun n hn => ?_⟩
  rw [dist_zero_right]
  have h1 : ‖y - u‖ < ε / 2 := by rw [dist_eq_norm] at hdist; exact hdist
  have h2 : ‖(cyc k K ^ n) u‖ < ε / 2 := by
    have h := hN n hn
    rw [dist_zero_right] at h
    rw [hiter n]
    exact h
  calc ‖(cyc k K ^ n) y‖ = ‖(cyc k K ^ n) (y - u) + (cyc k K ^ n) u‖ := by
        rw [← map_add, sub_add_cancel]
    _ ≤ ‖(cyc k K ^ n) (y - u)‖ + ‖(cyc k K ^ n) u‖ := norm_add_le _ _
    _ ≤ ‖y - u‖ + ‖(cyc k K ^ n) u‖ := add_le_add (norm_iter_le K n _) le_rfl
    _ < ε / 2 + ε / 2 := by linarith
    _ = ε := add_halves ε

/-- **Halperin's theorem.** In a Hilbert space the cyclic product of finitely many
orthogonal projections, iterated, converges in norm to the projection onto the
intersection. -/
theorem tendsto_cyc_iter [CompleteSpace E] [(⨅ i, K i).HasOrthogonalProjection] (x : E) :
    Tendsto (fun n => (cyc k K ^ n) x) atTop (nhds ((⨅ i, K i).starProjection x)) := by
  set p := (⨅ i, K i).starProjection x
  have hpmem : ∀ i, p ∈ K i := fun i =>
    (Submodule.mem_iInf _).mp (starProjection_apply_mem (⨅ i, K i) x) i
  have hdecomp : ∀ n, (cyc k K ^ n) x = p + (cyc k K ^ n) (x - p) := by
    intro n
    rw [map_sub, iter_fix K n p hpmem]
    abel
  have hlim := tendsto_zero_of_mem_orthogonal K (x - p) (sub_starProjection_mem_orthogonal x)
  have hsum := (tendsto_const_nhds (x := p)).add hlim
  rw [add_zero] at hsum
  exact hsum.congr (fun n => (hdecomp n).symm)

/-- **The H5 consistency detector for a whole presentation.** The cyclic
iterates collapse to `0` from every start exactly when the global meet is
trivial: the presentation is inconsistent iff `⨅ K_i = ⊥`. -/
theorem presentation_detector [CompleteSpace E] [(⨅ i, K i).HasOrthogonalProjection] :
    (∀ x : E, Tendsto (fun n => (cyc k K ^ n) x) atTop (nhds 0)) ↔ ⨅ i, K i = ⊥ := by
  constructor
  · intro h
    rw [eq_bot_iff]
    intro x hx
    have hxi : ∀ i, x ∈ K i := (Submodule.mem_iInf _).mp hx
    have hconst : (fun n => (cyc k K ^ n) x) = fun _ => x := funext fun n => iter_fix K n x hxi
    have hx0 : x = 0 := tendsto_nhds_unique (hconst ▸ tendsto_const_nhds) (h x)
    rw [hx0]
    exact zero_mem _
  · intro h x
    have hzero : ∀ y ∈ ⨅ i, K i, y = 0 := by
      intro y hy
      rw [h] at hy
      exact (mem_bot ℂ).mp hy
    have hp := hzero _ (starProjection_apply_mem (⨅ i, K i) x)
    have hlim := tendsto_cyc_iter K x
    rwa [hp] at hlim

end Iterates

end Snuffy.Cyclic
