/-
Snuffy — Canon Edition v4.1: the law's Propositions 2, 3 and 4, machine-checked
(working argument §§2–3; Part II, "The law"). Proposition 1 is
`Greatestness.aligned_iff_no_needless_loss`.

  * exists_aligned — Proposition 2: every finite nonempty feasible family has
    an aligned (canonically maximal) option.
  * life_guard — Proposition 2: some aligned option keeps everyone the standby
    option keeps at the first stage.
  * scope_guarantee_iff — Proposition 3: a rule requiring maximality only of
    the projection to a scope S guarantees no needless existing loss, for every
    feasible family, iff S is the whole existing domain.
  * same_priority_admits_needless_loss — Proposition 3: counting a new
    particular at the existing priority admits an option the canonical order
    shows needlessly loses an existing particular.
  * faithful_hold_dominates, faithful_hold_strict — Proposition 4: a statewise
    faithful hold dominates every rival on every upward-closed event, under any
    probability law on the worlds, strictly when the rival ends an existing
    particular with positive probability.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Greatestness
import Mathlib.Data.Set.Finite.Basic
import Mathlib.Order.WellFounded
import Mathlib.MeasureTheory.Measure.Typeclasses.Finite

open Snuffy.Greatestness

namespace Snuffy.Law

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-! ## Proposition 2: finite existence and the life guard -/

/-- **Proposition 2 (finite existence).** Every finite nonempty feasible family
has an aligned option. -/
theorem exists_aligned (F : Set (∀ i, L i)) (hfin : F.Finite) (hne : F.Nonempty) :
    ∃ o, Aligned F o := by
  have : Finite F := hfin.to_subtype
  let r : F → F → Prop := fun a b => LexLt b.1 a.1
  have : IsTrans F r := ⟨fun a b c h₁ h₂ => lexLt_trans h₂ h₁⟩
  have : Std.Irrefl r := ⟨fun a h => lexLt_irrefl _ h⟩
  have wf : WellFounded r := Finite.wellFounded_of_trans_of_irrefl r
  obtain ⟨o₀, ho₀⟩ := hne
  obtain ⟨m, -, hm⟩ := wf.has_min Set.univ ⟨⟨o₀, ho₀⟩, trivial⟩
  exact ⟨m.1, m.2, fun q hq hlt => hm ⟨q, hq⟩ trivial hlt⟩

/-- At the first stage, the canonical order never decreases. -/
theorem lexLt_first_le (hn : 0 < n) {o q : ∀ i, L i} (h : LexLt o q) :
    o ⟨0, hn⟩ ≤ q ⟨0, hn⟩ := by
  obtain ⟨j, he, hl⟩ := h
  by_cases hj : j = ⟨0, hn⟩
  · subst hj
    exact hl.le
  · have hpos : (⟨0, hn⟩ : Fin n) < j := by
      rw [Fin.lt_def]
      exact Nat.pos_of_ne_zero fun h0 => hj (Fin.ext h0)
    exact (he _ hpos).le

/-- **Proposition 2 (life guard).** Some aligned option keeps, at the first
stage, everyone the standby option `b` keeps. -/
theorem life_guard (hn : 0 < n) (F : Set (∀ i, L i)) (hfin : F.Finite) {b : ∀ i, L i}
    (hb : b ∈ F) : ∃ g, Aligned F g ∧ b ⟨0, hn⟩ ≤ g ⟨0, hn⟩ := by
  set G := {o ∈ F | b ⟨0, hn⟩ ≤ o ⟨0, hn⟩}
  obtain ⟨g, hgG, hgmax⟩ := exists_aligned G (hfin.subset fun _ h => h.1) ⟨b, hb, le_rfl⟩
  refine ⟨g, ⟨hgG.1, fun q hq hlt => ?_⟩, hgG.2⟩
  exact hgmax q ⟨hq, hgG.2.trans (lexLt_first_le hn hlt)⟩ hlt

/-! ## Proposition 3: the scope requirement -/

section Scope

variable {P : Type*}

/-- A needless existing loss: a feasible option keeps strictly more. -/
def NeedlessLoss₁ (F : Set (Set P)) (o : Set P) : Prop := ∃ q ∈ F, o ⊂ q

/-- Maximality of the projection to a scope `S`. -/
def ProjMax (S : Set P) (F : Set (Set P)) (o : Set P) : Prop :=
  o ∈ F ∧ ∀ q ∈ F, ¬ (o ∩ S ⊂ q ∩ S)

