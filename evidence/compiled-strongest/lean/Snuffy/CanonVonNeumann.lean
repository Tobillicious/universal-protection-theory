/-
Snuffy — Canon Edition v4.1: von Neumann's alternating projection theorem,
existence step (Summit 1 closed).

Discharges both `limit` fields of `MathlibAnalyticBridge.VonNeumannConvergence`
from Mathlib primitives and the canon's own engines, and with them the
identification already proved there: for every x,

  (P_A P_B)ⁿ x → P_{A ⊓ B} x   and   (P_B P_A)ⁿ x → P_{A ⊓ B} x   (in norm).

Setting: a Hilbert space (complete inner product space), the setting of von
Neumann's 1933 theorem; the identification step needs no completeness.

  * altIterate_sub, norm_altIterate_le — the iteration is linear and contractive.
  * tendsto_altIterate_sub_succ — successive steps vanish (from
    `Snuffy.Halperin.asymptotic_regularity`).
  * mem_inf_of_orthogonal_range — anything orthogonal to range(I − P_A P_B)
    is fixed by P_B P_A, hence (Pythagoras) lies in A ⊓ B.
  * tendsto_zero_of_mem_orthogonal — on (A ⊓ B)ᗮ = closure range(I − P_A P_B)
    the iterates decay to zero (density + uniform contraction).
  * tendsto_altIterate — the full limit, for both products.
  * canon_von_neumann_convergence — the `VonNeumannConvergence A B (A ⊓ B)`
    structure of `MathlibAnalyticBridge.lean`, both fields discharged.
  * canon_opial_convergence, opial_norm_sq_tendsto, opial_route_closes — the
    same for `Snuffy.Opial`, including the norm limit that the Pythagoras
    upgrade `tendsto_starProjection_of_norm_sq_tendsto` takes as input.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.MathlibAnalyticBridge
import Snuffy.HalperinDecay
import Snuffy.OpialBridge
import Mathlib.Analysis.InnerProductSpace.Projection.Submodule

open Submodule InnerProductSpace Filter

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace Snuffy.CanonVonNeumann

open Snuffy.AnalyticBridge

section Engines

variable (A B : Submodule ℂ E) [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]

/-! ## Linearity, shift and contraction of the alternating iteration -/

theorem altIterate_sub (x y : E) (n : ℕ) :
    altIterate A B (x - y) n = altIterate A B x n - altIterate A B y n := by
  induction n with
  | zero => rfl
  | succ k ih =>
      show A.starProjection (B.starProjection (altIterate A B (x - y) k))
        = A.starProjection (B.starProjection (altIterate A B x k))
          - A.starProjection (B.starProjection (altIterate A B y k))
      rw [ih, map_sub, map_sub]

/-- Iterating from T x is iterating from x one step later. -/
theorem altIterate_shift (x : E) (n : ℕ) :
    altIterate A B (A.starProjection (B.starProjection x)) n = altIterate A B x (n + 1) := by
  induction n with
  | zero => rfl
  | succ k ih =>
      show A.starProjection (B.starProjection
          (altIterate A B (A.starProjection (B.starProjection x)) k))
        = A.starProjection (B.starProjection (altIterate A B x (k + 1)))
      rw [ih]

/-- The iteration is a contraction. -/
theorem norm_altIterate_le (x : E) (n : ℕ) : ‖altIterate A B x n‖ ≤ ‖x‖ := by
  induction n with
  | zero => exact le_rfl
  | succ k ih =>
      show ‖A.starProjection (B.starProjection (altIterate A B x k))‖ ≤ ‖x‖
      calc ‖A.starProjection (B.starProjection (altIterate A B x k))‖
          ≤ ‖B.starProjection (altIterate A B x k)‖ :=
            Snuffy.Halperin.norm_starProjection_apply_le A _
        _ ≤ ‖altIterate A B x k‖ := Snuffy.Halperin.norm_starProjection_apply_le B _
        _ ≤ ‖x‖ := ih

