namespace Snuffy.MeanErgodicDeep

variable {α : Type}

/-- Cesàro average for the identity map on a type. -/
def cesaroAvgId (_n : Nat) (x : α) : α := x

/-- The Cesàro average of the identity is the identity. -/
theorem cesaro_id (_n : Nat) (x : α) : cesaroAvgId _n x = x := by
  rfl

/-- Fixed-point characterization: identity fixes every point. -/
theorem id_fixes_all (x : α) : x = x := by
  rfl

end Snuffy.MeanErgodicDeep