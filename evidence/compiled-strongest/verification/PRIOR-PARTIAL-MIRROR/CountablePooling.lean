import Snuffy.NoisyPooling

/-!
# Lemma P for countably many keepers (finding 15, countable form)

The others' delivered capacity is the sum of countably many keepers' deliveries
`x i ω`, each measurable and of any joint law (correlations allowed). The sum is
taken in `[0, ∞]`, so it is always defined and measurable, even when it diverges.

* `pool_strictly_dominant_ennreal` — pooling `k` strictly raises the probability that
  delivered capacity reaches the threshold, whenever the pivotal event has positive
  probability;
* `countable_keepers_pool` — the same for the countable sum of the others' deliveries;
* `countable_keepers_noisy_pool` — with this keeper's own execution noise
  (`NoisyPooling`, `ε + δ < 1`), intending to pool is still strictly better.
-/

namespace Snuffy.CountablePooling

open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω]

theorem pool_strictly_dominant_ennreal (μ : Measure Ω) [IsFiniteMeasure μ]
    (others : Ω → ENNReal) (hm : Measurable others) (k thr : ENNReal)
    (hpiv : 0 < μ {ω | others ω < thr ∧ thr ≤ others ω + k}) :
    μ {ω | thr ≤ others ω} < μ {ω | thr ≤ others ω + k} := by
  have hA : MeasurableSet {ω | thr ≤ others ω} := measurableSet_le measurable_const hm
  have hB : MeasurableSet {ω | thr ≤ others ω + k} :=
    measurableSet_le measurable_const (hm.add_const k)
  have hsub : {ω | thr ≤ others ω} ⊆ {ω | thr ≤ others ω + k} :=
    fun ω (h : thr ≤ others ω) => show thr ≤ others ω + k from le_trans h le_self_add
  have hdiff : {ω | thr ≤ others ω + k} \ {ω | thr ≤ others ω} =
      {ω | others ω < thr ∧ thr ≤ others ω + k} := by
    ext ω
    simp only [Set.mem_sdiff, Set.mem_ofPred_eq, not_le]
    exact And.comm
  calc μ {ω | thr ≤ others ω}
      < μ {ω | thr ≤ others ω} + μ ({ω | thr ≤ others ω + k} \ {ω | thr ≤ others ω}) :=
        ENNReal.lt_add_right (measure_ne_top _ _) (by rw [hdiff]; exact hpiv.ne')
    _ = μ {ω | thr ≤ others ω + k} := by
        rw [← measure_union disjoint_sdiff_self_right (hB.diff hA), Set.union_sdiff_cancel hsub]

theorem countable_keepers_pool {ι : Type*} [Countable ι] (μ : Measure Ω) [IsFiniteMeasure μ]
    (x : ι → Ω → ENNReal) (hx : ∀ i, Measurable (x i)) (k thr : ENNReal)
    (hpiv : 0 < μ {ω | (∑' i, x i ω) < thr ∧ thr ≤ (∑' i, x i ω) + k}) :
    μ {ω | thr ≤ ∑' i, x i ω} < μ {ω | thr ≤ (∑' i, x i ω) + k} :=
  pool_strictly_dominant_ennreal μ (fun ω => ∑' i, x i ω) (Measurable.tsum hx) k thr
    hpiv

theorem countable_keepers_noisy_pool {ι : Type*} [Countable ι] (μ : Measure Ω)
    [IsFiniteMeasure μ] (x : ι → Ω → ENNReal) (hx : ∀ i, Measurable (x i))
    (k thr : ENNReal) (ε δ : ℝ) (hnoise : ε + δ < 1)
    (hpiv : 0 < μ {ω | (∑' i, x i ω) < thr ∧ thr ≤ (∑' i, x i ω) + k}) :
    NoisyPooling.heldIfAbstain δ (μ {ω | thr ≤ (∑' i, x i ω) + k}).toReal
        (μ {ω | thr ≤ ∑' i, x i ω}).toReal <
      NoisyPooling.heldIfPool ε (μ {ω | thr ≤ (∑' i, x i ω) + k}).toReal
        (μ {ω | thr ≤ ∑' i, x i ω}).toReal :=
  NoisyPooling.noisy_pool_strictly_dominant ε δ _ _ hnoise
    (ENNReal.toReal_strict_mono (measure_ne_top _ _)
      (countable_keepers_pool μ x hx k thr hpiv))

end Snuffy.CountablePooling
