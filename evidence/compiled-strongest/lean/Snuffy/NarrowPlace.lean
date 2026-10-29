import Mathlib

/-!
# Theorem NP, the splitting bound (compiled edition, Part VII.5 (h)–(k))

UPT-P v0.12.1, (h4) and (k1): total protection-first capacity `C` is split among
`n` independent keepers, keeper `i` delivering the fraction `B i ∈ [0,1]` of its
share `C / n`, with mean delivery at least `1 - ε`. Holding fails when the
delivered capacity falls below the threat-plus-headroom `H`. If
`C (1 - ε) > H`, i.e. `δ = 1 - ε - H / C > 0`, then

  `P(holding fails) ≤ exp (-2 n δ²)`,

so the probability that holding fails falls exponentially as the capacity is
split among more independent keepers (Hoeffding). This is the `r > 1` side of
the sharp threshold.
-/

namespace Snuffy.NarrowPlace

open MeasureTheory ProbabilityTheory Real

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]

theorem np_splitting_bound (B : ℕ → Ω → ℝ) (hB : iIndepFun B μ)
    (hmeas : ∀ i, Measurable (B i)) (hrange : ∀ i ω, B i ω ∈ Set.Icc (0 : ℝ) 1)
    (n : ℕ) (hn : 0 < n) (ε H C : ℝ) (hC : 0 < C)
    (hmean : ∀ i, 1 - ε ≤ μ[B i]) (hδ : 0 < 1 - ε - H / C) :
    μ.real {ω | C / n * ∑ i ∈ Finset.range n, B i ω < H} ≤
      exp (-2 * n * (1 - ε - H / C) ^ 2) := by
  set δ := 1 - ε - H / C with hδdef
  -- centred deficits
  set X : ℕ → Ω → ℝ := fun i ω => μ[B i] - B i ω with hX
  have hXind : iIndepFun X μ := by
    have h := hB.comp (fun i (x : ℝ) => (∫ ω, B i ω ∂μ) - x)
      (fun i => measurable_const.sub measurable_id)
    simpa [hX, Function.comp_def] using h
  have hsub : ∀ i, HasSubgaussianMGF (X i) ((‖(0 : ℝ) - -1‖₊ / 2) ^ 2) μ := by
    intro i
    have h := hasSubgaussianMGF_of_mem_Icc (μ := μ) (X := fun ω => -B i ω)
      (a := -1) (b := 0) ((hmeas i).neg.aemeasurable)
      (ae_of_all _ fun ω => ⟨by linarith [(hrange i ω).2], by linarith [(hrange i ω).1]⟩)
    have hint : μ[fun ω => -B i ω] = -μ[B i] := integral_neg _
    refine h.congr (ae_of_all _ fun ω => ?_)
    simp only [hX, hint]
    ring
  have hbound := HasSubgaussianMGF.measure_sum_range_ge_le_of_iIndepFun (μ := μ) hXind
    (c := (‖(0 : ℝ) - -1‖₊ / 2) ^ 2) (n := n) (fun i _ => hsub i)
    (ε := n * δ) (by positivity)
  have hc : (((‖(0 : ℝ) - -1‖₊ / 2) ^ 2 : NNReal) : ℝ) = 1 / 4 := by
    norm_num
  rw [hc] at hbound
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hexp : -(↑n * δ) ^ 2 / (2 * ↑n * (1 / 4)) = -2 * ↑n * δ ^ 2 := by
    field_simp
    ring
  rw [hexp] at hbound
  refine le_trans (measureReal_mono ?_) hbound
  intro ω hω
  simp only [Set.mem_ofPred_eq] at hω ⊢
  have hsum : ∑ i ∈ Finset.range n, X i ω =
      ∑ i ∈ Finset.range n, μ[B i] - ∑ i ∈ Finset.range n, B i ω := by
    simp only [hX, Finset.sum_sub_distrib]
  have hmeansum : (n : ℝ) * (1 - ε) ≤ ∑ i ∈ Finset.range n, μ[B i] := by
    have h := Finset.sum_le_sum (s := Finset.range n) (fun i _ => hmean i)
    rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at h
    exact h
  have hB' : ∑ i ∈ Finset.range n, B i ω < n * H / C := by
    have h1 : C / n * ∑ i ∈ Finset.range n, B i ω < H := hω
    rw [div_mul_eq_mul_div, div_lt_iff₀ hnR] at h1
    rw [lt_div_iff₀ hC]
    linarith
  have hHC : (n : ℝ) * H / C = n * (H / C) := by ring
  rw [hsum, hδdef]
  rw [hHC] at hB'
  nlinarith

end Snuffy.NarrowPlace
