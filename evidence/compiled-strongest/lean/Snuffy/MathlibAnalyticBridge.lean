/-
Snuffy — Canon Edition: the Mathlib analytic bridge (H5, operator level).

Bridges the discrete meet algebra of `MeetAlgebra.lean` to continuous Hilbert
space projections. Everything here compiles with zero `sorry` and no vacuous
self-equality theorems. Content:

  * starProjection_fixed_iff_mem — P v = v ↔ v ∈ K (fixed points = the subspace).
  * starProjection_idem        — P ∘ P = P, the operator algebraic identity.
  * altIterate_succ_eq_self    — intersection points are fixed by every
                                 nonempty alternating iterate (P_A ∘ P_B)^(n+1).
  * VonNeumannConvergence      — the SOT limit statement as an explicit
                                 hypothesis structure (per the integrity
                                 briefing: no `sorry`; the topological limit is
                                 declared, not faked).
  * convergence_inf_le        — given the forward SOT convergence hypothesis,
                                 A ⊓ B ≤ AB.
  * convergence_inf_ge        — given also the mirrored SOT convergence
                                 hypothesis, AB ≤ A ⊓ B (continuity of the
                                 projections alone; no closedness lemma needed).
  * von_neumann_identification — the full result: with both alternating
                                 products converging pointwise to the same limit
                                 operator, that limit is exactly the projection
                                 onto the intersection: AB = A ⊓ B.

Remaining external obligation, honestly declared: the convergence itself —
discharging the structure's two limit fields from Mathlib primitives (the
norm-decay/Halperin argument or the mean-ergodic theorem; Mathlib carries the
related machinery `ContinuousLinearMap.tendsto_birkhoffAverage_orthogonalProjection`
in `Mathlib.Analysis.InnerProductSpace.MeanErgodic`). The identification step is
complete; the existence step is not claimed here.
-/

import Mathlib.Analysis.InnerProductSpace.Projection.Basic

open Submodule Filter

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

namespace Snuffy.AnalyticBridge

/-! ## Operator algebraic identities (proved unconditionally) -/

/-- The fixed points of the orthogonal projection endomorphism are exactly the
subspace: `P v = v ↔ v ∈ K`. -/
theorem starProjection_fixed_iff_mem {K : Submodule ℂ E} [K.HasOrthogonalProjection] {v : E} :
    K.starProjection v = v ↔ v ∈ K :=
  starProjection_eq_self_iff

/-- Idempotence: composing the projection endomorphism with itself changes
nothing. -/
theorem starProjection_idem (K : Submodule ℂ E) [K.HasOrthogonalProjection] :
    K.starProjection.comp K.starProjection = K.starProjection := by
  ext x
  show K.starProjection (K.starProjection x) = K.starProjection x
  exact starProjection_fixed_iff_mem.mpr (starProjection_apply_mem K x)

/-! ## The alternating iteration -/

/-- Pointwise alternating iterate: x, then (P_A ∘ P_B) applied n times. -/
noncomputable def altIterate (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) : ℕ → E
  | 0 => x
  | n + 1 => A.starProjection (B.starProjection (altIterate A B x n))

