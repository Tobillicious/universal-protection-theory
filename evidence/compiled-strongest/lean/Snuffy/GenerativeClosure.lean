import Mathlib.Data.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-! Gemini H5, the holding-closure target, and bootstrap migration:
reserve before activation, preserve all existing reservations, and attenuate
delegated capabilities. The transition rules specify a concrete admission
machine. Its connection to every physical activation is an implementation join.
-/
namespace UPTGenerativeClosure
open scoped BigOperators

structure Allocation (Id : Type) where
  funded : Finset Id
  active : Finset Id

def Valid {Id : Type} [DecidableEq Id] (cost : Id → Nat) (capacity : Nat)
    (s : Allocation Id) : Prop :=
  (∑ i ∈ s.funded, cost i) ≤ capacity ∧ s.active ⊆ s.funded

inductive Step {Id : Type} [DecidableEq Id] (cost : Id → Nat) (capacity : Nat) :
    Allocation Id → Allocation Id → Prop
  | reserve (s : Allocation Id) (child : Id) (fresh : child ∉ s.funded)
      (paid : cost child + (∑ i ∈ s.funded, cost i) ≤ capacity) :
      Step cost capacity s ⟨insert child s.funded, s.active⟩
  | activate (s : Allocation Id) (child : Id) (paid : child ∈ s.funded) :
      Step cost capacity s ⟨s.funded, insert child s.active⟩
  | retire (s : Allocation Id) (child : Id) :
      Step cost capacity s ⟨s.funded, s.active.erase child⟩
  | release (s : Allocation Id) (child : Id) (inactive : child ∉ s.active) :
      Step cost capacity s ⟨s.funded.erase child, s.active⟩

theorem step_preserves_paid_activation {Id : Type} [DecidableEq Id]
    (cost : Id → Nat) (capacity : Nat) {s t : Allocation Id}
    (valid : Valid cost capacity s) (step : Step cost capacity s t) :
    Valid cost capacity t := by
  rcases valid with ⟨budget, coverage⟩
  cases step with
  | reserve child fresh paid =>
      constructor
      · simpa [Finset.sum_insert fresh] using paid
      · exact coverage.trans (Finset.subset_insert _ _)
  | activate child paid =>
      exact ⟨budget, Finset.insert_subset paid coverage⟩
  | retire child =>
      exact ⟨budget, (Finset.erase_subset _ _).trans coverage⟩
  | release child inactive =>
      constructor
      · exact (Finset.sum_le_sum_of_subset_of_nonneg (Finset.erase_subset _ _)
          (fun _ _ _ => Nat.zero_le _)).trans budget
      · intro i live
        exact Finset.mem_erase.mpr ⟨by intro eq; subst i; exact inactive live, coverage live⟩

inductive Trace {Id : Type} [DecidableEq Id] (cost : Id → Nat) (capacity : Nat) :
    Allocation Id → Allocation Id → Prop
  | initial (s) : Trace cost capacity s s
  | next {s t u} : Trace cost capacity s t → Step cost capacity t u → Trace cost capacity s u

theorem every_generated_active_is_funded {Id : Type} [DecidableEq Id]
    (cost : Id → Nat) (capacity : Nat) {s t : Allocation Id}
    (initial : Valid cost capacity s) (trace : Trace cost capacity s t) :
    Valid cost capacity t := by
  induction trace with
  | initial => exact initial
  | next prior step ih => exact step_preserves_paid_activation cost capacity ih step

theorem reserve_does_not_displace_existing_agents {Id : Type} [DecidableEq Id]
    (s : Allocation Id) (child : Id) :
    s.active = (Allocation.mk (insert child s.funded) s.active).active := rfl

/-- A delegation chain is generated only by authority-attenuating grants. -/
inductive Delegated {Id Effect : Type} [DecidableEq Effect]
    (rights : Id → Finset Effect) : Id → Id → Prop
  | self (root : Id) : Delegated rights root root
  | grant {root parent child : Id} : Delegated rights root parent →
      rights child ⊆ rights parent → Delegated rights root child

theorem generated_authority_stays_within_root {Id Effect : Type} [DecidableEq Effect]
    (rights : Id → Finset Effect) {root child : Id}
    (chain : Delegated rights root child) : rights child ⊆ rights root := by
  induction chain with
  | self => exact Finset.Subset.refl _
  | grant parent attenuated ih => exact attenuated.trans ih

end UPTGenerativeClosure

