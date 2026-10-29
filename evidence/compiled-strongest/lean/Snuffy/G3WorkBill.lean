namespace Snuffy.G3WorkBill

structure WorkBill where
  timeSteps : Nat
  dimensionalFactor : Nat
  allocatedWork : Nat
  maxAllowedWork : Nat
  tiwaSuccess : Bool
  deriving Repr, DecidableEq

def G3_ValidWorkBill (bill : WorkBill) (scalingConstant : Nat) : Prop :=
  bill.tiwaSuccess = true →
  bill.allocatedWork <= scalingConstant * (bill.timeSteps ^ bill.dimensionalFactor)

abbrev WorkBillSequence := List WorkBill

def G3_SequenceValid (seq : WorkBillSequence) (scalingConstant : Nat) : Prop :=
  ∀ bill ∈ seq, G3_ValidWorkBill bill scalingConstant

theorem g3_append_work_bill (seq : WorkBillSequence) (bill : WorkBill) (scalingConstant : Nat)
    (h_seq : G3_SequenceValid seq scalingConstant)
    (h_bill : G3_ValidWorkBill bill scalingConstant) :
    G3_SequenceValid (seq ++ [bill]) scalingConstant := by
  intro x hx
  rw [List.mem_append, List.mem_singleton] at hx
  rcases hx with h_in | h_eq
  · exact h_seq x h_in
  · subst h_eq
    exact h_bill

end Snuffy.G3WorkBill
