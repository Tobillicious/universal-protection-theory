/-
Snuffy — Canon Edition 4.2 working: the correlated-burst accounts attain the
ceiling (§22.3, accounts 5–7; bridge 6 joined to the threshold theorem).

Faults are produced by shocks with bounded footprint: shock `σ` damages the
locations `cover σ`, at most `k` of them, and each location is touched by at
most `m` shocks. The fired shocks are local stochastic at rate `q`
(`Threshold.LocalStochastic`; common causes included, no independence). The
damaged locations then form a location-level local stochastic law at the
effective rate

  p = (e·m·k·q)^(1/k),

whenever `e·m·k·q ≤ 1`. The threshold theorem therefore applies to correlated
bursts as it does to independent faults: every target ceiling, 10⁻⁶ included,
is met at some code distance and every larger one.

  * ceil_touching, correlated_stress_ceil — damaging all of `S` needs at
    least `⌈|S|/k⌉` fired shocks touching `S` (the ceiling, not the floor, so
    sets smaller than one footprint are still suppressed).
  * damageLaw, prob_damage — the law of damaged locations, pushed forward from
    the shock law.
  * near_card_le, choose_pow_le — `|N(S)| ≤ m|S|` and
    `C(n,t) q^t ≤ (e·m·k·q)^t` for `n ≤ m·k·t`.
  * damage_local_stochastic — the damaged locations are local stochastic at
    rate `(e·m·k·q)^(1/k)`.
  * correlated_family_ceiling — joined to `Threshold.family_ceiling`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.CorrelatedStress
import Mathlib.Data.Nat.Choose.Bounds
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Exponential

open Finset

namespace Snuffy.CorrelatedCeiling

open Snuffy.Threshold Snuffy.CorrelatedStress

variable {Loc Shock : Type*} [Fintype Loc] [DecidableEq Loc] [Fintype Shock] [DecidableEq Shock]

omit [Fintype Loc] [DecidableEq Shock] in
/-- If the fired shocks damage all of `S`, they contain `⌈|S|/k⌉` shocks
touching `S`. -/
lemma ceil_touching (cover : Shock → Finset Loc) {k : ℕ} (hk0 : 0 < k)
    (hk : ∀ σ, (cover σ).card ≤ k) {S : Finset Loc} {G : Finset Shock}
    (hS : S ⊆ G.biUnion cover) :
    ∃ T ∈ powersetCard ((S.card + k - 1) / k) (near cover S), T ⊆ G := by
  set T₀ := G.filter fun σ => (cover σ ∩ S).Nonempty
  have hcov : S ⊆ T₀.biUnion fun σ => cover σ ∩ S := by
    intro x hx
    obtain ⟨σ, hσ, hxσ⟩ := mem_biUnion.mp (hS hx)
    exact mem_biUnion.mpr ⟨σ, mem_filter.mpr ⟨hσ, ⟨x, mem_inter.mpr ⟨hxσ, hx⟩⟩⟩,
      mem_inter.mpr ⟨hxσ, hx⟩⟩
  have hcard : S.card ≤ k * T₀.card := by
    calc S.card ≤ (T₀.biUnion fun σ => cover σ ∩ S).card := card_le_card hcov
      _ ≤ ∑ σ ∈ T₀, (cover σ ∩ S).card := card_biUnion_le
      _ ≤ ∑ _σ ∈ T₀, k := sum_le_sum fun σ _ => (card_le_card inter_subset_left).trans (hk σ)
      _ = k * T₀.card := by rw [sum_const, smul_eq_mul, mul_comm]
  have hceil : (S.card + k - 1) / k ≤ T₀.card := by
    have h : (S.card + k - 1) / k < T₀.card + 1 := by
      rw [Nat.div_lt_iff_lt_mul hk0]
      have : (T₀.card + 1) * k = k * T₀.card + k := by ring
      omega
    omega
  obtain ⟨T, hT, hTc⟩ := exists_subset_card_eq hceil
  refine ⟨T, mem_powersetCard.mpr ⟨fun σ hσ => ?_, hTc⟩, fun σ hσ => (mem_filter.mp (hT hσ)).1⟩
  exact mem_filter.mpr ⟨mem_univ _, (mem_filter.mp (hT hσ)).2⟩

