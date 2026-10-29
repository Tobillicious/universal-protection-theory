import Mathlib.Order.BoundedOrder.Basic

namespace Snuffy.GuardSignature

structure Guard (M : Type*) [PartialOrder M] [Bot M] where
  pi : M → M
  idempotent : ∀ x, pi (pi x) = pi x
  monotone : ∀ x y, x ≤ y → pi x ≤ pi y

theorem guard_idempotent {M : Type*} [PartialOrder M] [Bot M] (g : Guard M) (x : M) :
    g.pi (g.pi x) = g.pi x :=
  g.idempotent x

end Snuffy.GuardSignature
