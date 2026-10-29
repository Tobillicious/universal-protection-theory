/-
Snuffy — Canon Edition v4.1: the threshold theorem for concatenated
distance-3 codes, end to end (§23.8; premise 7's ceiling; §22.3).

A level-`k` block of a code concatenated from a seven-qubit distance-3 code
(the Steane code) has `7^k` physical locations, addressed by paths
`Fin k → Fin 7`. A distance-3 code corrects any single faulty sub-block
(`distance3_corrects_one`, unique decoding with `t = 1`), so a level-`(k+1)`
block fails only if at least two of its seven level-`k` sub-blocks fail.

  * distance3_corrects_one — a nearest-codeword decoder of a code of distance
    at least 3 corrects any single error.
  * fails_witness — every level-`k` failure contains a fully faulty witness:
    `2^k` locations, two failing sub-blocks at each level.
  * card_witnesses — there are at most `21^{2^k − 1}` witnesses
    (`21 = C(7, 2)` pairs of sub-blocks at each of the `2^k − 1` branchings).
  * concatenated_threshold — under local stochastic noise of rate `p`, a
    level-`k` block fails with probability at most `(21p)^{2^k} / 21`: decay
    double-exponential in the level below the threshold `p < 1/21`.
  * concatenated_ceiling — below threshold every target ceiling `ε > 0`,
    `10⁻⁶` included, is met at some level and every higher one.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold
import Snuffy.Bridge
import Mathlib.Data.Fin.Tuple.Basic

open Finset

namespace Snuffy.Concatenated

open Snuffy.Threshold

/-! ## The decoder corrects one faulty sub-block -/

/-- **A distance-3 code corrects any single error.** -/
theorem distance3_corrects_one {X : Type*} [MetricSpace X] {Code : Set X}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → (3 : ℝ) ≤ dist c c') {dec : X → X}
    (hdecC : ∀ y, dec y ∈ Code) (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    {c y : X} (hc : c ∈ Code) (hy : dist y c ≤ 1) : dec y = c :=
  Snuffy.Bridge.nearest_decodes hsep (by norm_num) hdecC hnear hc hy

/-! ## Blocks, failure and witnesses -/

/-- Locations of a level-`k` block: paths of length `k` through the seven
sub-blocks. -/
abbrev Loc (k : ℕ) := Fin k → Fin 7

/-- The faults of sub-block `i` of a level-`(k+1)` block. -/
def sub {k : ℕ} (F : Finset (Loc (k + 1))) (i : Fin 7) : Finset (Loc k) :=
  univ.filter fun a => Fin.cons i a ∈ F

/-- Block failure: a level-0 location fails when it is faulty; a level-`(k+1)`
block fails when at least two of its seven sub-blocks fail (a distance-3 code
corrects one). -/
def Fails : (k : ℕ) → Finset (Loc k) → Prop
  | 0, F => F.Nonempty
  | k + 1, F => ∃ i j, i ≠ j ∧ Fails k (sub F i) ∧ Fails k (sub F j)

/-- Prefixing a path with sub-block `i`. -/
def consEmb (k : ℕ) (i : Fin 7) : Loc k ↪ Loc (k + 1) :=
  ⟨fun a => Fin.cons i a, fun _ _ h => Fin.cons_right_injective (α := fun _ : Fin (k + 1) => Fin 7) i h⟩

/-- Lift a set of level-`k` locations into sub-block `i`. -/
def lift {k : ℕ} (i : Fin 7) (w : Finset (Loc k)) : Finset (Loc (k + 1)) :=
  w.map (consEmb k i)

/-- Witnesses: the single location at level 0; at level `k+1`, a witness of two
distinct sub-blocks `i < j`. -/
def witnesses : (k : ℕ) → Finset (Finset (Loc k))
  | 0 => {univ}
  | k + 1 => (univ.filter fun ij : Fin 7 × Fin 7 => ij.1 < ij.2).biUnion fun ij =>
      (witnesses k ×ˢ witnesses k).image fun w => lift ij.1 w.1 ∪ lift ij.2 w.2

theorem lift_subset {k : ℕ} {F : Finset (Loc (k + 1))} {i : Fin 7} {w : Finset (Loc k)}
    (h : w ⊆ sub F i) : lift i w ⊆ F := by
  intro z hz
  simp only [lift, mem_map, consEmb] at hz
  obtain ⟨a, ha, rfl⟩ := hz
  have := h ha
  simp only [sub, mem_filter, mem_univ, true_and] at this
  exact this

/-- **Every failure contains a fully faulty witness.** -/
theorem fails_witness : ∀ (k : ℕ) (F : Finset (Loc k)), Fails k F → ∃ w ∈ witnesses k, w ⊆ F
  | 0, F, hF => by
    refine ⟨univ, mem_singleton_self _, ?_⟩
    obtain ⟨a, ha⟩ := hF
    intro b _
    rwa [Subsingleton.elim b a]
  | k + 1, F, ⟨i, j, hij, hi, hj⟩ => by
    obtain ⟨w₁, hw₁, hs₁⟩ := fails_witness k _ hi
    obtain ⟨w₂, hw₂, hs₂⟩ := fails_witness k _ hj
    rcases lt_or_gt_of_ne hij with h | h
    · refine ⟨lift i w₁ ∪ lift j w₂, ?_, union_subset (lift_subset hs₁) (lift_subset hs₂)⟩
      simp only [witnesses, mem_biUnion, mem_filter, mem_univ, true_and, mem_image, mem_product,
        Prod.exists]
      exact ⟨i, j, h, w₁, w₂, ⟨hw₁, hw₂⟩, rfl⟩
    · refine ⟨lift j w₂ ∪ lift i w₁, ?_, union_subset (lift_subset hs₂) (lift_subset hs₁)⟩
      simp only [witnesses, mem_biUnion, mem_filter, mem_univ, true_and, mem_image, mem_product,
        Prod.exists]
      exact ⟨j, i, h, w₂, w₁, ⟨hw₂, hw₁⟩, rfl⟩

theorem card_lift {k : ℕ} (i : Fin 7) (w : Finset (Loc k)) : (lift i w).card = w.card :=
  card_map _

theorem disjoint_lift {k : ℕ} {i j : Fin 7} (hij : i ≠ j) (w₁ w₂ : Finset (Loc k)) :
    Disjoint (lift i w₁) (lift j w₂) := by
  rw [disjoint_left]
  intro z hz₁ hz₂
  simp only [lift, mem_map, consEmb] at hz₁ hz₂
  obtain ⟨a, -, rfl⟩ := hz₁
  obtain ⟨b, -, hb⟩ := hz₂
  have h0 : (Fin.cons j b : Loc (k + 1)) 0 = (Fin.cons i a : Loc (k + 1)) 0 := congrFun hb 0
  rw [Fin.cons_zero, Fin.cons_zero] at h0
  exact hij h0.symm

/-- Every witness has exactly `2^k` locations. -/
theorem card_witness : ∀ (k : ℕ), ∀ w ∈ witnesses k, w.card = 2 ^ k
  | 0, w, hw => by
    rw [witnesses, mem_singleton] at hw
    subst hw
    simp
  | k + 1, w, hw => by
    simp only [witnesses, mem_biUnion, mem_filter, mem_univ, true_and, mem_image, mem_product,
      Prod.exists] at hw
    obtain ⟨i, j, hij, w₁, w₂, ⟨hw₁, hw₂⟩, rfl⟩ := hw
    rw [card_union_of_disjoint (disjoint_lift hij.ne _ _), card_lift, card_lift,
      card_witness k w₁ hw₁, card_witness k w₂ hw₂]
    ring

/-- **At most `21^{2^k − 1}` witnesses.** -/
theorem card_witnesses : ∀ k : ℕ, ((witnesses k).card : ℝ) ≤ 21 ^ (2 ^ k - 1)
  | 0 => by simp [witnesses]
  | k + 1 => by
    have hpairs : (univ.filter fun ij : Fin 7 × Fin 7 => ij.1 < ij.2).card = 21 := by decide
    have heq : witnesses (k + 1) = (univ.filter fun ij : Fin 7 × Fin 7 => ij.1 < ij.2).biUnion
        fun ij => (witnesses k ×ˢ witnesses k).image fun w => lift ij.1 w.1 ∪ lift ij.2 w.2 := rfl
    have h1 : (witnesses (k + 1)).card ≤ 21 * ((witnesses k).card * (witnesses k).card) := by
      rw [heq]
      calc _ ≤ ∑ ij ∈ univ.filter (fun ij : Fin 7 × Fin 7 => ij.1 < ij.2),
            ((witnesses k ×ˢ witnesses k).image fun w => lift ij.1 w.1 ∪ lift ij.2 w.2).card :=
            card_biUnion_le
        _ ≤ ∑ _ij ∈ univ.filter (fun ij : Fin 7 × Fin 7 => ij.1 < ij.2),
            (witnesses k).card * (witnesses k).card :=
            sum_le_sum fun ij _ => card_image_le.trans (card_product _ _).le
        _ = 21 * ((witnesses k).card * (witnesses k).card) := by rw [sum_const, hpairs, smul_eq_mul]
    have hk := card_witnesses k
    have h0 : (0 : ℝ) ≤ (witnesses k).card := Nat.cast_nonneg _
    have hexp : (2 : ℕ) ^ (k + 1) - 1 = 2 * (2 ^ k - 1) + 1 := by
      have : 1 ≤ 2 ^ k := Nat.one_le_two_pow
      rw [pow_succ]; omega
    calc ((witnesses (k + 1)).card : ℝ) ≤ 21 * ((witnesses k).card * (witnesses k).card) := by
          exact_mod_cast h1
      _ ≤ 21 * (21 ^ (2 ^ k - 1) * 21 ^ (2 ^ k - 1)) := by gcongr
      _ = 21 ^ (2 ^ (k + 1) - 1) := by rw [hexp]; ring

/-! ## The threshold theorem -/

/-- **The threshold theorem for concatenated distance-3 codes.** Under local
stochastic noise of rate `p ≥ 0`, a level-`k` block fails with probability at
most `(21p)^{2^k} / 21`. -/
theorem concatenated_threshold (k : ℕ) (μ : FaultLaw (Loc k)) {p : ℝ} (hp0 : 0 ≤ p)
    (hμ : LocalStochastic μ p) [DecidablePred (Fails k)] :
    prob μ (Fails k) ≤ (21 * p) ^ (2 ^ k) / 21 := by
  classical
  have hind : ∀ F, (if Fails k F then μ.P F else 0) ≤ ∑ w ∈ witnesses k, if w ⊆ F then μ.P F else 0 := by
    intro F
    split_ifs with hF
    · obtain ⟨w, hw, hsub⟩ := fails_witness k F hF
      have := single_le_sum (f := fun w => if w ⊆ F then μ.P F else 0)
        (fun w _ => by split_ifs <;> simp [μ.nonneg F]) hw
      simpa [hsub] using this
    · exact sum_nonneg fun w _ => by split_ifs <;> simp [μ.nonneg F]
  calc prob μ (Fails k) ≤ ∑ F, ∑ w ∈ witnesses k, if w ⊆ F then μ.P F else 0 :=
        sum_le_sum fun F _ => hind F
    _ = ∑ w ∈ witnesses k, prob μ (fun F => w ⊆ F) := by rw [sum_comm]; rfl
    _ ≤ ∑ w ∈ witnesses k, p ^ (2 ^ k) := by
        refine sum_le_sum fun w hw => ?_
        have := hμ w
        rwa [card_witness k w hw] at this
    _ = (witnesses k).card * p ^ (2 ^ k) := by rw [sum_const, nsmul_eq_mul]
    _ ≤ 21 ^ (2 ^ k - 1) * p ^ (2 ^ k) :=
        mul_le_mul_of_nonneg_right (card_witnesses k) (pow_nonneg hp0 _)
    _ = (21 * p) ^ (2 ^ k) / 21 := by
        obtain ⟨m, hm⟩ : ∃ m, 2 ^ k = m + 1 := ⟨2 ^ k - 1, by have := @Nat.one_le_two_pow k; omega⟩
        rw [hm, Nat.add_sub_cancel, mul_pow, pow_succ, pow_succ]
        field_simp

/-- **Every ceiling is met below threshold.** For a family of fault laws, each
local stochastic with the same rate `p < 1/21`, every target `ε > 0` is met at
some concatenation level and every higher one. -/
theorem concatenated_ceiling {p : ℝ} (hp0 : 0 ≤ p) (hp : p < 1 / 21)
    (μ : ∀ k, FaultLaw (Loc k)) (hμ : ∀ k, LocalStochastic (μ k) p)
    [∀ k, DecidablePred (Fails k)] {ε : ℝ} (hε : 0 < ε) :
    ∃ k₀, ∀ k ≥ k₀, prob (μ k) (Fails k) < ε := by
  have hq0 : 0 ≤ 21 * p := by linarith
  have hq1 : 21 * p < 1 := by linarith
  obtain ⟨n₀, hn₀⟩ := exists_pow_lt_of_lt_one hε hq1
  refine ⟨n₀, fun k hk => ?_⟩
  have hkpow : n₀ ≤ 2 ^ k := hk.trans (Nat.lt_two_pow_self).le
  calc prob (μ k) (Fails k) ≤ (21 * p) ^ (2 ^ k) / 21 := concatenated_threshold k (μ k) hp0 (hμ k)
    _ ≤ (21 * p) ^ (2 ^ k) := div_le_self (pow_nonneg hq0 _) (by norm_num)
    _ ≤ (21 * p) ^ n₀ := pow_le_pow_of_le_one hq0 hq1.le hkpow
    _ < ε := hn₀

end Snuffy.Concatenated
