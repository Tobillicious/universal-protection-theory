import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Finite.Basic

namespace Snuffy.G2Singleton

universe u

variable {X : Type u}

def Coverage (R H : Set X) : Prop :=
  ∀ x : X, x ∈ R ∨ x ∈ H

def HoldingCycle (R H : Set X) : Prop :=
  ∀ x : X, x ∈ H → {x} ⊆ H ∪ R

def SingletonKeepingPolicy (_R _H : Set X) (x : X) : Set X :=
  {x}

theorem g2_discharge_hsingle
    (R H : Set X)
    (h_cov : Coverage R H)
    (_h_cycle : HoldingCycle R H) :
    ∀ x : X, ∃ (S : Set X), S = SingletonKeepingPolicy R H x ∧ (S ⊆ R ∪ H) := by
  intro x
  use {x}
  constructor
  · rfl
  · intro y hy
    rw [Set.mem_singleton_iff] at hy
    rw [hy]
    cases h_cov x with
    | inl hR =>
      left
      exact hR
    | inr hH =>
      right
      exact hH

def hsingle (R H : Set X) : Prop :=
  ∀ x : X, {x} ⊆ R ∪ H

theorem topRealisability_hsingle_discharged
    (R H : Set X)
    (h_cov : Coverage R H) :
    hsingle R H := by
  intro x y hy
  rw [Set.mem_singleton_iff] at hy
  rw [hy]
  cases h_cov x with
  | inl hR => exact Or.inl hR
  | inr hH => exact Or.inr hH

end Snuffy.G2Singleton