omit [Fintype Loc] in
/-- **Correlated stress, ceiling form.** -/
theorem correlated_stress_ceil (ν : FaultLaw Shock) {q : ℝ} (hν : LocalStochastic ν q)
    (cover : Shock → Finset Loc) {k : ℕ} (hk0 : 0 < k) (hk : ∀ σ, (cover σ).card ≤ k)
    (S : Finset Loc) :
    prob ν (fun G => S ⊆ G.biUnion cover) ≤
      ((near cover S).card.choose ((S.card + k - 1) / k) : ℝ) * q ^ ((S.card + k - 1) / k) := by
  set t := (S.card + k - 1) / k
  set N := near cover S
  have hind : ∀ G, (if S ⊆ G.biUnion cover then ν.P G else 0)
      ≤ ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 := by
    intro G
    split_ifs with h
    · obtain ⟨T, hT, hTG⟩ := ceil_touching cover hk0 hk h
      calc ν.P G = if T ⊆ G then ν.P G else 0 := by simp [hTG]
        _ ≤ ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 :=
          single_le_sum (f := fun T => if T ⊆ G then ν.P G else 0)
            (fun T _ => by split_ifs <;> simp [ν.nonneg G]) hT
    · exact sum_nonneg fun T _ => by split_ifs <;> simp [ν.nonneg G]
  calc prob ν (fun G => S ⊆ G.biUnion cover)
      ≤ ∑ G, ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 := sum_le_sum fun G _ => hind G
    _ = ∑ T ∈ powersetCard t N, prob ν (fun G => T ⊆ G) := by rw [sum_comm]; rfl
    _ ≤ ∑ T ∈ powersetCard t N, q ^ t := by
        refine sum_le_sum fun T hT => ?_
        have := hν T
        rwa [(mem_powersetCard.mp hT).2] at this
    _ = (N.card.choose t : ℝ) * q ^ t := by rw [sum_const, card_powersetCard, nsmul_eq_mul]

/-- The law of the damaged locations, pushed forward from the shock law. -/
noncomputable def damageLaw (ν : FaultLaw Shock) (cover : Shock → Finset Loc) : FaultLaw Loc where
  P F := ∑ G, if G.biUnion cover = F then ν.P G else 0
  nonneg F := sum_nonneg fun G _ => by split_ifs <;> simp [ν.nonneg G]
  sum_one := by
    rw [sum_comm]
    simp [ν.sum_one]

theorem prob_damage (ν : FaultLaw Shock) (cover : Shock → Finset Loc) (S : Finset Loc) :
    prob (damageLaw ν cover) (fun F => S ⊆ F) = prob ν (fun G => S ⊆ G.biUnion cover) := by
  simp only [prob, damageLaw]
  calc (∑ F, if S ⊆ F then ∑ G, (if G.biUnion cover = F then ν.P G else 0) else 0)
      = ∑ F, ∑ G, if G.biUnion cover = F then (if S ⊆ F then ν.P G else 0) else 0 := by
        refine sum_congr rfl fun F _ => ?_
        by_cases h : S ⊆ F <;> simp [h]
    _ = ∑ G, ∑ F, if G.biUnion cover = F then (if S ⊆ F then ν.P G else 0) else 0 := sum_comm
    _ = ∑ G, if S ⊆ G.biUnion cover then ν.P G else 0 := by
        refine sum_congr rfl fun G _ => ?_
        simp

