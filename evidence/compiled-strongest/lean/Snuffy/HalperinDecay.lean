/-
Snuffy — Canon Edition v4.1: Halperin norm-decay (the existence step, part 1).

Formalises the elementary half of the Halperin route supplied via the author
(Pātai A, 25 October 2026), in a series-free form: the two half-step
Pythagorean identities chain into one exact identity

  ‖t_k − z‖² = ‖t_{k+1} − z‖² + ‖t_k − P_B t_k‖² + ‖P_B t_k − P_A(P_B t_k)‖²

for every z ∈ A ⊓ B, where t_k = (P_A ∘ P_B)^k x. From it, monotonically:
Fejér monotonicity, monotone convergence of the squared distance (via ciSup),
vanishing telescoping differences, and asymptotic regularity: the distance
from the iterates to BOTH subspaces vanishes, for every starting point.

Declared next target (not claimed here): the weak-cluster-point argument
(Steps 4–5 of the sketch) upgrading regularity to strong convergence to the
projection onto A ⊓ B — via Opial's lemma or Eberlein–Šmulian.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.InnerProductSpace.Projection.Basic
import Mathlib.Topology.Order.MonotoneConvergence
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Order.ConditionallyCompleteLattice.Indexed
import Mathlib.Order.Filter.AtTopBot.Basic

open Submodule InnerProductSpace Filter

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace Snuffy.Halperin

/-! ## The three elementary engines -/

/-- Orthogonal projections are pointwise contractions. -/
theorem norm_starProjection_apply_le (K : Submodule ℂ E) [K.HasOrthogonalProjection] (u : E) :
    ‖K.starProjection u‖ ≤ ‖u‖ := by
  have h2 : ‖K.starProjection‖ ≤ 1 := starProjection_norm_le K
  calc ‖K.starProjection u‖ ≤ ‖K.starProjection‖ * ‖u‖ :=
        ContinuousLinearMap.le_opNorm _ _
    _ ≤ 1 * ‖u‖ := mul_le_mul_of_nonneg_right h2 (norm_nonneg _)
    _ = ‖u‖ := one_mul _

/-- Distance to a point of the subspace never increases under projection. -/
theorem dist_starProjection_le (K : Submodule ℂ E) [K.HasOrthogonalProjection] (u : E) {z : E}
    (hz : z ∈ K) : ‖K.starProjection u - z‖ ≤ ‖u - z‖ := by
  have hfix : K.starProjection z = z := starProjection_eq_self_iff.mpr hz
  have hsub : K.starProjection u - z = K.starProjection (u - z) := by
    rw [map_sub, hfix]
  rw [hsub]
  exact norm_starProjection_apply_le K (u - z)

/-- The Pythagorean step: u − z splits into its projection residual and the
projected displacement, which are orthogonal. -/
theorem sq_pythagoras_step (K : Submodule ℂ E) [K.HasOrthogonalProjection] (u : E) {z : E}
    (hz : z ∈ K) :
    ‖u - z‖ ^ 2 = ‖u - K.starProjection u‖ ^ 2 + ‖K.starProjection u - z‖ ^ 2 := by
  have hzmem : K.starProjection u - z ∈ K := by
    have hadd : K.starProjection u + (-z) ∈ K :=
      K.add_mem (starProjection_apply_mem K u) (K.neg_mem hz)
    simpa [sub_eq_add_neg] using hadd
  have hinner := starProjection_inner_eq_zero u (K.starProjection u - z) hzmem
  have h := norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero
    (u - K.starProjection u) (K.starProjection u - z) hinner
  have hsum : (u - K.starProjection u) + (K.starProjection u - z) = u - z := by abel
  rw [hsum] at h
  simp only [sq]
  exact h

/-! ## The alternating iterates and the chain identity -/

/-- The alternating-product iterates t_k = (P_A ∘ P_B)^k x. -/
noncomputable def tIterate (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) : ℕ → E
  | 0 => x
  | k + 1 => A.starProjection (B.starProjection (tIterate A B x k))

