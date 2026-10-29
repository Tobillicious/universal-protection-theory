import Mathlib.Topology.MetricSpace.Contracting
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! A finite energy quota gives a finite approximation, not exact Banach-limit
attainment. The existence of a fixed point is supplied separately (e.g. by a
contraction on a nonempty complete invariant space). These estimates apply to
arbitrary metric spaces once that witness and the contraction are certified.
-/
namespace UPTReflectionContraction
variable {S : Type} [MetricSpace S]

def run (R : S → S) : Nat → S → S
  | 0, s => s
  | n+1, s => R (run R n s)

/-- Banach supplies existence and uniqueness under its actual completeness
premise. A compact set of initial states alone is not that premise. -/
theorem complete_contraction_has_unique_fixed_point [Nonempty S] [CompleteSpace S]
    (R : S → S) (k : NNReal) (contract : ContractingWith k R) :
    ∃! fixed, R fixed = fixed := by
  refine ⟨ContractingWith.fixedPoint R contract, ?_, ?_⟩
  · exact contract.fixedPoint_isFixedPt
  · intro candidate fixed
    exact contract.fixedPoint_unique fixed

theorem finite_error_bound (R : S → S) (fixed : S) (k : ℝ) (hk : 0 ≤ k)
    (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t) (s : S) (n : Nat) :
    dist (run R n s) fixed ≤ k^n * dist s fixed := by
  induction n with
  | zero => simp [run]
  | succ n ih =>
      calc
        dist (run R (n+1) s) fixed = dist (R (run R n s)) (R fixed) := by simp [run,hfixed]
        _ ≤ k*dist (run R n s) fixed := contract _ _
        _ ≤ k*(k^n*dist s fixed) := mul_le_mul_of_nonneg_left ih hk
        _ = k^(n+1)*dist s fixed := by rw [pow_succ]; ring

/-- A genuine joint gate: sufficient paid steps AND a certified error tolerance.
    No assertion that exact convergence must precede arbitrary fuel exhaustion. -/
theorem accuracy_within_budget (R : S → S) (fixed s : S) (k diameter epsilon : ℝ)
    (hk : 0 ≤ k) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t)
    (initial : dist s fixed ≤ diameter) (steps energy cost : Nat)
    (paid : steps ≤ energy / cost) (accurate : k^steps*diameter ≤ epsilon) :
    dist (run R steps s) fixed ≤ epsilon ∧ steps*cost ≤ energy := by
  constructor
  · exact (finite_error_bound R fixed k hk hfixed contract s steps).trans
      ((mul_le_mul_of_nonneg_left initial (pow_nonneg hk _)).trans accurate)
  · exact Nat.le_trans (Nat.mul_le_mul_right cost paid) (Nat.div_mul_le_self energy cost)

/-- A computable residual certificate replaces comparison against an unknown
fixed point. The mathematical operator/metric must themselves be faithful. -/
theorem residual_error_bound (R : S → S) (fixed s : S) (k : ℝ)
    (hk : k < 1) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t) :
    dist s fixed ≤ dist s (R s)/(1-k) := by
  have triangle := dist_triangle s (R s) fixed
  have step : dist (R s) fixed ≤ k*dist s fixed := by
    simpa [hfixed] using contract s fixed
  apply (le_div_iff₀ (by linarith : 0 < 1-k)).mpr
  nlinarith

theorem residual_tolerance (R : S → S) (fixed s : S) (k epsilon : ℝ)
    (hk : k < 1) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t)
    (stop : dist s (R s) ≤ (1-k)*epsilon) :
    dist s fixed ≤ epsilon := by
  have bound := residual_error_bound R fixed s k hk hfixed contract
  have gap : 0 < 1-k := by linarith
  have divided : dist s (R s)/(1-k) ≤ epsilon := by
    apply (div_le_iff₀ gap).mpr
    simpa [mul_comm] using stop
  exact bound.trans divided

/-- Post-update form used by the received algorithm: compute the old-to-new
residual, then return R(s). This form includes k=0 without division by k. -/
theorem post_update_error_bound (R : S → S) (fixed s : S) (k : ℝ)
    (hk0 : 0 ≤ k) (hk1 : k < 1) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t) :
    dist (R s) fixed ≤ k*dist s (R s)/(1-k) := by
  have step : dist (R s) fixed ≤ k*dist s fixed := by
    simpa [hfixed] using contract s fixed
  calc dist (R s) fixed ≤ k*dist s fixed := step
    _ ≤ k*(dist s (R s)/(1-k)) :=
      mul_le_mul_of_nonneg_left (residual_error_bound R fixed s k hk1 hfixed contract) hk0
    _ = k*dist s (R s)/(1-k) := by ring