omit [Fintype Loc] in
/-- At most `m` shocks touch each location, so at most `m|S|` touch `S`. -/
lemma near_card_le (cover : Shock → Finset Loc) {m : ℕ}
    (hm : ∀ x, (univ.filter fun σ => x ∈ cover σ).card ≤ m) (S : Finset Loc) :
    (near cover S).card ≤ m * S.card := by
  have hsub : near cover S ⊆ S.biUnion fun x => univ.filter fun σ => x ∈ cover σ := by
    intro σ hσ
    obtain ⟨x, hx⟩ := (mem_filter.mp hσ).2
    exact mem_biUnion.mpr ⟨x, (mem_inter.mp hx).2, mem_filter.mpr ⟨mem_univ _, (mem_inter.mp hx).1⟩⟩
  calc (near cover S).card ≤ _ := card_le_card hsub
    _ ≤ ∑ x ∈ S, (univ.filter fun σ => x ∈ cover σ).card := card_biUnion_le
    _ ≤ ∑ _x ∈ S, m := sum_le_sum fun x _ => hm x
    _ = m * S.card := by rw [sum_const, smul_eq_mul, mul_comm]

/-- `C(n,t) q^t ≤ (e·m·k·q)^t` whenever `n ≤ m·k·t`. -/
lemma choose_pow_le {n t m k : ℕ} {q : ℝ} (hq : 0 ≤ q) (hn : n ≤ m * k * t) :
    (n.choose t : ℝ) * q ^ t ≤ (Real.exp 1 * m * k * q) ^ t := by
  have h1 : (n.choose t : ℝ) ≤ (n : ℝ) ^ t / t.factorial := Nat.choose_le_pow_div t n
  have hfac : (0 : ℝ) < t.factorial := by exact_mod_cast t.factorial_pos
  have h2 : (n : ℝ) ^ t ≤ ((m * k : ℕ) : ℝ) ^ t * (t : ℝ) ^ t := by
    rw [← mul_pow]
    exact pow_le_pow_left₀ (Nat.cast_nonneg _) (by exact_mod_cast hn) t
  have h3 : (t : ℝ) ^ t / t.factorial ≤ Real.exp t := Real.pow_div_factorial_le_exp (t : ℝ) (Nat.cast_nonneg t) t
  have hexp : Real.exp (t : ℝ) = Real.exp 1 ^ t := by
    rw [← Real.exp_nat_mul, mul_one]
  have hmk : (0 : ℝ) ≤ ((m * k : ℕ) : ℝ) ^ t := by positivity
  calc (n.choose t : ℝ) * q ^ t ≤ (n : ℝ) ^ t / t.factorial * q ^ t :=
        mul_le_mul_of_nonneg_right h1 (pow_nonneg hq t)
    _ ≤ ((m * k : ℕ) : ℝ) ^ t * (t : ℝ) ^ t / t.factorial * q ^ t := by
        gcongr
    _ = ((m * k : ℕ) : ℝ) ^ t * ((t : ℝ) ^ t / t.factorial) * q ^ t := by ring
    _ ≤ ((m * k : ℕ) : ℝ) ^ t * Real.exp 1 ^ t * q ^ t := by
        rw [← hexp]; gcongr
    _ = (Real.exp 1 * m * k * q) ^ t := by push_cast; ring

