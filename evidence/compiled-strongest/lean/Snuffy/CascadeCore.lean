import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith

/-! The directly adoptable mathematical core of Gemini's numbered proofs 1–6.
The thermodynamic identification is conditional on an actual dynamics model;
the final theorem supplies the sustained-deficit/time condition for buffer loss.
-/
namespace UPTCascadeCore
open scoped BigOperators

theorem workload_deadline (work rate deadline : ℝ) (hw : 0 ≤ work)
    (hr : 0 < rate) (paid : work ≤ rate*deadline) :
    0 ≤ work/rate ∧ work/rate ≤ deadline := by
  exact ⟨div_nonneg hw hr.le, (div_le_iff₀ hr).mpr (by simpa [mul_comm] using paid)⟩

def queue (initial : ℝ) (net : Nat → ℝ) : Nat → ℝ
  | 0 => initial
  | n+1 => max 0 (queue initial net n + net n)

theorem recursive_queue_bound (initial burst : ℝ) (net : Nat → ℝ)
    (hi : 0 ≤ initial) (hb : initial ≤ burst) :
    ∀ n, (∀ k < n, net k ≤ 0) → 0 ≤ queue initial net n ∧ queue initial net n ≤ burst := by
  intro n
  induction n with
  | zero => intro _; exact ⟨hi,hb⟩
  | succ n ih =>
      intro bounded
      have prior := ih (fun k hk => bounded k (by omega))
      have current := bounded n (by omega)
      simp only [queue]
      exact ⟨le_max_left _ _, max_le (hi.trans hb) (by linarith)⟩

def entropy (initial : ℝ) (net : Nat → ℝ) : Nat → ℝ
  | 0 => initial
  | n+1 => entropy initial net n + net n

theorem multi_epoch_entropy_bound (initial drift : ℝ) (net : Nat → ℝ) :
    ∀ n, (∀ k < n, net k ≤ drift) → entropy initial net n ≤ initial+n*drift := by
  intro n
  induction n with
  | zero => intro _; simp [entropy]
  | succ n ih =>
      intro bounded
      have prior := ih (fun k hk => bounded k (by omega))
      have current := bounded n (by omega)
      simp only [entropy, Nat.cast_add, Nat.cast_one]
      nlinarith

theorem spectrum_expectation_floor {n : Nat} (energy weight : Fin n → ℝ) (floor : ℝ)
    (positive : ∀ i, 0 ≤ weight i) (normalized : ∑ i, weight i = 1)
    (ground : ∀ i, floor ≤ energy i) :
    floor ≤ ∑ i, weight i*energy i := by
  calc
    floor = ∑ i, weight i*floor := by rw [← Finset.sum_mul, normalized, one_mul]
    _ ≤ ∑ i, weight i*energy i := Finset.sum_le_sum (fun i _ =>
      mul_le_mul_of_nonneg_left (ground i) (positive i))

theorem atomic_headroom (used cost capacity : Nat)
    (valid : used ≤ capacity) (fits : cost ≤ capacity-used) : used+cost ≤ capacity := by
  omega

theorem defection_deficit (base penalty production margin : ℝ)
    (shortage : base-penalty < production-margin) :
    margin < production-(base-penalty) := by linarith

/-- A persistent positive deficit crosses a finite buffer once its integrated
amount exceeds the buffer. This adds the temporal condition needed to turn a
rate inequality into an actual threshold crossing. -/
theorem sustained_deficit_crosses_buffer (initial _ceiling deficit : ℝ) (net : Nat → ℝ) :
    ∀ n, (∀ k < n, deficit ≤ net k) → initial+n*deficit ≤ entropy initial net n := by
  intro n
  induction n with
  | zero => intro _; simp [entropy]
  | succ n ih =>
      intro lower
      have prior := ih (fun k hk => lower k (by omega))
      have current := lower n (by omega)
      simp only [entropy, Nat.cast_add, Nat.cast_one]
      nlinarith

theorem buffer_threshold_crossed (initial ceiling deficit : ℝ) (net : Nat → ℝ)
    (n : Nat) (lower : ∀ k < n, deficit ≤ net k)
    (duration : ceiling < initial+n*deficit) : ceiling < entropy initial net n :=
  duration.trans_le (sustained_deficit_crosses_buffer initial ceiling deficit net n lower)

end UPTCascadeCore

