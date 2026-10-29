import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Uniform optimality AND an actual restoring gradient flow. The old
proposed upper bound is then evaluated along a cap-preserving trajectory,
not merely at an arbitrary off-equilibrium vector. -/
namespace GeminiBridgeH8
noncomputable section
open scoped BigOperators

def energy {n : Nat} (s : Fin n → ℝ) : ℝ := ∑ i, (s i)^2
def blend {n : Nat} (u r : ℝ) (s : Fin n → ℝ) (i : Fin n) : ℝ :=
  u+r*(s i-u)
def flow (u initial t : ℝ) : ℝ := u+Real.exp (-2*t)*(initial-u)

theorem variance_identity {n : Nat} (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i=1) (uniform : (n:ℝ)*u=1) :
    ∑ i, (s i-u)^2 = energy s-u := by
  have expand : ∀ i, (s i-u)^2=(s i)^2-(2*u)*s i+u^2 := by
    intro i
    ring
  simp_rw [expand]
  rw [Finset.sum_add_distrib,Finset.sum_sub_distrib,← Finset.mul_sum,normalized]
  simp only [Finset.sum_const,Finset.card_fin,nsmul_eq_mul]
  dsimp [energy]
  have secondMoment : (n:ℝ)*u^2=u := by
    calc
      (n:ℝ)*u^2 = ((n:ℝ)*u)*u := by ring
      _ = u := by rw [uniform,one_mul]
  rw [secondMoment]
  ring

theorem uniform_global_minimum {n : Nat} (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i=1) (uniform : (n:ℝ)*u=1) :
    u ≤ energy s := by
  have positive := Finset.sum_nonneg (fun i (_ : i∈Finset.univ) => sq_nonneg (s i-u))
  rw [variance_identity s u normalized uniform] at positive
  linarith

theorem equality_only_at_uniform {n : Nat} (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i=1) (uniform : (n:ℝ)*u=1)
    (minimal : energy s=u) : ∀ i, s i=u := by
  have total : ∑ i, (s i-u)^2=0 := by
    rw [variance_identity s u normalized uniform,minimal,sub_self]
  intro i
  have single : (s i-u)^2 ≤ ∑ j, (s j-u)^2 :=
    Finset.single_le_sum (fun j _ => sq_nonneg (s j-u)) (Finset.mem_univ i)
  rw [total] at single
  exact sub_eq_zero.mp (sq_eq_zero_iff.mp (le_antisymm single (sq_nonneg _)))

theorem blend_normalized {n : Nat} (s : Fin n → ℝ) (u r : ℝ)
    (normalized : ∑ i, s i=1) (uniform : (n:ℝ)*u=1) :
    ∑ i, blend u r s i=1 := by
  simp only [blend,Finset.sum_add_distrib,← Finset.mul_sum,
    Finset.sum_sub_distrib,Finset.sum_const,Finset.card_fin,nsmul_eq_mul]
  rw [normalized,uniform]
  ring

theorem blend_cap_preserved (u r initial cap : ℝ)
    (hu : 0 ≤ u) (huc : u ≤ cap) (hr : 0 ≤ r) (hrOne : r ≤ 1)
    (hi : 0 ≤ initial) (hic : initial ≤ cap) :
    0 ≤ u+r*(initial-u) ∧ u+r*(initial-u) ≤ cap := by
  have first := mul_nonneg hr hi
  have second := mul_nonneg (sub_nonneg.mpr hrOne) hu
  have firstUpper := mul_le_mul_of_nonneg_left hic hr
  have secondUpper := mul_le_mul_of_nonneg_left huc (sub_nonneg.mpr hrOne)
  constructor <;> nlinarith

theorem exact_excess_decay {n : Nat} (s : Fin n → ℝ) (u r : ℝ)
    (normalized : ∑ i, s i=1) (uniform : (n:ℝ)*u=1) :
    energy (blend u r s)-u = r^2*(energy s-u) := by
  rw [← variance_identity (blend u r s) u (blend_normalized s u r normalized uniform) uniform,
    ← variance_identity s u normalized uniform,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  dsimp [blend]
  ring

theorem gradient_flow_equation (u initial t : ℝ) :
    HasDerivAt (flow u initial) (-2*(flow u initial t-u)) t := by
  have raw := ((((hasDerivAt_id t).const_mul (-2)).exp).mul_const (initial-u)).const_add u
  convert raw using 1
  · rfl
  · dsimp [flow]
    ring

theorem flow_coefficient_in_unit_interval (t : ℝ) (ht : 0 ≤ t) :
    0 < Real.exp (-2*t) ∧ Real.exp (-2*t) ≤ 1 := by
  exact ⟨Real.exp_pos _,Real.exp_le_one_iff.mpr (by linarith)⟩

/-- Original H8 bound along the restoring four-node gradient flow.
The state has two shares 1/4+r/8 and two shares 1/4-r/8.
For every finite time r=exp(-2t)>0, actual normalized dissipation
exceeds the proposed upper bound despite restorative dynamics. -/
theorem original_upper_fails_along_restoring_flow (r : ℝ) (hr : 0 < r) :
    let hhi := 2*(1/4+r/8)^2+2*(1/4-r/8)^2
    1*(1+(hhi-1/4)/(1-1/4)) < 4*hhi := by
  dsimp
  have hhi : 2*(1/4+r/8)^2+2*(1/4-r/8)^2=(1:ℝ)/4+r^2/16 := by ring
  rw [hhi]
  norm_num
  nlinarith [sq_pos_of_pos hr]

end
end GeminiBridgeH8