/-- **The damaged locations are local stochastic** at the effective rate
`(e·m·k·q)^(1/k)`, for bounded-footprint shocks at rate `q`. -/
theorem damage_local_stochastic (ν : FaultLaw Shock) {q : ℝ} (hq : 0 ≤ q)
    (hν : LocalStochastic ν q) (cover : Shock → Finset Loc) {k m : ℕ} (hk0 : 0 < k)
    (hk : ∀ σ, (cover σ).card ≤ k) (hm : ∀ x, (univ.filter fun σ => x ∈ cover σ).card ≤ m)
    (hsmall : Real.exp 1 * m * k * q ≤ 1) :
    LocalStochastic (damageLaw ν cover) ((Real.exp 1 * m * k * q) ^ ((1 : ℝ) / k)) := by
  intro S
  set b := Real.exp 1 * m * k * q with hb
  have hb0 : 0 ≤ b := by positivity
  set t := (S.card + k - 1) / k
  have hst : S.card ≤ k * t := by
    have := Nat.lt_mul_div_succ (S.card + k - 1) hk0
    have h2 : k * ((S.card + k - 1) / k + 1) = k * t + k := by ring
    omega
  have hn : (near cover S).card ≤ m * k * t := by
    calc (near cover S).card ≤ m * S.card := near_card_le cover hm S
      _ ≤ m * (k * t) := Nat.mul_le_mul_left m hst
      _ = m * k * t := by ring
  rw [prob_damage]
  calc prob ν (fun G => S ⊆ G.biUnion cover)
      ≤ ((near cover S).card.choose t : ℝ) * q ^ t := correlated_stress_ceil ν hν cover hk0 hk S
    _ ≤ b ^ t := choose_pow_le hq hn
    _ = b ^ (t : ℝ) := (Real.rpow_natCast b t).symm
    _ ≤ b ^ ((S.card : ℝ) / k) := by
        apply Real.rpow_le_rpow_of_exponent_ge' hb0 hsmall (by positivity)
        rw [div_le_iff₀ (by exact_mod_cast hk0)]
        exact_mod_cast (by linarith [hst] : S.card ≤ t * k)
    _ = (b ^ ((1 : ℝ) / k)) ^ S.card := by
        rw [← Real.rpow_natCast, ← Real.rpow_mul hb0]
        congr 1
        ring

/-- **Correlated bursts attain the ceiling.** For a code family whose damage
comes from bounded-footprint shocks local stochastic at rate `q`, with the
effective rate below the threshold condition of `Threshold.family_ceiling`,
every target ceiling is met at some code distance and every larger one. -/
theorem correlated_family_ceiling {Loc Shock : ℕ → Type*} [∀ d, Fintype (Loc d)]
    [∀ d, DecidableEq (Loc d)] [∀ d, Fintype (Shock d)] [∀ d, DecidableEq (Shock d)]
    (ν : ∀ d, FaultLaw (Shock d)) {q : ℝ} (hq : 0 ≤ q) (hν : ∀ d, LocalStochastic (ν d) q)
    (cover : ∀ d, Shock d → Finset (Loc d)) {k m : ℕ} (hk0 : 0 < k)
    (hk : ∀ d σ, (cover d σ).card ≤ k)
    (hm : ∀ d x, (univ.filter fun σ => x ∈ cover d σ).card ≤ m)
    (hsmall : Real.exp 1 * m * k * q ≤ 1)
    (W : ∀ d, Finset (Finset (Loc d))) (fail : ∀ d, Finset (Loc d) → Prop)
    [∀ d, DecidablePred (fail d)]
    (hw : ∀ d F, fail d F → ∃ w ∈ W d, w.card ≤ 2 * (w ∩ F).card)
    (hlen : ∀ d, ∀ w ∈ W d, d ≤ w.card) {C Δ : ℝ} {j : ℕ} (hC : 0 ≤ C) (hΔ : 0 ≤ Δ)
    (hcount : ∀ d L, (((W d).filter fun w => w.card = L).card : ℝ) ≤ C * (d : ℝ) ^ j * Δ ^ L)
    (hr : 2 * Δ * Real.sqrt ((Real.exp 1 * m * k * q) ^ ((1 : ℝ) / k)) < 1)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ d₀, ∀ d ≥ d₀, prob (damageLaw (ν d) (cover d)) (fail d) < ε := by
  have hb0 : 0 ≤ Real.exp 1 * m * k * q := by positivity
  exact family_ceiling (fun d => damageLaw (ν d) (cover d)) (Real.rpow_nonneg hb0 _)
    (Real.rpow_le_one hb0 hsmall (by positivity))
    (fun d => damage_local_stochastic (ν d) hq (hν d) (cover d) hk0 (hk d) (hm d) hsmall)
    W fail hw hlen hC hΔ hcount hr hε

end Snuffy.CorrelatedCeiling
