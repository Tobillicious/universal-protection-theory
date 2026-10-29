/-
Snuffy — Canon Edition 4.2 working: the DKLP witness property of
minimum-weight decoding (review objection 7.2, the application line).

Edges are the locations of `Threshold`. A correction `C` is admissible for the
error `E` when it has the same syndrome. A minimum-weight decoder returns an
admissible correction of least size. Suppose `γ ⊆ E ∆ C` has zero syndrome: for
instance a nontrivial cycle, or a boundary-to-boundary path, of the
zero-syndrome residual. Then `C ∆ γ` is admissible too, so minimality gives
`|C ∩ γ| ≤ |γ|/2`. Every edge of `γ` outside `C` is an error edge, so at least
half of `γ` is faulty. That is the hypothesis `hw` of
`Threshold.fail_le_witness` and `fail_le_geometric`.

  * half_faulty — `γ ⊆ E ∆ C` and `|C| ≤ |C ∆ γ|` give `|γ| ≤ 2 |γ ∩ E|`.
  * matching_witness — for a minimum-weight decoder and a syndrome map
    additive under `∆`, every zero-syndrome `γ ⊆ E ∆ C` is at least half
    faulty.

The residual `E ∆ C` of a failed decoding is a zero-syndrome chain in a
nontrivial class. It decomposes into edge-disjoint simple cycles and
boundary-to-boundary paths, and one of them is nontrivial. That component has
length at least the circuit distance, and it is the witness counted by `V Δ^L`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.SymmDiff

open Finset

namespace Snuffy.MatchingWitness

variable {Ed : Type*} [DecidableEq Ed]

theorem card_symmDiff (A B : Finset Ed) : (symmDiff A B).card = (A \ B).card + (B \ A).card := by
  rw [symmDiff_def, sup_eq_union, card_union_of_disjoint disjoint_sdiff_sdiff]

/-- **At least half of a residual cycle is faulty.** -/
theorem half_faulty (E C γ : Finset Ed) (hγ : γ ⊆ symmDiff E C)
    (hmin : C.card ≤ (symmDiff C γ).card) : γ.card ≤ 2 * (γ ∩ E).card := by
  have h1 := card_sdiff_add_card_inter C γ
  have h2 := card_sdiff_add_card_inter γ C
  have h3 := card_symmDiff C γ
  have hinter : (C ∩ γ).card = (γ ∩ C).card := by rw [inter_comm]
  have hsub : γ \ C ⊆ γ ∩ E := by
    intro x hx
    obtain ⟨hxγ, hxC⟩ := mem_sdiff.mp hx
    have := hγ hxγ
    rw [mem_symmDiff] at this
    exact mem_inter.mpr ⟨hxγ, this.elim (fun h => h.1) (fun h => absurd h.1 hxC)⟩
  have h4 := card_le_card hsub
  omega

/-- **The witness property of minimum-weight decoding.** -/
theorem matching_witness {V : Type*} [DecidableEq V] (synd : Finset Ed → Finset V)
    (hadd : ∀ A B, synd (symmDiff A B) = symmDiff (synd A) (synd B))
    (E C : Finset Ed) (hmin : ∀ C', synd C' = synd E → C.card ≤ C'.card)
    (hC : synd C = synd E) (γ : Finset Ed) (hγ : γ ⊆ symmDiff E C) (hγ0 : synd γ = ∅) :
    γ.card ≤ 2 * (γ ∩ E).card := by
  apply half_faulty E C γ hγ
  apply hmin
  rw [hadd, hγ0, ← Finset.bot_eq_empty, symmDiff_bot, hC]

end Snuffy.MatchingWitness
