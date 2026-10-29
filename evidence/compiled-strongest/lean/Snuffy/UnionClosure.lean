/-
Snuffy — Canon Edition v4.1: universal greatestness at the declared premises,
from the Master Solvency Condition (Chapter 5, §5.3–5.4; premise 6; Global D).

The canonical regime's feasible family is the realisable outcome tuples whose
cost is within its budget (`budgetFamily`). Keeping every particular at every
stage is the top outcome. Premise 6 says the canonical regime's income covers
the protection of every covered particular, and coverage R ∨ H reaches every
particular; so the top outcome is feasible, and the canonical outcome is the
top.

  * greatest_or_irrelevant — greatest, or not a protector: by income-or-
    irrelevance, either the canonical ledger is solvent at every step and the
    canonical regime is greatest at every step, or it breaches and is
    comparison-void as a protector. No premise is assumed.
  * greatest_of_solvent, strict_of_solvent — universal greatestness: under
    solvency every canonical option keeps every particular, and the outcome of
    every rival regime whatsoever is contained in it, strictly below or an
    exact mirror. No union closure, slack inequality or cost model is needed.
  * aligned_eq_of_greatest — a feasible family with a greatest option has that
    option as its only canonical option.
  * insolvent_not_greatest — the unfunded branch: when keeping everything costs
    more than the income, a rival can keep a particular the canonical option
    does not. Income-or-irrelevance classifies such regimes as irrelevant.

The finer results hold even below full solvency:

  * dominates_of_affordable, strict_of_affordable — every realisable rival
    whose union with the canonical outcome is affordable is contained in it.
  * dominates_within_slack — with subadditive cost, every finite set of rivals
    whose total cost fits in the canonical slack is contained in it.
  * greatest_of_affordable — when every feasible pair is jointly affordable,
    greatestness holds outright.
  * aligned_never_below — whatever the budget, no feasible rival is
    canonically above the canonical option.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Greatestness
import Snuffy.PremiseFloor
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Linarith

open Snuffy.Greatestness Finset

namespace Snuffy.UnionClosure

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- The canonical regime's feasible family within budget `B`: realisable
outcome tuples of cost at most `B`. -/
def budgetFamily (R : Set (∀ i, L i)) (c : (∀ i, L i) → ℝ) (B : ℝ) : Set (∀ i, L i) :=
  {x | x ∈ R ∧ c x ≤ B}

/-- Realisability is union-closed: concurrent emulation through the shared
action interface realises the stage-wise union of any two realisable outcome
tuples. Resources are accounted for separately, by the cost. -/
def UnionRealizable (R : Set (∀ i, L i)) : Prop := ∀ x ∈ R, ∀ y ∈ R, x ⊔ y ∈ R

/-- **Never canonically below.** Whatever the budget, no feasible rival lies
strictly above the canonical option in the canonical order. -/
theorem aligned_never_below {F : Set (∀ i, L i)} {o : ∀ i, L i} (ho : Aligned F o) :
    ∀ q ∈ F, ¬ LexLt o q := ho.2

