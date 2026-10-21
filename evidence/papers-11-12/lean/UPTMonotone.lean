/-
Rung-5 monotonicity (Paper 11, rung4-gates/RUNG5-AUDIT.md, "Monotonicity proof"), previously analytical.
The holding, rescue and coordinated-load account bounds are built from factors 1 - w·pc + w·pc/z and
1 - w·pc + w·pc/z² (w a declared class weight, pc the service probability, z > 1 a grid point), raised to
nonnegative integer powers, multiplied by a nonnegative constant, minimised over a finite grid and clipped at 1.
Here y stands for 1/z or 1/z² (any y in [0, 1]); exact rational arithmetic, core Lean 4 only.
Conclusion: raising service from 499/500 to any larger pc never raises those account bounds.
-/
namespace UPTMono

/-- The factor `1 - w·pc + w·pc·y`, with `y = 1/z` or `y = 1/z²`. -/
def factor (w pc y : Rat) : Rat := 1 - w * pc + w * pc * y

/-- For a grid point z ≥ 1, both 1/z and 1/z² lie in [0, 1]. -/
theorem inv_in_unit (z : Rat) (hz : 1 ≤ z) : 0 ≤ z⁻¹ ∧ z⁻¹ ≤ 1 := by
  have hz0 : 0 < z := by grind
  have hpos : 0 < z⁻¹ := Rat.inv_pos.mpr hz0
  have hone : z * z⁻¹ = 1 := Rat.mul_inv_cancel z (by grind)
  have hmul := Rat.mul_le_mul_of_nonneg_left hz (Rat.le_of_lt hpos)
  refine ⟨Rat.le_of_lt hpos, ?_⟩
  grind

theorem factor_eq (w pc y : Rat) : factor w pc y = 1 - w * (1 - y) * pc := by unfold factor; grind

/-- Each factor is non-increasing in the service probability. -/
theorem factor_antitone (w y p q : Rat) (hw : 0 ≤ w) (hy : y ≤ 1) (hpq : p ≤ q) :
    factor w q y ≤ factor w p y := by
  have hc : 0 ≤ w * (1 - y) := Rat.mul_nonneg hw (by grind)
  have hm := Rat.mul_le_mul_of_nonneg_left hpq hc
  rw [factor_eq, factor_eq]; grind

/-- Each factor is nonnegative for weights, probabilities and y in [0, 1]. -/
theorem factor_nonneg (w p y : Rat) (hw0 : 0 ≤ w) (hw1 : w ≤ 1) (hp1 : p ≤ 1)
    (hy0 : 0 ≤ y) (hy1 : y ≤ 1) : 0 ≤ factor w p y := by
  have h2 : 1 - y ≤ 1 := by grind
  have hwy0 : 0 ≤ w * (1 - y) := Rat.mul_nonneg hw0 (by grind)
  have hwy1 : w * (1 - y) ≤ 1 := by have := Rat.mul_le_mul_of_nonneg_left h2 hw0; grind
  have hb : w * (1 - y) * p ≤ 1 := by have := Rat.mul_le_mul_of_nonneg_left hp1 hwy0; grind
  rw [factor_eq]; grind

/-- Products of nonnegative quantities preserve the comparison. -/
theorem mul_mono {x x' y y' : Rat} (hx0 : 0 ≤ x') (hx : x' ≤ x) (hy0 : 0 ≤ y') (hy : y' ≤ y) :
    x' * y' ≤ x * y := by
  have a := Rat.mul_le_mul_of_nonneg_left hy hx0
  have b := Rat.mul_le_mul_of_nonneg_left hx (show 0 ≤ y by grind)
  grind

