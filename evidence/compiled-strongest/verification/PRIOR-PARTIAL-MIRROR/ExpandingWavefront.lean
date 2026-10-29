import Snuffy.OuterLane

/-!
# Lemma W under the expansion of space (finding 14, expansion form)

In an expanding space with scale factor `a(t) > 0`, work in comoving coordinates and
conformal time `η = ∫ dt / a(t)`. Anything moving at proper speed at most `c` moves
comoving distance at most `c·η`; a guard wavefront advancing at proper speed `v`
reaches comoving distance `v·η`. Expansion carries particulars and guards alike, so it
cancels out of the comoving picture, and Lemma W's inequality `c ≤ v` is unchanged.

* `expanding_coverage` — with `hD` and `hG` stated in comoving distance and conformal
  time, interception coverage at comoving radius `ρ` is kept (`wavefront_coverage` with
  `t := η`);
* `expanding_round_trip` — if the scale factor stays at most `aMax` while a signal
  makes the round trip, its proper duration is at most `aMax · 2 dist / c_s`; so
  `aMax · 2ρ / c_s + τ ≤ d` gives interception before the deadline for every particular.
-/

namespace Snuffy.ExpandingWavefront

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

theorem expanding_coverage (D0 G0 Dη Gη : Set E) (ρ c v η : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (hη : 0 ≤ η) (hcv : c ≤ v)
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dη, ∃ y ∈ D0, dist x y ≤ c * η)
    (hG : ∀ z, (∃ g ∈ G0, dist z g ≤ v * η) → z ∈ Gη) :
    ∀ x ∈ Dη, ∃ g ∈ Gη, dist x g ≤ ρ :=
  OuterLane.wavefront_coverage D0 G0 Dη Gη ρ c v η hρ hv hη hcv hcov0 hD hG

theorem expanding_round_trip (D0 G0 Dη Gη : Set E) (ρ c v η cs aMax τ d : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (hη : 0 ≤ η) (hcv : c ≤ v) (hcs : 0 < cs) (ha : 0 ≤ aMax)
    (hfit : aMax * (2 * ρ / cs) + τ ≤ d)
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dη, ∃ y ∈ D0, dist x y ≤ c * η)
    (hG : ∀ z, (∃ g ∈ G0, dist z g ≤ v * η) → z ∈ Gη) :
    ∀ x ∈ Dη, ∃ g ∈ Gη, aMax * (2 * dist x g / cs) + τ ≤ d := by
  intro x hx
  obtain ⟨g, hg, hxg⟩ := expanding_coverage D0 G0 Dη Gη ρ c v η hρ hv hη hcv hcov0 hD hG x hx
  refine ⟨g, hg, le_trans ?_ hfit⟩
  have : 2 * dist x g / cs ≤ 2 * ρ / cs := by gcongr
  linarith [mul_le_mul_of_nonneg_left this ha]

end Snuffy.ExpandingWavefront
