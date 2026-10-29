/- 
Snuffy — Canon Edition 4.2 working: TIWA recovery schedule (G3).
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Snuffy.TIWARecovery

/-- Each vertex is visited at most `V` times. -/
theorem bounded_visits {Vertex : Type*} [DecidableEq Vertex] (processed : Finset Vertex)
    (visits : Vertex → Nat) (V : Nat) (hvisits : ∀ v ∈ processed, visits v ≤ V) :
    processed.sum visits ≤ V * processed.card := by
  calc
    processed.sum visits ≤ processed.card • V := Finset.sum_le_card_nsmul processed visits V hvisits
    _ = processed.card * V := Nat.nsmul_eq_mul processed.card V
    _ = V * processed.card := Nat.mul_comm processed.card V

/-- A linear wave count bound: `N(t) ≤ a t + b`. -/
def BoundedWaves (N : Nat → Nat) (a b : Nat) : Prop :=
  ∀ t, N t ≤ a * t + b

/-- From a wave count bound, the number of waves at time `t` is at most
`a t + b`. -/
theorem wave_count_at (N : Nat → Nat) (a b t : Nat) (h : BoundedWaves N a b) :
    N t ≤ a * t + b := h t

end Snuffy.TIWARecovery