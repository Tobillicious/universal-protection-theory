import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Algebra.Group.Subgroup.Basic

/-!
A precise group-theoretic version of the admissible invariant group.

Aut is supplied as a subgroup of permutations already proved to preserve
the relevant state-space structure. A bare equivalence S ≃ S does not by
itself preserve a metric, operational signature, or nonlinear dynamics.
This theorem covers any such separately certified Aut, including nonlinear
structure-preserving bijections. It is not Complete Koru's definition.
-/

namespace PhysicalBridges

universe u
variable {S : Type u}

/-- Bijective transformations fixing the designated point G. -/
def GuardianStabilizer (G : S) : Subgroup (Equiv.Perm S) where
  carrier := { f | f G = G }
  one_mem' := rfl
  mul_mem' := by
    intro a b ha hb
    change (a * b) G = G
    simpa only [Equiv.Perm.mul_apply, hb, ha]
  inv_mem' := by
    intro a ha
    change a⁻¹ G = G
    apply a.injective
    simpa [ha]

/-- Structure-preserving automorphisms which also fix G. -/
def AdmissibleGroup (G : S) (Aut : Subgroup (Equiv.Perm S)) :
    Subgroup (Equiv.Perm S) :=
  GuardianStabilizer G ⊓ Aut

theorem mem_admissibleGroup (G : S) (Aut : Subgroup (Equiv.Perm S))
    (f : Equiv.Perm S) :
    f ∈ AdmissibleGroup G Aut ↔ f G = G ∧ f ∈ Aut := by
  rfl

end PhysicalBridges
