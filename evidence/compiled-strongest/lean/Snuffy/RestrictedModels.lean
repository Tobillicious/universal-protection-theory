import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp

/-! Mathematical incorporation results for Gemini's H7, H8 and causal-law
targets. Each result states the model and premises used by its derivation.
-/
namespace UPTRestrictedModels
open scoped BigOperators

/-- With one common quadratic anchor and nonnegative diffusion, two-node
consensus dissipates error at every coupling strength. No universal upper
coupling threshold for 'groupthink' follows from the submitted dynamics. -/
theorem anchored_consensus_dissipation (x y anchor coupling : ℝ)
    (_ha : 0 ≤ anchor) (hc : 0 ≤ coupling) :
    x * (coupling*(y-x)-anchor*x) + y * (coupling*(x-y)-anchor*y) ≤
      -anchor*(x^2+y^2) := by
  have identity :
      x * (coupling*(y-x)-anchor*x) + y * (coupling*(x-y)-anchor*y) =
        -anchor*(x^2+y^2)-coupling*(x-y)^2 := by ring
  rw [identity]
  have dissipated := mul_nonneg hc (sq_nonneg (x-y))
  linarith

/-- Share variance is exactly excess HHI above the uniform share value.
This is an all-finite-population identity; no transport/energy law is inferred. -/
theorem hhi_variance_identity {n : ℕ} (positive : 0 < n) (shares : Fin n → ℝ)
    (normalized : ∑ i, shares i = 1) :
    (∑ i, (shares i - (1/(n:ℝ)))^2) = (∑ i, shares i^2) - 1/(n:ℝ) := by
  have hn : (n:ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt positive)
  calc
    (∑ i, (shares i - (1/(n:ℝ)))^2) =
      (∑ i, shares i^2) - 2*(1/(n:ℝ))*(∑ i, shares i) + (n:ℝ)*(1/(n:ℝ))^2 := by
        simp_rw [sub_sq]
        simp [Finset.sum_add_distrib, Finset.sum_sub_distrib,
          mul_comm, mul_left_comm]
        rw [Finset.sum_mul]
    _ = (∑ i, shares i^2) - 1/(n:ℝ) := by rw [normalized]; field_simp; ring

theorem uniform_shares_minimize_hhi {n : ℕ} (positive : 0 < n) (shares : Fin n → ℝ)
    (normalized : ∑ i, shares i = 1) :
    1/(n:ℝ) ≤ ∑ i, shares i^2 := by
  have nonneg : 0 ≤ ∑ i, (shares i - (1/(n:ℝ)))^2 :=
    Finset.sum_nonneg (fun _ _ => sq_nonneg _)
  rw [hhi_variance_identity positive shares normalized] at nonneg
  linarith

theorem uniform_shares_are_unique {n : ℕ} (positive : 0 < n) (shares : Fin n → ℝ)
    (normalized : ∑ i, shares i = 1) (minimal : ∑ i, shares i^2 = 1/(n:ℝ)) :
    ∀ i, shares i = 1/(n:ℝ) := by
  have zero : (∑ i, (shares i - (1/(n:ℝ)))^2) = 0 := by
    rw [hhi_variance_identity positive shares normalized, minimal]
    ring
  intro i
  have single : (shares i - (1/(n:ℝ)))^2 ≤ ∑ j, (shares j - (1/(n:ℝ)))^2 :=
    Finset.single_le_sum (fun j _ => sq_nonneg (shares j - (1/(n:ℝ)))) (Finset.mem_univ i)
  rw [zero] at single
  nlinarith [sq_nonneg (shares i - (1/(n:ℝ)))]

/-- An actual independently specified quadratic cost model supports the
corresponding decentralisation lower bound. The law relating physical costs
to this model is an application premise, not a theorem from HHI alone. -/
theorem quadratic_cost_floor {n : ℕ} (positive : 0 < n) (shares : Fin n → ℝ)
    (normalized : ∑ i, shares i = 1) (base scale : ℝ) (hs : 0 ≤ scale) :
    base + scale/(n:ℝ) ≤ base + scale*(∑ i, shares i^2) := by
  have lower := mul_le_mul_of_nonneg_left (uniform_shares_minimize_hhi positive shares normalized) hs
  simpa [div_eq_mul_inv, mul_assoc] using add_le_add_left lower base

def outputMass {U A : Type} [Fintype U] [DecidableEq A]
    (p : U → ℝ) (f : U → A) (a : A) : ℝ :=
  ∑ u, if f u = a then p u else 0

def jointOutputMass {U V A B : Type} [Fintype U] [Fintype V]
    [DecidableEq A] [DecidableEq B]
    (p : U → ℝ) (q : V → ℝ) (f : U → A) (g : V → B) (a : A) (b : B) : ℝ :=
  ∑ u, ∑ v, if f u = a ∧ g v = b then p u*q v else 0

/-- Fixed conditioning values (z,h) are parameters of p,q,f,g. In the explicitly
product conditional-noise model, independent deterministic mechanisms produce
factorized output masses. Actual conditional independence of the exogenous
noise must be justified; conditioning on history can otherwise destroy it. -/
theorem conditional_product_pushforward {U V A B : Type} [Fintype U] [Fintype V]
    [DecidableEq A] [DecidableEq B]
    (p : U → ℝ) (q : V → ℝ) (f : U → A) (g : V → B) (a : A) (b : B) :
    jointOutputMass p q f g a b = outputMass p f a * outputMass q g b := by
  classical
  unfold jointOutputMass outputMass
  rw [Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro u _
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro v _
  by_cases hf : f u = a <;> by_cases hg : g v = b <;> simp [hf, hg]

end UPTRestrictedModels

