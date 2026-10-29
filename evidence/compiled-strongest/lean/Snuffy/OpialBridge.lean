/-
Snuffy — Canon Edition v4.1: the weak-cluster bridge (existence step, part 2).

Connects the machine-checked Bregman asymptotic regularity of
`HalperinDecay.lean` to the identification of weak cluster points, per the
modular three-lemma structure supplied via the author (25 October 2026).
Weak convergence is taken in its Riesz-unfolded form — `WeaklyConvergesTo` —
so the development is pure inner-product algebra; no weak-topology machinery.

  * weakCluster_mem_exact — if the iterates are eventually exactly in K (as
    the T-iterates lie in A from k = 1 on), any weak limit lies in K.
  * weakCluster_mem      — Lemma 2: with regularity ‖u_k − P_K u_k‖ → 0, any
    weak limit lies in K (orthogonality argument; no Kᗮᗮ lemma needed — the
    elegant route via ⟪w, w⟫_ℂ = 0).
  * iterate_inner_const  — the exact invariant ⟪t_k, w⟫_ℂ = ⟪x, w⟫_ℂ, w ∈ A ⊓ B.
  * weakCluster_eq_starProjection — Lemma 3: every weak cluster point of the
    iterates equals P_{A ⊓ B} x.

Remaining external obligations (declared, not claimed): extraction of a weak
cluster point from a bounded sequence (Eberlein–Šmulian / Opial), and the Fejér
upgrade to strong convergence (Pātai D, banked: the inequality
‖t_k − z₀‖² ≤ ⟪x − z₀, t_k − z₀⟫_ℂ does not propagate by naive induction).

`tIterate` mirrors `Snuffy.Halperin.tIterate`. Zero `sorry`.
Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.InnerProductSpace.Projection.Basic
import Mathlib.Analysis.InnerProductSpace.Orthogonal
import Mathlib.Order.Filter.AtTopBot.Basic

open Submodule InnerProductSpace Filter

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace Snuffy.Opial

/-- Weak convergence in Riesz-unfolded form: all inner products against a
fixed vector converge. -/
def WeaklyConvergesTo (u : ℕ → E) (xs : E) : Prop :=
  ∀ y : E, Tendsto (fun k => ⟪u k, y⟫_ℂ) atTop (nhds ⟪xs, y⟫_ℂ)

/-- The alternating iterates (mirrors `Snuffy.Halperin.tIterate`). -/
noncomputable def tIterate (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) : ℕ → E
  | 0 => x
  | k + 1 => A.starProjection (B.starProjection (tIterate A B x k))

theorem tIterate_succ_mem (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) (k : ℕ) :
    tIterate A B x (k + 1) ∈ A :=
  starProjection_apply_mem A _

/-! ## Lemma 2, both halves -/

/-- If the iterates are exactly in K from the first step on, any weak limit
lies in K. -/
theorem weakCluster_mem_exact (K : Submodule ℂ E) [K.HasOrthogonalProjection]
    {u : ℕ → E} {xs : E} (hmem : ∀ k, u (k + 1) ∈ K) (hw : WeaklyConvergesTo u xs) :
    xs ∈ K := by
  have key : ∀ y ∈ Kᗮ, ⟪xs, y⟫_ℂ = 0 := by
    intro y hy
    have hzero : Tendsto (fun k => ⟪u (k + 1), y⟫_ℂ) atTop (nhds (0:ℂ)) :=
      tendsto_const_nhds.congr' (Eventually.of_forall fun k =>
        (inner_right_of_mem_orthogonal (hmem k) hy).symm)
    have hshift : Tendsto (fun k => ⟪u (k + 1), y⟫_ℂ) atTop (nhds ⟪xs, y⟫_ℂ) :=
      (hw y).comp (tendsto_add_atTop_nat 1)
    exact tendsto_nhds_unique hshift hzero
  have hwbot : xs - K.starProjection xs ∈ Kᗮ :=
    sub_starProjection_mem_orthogonal xs
  have h1 : ⟪xs, xs - K.starProjection xs⟫_ℂ = 0 := key _ hwbot
  have h2 : ⟪K.starProjection xs, xs - K.starProjection xs⟫_ℂ = 0 :=
    inner_right_of_mem_orthogonal (starProjection_apply_mem K xs) hwbot
  have h3 : ⟪xs - K.starProjection xs, xs - K.starProjection xs⟫_ℂ = 0 := by
    rw [inner_sub_left, h1, h2, sub_zero]
  have h4 : xs - K.starProjection xs = 0 := inner_self_eq_zero.mp h3
  have h5 : K.starProjection xs = xs := (sub_eq_zero.mp h4).symm
  exact starProjection_eq_self_iff.mp h5

