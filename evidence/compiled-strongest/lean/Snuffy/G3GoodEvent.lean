/-
Snuffy — Canon Edition 4.2 working: wavefront recovery succeeds on the good
event, and its bill keeps archive holding explicit (G3; review objection 5).

  * sweep_success_on_good_event — if, off the named charged accounts, every
    patch read-out lies within the decoding radius of its target codeword
    once its interior is recovered (the threshold theorem bounds the event
    that it does not), then the wavefront sweep recovers the whole region; the
    probability that recovery fails is at most `Σ δ`, with no independence.
  * complete_bill_with_archive — the complete pathwise bill is the sweep bill
    plus the archive holding charge. With the sweep bounded by `C₁ t^d` and
    the summed archive holding by `C₂ t^d`, the whole is at most
    `(C₁ + C₂) t^d`. Archive holding is a separate term of the bill; it is not
    set to zero.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G3PatchDecode
import Snuffy.G1Held

open MeasureTheory

namespace Snuffy.G3GoodEvent

open Snuffy.G3Sweep Snuffy.G3PatchDecode Snuffy.G1Held

variable {V Val X Ω ι : Type*} [MetricSpace X] [MeasurableSpace Ω]

/-- **Recovery succeeds on the good event.** -/
theorem sweep_success_on_good_event (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {Code : Set X} {dmin rad : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (hrad : 2 * rad < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (layer : V → ℕ) (target : V → Val) (read : Ω → V → (V → Val) → X) (extract : V → X → Val)
    (enc : V → X) (henc : ∀ v, enc v ∈ Code) (hext : ∀ v, extract v (enc v) = target v)
    (hradius : ∀ ω ∈ goodEvent accounts Ev', ∀ v s,
      (∀ u, layer u < layer v → s u = target u) → dist (read ω v s) (enc v) ≤ rad)
    (outer : Ω → ℕ → (V → Val) → (V → Val)) (s₀ : Ω → V → Val)
    (hfence : ∀ ω k s v, layer v < k → outer ω k s v = s v) (N : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ v, layer v < N →
      sweep layer (patchCorr (read ω) dec extract) (outer ω) (s₀ ω) N v = target v) ∧
    μ {ω | ¬ ∀ v, layer v < N →
      sweep layer (patchCorr (read ω) dec extract) (outer ω) (s₀ ω) N v = target v}
      ≤ ∑ i ∈ accounts, δ i := by
  have hgood : ∀ ω ∈ goodEvent accounts Ev', ∀ v, layer v < N →
      sweep layer (patchCorr (read ω) dec extract) (outer ω) (s₀ ω) N v = target v := by
    intro ω hω
    exact sweep_recovers layer (patchCorr (read ω) dec extract) (outer ω) (s₀ ω) target
      (patch_correction_succeeds hsep hrad hdecC hnear layer target (read ω) extract enc henc
        hext (hradius ω hω))
      (hfence ω) N
  refine ⟨hgood, ?_⟩
  have hsub : {ω | ¬ ∀ v, layer v < N →
      sweep layer (patchCorr (read ω) dec extract) (outer ω) (s₀ ω) N v = target v} ⊆
      ⋃ i ∈ accounts, Ev' i := by
    intro ω hω
    by_contra hnot
    exact hω (hgood ω (fun i hi hωi => hnot (Set.mem_biUnion hi hωi)))
  calc μ _ ≤ μ (⋃ i ∈ accounts, Ev' i) := measure_mono hsub
    _ ≤ ∑ i ∈ accounts, μ (Ev' i) := measure_biUnion_finset_le accounts Ev'
    _ ≤ ∑ i ∈ accounts, δ i := Finset.sum_le_sum hδ

omit [MetricSpace X] [MeasurableSpace Ω] in
/-- **The complete bill keeps archive holding explicit.** -/
theorem complete_bill_with_archive (sweepBill : ℕ) (hold : ℕ → ℕ) (C₁ C₂ d t : ℕ)
    (hsweep : sweepBill ≤ C₁ * t ^ d)
    (hhold : (Finset.range t).sum hold ≤ C₂ * t ^ d) :
    sweepBill + (Finset.range t).sum hold ≤ (C₁ + C₂) * t ^ d := by
  rw [add_mul]
  exact Nat.add_le_add hsweep hhold

end Snuffy.G3GoodEvent
