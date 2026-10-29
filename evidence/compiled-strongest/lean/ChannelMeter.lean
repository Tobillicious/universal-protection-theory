import Snuffy.ExclusionRadius

/-!
# Every channel excluded, listed or not (G1 inventory and Lemma E)

The G1 hypothesis asks for a complete inventory of a substrate's output channels. A
total meter makes that inventory unnecessary. Let `e c` be the power emitted through
channel `c`, over any index type: channels need not be known, listed or finite. If
the metered total `M` bounds every finite set of channels (energy conservation across
the enclosure), then:

* `channel_le_meter` — every channel, inventoried or not, emits at most `M`;
* `every_channel_excluded` — beyond `r* = (M d / W)^{1/n}` no channel can deliver the
  work `W` a harm needs within deadline `d` (`ExclusionRadius.exclusion_radius`);
* `every_channel_bits_bounded` — if each bit carried costs at least `ε₀ > 0` of
  energy, every channel carries at most `M / ε₀` bits per unit time.
-/

namespace Snuffy.ChannelMeter

theorem channel_le_meter {ι : Type*} (e : ι → ℝ) (M : ℝ)
    (hmeter : ∀ s : Finset ι, ∑ c ∈ s, e c ≤ M) (c : ι) : e c ≤ M := by
  simpa using hmeter {c}

theorem every_channel_excluded {ι : Type*} (e : ι → ℝ) (M W d r : ℝ) (n : ℕ) (hn : 0 < n)
    (hM : 0 < M) (hW : 0 < W) (hd : 0 < d)
    (hmeter : ∀ s : Finset ι, ∑ c ∈ s, e c ≤ M)
    (hr : (M * d / W) ^ ((1 : ℝ) / n) ≤ r) :
    ∀ c, e c / r ^ n * d ≤ W := by
  intro c
  have h1 := channel_le_meter e M hmeter c
  have hbase : 0 < M * d / W := by positivity
  have hr0 : 0 < r := lt_of_lt_of_le (Real.rpow_pos_of_pos hbase _) hr
  calc e c / r ^ n * d ≤ M / r ^ n * d := by gcongr
    _ ≤ W := ExclusionRadius.exclusion_radius M W d r n hn hM hW hd hr

theorem every_channel_bits_bounded {ι : Type*} (e I : ι → ℝ) (M ε₀ : ℝ) (hε : 0 < ε₀)
    (hmeter : ∀ s : Finset ι, ∑ c ∈ s, e c ≤ M) (hcost : ∀ c, I c * ε₀ ≤ e c) :
    ∀ c, I c ≤ M / ε₀ := by
  intro c
  rw [le_div_iff₀ hε]
  exact (hcost c).trans (channel_le_meter e M hmeter c)

end Snuffy.ChannelMeter