/-- The single-engine identity: the squared distance to any point of the
intersection decomposes exactly into the next squared distance plus the two
half-step errors. -/
theorem chain_identity (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x : E) {z : E} (hz : z ∈ A ⊓ B) (k : ℕ) :
    ‖tIterate A B x k - z‖ ^ 2 = ‖tIterate A B x (k + 1) - z‖ ^ 2
      + ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2
      + ‖B.starProjection (tIterate A B x k)
          - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2 := by
  have hzA : z ∈ A := (mem_inf.mp hz).1
  have hzB : z ∈ B := (mem_inf.mp hz).2
  have h1 := sq_pythagoras_step B (tIterate A B x k) hzB
  have h2 := sq_pythagoras_step A (B.starProjection (tIterate A B x k)) hzA
  have hnext : A.starProjection (B.starProjection (tIterate A B x k))
      = tIterate A B x (k + 1) := rfl
  rw [← hnext]
  linarith

/-! ## Monotone convergence -/

/-- Fejér monotonicity: the squared distance to any point of the intersection
is antitone along the iterates. -/
theorem sq_dist_antitone (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x : E) {z : E} (hz : z ∈ A ⊓ B) :
    Antitone (fun k => ‖tIterate A B x k - z‖ ^ 2) := by
  have hstep : ∀ k, ‖tIterate A B x (k + 1) - z‖ ^ 2 ≤ ‖tIterate A B x k - z‖ ^ 2 := by
    intro k
    have h := chain_identity A B x hz k
    have h1 : (0:ℝ) ≤ ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2 :=
      sq_nonneg _
    have h2 : (0:ℝ) ≤ ‖B.starProjection (tIterate A B x k)
        - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2 := sq_nonneg _
    linarith
  have hmono : Monotone (fun k => -(‖tIterate A B x k - z‖ ^ 2)) :=
    monotone_nat_of_le_succ (fun k => by
      have := hstep k
      linarith)
  exact fun a b hab => by
    have := hmono hab
    exact le_of_neg_le_neg this

/-- The squared distances converge (antitone and bounded below by zero). -/
theorem sq_dist_tendsto (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x : E) {z : E} (hz : z ∈ A ⊓ B) :
    ∃ L : ℝ, Tendsto (fun k => ‖tIterate A B x k - z‖ ^ 2) atTop (nhds L) := by
  have hanti := sq_dist_antitone A B x hz
  have hmono : Monotone (fun k => ‖tIterate A B x 0 - z‖ ^ 2
      - ‖tIterate A B x k - z‖ ^ 2) := by
    intro a b hab
    exact sub_le_sub_left (hanti hab) _
  have hbdd : BddAbove (Set.range (fun k => ‖tIterate A B x 0 - z‖ ^ 2
      - ‖tIterate A B x k - z‖ ^ 2)) := by
    refine ⟨‖tIterate A B x 0 - z‖ ^ 2, fun y hy => ?_⟩
    obtain ⟨k, rfl⟩ := hy
    show ‖tIterate A B x 0 - z‖ ^ 2 - ‖tIterate A B x k - z‖ ^ 2
        ≤ ‖tIterate A B x 0 - z‖ ^ 2
    linarith [sq_nonneg (‖tIterate A B x k - z‖ : ℝ)]
  obtain ⟨S, hS⟩ : ∃ S, IsLUB (Set.range (fun k => ‖tIterate A B x 0 - z‖ ^ 2
      - ‖tIterate A B x k - z‖ ^ 2)) S := ⟨_, isLUB_ciSup hbdd⟩
  exact ⟨‖tIterate A B x 0 - z‖ ^ 2 - S, by
    simpa using (tendsto_const_nhds.sub (tendsto_atTop_isLUB hmono hS) :
      Tendsto (fun k => ‖tIterate A B x 0 - z‖ ^ 2
        - (‖tIterate A B x 0 - z‖ ^ 2 - ‖tIterate A B x k - z‖ ^ 2)) atTop _)⟩

/-- The telescoping difference of squared distances vanishes. -/
theorem delta_tendsto_zero (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x : E) {z : E} (hz : z ∈ A ⊓ B) :
    Tendsto (fun k => ‖tIterate A B x k - z‖ ^ 2 - ‖tIterate A B x (k + 1) - z‖ ^ 2)
      atTop (nhds 0) := by
  obtain ⟨L, hL⟩ := sq_dist_tendsto A B x hz
  have h := hL.sub (hL.comp (tendsto_add_atTop_nat 1))
  simpa using h

