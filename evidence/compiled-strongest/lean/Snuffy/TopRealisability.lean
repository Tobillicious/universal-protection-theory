/- 
Snuffy — Canon Edition 4.2 working: realisability of the whole greatest outcome (G2).
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic

namespace Snuffy.TopRealisability

variable {Part : Type} [DecidableEq Part] [Fintype Part] {Policy : Type}

/-- A policy keeps a set of particulars when it keeps each of them. -/
def KeepsSet (keeps : Policy → Part → Prop) (π : Policy) (S : Finset Part) : Prop :=
  ∀ x ∈ S, keeps π x

/-- Realisability is union-closed when two realisable policies can be combined
into a policy realising the union of the particulars they keep. -/
def UnionClosed (keeps : Policy → Part → Prop) (R : Set Policy) : Prop :=
  ∀ π ∈ R, ∀ σ ∈ R, ∃ τ ∈ R, ∀ x, keeps τ x ↔ keeps π x ∨ keeps σ x

/-- If the empty outcome is realisable and every singleton particular is
realisable, and realisability is union-closed, then the top outcome (every
particular) is realisable. -/
theorem top_realisable_of_singletons [Nonempty Part] (keeps : Policy → Part → Prop) (R : Set Policy)
    (hempty : ∃ π ∈ R, ∀ x, ¬ keeps π x)
    (hsingle : ∀ x : Part, ∃ π ∈ R, keeps π x)
    (hunion : UnionClosed keeps R) :
    ∃ π ∈ R, ∀ x : Part, keeps π x := by
  classical
  have huniv : ∃ π ∈ R, ∀ x ∈ (Finset.univ : Finset Part), keeps π x := by
    induction (Finset.univ : Finset Part) using Finset.induction_on with
    | empty =>
        obtain ⟨π0, hπ0R, _⟩ := hempty
        refine ⟨π0, hπ0R, ?_⟩
        intro x hx
        exact False.elim (by simp at hx)
    | insert a s ha ih =>
        obtain ⟨πs, hπsR, hπs⟩ := ih
        obtain ⟨πa, hπaR, hπa⟩ := hsingle a
        obtain ⟨τ, hτR, hτ⟩ := hunion πs hπsR πa hπaR
        refine ⟨τ, hτR, ?_⟩
        intro x hx
        rcases Finset.mem_insert.mp hx with rfl | hs
        · exact (hτ x).mpr (Or.inr hπa)
        · exact (hτ x).mpr (Or.inl (hπs x hs))
  obtain ⟨π, hπR, hπ⟩ := huniv
  exact ⟨π, hπR, fun x => hπ x (Finset.mem_univ x)⟩

end Snuffy.TopRealisability