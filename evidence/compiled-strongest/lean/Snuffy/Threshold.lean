/-
Snuffy — Canon Edition v4.1: the threshold theorem's counting core,
machine-checked (§23.8 premise; §22.3; premise 7's ceiling).

The noise model is local stochastic noise, the standard hypothesis of
fault-tolerance theory: a law on fault sets in which every set S of locations
is entirely faulty with probability at most p^|S|. Correlations are allowed
so long as they are bounded in this way.

  * many_faults — P(at least m of the locations T are faulty) ≤ C(|T|, m) p^m.
  * fail_le_witness — if every decoder failure leaves a witness set at least
    half of whose locations are faulty, then P(fail) ≤ Σ_w (2√p)^{|w|}.
  * fail_le_geometric — with at most V Δ^L witnesses of each length L ≥ d,
    P(fail) ≤ V r^d / (1 − r) with r = 2Δ√p < 1: geometric decay in the code
    distance below threshold.
  * repetition_threshold, repetition_ceiling — the repetition code under
    majority decoding, end to end: P(fail) ≤ (2√p)^{2t+1} ≤ (4p)^t, so below
    p = 1/4 every target ceiling is met at some size.
  * family_ceiling — for a code family with polynomially many witnesses per
    length, the charged kernel decays geometrically and every target
    ceiling ε > 0, 10⁻⁶ included, is met at some distance and every larger
    one (via `ReciprocityCeiling.ceiling_achievable`).

For the surface code, the witness hypothesis is the lemma of Dennis, Kitaev,
Landahl and Preskill (J. Math. Phys. 43, 4452, 2002): minimum-weight decoding
fails only along a self-avoiding chain of length at least d, at least half of
whose edges are faulty.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ReciprocityCeiling
import Mathlib.Algebra.Order.Field.GeomSum
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Nat.Choose.Bounds
import Mathlib.Topology.Order.LiminfLimsup

open Finset Filter Topology

namespace Snuffy.Threshold

/-! ## Local stochastic noise -/

section Noise

variable {Loc : Type*} [Fintype Loc] [DecidableEq Loc]

/-- A law on fault sets: a probability mass function on `Finset Loc`. -/
structure FaultLaw (Loc : Type*) [Fintype Loc] [DecidableEq Loc] where
  P : Finset Loc → ℝ
  nonneg : ∀ F, 0 ≤ P F
  sum_one : ∑ F, P F = 1

/-- Probability of an event of fault sets. -/
noncomputable def prob (μ : FaultLaw Loc) (A : Finset Loc → Prop) [DecidablePred A] : ℝ :=
  ∑ F, if A F then μ.P F else 0

/-- **Local stochastic noise** with rate `p`: every set of locations is
entirely faulty with probability at most `p^|S|`. -/
def LocalStochastic (μ : FaultLaw Loc) (p : ℝ) : Prop :=
  ∀ S : Finset Loc, prob μ (fun F => S ⊆ F) ≤ p ^ S.card

theorem prob_le_one (μ : FaultLaw Loc) (A : Finset Loc → Prop) [DecidablePred A] :
    prob μ A ≤ 1 := by
  rw [← μ.sum_one]
  exact sum_le_sum fun F _ => by split_ifs <;> simp [μ.nonneg F]

theorem prob_nonneg (μ : FaultLaw Loc) (A : Finset Loc → Prop) [DecidablePred A] :
    0 ≤ prob μ A :=
  sum_nonneg fun F _ => by split_ifs <;> simp [μ.nonneg F]

omit [Fintype Loc] in
theorem filter_subset_powersetCard (m : ℕ) (T F : Finset Loc) :
    (powersetCard m T).filter (· ⊆ F) = powersetCard m (T ∩ F) := by
  ext S
  simp only [mem_filter, mem_powersetCard, subset_inter_iff]
  tauto

/-- **Many faults.** `P(|T ∩ F| ≥ m) ≤ C(|T|, m) p^m`. -/
theorem many_faults (μ : FaultLaw Loc) {p : ℝ} (hμ : LocalStochastic μ p) (T : Finset Loc)
    (m : ℕ) : prob μ (fun F => m ≤ (T ∩ F).card) ≤ (T.card.choose m : ℝ) * p ^ m := by
  have hind : ∀ F, (if m ≤ (T ∩ F).card then μ.P F else 0)
      ≤ ∑ S ∈ powersetCard m T, if S ⊆ F then μ.P F else 0 := by
    intro F
    rw [← sum_filter, sum_const, filter_subset_powersetCard, card_powersetCard, nsmul_eq_mul]
    split_ifs with h
    · have : (1 : ℝ) ≤ ((T ∩ F).card.choose m : ℝ) := by exact_mod_cast Nat.choose_pos h
      nlinarith [μ.nonneg F]
    · exact mul_nonneg (Nat.cast_nonneg _) (μ.nonneg F)
  calc prob μ (fun F => m ≤ (T ∩ F).card)
      ≤ ∑ F, ∑ S ∈ powersetCard m T, if S ⊆ F then μ.P F else 0 := sum_le_sum fun F _ => hind F
    _ = ∑ S ∈ powersetCard m T, prob μ (fun F => S ⊆ F) := by rw [sum_comm]; rfl
    _ ≤ ∑ S ∈ powersetCard m T, p ^ m := by
        refine sum_le_sum fun S hS => ?_
        have := hμ S
        rwa [(mem_powersetCard.mp hS).2] at this
    _ = (T.card.choose m : ℝ) * p ^ m := by rw [sum_const, card_powersetCard, nsmul_eq_mul]

/-- **Witness bound.** If every failure leaves a witness `w ∈ W` with at least
half of its locations faulty, then `P(fail) ≤ Σ_w (2√p)^{|w|}`. -/
theorem fail_le_witness (μ : FaultLaw Loc) {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1)
    (hμ : LocalStochastic μ p) (W : Finset (Finset Loc)) (fail : Finset Loc → Prop)
    [DecidablePred fail] (hw : ∀ F, fail F → ∃ w ∈ W, w.card ≤ 2 * (w ∩ F).card) :
    prob μ fail ≤ ∑ w ∈ W, (2 * Real.sqrt p) ^ w.card := by
  have hs0 : 0 ≤ Real.sqrt p := Real.sqrt_nonneg p
  have hs1 : Real.sqrt p ≤ 1 := Real.sqrt_le_one.mpr hp1
  -- each witness contributes at most (2√p)^{|w|}
  have hterm : ∀ w : Finset Loc,
      prob μ (fun F => (w.card + 1) / 2 ≤ (w ∩ F).card) ≤ (2 * Real.sqrt p) ^ w.card := by
    intro w
    refine (many_faults μ hμ w _).trans ?_
    have hc : (w.card.choose ((w.card + 1) / 2) : ℝ) ≤ 2 ^ w.card := by
      exact_mod_cast Nat.choose_le_two_pow _ _
    have hpw : p ^ ((w.card + 1) / 2) ≤ Real.sqrt p ^ w.card := by
      have he : p ^ ((w.card + 1) / 2) = Real.sqrt p ^ (2 * ((w.card + 1) / 2)) := by
        rw [pow_mul, Real.sq_sqrt hp0]
      have hle : w.card ≤ 2 * ((w.card + 1) / 2) := by omega
      rw [he]
      exact pow_le_pow_of_le_one hs0 hs1 hle
    rw [mul_pow]
    exact mul_le_mul hc hpw (pow_nonneg hp0 _) (by positivity)
  -- union bound over witnesses
  have hind : ∀ F, (if fail F then μ.P F else 0)
      ≤ ∑ w ∈ W, if (w.card + 1) / 2 ≤ (w ∩ F).card then μ.P F else 0 := by
    intro F
    split_ifs with hf
    · obtain ⟨w, hwW, hw2⟩ := hw F hf
      have hcond : (w.card + 1) / 2 ≤ (w ∩ F).card := by omega
      have hle := single_le_sum
        (f := fun w => if (w.card + 1) / 2 ≤ (w ∩ F).card then μ.P F else 0)
        (fun w _ => by split_ifs <;> simp [μ.nonneg F]) hwW
      simp only [hcond, ↓reduceIte] at hle
      exact hle
    · exact sum_nonneg fun w _ => by split_ifs <;> simp [μ.nonneg F]
  calc prob μ fail ≤ ∑ F, ∑ w ∈ W, if (w.card + 1) / 2 ≤ (w ∩ F).card then μ.P F else 0 :=
        sum_le_sum fun F _ => hind F
    _ = ∑ w ∈ W, prob μ (fun F => (w.card + 1) / 2 ≤ (w ∩ F).card) := by rw [sum_comm]; rfl
    _ ≤ ∑ w ∈ W, (2 * Real.sqrt p) ^ w.card := sum_le_sum fun w _ => hterm w

/-- **Geometric decay below threshold.** If every witness has length at least
`d` and there are at most `V Δ^L` witnesses of each length `L`, then with
`r = 2Δ√p < 1`, `P(fail) ≤ V r^d / (1 − r)`. -/
theorem fail_le_geometric (μ : FaultLaw Loc) {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1)
    (hμ : LocalStochastic μ p) (W : Finset (Finset Loc)) (fail : Finset Loc → Prop)
    [DecidablePred fail] (hw : ∀ F, fail F → ∃ w ∈ W, w.card ≤ 2 * (w ∩ F).card)
    {d : ℕ} (hlen : ∀ w ∈ W, d ≤ w.card) {V Δ : ℝ} (hV : 0 ≤ V) (hΔ : 0 ≤ Δ)
    (hcount : ∀ L, ((W.filter fun w => w.card = L).card : ℝ) ≤ V * Δ ^ L)
    (hr : 2 * Δ * Real.sqrt p < 1) :
    prob μ fail ≤ V * (2 * Δ * Real.sqrt p) ^ d / (1 - 2 * Δ * Real.sqrt p) := by
  set r := 2 * Δ * Real.sqrt p with hrdef
  have hr0 : 0 ≤ r := by positivity
  set N := Fintype.card Loc
  have hmaps : ∀ w ∈ W, w.card ∈ Ico d (N + 1) := fun w hw =>
    mem_Ico.mpr ⟨hlen w hw, Nat.lt_succ_of_le (card_le_univ w)⟩
  refine (fail_le_witness μ hp0 hp1 hμ W fail hw).trans ?_
  rw [← sum_fiberwise_of_maps_to' hmaps (fun L => (2 * Real.sqrt p) ^ L)]
  calc ∑ L ∈ Ico d (N + 1), ∑ w ∈ W with w.card = L, (2 * Real.sqrt p) ^ L
      = ∑ L ∈ Ico d (N + 1), ((W.filter fun w => w.card = L).card : ℝ) * (2 * Real.sqrt p) ^ L := by
        simp only [sum_const, nsmul_eq_mul]
    _ ≤ ∑ L ∈ Ico d (N + 1), V * r ^ L := by
        refine sum_le_sum fun L _ => ?_
        calc ((W.filter fun w => w.card = L).card : ℝ) * (2 * Real.sqrt p) ^ L
            ≤ V * Δ ^ L * (2 * Real.sqrt p) ^ L :=
              mul_le_mul_of_nonneg_right (hcount L) (by positivity)
          _ = V * r ^ L := by rw [hrdef, mul_assoc, ← mul_pow]; ring
    _ = V * ∑ L ∈ Ico d (N + 1), r ^ L := by rw [mul_sum]
    _ ≤ V * (r ^ d / (1 - r)) := mul_le_mul_of_nonneg_left (geom_sum_Ico_le_of_lt_one hr0 hr) hV
    _ = V * r ^ d / (1 - r) := by ring

end Noise

/-! ## The repetition code, end to end -/

/-- Majority decoding of `2t + 1` copies fails exactly when more than `t`
copies are faulty. -/
def MajorityFails (t : ℕ) (F : Finset (Fin (2 * t + 1))) : Prop := t + 1 ≤ F.card

instance (t : ℕ) : DecidablePred (MajorityFails t) := fun F => by
  unfold MajorityFails; infer_instance

/-- **Repetition-code threshold.** Under local stochastic noise of rate `p ≤ 1`,
majority decoding of `2t + 1` copies fails with probability at most
`(2√p)^{2t+1}`. -/
theorem repetition_threshold (t : ℕ) (μ : FaultLaw (Fin (2 * t + 1))) {p : ℝ} (hp0 : 0 ≤ p)
    (hp1 : p ≤ 1) (hμ : LocalStochastic μ p) :
    prob μ (MajorityFails t) ≤ (2 * Real.sqrt p) ^ (2 * t + 1) := by
  have h := fail_le_witness μ hp0 hp1 hμ {univ} (MajorityFails t) (fun F hF => by
    refine ⟨univ, mem_singleton_self _, ?_⟩
    rw [univ_inter, card_univ, Fintype.card_fin]
    unfold MajorityFails at hF
    omega)
  simpa [card_univ, Fintype.card_fin] using h

/-- `(2√p)^{2t+1} ≤ (4p)^t` when `4p ≤ 1`. -/
theorem two_sqrt_pow_le {p : ℝ} (hp0 : 0 ≤ p) (hp : 4 * p ≤ 1) (t : ℕ) :
    (2 * Real.sqrt p) ^ (2 * t + 1) ≤ (4 * p) ^ t := by
  have hs : 2 * Real.sqrt p ≤ 1 := by
    have : Real.sqrt (4 * p) ≤ 1 := Real.sqrt_le_one.mpr hp
    rwa [Real.sqrt_mul (by norm_num), show Real.sqrt 4 = 2 by
      rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]] at this
  have h4 : (2 * Real.sqrt p) ^ 2 = 4 * p := by rw [mul_pow, Real.sq_sqrt hp0]; norm_num
  rw [pow_succ, pow_mul, h4]
  exact mul_le_of_le_one_right (pow_nonneg (by positivity) _) hs

/-- **The repetition code meets every ceiling below `p = 1/4`.** For a family
of fault laws, each local stochastic with the same rate `p < 1/4`, the
failure probability is at most `(4p)^t`, and every target `ε > 0` is met at
some size and every larger one. -/
theorem repetition_ceiling {p : ℝ} (hp0 : 0 ≤ p) (hp : p < 1 / 4)
    (μ : ∀ t : ℕ, FaultLaw (Fin (2 * t + 1))) (hμ : ∀ t, LocalStochastic (μ t) p)
    {ε : ℝ} (hε : 0 < ε) : ∃ t₀, ∀ t ≥ t₀, prob (μ t) (MajorityFails t) < ε := by
  have h4 : 4 * p ≤ 1 := by linarith
  obtain ⟨t₀, ht₀⟩ := Snuffy.ReciprocityCeiling.ceiling_achievable ({()} : Finset Unit)
    (fun _ t => prob (μ t) (MajorityFails t)) (fun _ => 1) (r := 4 * p) (by positivity)
    (by linarith)
    (fun _ _ => zero_le_one) (fun _ _ t => by
      rw [one_mul]
      exact (repetition_threshold t (μ t) hp0 (by linarith) (hμ t)).trans
        (two_sqrt_pow_le hp0 h4 t)) hε
  exact ⟨t₀, fun t ht => by simpa using ht₀ t ht⟩

/-! ## Code families with polynomially many witnesses -/

/-- Polynomial times geometric is dominated by a slower geometric. -/
theorem poly_geom_le {k : ℕ} {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    ∃ B, 0 ≤ B ∧ ∀ d : ℕ, (d : ℝ) ^ k * r ^ d ≤ B * ((1 + r) / 2) ^ d := by
  set s := (1 + r) / 2 with hs
  have hs0 : 0 < s := by rw [hs]; linarith
  have hq0 : 0 ≤ r / s := div_nonneg hr0 hs0.le
  have hq1 : r / s < 1 := by rw [div_lt_one hs0, hs]; linarith
  have ht := tendsto_pow_const_mul_const_pow_of_abs_lt_one k (by rwa [abs_of_nonneg hq0])
  obtain ⟨B, hB⟩ := ht.bddAbove_range
  refine ⟨max B 0, le_max_right _ _, fun d => ?_⟩
  have hd : (d : ℝ) ^ k * (r / s) ^ d ≤ max B 0 := (hB ⟨d, rfl⟩).trans (le_max_left _ _)
  calc (d : ℝ) ^ k * r ^ d = (d : ℝ) ^ k * (r / s) ^ d * s ^ d := by
        rw [div_pow, mul_assoc, div_mul_cancel₀ _ (pow_ne_zero _ hs0.ne')]
    _ ≤ max B 0 * s ^ d := mul_le_mul_of_nonneg_right hd (pow_nonneg hs0.le _)

/-- **Threshold theorem for code families.** A family of codes indexed by
distance `d`, with locations `Loc d`, local stochastic noise of rate `p`, and
decoder failures witnessed by sets of length at least `d`, at most
`C d^k Δ^L` of each length `L`, has charged kernel
`δ(d) ≤ A ((1 + r)/2)^d` with `r = 2Δ√p < 1`. Every target ceiling `ε > 0`,
10⁻⁶ included, is met at some distance and every larger one. -/
theorem family_ceiling {Loc : ℕ → Type*} [∀ d, Fintype (Loc d)] [∀ d, DecidableEq (Loc d)]
    (μ : ∀ d, FaultLaw (Loc d)) {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1)
    (hμ : ∀ d, LocalStochastic (μ d) p) (W : ∀ d, Finset (Finset (Loc d)))
    (fail : ∀ d, Finset (Loc d) → Prop) [∀ d, DecidablePred (fail d)]
    (hw : ∀ d F, fail d F → ∃ w ∈ W d, w.card ≤ 2 * (w ∩ F).card)
    (hlen : ∀ d, ∀ w ∈ W d, d ≤ w.card) {C Δ : ℝ} {k : ℕ} (hC : 0 ≤ C) (hΔ : 0 ≤ Δ)
    (hcount : ∀ d L, (((W d).filter fun w => w.card = L).card : ℝ) ≤ C * (d : ℝ) ^ k * Δ ^ L)
    (hr : 2 * Δ * Real.sqrt p < 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ d₀, ∀ d ≥ d₀, prob (μ d) (fail d) < ε := by
  set r := 2 * Δ * Real.sqrt p with hrdef
  have hr0 : 0 ≤ r := by positivity
  obtain ⟨B, hB0, hB⟩ := poly_geom_le (k := k) hr0 hr
  have h1r : 0 < 1 - r := by linarith
  set A := C * B / (1 - r)
  have hA : 0 ≤ A := div_nonneg (mul_nonneg hC hB0) h1r.le
  have hδ : ∀ d, prob (μ d) (fail d) ≤ A * ((1 + r) / 2) ^ d := by
    intro d
    have hV : 0 ≤ C * (d : ℝ) ^ k := mul_nonneg hC (pow_nonneg (Nat.cast_nonneg _) _)
    refine (fail_le_geometric (μ d) hp0 hp1 (hμ d) (W d) (fail d) (hw d) (hlen d) hV hΔ
      (hcount d) hr).trans ?_
    calc C * (d : ℝ) ^ k * r ^ d / (1 - r) = C * ((d : ℝ) ^ k * r ^ d) / (1 - r) := by ring
      _ ≤ C * (B * ((1 + r) / 2) ^ d) / (1 - r) :=
          div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left (hB d) hC) h1r.le
      _ = A * ((1 + r) / 2) ^ d := by ring
  obtain ⟨d₀, hd₀⟩ := Snuffy.ReciprocityCeiling.ceiling_achievable ({()} : Finset Unit)
    (fun _ d => prob (μ d) (fail d)) (fun _ => A) (r := (1 + r) / 2) (by positivity)
    (by linarith)
    (fun _ _ => hA) (fun _ _ d => hδ d) hε
  exact ⟨d₀, fun d hd => by simpa using hd₀ d hd⟩

end Snuffy.Threshold
