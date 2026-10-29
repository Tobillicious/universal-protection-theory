/-
Snuffy — Canon Edition v4.1: Bennett's reversible simulation, and premise 5
derived from it (Part I premise 5; §17; Chapter 5 §5.4, P-slack).

  * bennett_step, bennett_compute_uncompute — compute–copy–uncompute: for any
    computation `f = h ∘ g` with workspace, the three steps
    `(x, c, y) ↦ (x, c + g x, y) ↦ (x, c + g x, y + h(c + g x)) ↦ (x, c, y + h(c + g x))`
    form a bijection that writes `f x` into a clean output register and returns
    the workspace exactly to its initial state: no garbage.
  * ent_equiv — a bijection of the register preserves Shannon entropy.
  * negMulLog_add_le, negMulLog_add_lt — subadditivity of `−t log t`, strict
    for two positive masses.
  * ent_push_le, ent_push_lt — overwriting the register by `f` never raises its
    entropy, and strictly lowers it when `f` merges two states of positive
    probability.
  * heat_reversible — in the Landauer model, a bijection of the register alone
    leaves the bath in its Gibbs state: exactly zero heat.
  * heat_irreversible — an implementation whose register ends in the law of
    `f` (an overwrite merging two states of positive probability) exports heat
    at least `k_BT (H(p) − H(f p)) > 0`.
  * premise5_from_bennett — with these, the Bennett counterpart has the same
    outcomes, costs strictly less, is feasible, and strictly gains slack, so
    no canonical option has irreversible administration
    (`PremiseFloor.reversible_administration_forced`), with nothing assumed
    about the counterpart.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Landauer
import Snuffy.PremiseFloor

open Finset Real

namespace Snuffy.Bennett

open Snuffy.Landauer

/-! ## Compute, copy, uncompute -/

section Construction

variable {α γ β : Type*} [AddGroup γ] [AddGroup β]

/-- One Bennett cycle: compute `g` into the workspace, add `h` of the workspace
into the output, uncompute `g`. -/
def bennettStep (g : α → γ) (h : γ → β) (z : α × γ × β) : α × γ × β :=
  (z.1, z.2.1, z.2.2 + h (z.2.1 + g z.1))

/-- The Bennett cycle is a bijection (its inverse subtracts `h`). -/
def bennettEquiv (g : α → γ) (h : γ → β) : α × γ × β ≃ α × γ × β where
  toFun := bennettStep g h
  invFun z := (z.1, z.2.1, z.2.2 - h (z.2.1 + g z.1))
  left_inv z := by simp [bennettStep]
  right_inv z := by simp [bennettStep]

/-- The three steps compose to the Bennett cycle. -/
theorem bennett_step (g : α → γ) (h : γ → β) (z : α × γ × β) :
    let s1 : α × γ × β := (z.1, z.2.1 + g z.1, z.2.2)
    let s2 : α × γ × β := (s1.1, s1.2.1, s1.2.2 + h s1.2.1)
    let s3 : α × γ × β := (s2.1, s2.2.1 - g s2.1, s2.2.2)
    s3 = bennettStep g h z := by
  simp [bennettStep]

/-- **No garbage.** From a clean workspace and output, the cycle leaves the
input, a clean workspace, and `h (g x)` in the output. -/
theorem bennett_compute_uncompute (g : α → γ) (h : γ → β) (x : α) :
    bennettEquiv g h (x, 0, 0) = (x, 0, h (g x)) := by
  simp [bennettEquiv, bennettStep]

end Construction

/-! ## Entropy under bijections and under overwrites -/

section Entropy

variable {α ι : Type*} [Fintype α] [Fintype ι] [DecidableEq ι]

/-- A bijection of the register preserves Shannon entropy. -/
theorem ent_equiv (p : α → ℝ) (e : α ≃ α) : ent (fun x => p (e.symm x)) = ent p := by
  unfold ent
  exact Equiv.sum_comp e.symm (fun x => negMulLog (p x))

