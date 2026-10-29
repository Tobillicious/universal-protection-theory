/-
Snuffy — Canon Edition 4.2 working: the wavefront sweep with tolerant local
correction, and the reduction of sparse-failure recovery to an eroder
property of the dependency geometry (review objection 7, item 5).

The sweep is `G3Sweep.sweep`, with the same TIWA fence. The local correction
of `v` reads the frozen interior through its dependencies `D v`, all in
earlier shells. Tolerance means that a good patch, one whose own window does
not hold enough faults, returns its target whenever at most `τ` of its
dependencies are wrong.

  * frozen_after — once its wave has run, a vertex keeps its value through
    every later wave and fenced outer step.
  * wrong_has_cause — after `N` waves, every wrong vertex of the first `N`
    shells is bad or has more than `τ` wrong dependencies.
  * wrong_le_of_eroder — if the geometry is an eroder (every self-supporting
    set `X` has `|X| ≤ C |X ∩ Bad|`), the wrong vertices number at most `C`
    times the bad ones. With `SparseFailure.many_failures` bounding the bad
    vertices, a wrong fraction above `C θ` is exponentially unlikely in the
    number of patches, uniformly in age.

  * wrong_subset_bad — when a good patch decodes correctly whatever its
    interior commits (a wrong inner commit reaches it only as an interface
    error of bounded weight, already counted in its own fault budget), every
    wrong vertex is bad. The eroder constant is then `C = 1`.
  * sweep_density — under local stochastic noise, with patch windows
    coloured `K` ways, at least `K n` wrong vertices among `N` occur with
    probability at most `K · C(N, n) · (C(w, k) p^k)^n`, for every age.

  * pathwise_bill — on the event that fewer than `m` vertices are wrong, the
    realised bill with per-vertex cost at most `base`, plus `repair` at a
    wrong vertex, is at most `base · N + repair · m`. This is the bill itself
    on that event, not its expectation. With `m = K n ≤ θ N` it is at most
    `(base + θ · repair) · N`, outside an event of probability at most
    `K · C(N, n) · q^n`.

  * recovery_tail — an outer decoder that returns the record whenever fewer
    than `K n` patches are wrong fails with probability at most
    `K · C(N, n) · (C(w, k) p^k)^n`, at every age.

The physical input is the interface property of the windowed decoder: a
wrong commit costs the next window at most `c` of its `k` faults.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G3Sweep
import Snuffy.SparseFailure

open Finset

namespace Snuffy.ToleranceSweep

open Snuffy.G3Sweep

variable {V Val : Type*} [DecidableEq V] [DecidableEq Val]

omit [DecidableEq V] [DecidableEq Val] in
/-- **Frozen after its wave.** -/
theorem frozen_after (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ : V → Val)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v) (v : V) :
    ∀ j, layer v + 1 ≤ j → sweep layer corr outer s₀ j v = sweep layer corr outer s₀ (layer v + 1) v := by
  intro j hj
  induction j with
  | zero => omega
  | succ j ih =>
      rcases Nat.eq_or_lt_of_le hj with h | h
      · rw [h]
      · have hj' : layer v + 1 ≤ j := by omega
        show wave layer corr j (outer j (sweep layer corr outer s₀ j)) v = _
        unfold wave
        have hne : ¬ layer v = j := by omega
        simp only [hne, ↓reduceIte]
        rw [hfence j _ v (by omega)]
        exact ih hj'

omit [DecidableEq V] in
/-- **Every wrong vertex has a cause.** -/
theorem wrong_has_cause (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ target : V → Val)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (D : V → Finset V) (hD : ∀ v, ∀ u ∈ D v, layer u < layer v)
    (bad : V → Prop) (τ : ℕ)
    (htol : ∀ v s, ¬ bad v → ((D v).filter fun u => s u ≠ target u).card ≤ τ →
      corr v s = target v)
    (N : ℕ) (v : V) (hv : layer v < N)
    (hw : sweep layer corr outer s₀ N v ≠ target v) :
    bad v ∨ τ < ((D v).filter fun u => sweep layer corr outer s₀ N u ≠ target u).card := by
  have hSv : sweep layer corr outer s₀ N v =
      corr v (outer (layer v) (sweep layer corr outer s₀ (layer v))) := by
    rw [frozen_after layer corr outer s₀ hfence v N (by omega)]
    show wave layer corr (layer v) (outer (layer v) (sweep layer corr outer s₀ (layer v))) v = _
    unfold wave
    simp only [↓reduceIte]
  have hinput : ∀ u ∈ D v, outer (layer v) (sweep layer corr outer s₀ (layer v)) u =
      sweep layer corr outer s₀ N u := by
    intro u hu
    have hlt := hD v u hu
    rw [hfence (layer v) _ u hlt, frozen_after layer corr outer s₀ hfence u N (by omega),
      frozen_after layer corr outer s₀ hfence u (layer v) (by omega)]
  have hcount : ((D v).filter fun u =>
        outer (layer v) (sweep layer corr outer s₀ (layer v)) u ≠ target u) =
      ((D v).filter fun u => sweep layer corr outer s₀ N u ≠ target u) :=
    filter_congr fun u hu => by rw [hinput u hu]
  by_contra hno
  push Not at hno
  obtain ⟨hgood, hle⟩ := hno
  exact hw (hSv.trans (htol v _ hgood (hcount ▸ hle)))

