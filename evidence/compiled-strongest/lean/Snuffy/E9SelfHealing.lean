/-
Snuffy — Canon Edition v4.1: Theorem E9, machine-checked (Summit 4, E9).

Observation to timely self-healing:

  * robust_between_honest — any estimate m with at least f + 1 readings at or
    below it and f + 1 at or above it lies between honest readings, whenever at
    most f sensors are faulty or spoofed.
  * no_false_alarm, no_masking — hence no f sensors can force an alarm that no
    honest sensor supports, nor suppress an alarm every honest sensor supports.
  * exists_robust — with K ≥ 2f + 1 sensors such an estimate always exists
    (the trimmed median is one).
  * syndrome_detects (Branch B) — for any bilinear commutation form, a
    non-stabilizer error of weight below the code distance has a non-trivial
    syndrome on some generator (Paulis over 𝔽₂ with the symplectic form are an
    instance).
  * wave_race_margin, code_headroom — buffer sizing L > v_harm τ_response gives
    τ_response < L / v_harm; fault headroom 2 λ τ_response < d keeps the error
    count inside the correctable radius ⌊(d − 1)/2⌋.
  * e9_timely_self_healing — the assembled theorem.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Data.Fintype.Card
import Mathlib.Basic.Real.Basic
import Mathlib.LinearAlgebra.BilinearForm.Properties
import Mathlib.Order.Interval.Finset.Defs
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

open Finset

namespace Snuffy.E9

/-! ## Byzantine sensor quorum -/

section Quorum

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A robust estimate has at least `f + 1` readings on each side. -/
def Robust (y : ι → ℝ) (f : ℕ) (m : ℝ) : Prop :=
  f + 1 ≤ (univ.filter (fun i => y i ≤ m)).card ∧
    f + 1 ≤ (univ.filter (fun i => m ≤ y i)).card

/-- **Spoofing immunity.** With at most `f` faulty sensors, a robust estimate
lies between honest readings. -/
theorem robust_between_honest (y : ι → ℝ) (faulty : Finset ι) {f : ℕ}
    (hf : faulty.card ≤ f) {m : ℝ} (hm : Robust y f m) :
    (∃ i ∉ faulty, y i ≤ m) ∧ (∃ j ∉ faulty, m ≤ y j) := by
  constructor
  · by_contra h
    have hsub : univ.filter (fun i => y i ≤ m) ⊆ faulty := by
      intro i hi
      by_contra hif
      exact h ⟨i, hif, (mem_filter.mp hi).2⟩
    have := card_le_card hsub
    have := hm.1
    omega
  · by_contra h
    have hsub : univ.filter (fun i => m ≤ y i) ⊆ faulty := by
      intro i hi
      by_contra hif
      exact h ⟨i, hif, (mem_filter.mp hi).2⟩
    have := card_le_card hsub
    have := hm.2
    omega

/-- **No false alarm.** If a robust estimate exceeds the threshold, some honest
sensor's reading exceeds it. -/
theorem no_false_alarm (y : ι → ℝ) (faulty : Finset ι) {f : ℕ} (hf : faulty.card ≤ f)
    {m θ : ℝ} (hm : Robust y f m) (halarm : θ < m) : ∃ j ∉ faulty, θ < y j := by
  obtain ⟨j, hj, hmj⟩ := (robust_between_honest y faulty hf hm).2
  exact ⟨j, hj, lt_of_lt_of_le halarm hmj⟩

/-- **No masking.** If every honest reading exceeds the threshold, so does every
robust estimate. -/
theorem no_masking (y : ι → ℝ) (faulty : Finset ι) {f : ℕ} (hf : faulty.card ≤ f)
    {m θ : ℝ} (hm : Robust y f m) (hall : ∀ i ∉ faulty, θ < y i) : θ < m := by
  obtain ⟨i, hi, him⟩ := (robust_between_honest y faulty hf hm).1
  exact lt_of_lt_of_le (hall i hi) him

omit [DecidableEq ι] in
/-- **Existence.** With `K ≥ 2f + 1` sensors a robust estimate exists: the least
reading with at least `f + 1` readings at or below it. -/
theorem exists_robust (y : ι → ℝ) {f : ℕ} (hK : 2 * f + 1 ≤ Fintype.card ι) :
    ∃ m, Robust y f m := by
  classical
  have hne : (univ : Finset ι).Nonempty := by
    rw [univ_nonempty_iff, ← Fintype.card_pos_iff]
    omega
  set V := (univ : Finset ι).image y
  set good := V.filter (fun v => f + 1 ≤ (univ.filter (fun i => y i ≤ v)).card)
  obtain ⟨i₀, -, hi₀⟩ := (univ : Finset ι).exists_max_image y hne
  have hgood : good.Nonempty := by
    refine ⟨y i₀, mem_filter.mpr ⟨mem_image_of_mem y (mem_univ _), ?_⟩⟩
    have hall : univ.filter (fun i => y i ≤ y i₀) = univ := by
      ext i
      simp [hi₀ i (mem_univ _)]
    rw [hall, card_univ]
    omega
  set m := good.min' hgood
  have hm_good : m ∈ good := good.min'_mem hgood
  have hlo : f + 1 ≤ (univ.filter (fun i => y i ≤ m)).card := (mem_filter.mp hm_good).2
  have hlt : (univ.filter (fun i => y i < m)).card ≤ f := by
    by_contra hcon
    rw [not_le] at hcon
    have hne' : (univ.filter (fun i => y i < m)).Nonempty := by
      rw [← card_pos]
      omega
    obtain ⟨j, hj, hjmax⟩ := (univ.filter (fun i => y i < m)).exists_max_image y hne'
    have hsub : univ.filter (fun i => y i < m) ⊆ univ.filter (fun i => y i ≤ y j) := by
      intro i hi
      exact mem_filter.mpr ⟨mem_univ _, hjmax i hi⟩
    have hjgood : y j ∈ good := by
      refine mem_filter.mpr ⟨mem_image_of_mem y (mem_univ _), ?_⟩
      have := card_le_card hsub
      omega
    have hle : m ≤ y j := good.min'_le _ hjgood
    have hjlt : y j < m := (mem_filter.mp hj).2
    linarith
  have hsplit := card_filter_add_card_filter_not (s := (univ : Finset ι))
    (fun i => y i < m)
  have hneg : univ.filter (fun i => ¬ y i < m) = univ.filter (fun i => m ≤ y i) := by
    ext i
    simp [not_lt]
  rw [hneg, card_univ] at hsplit
  exact ⟨m, hlo, by omega⟩