/-- Subadditivity of `−t log t`. -/
theorem negMulLog_add_le {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) :
    negMulLog (a + b) ≤ negMulLog a + negMulLog b := by
  rcases ha.eq_or_lt with rfl | ha'
  · simp
  rcases hb.eq_or_lt with rfl | hb'
  · simp
  have h1 : log a ≤ log (a + b) := log_le_log ha' (by linarith)
  have h2 : log b ≤ log (a + b) := log_le_log hb' (by linarith)
  simp only [negMulLog]
  nlinarith [mul_le_mul_of_nonneg_left h1 ha, mul_le_mul_of_nonneg_left h2 hb]

/-- Strict subadditivity for two positive masses. -/
theorem negMulLog_add_lt {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    negMulLog (a + b) < negMulLog a + negMulLog b := by
  have h1 : log a < log (a + b) := log_lt_log ha (by linarith)
  have h2 : log b ≤ log (a + b) := log_le_log hb (by linarith)
  simp only [negMulLog]
  nlinarith [mul_lt_mul_of_pos_left h1 ha, mul_le_mul_of_nonneg_left h2 hb.le]

omit [Fintype α] in
theorem negMulLog_sum_le (s : Finset α) (p : α → ℝ) (hp : ∀ x, 0 ≤ p x) :
    negMulLog (∑ x ∈ s, p x) ≤ ∑ x ∈ s, negMulLog (p x) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
    rw [sum_insert ha, sum_insert ha]
    exact (negMulLog_add_le (hp a) (sum_nonneg fun x _ => hp x)).trans (by linarith)

/-- The law of the register after overwriting it by `f`. -/
def push (p : α → ℝ) (f : α → ι) (y : ι) : ℝ := ∑ x ∈ univ.filter (fun x => f x = y), p x

theorem ent_eq_fiber (p : α → ℝ) (f : α → ι) :
    ent p = ∑ y, ∑ x ∈ univ.filter (fun x => f x = y), negMulLog (p x) := by
  unfold ent
  rw [sum_fiberwise_of_maps_to (fun x _ => mem_univ (f x))]

/-- **Overwriting never raises entropy.** -/
theorem ent_push_le (p : α → ℝ) (hp : ∀ x, 0 ≤ p x) (f : α → ι) : ent (push p f) ≤ ent p := by
  rw [ent_eq_fiber p f]
  exact sum_le_sum fun y _ => negMulLog_sum_le _ p hp

/-- **A merging overwrite strictly lowers entropy.** If `f` sends two distinct
states of positive probability to the same value, the register's entropy drops. -/
theorem ent_push_lt (p : α → ℝ) (hp : ∀ x, 0 ≤ p x) (f : α → ι) {x₁ x₂ : α} (hne : x₁ ≠ x₂)
    (hf : f x₁ = f x₂) (h₁ : 0 < p x₁) (h₂ : 0 < p x₂) : ent (push p f) < ent p := by
  classical
  rw [ent_eq_fiber p f]
  apply sum_lt_sum (fun y _ => negMulLog_sum_le _ p hp)
  refine ⟨f x₁, mem_univ _, ?_⟩
  set s := univ.filter (fun x => f x = f x₁)
  have hx₁ : x₁ ∈ s := by simp [s]
  have hx₂ : x₂ ∈ s.erase x₁ := by simp [s, hne.symm, hf]
  rw [← add_sum_erase s _ hx₁, ← add_sum_erase s _ hx₁]
  have hrest : 0 < ∑ x ∈ s.erase x₁, p x :=
    lt_of_lt_of_le h₂ (single_le_sum (fun x _ => hp x) hx₂)
  calc negMulLog (p x₁ + ∑ x ∈ s.erase x₁, p x)
      < negMulLog (p x₁) + negMulLog (∑ x ∈ s.erase x₁, p x) := negMulLog_add_lt h₁ hrest
    _ ≤ negMulLog (p x₁) + ∑ x ∈ s.erase x₁, negMulLog (p x) := by
        linarith [negMulLog_sum_le (s.erase x₁) p hp]

end Entropy

/-! ## Heat: zero for reversible steps, positive for merging overwrites -/

section Heat

variable {α β : Type*} [Fintype α] [Fintype β] [Nonempty β]

omit [Nonempty β] in
/-- **A reversible step exports no heat.** A bijection of the register alone,
with the bath untouched, leaves the bath in its Gibbs state. -/
theorem heat_reversible (p : α → ℝ) (hp1 : ∑ x, p x = 1) (b : ℝ) (E : β → ℝ) (e : α ≃ α) :
    heat p b E (e.prodCongr (Equiv.refl β)) = 0 := by
  have hB : ∀ y, margB (evolve p b E (e.prodCongr (Equiv.refl β))) y = gibbs b E y := by
    intro y
    simp only [margB, evolve, Equiv.prodCongr_symm, Equiv.prodCongr_apply, Equiv.refl_symm,
      Equiv.coe_refl, id_eq, Prod.map_fst, Prod.map_snd]
    rw [← sum_mul, Equiv.sum_comp e.symm p, hp1, one_mul]
  unfold heat
  simp only [hB, sub_self]

/-- **A merging overwrite exports heat.** If the joint dynamics leaves the
register in the law of `f` and `f` merges two states of positive probability,
then the heat delivered to the bath is at least `k_BT (H(p) − H(f p)) > 0`. -/
theorem heat_irreversible [DecidableEq α] (p : α → ℝ) (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1)
    {kT : ℝ} (hkT : 0 < kT) (E : β → ℝ) (σ : α × β ≃ α × β) (f : α → α)
    (himpl : margA (evolve p (1 / kT) E σ) = push p f) {x₁ x₂ : α} (hne : x₁ ≠ x₂)
    (hf : f x₁ = f x₂) (h₁ : 0 < p x₁) (h₂ : 0 < p x₂) :
    0 < kT * (ent p - ent (push p f)) ∧ kT * (ent p - ent (push p f)) ≤ heat p (1 / kT) E σ := by
  have hdrop := ent_push_lt p hp f hne hf h₁ h₂
  refine ⟨mul_pos hkT (by linarith), ?_⟩
  have h := landauer p hp hp1 (1 / kT) E σ
  rw [entDrop, himpl, div_mul_eq_mul_div, one_mul, le_div_iff₀ hkT] at h
  linarith

end Heat

/-! ## Premise 5 from Bennett -/

section Premise5

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- **Premise 5, derived.** Options are realisable outcome tuples of cost within
the budget `B`; an option's cost is its base cost plus the heat its
administration exports; the resource stage `j` records the residual slack
`B − cost`. Every option has a Bennett counterpart (`rev`) that is realisable,
has the same outcomes before the resource stage and the same base cost, and
whose administration exports no heat (`heat_reversible`); an option with
irreversible administration exports strictly positive heat (`heat_irreversible`).
Then no canonical option has irreversible administration. -/
theorem premise5_from_bennett (R : Set (∀ i, L i)) (base heatOf : (∀ i, L i) → ℝ) (B : ℝ)
    (j : Fin n) (slackAt : (∀ i, L i) → ℝ) (hmono : ∀ x y, slackAt x < slackAt y → x j < y j)
    (hslackdef : ∀ x, slackAt x = B - (base x + heatOf x))
    (Irreversible : (∀ i, L i) → Prop) (rev : (∀ i, L i) → (∀ i, L i))
    (hrevR : ∀ x ∈ R, rev x ∈ R) (hsame : ∀ x, ∀ i, i < j → rev x i = x i)
    (hbase : ∀ x, base (rev x) = base x) (hrevheat : ∀ x, heatOf (rev x) = 0)
    (hirr : ∀ x, Irreversible x → 0 < heatOf x)
    {o : ∀ i, L i} (ho : Snuffy.Greatestness.Aligned {x | x ∈ R ∧ base x + heatOf x ≤ B} o) :
    ¬ Irreversible o := by
  refine Snuffy.PremiseFloor.reversible_administration_forced ho Irreversible rev j
    (fun x hx hirrx => ⟨hrevR x hx.1, ?_⟩) hsame (fun x hirrx => hmono _ _ ?_)
  · rw [hbase, hrevheat]
    linarith [hx.2, hirr x hirrx]
  · rw [hslackdef, hslackdef, hbase, hrevheat]
    linarith [hirr x hirrx]

end Premise5

end Snuffy.Bennett
