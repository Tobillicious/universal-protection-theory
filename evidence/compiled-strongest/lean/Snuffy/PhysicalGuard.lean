namespace Snuffy.PhysicalGuard

variable {X Y : Type}

/-- A factorized evolution on a product space. -/
def factorized (f : X → X) (g : Y → Y) : X × Y → X × Y :=
  fun p => (f p.1, g p.2)

/-- Factorization is definitional for product maps. -/
theorem factorization (f : X → X) (g : Y → Y) (x : X) (y : Y) :
    factorized f g (x, y) = (f x, g y) := by
  rfl

/-- The interior component is unchanged by the outer map. -/
theorem interior_unchanged (f : X → X) (g : Y → Y) (x : X) (y : Y) :
    (factorized f g (x, y)).1 = f x := by
  rfl

end Snuffy.PhysicalGuard