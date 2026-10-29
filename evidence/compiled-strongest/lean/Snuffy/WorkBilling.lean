import Snuffy.ThermoLedger
import Snuffy.QuantumLandauer

open scoped ComplexOrder

namespace Snuffy.WorkBilling

structure WorkBill where
  timeSteps : Nat
  allocatedWork : Nat
  scalingConstant : Nat
  dimFactor : Nat

def workBound (bill : WorkBill) : Prop :=
  bill.allocatedWork <= bill.scalingConstant * (bill.timeSteps ^ bill.dimFactor)

def workAdditive (w1 w2 : Nat) : Nat := w1 + w2

theorem work_nonnegative (w : Nat) : w >= 0 := Nat.zero_le w

theorem work_bound_preserved (bill : WorkBill) (h : workBound bill) :
    workBound bill := h

/-- At a fixed Hamiltonian and Gibbs reference, the complete first-law
ledger gives beta*work = relative-free-energy change + entropy production.
Historical degrees of freedom are included in U and S. -/
theorem decoder_work_balance {β lnZ S₁ S₂ U₁ U₂ W Q : ℝ}
    (hfirst : U₂ - U₁ = W - Q) :
    β * W =
      ((-S₂ + β * U₂ + lnZ) - (-S₁ + β * U₁ + lnZ)) +
      (S₂ - S₁ + β * Q) := by
  have h := Snuffy.ThermoLedger.stroke_identity
    (β := β) (lnZ := lnZ) (I₁ := S₁) (I₂ := S₂) hfirst rfl
  linarith

/-- The work floor uses output minus input relative free energy. -/
theorem decoder_work_floor {β lnZ S₁ S₂ U₁ U₂ W Q : ℝ}
    (hβ : 0 < β) (hfirst : U₂ - U₁ = W - Q)
    (hsecond : 0 ≤ S₂ - S₁ + β * Q) :
    ((-S₂ + β * U₂ + lnZ) - (-S₁ + β * U₁ + lnZ)) / β ≤ W := by
  apply (div_le_iff₀ hβ).mpr
  have h := decoder_work_balance (β := β) (lnZ := lnZ) (S₁ := S₁) (S₂ := S₂) hfirst
  nlinarith

