/-
Snuffy — Canon Edition 4.2 working: a redundantly recorded record is decoded
by majority, and that decoder tolerates any minority of wrong fragments
(review objection 7, item 5; the redundancy application line).

An objective classical record is imprinted redundantly across carrier
fragments. That is the theorem of quantum Darwinism and spectrum-broadcast
structure: classical information emerges redundantly and generically across
environment fragments (Brandão, Piani and Horodecki, Nat. Commun. 6, 7908,
2015), and objectivity implies a spectrum-broadcast structure (Horodecki,
Korbicz and Horodecki, PRA 91, 032122, 2015). Fragment `v` reads the record
value `read v s` from the recovered state `s`; an intact fragment reads `rec`.

  * majority_decodes — the strict-majority decoder returns `rec` whenever
    fewer than half of the fragments read a wrong value.
  * tolerant_outer_decoder — this supplies the tolerance hypothesis of
    `ToleranceSweep.recovery_tail` with `K n` at most half the fragments.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Data.Finset.Card

open Finset

namespace Snuffy.RedundantRecord

variable {V Out S : Type*} [DecidableEq Out]

open scoped Classical in
/-- The strict-majority decoder over the fragments `P`. -/
noncomputable def majority (P : Finset V) (read : V → S → Out) (default : Out) (s : S) : Out :=
  if h : ∃ x, P.card < 2 * (P.filter fun v => read v s = x).card then h.choose else default

open scoped Classical in
/-- **The majority decoder returns the record when wrong fragments are a minority.** -/
theorem majority_decodes (P : Finset V) (read : V → S → Out) (default rec : Out) (s : S)
    (hmin : 2 * (P.filter fun v => read v s ≠ rec).card < P.card) :
    majority P read default s = rec := by
  have hsplit := card_filter_add_card_filter_not (s := P) (fun v => read v s = rec)
  have hneg : (P.filter fun v => ¬ read v s = rec).card = (P.filter fun v => read v s ≠ rec).card := by
    simp only [ne_eq]
  have hrec : P.card < 2 * (P.filter fun v => read v s = rec).card := by omega
  have hex : ∃ x, P.card < 2 * (P.filter fun v => read v s = x).card := ⟨rec, hrec⟩
  unfold majority
  simp only [hex, ↓reduceDIte]
  by_contra hne
  have hx := hex.choose_spec
  have hdisj : Disjoint (P.filter fun v => read v s = hex.choose)
      (P.filter fun v => read v s = rec) := by
    rw [disjoint_filter]
    intro v _ h1 h2
    exact hne (h1.symm.trans h2)
  have hsum := card_union_of_disjoint hdisj
  have hsub : (P.filter fun v => read v s = hex.choose) ∪ (P.filter fun v => read v s = rec) ⊆ P :=
    union_subset (filter_subset _ _) (filter_subset _ _)
  have := card_le_card hsub
  omega

open scoped Classical in
/-- **The tolerance hypothesis of `recovery_tail`.** If each fragment's reading
is wrong only where its patch is wrong, then fewer than `m` wrong patches, with
`2 m ≤ |P|`, leave the majority decoder returning the record. -/
theorem tolerant_outer_decoder {Val : Type*} (P : Finset V) (read : V → (V → Val) → Out)
    (default rec : Out) (target : V → Val)
    (hread : ∀ s v, v ∈ P → s v = target v → read v s = rec) (m : ℕ) (hm : 2 * m ≤ P.card)
    (s : V → Val) (hfew : (P.filter fun v => s v ≠ target v).card < m) :
    majority P read default s = rec := by
  apply majority_decodes
  have hsub : (P.filter fun v => read v s ≠ rec) ⊆ (P.filter fun v => s v ≠ target v) := by
    intro v hv
    obtain ⟨hvP, hne⟩ := mem_filter.mp hv
    exact mem_filter.mpr ⟨hvP, fun h => hne (hread s v hvP h)⟩
  have := card_le_card hsub
  omega

end Snuffy.RedundantRecord
