namespace Snuffy.GuardOperator

structure GuardOperator (S : Type) where
  validProjection : S → S
  faultPenalty : S → S
  threshold : Nat

def guardAction {S : Type} (g : GuardOperator S) (signal : Nat) (psi : S) : S :=
  if signal <= g.threshold then
    g.validProjection psi
  else
    g.faultPenalty psi

theorem guard_within_tolerance {S : Type} (g : GuardOperator S) (signal : Nat) (psi : S)
    (h : signal <= g.threshold) :
    guardAction g signal psi = g.validProjection psi := by
  unfold guardAction
  simp [h]

theorem guard_exceeds_tolerance {S : Type} (g : GuardOperator S) (signal : Nat) (psi : S)
    (h : signal > g.threshold) :
    guardAction g signal psi = g.faultPenalty psi := by
  unfold guardAction
  have h' : ¬(signal <= g.threshold) := Nat.not_le.mpr h
  simp [h']

end Snuffy.GuardOperator