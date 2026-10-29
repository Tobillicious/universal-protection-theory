/-
Snuffy — Canon Edition v4.1: the Theorem 8 thermodynamic ledger, the canon
invariant and the identity envelope, machine-checked (Summit 4, Theorem 8;
Chapters 1, 2 and 5).

  * stroke_identity — ΔD = βW_on − βQ_B + I₁ − I₂ at fixed Hamiltonian, from the
    first law and the correlation bookkeeping (Chapter 1, 1.1).
  * cycle_work_floor — with guard 1 (βQ_B ≥ I_M + D_err + δ_I) and gross
    charging of the escrow loss, W_cycle ≥ k_BT(I_M + D_err + δ_I) + (1 − η)C.
  * funded_repair_certificate — the controller repairs when affordable and
    otherwise drops to the minimal hold; under prefix solvency every repair
    executes and the escrow equals E₀ + Σ(income − demand) ≥ 0.
  * quarantine_zero_debt — whenever income covers the minimal-hold drain, the
    escrow never goes negative, whatever the demand: no unfunded transition.
  * tower_bound, canon_invariant — a conditional kernel bound gives the
    unconditional one (tower property, disintegrated form), and breach on the
    certified good event being impossible gives P(breach) ≤ P(Gᶜ) ≤ Σδ with no
    independence assumed.
  * tracking_envelope, tracking_bounded — the identity layer's recursion
    e_{k+1} ≤ (1 − a)e_k + b solves to (1 − a)^k e₀ + (b/a)(1 − (1 − a)^k) and
    never exceeds max(e₀, b/a) (Chapter 2).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.MeasureTheory.Measure.Basic
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

open MeasureTheory Finset

namespace Snuffy.ThermoLedger

/-! ## The stroke identity and the cycle work floor -/

/-- **Stroke identity.** With `D = −S + βU + ln Z` at fixed Hamiltonian, the first
law `ΔU = W_on − Q_B` and the correlation bookkeeping `ΔS = I₂ − I₁` give
`ΔD = βW_on − βQ_B + I₁ − I₂`. Consuming correlation (`I₁ = I_M`, `I₂ = 0`)
contributes `+I_M`. -/
theorem stroke_identity {β lnZ S₁ S₂ U₁ U₂ W Q I₁ I₂ : ℝ}
    (hfirst : U₂ - U₁ = W - Q) (hcorr : S₂ - S₁ = I₂ - I₁) :
    (-S₂ + β * U₂ + lnZ) - (-S₁ + β * U₁ + lnZ) = β * W - β * Q + I₁ - I₂ := by
  have : β * U₂ - β * U₁ = β * W - β * Q := by
    rw [← mul_sub, ← mul_sub, hfirst]
  linarith