/-- Lemma 2 (regular half): with asymptotic regularity toward K, any weak
limit lies in K. -/
theorem weakCluster_mem (K : Submodule ℂ E) [K.HasOrthogonalProjection]
    {u : ℕ → E} {xs : E} (hw : WeaklyConvergesTo u xs)
    (hreg : Tendsto (fun k => ‖u k - K.starProjection (u k)‖) atTop (nhds 0)) :
    xs ∈ K := by
  have key : ∀ y ∈ Kᗮ, ⟪xs, y⟫_ℂ = 0 := by
    intro y hy
    have hlim : Tendsto (fun k => ⟪u k - K.starProjection (u k), y⟫_ℂ) atTop
        (nhds (0:ℂ)) := by
      rw [Metric.tendsto_atTop]
      intro ε hε
      by_cases hy0 : y = 0
      · subst hy0
        refine ⟨0, fun n _ => ?_⟩
        rw [dist_zero_right, inner_zero_right, norm_zero]
        exact hε
      · have hypos : 0 < ‖y‖ := by
          refine lt_of_le_of_ne (norm_nonneg y) ?_
          intro h0
          exact hy0 (norm_eq_zero.mp h0.symm)
        have hdiv : (0:ℝ) < ε / ‖y‖ := div_pos hε hypos
        obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hreg (ε / ‖y‖) hdiv
        refine ⟨N, fun n hn => ?_⟩
        have hb := norm_inner_le_norm (𝕜 := ℂ) (u n - K.starProjection (u n)) y
        have hn' := hN n hn
        rw [dist_zero_right, Real.norm_of_nonneg (norm_nonneg _)] at hn'
        rw [dist_zero_right]
        calc ‖⟪u n - K.starProjection (u n), y⟫_ℂ‖
            ≤ ‖u n - K.starProjection (u n)‖ * ‖y‖ := hb
          _ < (ε / ‖y‖) * ‖y‖ := mul_lt_mul_of_pos_right hn' hypos
          _ = ε := div_mul_cancel₀ ε (ne_of_gt hypos)
    have hsplit : Tendsto (fun k => ⟪u k, y⟫_ℂ) atTop (nhds (0:ℂ)) := by
      have heq : (fun k => ⟪u k, y⟫_ℂ)
          = fun k => ⟪u k - K.starProjection (u k), y⟫_ℂ
            + ⟪K.starProjection (u k), y⟫_ℂ := by
        funext k
        have h7 : ⟪u k, y⟫_ℂ
            = ⟪(u k - K.starProjection (u k)) + K.starProjection (u k), y⟫_ℂ := by
          congr 1
          abel
        rw [h7]
        exact inner_add_left _ _ y
      rw [heq]
      simpa using hlim.add (tendsto_const_nhds.congr' (Eventually.of_forall fun k =>
        (inner_right_of_mem_orthogonal (starProjection_apply_mem K (u k)) hy).symm))
    exact (tendsto_nhds_unique hsplit (hw y)).symm
  have hwbot : xs - K.starProjection xs ∈ Kᗮ :=
    sub_starProjection_mem_orthogonal xs
  have h1 : ⟪xs, xs - K.starProjection xs⟫_ℂ = 0 := key _ hwbot
  have h2 : ⟪K.starProjection xs, xs - K.starProjection xs⟫_ℂ = 0 :=
    inner_right_of_mem_orthogonal (starProjection_apply_mem K xs) hwbot
  have h3 : ⟪xs - K.starProjection xs, xs - K.starProjection xs⟫_ℂ = 0 := by
    rw [inner_sub_left, h1, h2, sub_zero]
  have h4 : xs - K.starProjection xs = 0 := inner_self_eq_zero.mp h3
  have h5 : K.starProjection xs = xs := (sub_eq_zero.mp h4).symm
  exact starProjection_eq_self_iff.mp h5

/-! ## The invariant and Lemma 3 -/

/-- The exact invariant: the iterates preserve inner products against every
point of the intersection. -/
theorem iterate_inner_const (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x w : E) (hw : w ∈ A ⊓ B) (k : ℕ) :
    ⟪tIterate A B x k, w⟫_ℂ = ⟪x, w⟫_ℂ := by
  have hzA : w ∈ A := (mem_inf.mp hw).1
  have hzB : w ∈ B := (mem_inf.mp hw).2
  induction k with
  | zero => rfl
  | succ j ih =>
      have hB : ⟪B.starProjection (tIterate A B x j), w⟫_ℂ = ⟪tIterate A B x j, w⟫_ℂ := by
        have h0 := starProjection_inner_eq_zero (tIterate A B x j) w hzB
        rw [inner_sub_left, sub_eq_zero] at h0
        exact h0.symm
      have hA : ⟪A.starProjection (B.starProjection (tIterate A B x j)), w⟫_ℂ
          = ⟪B.starProjection (tIterate A B x j), w⟫_ℂ := by
        have h0 := starProjection_inner_eq_zero
          (B.starProjection (tIterate A B x j)) w hzA
        rw [inner_sub_left, sub_eq_zero] at h0
        exact h0.symm
      show ⟪A.starProjection (B.starProjection (tIterate A B x j)), w⟫_ℂ = ⟪x, w⟫_ℂ
      rw [hA, hB, ih]

