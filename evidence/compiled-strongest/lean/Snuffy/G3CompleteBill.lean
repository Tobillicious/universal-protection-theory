import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Ring

namespace Snuffy.G3CompleteBill

structure WorkBill where
  timeSteps : Nat
  waveCount : Nat
  dimensionalFactor : Nat
  allocatedWork : Nat
  scalingConstant : Nat
  tiwaSuccess : Bool
  isBoundaryClosed : Bool
  decoderSuccess : Bool
  deriving Repr, DecidableEq

def G3_ValidWorkBill (bill : WorkBill) : Prop :=
  bill.tiwaSuccess = true →
  bill.allocatedWork <= bill.scalingConstant * (bill.waveCount ^ bill.dimensionalFactor)

abbrev WorkBillSequence := List WorkBill

def G3_SequenceValid (seq : WorkBillSequence) : Prop :=
  ∀ bill ∈ seq, G3_ValidWorkBill bill

theorem g3_success_implies_bound (bill : WorkBill) (h : G3_ValidWorkBill bill)
    (h_success : bill.tiwaSuccess = true) :
    bill.allocatedWork <= bill.scalingConstant * (bill.waveCount ^ bill.dimensionalFactor) := by
  exact h h_success

theorem g3_compose_valid (seq : WorkBillSequence) (bill : WorkBill)
    (h_seq : G3_SequenceValid seq)
    (h_bill : G3_ValidWorkBill bill) :
    G3_SequenceValid (seq ++ [bill]) := by
  intro x hx
  rw [List.mem_append, List.mem_singleton] at hx
  rcases hx with h_in | h_eq
  · exact h_seq x h_in
  · subst h_eq
    exact h_bill

theorem g3_wave_count_nonnegative (bill : WorkBill) :
    bill.waveCount >= 0 := by
  exact Nat.zero_le bill.waveCount

/-- Complete wave charge, including fixed endpoints and an explicitly metered
local rollback. Routine measurement/reset, holding, controller, guard, routing,
verification and deployment costs belong in `cost`; rollback is additional.
The controller performs at most the one metered rollback represented by each
flag. This is a pathwise work bill, not an expected-work discount. -/
def cumulativeCharge (cost : Nat → Nat) (rollback : Nat → Bool)
    (reset fixed horizon : Nat) : Nat :=
  fixed + (Finset.range horizon).sum
    (fun k => cost (k + 1) + if rollback k then reset else 0)

/-- The supplied per-wave complete charge gives an explicit age-independent
polynomial coefficient. A rollback on every wave still fits the work bound.
The source must supply the full local charge bound and the metered schedule;
this theorem does not assume the desired cumulative upper bound. -/
theorem cumulative_charge_bound (cost : Nat → Nat) (rollback : Nat → Bool)
    (reset fixed α β horizon d : Nat) (hh : 1 ≤ horizon) (hd : 1 ≤ d)
    (hcost : ∀ k ∈ Finset.range horizon,
      cost (k + 1) ≤ α * (k + 1) ^ (d - 1) + β) :
    cumulativeCharge cost rollback reset fixed horizon ≤
      (fixed + α + β + reset) * horizon ^ d := by
  have hexp : horizon * horizon ^ (d - 1) = horizon ^ d := by
    rw [← pow_succ', Nat.sub_add_cancel hd]
  have hlinear : horizon ≤ horizon ^ d :=
    le_self_pow₀ hh (Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one hd))
  have hfixed : fixed ≤ fixed * horizon ^ d := by
    simpa using Nat.mul_le_mul_left fixed (one_le_pow₀ hh : 1 ≤ horizon ^ d)
  have hstep : ∀ k ∈ Finset.range horizon,
      cost (k + 1) + (if rollback k then reset else 0) ≤
        α * horizon ^ (d - 1) + (β + reset) := by
    intro k hk
    have hk' : k + 1 ≤ horizon := Nat.succ_le_of_lt (Finset.mem_range.mp hk)
    have hp : (k + 1) ^ (d - 1) ≤ horizon ^ (d - 1) :=
      pow_le_pow_left' hk' (d - 1)
    have hr : (if rollback k then reset else 0) ≤ reset := by
      split <;> simp
    calc
      cost (k + 1) + (if rollback k then reset else 0)
          ≤ (α * (k + 1) ^ (d - 1) + β) + reset :=
        Nat.add_le_add (hcost k hk) hr
      _ ≤ (α * horizon ^ (d - 1) + β) + reset :=
        Nat.add_le_add_right (Nat.add_le_add_right (Nat.mul_le_mul_left α hp) β) reset
      _ = α * horizon ^ (d - 1) + (β + reset) := by ring
  have hsum :
      (Finset.range horizon).sum
          (fun k => cost (k + 1) + if rollback k then reset else 0) ≤
        horizon * (α * horizon ^ (d - 1) + (β + reset)) := by
    calc
      _ ≤ (Finset.range horizon).sum
          (fun _ => α * horizon ^ (d - 1) + (β + reset)) :=
        Finset.sum_le_sum hstep
      _ = _ := by simp
  have hproduct :
      horizon * (α * horizon ^ (d - 1) + (β + reset)) =
        α * horizon ^ d + (β + reset) * horizon := by
    calc
      _ = α * (horizon * horizon ^ (d - 1)) + (β + reset) * horizon := by ring
      _ = _ := by rw [hexp]
  unfold cumulativeCharge
  calc
    _ ≤ fixed + horizon * (α * horizon ^ (d - 1) + (β + reset)) :=
      Nat.add_le_add_left hsum fixed
    _ = fixed + α * horizon ^ d + (β + reset) * horizon := by
      rw [hproduct, Nat.add_assoc]
    _ ≤ fixed * horizon ^ d + α * horizon ^ d + (β + reset) * horizon ^ d :=
      Nat.add_le_add (Nat.add_le_add_right hfixed _)
        (Nat.mul_le_mul_left (β + reset) hlinear)
    _ = (fixed + α + β + reset) * horizon ^ d := by ring