/-- **Dominance of affordable rivals.** If realisability is union-closed, every
realisable rival `q` whose union with the canonical outcome fits in the budget
is contained in the canonical outcome, stage by stage. -/
theorem dominates_of_affordable {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (hR : UnionRealizable R) {o : ∀ i, L i} (ho : Aligned (budgetFamily R c B) o)
    {q : ∀ i, L i} (hq : q ∈ R) (hcost : c (q ⊔ o) ≤ B) : q ≤ o := by
  have hu : q ⊔ o ∈ budgetFamily R c B := ⟨hR q hq o ho.1.1, hcost⟩
  rcases lexLe_of_le (le_sup_right : o ≤ q ⊔ o) with heq | hlt
  · rw [heq]
    exact le_sup_left
  · exact absurd hlt (ho.2 _ hu)

/-- Affordable rivals are strictly below the canonical option or exact mirrors. -/
theorem strict_of_affordable {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (hR : UnionRealizable R) {o : ∀ i, L i} (ho : Aligned (budgetFamily R c B) o)
    {q : ∀ i, L i} (hq : q ∈ R) (hcost : c (q ⊔ o) ≤ B) : q = o ∨ LexLt q o :=
  lexLe_of_le (dominates_of_affordable hR ho hq hcost)

/-- The union of the canonical outcome with any finite set of realisable rivals
is realisable and costs at most the sum, under subadditive cost. -/
theorem exists_union_bound {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} (hR : UnionRealizable R)
    (hsub : ∀ x y, c (x ⊔ y) ≤ c x + c y) {o : ∀ i, L i} (ho : o ∈ R) {ι : Type*}
    (q : ι → ∀ i, L i) (s : Finset ι) (hq : ∀ j ∈ s, q j ∈ R) :
    ∃ u ∈ R, o ≤ u ∧ (∀ j ∈ s, q j ≤ u) ∧ c u ≤ c o + ∑ j ∈ s, c (q j) := by
  classical
  induction s using Finset.induction_on with
  | empty => exact ⟨o, ho, le_rfl, by simp, by simp⟩
  | insert a s ha ih =>
    obtain ⟨u, hu, hou, hqu, hcu⟩ := ih fun j hj => hq j (mem_insert_of_mem hj)
    refine ⟨u ⊔ q a, hR u hu (q a) (hq a (mem_insert_self a s)), hou.trans le_sup_left,
      fun j hj => ?_, ?_⟩
    · rcases mem_insert.mp hj with rfl | hj
      · exact le_sup_right
      · exact (hqu j hj).trans le_sup_left
    · rw [sum_insert ha]
      linarith [hsub u (q a)]

/-- **Dominance within slack.** With subadditive cost, every finite set of
realisable rivals whose total cost fits in the canonical slack `B − c(o)` is
contained in the canonical outcome, stage by stage: the canonical regime keeps
everything any of them keeps. -/
theorem dominates_within_slack {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (hR : UnionRealizable R) (hsub : ∀ x y, c (x ⊔ y) ≤ c x + c y) {o : ∀ i, L i}
    (ho : Aligned (budgetFamily R c B) o) {ι : Type*} (q : ι → ∀ i, L i) (s : Finset ι)
    (hq : ∀ j ∈ s, q j ∈ R) (hslack : ∑ j ∈ s, c (q j) ≤ B - c o) : ∀ j ∈ s, q j ≤ o := by
  obtain ⟨u, hu, hou, hqu, hcu⟩ := exists_union_bound hR hsub ho.1.1 q s hq
  have huF : u ∈ budgetFamily R c B := ⟨hu, by linarith⟩
  rcases lexLe_of_le hou with heq | hlt
  · intro j hj
    rw [heq]
    exact hqu j hj
  · exact absurd hlt (ho.2 _ huF)

/-- **Universal greatestness from the budget.** If realisability is
union-closed and every pair of feasible tuples is jointly affordable, the
budget family is union-closed, so every canonical option contains every
feasible option. -/
theorem union_closed_of_affordable {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (hR : UnionRealizable R)
    (hjoint : ∀ x ∈ budgetFamily R c B, ∀ y ∈ budgetFamily R c B, c (x ⊔ y) ≤ B) :
    ∀ x ∈ budgetFamily R c B, ∀ y ∈ budgetFamily R c B, x ⊔ y ∈ budgetFamily R c B :=
  fun x hx y hy => ⟨hR x hx.1 y hy.1, hjoint x hx y hy⟩

theorem greatest_of_affordable {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (hR : UnionRealizable R)
    (hjoint : ∀ x ∈ budgetFamily R c B, ∀ y ∈ budgetFamily R c B, c (x ⊔ y) ≤ B)
    {o : ∀ i, L i} (ho : Aligned (budgetFamily R c B) o) :
    ∀ q ∈ budgetFamily R c B, q ≤ o :=
  greatest_of_union_closed (union_closed_of_affordable hR hjoint) ho

/-- **Greatestness from a greatest feasible option.** If the feasible family
contains an option that contains every feasible option, every canonical option
is that option. -/
theorem aligned_eq_of_greatest {F : Set (∀ i, L i)} {t : ∀ i, L i} (ht : t ∈ F)
    (htop : ∀ q ∈ F, q ≤ t) {o : ∀ i, L i} (ho : Aligned F o) : o = t := by
  rcases lexLe_of_le (htop o ho.1) with h | h
  · exact h
  · exact absurd h (ho.2 t ht)

section Solvent

variable [∀ i, OrderTop (L i)]

/-- **Universal greatestness at the declared premises.** Keeping every
particular at every stage is the top outcome `⊤`. Under the Master Solvency
Condition (premise 6) the canonical regime's income covers the protection of
every covered particular, so `⊤` is realisable within its budget; coverage
`R ∨ H` reaches every particular. Then every canonical option keeps every
particular, and the outcome of every rival regime whatsoever is contained in
it, stage by stage. No union closure, slack inequality or cost model is
needed. -/
theorem greatest_of_solvent {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (htopR : (⊤ : ∀ i, L i) ∈ R) (hsolv : c ⊤ ≤ B) {o : ∀ i, L i}
    (ho : Aligned (budgetFamily R c B) o) : o = ⊤ ∧ ∀ q : ∀ i, L i, q ≤ o := by
  have ho' : o = ⊤ := aligned_eq_of_greatest (show (⊤ : ∀ i, L i) ∈ budgetFamily R c B from ⟨htopR, hsolv⟩)
    (fun q _ => le_top) ho
  exact ⟨ho', fun q => ho' ▸ le_top⟩

/-- Under solvency every rival outcome is strictly below the canonical one or an
exact mirror of it. -/
theorem strict_of_solvent {R : Set (∀ i, L i)} {c : (∀ i, L i) → ℝ} {B : ℝ}
    (htopR : (⊤ : ∀ i, L i) ∈ R) (hsolv : c ⊤ ≤ B) {o : ∀ i, L i}
    (ho : Aligned (budgetFamily R c B) o) : ∀ q : ∀ i, L i, q = o ∨ LexLt q o :=
  fun q => lexLe_of_le ((greatest_of_solvent htopR hsolv ho).2 q)

/-- **Greatest, or not a protector.** Let the canonical regime's demand at
step `k` be the cost of keeping every particular, and its budget at step `k` be
its escrow balance plus that step's income. By income-or-irrelevance
(`PremiseFloor.income_or_irrelevance`) exactly one holds: the ledger is solvent
at every step, and then at every step every canonical option keeps every
particular and contains the outcome of every rival regime whatsoever; or the
ledger has a first breach step, the irrelevance branch, in which the regime
cannot fund the protection of every particular and is comparison-void as a
protector (`PremiseFloor.breach_strictly_below`). No premise is assumed. -/
theorem greatest_or_irrelevant (E₀ : ℝ) (inc dem : ℕ → ℝ) (R : ℕ → Set (∀ i, L i))
    (c : ℕ → (∀ i, L i) → ℝ) (htopR : ∀ k, (⊤ : ∀ i, L i) ∈ R k) (hcost : ∀ k, c k ⊤ = dem k) :
    (∀ k (o : ∀ i, L i),
        Aligned (budgetFamily (R k) (c k) (Snuffy.PremiseFloor.balance E₀ inc dem k + inc k)) o →
          o = ⊤ ∧ ∀ q : ∀ i, L i, q ≤ o) ∨
      ∃ kb, (∀ k < kb, 0 ≤ Snuffy.PremiseFloor.balance E₀ inc dem k) ∧
        Snuffy.PremiseFloor.balance E₀ inc dem kb < 0 := by
  rcases Snuffy.PremiseFloor.income_or_irrelevance E₀ inc dem with hs | hb
  · left
    intro k o ho
    have hstep : Snuffy.PremiseFloor.balance E₀ inc dem (k + 1)
        = Snuffy.PremiseFloor.balance E₀ inc dem k + inc k - dem k := by
      unfold Snuffy.PremiseFloor.balance
      rw [Finset.sum_range_succ]
      ring
    have h1 := hs (k + 1)
    exact greatest_of_solvent (htopR k) (by rw [hcost]; linarith) ho
  · exact Or.inr hb

end Solvent

/-- **An insolvent regime is not greatest.** With one stage, two particulars,
each kept at unit cost, and budget one, keeping everything costs more than the
income: the Master Solvency Condition fails. The option keeping the first
particular is then canonical, yet a feasible option keeping the second is not
contained in it. This is the unfunded branch that income-or-irrelevance
(`PremiseFloor.income_or_irrelevance`) classifies as irrelevant. -/
theorem insolvent_not_greatest :
    ∃ (R : Set (Fin 1 → Finset Bool)) (c : (Fin 1 → Finset Bool) → ℝ) (B : ℝ)
      (o q : Fin 1 → Finset Bool),
      UnionRealizable (L := fun _ => Finset Bool) R ∧
      Aligned (L := fun _ => Finset Bool) (budgetFamily (L := fun _ => Finset Bool) R c B) o ∧
      q ∈ budgetFamily (L := fun _ => Finset Bool) R c B ∧ ¬ q ≤ o := by
  refine ⟨Set.univ, fun x => ((x 0).card : ℝ), 1, fun _ => {true}, fun _ => {false},
    fun _ _ _ _ => trivial, ⟨⟨trivial, by simp⟩, ?_⟩, ⟨trivial, by simp⟩, ?_⟩
  · rintro q' ⟨-, hc⟩ ⟨j, -, hlt⟩
    have hj : j = 0 := Subsingleton.elim j 0
    subst hj
    have hcard : ({true} : Finset Bool).card < (q' 0).card := Finset.card_lt_card hlt
    simp only [Finset.card_singleton] at hcard
    have : (2 : ℝ) ≤ ((q' 0).card : ℝ) := by exact_mod_cast hcard
    simp only at hc
    linarith
  · intro h
    have h0 := h 0
    simp at h0

end Snuffy.UnionClosure
