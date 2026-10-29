import Mathlib

/-!
# The receiver-exclusion radius (Lemma E and the decoherence bound)

An emission channel delivers power `P₀ / rⁿ` at distance `r` (`n = 2` for radiated
fields and sound, `n = 3` for the low-frequency magnetic channel). A harm needing
work `W > 0` within deadline `d > 0` needs received energy `P(r)·d ≥ W`.

* `exclusion_radius` — at every `r ≥ r* = (P₀ d / W)^{1/n}` the received energy over the
  deadline is at most `W`, so beyond `r*` the channel cannot power that harm;
* `received_effect_bound` — any effect bounded by a coupling constant times received
  power (for example a decoherence rate `Γ ≤ κ·P(r)`) is bounded beyond the same kind of
  radius: `κ·P(r) ≤ Γ_max` once `r ≥ (κ P₀ / Γ_max)^{1/n}`.
-/

namespace Snuffy.ExclusionRadius

open Real

theorem exclusion_radius (P₀ W d r : ℝ) (n : ℕ) (hn : 0 < n)
    (hP : 0 < P₀) (hW : 0 < W) (hd : 0 < d)
    (hr : (P₀ * d / W) ^ ((1 : ℝ) / n) ≤ r) :
    P₀ / r ^ n * d ≤ W := by
  have hbase : 0 < P₀ * d / W := by positivity
  have hr0 : 0 < r := lt_of_lt_of_le (rpow_pos_of_pos hbase _) hr
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  -- raise both sides of hr to the n-th power
  have hpow : ((P₀ * d / W) ^ ((1 : ℝ) / n)) ^ n ≤ r ^ n :=
    pow_le_pow_left₀ (rpow_nonneg hbase.le _) hr n
  have hroot : ((P₀ * d / W) ^ ((1 : ℝ) / n)) ^ n = P₀ * d / W := by
    rw [← rpow_natCast, ← rpow_mul hbase.le, one_div_mul_cancel hnR.ne', rpow_one]
  rw [hroot] at hpow
  have hrn : 0 < r ^ n := pow_pos hr0 n
  rw [div_mul_eq_mul_div, div_le_iff₀ hrn]
  rw [div_le_iff₀ hW] at hpow
  linarith

theorem received_effect_bound (κ P₀ Γmax r : ℝ) (n : ℕ) (hn : 0 < n)
    (hκ : 0 < κ) (hP : 0 < P₀) (hΓ : 0 < Γmax)
    (hr : (κ * P₀ / Γmax) ^ ((1 : ℝ) / n) ≤ r) :
    κ * (P₀ / r ^ n) ≤ Γmax := by
  have h := exclusion_radius (κ * P₀) Γmax 1 r n hn (by positivity) hΓ one_pos
    (by simpa using hr)
  calc κ * (P₀ / r ^ n) = κ * P₀ / r ^ n * 1 := by ring
    _ ≤ Γmax := h

end Snuffy.ExclusionRadius