/-- The bridge iterate is the Halperin iterate. -/
theorem altIterate_eq_halperin (x : E) (n : ℕ) :
    altIterate A B x n = Snuffy.Halperin.tIterate A B x n := by
  induction n with
  | zero => rfl
  | succ k ih =>
      show A.starProjection (B.starProjection (altIterate A B x k))
        = A.starProjection (B.starProjection (Snuffy.Halperin.tIterate A B x k))
      rw [ih]

/-- The Opial iterate is the bridge iterate. -/
theorem opial_tIterate_eq (x : E) (n : ℕ) :
    Snuffy.Opial.tIterate A B x n = altIterate A B x n := by
  induction n with
  | zero => rfl
  | succ k ih =>
      show A.starProjection (B.starProjection (Snuffy.Opial.tIterate A B x k))
        = A.starProjection (B.starProjection (altIterate A B x k))
      rw [ih]

/-- The mirrored bridge iterate is the bridge iterate with A and B exchanged. -/
theorem mirrorAltIterate_eq (x : E) (n : ℕ) :
    mirrorAltIterate A B x n = altIterate B A x n := by
  induction n with
  | zero => rfl
  | succ k ih =>
      show B.starProjection (A.starProjection (mirrorAltIterate A B x k))
        = B.starProjection (A.starProjection (altIterate B A x k))
      rw [ih]

/-! ## Successive steps vanish -/

/-- From Bregman asymptotic regularity: ‖Tⁿ z − Tⁿ⁺¹ z‖ → 0 for every z. -/
theorem tendsto_altIterate_sub_succ (z : E) :
    Tendsto (fun n => altIterate A B z n - altIterate A B z (n + 1)) atTop (nhds 0) := by
  obtain ⟨h1, h2⟩ := Snuffy.Halperin.asymptotic_regularity A B z
  have hsum := h1.add h2
  rw [add_zero] at hsum
  rw [tendsto_iff_norm_sub_tendsto_zero]
  refine squeeze_zero (fun n => norm_nonneg _) (fun n => ?_) hsum
  rw [sub_zero, altIterate_eq_halperin A B z n, altIterate_eq_halperin A B z (n + 1)]
  have hsplit : Snuffy.Halperin.tIterate A B z n - Snuffy.Halperin.tIterate A B z (n + 1)
      = (Snuffy.Halperin.tIterate A B z n
          - B.starProjection (Snuffy.Halperin.tIterate A B z n))
        + (B.starProjection (Snuffy.Halperin.tIterate A B z n)
          - A.starProjection (B.starProjection (Snuffy.Halperin.tIterate A B z n))) := by
    show _ - A.starProjection (B.starProjection (Snuffy.Halperin.tIterate A B z n)) = _
    abel
  rw [hsplit]
  exact norm_add_le _ _

/-! ## The orthogonal complement of range(I − P_A P_B) is A ⊓ B -/

