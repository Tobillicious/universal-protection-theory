/-
Snuffy — Canon Edition v4.1: three instrument steps derived (Chapter 2;
Chapter 3 / §19 Branch C; §21 / working argument §12).

  * lindblad_reset_flow — the controller `L(ρ) = −κ(ρ − ρ*)` has the exact
    flow `ρ(t) = ρ* + e^{−κt}(ρ₀ − ρ*)`; over one step of length `Δt` it is the
    reset map `σ ↦ (1 − λ)σ + λρ*` with `λ = 1 − e^{−κΔt}`.
  * reset_contracts — the reset map contracts the distance to the record by
    exactly `1 − λ`.
  * tracking_recursion_derived, tracking_envelope_derived — with per-step
    injection and record drift at most `b`, the tracking error obeys
    `e_{k+1} ≤ (1 − λ) e_k + b`, hence the identity envelope of Chapter 2
    (`ThermoLedger.tracking_envelope`), with nothing assumed about the error
    sequence.
  * branchC_complete — a coherent logical attack acts on at least `d` sites
    (the code distance); at every site of its support either the delivered
    power is below threshold (Branch A, rate-capped by the speed limit) or it
    reaches the threshold, and then the site's quorum fires, whatever up to
    `f` faulty sensors report (`E9.no_masking`). The trichotomy is complete.
  * card_box, card_boundary, boundary_power — the frontier of a lattice region
    of radius `r` in `d` dimensions has at least `2(2r + 1)^{d−1}` sites, so
    maintaining it against a per-site leak `p₀` costs power at least
    `p₀ r^{d−1}`: the area law used by the recovery-work theorem.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ThermoLedger
import Snuffy.E9SelfHealing
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Normed.Module.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Int.Interval
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Tactic.Module

open Finset

namespace Snuffy.Instruments

/-! ## B1: the tracking recursion from the controller -/

section Tracking

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F]

/-- **The controller's exact flow.** `t ↦ ρ* + e^{−κt}(ρ₀ − ρ*)` solves
`ρ' = −κ(ρ − ρ*)` (reset-type Lindblad dynamics toward the record). -/
theorem lindblad_reset_flow (κ : ℝ) (r x₀ : F) (t : ℝ) :
    HasDerivAt (fun s => r + Real.exp (-κ * s) • (x₀ - r))
      (-κ • ((r + Real.exp (-κ * t) • (x₀ - r)) - r)) t := by
  have h1 : HasDerivAt (fun s => Real.exp (-κ * s)) (Real.exp (-κ * t) * -κ) t := by
    have := ((hasDerivAt_id t).const_mul (-κ)).exp
    simpa [mul_comm] using this
  have h2 := (h1.smul_const (x₀ - r)).const_add r
  convert h2 using 1
  rw [add_sub_cancel_left, smul_smul, mul_comm]

/-- Over one step the flow is the reset map with `λ = 1 − e^{−κΔt}`. -/
theorem lindblad_step (κ Δ : ℝ) (r x₀ : F) :
    r + Real.exp (-κ * Δ) • (x₀ - r)
      = (1 - (1 - Real.exp (-κ * Δ))) • x₀ + (1 - Real.exp (-κ * Δ)) • r := by
  rw [sub_sub_cancel, smul_sub, sub_smul, one_smul]
  abel

/-- **The reset contracts by exactly `1 − λ`.** -/
theorem reset_contracts {lam : ℝ} (h1 : lam ≤ 1) (σ r : F) :
    ‖((1 - lam) • σ + lam • r) - r‖ = (1 - lam) * ‖σ - r‖ := by
  have : (1 - lam) • σ + lam • r - r = (1 - lam) • (σ - r) := by module
  rw [this, norm_smul, Real.norm_eq_abs, abs_of_nonneg (by linarith)]

