import Mathlib

/-!
# Itemised failure accounts with conditional kernels (Theorem XI hypothesis 5, Lemma R)

Theorem XI's hypothesis 5 names every failure account and asks each to have a genuine
conditional kernel. Here an account `i` fails with probability given by a kernel
`κ i ω` (its conditional failure probability given the state `ω` of everything else),
so `μ (A i) = ∫ κ i dμ`. A pointwise bound `κ i ω ≤ δ i`, the worst case over every
conditioning state, covers correlated failures without any independence.

* `account_le_of_kernel` — such an account fails with probability at most `δ i`;
* `itemised_risk` — if every failure of the conclusion lies in one of countably many
  accounts, its probability is at most `∑ δ i`.
-/

namespace Snuffy.ItemisedRisk

open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω]

theorem account_le_of_kernel (μ : Measure Ω) [IsProbabilityMeasure μ] (A : Set Ω)
    (κ : Ω → ENNReal) (δ : ENNReal) (hker : μ A = ∫⁻ ω, κ ω ∂μ) (hbound : ∀ ω, κ ω ≤ δ) :
    μ A ≤ δ := by
  rw [hker]
  calc ∫⁻ ω, κ ω ∂μ ≤ ∫⁻ _, δ ∂μ := lintegral_mono hbound
    _ = δ := by simp

theorem itemised_risk {ι : Type*} [Countable ι] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (Fail : Set Ω) (A : ι → Set Ω) (κ : ι → Ω → ENNReal) (δ : ι → ENNReal)
    (hcover : Fail ⊆ ⋃ i, A i) (hker : ∀ i, μ (A i) = ∫⁻ ω, κ i ω ∂μ)
    (hbound : ∀ i ω, κ i ω ≤ δ i) :
    μ Fail ≤ ∑' i, δ i :=
  calc μ Fail ≤ μ (⋃ i, A i) := measure_mono hcover
    _ ≤ ∑' i, μ (A i) := measure_iUnion_le _
    _ ≤ ∑' i, δ i := ENNReal.tsum_le_tsum fun i =>
        account_le_of_kernel μ (A i) (κ i) (δ i) (hker i) (hbound i)

end Snuffy.ItemisedRisk
