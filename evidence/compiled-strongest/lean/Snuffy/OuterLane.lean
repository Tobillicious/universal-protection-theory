import Mathlib

/-!
# Reach before harm: the outer lane (compiled edition, Part XI)

Four results that join the 18 October external lane to the canon's holding
construction.

* `wavefront_coverage` — if the guarded region expands at least as fast as the
  protected domain can (finite propagation speed, BCRD P4), and every initial
  particular is within interception radius `ρ` of a guard, then every
  particular of the domain at time `t` is within `ρ` of a guard at time `t`.
* `interception_in_time` — a guard within `ρ ≤ c_s (d - τ)` of a particular,
  signalling at speed `c_s` with response time `τ`, acts before the deadline `d`.
* `pool_strictly_dominant` — UPT-P v0.12.1 (b1): under execution noise, a keeper
  whose pooling is pivotal with positive probability strictly raises the
  probability that the ender is held, whatever the others intend.
* `outer_lane_risk` — founding, holding and charged-account failures compose by
  the union bound, with no independence.
-/

namespace Snuffy.OuterLane

open MeasureTheory

section Wavefront

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Wavefront coverage. `D0`, `G0`: initial domain and guards; `Dt`, `Gt`: the
domain and guards at time `t`. The domain moves at most at speed `c`
(`hD`); the guards fill every point within `v t` of an initial guard (`hG`);
`c ≤ v`. Then interception coverage at radius `ρ` is kept. -/
theorem wavefront_coverage (D0 G0 Dt Gt : Set E) (ρ c v t : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (ht : 0 ≤ t) (hcv : c ≤ v)
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dt, ∃ y ∈ D0, dist x y ≤ c * t)
    (hG : ∀ z, (∃ g ∈ G0, dist z g ≤ v * t) → z ∈ Gt) :
    ∀ x ∈ Dt, ∃ g' ∈ Gt, dist x g' ≤ ρ := by
  intro x hx
  obtain ⟨y, hy, hxy⟩ := hD x hx
  obtain ⟨g, hg, hyg⟩ := hcov0 y hy
  have hvt : 0 ≤ v * t := mul_nonneg hv ht
  have hct : c * t ≤ v * t := mul_le_mul_of_nonneg_right hcv ht
  have hxg : dist x g ≤ ρ + v * t := by
    calc dist x g ≤ dist x y + dist y g := dist_triangle _ _ _
      _ ≤ c * t + ρ := add_le_add hxy hyg
      _ ≤ ρ + v * t := by linarith
  by_cases hnear : dist x g ≤ v * t
  · exact ⟨x, hG x ⟨g, hg, hnear⟩, by simpa using hρ⟩
  · replace hnear := lt_of_not_ge hnear
    set a := dist x g with ha
    have ha0 : 0 < a := lt_of_le_of_lt hvt hnear
    set s : ℝ := v * t / a with hs
    have hs0 : 0 ≤ s := div_nonneg hvt ha0.le
    have hs1 : s ≤ 1 := (div_le_one ha0).mpr hnear.le
    have hnorm : ‖x - g‖ = a := by rw [ha, dist_eq_norm]
    refine ⟨g + s • (x - g), hG _ ⟨g, hg, ?_⟩, ?_⟩
    · rw [dist_eq_norm, add_sub_cancel_left, norm_smul, Real.norm_eq_abs,
        abs_of_nonneg hs0, hnorm, hs, div_mul_cancel₀ _ ha0.ne']
    · have hrw : x - (g + s • (x - g)) = (1 - s) • (x - g) := by
        rw [sub_smul, one_smul]; abel
      rw [dist_eq_norm, hrw, norm_smul, Real.norm_eq_abs,
        abs_of_nonneg (by linarith), hnorm]
      have : (1 - s) * a = a - v * t := by
        rw [sub_mul, one_mul, hs, div_mul_cancel₀ _ ha0.ne']
      rw [this]; linarith

/-- Interception before the deadline: travel time plus response fits. -/
theorem interception_in_time (dist_g ρ cs τ d : ℝ) (hcs : 0 < cs)
    (hdist : dist_g ≤ ρ) (hρ : ρ ≤ cs * (d - τ)) :
    dist_g / cs + τ ≤ d := by
  have : dist_g / cs ≤ d - τ := by
    rw [div_le_iff₀ hcs]; linarith [mul_comm cs (d - τ)]
  linarith

end Wavefront

section Pooling

variable {Ω : Type*} [MeasurableSpace Ω]

/-- Noise-induced dominance (v0.12.1 (b1)). `others ω` is the capacity the
other keepers actually deliver (their intentions composed with execution
noise, any law `μ`). The ender is held when delivered capacity reaches
`thr`. Pooling adds `k > 0`. If the pivotal event has positive probability,
pooling strictly raises the probability of holding, for every law of the
others' intentions with that property. -/
theorem pool_strictly_dominant (μ : Measure Ω) [IsFiniteMeasure μ]
    (others : Ω → ℝ) (hm : Measurable others) (k thr : ℝ) (hk : 0 < k)
    (hpiv : 0 < μ {ω | thr - k ≤ others ω ∧ others ω < thr}) :
    μ {ω | thr ≤ others ω} < μ {ω | thr ≤ others ω + k} := by
  have hsub : {ω | thr ≤ others ω} ⊆ {ω | thr ≤ others ω + k} := by
    intro ω h; simp only [Set.mem_ofPred_eq] at *; linarith
  have hdiff : {ω | thr ≤ others ω + k} \ {ω | thr ≤ others ω} =
      {ω | thr - k ≤ others ω ∧ others ω < thr} := by
    ext ω; simp only [Set.mem_sdiff, Set.mem_ofPred_eq, not_le]
    constructor
    · rintro ⟨h1, h2⟩; exact ⟨by linarith, h2⟩
    · rintro ⟨h1, h2⟩; exact ⟨by linarith, h2⟩
  have hmeas : MeasurableSet {ω | thr ≤ others ω} :=
    measurableSet_le measurable_const hm
  have key := measure_sdiff_add_inter
    {ω | thr ≤ others ω + k} hmeas (μ := μ)
  rw [Set.inter_eq_right.mpr hsub, hdiff] at key
  have hfin : μ {ω | thr ≤ others ω} ≠ ⊤ := measure_ne_top _ _
  calc μ {ω | thr ≤ others ω}
      < μ {ω | thr ≤ others ω} + μ {ω | thr - k ≤ others ω ∧ others ω < thr} :=
        ENNReal.lt_add_right hfin hpiv.ne'
    _ = μ {ω | thr - k ≤ others ω ∧ others ω < thr} + μ {ω | thr ≤ others ω} :=
        add_comm _ _
    _ = μ {ω | thr ≤ others ω + k} := key

end Pooling

section Risk

variable {Ω : Type*} [MeasurableSpace Ω]

/-- The outer lane's failure event is contained in founding failure, a holding
failure at some date, or a charged account failure; its probability is at most
the sum of the bounds. No independence is assumed. -/
theorem outer_lane_risk (μ : Measure Ω) (Fail Found : Set Ω)
    (T K : Finset ℕ) (Hold : ℕ → Set Ω) (Acct : ℕ → Set Ω)
    (ηF : ENNReal) (φ δ : ℕ → ENNReal)
    (hcover : Fail ⊆ Found ∪ (⋃ t ∈ T, Hold t) ∪ (⋃ i ∈ K, Acct i))
    (hF : μ Found ≤ ηF) (hH : ∀ t ∈ T, μ (Hold t) ≤ φ t)
    (hA : ∀ i ∈ K, μ (Acct i) ≤ δ i) :
    μ Fail ≤ ηF + ∑ t ∈ T, φ t + ∑ i ∈ K, δ i := by
  calc μ Fail ≤ μ (Found ∪ (⋃ t ∈ T, Hold t) ∪ (⋃ i ∈ K, Acct i)) :=
        measure_mono hcover
    _ ≤ μ (Found ∪ ⋃ t ∈ T, Hold t) + μ (⋃ i ∈ K, Acct i) :=
        measure_union_le _ _
    _ ≤ (μ Found + μ (⋃ t ∈ T, Hold t)) + μ (⋃ i ∈ K, Acct i) := by
        gcongr; exact measure_union_le _ _
    _ ≤ (ηF + ∑ t ∈ T, φ t) + ∑ i ∈ K, δ i := by
        gcongr
        · exact (measure_biUnion_finset_le T Hold).trans (Finset.sum_le_sum hH)
        · exact (measure_biUnion_finset_le K Acct).trans (Finset.sum_le_sum hA)

end Risk

end Snuffy.OuterLane
