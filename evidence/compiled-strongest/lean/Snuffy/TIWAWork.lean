/- 
Snuffy — Canon Edition 4.2 working: TIWA work accounting (G3).
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Snuffy.TIWAWork

theorem local_work_bound {Vertex : Type*} [DecidableEq Vertex] (processed : Finset Vertex)
    (work : Vertex → Nat) (K : Nat) (hcost : ∀ v ∈ processed, work v ≤ K) :
    processed.sum work ≤ K * processed.card := by
  calc
    processed.sum work ≤ processed.card • K := Finset.sum_le_card_nsmul processed work K hcost
    _ = processed.card * K := Nat.nsmul_eq_mul processed.card K
    _ = K * processed.card := Nat.mul_comm processed.card K

theorem ball_work_bound {Vertex : Type*} [DecidableEq Vertex] (processed : Finset Vertex)
    (work : Vertex → Nat) (K ballSize : Nat)
    (hcost : ∀ v ∈ processed, work v ≤ K)
    (hcount : processed.card ≤ ballSize) :
    processed.sum work ≤ K * ballSize := by
  calc
    processed.sum work ≤ K * processed.card := local_work_bound processed work K hcost
    _ ≤ K * ballSize := Nat.mul_le_mul_left K hcount

theorem total_work_bound (localWork rest K ballSize : Nat)
    (hlocal : localWork ≤ K * ballSize) :
    localWork + rest ≤ K * ballSize + rest := by
  exact Nat.add_le_add_right hlocal rest

end Snuffy.TIWAWork