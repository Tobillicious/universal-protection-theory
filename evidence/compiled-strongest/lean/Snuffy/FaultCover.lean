import Mathlib.Data.Set.Basic
import Mathlib.Data.Finset.Basic

namespace Snuffy.FaultCover

variable {Ω : Type}

theorem fault_cover {G : Set Ω} {E : Fin 21 → Set Ω}
    (hcover : ∀ ω, ω ∉ G → ∃ i, ω ∈ E i) :
    Set.compl G ⊆ {ω : Ω | ∃ i : Fin 21, ω ∈ E i} := by
  intro ω hω
  rcases hcover ω hω with ⟨i, hi⟩
  exact ⟨i, hi⟩

end Snuffy.FaultCover