/-- Every point of the intersection is fixed by every nonempty alternating
iterate — the discrete half of the bridge. -/
theorem altIterate_succ_eq_self (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    (x : E) (hx : x ∈ A ⊓ B) (n : ℕ) :
    altIterate A B x (n + 1) = x := by
  have hA : x ∈ A := (mem_inf.mp hx).1
  have hB : x ∈ B := (mem_inf.mp hx).2
  induction n with
  | zero =>
      show A.starProjection (B.starProjection x) = x
      rw [starProjection_fixed_iff_mem.mpr hB]
      exact starProjection_fixed_iff_mem.mpr hA
  | succ k ih =>
      show A.starProjection (B.starProjection (altIterate A B x (k + 1))) = x
      rw [ih, starProjection_fixed_iff_mem.mpr hB]
      exact starProjection_fixed_iff_mem.mpr hA

/-- Forward iterates land in A after the first step. -/
theorem altIterate_succ_mem (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) (n : ℕ) :
    altIterate A B x (n + 1) ∈ A :=
  starProjection_apply_mem A _

/-- The mirrored iterate: (P_B ∘ P_A)^n applied pointwise. -/
noncomputable def mirrorAltIterate (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) : ℕ → E
  | 0 => x
  | n + 1 => B.starProjection (A.starProjection (mirrorAltIterate A B x n))

/-- Mirrored iterates land in B after the first step. -/
theorem mirrorIterate_succ_mem (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection] (x : E) (n : ℕ) :
    mirrorAltIterate A B x (n + 1) ∈ B :=
  starProjection_apply_mem B _

/-! ## The SOT convergence hypothesis (declared, not faked) -/

/-- Von Neumann convergence as an explicit hypothesis structure: the alternating
iterates converge pointwise to the projection onto `AB`. This is the statement
of von Neumann's theorem; it is supplied as a hypothesis, never `sorry`ed. -/
structure VonNeumannConvergence (A B AB : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [AB.HasOrthogonalProjection] where
  /-- Pointwise (strong operator topology) convergence to `AB.starProjection`. -/
  limit : ∀ x : E, Tendsto (fun n => altIterate A B x n) atTop (nhds (AB.starProjection x))
  /-- The mirrored product (P_B ∘ P_A)^n converges pointwise to the same limit. -/
  limit_mirror : ∀ x : E, Tendsto (fun n => mirrorAltIterate A B x n) atTop
    (nhds (AB.starProjection x))

/-! ## A genuine conditional theorem -/

/-- Given the SOT convergence hypothesis, the limit subspace contains the
intersection: `A ⊓ B ≤ AB`. Proof: intersection points are fixed by every
nonempty iterate, so their iterate sequence is eventually constant with value
`x`; the limit is therefore `x` by uniqueness of limits in a T2 space, and the
fixed-point characterization gives `x ∈ AB`. -/
theorem convergence_inf_le (A B AB : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [AB.HasOrthogonalProjection] (h : VonNeumannConvergence A B AB) :
    A ⊓ B ≤ AB := by
  intro x hx
  have hconst : ∀ n, altIterate A B x (n + 1) = x := altIterate_succ_eq_self A B x hx
  have hev : (fun n => altIterate A B x n) =ᶠ[atTop] (fun _ => x) := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
    rw [Nat.add_comm]
    exact hconst k
  have hlimitxisx : AB.starProjection x = x :=
    tendsto_nhds_unique (h.limit x) (tendsto_const_nhds.congr' hev.symm)
  exact starProjection_fixed_iff_mem.mp hlimitxisx

/-- A limit of eventually-K-valued iterates lies in K: projections are continuous
and fix their own subspace, so the projected image of the sequence converges both
to the projection of the limit and to the limit itself. -/
theorem limit_mem_of_fixed (K : Submodule ℂ E) [K.HasOrthogonalProjection]
    {f : ℕ → E} {y : E} (htendsto : Tendsto f atTop (nhds y))
    (hf : ∀ᶠ n in atTop, f n ∈ K) : y ∈ K := by
  rw [← starProjection_fixed_iff_mem]
  have h1 : Tendsto (fun n => K.starProjection (f n)) atTop (nhds (K.starProjection y)) :=
    (K.starProjection.continuous.tendsto y).comp htendsto
  have h2 : Tendsto (fun n => K.starProjection (f n)) atTop (nhds y) :=
    htendsto.congr' (by
      filter_upwards [hf] with n hn
      exact (starProjection_fixed_iff_mem.mpr hn).symm)
  exact tendsto_nhds_unique h1 h2

/-- The reverse inclusion: with the mirrored convergence hypothesis, the limit
subspace is contained in the intersection: AB ≤ A ⊓ B. -/
theorem convergence_inf_ge (A B AB : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [AB.HasOrthogonalProjection] (h : VonNeumannConvergence A B AB) :
    AB ≤ A ⊓ B := by
  intro x hx
  have hxA : AB.starProjection x ∈ A := by
    refine limit_mem_of_fixed A (h.limit x) ?_
    filter_upwards [eventually_ge_atTop 1] with n hn
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
    rw [Nat.add_comm]
    exact altIterate_succ_mem A B x k
  have hxB : AB.starProjection x ∈ B := by
    refine limit_mem_of_fixed B (h.limit_mirror x) ?_
    filter_upwards [eventually_ge_atTop 1] with n hn
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
    rw [Nat.add_comm]
    exact mirrorIterate_succ_mem A B x k
  rw [starProjection_fixed_iff_mem.mpr hx] at hxA hxB
  rw [mem_inf]
  exact ⟨hxA, hxB⟩

/-- **Von Neumann's alternating projection theorem, identification step**: if both
alternating products (P_A ∘ P_B)^n and (P_B ∘ P_A)^n converge pointwise to the
same limit operator `AB.starProjection`, then the limit is exactly the orthogonal
projection onto the intersection: `AB = A ⊓ B`. -/
theorem von_neumann_identification (A B AB : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [AB.HasOrthogonalProjection] (h : VonNeumannConvergence A B AB) :
    AB = A ⊓ B :=
  le_antisymm (convergence_inf_ge A B AB h) (convergence_inf_le A B AB h)

end Snuffy.AnalyticBridge