/-- **The tracking recursion, derived.** Each step adds an injection `Δ k` to the
state and then resets toward the current record `rec (k+1)`. If the injection
plus the record's drift is at most `b`, the tracking error obeys
`e_{k+1} ≤ (1 − λ) e_k + b`. -/
theorem tracking_recursion_derived {lam b : ℝ} (h0 : 0 ≤ lam) (h1 : lam ≤ 1)
    (x rec Δ : ℕ → F)
    (hstep : ∀ k, x (k + 1) = (1 - lam) • (x k + Δ k) + lam • rec (k + 1))
    (hinj : ∀ k, ‖Δ k‖ + ‖rec (k + 1) - rec k‖ ≤ b) :
    ∀ k, ‖x (k + 1) - rec (k + 1)‖ ≤ (1 - lam) * ‖x k - rec k‖ + b := by
  intro k
  have hb0 : 0 ≤ b := (add_nonneg (norm_nonneg _) (norm_nonneg _)).trans (hinj 0)
  rw [hstep k, reset_contracts h1]
  have htri : ‖x k + Δ k - rec (k + 1)‖ ≤ ‖x k - rec k‖ + (‖Δ k‖ + ‖rec (k + 1) - rec k‖) := by
    have : x k + Δ k - rec (k + 1) = (x k - rec k) + Δ k - (rec (k + 1) - rec k) := by abel
    rw [this]
    calc ‖(x k - rec k) + Δ k - (rec (k + 1) - rec k)‖
        ≤ ‖(x k - rec k) + Δ k‖ + ‖rec (k + 1) - rec k‖ := norm_sub_le _ _
      _ ≤ ‖x k - rec k‖ + ‖Δ k‖ + ‖rec (k + 1) - rec k‖ := by gcongr; exact norm_add_le _ _
      _ = _ := by ring
  have h1l : 0 ≤ 1 - lam := by linarith
  calc (1 - lam) * ‖x k + Δ k - rec (k + 1)‖
      ≤ (1 - lam) * (‖x k - rec k‖ + b) :=
        mul_le_mul_of_nonneg_left (htri.trans (by linarith [hinj k])) h1l
    _ ≤ (1 - lam) * ‖x k - rec k‖ + b := by nlinarith

/-- **The identity envelope of Chapter 2, from the controller.** -/
theorem tracking_envelope_derived {lam b : ℝ} (h0 : 0 < lam) (h1 : lam ≤ 1)
    (x rec Δ : ℕ → F)
    (hstep : ∀ k, x (k + 1) = (1 - lam) • (x k + Δ k) + lam • rec (k + 1))
    (hinj : ∀ k, ‖Δ k‖ + ‖rec (k + 1) - rec k‖ ≤ b) :
    ∀ k, ‖x k - rec k‖ ≤ (1 - lam) ^ k * ‖x 0 - rec 0‖ + b / lam * (1 - (1 - lam) ^ k) :=
  Snuffy.ThermoLedger.tracking_envelope h0 h1
    (tracking_recursion_derived h0.le h1 x rec Δ hstep hinj)

end Tracking

/-! ## B3: Branch C is complete -/

section BranchC

