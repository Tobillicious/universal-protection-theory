/-
IR-14: rank-certified finite termination of descending viability calculations.
A proven strictly decreasing natural-number rank on nonfixed candidates
eliminates a free/stated fixed-point assumption within that ranked model.

The rank hypothesis is not silently discharged merely by saying the physical
system has finitely many states. Concrete rank and termination bounds still
require an implementation-level certificate.
-/
import PhysicalBridges.IRKernelConstruction
import PhysicalBridges.IRBeliefViability

namespace PhysicalBridges.IRRankTermination
universe u v w x
variable {X : Type u}

def Stable (F : (X → Prop) → X → Prop) (K : X → Prop) : Prop :=
  ∀ x, F K x ↔ K x

/-- Applying the next pruning step first, then n times more. -/
def iterate (F : (X → Prop) → X → Prop)
    (K : X → Prop) : Nat → X → Prop
  | 0 => K
  | n + 1 => iterate F (F K) n

theorem iterate_shift (F : (X → Prop) → X → Prop) :
    ∀ n (K : X → Prop), iterate F (F K) n = F (iterate F K n) := by
  intro n
  induction n with
  | zero =>
      intro K
      rfl
  | succ n ih =>
      intro K
      change iterate F (F (F K)) n = F (iterate F (F K) n)
      exact ih (F K)

/-- If a verified rank strictly decreases at every nonstable pruning
step, the exact fixed point is reached within the initial rank budget.
The proof uses strong induction, not an unbounded convergence assertion. -/
theorem decreasing_rank_forces_stabilisation
    (F : (X → Prop) → X → Prop)
    (rank : (X → Prop) → Nat)
    (decreases : ∀ K, ¬ Stable F K → rank (F K) < rank K) :
    ∀ K, ∃ k, k ≤ rank K ∧ Stable F (iterate F K k) := by
  have aux : ∀ r : Nat, ∀ K : X → Prop, rank K = r →
      ∃ k, k ≤ r ∧ Stable F (iterate F K k) := by
    intro r
    induction r using Nat.strong_induction_on with
    | h r ih =>
      intro K hRank
      by_cases hStable : Stable F K
      · refine ⟨0, Nat.zero_le r, ?_⟩
        simpa [iterate] using hStable
      · have smaller : rank (F K) < r := by
          calc
            rank (F K) < rank K := decreases K hStable
            _ = r := hRank
        obtain ⟨k, hk, hAfter⟩ :=
          ih (rank (F K)) smaller (F K) rfl
        refine ⟨k + 1, ?_, ?_⟩
        · omega
        · simpa [iterate] using hAfter
  intro K
  obtain ⟨k, hk, hs⟩ := aux (rank K) K rfl
  exact ⟨k, hk, hs⟩

/-- At rank zero, a non-stable step would require a negative rank. -/
theorem zero_rank_must_be_stable
    (F : (X → Prop) → X → Prop)
    (rank : (X → Prop) → Nat)
    (decreases : ∀ K, ¬ Stable F K → rank (F K) < rank K)
    (K : X → Prop) (zero : rank K = 0) : Stable F K := by
  by_contra hn
  have below := decreases K hn
  omega

/-- The head-first iteration is definitionally extensionally equivalent to
the preceding PR's state-kernel pruning approximations. -/
theorem iterate_state_approx
    {S : Type v} {A : Type w} {D : Type x}
    (next : S → A → D → S) (safe : S → Prop) :
    ∀ k, iterate (IRKernelConstruction.Prune next) safe k =
      IRKernelConstruction.Approx next safe k := by
  intro k
  induction k with
  | zero => rfl
  | succ k ih =>
    change iterate (IRKernelConstruction.Prune next)
      (IRKernelConstruction.Prune next safe) k =
      IRKernelConstruction.Prune next
        (IRKernelConstruction.Approx next safe k)
    rw [iterate_shift, ih]

theorem ranked_state_kernel_stabilises
    {S : Type v} {A : Type w} {D : Type x}
    (next : S → A → D → S) (safe : S → Prop)
    (rank : (S → Prop) → Nat)
    (decreases : ∀ K, ¬ Stable (IRKernelConstruction.Prune next) K →
      rank (IRKernelConstruction.Prune next K) < rank K) :
    ∃ k, k ≤ rank safe ∧
      (∀ s, IRKernelConstruction.Prune next
          (IRKernelConstruction.Approx next safe k) s ↔
        IRKernelConstruction.Approx next safe k s) := by
  obtain ⟨k, bound, hStable⟩ :=
    decreasing_rank_forces_stabilisation
      (IRKernelConstruction.Prune next) rank decreases safe
  refine ⟨k, bound, ?_⟩
  rw [iterate_state_approx next safe k] at hStable
  exact hStable

/-- The same rank certificate works on the richer belief-state lattice. -/
theorem iterate_belief_approx
    {S : Type v} {A : Type w} {D : Type x} {O : Type u}
    (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) :
    ∀ k, iterate (IRBeliefViability.Prune next observe) initial k =
      IRBeliefViability.Approx next observe initial k := by
  intro k
  induction k with
  | zero => rfl
  | succ k ih =>
    change iterate (IRBeliefViability.Prune next observe)
      (IRBeliefViability.Prune next observe initial) k =
      IRBeliefViability.Prune next observe
        (IRBeliefViability.Approx next observe initial k)
    rw [iterate_shift, ih]

theorem ranked_belief_kernel_stabilises
    {S : Type v} {A : Type w} {D : Type x} {O : Type u}
    (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop)
    (rank : ((S → Prop) → Prop) → Nat)
    (decreases : ∀ K,
      ¬ Stable (IRBeliefViability.Prune next observe) K →
      rank (IRBeliefViability.Prune next observe K) < rank K) :
    ∃ k, k ≤ rank initial ∧
      (∀ B, IRBeliefViability.Prune next observe
          (IRBeliefViability.Approx next observe initial k) B ↔
        IRBeliefViability.Approx next observe initial k B) := by
  obtain ⟨k, bound, hStable⟩ :=
    decreasing_rank_forces_stabilisation
      (IRBeliefViability.Prune next observe) rank decreases initial
  refine ⟨k, bound, ?_⟩
  rw [iterate_belief_approx next observe initial k] at hStable
  exact hStable

#print axioms decreasing_rank_forces_stabilisation
#print axioms zero_rank_must_be_stable
#print axioms iterate_state_approx
#print axioms ranked_state_kernel_stabilises
#print axioms iterate_belief_approx
#print axioms ranked_belief_kernel_stabilises
end PhysicalBridges.IRRankTermination
