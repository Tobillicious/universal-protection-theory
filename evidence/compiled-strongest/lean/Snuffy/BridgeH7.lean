import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! The submitted stubborn-anchor mechanism, with an actual FJ update.
a is positive access to a stubborn biased anchor; w is susceptibility.
Private evidence is retained with weight 1-w. No universal graph or
bandwidth threshold is assumed. The exact threshold is derived below. -/
namespace GeminiBridgeH7
noncomputable section
open Filter
open scoped Topology

def rate (a w : ℝ) : ℝ := w*(1-a)
def denominator (a w : ℝ) : ℝ := 1-rate a w
def step (a w anchor evidence state : ℝ) : ℝ :=
  w*((1-a)*state+a*anchor)+(1-w)*evidence
def equilibrium (a w anchor evidence : ℝ) : ℝ :=
  (w*a*anchor+(1-w)*evidence)/denominator a w
def sensitivity (a w : ℝ) : ℝ := (1-w)/denominator a w

def run (a w anchor evidence initial : ℝ) : Nat → ℝ
  | 0 => initial
  | n+1 => step a w anchor evidence (run a w anchor evidence initial n)

theorem rate_bounds (a w : ℝ) (ha : 0 < a) (haOne : a ≤ 1)
    (hw : 0 ≤ w) (hwOne : w ≤ 1) : 0 ≤ rate a w ∧ rate a w < 1 := by
  have factor : 0 ≤ 1-a := sub_nonneg.mpr haOne
  constructor
  · exact mul_nonneg hw factor
  · have upper := mul_le_mul_of_nonneg_right hwOne factor
    dsimp [rate]
    nlinarith

theorem denominator_positive (a w : ℝ) (ha : 0 < a) (haOne : a ≤ 1)
    (hw : 0 ≤ w) (hwOne : w ≤ 1) : 0 < denominator a w := by
  exact sub_pos.mpr (rate_bounds a w ha haOne hw hwOne).2

theorem equilibrium_is_fixed (a w anchor evidence : ℝ)
    (hd : denominator a w ≠ 0) :
    step a w anchor evidence (equilibrium a w anchor evidence) =
      equilibrium a w anchor evidence := by
  unfold step equilibrium denominator rate at *
  field_simp
  ring

theorem fixed_point_unique (a w anchor evidence state : ℝ)
    (hd : denominator a w ≠ 0)
    (fixed : step a w anchor evidence state = state) :
    state = equilibrium a w anchor evidence := by
  unfold equilibrium
  apply (eq_div_iff hd).mpr
  dsimp [step] at fixed
  dsimp [denominator,rate]
  nlinarith

theorem exact_transient (a w anchor evidence initial : ℝ)
    (hd : denominator a w ≠ 0) (n : Nat) :
    run a w anchor evidence initial n-equilibrium a w anchor evidence =
      rate a w^n*(initial-equilibrium a w anchor evidence) := by
  induction n with
  | zero => simp [run]
  | succ n ih =>
      have fixed := equilibrium_is_fixed a w anchor evidence hd
      have delta : ∀ x, step a w anchor evidence x-equilibrium a w anchor evidence =
          rate a w*(x-equilibrium a w anchor evidence) := by
        intro x
        dsimp [step] at fixed ⊢
        dsimp [rate]
        nlinarith
      rw [run,delta,ih,pow_succ]
      ring

theorem equilibrium_private_evidence_sensitivity
    (a w anchor evidence increment : ℝ) :
    equilibrium a w anchor (evidence+increment)-equilibrium a w anchor evidence =
      sensitivity a w*increment := by
  unfold equilibrium sensitivity
  ring

theorem stubborn_anchor_limit (a anchor evidence : ℝ) (ha : 0 < a) :
    Tendsto (fun w => equilibrium a w anchor evidence) (𝓝 1) (𝓝 anchor) := by
  have continuity : ContinuousAt (fun w => equilibrium a w anchor evidence) 1 := by
    unfold equilibrium denominator rate
    apply ContinuousAt.div
    · fun_prop
    · fun_prop
    · simpa using ne_of_gt ha
  have value : equilibrium a 1 anchor evidence = anchor := by
    simp [equilibrium,denominator,rate,ne_of_gt ha]
  simpa only [value] using continuity.tendsto

theorem private_evidence_sensitivity_vanishes (a : ℝ) (ha : 0 < a) :
    Tendsto (fun w => sensitivity a w) (𝓝 1) (𝓝 0) := by
  have continuity : ContinuousAt (fun w => sensitivity a w) 1 := by
    unfold sensitivity denominator rate
    apply ContinuousAt.div
    · fun_prop
    · fun_prop
    · simpa using ne_of_gt ha
  simpa [sensitivity,denominator,rate] using continuity.tendsto

/-- Truth=0, stubborn biased anchor=1. The operational bias threshold is
derived from a declared tolerance, not a universal unexplained constant. -/
theorem exact_bias_threshold (a w tolerance : ℝ)
    (ha : 0 < a) (haOne : a ≤ 1) (hw : 0 ≤ w) (hwOne : w ≤ 1)
    (ht : 0 ≤ tolerance) :
    tolerance ≤ equilibrium a w 1 0 ↔
      tolerance/(a+(1-a)*tolerance) ≤ w := by
  have hd := denominator_positive a w ha haOne hw hwOne
  have thresholdPositive : 0 < a+(1-a)*tolerance := by
    nlinarith [mul_nonneg (sub_nonneg.mpr haOne) ht]
  simp only [equilibrium,mul_one,mul_zero,add_zero]
  rw [le_div_iff₀ hd,div_le_iff₀ thresholdPositive]
  dsimp [denominator,rate]
  constructor <;> intro h <;> nlinarith

end
end GeminiBridgeH7

