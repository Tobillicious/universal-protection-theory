/-
Snuffy — affordable reciprocity (next-proof register 2026-10-25, item 2;
the honest form of PATAI 3 A2).

Below full solvency, per-rival dominance needs exactly two named hypotheses:
the union of the rival with the canonical option is realisable through the
shared action interface (`UnionRealizable`, premise 4's clause), and that
union is affordable within the budget. Given these, any mind kept by the
rival is kept by the canonical regime. No union closure of the feasible
family, no solvency of the top option.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.UnionClosure

open Snuffy.Greatestness Snuffy.UnionClosure

namespace Snuffy.AffordableReciprocity

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- **Affordable reciprocity (below full solvency).** If the union of the
rival `q` with the canonical option is realisable (`UnionRealizable`) and
affordable, the rival's outcome is contained in the canonical one
(`dominates_of_affordable`), so any mind the rival keeps, the canonical
regime keeps. -/
theorem reciprocity_dominance_affordable {P : Type*} (hn : 0 < n)
    (keeps : L ⟨0, hn⟩ → P → Prop) (hmono : ∀ x y, x ≤ y → ∀ m, keeps x m → keeps y m)
    {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ} (hR : UnionRealizable R)
    {o : ∀ i, L i} (ho : Aligned (budgetFamily R c B) o) {q : ∀ i, L i}
    (hq : q ∈ R) (hcost : c (q ⊔ o) ≤ B) (m : P) (hm : keeps (q ⟨0, hn⟩) m) :
    keeps (o ⟨0, hn⟩) m :=
  hmono _ _ (dominates_of_affordable hR ho hq hcost ⟨0, hn⟩) m hm

end Snuffy.AffordableReciprocity
