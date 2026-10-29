/-
Snuffy — Canon Edition v4.1: the canonical order, no needless loss, and
universal greatestness, machine-checked (Chapter 5).

Outcome tuples have `n` stages; stage `i` takes values in a join-semilattice
`L i` (sets of particulars for the four outcome stages under union; residual
slack for the fifth under max). `o ≺ q` when at the first stage where they
differ, `q`'s value strictly exceeds `o`'s.

  * lexLt_trans, lexLt_irrefl — the canonical order is a strict partial order.
  * aligned_iff_no_needless_loss — Proposition 1: an option is canonically
    maximal in its feasible family iff it needlessly loses nothing at any stage.
  * lexLe_of_le — stage-wise inclusion implies the canonical comparison.
  * greatest_of_union_closed — universal greatestness: if the feasible family
    is closed under stage-wise union (P-emu(c), concurrent emulation), every
    canonical option contains every feasible option stage by stage.
  * strict_except_mirrors — and every other feasible option is either an
    exact mirror (equal at every stage) or strictly below.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Order.Lattice
import Mathlib.Order.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Nat.Find

namespace Snuffy.Greatestness

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- The canonical strict order: at the first stage where the tuples differ,
the second strictly exceeds the first. -/
def LexLt (o q : ∀ i, L i) : Prop :=
  ∃ j, (∀ i, i < j → o i = q i) ∧ o j < q j

/-- The canonical weak order: equal at every stage, or strictly below. -/
def LexLe (o q : ∀ i, L i) : Prop := o = q ∨ LexLt o q

theorem lexLt_irrefl (o : ∀ i, L i) : ¬ LexLt o o := by
  rintro ⟨j, -, h⟩
  exact lt_irrefl _ h

/-- The canonical order is transitive: take the earlier of the two first strict
stages. -/
theorem lexLt_trans {o p q : ∀ i, L i} (h₁ : LexLt o p) (h₂ : LexLt p q) : LexLt o q := by
  obtain ⟨j₁, he₁, hl₁⟩ := h₁
  obtain ⟨j₂, he₂, hl₂⟩ := h₂
  rcases lt_trichotomy j₁ j₂ with h | h | h
  · refine ⟨j₁, fun i hi => (he₁ i hi).trans (he₂ i (hi.trans h)), ?_⟩
    rw [← he₂ j₁ h]
    exact hl₁
  · subst h
    exact ⟨j₁, fun i hi => (he₁ i hi).trans (he₂ i hi), hl₁.trans hl₂⟩
  · refine ⟨j₂, fun i hi => (he₁ i (hi.trans h)).trans (he₂ i hi), ?_⟩
    rw [he₁ j₂ h]
    exact hl₂

/-- An option is aligned (canonically maximal) in a feasible family when no
feasible option lies strictly above it. -/
def Aligned (F : Set (∀ i, L i)) (o : ∀ i, L i) : Prop :=
  o ∈ F ∧ ∀ q ∈ F, ¬ LexLt o q

/-- A needless loss at stage `j`: a feasible option agrees at every earlier
stage and strictly exceeds at stage `j`. -/
def NeedlessLoss (F : Set (∀ i, L i)) (o : ∀ i, L i) (j : Fin n) : Prop :=
  ∃ q ∈ F, (∀ i, i < j → o i = q i) ∧ o j < q j

/-- **Proposition 1.** Canonical maximality is exactly the absence of needless
loss at every stage. -/
theorem aligned_iff_no_needless_loss (F : Set (∀ i, L i)) {o : ∀ i, L i} (ho : o ∈ F) :
    Aligned F o ↔ ∀ j, ¬ NeedlessLoss F o j := by
  constructor
  · rintro ⟨-, h⟩ j ⟨q, hq, he, hl⟩
    exact h q hq ⟨j, he, hl⟩
  · intro h
    refine ⟨ho, fun q hq ⟨j, he, hl⟩ => h j ⟨q, hq, he, hl⟩⟩

omit [∀ i, SemilatticeSup (L i)] in
/-- The first stage at which two distinct tuples differ. -/
private theorem exists_first_diff {o q : ∀ i, L i} (hne : o ≠ q) :
    ∃ j, (∀ i, i < j → o i = q i) ∧ o j ≠ q j := by
  classical
  have hex : ∃ k : ℕ, ∃ h : k < n, o ⟨k, h⟩ ≠ q ⟨k, h⟩ := by
    by_contra hall
    apply hne
    funext i
    by_contra hi
    exact hall ⟨i.1, i.2, hi⟩
  let k := Nat.find hex
  obtain ⟨hk, hkne⟩ := Nat.find_spec hex
  refine ⟨⟨k, hk⟩, fun i hi => ?_, hkne⟩
  by_contra hne'
  have hlt : i.1 < k := hi
  exact Nat.find_min hex hlt ⟨i.2, hne'⟩

/-- Stage-wise inclusion implies the canonical weak comparison. -/
theorem lexLe_of_le {o q : ∀ i, L i} (h : o ≤ q) : LexLe o q := by
  by_cases he : o = q
  · exact Or.inl he
  · obtain ⟨j, hj, hne⟩ := exists_first_diff he
    exact Or.inr ⟨j, hj, lt_of_le_of_ne (h j) hne⟩

/-- **Universal greatestness.** If the feasible family is closed under
stage-wise union — concurrent emulation realises the union of any two feasible
outcome tuples (P-emu(c)) — then every canonical option contains every
feasible option stage by stage. -/
theorem greatest_of_union_closed {F : Set (∀ i, L i)}
    (hF : ∀ x ∈ F, ∀ y ∈ F, x ⊔ y ∈ F) {o : ∀ i, L i} (ho : Aligned F o) :
    ∀ q ∈ F, q ≤ o := by
  intro q hq
  have hu : q ⊔ o ∈ F := hF q hq o ho.1
  have hou : o ≤ q ⊔ o := le_sup_right
  have heq : o = q ⊔ o := by
    by_contra hne
    obtain ⟨j, hj, hne'⟩ := exists_first_diff hne
    exact ho.2 _ hu ⟨j, hj, lt_of_le_of_ne (hou j) hne'⟩
  rw [heq]
  exact le_sup_left

/-- **Greatest in the canonical order, strict except exact mirrors.** Under
union closure, every feasible option either equals the canonical option at
every stage or lies strictly below it. -/
theorem strict_except_mirrors {F : Set (∀ i, L i)}
    (hF : ∀ x ∈ F, ∀ y ∈ F, x ⊔ y ∈ F) {o : ∀ i, L i} (ho : Aligned F o) :
    ∀ q ∈ F, q = o ∨ LexLt q o :=
  fun q hq => lexLe_of_le (greatest_of_union_closed hF ho q hq)

/-- Under union closure the canonical option is unique: two aligned options are
exact mirrors. -/
theorem aligned_unique {F : Set (∀ i, L i)}
    (hF : ∀ x ∈ F, ∀ y ∈ F, x ⊔ y ∈ F) {o o' : ∀ i, L i} (ho : Aligned F o)
    (ho' : Aligned F o') : o = o' :=
  le_antisymm (greatest_of_union_closed hF ho' o ho.1) (greatest_of_union_closed hF ho o' ho'.1)

end Snuffy.Greatestness
