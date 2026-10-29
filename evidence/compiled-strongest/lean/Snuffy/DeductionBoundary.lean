/-
Snuffy — Canon Edition v4.1: the H5 deduction-boundary certificate,
machine-checked (working argument §8, Proposition 7; Chapter 4).

  * rank_criterion — over any field, col(A) ∩ col(G) = {0} iff
    dim(col A + col G) = dim col A + dim col G (rank[A G] = rank A + rank G).
  * context_maps_image — a context with C A = A M maps im A into itself.
  * Deduction, boundary_mem_image — Proposition 7: if primitive boundaries lie
    in im A and every generating context satisfies C_j A = A M_j, every finite
    deduction built by contexts and sums has its boundary in im A.
  * anchor_untouched — with the rank criterion, no deduction boundary has a
    non-zero component in the protected-anchor space: a boundary lying in it
    is zero.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.LinearAlgebra.Dimension.Finrank

open Module

namespace Snuffy.DeductionBoundary

variable {K W : Type*} [Field K] [AddCommGroup W] [Module K W]

/-- **Rank criterion.** For subspaces `A` (spanned by the represented deduction
boundaries) and `G` (the protected-anchor generators) of a finite-dimensional
space, `A ⊓ G = ⊥` iff `dim (A ⊔ G) = dim A + dim G`. -/
theorem rank_criterion [FiniteDimensional K W] (A G : Submodule K W) :
    A ⊓ G = ⊥ ↔ finrank K ↥(A ⊔ G) = finrank K ↥A + finrank K ↥G := by
  have h := Submodule.finrank_sup_add_finrank_inf_eq A G
  constructor
  · intro hbot
    rw [hbot, finrank_bot, add_zero] at h
    exact h
  · intro hsum
    have h0 : finrank K ↥(A ⊓ G) = 0 := by omega
    exact Submodule.finrank_eq_zero.mp h0

variable {U : Type*} [AddCommGroup U] [Module K U]

/-- A context intertwined with the boundary map (`C ∘ A = A ∘ M`) maps the image
of `A` into itself. -/
theorem context_maps_image (A : U →ₗ[K] W) (C : W →ₗ[K] W) (M : U →ₗ[K] U)
    (hCA : C.comp A = A.comp M) {b : W} (hb : b ∈ LinearMap.range A) :
    C b ∈ LinearMap.range A := by
  obtain ⟨u, rfl⟩ := hb
  refine ⟨M u, ?_⟩
  have := LinearMap.congr_fun hCA u
  simp only [LinearMap.comp_apply] at this
  exact this.symm

/-- Finite deductions: primitive boundaries, context images and sums. -/
inductive Deduction (J P : Type*)
  | prim : P → Deduction J P
  | ctx : J → Deduction J P → Deduction J P
  | sum : Deduction J P → Deduction J P → Deduction J P

/-- The boundary of a deduction under the specified composition rule. -/
def boundary {J P : Type*} (prim : P → W) (C : J → W →ₗ[K] W) : Deduction J P → W
  | .prim p => prim p
  | .ctx j t => C j (boundary prim C t)
  | .sum t₁ t₂ => boundary prim C t₁ + boundary prim C t₂

/-- **Proposition 7.** Context-closed finite certificates cover arbitrary
finite compositions. -/
theorem boundary_mem_image {J P : Type*} (A : U →ₗ[K] W) (prim : P → W)
    (C : J → W →ₗ[K] W) (M : J → U →ₗ[K] U)
    (hprim : ∀ p, prim p ∈ LinearMap.range A) (hctx : ∀ j, (C j).comp A = A.comp (M j)) :
    ∀ t : Deduction J P, boundary prim C t ∈ LinearMap.range A
  | .prim p => hprim p
  | .ctx j t => context_maps_image A (C j) (M j) (hctx j) (boundary_mem_image A prim C M hprim hctx t)
  | .sum t₁ t₂ => (LinearMap.range A).add_mem (boundary_mem_image A prim C M hprim hctx t₁)
      (boundary_mem_image A prim C M hprim hctx t₂)

/-- **The protected anchors are untouched.** If the boundary image meets the
anchor space only in zero (the rank criterion), every deduction boundary that
lies in the anchor space is zero. -/
theorem anchor_untouched {J P : Type*} (A : U →ₗ[K] W) (G : Submodule K W) (prim : P → W)
    (C : J → W →ₗ[K] W) (M : J → U →ₗ[K] U)
    (hprim : ∀ p, prim p ∈ LinearMap.range A) (hctx : ∀ j, (C j).comp A = A.comp (M j))
    (hdisj : LinearMap.range A ⊓ G = ⊥) (t : Deduction J P)
    (hG : boundary prim C t ∈ G) : boundary prim C t = 0 := by
  have hmem : boundary prim C t ∈ LinearMap.range A ⊓ G :=
    ⟨boundary_mem_image A prim C M hprim hctx t, hG⟩
  rw [hdisj] at hmem
  exact (Submodule.mem_bot K).mp hmem

end Snuffy.DeductionBoundary
