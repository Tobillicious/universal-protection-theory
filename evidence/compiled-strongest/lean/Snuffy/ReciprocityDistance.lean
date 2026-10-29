/-
Snuffy — Canon Edition 4.2 working: reciprocity dominance at a sufficient code
distance (§15.2, the combined form).

Three compiled results combine into one. On the good event the canonical
outcome contains the rival's (`ReasonsCompiled.reciprocity_expectation`), so a
rival can exceed the canonical regime only on the good event's complement. On
the good event the canonical regime keeps every particular
(`reciprocity_canonical_floor`), so it keeps the mind with probability at least
one minus the failure probability. And the failure probability can be pushed
below any ε by code distance (`Threshold.family_ceiling`,
`CorrelatedCeiling.correlated_family_ceiling`).

For the design family indexed by code distance `d`, with good events `G d`
whose failure probability falls below every ε from some distance on:

  * distance_floor — from some distance on, the canonical regime keeps the
    mind with probability above `1 − ε`.
  * reciprocity_at_distance — for every rival and every ε > 0, from some
    distance on, the rival's kept-probability is at most the canonical one
    plus ε.
  * reciprocity_strict_at_distance — every rival that loses the mind with
    positive probability is strictly below the canonical regime from some
    distance on.
  * canonical_tends_to_one — the canonical kept-probability tends to one, at
    least the kept-probability of every rival.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ReasonsCompiled

open MeasureTheory Set Filter

namespace Snuffy.ReciprocityDistance

open Snuffy.ReasonsCompiled

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)] [∀ i, OrderTop (L i)]
variable {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]

theorem distance_floor (oL : ℕ → Ω → ∀ i, L i) (G : ℕ → Set Ω)
    (hG : ∀ d, MeasurableSet (G d)) (htop : ∀ d, ∀ w ∈ G d, oL d w = ⊤)
    (hceil : ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, μ.real (G d)ᶜ < ε)
    (U : Set (∀ i, L i)) (hU : ⊤ ∈ U) :
    ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, 1 - ε < μ.real (oL d ⁻¹' U) := by
  intro ε hε
  obtain ⟨d₀, hd₀⟩ := hceil ε hε
  refine ⟨d₀, fun d hd => ?_⟩
  have h := reciprocity_canonical_floor μ (oL d) (G d) (hG d) (htop d) U hU
  linarith [hd₀ d hd]

theorem reciprocity_at_distance (oL : ℕ → Ω → ∀ i, L i) (G : ℕ → Set Ω)
    (hG : ∀ d, MeasurableSet (G d)) (htop : ∀ d, ∀ w ∈ G d, oL d w = ⊤)
    (hceil : ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, μ.real (G d)ᶜ < ε)
    (U : Set (∀ i, L i)) (hU : ⊤ ∈ U) (oQ : Ω → ∀ i, L i) :
    ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, μ.real (oQ ⁻¹' U) ≤ μ.real (oL d ⁻¹' U) + ε := by
  intro ε hε
  obtain ⟨d₀, hd₀⟩ := distance_floor μ oL G hG htop hceil U hU ε hε
  refine ⟨d₀, fun d hd => ?_⟩
  have h1 : μ.real (oQ ⁻¹' U) ≤ 1 := measureReal_le_one
  linarith [hd₀ d hd]

theorem reciprocity_strict_at_distance (oL : ℕ → Ω → ∀ i, L i) (G : ℕ → Set Ω)
    (hG : ∀ d, MeasurableSet (G d)) (htop : ∀ d, ∀ w ∈ G d, oL d w = ⊤)
    (hceil : ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, μ.real (G d)ᶜ < ε)
    (U : Set (∀ i, L i)) (hU : ⊤ ∈ U) (oQ : Ω → ∀ i, L i)
    (hloses : μ.real (oQ ⁻¹' U) < 1) :
    ∃ d₀, ∀ d ≥ d₀, μ.real (oQ ⁻¹' U) < μ.real (oL d ⁻¹' U) := by
  obtain ⟨d₀, hd₀⟩ := distance_floor μ oL G hG htop hceil U hU
    (1 - μ.real (oQ ⁻¹' U)) (by linarith)
  exact ⟨d₀, fun d hd => by linarith [hd₀ d hd]⟩

theorem canonical_tends_to_one (oL : ℕ → Ω → ∀ i, L i) (G : ℕ → Set Ω)
    (hG : ∀ d, MeasurableSet (G d)) (htop : ∀ d, ∀ w ∈ G d, oL d w = ⊤)
    (hceil : ∀ ε > 0, ∃ d₀, ∀ d ≥ d₀, μ.real (G d)ᶜ < ε)
    (U : Set (∀ i, L i)) (hU : ⊤ ∈ U) :
    Tendsto (fun d => μ.real (oL d ⁻¹' U)) atTop (nhds 1) := by
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨d₀, hd₀⟩ := distance_floor μ oL G hG htop hceil U hU ε hε
  refine ⟨d₀, fun d hd => ?_⟩
  have h1 : μ.real (oL d ⁻¹' U) ≤ 1 := measureReal_le_one
  rw [Real.dist_eq, abs_lt]
  constructor <;> linarith [hd₀ d hd]

end Snuffy.ReciprocityDistance
