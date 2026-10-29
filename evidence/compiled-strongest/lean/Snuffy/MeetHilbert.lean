/-
Snuffy — Canon Edition v4.1: the H5 meet algebra realised by Hilbert-space
subspaces, machine-checked (Chapter 4).

The v4.0 meet algebra (`MeetAlgebra.lean`) proved anchor preservation and
contradiction collapse for any projection lattice, with a predicate model.
Here the lattice of subspaces of a complex inner product space — meet the
intersection, complement the orthogonal complement — is an instance, so the
v4.0 theorems hold for the embedding Π itself; and the operator dynamics
detect what the algebra predicts.

  * hilbertLattice — subspaces of a Hilbert space form a projection lattice.
  * hilbert_anchor_preserved — deduced extensions preserve the anchor subspace.
  * hilbert_contradiction_collapse — a contradictory extension meets the
    anchor in zero.
  * contradiction_detected — and then the alternating-projection iterates
    collapse to 0 from every start (Summit 1 + H5 detector): the rollback
    signal is computed by the projections themselves.
  * deduction_never_rolls_back — a deduced extension leaves the meet equal to
    the anchor, so the iterates converge to the anchor projection.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.MeetAlgebra
import Snuffy.H5Closure

open Submodule Filter

namespace Snuffy.MeetHilbert

variable {E : Type} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- **Subspaces of a Hilbert space form a projection lattice**: meet is
intersection, complement is orthogonal complement, `K ⊓ Kᗮ = ⊥`. -/
noncomputable instance hilbertLattice : Snuffy.ProjectionLattice (Submodule ℂ E) where
  le K L := K ≤ L
  meet K L := K ⊓ L
  top := ⊤
  bot := ⊥
  complement K := Kᗮ
  refl K := le_refl K
  antisymm h₁ h₂ := le_antisymm h₁ h₂
  trans h₁ h₂ := le_trans h₁ h₂
  meet_left _ _ := inf_le_left
  meet_right _ _ := inf_le_right
  meet_greatest h₁ h₂ := le_inf h₁ h₂
  meet_comm K L := inf_comm K L
  top_greatest _ := le_top
  bot_least _ := bot_le
  meet_complement K := Submodule.inf_orthogonal_eq_bot K

/-- **Anchor preservation in Hilbert space.** If every extension subspace
contains the anchor (it is deduced from the anchor set), the global meet is
the anchor. -/
theorem hilbert_anchor_preserved (T₀ : Submodule ℂ E) (ext : List (Submodule ℂ E))
    (h : ∀ φ ∈ ext, T₀ ≤ φ) : Snuffy.meetAll T₀ ext = T₀ :=
  Snuffy.anchor_preserved_over T₀ ext h

/-- **Contradiction collapse in Hilbert space.** An extension contradicting the
anchor (`T₀ ≤ φᗮ`) zeroes the global meet. -/
theorem hilbert_contradiction_collapse (T₀ φ : Submodule ℂ E) (rest : List (Submodule ℂ E))
    (h : T₀ ≤ φᗮ) : Snuffy.meetAll T₀ (φ :: rest) = ⊥ :=
  Snuffy.collapse_over T₀ φ rest h

/-- **Contradiction is detected by the dynamics.** If `φ` contradicts the
anchor `T₀`, the alternating projections between them collapse to `0` from
every start. -/
theorem contradiction_detected [CompleteSpace E] (T₀ φ : Submodule ℂ E)
    [T₀.HasOrthogonalProjection] [φ.HasOrthogonalProjection]
    [(T₀ ⊓ φ).HasOrthogonalProjection] (h : T₀ ≤ φᗮ) :
    ∀ x : E, Tendsto (fun n => Snuffy.AnalyticBridge.altIterate T₀ φ x n) atTop (nhds 0) := by
  have hbot : T₀ ⊓ φ = ⊥ := Snuffy.contradiction_collapse (P := Submodule ℂ E) h
  exact (Snuffy.H5.consistency_detector T₀ φ).mpr hbot

/-- **Valid deduction never triggers rollback.** If `φ` is deduced from the
anchor (`T₀ ≤ φ`), the meet is the anchor and the alternating projections
converge to the anchor projection. -/
theorem deduction_never_rolls_back [CompleteSpace E] (T₀ φ : Submodule ℂ E)
    [T₀.HasOrthogonalProjection] [φ.HasOrthogonalProjection] (h : T₀ ≤ φ) (x : E) :
    Tendsto (fun n => Snuffy.AnalyticBridge.altIterate T₀ φ x n) atTop
      (nhds (T₀.starProjection x)) :=
  Snuffy.CanonVonNeumann.tendsto_altIterate T₀ φ T₀ (inf_eq_left.mpr h).symm x

end Snuffy.MeetHilbert
