/- 
Snuffy — Canon Edition 4.2 working: TIWA source transition system (G1/G3).
-/

import Mathlib.Data.Set.Basic
import Mathlib.Data.Finset.Basic

namespace Snuffy.TIWASource

structure Write (Coord Val : Type*) where
  target : Coord
  value : Val
  epoch : Nat
deriving DecidableEq

structure State (Coord Val Vertex : Type*) where
  store : Coord → Val
  frozen : Finset Coord
  epoch : Nat
  inFlight : List (Write Coord Val)
  completed : Set Vertex
  tasks : Set Vertex

def readFrozen {Coord Val Vertex : Type*} (s : State Coord Val Vertex) (u : Coord) (_hu : u ∈ s.frozen) : Val := s.store u

def outerUpdate {Coord Val Vertex : Type*} [DecidableEq Coord] (s : State Coord Val Vertex) (target : Coord) (value : Val)
    (_htarget : target ∉ s.frozen) : State Coord Val Vertex :=
  { s with store := fun c => if c = target then value else s.store c }

theorem outerUpdate_read_frozen {Coord Val Vertex : Type*} [DecidableEq Coord] (s : State Coord Val Vertex) (target : Coord) (value : Val)
    (htarget : target ∉ s.frozen) (u : Coord) (hu : u ∈ s.frozen) :
    (outerUpdate s target value htarget).store u = s.store u := by
  have hne : u ≠ target := by
    intro h
    subst h
    exact htarget hu
  simp [outerUpdate, hne]

/-- An admitted write enters the in-flight set. -/
def admitWrite {Coord Val Vertex : Type*} (s : State Coord Val Vertex) (w : Write Coord Val) : State Coord Val Vertex :=
  { s with inFlight := w :: s.inFlight }

/-- A write may be resolved only when its target is outside the frozen set. -/
def resolvable {Coord Val Vertex : Type*} [DecidableEq Coord] (s : State Coord Val Vertex) (w : Write Coord Val) : Prop :=
  w.target ∉ s.frozen

/-- Resolve one in-flight write by applying it when resolvable. -/
def resolveOne {Coord Val Vertex : Type*} [DecidableEq Coord] [DecidableEq Val] (s : State Coord Val Vertex) (w : Write Coord Val) : State Coord Val Vertex :=
  if _h : w.target ∉ s.frozen then
    { s with store := fun c => if c = w.target then w.value else s.store c,
              inFlight := s.inFlight.filter (fun x => decide (x ≠ w)) }
  else
    s

/-- Freeze is allowed only after all in-flight writes have been resolved or
fenced; no admitted write may be silently ignored. -/
def readyToFreeze {Coord Val Vertex : Type*} (s : State Coord Val Vertex) : Prop :=
  s.inFlight = []

def freeze {Coord Val Vertex : Type*} [DecidableEq Coord] (s : State Coord Val Vertex) (newF : Finset Coord)
    (_hready : readyToFreeze s) : State Coord Val Vertex :=
  { s with frozen := s.frozen ∪ newF, epoch := s.epoch + 1 }

theorem freeze_monotone {Coord Val Vertex : Type*} [DecidableEq Coord] (s : State Coord Val Vertex) (newF : Finset Coord)
    (hready : readyToFreeze s) :
    s.frozen ⊆ (freeze s newF hready).frozen := by
  intro u hu
  simp [freeze]
  exact Or.inl hu

def maySchedule {Coord Val Vertex : Type*} (s : State Coord Val Vertex) (v : Vertex) : Prop :=
  v ∉ s.completed

def schedule {Coord Val Vertex : Type*} (s : State Coord Val Vertex) (v : Vertex) (_hv : maySchedule s v) : State Coord Val Vertex :=
  { s with tasks := s.tasks ∪ {v} }

theorem schedule_no_rework {Coord Val Vertex : Type*} (s : State Coord Val Vertex) (v : Vertex) (hv : maySchedule s v) :
    v ∉ s.completed := hv

def guardThicknessOk (thickness interactionRadius : Nat) : Prop :=
  thickness ≥ interactionRadius

/-- If a state is ready to freeze, it has no unresolved in-flight writes. -/
theorem readyToFreeze_no_inFlight {Coord Val Vertex : Type*} (s : State Coord Val Vertex)
    (h : readyToFreeze s) : s.inFlight = [] := h

end Snuffy.TIWASource