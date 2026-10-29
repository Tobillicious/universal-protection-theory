import Snuffy.OuterLane
import Snuffy.UPTFence

/-!
# Reach before harm with round-trip timing and the synchronous fence (Part XI repair)

The hostile referee of 29 October 2026 observed that `OuterLane.interception_in_time`
counts the outbound signal only. Here:

* `round_trip_in_time` — sign out, response `τ`, action back: `2ρ/c_s + τ ≤ d`
  whenever the guard is within `ρ ≤ c_s (d - τ)/2`;
* `reach_round_trip` — Lemma W joined to the round-trip bound;
* `net_coverage` — discrete guards forming a `ρ_net`-net of the swept region give
  coverage at radius `ρ + ρ_net`;
* `fence_in_time` — the synchronous fence: once the floor is raised above every
  minted generation, no write lands for any later sequence of attempts
  (`UPTFence.raise_then_nothing_lands`); its latency is zero, so it meets every
  deadline, including attacks faster than any round trip.
-/

namespace Snuffy.ReachTiming

open Snuffy.OuterLane

theorem round_trip_in_time (dist_g ρ cs τ d : ℝ) (hcs : 0 < cs)
    (hdist : dist_g ≤ ρ) (hρ : ρ ≤ cs * (d - τ) / 2) :
    2 * dist_g / cs + τ ≤ d := by
  have h2 : 2 * dist_g ≤ cs * (d - τ) := by linarith
  have : 2 * dist_g / cs ≤ d - τ := by
    rw [div_le_iff₀ hcs]; linarith [mul_comm cs (d - τ)]
  linarith

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

theorem reach_round_trip (D0 G0 Dt Gt : Set E) (ρ c v t cs τ d : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (ht : 0 ≤ t) (hcv : c ≤ v) (hcs : 0 < cs)
    (hfit : ρ ≤ cs * (d - τ) / 2)
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dt, ∃ y ∈ D0, dist x y ≤ c * t)
    (hG : ∀ z, (∃ g ∈ G0, dist z g ≤ v * t) → z ∈ Gt) :
    ∀ x ∈ Dt, ∃ g ∈ Gt, 2 * dist x g / cs + τ ≤ d := by
  intro x hx
  obtain ⟨g, hg, hxg⟩ :=
    wavefront_coverage D0 G0 Dt Gt ρ c v t hρ hv ht hcv hcov0 hD hG x hx
  exact ⟨g, hg, round_trip_in_time (dist x g) ρ cs τ d hcs hxg hfit⟩

/-- Discrete guards: if every point of the swept region is within `ρnet` of an
actual guard, coverage holds at radius `ρ + ρnet`. -/
theorem net_coverage (D0 G0 Dt Gt : Set E) (ρ ρnet c v t : ℝ)
    (hρ : 0 ≤ ρ) (hv : 0 ≤ v) (ht : 0 ≤ t) (hcv : c ≤ v)
    (hcov0 : ∀ y ∈ D0, ∃ g ∈ G0, dist y g ≤ ρ)
    (hD : ∀ x ∈ Dt, ∃ y ∈ D0, dist x y ≤ c * t)
    (hnet : ∀ z, (∃ g ∈ G0, dist z g ≤ v * t) → ∃ g' ∈ Gt, dist z g' ≤ ρnet) :
    ∀ x ∈ Dt, ∃ g' ∈ Gt, dist x g' ≤ ρ + ρnet := by
  intro x hx
  obtain ⟨z, hz, hxz⟩ := wavefront_coverage D0 G0 Dt
    {z | ∃ g ∈ G0, dist z g ≤ v * t} ρ c v t hρ hv ht hcv hcov0 hD (fun z hz => hz) x hx
  obtain ⟨g', hg', hzg'⟩ := hnet z hz
  exact ⟨g', hg', (dist_triangle x z g').trans (add_le_add hxz hzg')⟩

/-- **The synchronous fence meets every deadline.** Raising the floor above every
minted generation makes the very next window one in which nothing lands, for
every later sequence of attempts that mints no new generation: zero latency. -/
theorem fence_in_time (s : UPTFence.St) (g : Nat) (mid : List UPTFence.Ev)
    (hold : ∀ h, h ∈ s.minted → h ≤ g)
    (hmid : ∀ h, UPTFence.Ev.mint h ∈ mid → h ≤ g) :
    (UPTFence.run (UPTFence.apply s (.raise (g + 1))) mid).log = s.log :=
  UPTFence.raise_then_nothing_lands s g mid hold hmid

end Snuffy.ReachTiming