omit [DecidableEq Val] in
/-- **Wrong vertices from an eroder geometry.** -/
theorem wrong_le_of_eroder (P Wr Bad : Finset V) (D : V → Finset V) (τ C : ℕ)
    (hWr : Wr ⊆ P) (hcause : ∀ v ∈ Wr, v ∈ Bad ∨ τ < (D v ∩ Wr).card)
    (heroder : ∀ X ⊆ P, (∀ x ∈ X, x ∈ Bad ∨ τ < (D x ∩ X).card) → X.card ≤ C * (X ∩ Bad).card) :
    Wr.card ≤ C * Bad.card :=
  (heroder Wr hWr hcause).trans (Nat.mul_le_mul_left C (card_le_card inter_subset_right))

omit [DecidableEq V] [DecidableEq Val] in
/-- **Interface-tolerant correction: every wrong vertex is bad.** -/
theorem wrong_subset_bad (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ target : V → Val)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (bad : V → Prop) (htol : ∀ v s, ¬ bad v → corr v s = target v)
    (N : ℕ) (v : V) (hv : layer v < N)
    (hw : sweep layer corr outer s₀ N v ≠ target v) : bad v := by
  by_contra hb
  apply hw
  rw [frozen_after layer corr outer s₀ hfence v N (by omega)]
  show wave layer corr (layer v) (outer (layer v) (sweep layer corr outer s₀ (layer v))) v = _
  unfold wave
  simp only [↓reduceIte]
  exact htol v _ hb

open Snuffy.Threshold Snuffy.SparseFailure in
open scoped Classical in
/-- **Sweep density: many wrong vertices are exponentially unlikely, at every age.** -/
theorem sweep_density {Loc : Type*} [Fintype Loc] [DecidableEq Loc] (μ : FaultLaw Loc) {p : ℝ}
    (hp : 0 ≤ p) (hμ : LocalStochastic μ p) (layer : V → ℕ)
    (corr : Finset Loc → V → (V → Val) → Val) (outer : Finset Loc → ℕ → (V → Val) → (V → Val))
    (s₀ : Finset Loc → V → Val) (target : V → Val)
    (hfence : ∀ F k s v, layer v < k → outer F k s v = s v)
    (Wn : V → Finset Loc) {w k : ℕ} (hw : ∀ v, (Wn v).card ≤ w)
    (htol : ∀ F v s, (Wn v ∩ F).card < k → corr F v s = target v)
    (P : Finset V) (N : ℕ) (hP : ∀ v ∈ P, layer v < N) {K : ℕ} (hK : 0 < K) (col : V → Fin K)
    (hcol : ∀ a ∈ P, ∀ b ∈ P, a ≠ b → col a = col b → Disjoint (Wn a) (Wn b)) (n : ℕ) :
    prob μ (fun F => K * n ≤
        (P.filter fun v => sweep layer (corr F) (outer F) (s₀ F) N v ≠ target v).card) ≤
      K * (P.card.choose n) * ((w.choose k : ℝ) * p ^ k) ^ n := by
  have hsub : ∀ F, (P.filter fun v => sweep layer (corr F) (outer F) (s₀ F) N v ≠ target v) ⊆
      (P.filter fun v => k ≤ (Wn v ∩ F).card) := by
    intro F v hv
    obtain ⟨hvP, hvw⟩ := mem_filter.mp hv
    refine mem_filter.mpr ⟨hvP, ?_⟩
    by_contra hlt
    push Not at hlt
    exact hvw (by
      rw [frozen_after layer (corr F) (outer F) (s₀ F) (hfence F) v N (by have := hP v hvP; omega)]
      show wave layer (corr F) (layer v)
        (outer F (layer v) (sweep layer (corr F) (outer F) (s₀ F) (layer v))) v = _
      unfold wave
      simp only [↓reduceIte]
      exact htol F v _ hlt)
  have hmono : prob μ (fun F => K * n ≤
        (P.filter fun v => sweep layer (corr F) (outer F) (s₀ F) N v ≠ target v).card) ≤
      prob μ (fun F => K * n ≤ (P.filter fun v => k ≤ (Wn v ∩ F).card).card) := by
    unfold prob
    refine sum_le_sum fun F _ => ?_
    by_cases h1 : K * n ≤ (P.filter fun v => sweep layer (corr F) (outer F) (s₀ F) N v ≠ target v).card
    · have h2 : K * n ≤ (P.filter fun v => k ≤ (Wn v ∩ F).card).card :=
        h1.trans (card_le_card (hsub F))
      simp only [h1, h2, ↓reduceIte, le_refl]
    · simp only [h1, ↓reduceIte]
      split_ifs <;> simp [μ.nonneg F]
  refine hmono.trans ?_
  convert many_failures μ hp hμ Wn hw P hK col hcol (fun v F => k ≤ (Wn v ∩ F).card)
    (fun _ _ h => h) n

