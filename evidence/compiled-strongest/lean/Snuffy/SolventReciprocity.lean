/-
Snuffy — solvent reciprocity (next-proof register 2026-10-25, item 1).

Under the Master Solvency Condition the canonical regime keeps every
particular outright, and any mind kept by any rival whatsoever is kept by the
canonical regime — no union closure (P-emu(c)) anywhere.

  * solvent_keeps_everyone — under solvency every canonical option is the top
    outcome, and the top outcome keeps every particular. The reading of stage
    1 under which `⊤` is "all existing particulars continue" is the hypothesis
    `htopkeeps`; the solvency premises are `htopR` (the top outcome is
    realisable) and `hsolv` (its cost fits the budget), exactly as in
    `UnionClosure.greatest_of_solvent`.
  * reciprocity_dominance_solvent — the order-form dominance of Section 15
    (D3*) without the union-closure hypothesis `hF` of
    `ReciprocityCeiling.reciprocity_dominance`; the rival needs no closure and
    no feasibility assumption at all.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.UnionClosure

open Snuffy.Greatestness Snuffy.UnionClosure

namespace Snuffy.SolventReciprocity

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)] [∀ i, OrderTop (L i)]

/-- **Solvent reciprocity, strong form.** Under the Master Solvency Condition
(`⊤` realisable and affordable) every canonical option is the top outcome, and
the top outcome keeps every particular — the reading of stage 1 under which
`⊤` is "all existing particulars continue" is the hypothesis `htopkeeps`. No
union closure. -/
theorem solvent_keeps_everyone {P : Type*} (hn : 0 < n) (keeps : L ⟨0, hn⟩ → P → Prop)
    (htopkeeps : ∀ m : P, keeps ((⊤ : ∀ i, L i) ⟨0, hn⟩) m)
    {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (htopR : (⊤ : ∀ i, L i) ∈ R) (hsolv : c ⊤ ≤ B) {o : ∀ i, L i}
    (ho : Aligned (budgetFamily R c B) o) (m : P) : keeps (o ⟨0, hn⟩) m := by
  have ho' : o = ⊤ := (greatest_of_solvent htopR hsolv ho).1
  rw [ho']
  exact htopkeeps m

/-- **Reciprocity dominance, solvent form.** Under solvency, any mind kept by
any rival regime whatsoever — no closure on the family, no feasibility
assumption on the rival — is kept by the canonical regime. -/
theorem reciprocity_dominance_solvent {P : Type*} (hn : 0 < n)
    (keeps : L ⟨0, hn⟩ → P → Prop)
    (htopkeeps : ∀ m : P, keeps ((⊤ : ∀ i, L i) ⟨0, hn⟩) m)
    {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (htopR : (⊤ : ∀ i, L i) ∈ R) (hsolv : c ⊤ ≤ B) {o : ∀ i, L i}
    (ho : Aligned (budgetFamily R c B) o) (q : ∀ i, L i) (m : P)
    (_hm : keeps (q ⟨0, hn⟩) m) : keeps (o ⟨0, hn⟩) m :=
  solvent_keeps_everyone hn keeps htopkeeps htopR hsolv ho m

end Snuffy.SolventReciprocity