/-- Saturation of that floor is exactly zero entropy production in this
ledger. Joint unitarity alone is not substituted for this condition. -/
theorem decoder_work_floor_saturation {β lnZ S₁ S₂ U₁ U₂ W Q : ℝ}
    (hβ : 0 < β) (hfirst : U₂ - U₁ = W - Q) :
    W = ((-S₂ + β * U₂ + lnZ) - (-S₁ + β * U₁ + lnZ)) / β ↔
      S₂ - S₁ + β * Q = 0 := by
  have h := decoder_work_balance (β := β) (lnZ := lnZ) (S₁ := S₁) (S₂ := S₂) hfirst
  rw [eq_div_iff hβ.ne']
  constructor <;> intro heq <;> nlinarith

/-- A Gibbs entropy bound joined to the decoder's metered energy budget.
The partition term is retained; entropy is measured per prepared state,
not silently equated with a channel rate. -/
theorem funded_decoder_entropy_bound {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]
    {H ρ : Matrix n n ℂ} (hH : H.IsHermitian) (hρ : ρ.PosSemidef)
    (htr : (Matrix.trace ρ).re = 1) {β E₀ budget : ℝ}
    (hβ : 0 ≤ β) (henergy : (Matrix.trace (ρ * H)).re ≤ E₀ + budget) :
    Snuffy.QuantumLandauer.vnEnt hρ.1 ≤
      β * (E₀ + budget) + Real.log (Snuffy.Landauer.partition β hH.eigenvalues) := by
  have h := Snuffy.QuantumLandauer.vnEnt_le_energy hH β hρ htr
  have hm := mul_le_mul_of_nonneg_left henergy hβ
  linarith

/-- Local income covering the complete decoder demand supplies the existing
escrow theorem at every cycle, including the minimal-hold account. -/
theorem funded_decoder_cycles {E₀ : ℝ} {r w h : ℕ → ℝ}
    (hE : 0 ≤ E₀) (hcover : ∀ k, w k ≤ r k) :
    ∀ k, Snuffy.ThermoLedger.escrow E₀ r w h k =
        E₀ + ∑ j ∈ Finset.range k, (r j - w j) ∧
      0 ≤ Snuffy.ThermoLedger.escrow E₀ r w h k ∧
      w k ≤ Snuffy.ThermoLedger.escrow E₀ r w h k + r k := by
  apply Snuffy.ThermoLedger.funded_repair_certificate hE
  intro k
  exact add_nonneg hE (Finset.sum_nonneg fun j _ => sub_nonneg.mpr (hcover j))

/-- Full charge of one admitted handoff attempt. A failed verification still
owes the attempted encoding, transfer, checking, routing, guard, reset,
holding, controller and endpoint work. -/
structure HandoffCharge where
  encoding : ℕ
  transfer : ℕ
  verification : ℕ
  routing : ℕ
  guard : ℕ
  reset : ℕ
  holding : ℕ
  controller : ℕ
  endpoints : ℕ

def HandoffCharge.total (q : HandoffCharge) : ℕ :=
  q.encoding + q.transfer + q.verification + q.routing + q.guard +
    q.reset + q.holding + q.controller + q.endpoints

structure ChargedState (A : Type*) where
  payload : A
  escrow : ℕ
  spent : ℕ

/-- An admitted attempt pays its complete charge whether or not it commits.
Admission must reserve this amount before the source operation. The existing
funded controller supplies the fallback/minimal-hold branch. -/
def chargedAttempt {A : Type*} (move : A → A) (q : HandoffCharge) (commit : Bool)
    (s : ChargedState A) (_hfunded : q.total ≤ s.escrow) : ChargedState A :=
  { payload := if commit then move s.payload else s.payload
    escrow := s.escrow - q.total
    spent := s.spent + q.total }

/-- Complete accounting and safe failed commit are derived from the actual
source update. The debit does not depend on the success flag. -/
theorem charged_attempt_accounting {A : Type*} (move : A → A)
    (q : HandoffCharge) (commit : Bool) (s : ChargedState A)
    (hfunded : q.total ≤ s.escrow) :
    let s' := chargedAttempt move q commit s hfunded
    s'.spent = s.spent + q.total ∧
      s'.escrow + s'.spent = s.escrow + s.spent ∧
      (commit = false → s'.payload = s.payload) := by
  dsimp [chargedAttempt]
  refine ⟨rfl, ?_, ?_⟩
  · omega
  · intro h
    simp [h]

/-- A dissipative syndrome stock has a uniform envelope when its influx is
bounded. This is a bound on stored charge, with no historical payload erased. -/
theorem syndrome_stock_bound {q influx : ℕ → ℝ} {α cap : ℝ}
    (hα : 0 < α) (hα₁ : α ≤ 1)
    (hrec : ∀ k, q (k + 1) = (1 - α) * q k + influx k)
    (hcap : ∀ k, influx k ≤ cap) :
    ∀ k, q k ≤ max (q 0) (cap / α) := by
  apply Snuffy.ThermoLedger.tracking_bounded hα hα₁
  intro k
  rw [hrec k]
  linarith [hcap k]

/-- Export is retained in the gross ledger: final stock plus all flushed
charge equals initial stock plus all incoming charge. -/
theorem syndrome_flux_balance (q influx : ℕ → ℝ) (α : ℝ)
    (hrec : ∀ k, q (k + 1) = (1 - α) * q k + influx k) (N : ℕ) :
    q N + ∑ k ∈ Finset.range N, α * q k =
      q 0 + ∑ k ∈ Finset.range N, influx k := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_range_succ, Finset.sum_range_succ, hrec N]
      nlinarith

/-- The cumulative maintenance upper bill follows from measured influx and
active-footprint bounds. All import/flush/holding/guard/controller charges
must be included in the local cost inequality. If the recurrence is for
expectations this concludes an expected bill; a pathwise application needs
these source bounds pathwise. The desired cumulative bill is not an input. -/
theorem cumulative_maintenance_bound (q influx active cost : ℕ → ℝ)
    (α u v w κ initial V : ℝ) (N : ℕ)
    (hrec : ∀ k, q (k + 1) = (1 - α) * q k + influx k)
    (hq : 0 ≤ q N) (hu : 0 ≤ u) (hv : 0 ≤ v) (hw : 0 ≤ w)
    (hinit : q 0 ≤ initial * V)
    (hin : (∑ k ∈ Finset.range N, influx k) ≤ κ * V)
    (hactive : (∑ k ∈ Finset.range N, active k) ≤ V)
    (hcost : ∀ k ∈ Finset.range N,
      cost k ≤ u * influx k + v * (α * q k) + w * active k) :
    (∑ k ∈ Finset.range N, cost k) ≤
      (u * κ + v * (initial + κ) + w) * V := by
  have hflux : (∑ k ∈ Finset.range N, α * q k) ≤ (initial + κ) * V := by
    have h := syndrome_flux_balance q influx α hrec N
    nlinarith
  calc
    _ ≤ ∑ k ∈ Finset.range N,
        (u * influx k + v * (α * q k) + w * active k) :=
      Finset.sum_le_sum hcost
    _ = u * (∑ k ∈ Finset.range N, influx k) +
        v * (∑ k ∈ Finset.range N, α * q k) +
        w * (∑ k ∈ Finset.range N, active k) := by
      simp only [Finset.sum_add_distrib, Finset.mul_sum]
    _ ≤ u * (κ * V) + v * ((initial + κ) * V) + w * V :=
      add_le_add (add_le_add (mul_le_mul_of_nonneg_left hin hu)
        (mul_le_mul_of_nonneg_left hflux hv))
        (mul_le_mul_of_nonneg_left hactive hw)
    _ = _ := by ring

end Snuffy.WorkBilling