/-- **Cycle work floor.** Guard 1 (the bath absorbs the exported entropy,
`βQ_B ≥ I_M + D_err + δ_I`, `β = 1/k_BT`) and gross charging of the escrow
liquidation (`W ≥ Q_B + (1 − η)C`) give
`W_cycle ≥ k_BT(I_M + D_err + δ_I) + (1 − η)C`. -/
theorem cycle_work_floor {kT Q W IM Derr δI η C : ℝ} (hkT : 0 < kT)
    (hguard : Q / kT ≥ IM + Derr + δI) (hcharge : W ≥ Q + (1 - η) * C) :
    W ≥ kT * (IM + Derr + δI) + (1 - η) * C := by
  have hQ : Q ≥ kT * (IM + Derr + δI) := by
    have h := mul_le_mul_of_nonneg_left hguard hkT.le
    rwa [mul_div_cancel₀ Q hkT.ne'] at h
  linarith

/-! ## The funded-repair certificate and quarantine -/

/-- One cycle of the escrow controller: income `r` arrives; the repair demand `w`
is paid if affordable, otherwise the minimal-hold drain `h` is paid instead. -/
noncomputable def escrowStep (E r w h : ℝ) : ℝ := if w ≤ E + r then E + r - w else E + r - h

/-- The escrow trajectory from `E₀`. -/
noncomputable def escrow (E₀ : ℝ) (r w h : ℕ → ℝ) : ℕ → ℝ
  | 0 => E₀
  | k + 1 => escrowStep (escrow E₀ r w h k) (r k) (w k) (h k)

/-- **Funded-repair certificate.** Under prefix solvency
`E₀ + Σ_{j ≤ k} (r_j − w_j) ≥ 0` for every `k`, every repair executes and the
escrow is exactly `E₀ + Σ_{j < k}(r_j − w_j) ≥ 0`. -/
theorem funded_repair_certificate {E₀ : ℝ} {r w h : ℕ → ℝ} (hE : 0 ≤ E₀)
    (hsolv : ∀ k, 0 ≤ E₀ + ∑ j ∈ range (k + 1), (r j - w j)) :
    ∀ k, escrow E₀ r w h k = E₀ + ∑ j ∈ range k, (r j - w j) ∧
      0 ≤ escrow E₀ r w h k ∧ w k ≤ escrow E₀ r w h k + r k := by
  intro k
  induction k with
  | zero =>
    have h0 := hsolv 0
    rw [zero_add, sum_range_one] at h0
    refine ⟨by simp [escrow], by simpa [escrow] using hE, ?_⟩
    simp only [escrow]
    linarith
  | succ k ih =>
    obtain ⟨heq, -, hrep⟩ := ih
    have hnext : escrow E₀ r w h (k + 1) = E₀ + ∑ j ∈ range (k + 1), (r j - w j) := by
      show escrowStep (escrow E₀ r w h k) (r k) (w k) (h k) = _
      simp only [escrowStep, hrep, ↓reduceIte]
      rw [heq, sum_range_succ]
      ring
    refine ⟨hnext, hnext ▸ hsolv k, ?_⟩
    have hk2 := hsolv (k + 1)
    rw [sum_range_succ] at hk2
    rw [hnext]
    linarith

/-- **Quarantine: zero debt.** If income always covers the minimal-hold drain,
the escrow never goes negative, whatever the repair demand: the controller
never takes an unfunded transition. -/
theorem quarantine_zero_debt {E₀ : ℝ} {r w h : ℕ → ℝ} (hE : 0 ≤ E₀)
    (hhold : ∀ k, h k ≤ r k) : ∀ k, 0 ≤ escrow E₀ r w h k := by
  intro k
  induction k with
  | zero => exact hE
  | succ k ih =>
    show 0 ≤ escrowStep (escrow E₀ r w h k) (r k) (w k) (h k)
    unfold escrowStep
    split_ifs with hrep
    · linarith
    · linarith [hhold k]

/-! ## The canon invariant -/

/-- **Tower bound (disintegrated form).** If the law of a charged event is a
mixture of conditional laws over admitted histories, each giving it
probability at most `δ`, its unconditional probability is at most `δ`. -/
theorem tower_bound {Ω H : Type*} [MeasurableSpace Ω] [MeasurableSpace H]
    (μ : Measure Ω) (ν : Measure H) [IsProbabilityMeasure ν] (κ : H → Measure Ω)
    (E : Set Ω) (δ : ENNReal) (hmix : μ E = ∫⁻ x, κ x E ∂ν) (hk : ∀ x, κ x E ≤ δ) :
    μ E ≤ δ := by
  rw [hmix]
  calc ∫⁻ x, κ x E ∂ν ≤ ∫⁻ _, δ ∂ν := lintegral_mono hk
    _ = δ := by simp

/-- **The canon invariant.** Uncompensated breach is impossible on the certified
good event `G`; the good event fails only through the charged accounts; each
account fires with probability at most its kernel bound. Then
`P(breach) ≤ P(Gᶜ) ≤ Σ δ` — no independence is used. -/
theorem canon_invariant {Ω ι : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    (accounts : Finset ι) (E : ι → Set Ω) (δ : ι → ENNReal) (G breach : Set Ω)
    (hbreach : breach ⊆ Gᶜ) (hG : Gᶜ ⊆ ⋃ i ∈ accounts, E i)
    (hδ : ∀ i ∈ accounts, μ (E i) ≤ δ i) :
    μ breach ≤ μ Gᶜ ∧ μ Gᶜ ≤ ∑ i ∈ accounts, δ i := by
  refine ⟨measure_mono hbreach, ?_⟩
  calc μ Gᶜ ≤ μ (⋃ i ∈ accounts, E i) := measure_mono hG
    _ ≤ ∑ i ∈ accounts, μ (E i) := measure_biUnion_finset_le accounts E
    _ ≤ ∑ i ∈ accounts, δ i := sum_le_sum hδ

/-! ## The identity envelope (Chapter 2) -/

/-- **Tracking envelope.** The recursion `e_{k+1} ≤ (1 − a)e_k + b` with
`0 < a ≤ 1`, `b ≥ 0` (correction plus controller gain `a`, leakage and fault
injection `b`) solves to `e_k ≤ (1 − a)^k e₀ + (b/a)(1 − (1 − a)^k)`. The
injection stays in the bound: the controller suppresses accumulation, it does
not delete injection. -/
theorem tracking_envelope {e : ℕ → ℝ} {a b : ℝ} (ha0 : 0 < a) (ha1 : a ≤ 1)
    (hrec : ∀ k, e (k + 1) ≤ (1 - a) * e k + b) :
    ∀ k, e k ≤ (1 - a) ^ k * e 0 + b / a * (1 - (1 - a) ^ k) := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
    have h1a : 0 ≤ 1 - a := by linarith
    calc e (k + 1) ≤ (1 - a) * e k + b := hrec k
      _ ≤ (1 - a) * ((1 - a) ^ k * e 0 + b / a * (1 - (1 - a) ^ k)) + b := by
        have := mul_le_mul_of_nonneg_left ih h1a
        linarith
      _ = (1 - a) ^ (k + 1) * e 0 + b / a * (1 - (1 - a) ^ (k + 1)) := by
        field_simp
        ring

/-- **Bounded envelope.** The tracking error never exceeds `max(e₀, b/a)`; with
gain large enough that `b/a ≤ ε₀` and a start within `ε₀`, it stays within the
measurement resolution `ε₀` for all time. -/
theorem tracking_bounded {e : ℕ → ℝ} {a b : ℝ} (ha0 : 0 < a) (ha1 : a ≤ 1)
    (hrec : ∀ k, e (k + 1) ≤ (1 - a) * e k + b) :
    ∀ k, e k ≤ max (e 0) (b / a) := by
  intro k
  have henv := tracking_envelope ha0 ha1 hrec k
  have hp0 : 0 ≤ (1 - a) ^ k := pow_nonneg (by linarith) k
  have hp1 : (1 - a) ^ k ≤ 1 := pow_le_one₀ (by linarith) (by linarith)
  have h1 : (1 - a) ^ k * e 0 ≤ (1 - a) ^ k * max (e 0) (b / a) :=
    mul_le_mul_of_nonneg_left (le_max_left _ _) hp0
  have h2 : b / a * (1 - (1 - a) ^ k) ≤ max (e 0) (b / a) * (1 - (1 - a) ^ k) :=
    mul_le_mul_of_nonneg_right (le_max_right _ _) (by linarith)
  nlinarith

theorem tracking_within_resolution {e : ℕ → ℝ} {a b ε₀ : ℝ} (ha0 : 0 < a) (ha1 : a ≤ 1)
    (hrec : ∀ k, e (k + 1) ≤ (1 - a) * e k + b) (he0 : e 0 ≤ ε₀) (hgain : b / a ≤ ε₀) :
    ∀ k, e k ≤ ε₀ :=
  fun k => (tracking_bounded ha0 ha1 hrec k).trans (max_le he0 hgain)

end Snuffy.ThermoLedger