theorem post_update_tolerance (R : S → S) (fixed s : S) (k epsilon : ℝ)
    (hk0 : 0 ≤ k) (hk1 : k < 1) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t)
    (stop : k*dist s (R s) ≤ (1-k)*epsilon) :
    dist (R s) fixed ≤ epsilon := by
  apply (post_update_error_bound R fixed s k hk0 hk1 hfixed contract).trans
  apply (div_le_iff₀ (by linarith : 0 < 1-k)).mpr
  simpa [mul_comm] using stop

omit [MetricSpace S] in
theorem run_commutes (R : S → S) (s : S) (n : Nat) :
    run R n (R s) = R (run R n s) := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [run, ih]

theorem paired_trajectory_bound (R : S → S) (k : ℝ) (hk : 0 ≤ k)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t) (s t : S) (n : Nat) :
    dist (run R n s) (run R n t) ≤ k^n*dist s t := by
  induction n with
  | zero => simp [run]
  | succ n ih =>
      calc
        dist (run R (n+1) s) (run R (n+1) t) ≤
          k*dist (run R n s) (run R n t) := contract _ _
        _ ≤ k*(k^n*dist s t) := mul_le_mul_of_nonneg_left ih hk
        _ = k^(n+1)*dist s t := by rw [pow_succ]; ring

theorem residual_geometric_bound (R : S → S) (k : ℝ) (hk : 0 ≤ k)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t) (s : S) (n : Nat) :
    dist (run R n s) (R (run R n s)) ≤ k^n*dist s (R s) := by
  simpa only [run_commutes] using paired_trajectory_bound R k hk contract s (R s) n

/-- Complete finite H6 stopping certificate. The returned index is the first
positive update satisfying the residual test. It lies within the paid horizon,
and its state is epsilon-accurate. The geometric adequacy test avoids log/0 and
division by k, so zero contraction and an initially fixed state are included.
-/
theorem first_residual_stop_is_paid_and_accurate
    (R : S → S) (fixed s : S) (k epsilon energy cost : ℝ)
    (hk0 : 0 ≤ k) (hk1 : k < 1) (hfixed : R fixed = fixed)
    (contract : ∀ s t, dist (R s) (R t) ≤ k*dist s t)
    (N : Nat) (positive : 0 < N) (costPositive : 0 < cost)
    (paid : (N:ℝ)*cost ≤ energy)
    (adequate : k^N*dist s (R s) ≤ (1-k)*epsilon) :
    ∃ n : Nat, 0 < n ∧ n ≤ N ∧
      k*dist (run R (n-1) s) (R (run R (n-1) s)) ≤ (1-k)*epsilon ∧
      dist (run R n s) fixed ≤ epsilon ∧ (n:ℝ)*cost ≤ energy ∧
      (∀ m, 0 < m → m < n →
        ¬ k*dist (run R (m-1) s) (R (run R (m-1) s)) ≤ (1-k)*epsilon) := by
  classical
  let Stops : Nat → Prop := fun n =>
    k*dist (run R (n-1) s) (R (run R (n-1) s)) ≤ (1-k)*epsilon
  have finalStop : Stops N := by
    have shrink := mul_le_mul_of_nonneg_left
      (residual_geometric_bound R k hk0 contract s (N-1)) hk0
    have predecessor : N-1+1=N := by omega
    have power : k*k^(N-1)=k^N := by
      calc k*k^(N-1)=k^(N-1+1) := by rw [pow_succ]; ring
           _=k^N := by rw [predecessor]
    calc
      k*dist (run R (N-1) s) (R (run R (N-1) s)) ≤
        k*(k^(N-1)*dist s (R s)) := shrink
      _ = k^N*dist s (R s) := by rw [← mul_assoc, power]
      _ ≤ (1-k)*epsilon := adequate
  have existsStop : ∃ n, 0 < n ∧ n ≤ N ∧ Stops n := ⟨N,positive,le_rfl,finalStop⟩
  let n := Nat.find existsStop
  obtain ⟨pn,within,stop⟩ := Nat.find_spec existsStop
  refine ⟨n,pn,within,stop,?_,?_,?_⟩
  · have result := post_update_tolerance R fixed (run R (n-1) s) k epsilon
      hk0 hk1 hfixed contract stop
    have predecessor : n-1+1=n := by omega
    have next : R (run R (n-1) s)=run R n s := by
      calc R (run R (n-1) s)=run R (n-1+1) s := rfl
           _=run R n s := by rw [predecessor]
    simpa only [next] using result
  · have castBound : (n:ℝ) ≤ (N:ℝ) := by exact_mod_cast within
    exact (mul_le_mul_of_nonneg_right castBound costPositive.le).trans paid
  · intro m pm before accepted
    have smaller : m ≤ N := (Nat.le_of_lt before).trans within
    have first := Nat.find_min' existsStop ⟨pm,smaller,accepted⟩
    exact (Nat.not_le_of_gt before) first

end UPTReflectionContraction