/-- Populate the existing bill predicate from the complete metered ledger and
the local wave bounds. `G3_ValidWorkBill` is the conclusion, not an input. -/
theorem valid_work_bill_from_complete_ledger (bill : WorkBill)
    (cost : Nat → Nat) (rollback : Nat → Bool) (reset fixed α β : Nat)
    (hh : 1 ≤ bill.waveCount) (hd : 1 ≤ bill.dimensionalFactor)
    (hledger : bill.allocatedWork =
      cumulativeCharge cost rollback reset fixed bill.waveCount)
    (hcost : ∀ k ∈ Finset.range bill.waveCount,
      cost (k + 1) ≤ α * (k + 1) ^ (bill.dimensionalFactor - 1) + β)
    (hscale : fixed + α + β + reset ≤ bill.scalingConstant) :
    G3_ValidWorkBill bill := by
  intro _
  rw [hledger]
  exact (cumulative_charge_bound cost rollback reset fixed α β bill.waveCount
    bill.dimensionalFactor hh hd hcost).trans
      (Nat.mul_le_mul_right (bill.waveCount ^ bill.dimensionalFactor) hscale)

/-- Translate a valid wave-count bill to unattended age using the constructed
linear wave schedule. The new coefficient is independent of age. -/
theorem valid_bill_bound_in_age (bill : WorkBill) (a b : Nat)
    (hvalid : G3_ValidWorkBill bill) (hsuccess : bill.tiwaSuccess = true)
    (hage : 1 ≤ bill.timeSteps) (hwaves : bill.waveCount ≤ a * bill.timeSteps + b) :
    bill.allocatedWork ≤
      (bill.scalingConstant * (a + b) ^ bill.dimensionalFactor) *
        bill.timeSteps ^ bill.dimensionalFactor := by
  have hb : b ≤ b * bill.timeSteps := by
    simpa using Nat.mul_le_mul_left b hage
  have hn : bill.waveCount ≤ (a + b) * bill.timeSteps := by
    calc
      _ ≤ a * bill.timeSteps + b := hwaves
      _ ≤ a * bill.timeSteps + b * bill.timeSteps := Nat.add_le_add_left hb _
      _ = (a + b) * bill.timeSteps := by ring
  calc
    _ ≤ bill.scalingConstant * bill.waveCount ^ bill.dimensionalFactor :=
      hvalid hsuccess
    _ ≤ bill.scalingConstant * ((a + b) * bill.timeSteps) ^ bill.dimensionalFactor :=
      Nat.mul_le_mul_left _ (pow_le_pow_left' hn bill.dimensionalFactor)
    _ = _ := by rw [mul_pow]; ring

end Snuffy.G3CompleteBill
