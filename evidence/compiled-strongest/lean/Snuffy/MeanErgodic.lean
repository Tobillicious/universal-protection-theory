namespace Snuffy.MeanErgodic

variable {α : Type}

/-- Cesàro mean for the identity map. -/
def cesaroMeanId (_n : Nat) (x : α) : α := x

/-- The Cesàro mean of the identity is the identity. -/
theorem cesaro_mean_id (_n : Nat) (x : α) : cesaroMeanId _n x = x := by
  rfl

end Snuffy.MeanErgodic