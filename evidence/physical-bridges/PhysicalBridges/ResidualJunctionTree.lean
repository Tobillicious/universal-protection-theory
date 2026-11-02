import Std

/-!
BDL RESIDUAL JUNCTION-TREE INTERFACE (2026-11-03)

Exact finite binary elimination and a CONDITIONAL bag-cost theorem.
No theorem here asserts that RCM supplies an O(L) elimination order for
the BDL residual Fourier-dual graph. The unresolved 2c are independent
parity-check coefficients, not automatically physical syndrome bits.
-/
namespace PhysicalBridges.ResidualJunctionTree

/-- All binary assignments of length n, including both branches. -/
def assignments : Nat → List (List Bool)
  | 0 => [[]]
  | n + 1 =>
      ((assignments n).map (fun xs => false :: xs)) ++
      ((assignments n).map (fun xs => true :: xs))

/-- Exactly normalized finite partition sum for rational weights. -/
def partition (n : Nat) (weight : List Bool → Rat) : Rat :=
  ((assignments n).map weight).sum

/-- Exact one-variable elimination; no independence or approximation. -/
theorem partition_split (n : Nat) (weight : List Bool → Rat) :
    partition (n + 1) weight =
      partition n (fun xs => weight (false :: xs)) +
      partition n (fun xs => weight (true :: xs)) := by
  simp [partition, assignments, List.map_append, List.map_map,
    List.sum_append, Function.comp_def]

/-- Pull a factor that does not depend on the eliminated bit outside
the sum. This is the basic sum-product bucket-elimination step. -/
def sumBool (f : Bool → Rat) : Rat := f false + f true

theorem eliminate_independent (a : Rat) (f : Bool → Rat) :
    sumBool (fun b => a * f b) = a * sumBool f := by
  simp [sumBool, mul_add]

/-- The operation count for one Boolean table of k variables is 2^k.
This applies only when a verified elimination certificate bounds k. -/
theorem table_entries_bounded (k width : Nat) (hk : k ≤ width + 1) :
    2 ^ k ≤ 2 ^ (width + 1) := by
  exact Nat.pow_le_pow_right (by decide) hk

/-- Sum of all bag-table sizes, conditional on a bound for EVERY bag.
The factor count and arithmetic bit cost are NOT hidden in this bound. -/
theorem total_table_entries_bounded (width : Nat) (bags : List Nat)
    (h : ∀ k, k ∈ bags → k ≤ width + 1) :
    ((bags.map (fun k => 2 ^ k)).sum) ≤
      bags.length * 2 ^ (width + 1) := by
  induction bags with
  | nil => simp
  | cons k ks ih =>
      have hk : k ≤ width + 1 := h k (by simp)
      have hks : ∀ j, j ∈ ks → j ≤ width + 1 := by
        intro j hj
        exact h j (by simp [hj])
      have hpow := table_entries_bounded k width hk
      have hrest := ih hks
      calc
        ((k :: ks).map (fun j => 2 ^ j)).sum
            = 2 ^ k + ((ks.map (fun j => 2 ^ j)).sum) := by simp
        _ ≤ 2 ^ (width + 1) + ks.length * 2 ^ (width + 1) :=
          Nat.add_le_add hpow hrest
        _ = (k :: ks).length * 2 ^ (width + 1) := by
          simp [Nat.succ_mul, Nat.add_comm]

#print axioms partition_split
#print axioms eliminate_independent
#print axioms table_entries_bounded
#print axioms total_table_entries_bounded

end PhysicalBridges.ResidualJunctionTree
