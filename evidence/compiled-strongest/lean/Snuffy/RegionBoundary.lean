/-
Snuffy — Canon Edition 4.2 working: the mutual bootstrap of volume and
boundary homology for regions (Part III-F.3).

The relational structure is a connected graph on finitely many particulars
(P1: one structure; its relations are the edges). A region `U` is a finite
set of particulars; its volume is its number of particulars; its boundary is
the set of its particulars related to a particular outside it. The degree-zero
homology of the boundary is the free ℤ-module on the connected components of
the boundary (`H0`), the standard identification `H₀ ≅ ℤ^{π₀}`.

  * exists_crossing — in a connected structure, a nonempty region that is not
    the whole structure has a particular related to one outside it.
  * region_bootstrap — for every region other than the whole structure,
    `Vol(U) > 0 ⇔ H₀(∂U) ≠ 0`.
  * whole_no_boundary, whole_H0_trivial — the whole structure has no outside
    (P1), so its boundary is empty and its boundary homology is zero, while its
    volume is positive. The bootstrap is therefore a statement about regions,
    as in its use for retiring patches (III-F.2).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Data.Finsupp.Single

namespace Snuffy.RegionBoundary

open SimpleGraph

variable {V : Type*} [Fintype V] [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]

/-- The boundary of a region: its particulars related to a particular outside
it. -/
def boundary (U : Finset V) : Finset V :=
  U.filter fun u => ∃ w, G.Adj u w ∧ w ∉ U

/-- Degree-zero homology of the boundary: the free ℤ-module on its connected
components. -/
abbrev H0 (U : Finset V) : Type _ :=
  (G.induce (boundary G U : Set V)).ConnectedComponent →₀ ℤ

omit [Fintype V] [DecidableEq V] [DecidableRel G.Adj] in
/-- **A crossing relation.** -/
theorem exists_crossing (hG : G.Connected) {U : Finset V} {u w : V} (hu : u ∈ U)
    (hw : w ∉ U) : ∃ a ∈ U, ∃ b, G.Adj a b ∧ b ∉ U := by
  obtain ⟨p⟩ := hG.preconnected u w
  obtain ⟨d, -, hd1, hd2⟩ := p.exists_boundary_dart (U : Set V) hu hw
  exact ⟨d.fst, hd1, d.snd, d.adj, hd2⟩

/-- **The mutual bootstrap for regions.** For every region other than the whole
structure, positive volume holds exactly when the boundary homology is
nonzero. -/
theorem region_bootstrap (hG : G.Connected) (U : Finset V) (hproper : U ≠ Finset.univ) :
    0 < U.card ↔ Nontrivial (H0 G U) := by
  constructor
  · intro hpos
    obtain ⟨u, hu⟩ := Finset.card_pos.mp hpos
    have hw : ∃ w, w ∉ U := by
      by_contra h
      push Not at h
      exact hproper (Finset.eq_univ_iff_forall.mpr h)
    obtain ⟨w, hw⟩ := hw
    obtain ⟨a, ha, b, hab, hb⟩ := exists_crossing G hG hu hw
    have hab' : a ∈ boundary G U := Finset.mem_filter.mpr ⟨ha, b, hab, hb⟩
    have : Nonempty (G.induce (boundary G U : Set V)).ConnectedComponent :=
      ⟨(G.induce (boundary G U : Set V)).connectedComponentMk ⟨a, hab'⟩⟩
    infer_instance
  · intro hnt
    by_contra hzero
    have hU : U = ∅ := Finset.card_eq_zero.mp (by omega)
    have hB : boundary G U = ∅ := by simp [boundary, hU]
    have : IsEmpty (G.induce (boundary G U : Set V)).ConnectedComponent := by
      constructor
      intro c
      obtain ⟨v, -⟩ := c.exists_rep
      have := v.2
      simp [hB] at this
    exact not_nontrivial (H0 G U) hnt

omit [Fintype V] in
/-- **No outside.** The whole structure has empty boundary. -/
theorem whole_no_boundary [Fintype V] : boundary G Finset.univ = ∅ := by
  ext u
  simp [boundary]

/-- The whole structure's boundary homology is zero. -/
theorem whole_H0_trivial : ¬ Nontrivial (H0 G Finset.univ) := by
  have : IsEmpty (G.induce (boundary G Finset.univ : Set V)).ConnectedComponent := by
    constructor
    intro c
    obtain ⟨v, -⟩ := c.exists_rep
    have := v.2
    simp [whole_no_boundary] at this
  exact not_nontrivial _

end Snuffy.RegionBoundary
