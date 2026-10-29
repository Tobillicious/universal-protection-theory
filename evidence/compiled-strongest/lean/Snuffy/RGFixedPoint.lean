/-
Snuffy — Canon Edition v4.1: bridge 11, the infrared fixed point of the
Wilson–Fisher-type flow `dg/dt = β(g) = εg − bg² − cg³` (`ε, b, c > 0`).

  * gstar_pos, beta_gstar — the interacting fixed point
    `g* = (−b + √(b² + 4εc))/(2c)` is positive and `β(g*) = 0`.
  * eigenvalue_gstar — `β'(g*) = −b g* − 2c g*² < 0`: the linearised flow
    decays at `g*`.
  * beta_pos_below, beta_neg_above — globally on `g > 0`, `β > 0` below `g*`
    and `β < 0` above it, so every positive coupling flows toward `g*`: the
    whole positive half-line is its basin.

The flow law (the coefficients `b, c > 0` for the BCRD metric coupling) is
this module's premise.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Polynomial

open Real

namespace Snuffy.RGFixedPoint

variable {ε b c : ℝ}

/-- The beta function. -/
def beta (ε b c g : ℝ) : ℝ := ε * g - b * g ^ 2 - c * g ^ 3

/-- The interacting fixed point. -/
noncomputable def gstar (ε b c : ℝ) : ℝ := (-b + √(b ^ 2 + 4 * ε * c)) / (2 * c)

lemma sq_root (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) :
    √(b ^ 2 + 4 * ε * c) ^ 2 = b ^ 2 + 4 * ε * c ∧ b < √(b ^ 2 + 4 * ε * c) := by
  have hpos : 0 ≤ b ^ 2 + 4 * ε * c := by positivity
  refine ⟨sq_sqrt hpos, (lt_sqrt hb.le).mpr (by nlinarith [mul_pos hε hc])⟩

theorem gstar_pos (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) : 0 < gstar ε b c := by
  unfold gstar
  exact div_pos (by linarith [(sq_root hε hb hc).2]) (by positivity)

/-- The fixed-point relation `c g*² + b g* = ε`. -/
lemma fixed_relation (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) :
    c * gstar ε b c ^ 2 + b * gstar ε b c = ε := by
  have h := (sq_root hε hb hc).1
  unfold gstar
  set r := √(b ^ 2 + 4 * ε * c)
  field_simp
  nlinarith [h]

theorem beta_gstar (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) : beta ε b c (gstar ε b c) = 0 := by
  have h := fixed_relation hε hb hc
  unfold beta
  have : ε * gstar ε b c - b * gstar ε b c ^ 2 - c * gstar ε b c ^ 3
      = gstar ε b c * (ε - (c * gstar ε b c ^ 2 + b * gstar ε b c)) := by ring
  rw [this, h, sub_self, mul_zero]

/-- **The IR eigenvalue.** `β'(g*) = −b g* − 2c g*² < 0`. -/
theorem eigenvalue_gstar (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) :
    HasDerivAt (beta ε b c) (-b * gstar ε b c - 2 * c * gstar ε b c ^ 2) (gstar ε b c) ∧
      -b * gstar ε b c - 2 * c * gstar ε b c ^ 2 < 0 := by
  have hg := gstar_pos hε hb hc
  have h := fixed_relation hε hb hc
  have hd := (((hasDerivAt_id' (gstar ε b c)).const_mul ε).sub
    ((hasDerivAt_pow 2 (gstar ε b c)).const_mul b)).sub
    ((hasDerivAt_pow 3 (gstar ε b c)).const_mul c)
  refine ⟨?_, by nlinarith [mul_pos hb hg, mul_pos hc (pow_pos hg 2)]⟩
  have hfun : beta ε b c = fun y => ε * y - b * y ^ 2 - c * y ^ 3 := rfl
  rw [hfun]
  convert hd using 1
  norm_num
  linear_combination h

/-- The factorisation `β(g) = c g (g* − g)(g + g₋)` with `g₋ = (b + √·)/(2c) > 0`. -/
lemma beta_factor (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) (g : ℝ) :
    beta ε b c g = c * g * (gstar ε b c - g) * (g + (b + √(b ^ 2 + 4 * ε * c)) / (2 * c)) := by
  have h := (sq_root hε hb hc).1
  unfold beta gstar
  set r := √(b ^ 2 + 4 * ε * c)
  field_simp
  linear_combination (-g) * h

theorem beta_pos_below (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) {g : ℝ} (hg : 0 < g)
    (hlt : g < gstar ε b c) : 0 < beta ε b c g := by
  rw [beta_factor hε hb hc]
  have : 0 < (b + √(b ^ 2 + 4 * ε * c)) / (2 * c) :=
    div_pos (by linarith [(sq_root hε hb hc).2]) (by positivity)
  have h1 : 0 < c * g := mul_pos hc hg
  have h2 : 0 < gstar ε b c - g := by linarith
  positivity

theorem beta_neg_above (hε : 0 < ε) (hb : 0 < b) (hc : 0 < c) {g : ℝ}
    (hgt : gstar ε b c < g) : beta ε b c g < 0 := by
  have hg0 := gstar_pos hε hb hc
  rw [beta_factor hε hb hc]
  have hm : 0 < (b + √(b ^ 2 + 4 * ε * c)) / (2 * c) :=
    div_pos (by linarith [(sq_root hε hb hc).2]) (by positivity)
  have h1 : 0 < c * g := mul_pos hc (by linarith)
  have h2 : gstar ε b c - g < 0 := by linarith
  have h3 : 0 < g + (b + √(b ^ 2 + 4 * ε * c)) / (2 * c) := by linarith
  have := mul_neg_of_pos_of_neg h1 h2
  exact mul_neg_of_neg_of_pos this h3

end Snuffy.RGFixedPoint
