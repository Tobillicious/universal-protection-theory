/-!
A Mathlib-free, group-level closure construction for G-admissible state
automorphisms. The real structure-preservation predicate must be supplied
and certified independently. An arbitrary bijection is not by itself a
metric, operational-signature or nonlinear-dynamics automorphism.

This is a theorem about a specified state type and its admissible maps,
not a definition of Complete Koru or an assertion about the entire universe.
-/

namespace PhysicalBridges

universe u

/-- An explicitly invertible state transformation. -/
structure StateAut (S : Type u) where
  toFun : S → S
  invFun : S → S
  left_inverse : ∀ x, invFun (toFun x) = x
  right_inverse : ∀ x, toFun (invFun x) = x

namespace StateAut

variable {S : Type u}

def id (S : Type u) : StateAut S where
  toFun := fun x => x
  invFun := fun x => x
  left_inverse := by intro x; rfl
  right_inverse := by intro x; rfl

def comp (a b : StateAut S) : StateAut S where
  toFun := fun x => a.toFun (b.toFun x)
  invFun := fun x => b.invFun (a.invFun x)
  left_inverse := by
    intro x
    rw [a.left_inverse, b.left_inverse]
  right_inverse := by
    intro x
    rw [b.right_inverse, a.right_inverse]

def inv (a : StateAut S) : StateAut S where
  toFun := a.invFun
  invFun := a.toFun
  left_inverse := a.right_inverse
  right_inverse := a.left_inverse

end StateAut

/-- The structure-preserving automorphism class, including closure under
identity, composition and inverse. Its concrete signature/metric invariance
must be proven by the caller rather than inferred from bijectivity. -/
structure AutomorphismClass (S : Type u) where
  preserves : StateAut S → Prop
  id_mem : preserves (StateAut.id S)
  comp_mem : ∀ a b, preserves a → preserves b → preserves (StateAut.comp a b)
  inv_mem : ∀ a, preserves a → preserves (StateAut.inv a)

variable {S : Type u}

/-- Stabilizer of a designated state G. -/
def GuardianStabilizer (G : S) (f : StateAut S) : Prop :=
  f.toFun G = G

/-- The logical intersection Stab(G) ∩ Aut(S). -/
def G_admissible (G : S) (Aut : AutomorphismClass S) (f : StateAut S) : Prop :=
  GuardianStabilizer G f ∧ Aut.preserves f

theorem admissible_iff_stabilizer_inter_aut
    (G : S) (Aut : AutomorphismClass S) (f : StateAut S) :
    G_admissible G Aut f ↔ GuardianStabilizer G f ∧ Aut.preserves f :=
  Iff.rfl

theorem admissible_identity (G : S) (Aut : AutomorphismClass S) :
    G_admissible G Aut (StateAut.id S) := by
  exact ⟨rfl, Aut.id_mem⟩

theorem admissible_comp (G : S) (Aut : AutomorphismClass S)
    (a b : StateAut S) (ha : G_admissible G Aut a)
    (hb : G_admissible G Aut b) :
    G_admissible G Aut (StateAut.comp a b) := by
  constructor
  · change a.toFun (b.toFun G) = G
    rw [hb.1, ha.1]
  · exact Aut.comp_mem a b ha.2 hb.2

theorem admissible_inv (G : S) (Aut : AutomorphismClass S)
    (a : StateAut S) (ha : G_admissible G Aut a) :
    G_admissible G Aut (StateAut.inv a) := by
  constructor
  · change a.invFun G = G
    calc
      a.invFun G = a.invFun (a.toFun G) := by rw [ha.1]
      _ = G := a.left_inverse G
  · exact Aut.inv_mem a ha.2

end PhysicalBridges
