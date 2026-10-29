import Mathlib.Order.Defs.Lattice
import Mathlib.Order.BoundedOrder.Basic

namespace Snuffy.Htopkeeps

structure BoundaryEval (L : Type*) [Lattice L] [BoundedOrder L] where
  eval : L → L
  monotone : ∀ x y, x ≤ y → eval x ≤ eval y
  unital : eval ⊤ = ⊤

theorem htopkeeps {L : Type*} [Lattice L] [BoundedOrder L] (E : BoundaryEval L) :
    E.eval ⊤ = ⊤ :=
  E.unital

end Snuffy.Htopkeeps