end Quorum

/-! ## Branch B: low-weight syndrome detection -/

section Syndrome

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

/-- The stabilizer generated by the check family. -/
abbrev Stabilizer {n : ℕ} (g : Fin n → V) : Submodule K V := Submodule.span K (Set.range g)

/-- **Branch B.** Let `ω` be the bilinear commutation form, `g` the stabilizer
generators and `d` the code distance: every operator commuting with the whole
stabilizer but outside it has weight at least `d`. Then any non-stabilizer
error of weight below `d` anticommutes with some generator — its syndrome is
non-trivial. -/
theorem syndrome_detects (ω : LinearMap.BilinForm K V) {n : ℕ} (g : Fin n → V)
    (wt : V → ℕ) (d : ℕ)
    (hdist : ∀ P, (∀ s ∈ Stabilizer (K := K) g, ω P s = 0) →
      P ∉ Stabilizer (K := K) g → d ≤ wt P)
    (P : V) (hP : P ∉ Stabilizer (K := K) g) (hwt : wt P < d) :
    ∃ i, ω P (g i) ≠ 0 := by
  by_contra h
  have hzero : ∀ i, ω P (g i) = 0 := fun i => by
    by_contra hi
    exact h ⟨i, hi⟩
  have hspan : Stabilizer (K := K) g ≤ LinearMap.ker (ω P) := by
    rw [Submodule.span_le]
    rintro _ ⟨i, rfl⟩
    exact hzero i
  have hcomm : ∀ s ∈ Stabilizer (K := K) g, ω P s = 0 := fun s hs => hspan hs
  have := hdist P hcomm hP
  omega

end Syndrome

/-! ## Timing: wave race and code headroom -/

/-- **Wave race.** Buffer sizing `L > v_harm · τ_response` gives a strictly
positive margin: the response completes before the harm front crosses the
buffer. -/
theorem wave_race_margin {L vh τ : ℝ} (hv : 0 < vh) (hL : vh * τ < L) : τ < L / vh := by
  rw [lt_div_iff₀ hv]
  linarith

/-- **Code headroom.** If at most `λ τ_response` errors accrue during the response
window and `2 λ τ_response < d`, the error count `N` satisfies `2N + 1 ≤ d`: it
lies inside the correctable radius `⌊(d − 1)/2⌋`. -/
theorem code_headroom {N d : ℕ} {lt : ℝ} (hN : (N : ℝ) ≤ lt) (hd : 2 * lt < d) :
    2 * N + 1 ≤ d ∧ N ≤ (d - 1) / 2 := by
  have h : (2 * N : ℝ) < d := by linarith
  have h' : 2 * N < d := by exact_mod_cast h
  constructor <;> omega

/-! ## Assembly -/

/-- **Theorem E9 (timely self-healing).** For a local cluster of `K ≥ 2f + 1`
sensors with at most `f` faulty or spoofed, a disturbance that every honest
sensor registers above threshold `θ`:
1. is committed — a robust estimate exists and exceeds `θ` (no masking);
2. cannot be faked — any robust estimate above `θ` is backed by an honest
   reading above `θ` (no false alarm);
3. is answered in time — with `L > v_harm τ_response`, `τ_response < L / v_harm`;
4. stays correctable — the `N ≤ λ τ_response` errors of the window satisfy
   `N ≤ ⌊(d − 1)/2⌋` when `2 λ τ_response < d`. -/
theorem e9_timely_self_healing {ι : Type*} [Fintype ι] [DecidableEq ι]
    (y : ι → ℝ) (faulty : Finset ι) {f : ℕ} (hK : 2 * f + 1 ≤ Fintype.card ι)
    (hf : faulty.card ≤ f) {θ : ℝ} (hhonest : ∀ i ∉ faulty, θ < y i)
    {L vh τ_detect τ_signal τ_decide τ_actuate : ℝ} (hv : 0 < vh)
    (hL : vh * (τ_detect + τ_signal + τ_decide + τ_actuate) < L)
    {N d : ℕ} {lam : ℝ}
    (hN : (N : ℝ) ≤ lam * (τ_detect + τ_signal + τ_decide + τ_actuate))
    (hd : 2 * (lam * (τ_detect + τ_signal + τ_decide + τ_actuate)) < d) :
    (∃ m, Robust y f m ∧ θ < m) ∧
    (∀ m, Robust y f m → θ < m → ∃ j ∉ faulty, θ < y j) ∧
    τ_detect + τ_signal + τ_decide + τ_actuate < L / vh ∧
    N ≤ (d - 1) / 2 := by
  obtain ⟨m, hm⟩ := exists_robust y hK
  refine ⟨⟨m, hm, no_masking y faulty hf hm hhonest⟩,
    fun m' hm' h' => no_false_alarm y faulty hf hm' h',
    wave_race_margin hv hL, (code_headroom hN hd).2⟩

end Snuffy.E9