/-! ## Asymptotic regularity -/

/-- **Asymptotic regularity** (Bregman): for every starting point, the distance
from the alternating iterates to both subspaces vanishes — the iterates become
eventually-almost-fixed by both projections. -/
theorem asymptotic_regularity (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) :
    Tendsto (fun k => ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖) atTop (nhds 0) ∧
    Tendsto (fun k => ‖B.starProjection (tIterate A B x k)
        - A.starProjection (B.starProjection (tIterate A B x k))‖) atTop (nhds 0) := by
  have hz : (0:E) ∈ A ⊓ B := by
    rw [mem_inf]
    exact ⟨zero_mem A, zero_mem B⟩
  have hdelta' := delta_tendsto_zero A B x hz
  have hsum_eq : ∀ k, ‖tIterate A B x k - (0:E)‖ ^ 2 - ‖tIterate A B x (k + 1) - (0:E)‖ ^ 2
      = ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2
        + ‖B.starProjection (tIterate A B x k)
            - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2 := by
    intro k
    have h := chain_identity A B x hz k
    linarith
  have he1 : Tendsto (fun k => ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2)
      atTop (nhds 0) := by
    rw [Metric.tendsto_atTop]
    intro ε hε
    obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hdelta' ε hε
    refine ⟨N, fun n hn => ?_⟩
    simp only [Real.dist_eq] at hN ⊢
    obtain ⟨hn1, hn2⟩ := abs_lt.mp (hN n hn)
    have hbound : ‖tIterate A B x n - B.starProjection (tIterate A B x n)‖ ^ 2
        ≤ ‖tIterate A B x n - (0:E)‖ ^ 2 - ‖tIterate A B x (n + 1) - (0:E)‖ ^ 2 := by
      have hb2 : (0:ℝ) ≤ ‖B.starProjection (tIterate A B x n)
          - A.starProjection (B.starProjection (tIterate A B x n))‖ ^ 2 := sq_nonneg _
      have := hsum_eq n
      linarith
    have hpos : (0:ℝ) ≤ ‖tIterate A B x n - B.starProjection (tIterate A B x n)‖ ^ 2 :=
      sq_nonneg _
    exact abs_lt.mpr ⟨by linarith, by linarith⟩
  have hsum_t : Tendsto (fun k => ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2
        + ‖B.starProjection (tIterate A B x k)
            - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2) atTop (nhds 0) := by
    have hfun : (fun k => ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2
        + ‖B.starProjection (tIterate A B x k)
            - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2)
        = fun k => ‖tIterate A B x k - (0:E)‖ ^ 2
            - ‖tIterate A B x (k + 1) - (0:E)‖ ^ 2 := funext fun k => (hsum_eq k).symm
    rw [hfun]
    exact hdelta'
  have he2 : Tendsto (fun k => ‖B.starProjection (tIterate A B x k)
        - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2) atTop (nhds 0) := by
    have h := hsum_t.sub he1
    simpa using h
  constructor
  · have hconv := (Real.continuous_sqrt.tendsto (0:ℝ)).comp he1
    have hre : (fun k => ‖tIterate A B x k - B.starProjection (tIterate A B x k)‖)
        = fun k => Real.sqrt (‖tIterate A B x k - B.starProjection (tIterate A B x k)‖ ^ 2) :=
      funext fun k => (Real.sqrt_sq (norm_nonneg _)).symm
    rw [hre]
    simp only [Function.comp_def, Real.sqrt_zero] at hconv ⊢
    exact hconv
  · have hconv := (Real.continuous_sqrt.tendsto (0:ℝ)).comp he2
    have hre : (fun k => ‖B.starProjection (tIterate A B x k)
          - A.starProjection (B.starProjection (tIterate A B x k))‖)
        = fun k => Real.sqrt (‖B.starProjection (tIterate A B x k)
            - A.starProjection (B.starProjection (tIterate A B x k))‖ ^ 2) :=
      funext fun k => (Real.sqrt_sq (norm_nonneg _)).symm
    rw [hre]
    simp only [Function.comp_def, Real.sqrt_zero] at hconv ⊢
    exact hconv

end Snuffy.Halperin