/-- **Proposition 3.** Projected maximality on `S` guarantees no needless
existing loss for every feasible family iff `S` is the whole domain. -/
theorem scope_guarantee_iff (S : Set P) :
    (∀ (F : Set (Set P)) (o : Set P), ProjMax S F o → ¬ NeedlessLoss₁ F o) ↔ S = Set.univ := by
  constructor
  · intro h
    by_contra hS
    obtain ⟨x, hx⟩ : ∃ x, x ∉ S := by
      by_contra hall
      push Not at hall
      exact hS (Set.eq_univ_of_forall hall)
    apply h {∅, {x}} ∅
    · refine ⟨Or.inl rfl, fun q hq => ?_⟩
      rcases hq with rfl | rfl
      · simp
      · intro hlt
        have : ({x} : Set P) ∩ S = ∅ := by
          ext y; simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_empty_iff_false,
            iff_false, not_and]; rintro rfl; exact hx
        rw [this] at hlt
        simp at hlt
    · exact ⟨{x}, Or.inr rfl, Set.empty_ssubset.mpr ⟨x, rfl⟩⟩
  · rintro rfl F o ⟨_, hmax⟩ ⟨q, hq, hlt⟩
    exact hmax q hq (by simpa using hlt)

/-- **Proposition 3 (priority).** Ranking a new particular `y` at the same
priority as an existing particular `x` makes the option "end x, make y"
maximal among {keep x, make y}, although the canonical order (existing first)
shows it needlessly loses `x`. -/
theorem same_priority_admits_needless_loss {x y : P} (hxy : x ≠ y) :
    (∀ q ∈ ({{x}, {y}} : Set (Set P)), ¬ (({y} : Set P) ⊂ q)) ∧
      ({y} : Set P) ∩ {x} ⊂ ({x} : Set P) ∩ {x} := by
  constructor
  · intro q hq hlt
    rcases hq with rfl | rfl
    · have := hlt.1 (Set.mem_singleton y)
      exact hxy (Set.mem_singleton_iff.mp this).symm
    · exact ssubset_irrefl _ hlt
  · have h1 : ({y} : Set P) ∩ {x} = ∅ := by
      ext z; simp only [Set.mem_inter_iff, Set.mem_singleton_iff, Set.mem_empty_iff_false,
        iff_false, not_and]; rintro rfl; exact fun h => hxy h.symm
    rw [h1, Set.inter_self]
    exact Set.empty_ssubset.mpr ⟨x, rfl⟩

end Scope

/-! ## Proposition 4: faithful holds dominate -/

section Holds

open MeasureTheory

/-- An event is upward closed in the canonical order. -/
def UpwardClosed (U : Set (∀ i, L i)) : Prop := ∀ a b, LexLe a b → a ∈ U → b ∈ U

/-- **Proposition 4.** If the hold's outcome is at least the rival's in every
world, then for every upward-closed event and every law on the worlds, the
hold realises the event with at least the rival's probability. -/
theorem faithful_hold_dominates {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    (Oπ Oh : Ω → ∀ i, L i) (hdom : ∀ w, LexLe (Oπ w) (Oh w)) (U : Set (∀ i, L i))
    (hU : UpwardClosed U) : μ (Oπ ⁻¹' U) ≤ μ (Oh ⁻¹' U) :=
  measure_mono fun w hw => hU _ _ (hdom w) hw

omit [∀ i, SemilatticeSup (L i)] in
/-- **Proposition 4 (strictness).** If the hold keeps the event in every world
(e.g. every existing particular continues) while the rival misses it with
positive probability, the hold is strictly better on that event. -/
theorem faithful_hold_strict {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsFiniteMeasure μ]
    (Oπ Oh : Ω → ∀ i, L i) (U : Set (∀ i, L i)) (hkeep : ∀ w, Oh w ∈ U)
    (hmeas : MeasurableSet (Oπ ⁻¹' U)) (hmiss : 0 < μ (Oπ ⁻¹' U)ᶜ) :
    μ (Oπ ⁻¹' U) < μ (Oh ⁻¹' U) := by
  have huniv : Oh ⁻¹' U = Set.univ := Set.eq_univ_of_forall hkeep
  rw [huniv]
  have hsplit := measure_add_measure_compl (μ := μ) hmeas
  have hfin : μ (Oπ ⁻¹' U) ≠ ⊤ := measure_ne_top μ _
  calc μ (Oπ ⁻¹' U) < μ (Oπ ⁻¹' U) + μ (Oπ ⁻¹' U)ᶜ := ENNReal.lt_add_right hfin hmiss.ne'
    _ = μ Set.univ := hsplit

end Holds

end Snuffy.Law