omit [DecidableEq Val] in
/-- **The pathwise bill on the sparse-failure event.** -/
theorem pathwise_bill (P Wr : Finset V) (cost : V → ℕ) (base repair m : ℕ)
    (hcost : ∀ v ∈ P, cost v ≤ base + if v ∈ Wr then repair else 0) (hWr : Wr ⊆ P)
    (hfew : Wr.card ≤ m) :
    ∑ v ∈ P, cost v ≤ base * P.card + repair * m := by
  calc ∑ v ∈ P, cost v ≤ ∑ v ∈ P, (base + if v ∈ Wr then repair else 0) := sum_le_sum hcost
    _ = base * P.card + repair * Wr.card := by
        rw [sum_add_distrib, sum_const, smul_eq_mul, mul_comm, sum_ite_mem, inter_eq_right.mpr hWr,
          sum_const, smul_eq_mul, mul_comm (#Wr)]
    _ ≤ base * P.card + repair * m := Nat.add_le_add_left (Nat.mul_le_mul_left _ hfew) _

open Snuffy.Threshold in
open scoped Classical in
/-- **Recovery of the record through a tolerant outer decoder.** -/
theorem recovery_tail {Loc Out : Type*} [Fintype Loc] [DecidableEq Loc] (μ : FaultLaw Loc) {p : ℝ}
    (hp : 0 ≤ p) (hμ : LocalStochastic μ p) (layer : V → ℕ)
    (corr : Finset Loc → V → (V → Val) → Val) (outer : Finset Loc → ℕ → (V → Val) → (V → Val))
    (s₀ : Finset Loc → V → Val) (target : V → Val)
    (hfence : ∀ F k s v, layer v < k → outer F k s v = s v)
    (Wn : V → Finset Loc) {w k : ℕ} (hw : ∀ v, (Wn v).card ≤ w)
    (htol : ∀ F v s, (Wn v ∩ F).card < k → corr F v s = target v)
    (P : Finset V) (N : ℕ) (hP : ∀ v ∈ P, layer v < N) {K : ℕ} (hK : 0 < K) (col : V → Fin K)
    (hcol : ∀ a ∈ P, ∀ b ∈ P, a ≠ b → col a = col b → Disjoint (Wn a) (Wn b)) (n : ℕ)
    (decOut : (V → Val) → Out) (rec : Out)
    (hout : ∀ s : V → Val, (P.filter fun v => s v ≠ target v).card < K * n → decOut s = rec) :
    prob μ (fun F => decOut (sweep layer (corr F) (outer F) (s₀ F) N) ≠ rec) ≤
      K * (P.card.choose n) * ((w.choose k : ℝ) * p ^ k) ^ n := by
  refine le_trans ?_ (sweep_density μ hp hμ layer corr outer s₀ target hfence Wn hw htol P N hP hK
    col hcol n)
  unfold prob
  refine sum_le_sum fun F _ => ?_
  split_ifs with ha hb hb
  · exact le_rfl
  · exfalso
    apply hb
    by_contra hlt
    push Not at hlt
    exact ha (hout _ hlt)
  · exact μ.nonneg F
  · exact le_rfl

end Snuffy.ToleranceSweep
