import Snuffy.OuterLane

/-!
# Theorem XI, geometric core: reach before harm

Joins wavefront coverage and interception timing: if founding covers the
initial domain at an interception radius that fits every deadline, and the
guarded region expands at least as fast as the domain, then at every later
time every particular of the domain has a guard that acts before the deadline.
-/

namespace Snuffy.ReachBeforeHarm

open Snuffy.OuterLane

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

theorem reach_before_harm (D0 G0 Dt Gt : Set E) (ρ c v t cs τ d : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (ht : 0 ≤ t) (hcv : c ≤ v) (hcs : 0 < cs)
    (hfit : ρ ≤ cs * (d - τ))
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dt, ∃ y ∈ D0, dist x y ≤ c * t)
    (hG : ∀ z, (∃ g ∈ G0, dist z g ≤ v * t) → z ∈ Gt) :
    ∀ x ∈ Dt, ∃ g ∈ Gt, dist x g / cs + τ ≤ d := by
  intro x hx
  obtain ⟨g, hg, hxg⟩ :=
    wavefront_coverage D0 G0 Dt Gt ρ c v t hρ hv ht hcv hcov0 hD hG x hx
  exact ⟨g, hg, interception_in_time (dist x g) ρ cs τ d hcs hxg hfit⟩

end Snuffy.ReachBeforeHarm
