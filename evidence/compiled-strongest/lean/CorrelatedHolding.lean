import Snuffy.NarrowPlace

/-!
# Holding with a random threat and correlated keepers (finding 16)

`NarrowPlace.np_splitting_bound` takes a fixed threat-plus-headroom `H` and independent
keepers. Neither assumption is needed for a guarantee:

* `random_threat_bound` — let the threat `H(ω)` be random and correlated with the
  deliveries in any way. Holding fails only if the threat exceeds its cap `Hmax` (a
  charged account, `ηH`) or the delivered capacity falls below `Hmax` (`ηD`). So the
  failure probability is at most `ηH + ηD`, with no independence between threat and
  deliveries;
* `correlated_holding_bound` — let the average undelivered fraction `D ∈ [0, ∞)` have
  mean at most `ε`, under any joint law of the keepers (common-mode failures
  included). Then delivered capacity `C (1 - D)` falls below `H` with probability at
  most `ε / (1 - H / C)` (Markov), whenever `H < C`;
* `random_threat_independent` — with independent keepers, the random-threat failure is
  at most `ηH + exp(-2 n (1 - ε - Hmax / C)²)`;
* `random_threat_correlated` — with correlated keepers, at most
  `ηH + ε / (1 - Hmax / C)`.
-/

namespace Snuffy.CorrelatedHolding

open MeasureTheory ProbabilityTheory Real

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]

theorem random_threat_bound (cap Hrand : Ω → ℝ) (Hmax ηH ηD : ℝ)
    (hT : μ.real {ω | Hmax < Hrand ω} ≤ ηH) (hD : μ.real {ω | cap ω < Hmax} ≤ ηD) :
    μ.real {ω | cap ω < Hrand ω} ≤ ηH + ηD := by
  have hsub : {ω | cap ω < Hrand ω} ⊆ {ω | Hmax < Hrand ω} ∪ {ω | cap ω < Hmax} := by
    intro ω hω
    simp only [Set.mem_ofPred_eq, Set.mem_union] at *
    rcases le_or_gt (Hrand ω) Hmax with h | h
    · exact Or.inr (lt_of_lt_of_le hω h)
    · exact Or.inl h
  calc μ.real {ω | cap ω < Hrand ω}
      ≤ μ.real ({ω | Hmax < Hrand ω} ∪ {ω | cap ω < Hmax}) := measureReal_mono hsub
    _ ≤ μ.real {ω | Hmax < Hrand ω} + μ.real {ω | cap ω < Hmax} := measureReal_union_le _ _
    _ ≤ ηH + ηD := add_le_add hT hD

theorem correlated_holding_bound (D : Ω → ℝ) (hD0 : ∀ ω, 0 ≤ D ω) (hDi : Integrable D μ)
    (ε H C : ℝ) (hC : 0 < C) (hmean : ∫ ω, D ω ∂μ ≤ ε) (hh : 0 < 1 - H / C) :
    μ.real {ω | C * (1 - D ω) < H} ≤ ε / (1 - H / C) := by
  have hsub : {ω | C * (1 - D ω) < H} ⊆ {ω | 1 - H / C ≤ D ω} := by
    intro ω hω
    simp only [Set.mem_ofPred_eq] at *
    have : 1 - D ω < H / C := by
      rw [lt_div_iff₀ hC]; linarith [mul_comm C (1 - D ω)]
    linarith
  have hm := mul_meas_ge_le_integral_of_nonneg (μ := μ)
    (Filter.Eventually.of_forall fun ω => hD0 ω) hDi (1 - H / C)
  rw [le_div_iff₀ hh]
  calc μ.real {ω | C * (1 - D ω) < H} * (1 - H / C)
      ≤ μ.real {ω | 1 - H / C ≤ D ω} * (1 - H / C) := 
        mul_le_mul_of_nonneg_right (measureReal_mono hsub (measure_ne_top _ _)) hh.le
    _ = (1 - H / C) * μ.real {ω | 1 - H / C ≤ D ω} := mul_comm _ _
    _ ≤ ∫ ω, D ω ∂μ := hm
    _ ≤ ε := hmean

theorem random_threat_independent (B : ℕ → Ω → ℝ) (hB : iIndepFun B μ)
    (hmeas : ∀ i, Measurable (B i)) (hrange : ∀ i ω, B i ω ∈ Set.Icc (0 : ℝ) 1)
    (n : ℕ) (hn : 0 < n) (ε Hmax C ηH : ℝ) (hC : 0 < C) (Hrand : Ω → ℝ)
    (hmean : ∀ i, 1 - ε ≤ μ[B i]) (hδ : 0 < 1 - ε - Hmax / C)
    (hT : μ.real {ω | Hmax < Hrand ω} ≤ ηH) :
    μ.real {ω | C / n * ∑ i ∈ Finset.range n, B i ω < Hrand ω} ≤
      ηH + exp (-2 * n * (1 - ε - Hmax / C) ^ 2) :=
  random_threat_bound (fun ω => C / n * ∑ i ∈ Finset.range n, B i ω) Hrand Hmax ηH _ hT
    (NarrowPlace.np_splitting_bound B hB hmeas hrange n hn ε Hmax C hC hmean hδ)

theorem random_threat_correlated (D Hrand : Ω → ℝ) (hD0 : ∀ ω, 0 ≤ D ω)
    (hDi : Integrable D μ) (ε Hmax C ηH : ℝ) (hC : 0 < C) (hmean : ∫ ω, D ω ∂μ ≤ ε)
    (hh : 0 < 1 - Hmax / C) (hT : μ.real {ω | Hmax < Hrand ω} ≤ ηH) :
    μ.real {ω | C * (1 - D ω) < Hrand ω} ≤ ηH + ε / (1 - Hmax / C) :=
  random_threat_bound (fun ω => C * (1 - D ω)) Hrand Hmax ηH _ hT
    (correlated_holding_bound D hD0 hDi ε Hmax C hC hmean hh)

end Snuffy.CorrelatedHolding
