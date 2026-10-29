/-
Snuffy — Canon Edition v4.1: the knowledge-maximiser's irreplaceability
dominance and grading, machine-checked (Section 16.1, U1).

Additive information model (the model of the exact check, Part B): each
irreplaceable particular `x` carries information `info x ≥ 0` about the
relational history, carried by no funded copy, and preserved sets add.

  * destroy_loses_exactly — destroying `W` from a preserved set forfeits
    exactly `info W`; preserving weakly dominates destroying, strictly when
    `info W > 0` (slack budget).
  * optimal_keeps_most_irreplaceable — the grading: under a binding budget
    (at most `B` particulars preserved), every optimal preserved set keeps
    each particular at least as irreplaceable as any it drops.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

open Finset

namespace Snuffy.Irreplaceability

variable {ι : Type*} [DecidableEq ι]

/-- Information preserved by a set of particulars (additive model). -/
def value (info : ι → ℝ) (S : Finset ι) : ℝ := ∑ x ∈ S, info x

/-- **Irreplaceability dominance.** Destroying `W` from the preserved set `S`
forfeits exactly `info W`; preserving weakly dominates destroying, strictly
when `info W > 0`. -/
theorem destroy_loses_exactly (info : ι → ℝ) {S : Finset ι} {W : ι} (hW : W ∈ S) :
    value info S - value info (S.erase W) = info W := by
  unfold value
  rw [← add_sum_erase S info hW]
  ring

theorem preserve_dominates (info : ι → ℝ) {S : Finset ι} {W : ι} (hW : W ∈ S)
    (hpos : 0 < info W) : value info (S.erase W) < value info S := by
  have := destroy_loses_exactly info hW
  linarith

/-- **The irreplaceability grading.** Among preserved sets of at most `B`
particulars drawn from `U`, an optimal set never drops a particular that is
strictly more irreplaceable than one it keeps. -/
theorem optimal_keeps_most_irreplaceable (info : ι → ℝ) {U S : Finset ι} {B : ℕ}
    (hSU : S ⊆ U) (hSB : S.card ≤ B)
    (hopt : ∀ T ⊆ U, T.card ≤ B → value info T ≤ value info S)
    {x y : ι} (hxU : x ∈ U) (hxS : x ∉ S) (hyS : y ∈ S) : info x ≤ info y := by
  by_contra h
  rw [not_le] at h
  set T := insert x (S.erase y)
  have hxT : x ∉ S.erase y := fun hx => hxS (mem_of_mem_erase hx)
  have hTU : T ⊆ U := by
    intro z hz
    rcases mem_insert.mp hz with rfl | hz'
    · exact hxU
    · exact hSU (mem_of_mem_erase hz')
  have hTcard : T.card ≤ B := by
    rw [card_insert_of_notMem hxT, card_erase_of_mem hyS]
    have : 0 < S.card := card_pos.mpr ⟨y, hyS⟩
    omega
  have hTval : value info T = value info S - info y + info x := by
    unfold value
    rw [sum_insert hxT, ← add_sum_erase S info hyS]
    ring
  have := hopt T hTU hTcard
  linarith

end Snuffy.Irreplaceability
