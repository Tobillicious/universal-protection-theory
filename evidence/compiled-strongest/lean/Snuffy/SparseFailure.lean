/-
Snuffy — Canon Edition 4.2 working: sparse patch failure under local
stochastic noise, with no dependence on age (review objection 7, item 5).

Each patch `v` has a spacetime window `W v` of fault locations, and its
failure is decided by the faults in that window: it fails only if at least `k`
of them are faulty. For a windowed decoder, `k` is half the certified circuit
distance (`MatchingWitness`, the cut certificate). Patches are coloured with
`K` colours so that windows of one colour are disjoint. A periodic colouring
of the lattice gives this.

  * disjoint_windows — patches with pairwise disjoint windows all fail with
    probability at most `∏ C(|W v|, k) · p^(k |U|)`.
  * many_failures — at least `K n` of `N` patches fail with probability at most
    `K · C(N, n) · (C(w, k) p^k)^n`.

With `n = θN/K` the bound is at most `K (e K q / θ)^(θN/K)`, where
`q = C(w, k) p^k`. It falls exponentially in the number of patches once
`q < θ/(eK)`. A failed fraction above `θ` is therefore exponentially unlikely
however long the installation runs, and an outer decoder tolerating that
fraction keeps a constant overhead per location, with no logarithm. Failures
do occur, at a density of order `q`; the theorem bounds their number, not
their existence.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold
import Mathlib.Combinatorics.Pigeonhole

open Finset

namespace Snuffy.SparseFailure

open Snuffy.Threshold

variable {Loc V : Type*} [Fintype Loc] [DecidableEq Loc] [DecidableEq V]

open scoped Classical in
/-- **Patches with disjoint windows.** -/
theorem disjoint_windows (μ : FaultLaw Loc) {p : ℝ} (hμ : LocalStochastic μ p)
    (W : V → Finset Loc) (U : Finset V)
    (hdisj : ∀ a ∈ U, ∀ b ∈ U, a ≠ b → Disjoint (W a) (W b)) (k : ℕ) :
    prob μ (fun F => ∀ v ∈ U, k ≤ (W v ∩ F).card) ≤
      (∏ v ∈ U, ((W v).card.choose k : ℝ)) * p ^ (k * U.card) := by
  set secs := Fintype.piFinset (fun v : U => powersetCard k (W v.1))
  set Tg : (U → Finset Loc) → Finset Loc := fun g => univ.biUnion g
  have hcard : ∀ g ∈ secs, (Tg g).card = k * U.card := by
    intro g hg
    have hmem := fun v => mem_powersetCard.mp (Fintype.mem_piFinset.mp hg v)
    rw [card_biUnion]
    · simp only [fun v => (hmem v).2, sum_const, card_univ, Fintype.card_coe, smul_eq_mul, mul_comm]
    · intro a _ b _ hab
      exact (hdisj a.1 a.2 b.1 b.2 (fun h => hab (Subtype.ext h))).mono (hmem a).1 (hmem b).1
  have hpt : ∀ F, (if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0) ≤
      ∑ g ∈ secs, if Tg g ⊆ F then μ.P F else 0 := by
    intro F
    split_ifs with hU
    · have hch : ∀ v : U, ∃ S ⊆ W v.1 ∩ F, S.card = k := fun v => exists_subset_card_eq (hU v.1 v.2)
      choose g hgsub hgcard using hch
      have hg : g ∈ secs := Fintype.mem_piFinset.mpr fun v =>
        mem_powersetCard.mpr ⟨(hgsub v).trans inter_subset_left, hgcard v⟩
      have hsub : Tg g ⊆ F := by
        intro x hx
        obtain ⟨v, -, hxv⟩ := mem_biUnion.mp hx
        exact (mem_inter.mp (hgsub v hxv)).2
      have := single_le_sum (f := fun g => if Tg g ⊆ F then μ.P F else 0)
        (fun g _ => by split_ifs <;> simp [μ.nonneg F]) hg
      simp only [hsub, ↓reduceIte] at this
      exact this
    · exact sum_nonneg fun g _ => by split_ifs <;> simp [μ.nonneg F]
  calc prob μ (fun F => ∀ v ∈ U, k ≤ (W v ∩ F).card)
      ≤ ∑ F, ∑ g ∈ secs, (if Tg g ⊆ F then μ.P F else 0) := sum_le_sum fun F _ => hpt F
    _ = ∑ g ∈ secs, prob μ (fun F => Tg g ⊆ F) := by rw [sum_comm]; rfl
    _ ≤ ∑ g ∈ secs, p ^ (k * U.card) := by
        refine sum_le_sum fun g hg => ?_
        have := hμ (Tg g); rwa [hcard g hg] at this
    _ = (secs.card : ℝ) * p ^ (k * U.card) := by rw [sum_const, nsmul_eq_mul]
    _ = (∏ v ∈ U, ((W v).card.choose k : ℝ)) * p ^ (k * U.card) := by
        congr 1
        rw [Fintype.card_piFinset]
        push_cast
        simp only [card_powersetCard]
        exact Finset.prod_coe_sort U (fun v => ((W v).card.choose k : ℝ))

