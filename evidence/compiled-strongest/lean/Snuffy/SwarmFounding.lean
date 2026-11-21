import Snuffy.CorrelatedHolding

/-!
Part XIV.2: named pool-threshold wrappers and an unequal-capacity extension.

The correlated bound is derived from individual nonnegative, integrable
deficits and their expectation bounds. It assumes no independence, so shared
infrastructure failures and arbitrary joint correlations remain in scope.
The independent exponential form explicitly retains equal delivered shares.
These are capacity/risk results, not an installation or commissioning claim.
-/

namespace Snuffy.SwarmFounding

open MeasureTheory ProbabilityTheory Real Finset

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsProbabilityMeasure μ]

/-- The founding ratio is a comparison of the additive pool with the hazard. -/
theorem pool_ratio_gt_one_iff (C ε H : ℝ) (hH : 0 < H) :
    1 < C * (1 - ε) / H ↔ H < C * (1 - ε) := by
  rw [lt_div_iff₀ hH, one_mul]

/-- Arbitrary joint keeper law, unequal capacities, and individual expected
deficits: only the sums enter the holding threshold and the risk bound.
The delivery/deficit identity is explicit for every member and every world. -/
theorem pool_threshold {ι : Type*} [DecidableEq ι]
    (N : Finset ι) (capacity expectedDeficit : ι → ℝ)
    (delivery deficit : ι → Ω → ℝ) (H : ℝ)
    (hC : 0 < ∑ i ∈ N, capacity i)
    (hH : H < ∑ i ∈ N, capacity i)
    (hNonneg : ∀ i ∈ N, ∀ ω, 0 ≤ deficit i ω)
    (hIntegrable : ∀ i ∈ N, Integrable (deficit i) μ)
    (hMean : ∀ i ∈ N, (∫ ω, deficit i ω ∂μ) ≤ expectedDeficit i)
    (hSplit : ∀ i ∈ N, ∀ ω, delivery i ω + deficit i ω = capacity i) :
    μ.real {ω | (∑ i ∈ N, delivery i ω) < H} ≤
      (∑ i ∈ N, expectedDeficit i) / ((∑ i ∈ N, capacity i) - H) := by
  let C : ℝ := ∑ i ∈ N, capacity i
  let D : Ω → ℝ := fun ω => ∑ i ∈ N, deficit i ω
  have hCpos : 0 < C := hC
  have hHlt : H < C := hH
  have hDnonneg : ∀ ω, 0 ≤ D ω := by
    intro ω
    exact Finset.sum_nonneg (fun i hi => hNonneg i hi ω)
  have hDint : Integrable D μ := by
    exact integrable_finsetSum N hIntegrable
  have hDmean : (∫ ω, D ω ∂μ) ≤ ∑ i ∈ N, expectedDeficit i := by
    calc
      (∫ ω, D ω ∂μ) = ∑ i ∈ N, ∫ ω, deficit i ω ∂μ :=
        integral_finsetSum N hIntegrable
      _ ≤ ∑ i ∈ N, expectedDeficit i := Finset.sum_le_sum hMean
  have hDelta : 0 < 1 - H / C := by
    have h := (div_lt_one hCpos).2 hHlt
    linarith
  have hNormalizedMean :
      (∫ ω, D ω / C ∂μ) ≤ (∑ i ∈ N, expectedDeficit i) / C := by
    rw [integral_div]
    exact div_le_div_of_nonneg_right hDmean hCpos.le
  have hDelivered : ∀ ω, C * (1 - D ω / C) = ∑ i ∈ N, delivery i ω := by
    intro ω
    have hBalance : (∑ i ∈ N, delivery i ω) + D ω = C := by
      calc
        _ = ∑ i ∈ N, (delivery i ω + deficit i ω) :=
          (Finset.sum_add_distrib).symm
        _ = C := Finset.sum_congr rfl (fun i hi => hSplit i hi ω)
    have hCancel : C * (D ω / C) = D ω := by
      field_simp
    nlinarith
  have hBound := Snuffy.CorrelatedHolding.correlated_holding_bound
    (fun ω => D ω / C)
    (fun ω => div_nonneg (hDnonneg ω) hCpos.le)
    (hDint.div_const C)
    ((∑ i ∈ N, expectedDeficit i) / C) H C hCpos
    hNormalizedMean hDelta
  have hRate :
      ((∑ i ∈ N, expectedDeficit i) / C) / (1 - H / C) =
        (∑ i ∈ N, expectedDeficit i) / (C - H) := by
    have hCne : C ≠ 0 := ne_of_gt hCpos
    have hDiff : C - H ≠ 0 := ne_of_gt (sub_pos.mpr hHlt)
    field_simp
  rw [hRate] at hBound
  simpa only [hDelivered] using hBound

/-- The independent form has equal shares C/n and retains the precise
independence, measurability, range and positive-gap premises of Theorem NP. -/
theorem independent_pool_threshold
    (B : ℕ → Ω → ℝ) (hB : iIndepFun B μ)
    (hmeas : ∀ i, Measurable (B i))
    (hrange : ∀ i ω, B i ω ∈ Set.Icc 0 1)
    (n : ℕ) (hn : 0 < n) (ε H C : ℝ) (hC : 0 < C)
    (hmean : ∀ i, 1 - ε ≤ μ[B i]) (hgap : 0 < 1 - ε - H / C) :
    μ.real {ω | C / n * ∑ i ∈ Finset.range n, B i ω < H} ≤
      exp (-2 * n * (1 - ε - H / C) ^ 2) :=
  Snuffy.NarrowPlace.np_splitting_bound B hB hmeas hrange n hn ε H C hC hmean hgap

end Snuffy.SwarmFounding