/-- Nonnegative integer powers preserve the comparison. -/
theorem pow_mono {x x' : Rat} (hx0 : 0 ≤ x') (hx : x' ≤ x) : ∀ n : Nat, 0 ≤ x' ^ n ∧ x' ^ n ≤ x ^ n := by
  intro n
  induction n with
  | zero => grind
  | succ n ih =>
    rw [Rat.pow_succ, Rat.pow_succ]
    exact ⟨Rat.mul_nonneg ih.1 hx0, mul_mono ih.1 ih.2 hx0 hx⟩

/-- **One grid point.** The bound `factor(w₁)^u · factor(w₂)^D · K` (K ≥ 0, the z-power multiplier) does not
increase when service rises from p to q. -/
theorem bound_antitone (w₁ w₂ y K p q : Rat) (u D : Nat) (hw₁0 : 0 ≤ w₁) (hw₁1 : w₁ ≤ 1)
    (hw₂0 : 0 ≤ w₂) (hw₂1 : w₂ ≤ 1) (hy0 : 0 ≤ y) (hy1 : y ≤ 1) (hK : 0 ≤ K)
    (hp0 : 0 ≤ p) (hpq : p ≤ q) (hq1 : q ≤ 1) :
    factor w₁ q y ^ u * factor w₂ q y ^ D * K ≤ factor w₁ p y ^ u * factor w₂ p y ^ D * K := by
  have hq0 : 0 ≤ q := by grind
  have hp1 : p ≤ 1 := by grind
  have a := pow_mono (factor_nonneg w₁ q y hw₁0 hw₁1 hq1 hy0 hy1) (factor_antitone w₁ y p q hw₁0 hy1 hpq) u
  have b := pow_mono (factor_nonneg w₂ q y hw₂0 hw₂1 hq1 hy0 hy1) (factor_antitone w₂ y p q hw₂0 hy1 hpq) D
  have c := mul_mono a.1 a.2 b.1 b.2
  have hprod0 : 0 ≤ factor w₁ q y ^ u * factor w₂ q y ^ D := Rat.mul_nonneg a.1 b.1
  exact mul_mono hprod0 c hK (by grind)

/-- **The grid minimum.** If every grid point's bound does not increase, the minimum over the grid does not. -/
theorem grid_min_antitone (G : List Rat) (bq bp : Rat → Rat) (h : ∀ z, z ∈ G → bq z ≤ bp z) :
    ∀ c₁ c₂ : Rat, c₁ ≤ c₂ → (G.map bq).foldl min c₁ ≤ (G.map bp).foldl min c₂ := by
  induction G with
  | nil => intro c₁ c₂ hc; exact hc
  | cons z G ih =>
    intro c₁ c₂ hc
    simp only [List.map_cons, List.foldl_cons]
    apply ih (fun z' hz' => h z' (List.mem_cons_of_mem z hz'))
    have := h z List.mem_cons_self
    grind

/-- **Clipping at 1** preserves the comparison. -/
theorem clip_antitone (a b : Rat) (h : a ≤ b) : min 1 a ≤ min 1 b := by grind

/-- **The audit's step.** At every grid point and for every service probability q at or above 499/500, the
account bound is at most its value at 499/500, so the outward ceiling computed at 499/500 bounds every
larger service probability. -/
theorem ceiling_at_499_bounds_larger_service (w₁ w₂ y K q : Rat) (u D : Nat) (hw₁0 : 0 ≤ w₁) (hw₁1 : w₁ ≤ 1)
    (hw₂0 : 0 ≤ w₂) (hw₂1 : w₂ ≤ 1) (hy0 : 0 ≤ y) (hy1 : y ≤ 1) (hK : 0 ≤ K)
    (hq : 499 / 500 ≤ q) (hq1 : q ≤ 1) :
    factor w₁ q y ^ u * factor w₂ q y ^ D * K ≤
      factor w₁ (499 / 500) y ^ u * factor w₂ (499 / 500) y ^ D * K :=
  bound_antitone w₁ w₂ y K (499 / 500) q u D hw₁0 hw₁1 hw₂0 hw₂1 hy0 hy1 hK (by grind) hq hq1

/-- **At the audit's own parameters** (class weights 29/30 and 1/2, grid point z = 2, so y = 1/2), the account
bound at full service (pc = 1) is at most its value at pc = 499/500: the premises fit the real ledger. -/
theorem audit_instance (u D : Nat) (K : Rat) (hK : 0 ≤ K) :
    factor (29 / 30) 1 (1 / 2) ^ u * factor (1 / 2) 1 (1 / 2) ^ D * K ≤
      factor (29 / 30) (499 / 500) (1 / 2) ^ u * factor (1 / 2) (499 / 500) (1 / 2) ^ D * K :=
  ceiling_at_499_bounds_larger_service (29 / 30) (1 / 2) (1 / 2) K 1 u D (by grind) (by grind) (by grind) (by grind)
    (by grind) (by grind) hK (by grind) (by grind)

end UPTMono