variable {Site ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Branch C, complete.** A logical operator — one the stabilizer cannot see
and that is not itself a stabilizer — has weight at least the code distance `d`
(the definition of distance), so its delivery touches at least `d` sites. At
each site of the support, either the delivered power is below the threshold `θ`
(Branch A: the speed limit caps the rate) or it reaches the threshold. In the
second case, if the honest sensors of that site read above `θ`, every robust
quorum estimate exceeds `θ`, whatever up to `f` faulty sensors report: the
attack is detected. -/
theorem branchC_complete {V : Type*} {wt : V → ℕ} {d : ℕ} {Logical : V → Prop}
    (hdist : ∀ P, Logical P → d ≤ wt P) {P : V} (hP : Logical P)
    (supp : Finset Site) (hsupp : wt P ≤ supp.card) (pow : Site → ℝ) (θ : ℝ)
    (y : Site → ι → ℝ) (faulty : Site → Finset ι) {f : ℕ}
    (hf : ∀ i, (faulty i).card ≤ f)
    (hhonest : ∀ i ∈ supp, θ ≤ pow i → ∀ j ∉ faulty i, θ < y i j) :
    d ≤ supp.card ∧
      ((∀ i ∈ supp, pow i < θ) ∨
        ∃ i ∈ supp, θ ≤ pow i ∧ ∀ m, Snuffy.E9.Robust (y i) f m → θ < m) := by
  refine ⟨(hdist P hP).trans hsupp, ?_⟩
  by_cases hall : ∀ i ∈ supp, pow i < θ
  · exact Or.inl hall
  · right
    push Not at hall
    obtain ⟨i, hi, hpow⟩ := hall
    exact ⟨i, hi, hpow, fun m hm =>
      Snuffy.E9.no_masking (y i) (faulty i) (hf i) hm (hhonest i hi hpow)⟩

end BranchC

/-! ## B5: the frontier area law -/

section Frontier

/-- The lattice box of radius `r` in `d` dimensions. -/
def box (d : ℕ) (r : ℤ) : Finset (Fin d → ℤ) := Fintype.piFinset fun _ => Icc (-r) r

theorem card_box (d : ℕ) {r : ℤ} (hr : 0 ≤ r) : ((box d r).card : ℤ) = (2 * r + 1) ^ d := by
  unfold box
  rw [Fintype.card_piFinset, prod_const, card_univ, Fintype.card_fin, Nat.cast_pow,
    Int.card_Icc, Int.toNat_of_nonneg (by omega)]
  ring_nf

theorem box_mono (d : ℕ) {r s : ℤ} (h : s ≤ r) : box d s ⊆ box d r := by
  intro x hx
  simp only [box, Fintype.mem_piFinset, mem_Icc] at hx ⊢
  exact fun i => ⟨by linarith [(hx i).1], by linarith [(hx i).2]⟩

/-- The frontier: sites of the box of radius `r` outside the box of radius
`r − 1`. -/
def boundary (d : ℕ) (r : ℤ) : Finset (Fin d → ℤ) := box d r \ box d (r - 1)

/-- **The frontier is large.** For `r ≥ 1` and `d ≥ 1`, the frontier has at
least `2(2r + 1)^{d−1}` sites. -/
theorem card_boundary {d : ℕ} (hd : 1 ≤ d) {r : ℤ} (hr : 1 ≤ r) :
    2 * (2 * r + 1) ^ (d - 1) ≤ ((boundary d r).card : ℤ) := by
  unfold boundary
  rw [card_sdiff_of_subset (box_mono d (by linarith)), Nat.cast_sub (card_le_card
    (box_mono d (by linarith))), card_box d (by linarith), card_box d (by linarith)]
  obtain ⟨k, rfl⟩ : ∃ k, d = k + 1 := ⟨d - 1, by omega⟩
  simp only [Nat.add_sub_cancel]
  set a : ℤ := 2 * r + 1
  have hb : 2 * (r - 1) + 1 = a - 2 := by ring
  rw [hb]
  -- a^(k+1) − (a−2)^(k+1) = 2 Σ a^i (a−2)^(k−i) ≥ 2 a^k
  have hgeom := Commute.geom_sum₂_mul (Commute.all a (a - 2)) (k + 1)
  rw [sub_sub_cancel] at hgeom
  simp only [Nat.add_sub_cancel] at hgeom
  have ha2 : 0 ≤ a - 2 := by linarith
  have hterm : a ^ k ≤ ∑ i ∈ range (k + 1), a ^ i * (a - 2) ^ (k - i) := by
    rw [sum_range_succ, Nat.sub_self, pow_zero, mul_one]
    have : 0 ≤ ∑ i ∈ range k, a ^ i * (a - 2) ^ (k - i) :=
      sum_nonneg fun i _ => mul_nonneg (pow_nonneg (by linarith) _) (pow_nonneg ha2 _)
    linarith
  nlinarith [hgeom, hterm]

/-- **The area law.** Maintaining the frontier of a region of radius `r ≥ 1`
against a leak of at least `p₀ ≥ 0` per frontier site costs power at least
`p₀ r^{d−1}`. -/
theorem boundary_power {d : ℕ} (hd : 1 ≤ d) {r : ℤ} (hr : 1 ≤ r) {p₀ P : ℝ} (hp : 0 ≤ p₀)
    (hP : p₀ * (boundary d r).card ≤ P) : p₀ * (r : ℝ) ^ (d - 1) ≤ P := by
  have hc : (2 * (2 * (r : ℝ) + 1) ^ (d - 1)) ≤ ((boundary d r).card : ℝ) := by
    exact_mod_cast card_boundary hd hr
  have hr0 : (0 : ℝ) ≤ r := by exact_mod_cast (show (0 : ℤ) ≤ r by omega)
  have hpow : (r : ℝ) ^ (d - 1) ≤ 2 * (2 * (r : ℝ) + 1) ^ (d - 1) := by
    have h1 : (r : ℝ) ^ (d - 1) ≤ (2 * (r : ℝ) + 1) ^ (d - 1) :=
      pow_le_pow_left₀ hr0 (by linarith) _
    have h2 : 0 ≤ (2 * (r : ℝ) + 1) ^ (d - 1) := pow_nonneg (by linarith) _
    linarith
  calc p₀ * (r : ℝ) ^ (d - 1) ≤ p₀ * (boundary d r).card :=
        mul_le_mul_of_nonneg_left (hpow.trans hc) hp
    _ ≤ P := hP

end Frontier

end Snuffy.Instruments
