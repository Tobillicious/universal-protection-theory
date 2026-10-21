import Std

def survivor (a e : Bool) : Nat := if a && !e then 1 else 0

-- Omitting the erasure shift is false, already for one success removed.
example : ∀ a e : Bool, (if a then 1 else 0) ≤ survivor a e := by decide
