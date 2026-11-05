import Snuffy.Law
import Snuffy.CommonPolicyTop

/-!
CATHEDRAL-MULTIVERSE-UNIFORMITY-01 — candidate corollary only.

No new axioms or reproofs of the imported source theorems.
This module is a new research candidate and has NOT been compiled in Lean.
Its claim is mathematical scope/greatestness, NOT physical cosmogenesis
or physical UPT installation.
-/

universe u v w

namespace Cathedral.Multiverse

variable {U : Type u} (Part : U → Type v)

/-- All indexed universes together, with their particulars retaining
    their universe tags; no inter-universe bijection is supplied. -/
def ScopeGuarantee (S : Set (Sigma Part)) : Prop :=
  ∀ (F : Set (Set (Sigma Part))) (o : Set (Sigma Part)),
    Snuffy.Law.ProjMax S F o → ¬ Snuffy.Law.NeedlessLoss₁ F o

/-- Full no-needless-existing-loss scope is required for every world,
    even if their particular domains are heterogeneous. Reuses the
    already compiled source theorem scope_guarantee_iff. -/
theorem scope_guarantee_iff_every_world_full
    (S : Set (Sigma Part)) :
    ScopeGuarantee Part S ↔
      ∀ (i : U) (p : Part i), (⟨i, p⟩ : Sigma Part) ∈ S := by
  constructor
  · intro h i p
    have hS : S = Set.univ :=
      (Snuffy.Law.scope_guarantee_iff S).mp h
    simp [hS]
  · intro h
    apply (Snuffy.Law.scope_guarantee_iff S).mpr
    apply Set.eq_univ_of_forall
    intro x
    rcases x with ⟨i, p⟩
    exact h i p

/-- The already compiled common-policy existence theorem acts on a
    dependent sum of all indexed world facts at once.
    Union-realizability is GLOBAL, not merely per-world. -/
theorem global_policy_top_from_common_source
    {Pol : Type w} [TopologicalSpace Pol] [CompactSpace Pol]
    [Nonempty Pol] (Fact : U → Type v)
    (out : Pol → Set (Sigma Fact))
    (hclosed : ∀ a, IsClosed {q | a ∈ out q})
    (hunion : ∀ q₁ q₂ : Pol, ∃ q, out q₁ ∪ out q₂ ⊆ out q) :
    ∃ q, ∀ q' : Pol, out q' ⊆ out q := by
  exact Snuffy.CommonPolicyTop.top_policy_exists out hclosed hunion

end Cathedral.Multiverse