/-- A vector orthogonal to every z − P_A P_B z is fixed by P_B P_A and hence,
by Pythagoras, lies in both subspaces. -/
theorem mem_inf_of_orthogonal_range (w : E)
    (hw : ∀ z : E, ⟪z - A.starProjection (B.starProjection z), w⟫_ℂ = 0) :
    w ∈ A ⊓ B := by
  have key : ∀ z : E, ⟪z, w - B.starProjection (A.starProjection w)⟫_ℂ = 0 := by
    intro z
    have h := hw z
    rw [inner_sub_left, inner_starProjection_left_eq_right,
      inner_starProjection_left_eq_right, sub_eq_zero] at h
    rw [inner_sub_right, h, sub_self]
  have hfix : B.starProjection (A.starProjection w) = w := by
    have h0 := inner_self_eq_zero.mp (key (w - B.starProjection (A.starProjection w)))
    exact (sub_eq_zero.mp h0).symm
  have hA_norm : ‖A.starProjection w‖ = ‖w‖ := by
    apply le_antisymm (Snuffy.Halperin.norm_starProjection_apply_le A w)
    calc ‖w‖ = ‖B.starProjection (A.starProjection w)‖ := by rw [hfix]
      _ ≤ ‖A.starProjection w‖ := Snuffy.Halperin.norm_starProjection_apply_le B _
  have hpyth := Snuffy.Halperin.sq_pythagoras_step A w (zero_mem A)
  simp only [sub_zero] at hpyth
  rw [hA_norm] at hpyth
  have hres : ‖w - A.starProjection w‖ ^ 2 = 0 := by linarith
  have hres' : w - A.starProjection w = 0 :=
    norm_eq_zero.mp ((pow_eq_zero_iff two_ne_zero).mp hres)
  have hwA : A.starProjection w = w := (sub_eq_zero.mp hres').symm
  have hwB : B.starProjection w = w := by
    have h := hfix
    rw [hwA] at h
    exact h
  exact mem_inf.mpr ⟨starProjection_eq_self_iff.mp hwA, starProjection_eq_self_iff.mp hwB⟩

/-! ## Decay on (A ⊓ B)ᗮ -/

/-- In a Hilbert space, the iterates of every vector orthogonal to A ⊓ B
converge to zero. -/
theorem tendsto_zero_of_mem_orthogonal [CompleteSpace E] (y : E) (hy : y ∈ (A ⊓ B)ᗮ) :
    Tendsto (fun n => altIterate A B y n) atTop (nhds 0) := by
  let T : E →L[ℂ] E := A.starProjection.comp B.starProjection
  let M : Submodule ℂ E :=
    LinearMap.range ((ContinuousLinearMap.id ℂ E - T : E →L[ℂ] E) : E →ₗ[ℂ] E)
  have hT : ∀ z : E, ((ContinuousLinearMap.id ℂ E - T : E →L[ℂ] E) : E →ₗ[ℂ] E) z
      = z - A.starProjection (B.starProjection z) := fun z => rfl
  have hMorth : Mᗮ ≤ A ⊓ B := by
    intro w hw
    apply mem_inf_of_orthogonal_range A B w
    intro z
    exact (Submodule.mem_orthogonal M w).mp hw _ ⟨z, hT z⟩
  have hy_cl : y ∈ closure (M : Set E) := by
    have h1 : y ∈ Mᗮᗮ := Submodule.orthogonal_le hMorth hy
    rw [Submodule.orthogonal_orthogonal_eq_closure] at h1
    rw [← Submodule.topologicalClosure_coe]
    exact h1
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨u, huM, hdist⟩ := Metric.mem_closure_iff.mp hy_cl (ε / 2) (half_pos hε)
  obtain ⟨z, hz⟩ := LinearMap.mem_range.mp huM
  have hu : u = z - A.starProjection (B.starProjection z) := by rw [← hz, hT]
  have hiter : ∀ n, altIterate A B u n = altIterate A B z n - altIterate A B z (n + 1) := by
    intro n
    rw [hu, altIterate_sub, altIterate_shift]
  obtain ⟨N, hN⟩ :=
    Metric.tendsto_atTop.mp (tendsto_altIterate_sub_succ A B z) (ε / 2) (half_pos hε)
  refine ⟨N, fun n hn => ?_⟩
  rw [dist_zero_right]
  have hsplit : altIterate A B y n = altIterate A B (y - u) n + altIterate A B u n := by
    rw [altIterate_sub]
    abel
  have h1 : ‖y - u‖ < ε / 2 := by
    rw [dist_eq_norm] at hdist
    exact hdist
  have h2 : ‖altIterate A B u n‖ < ε / 2 := by
    have h := hN n hn
    rw [dist_zero_right] at h
    rw [hiter n]
    exact h
  calc ‖altIterate A B y n‖
      ≤ ‖altIterate A B (y - u) n‖ + ‖altIterate A B u n‖ := by
        rw [hsplit]
        exact norm_add_le _ _
    _ ≤ ‖y - u‖ + ‖altIterate A B u n‖ :=
        add_le_add (norm_altIterate_le A B (y - u) n) le_rfl
    _ < ε / 2 + ε / 2 := by linarith
    _ = ε := add_halves ε

/-! ## The limit -/

/-- **Von Neumann's alternating projection theorem.** In a Hilbert space, for
every x the iterates (P_A P_B)ⁿ x converge in norm to the projection of x onto
A ⊓ B (stated for any `AB` equal to `A ⊓ B`, so that it applies verbatim to
`B ⊓ A`). -/
theorem tendsto_altIterate [CompleteSpace E] (AB : Submodule ℂ E) [AB.HasOrthogonalProjection]
    (hAB : AB = A ⊓ B) (x : E) :
    Tendsto (fun n => altIterate A B x n) atTop (nhds (AB.starProjection x)) := by
  subst hAB
  have hp : ∀ n, altIterate A B ((A ⊓ B).starProjection x) n = (A ⊓ B).starProjection x := by
    intro n
    cases n with
    | zero => rfl
    | succ k =>
        exact altIterate_succ_eq_self A B _ (starProjection_apply_mem (A ⊓ B) x) k
  have hdecomp : ∀ n, altIterate A B x n
      = (A ⊓ B).starProjection x + altIterate A B (x - (A ⊓ B).starProjection x) n := by
    intro n
    rw [altIterate_sub, hp]
    abel
  have hlim := tendsto_zero_of_mem_orthogonal A B (x - (A ⊓ B).starProjection x)
    (sub_starProjection_mem_orthogonal x)
  have hsum := (tendsto_const_nhds (x := (A ⊓ B).starProjection x)).add hlim
  rw [add_zero] at hsum
  exact hsum.congr (fun n => (hdecomp n).symm)

end Engines

section Packaging

variable (A B : Submodule ℂ E) [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
  [CompleteSpace E] [(A ⊓ B).HasOrthogonalProjection]

/-- **Summit 1.** Both limit fields of `MathlibAnalyticBridge.VonNeumannConvergence`
discharged: the forward and mirrored alternating products converge pointwise
to the projection onto A ⊓ B. -/
theorem canon_von_neumann_convergence : VonNeumannConvergence A B (A ⊓ B) where
  limit x := tendsto_altIterate A B (A ⊓ B) rfl x
  limit_mirror x :=
    (tendsto_altIterate B A (A ⊓ B) (inf_comm A B) x).congr
      (fun n => (mirrorAltIterate_eq A B x n).symm)

omit [CompleteSpace E] [(A ⊓ B).HasOrthogonalProjection] in
/-- With the existence step discharged, the identification of
`MathlibAnalyticBridge.lean` applies unconditionally in Hilbert space: any
subspace whose projection is the common limit of both alternating products
is exactly A ⊓ B. -/
theorem limit_subspace_eq_inf (AB : Submodule ℂ E) [AB.HasOrthogonalProjection]
    (h : VonNeumannConvergence A B AB) : AB = A ⊓ B :=
  von_neumann_identification A B AB h

/-- The same structure in its `Snuffy.Opial` form. -/
theorem canon_opial_convergence : Snuffy.Opial.VonNeumannConvergence A B (A ⊓ B) :=
  Snuffy.Opial.makeVonNeumannConvergence A B
    (fun x => (tendsto_altIterate A B (A ⊓ B) rfl x).congr
      (fun n => (opial_tIterate_eq A B x n).symm))
    (fun x => (tendsto_altIterate B A (A ⊓ B) (inf_comm A B) x).congr
      (fun n => (opial_tIterate_eq B A x n).symm))

/-- The scalar norm limit that the invariant Pythagoras upgrade
(`Snuffy.Opial.tendsto_starProjection_of_norm_sq_tendsto`) takes as input. -/
theorem opial_norm_sq_tendsto (x : E) :
    Tendsto (fun k => ‖Snuffy.Opial.tIterate A B x k‖ ^ 2) atTop
      (nhds (‖(A ⊓ B).starProjection x‖ ^ 2)) :=
  (((tendsto_altIterate A B (A ⊓ B) rfl x).congr
    (fun n => (opial_tIterate_eq A B x n).symm)).norm).pow 2

/-- The Opial/Pythagoras route closes: its declared input is now a theorem. -/
theorem opial_route_closes (x : E) :
    Tendsto (fun k => Snuffy.Opial.tIterate A B x k) atTop
      (nhds ((A ⊓ B).starProjection x)) :=
  Snuffy.Opial.tendsto_starProjection_of_norm_sq_tendsto A B x (opial_norm_sq_tendsto A B x)

end Packaging

end Snuffy.CanonVonNeumann
