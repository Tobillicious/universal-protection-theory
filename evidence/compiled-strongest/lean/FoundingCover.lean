import Snuffy.ReachTiming

/-!
# Founding coverage with finitely many guards (Theorem XI hypothesis 2, location part)

* `founding_cover_exists` — a compact initial domain is covered at any interception
  radius `ρ > 0` by a finite guard set placed inside it;
* `founded_reach` — founding with that finite set, a guarded region expanding at least as
  fast as the domain, and `ρ ≤ c_s (d - τ)/2` give round-trip reach before the deadline
  for every particular at every later time.

So the location half of founding coverage is a finite, costable construction: its cost
is the number of founding guards times the cost of one guard, which enters the anchor's
condition (`FoundingAnchor.anchor_founds_iff`).
-/

namespace Snuffy.FoundingCover

open Metric

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

omit [NormedSpace ℝ E] in
theorem founding_cover_exists (D0 : Set E) (hD : IsCompact D0) (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ G0 : Set E, G0 ⊆ D0 ∧ G0.Finite ∧ ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ := by
  obtain ⟨t, hts, htf, hcov⟩ := finite_cover_balls_of_compact hD hρ
  refine ⟨t, hts, htf, fun y hy => ?_⟩
  obtain ⟨g, hg, hyg⟩ := Set.mem_iUnion₂.mp (hcov hy)
  exact ⟨g, hg, (mem_ball.mp hyg).le⟩

theorem founded_reach (D0 Dt Gt : Set E) (hD : IsCompact D0) (ρ c v t cs τ d : ℝ)
    (hρ : 0 < ρ) (hv : 0 ≤ v) (ht : 0 ≤ t) (hcv : c ≤ v) (hcs : 0 < cs)
    (hfit : ρ ≤ cs * (d - τ) / 2)
    (hDt : ∀ x ∈ Dt, ∃ y ∈ D0, dist x y ≤ c * t) :
    ∃ G0 : Set E, G0.Finite ∧
      ((∀ z, (∃ g ∈ G0, dist z g ≤ v * t) → z ∈ Gt) →
        ∀ x ∈ Dt, ∃ g ∈ Gt, 2 * dist x g / cs + τ ≤ d) := by
  obtain ⟨G0, -, hfin, hcov⟩ := founding_cover_exists D0 hD ρ hρ
  exact ⟨G0, hfin, fun hG =>
    ReachTiming.reach_round_trip D0 G0 Dt Gt ρ c v t cs τ d hρ.le hv ht hcv hcs hfit
      hcov hDt hG⟩

end Snuffy.FoundingCover
