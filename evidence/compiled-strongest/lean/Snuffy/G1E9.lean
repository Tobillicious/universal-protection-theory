/-
Snuffy — Canon Edition 4.2 working: the coupling bound of the held source,
from E9 (G1).

At each step, either every monitored site of the particular's support is below
the sensor threshold, and the perturbing coupling on the frame is the
sub-threshold coupling bounded by `W` (Branch A), or some site reaches the
threshold. In the second case its honest sensors read above the threshold, so
every robust quorum estimate exceeds it whatever up to `f` faulty sensors
report (`E9SelfHealing.no_masking`): the alarm fires. The mediated response —
committed before the harm front arrives (the wave race of
`E9SelfHealing.e9_timely_self_healing`) and enforced at application time
(`H5Closure.no_harmful_effect`) — removes the perturbing coupling from the
frame for that step. In both cases the frame's step is a Schrödinger
evolution with perturbing coupling bounded by `W`, and the held source keeps
every particular.

  * alarm_or_subthreshold — the exhaustive per-step split with the alarm
    forced in the second branch.
  * held_source_e9 — `G1Held.held_source_qsl` with its coupling bound derived
    from that split.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G1Held
import Snuffy.E9SelfHealing

open MeasureTheory

namespace Snuffy.G1E9

open Snuffy.Bridge Snuffy.G1Held

/-- **Every step is sub-threshold or alarmed.** If some site reaches the
threshold, its honest sensors read above it and every robust quorum estimate
exceeds it. -/
theorem alarm_or_subthreshold {Site ι : Type*} [Fintype ι] [DecidableEq ι]
    (supp : Finset Site) (pow : Site → ℝ) (θ : ℝ) (y : Site → ι → ℝ)
    (faulty : Site → Finset ι) {f : ℕ} (hf : ∀ i, (faulty i).card ≤ f)
    (hhonest : ∀ i ∈ supp, θ ≤ pow i → ∀ j ∉ faulty i, θ < y i j) :
    (∀ i ∈ supp, pow i < θ) ∨
      ∃ i ∈ supp, θ ≤ pow i ∧ ∀ m, Snuffy.E9.Robust (y i) f m → θ < m := by
  by_cases hall : ∀ i ∈ supp, pow i < θ
  · exact Or.inl hall
  · right
    push Not at hall
    obtain ⟨i, hi, hpow⟩ := hall
    exact ⟨i, hi, hpow, fun m hm =>
      Snuffy.E9.no_masking (y i) (faulty i) (hf i) hm (hhonest i hi hpow)⟩

variable {Part Ω ι C Ev O Site Sensor : Type*} [MeasurableSpace Ω]
variable [Fintype Sensor] [DecidableEq Sensor]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-- **The held source with its coupling bound from E9.** At each step on the
good event, the frame's evolution is a Schrödinger evolution of duration `Δ`
under `H₀ + V` with the record stationary. If every support site is below
threshold, the coupling is the sub-threshold coupling, bounded by `W`. If the
alarm fires — every robust estimate at some site exceeds the threshold — the
mediated response leaves no perturbing coupling on the frame. The split is
exhaustive and the alarm is forced by the honest sensors, so the coupling is
bounded by `W` at every step, and every particular is held. -/
theorem held_source_e9 (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → NormalisedState E} {ε t dmin : ℝ} {Code : Set (NormalisedState E)} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : NormalisedState E → NormalisedState E} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (scope : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax scope F o → ¬ Snuffy.Law.NeedlessLoss₁ F o)
    (pre : Ω → (Part → NormalisedState E) → C → Ev → Part → NormalisedState E)
    {ħ W Δ θ : ℝ} (hħ : 0 < ħ) (hΔ : 0 ≤ Δ) (hW : 0 ≤ W) {f : ℕ}
    -- the monitored support, its delivered power and sensor readings at each step
    (supp : Ω → (Part → NormalisedState E) → C → Ev → Part → Finset Site)
    (pow : Ω → (Part → NormalisedState E) → C → Ev → Part → Site → ℝ)
    (y : Ω → (Part → NormalisedState E) → C → Ev → Part → Site → Sensor → ℝ)
    (faulty : Ω → (Part → NormalisedState E) → C → Ev → Part → Site → Finset Sensor)
    (hf : ∀ ω a c e x i, (faulty ω a c e x i).card ≤ f)
    (hhonest : ∀ ω a c e x, ∀ i ∈ supp ω a c e x, θ ≤ pow ω a c e x i →
      ∀ j ∉ faulty ω a c e x i, θ < y ω a c e x i j)
    -- the frame's actual evolution during the step
    (H₀ V : Ω → (Part → NormalisedState E) → C → Ev → Part → ℝ → E →L[ℂ] E)
    (ψ : Ω → (Part → NormalisedState E) → C → Ev → Part → ℝ → E) (s₁ : Ω → (Part → NormalisedState E) → C → Ev → Part → ℝ)
    (hevol : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x,
      (∀ s, IsSelfAdjoint (H₀ ω a c e x s)) ∧
      (∀ s, IsSelfAdjoint (H₀ ω a c e x s + V ω a c e x s)) ∧
      (∀ s, H₀ ω a c e x s (rec x).val = 0) ∧
      Snuffy.SpeedLimit.Solves ħ (fun s => H₀ ω a c e x s + V ω a c e x s) (ψ ω a c e x) ∧
      ‖ψ ω a c e x 0‖ = 1 ∧ ψ ω a c e x (s₁ ω a c e x) = (a x).val ∧
      ψ ω a c e x (s₁ ω a c e x + Δ) = (pre ω a c e x).val)
    -- Branch A: below threshold at every support site, the coupling is sub-threshold
    (hsub : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x,
      (∀ i ∈ supp ω a c e x, pow ω a c e x i < θ) → ∀ s, ‖V ω a c e x s‖ ≤ W)
    -- the mediated response: once the alarm fires, no perturbing coupling reaches the frame
    (hresp : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x, ∀ i ∈ supp ω a c e x,
      (∀ m, Snuffy.E9.Robust (y ω a c e x i) f m → θ < m) → ∀ s, V ω a c e x s = 0)
    (hbudget : ε + W / ħ * Δ ≤ t)
    (obs : (Part → NormalisedState E) → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x}
      ≤ ∑ i ∈ accounts, δ i := by
  refine held_source_qsl μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε scope hlaw pre
    hħ hΔ (W := W) (fun ω hω a c e x => ?_) hbudget obs ctrl env horizon
  obtain ⟨hH₀, hHV, hzero, hψ, hψ1, hstart, hend⟩ := hevol ω hω a c e x
  have hVW : ∀ s, ‖V ω a c e x s‖ ≤ W := by
    rcases alarm_or_subthreshold (supp ω a c e x) (pow ω a c e x) θ (y ω a c e x)
      (faulty ω a c e x) (hf ω a c e x) (hhonest ω a c e x) with hall | ⟨i, hi, -, halarm⟩
    · exact hsub ω hω a c e x hall
    · intro s
      rw [hresp ω hω a c e x i hi halarm s, norm_zero]
      exact hW
  exact ⟨H₀ ω a c e x, V ω a c e x, ψ ω a c e x, s₁ ω a c e x, hH₀, hHV, hVW, hzero, hψ, hψ1,
    hstart, hend⟩

end Snuffy.G1E9