/-- Lemma 3: every weak cluster point of the alternating iterates equals the
orthogonal projection of the start onto the intersection. -/
theorem weakCluster_eq_starProjection (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [(A ⊓ B).HasOrthogonalProjection] (x : E) {xs : E}
    (hw : WeaklyConvergesTo (tIterate A B x) xs)
    (hregB : Tendsto (fun k => ‖tIterate A B x k
      - B.starProjection (tIterate A B x k)‖) atTop (nhds 0)) :
    xs = (A ⊓ B).starProjection x := by
  have hA : xs ∈ A := weakCluster_mem_exact A (tIterate_succ_mem A B x) hw
  have hB : xs ∈ B := weakCluster_mem B hw hregB
  have hxs : xs ∈ A ⊓ B := mem_inf.mpr ⟨hA, hB⟩
  have hinner : ∀ w ∈ A ⊓ B, ⟪x - xs, w⟫_ℂ = 0 := by
    intro w hw'
    have hlimw : Tendsto (fun k => ⟪tIterate A B x k, w⟫_ℂ) atTop (nhds ⟪x, w⟫_ℂ) :=
      tendsto_const_nhds.congr' (Eventually.of_forall
        fun k => (iterate_inner_const A B x w hw' k).symm)
    have hlimxs := tendsto_nhds_unique hlimw (hw w)
    rw [inner_sub_left, hlimxs, sub_self]
  have hdin : (A ⊓ B).starProjection x - xs ∈ A ⊓ B := by
    simpa [sub_eq_add_neg] using
      (A ⊓ B).add_mem (starProjection_apply_mem _ x) ((A ⊓ B).neg_mem hxs)
  have hdbot : (A ⊓ B).starProjection x - xs ∈ (A ⊓ B)ᗮ := by
    intro w hw'
    rw [inner_eq_zero_symm]
    have h1 := hinner w hw'
    have h2 := starProjection_inner_eq_zero x w hw'
    have hsplit : (A ⊓ B).starProjection x - xs
        = (x - xs) - (x - (A ⊓ B).starProjection x) := by abel
    rw [hsplit, inner_sub_left, h1, h2, sub_zero]
  have hdd : ⟪(A ⊓ B).starProjection x - xs, (A ⊓ B).starProjection x - xs⟫_ℂ = 0 :=
    inner_right_of_mem_orthogonal hdin hdbot
  exact (sub_eq_zero.mp (inner_self_eq_zero.mp hdd)).symm

/-- The invariant Pythagoras decomposition: the squared distance from the iterate
to the projection on the intersection is exactly the squared norm of the iterate
minus the squared norm of the projection. Resolves Pātai D by reducing strong
convergence directly to scalar norm convergence. -/
theorem iterate_sub_starProjection_sq_eq (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [(A ⊓ B).HasOrthogonalProjection] (x : E) (k : ℕ) :
    ‖tIterate A B x k - (A ⊓ B).starProjection x‖ ^ 2
      = ‖tIterate A B x k‖ ^ 2 - ‖(A ⊓ B).starProjection x‖ ^ 2 := by
  have hzmem : (A ⊓ B).starProjection x ∈ A ⊓ B := starProjection_apply_mem (A ⊓ B) x
  have hconst := iterate_inner_const A B x ((A ⊓ B).starProjection x) hzmem k
  have horth : x - (A ⊓ B).starProjection x ∈ (A ⊓ B)ᗮ :=
    sub_starProjection_mem_orthogonal x
  have h0 : ⟪(A ⊓ B).starProjection x, x - (A ⊓ B).starProjection x⟫_ℂ = 0 :=
    inner_right_of_mem_orthogonal hzmem horth
  have h0' : ⟪x - (A ⊓ B).starProjection x, (A ⊓ B).starProjection x⟫_ℂ = 0 :=
    inner_eq_zero_symm.mp h0
  have hdecomp : ⟪x, (A ⊓ B).starProjection x⟫_ℂ
      = ⟪(x - (A ⊓ B).starProjection x) + (A ⊓ B).starProjection x, (A ⊓ B).starProjection x⟫_ℂ := by
    congr 1; abel
  have hx_inner : ⟪x, (A ⊓ B).starProjection x⟫_ℂ
      = ⟪(A ⊓ B).starProjection x, (A ⊓ B).starProjection x⟫_ℂ := by
    rw [hdecomp, inner_add_left, h0', zero_add]
  have htk_inner : ⟪tIterate A B x k, (A ⊓ B).starProjection x⟫_ℂ
      = ⟪(A ⊓ B).starProjection x, (A ⊓ B).starProjection x⟫_ℂ := by
    rw [hconst, hx_inner]
  have hsub_inner : ⟪tIterate A B x k - (A ⊓ B).starProjection x, (A ⊓ B).starProjection x⟫_ℂ = 0 := by
    rw [inner_sub_left, htk_inner, sub_self]
  have hpyth := norm_add_sq_eq_norm_sq_add_norm_sq_of_inner_eq_zero
    (tIterate A B x k - (A ⊓ B).starProjection x) ((A ⊓ B).starProjection x) hsub_inner
  have hsum : (tIterate A B x k - (A ⊓ B).starProjection x) + (A ⊓ B).starProjection x
      = tIterate A B x k := by abel
  rw [hsum] at hpyth
  simp only [sq] at hpyth ⊢
  linarith

/-- Strong convergence of the alternating iterates to the orthogonal projection
onto the intersection, upgraded from scalar norm convergence via the invariant
Pythagoras decomposition. -/
theorem tendsto_starProjection_of_norm_sq_tendsto (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [(A ⊓ B).HasOrthogonalProjection] (x : E)
    (hlim : Tendsto (fun k => ‖tIterate A B x k‖ ^ 2) atTop
      (nhds (‖(A ⊓ B).starProjection x‖ ^ 2))) :
    Tendsto (fun k => tIterate A B x k) atTop (nhds ((A ⊓ B).starProjection x)) := by
  have hsub : Tendsto (fun k => ‖tIterate A B x k - (A ⊓ B).starProjection x‖ ^ 2) atTop (nhds 0) := by
    have hfun : (fun k => ‖tIterate A B x k - (A ⊓ B).starProjection x‖ ^ 2)
        = fun k => ‖tIterate A B x k‖ ^ 2 - ‖(A ⊓ B).starProjection x‖ ^ 2 :=
      funext fun k => iterate_sub_starProjection_sq_eq A B x k
    rw [hfun]
    simpa using hlim.sub (tendsto_const_nhds : Tendsto (fun _ => ‖(A ⊓ B).starProjection x‖ ^ 2) atTop _)
  have hnorm : Tendsto (fun k => ‖tIterate A B x k - (A ⊓ B).starProjection x‖) atTop (nhds 0) := by
    have hconv := (Real.continuous_sqrt.tendsto (0:ℝ)).comp hsub
    have hre : (fun k => ‖tIterate A B x k - (A ⊓ B).starProjection x‖)
        = fun k => Real.sqrt (‖tIterate A B x k - (A ⊓ B).starProjection x‖ ^ 2) :=
      funext fun k => (Real.sqrt_sq (norm_nonneg _)).symm
    rw [hre]
    simp only [Function.comp_def, Real.sqrt_zero] at hconv ⊢
    exact hconv
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hnorm ε hε
  refine ⟨N, fun n hn => ?_⟩
  have hn' := hN n hn
  rw [dist_zero_right, Real.norm_of_nonneg (norm_nonneg _)] at hn'
  rw [dist_eq_norm]
  exact hn'

/-- The mirrored iterate: (P_B ∘ P_A)^k applied pointwise. -/
noncomputable def mirrorTIterate (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) : ℕ → E :=
  tIterate B A x

/-- The Von Neumann SOT convergence structure (mirrors MathlibAnalyticBridge.VonNeumannConvergence). -/
structure VonNeumannConvergence (A B AB : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [AB.HasOrthogonalProjection] where
  limit : ∀ x : E, Tendsto (fun n => tIterate A B x n) atTop (nhds (AB.starProjection x))
  limit_mirror : ∀ x : E, Tendsto (fun n => mirrorTIterate A B x n) atTop
    (nhds (AB.starProjection x))

/-- The canonical packaging: discharges VonNeumannConvergence directly from the
forward and mirrored strong limits. -/
theorem makeVonNeumannConvergence (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [(A ⊓ B).HasOrthogonalProjection]
    (hlim : ∀ x : E, Tendsto (fun n => tIterate A B x n) atTop (nhds ((A ⊓ B).starProjection x)))
    (hmirror : ∀ x : E, Tendsto (fun n => mirrorTIterate A B x n) atTop (nhds ((A ⊓ B).starProjection x))) :
    VonNeumannConvergence A B (A ⊓ B) :=
  ⟨hlim, hmirror⟩

end Snuffy.Opial
