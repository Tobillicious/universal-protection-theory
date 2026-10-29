/- 
Snuffy — Canon Edition 4.2 working: TIWA guard construction (G1/G3).
-/

import Snuffy.TIWASource

namespace Snuffy.TIWAGuard

open Snuffy.TIWASource

/-- A guard installation records its thickness, installed boundary data, and
reserved cost. -/
structure Guard (Coord : Type*) where
  thickness : Nat
  boundary : Set Coord
  reservedCost : Nat

/-- A state extended with guards. -/
structure GuardedState (Coord Val Vertex : Type*) where
  base : State Coord Val Vertex
  guards : List (Guard Coord)

/-- Outer activity never modifies installed guard data. -/
theorem guard_data_frame {Coord Val Vertex : Type*} [DecidableEq Coord] (s : GuardedState Coord Val Vertex)
    (target : Coord) (value : Val) (htarget : target ∉ s.base.frozen) :
    (GuardedState.mk (TIWASource.outerUpdate s.base target value htarget) s.guards).guards = s.guards := by
  rfl

/-- Guard installation only adds a guard; it never removes an existing one. -/
def installGuard {Coord Val Vertex : Type*} (s : GuardedState Coord Val Vertex) (g : Guard Coord) :
    GuardedState Coord Val Vertex :=
  { s with guards := s.guards ++ [g] }

theorem installGuard_monotone {Coord Val Vertex : Type*} (s : GuardedState Coord Val Vertex) (g : Guard Coord) :
    ∀ x, x ∈ s.guards → x ∈ (installGuard s g).guards := by
  intro x hx
  exact List.mem_append_left [g] hx

/-- Guard thickness must be at least the interaction radius. -/
def thicknessOk (g : Guard Coord) (interactionRadius : Nat) : Prop :=
  g.thickness ≥ interactionRadius

end Snuffy.TIWAGuard