open scoped Classical in
/-- **Many failures are exponentially unlikely, uniformly in age.** -/
theorem many_failures (μ : FaultLaw Loc) {p : ℝ} (hp : 0 ≤ p) (hμ : LocalStochastic μ p)
    (W : V → Finset Loc) {w k : ℕ} (hw : ∀ v, (W v).card ≤ w) (P : Finset V) {K : ℕ}
    (hK : 0 < K) (col : V → Fin K)
    (hcol : ∀ a ∈ P, ∀ b ∈ P, a ≠ b → col a = col b → Disjoint (W a) (W b))
    (fail : V → Finset Loc → Prop) (hfail : ∀ v F, fail v F → k ≤ (W v ∩ F).card) (n : ℕ) :
    prob μ (fun F => K * n ≤ (P.filter fun v => fail v F).card) ≤
      K * (P.card.choose n) * ((w.choose k : ℝ) * p ^ k) ^ n := by
  set cls : Fin K → Finset (Finset V) := fun c =>
    (powersetCard n P).filter fun U => ∀ v ∈ U, col v = c
  have hpt : ∀ F, (if K * n ≤ (P.filter fun v => fail v F).card then μ.P F else 0) ≤
      ∑ c, ∑ U ∈ cls c, (if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0) := by
    intro F
    have h0 := μ.nonneg F
    have hnn : ∀ c, 0 ≤ ∑ U ∈ cls c, (if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0) :=
      fun c => sum_nonneg fun U _ => by split_ifs <;> simp [h0]
    split_ifs with hF
    · obtain ⟨c, -, hc⟩ := exists_le_card_fiber_of_mul_le_card_of_maps_to
        (s := P.filter fun v => fail v F) (t := (univ : Finset (Fin K))) (f := col)
        (fun _ _ => mem_univ _) ⟨⟨0, hK⟩, mem_univ _⟩ (by rw [card_univ, Fintype.card_fin]; exact hF)
      obtain ⟨U, hUsub, hUcard⟩ := exists_subset_card_eq hc
      have hUcls : U ∈ cls c := by
        refine mem_filter.mpr ⟨mem_powersetCard.mpr ⟨fun v hv => ?_, hUcard⟩, fun v hv => ?_⟩
        · exact (mem_filter.mp (mem_filter.mp (hUsub hv)).1).1
        · exact (mem_filter.mp (hUsub hv)).2
      have hUf : ∀ v ∈ U, k ≤ (W v ∩ F).card := fun v hv =>
        hfail v F (mem_filter.mp (mem_filter.mp (hUsub hv)).1).2
      have h1 : μ.P F ≤ ∑ U ∈ cls c, (if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0) := by
        have := single_le_sum (f := fun U => if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0)
          (fun U _ => by split_ifs <;> simp [h0]) hUcls
        split_ifs at this
        exact this
      exact h1.trans (single_le_sum (fun c _ => hnn c) (mem_univ c))
    · exact sum_nonneg fun c _ => hnn c
  have hU : ∀ c, ∀ U ∈ cls c, prob μ (fun F => ∀ v ∈ U, k ≤ (W v ∩ F).card) ≤
      ((w.choose k : ℝ) * p ^ k) ^ n := by
    intro c U hUc
    obtain ⟨hUp, hUcol⟩ := mem_filter.mp hUc
    obtain ⟨hUP, hUn⟩ := mem_powersetCard.mp hUp
    have hd : ∀ a ∈ U, ∀ b ∈ U, a ≠ b → Disjoint (W a) (W b) := fun a ha b hb hab =>
      hcol a (hUP ha) b (hUP hb) hab ((hUcol a ha).trans (hUcol b hb).symm)
    calc prob μ (fun F => ∀ v ∈ U, k ≤ (W v ∩ F).card)
        ≤ (∏ v ∈ U, ((W v).card.choose k : ℝ)) * p ^ (k * U.card) :=
          disjoint_windows μ hμ W U hd k
      _ ≤ (w.choose k : ℝ) ^ U.card * p ^ (k * U.card) := by
          apply mul_le_mul_of_nonneg_right _ (pow_nonneg hp _)
          calc (∏ v ∈ U, ((W v).card.choose k : ℝ)) ≤ ∏ _v ∈ U, (w.choose k : ℝ) :=
                prod_le_prod₀ (fun v _ => by positivity)
                  (fun v _ => by exact_mod_cast Nat.choose_le_choose k (hw v))
            _ = (w.choose k : ℝ) ^ U.card := prod_const _
      _ = ((w.choose k : ℝ) * p ^ k) ^ n := by rw [hUn, mul_pow, ← pow_mul, mul_comm k n]
  calc prob μ (fun F => K * n ≤ (P.filter fun v => fail v F).card)
      ≤ ∑ F, ∑ c, ∑ U ∈ cls c, (if ∀ v ∈ U, k ≤ (W v ∩ F).card then μ.P F else 0) :=
        sum_le_sum fun F _ => hpt F
    _ = ∑ c, ∑ U ∈ cls c, prob μ (fun F => ∀ v ∈ U, k ≤ (W v ∩ F).card) := by
        rw [sum_comm]; refine sum_congr rfl fun c _ => ?_; rw [sum_comm]; rfl
    _ ≤ ∑ c : Fin K, ∑ _U ∈ cls c, ((w.choose k : ℝ) * p ^ k) ^ n :=
        sum_le_sum fun c _ => sum_le_sum fun U hUc => hU c U hUc
    _ ≤ ∑ _c : Fin K, (P.card.choose n : ℝ) * ((w.choose k : ℝ) * p ^ k) ^ n := by
        refine sum_le_sum fun c _ => ?_
        rw [sum_const, nsmul_eq_mul]
        apply mul_le_mul_of_nonneg_right _ (by positivity)
        have : (cls c).card ≤ P.card.choose n :=
          (card_filter_le _ _).trans (card_powersetCard n P).le
        exact_mod_cast this
    _ = K * (P.card.choose n) * ((w.choose k : ℝ) * p ^ k) ^ n := by
        rw [sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul, mul_assoc]

end Snuffy.SparseFailure
