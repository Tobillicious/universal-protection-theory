/-
Snuffy — Canon Edition v4.1: guard 1 derived — Landauer's bound and the
Reeb–Wolf identity for reversible dynamics, machine-checked (§18, stroke III;
canon §8.1 "Integration guard 1"; §23.8 physical premise).

A register `R` (the memory being reset, with whatever damage the reset
removes) starts in the law `p`; a bath `B` with energy levels `E` starts in its
Gibbs state `γ = e^{−βE}/Z`, independent of the register. The joint system
evolves by an arbitrary reversible map (a bijection `σ` of the joint state
space). Entropies are Shannon entropies in nats.

  * kl_nonneg — Gibbs' inequality (relative entropy is nonnegative).
  * ent_le_ent_marg — subadditivity: H(R′B′) ≤ H(R′) + H(B′).
  * ent_gibbs, ent_le_energy — H(γ) = β⟨E⟩_γ + ln Z, and H(a) ≤ β⟨E⟩_a + ln Z.
  * ent_evolve — reversible dynamics conserves the joint entropy, which starts
    at H(p) + H(γ).
  * reeb_wolf_identity — β ΔQ_B − ΔS_R = I(R′ : B′) + D(q_B ‖ γ), exactly.
  * landauer — β ΔQ_B ≥ ΔS_R = H(p) − H(q_R).
  * landauer_erasure — resetting to a deterministic state costs heat
    Q_B ≥ k_BT · H(p).
  * guard_one — whenever the reset removes I_M + D_err + δ_I nats from the
    register, βQ_B ≥ I_M + D_err + δ_I: the canon's guard 1.
  * cycle_work_floor_derived — `ThermoLedger.cycle_work_floor` with guard 1
    derived instead of assumed.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.FiniteInformation
import Snuffy.ThermoLedger

open Finset Real

namespace Snuffy.Landauer

/-! ## Entropy and Gibbs' inequality -/

/-- Shannon entropy in nats. -/
noncomputable def ent {ι : Type*} [Fintype ι] (f : ι → ℝ) : ℝ := ∑ i, negMulLog (f i)

/-- **Gibbs' inequality.** Relative entropy between laws is nonnegative. -/
theorem kl_nonneg {ι : Type*} [Fintype ι] (a b : ι → ℝ) (ha : ∀ i, 0 ≤ a i)
    (hb : ∀ i, 0 ≤ b i) (hab : ∀ i, b i = 0 → a i = 0) (ha1 : ∑ i, a i = 1)
    (hb1 : ∑ i, b i = 1) : 0 ≤ ∑ i, a i * log (a i / b i) := by
  have := Snuffy.FiniteInformation.log_sum a b ha hb hab
  rwa [ha1, hb1, div_one, log_one, mul_zero] at this

theorem mul_log_div_eq {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : b = 0 → a = 0) :
    a * log (a / b) = -negMulLog a - a * log b := by
  rcases ha.eq_or_lt with rfl | ha'
  · simp
  · have hb' : 0 < b := lt_of_le_of_ne hb fun h => ha'.ne' (hab h.symm)
    rw [log_div ha'.ne' hb'.ne', negMulLog]
    ring

/-! ## Subadditivity -/

section Joint

variable {α β : Type*} [Fintype α] [Fintype β]

/-- Register marginal. -/
def margA (q : α × β → ℝ) (x : α) : ℝ := ∑ y, q (x, y)

/-- Bath marginal. -/
def margB (q : α × β → ℝ) (y : β) : ℝ := ∑ x, q (x, y)

theorem sum_margA (q : α × β → ℝ) : ∑ x, margA q x = ∑ z, q z := by
  rw [Fintype.sum_prod_type]; rfl

theorem sum_margB (q : α × β → ℝ) : ∑ y, margB q y = ∑ z, q z := by
  rw [Fintype.sum_prod_type_right]; rfl

/-- Mutual information `I(R : B) = Σ q log(q / q_R q_B)`. -/
noncomputable def mutualInfo (q : α × β → ℝ) : ℝ :=
  ∑ z, q z * log (q z / (margA q z.1 * margB q z.2))

theorem mutualInfo_eq (q : α × β → ℝ) (hq : ∀ z, 0 ≤ q z) :
    mutualInfo q = ent (margA q) + ent (margB q) - ent q := by
  have hA : ∀ z, 0 < q z → 0 < margA q z.1 := fun z hz =>
    hz.trans_le (single_le_sum (f := fun y => q (z.1, y)) (fun y _ => hq _) (mem_univ z.2))
  have hB : ∀ z, 0 < q z → 0 < margB q z.2 := fun z hz =>
    hz.trans_le (single_le_sum (f := fun x => q (x, z.2)) (fun x _ => hq _) (mem_univ z.1))
  have hpt : ∀ z, q z * log (q z / (margA q z.1 * margB q z.2))
      = -negMulLog (q z) - q z * log (margA q z.1) - q z * log (margB q z.2) := by
    intro z
    rcases (hq z).eq_or_lt with h0 | hpos
    · rw [← h0]; simp
    · rw [log_div hpos.ne' (mul_pos (hA z hpos) (hB z hpos)).ne',
        log_mul (hA z hpos).ne' (hB z hpos).ne', negMulLog]
      ring
  have hsA : ∑ z, q z * log (margA q z.1) = -ent (margA q) := by
    rw [Fintype.sum_prod_type, ent, ← sum_neg_distrib]
    refine sum_congr rfl fun x _ => ?_
    show ∑ y, q (x, y) * log (margA q x) = _
    rw [← sum_mul, negMulLog, neg_mul, neg_neg]; rfl
  have hsB : ∑ z, q z * log (margB q z.2) = -ent (margB q) := by
    rw [Fintype.sum_prod_type_right, ent, ← sum_neg_distrib]
    refine sum_congr rfl fun y _ => ?_
    show ∑ x, q (x, y) * log (margB q y) = _
    rw [← sum_mul, negMulLog, neg_mul, neg_neg]; rfl
  unfold mutualInfo
  rw [sum_congr rfl fun z _ => hpt z, sum_sub_distrib, sum_sub_distrib, sum_neg_distrib, hsA, hsB]
  unfold ent
  ring

theorem mutualInfo_nonneg (q : α × β → ℝ) (hq : ∀ z, 0 ≤ q z) (hq1 : ∑ z, q z = 1) :
    0 ≤ mutualInfo q := by
  have hmA : ∀ x, 0 ≤ margA q x := fun x => sum_nonneg fun y _ => hq _
  have hmB : ∀ y, 0 ≤ margB q y := fun y => sum_nonneg fun x _ => hq _
  refine kl_nonneg q (fun z => margA q z.1 * margB q z.2) hq
    (fun z => mul_nonneg (hmA _) (hmB _)) (fun z hz => ?_) hq1 ?_
  · rcases mul_eq_zero.mp hz with h | h
    · exact (sum_eq_zero_iff_of_nonneg (fun y _ => hq _)).mp h z.2 (mem_univ _)
    · exact (sum_eq_zero_iff_of_nonneg (fun x _ => hq _)).mp h z.1 (mem_univ _)
  · rw [Fintype.sum_prod_type, ← sum_mul_sum, sum_margA, sum_margB, hq1, one_mul]

/-- **Subadditivity.** `H(R′B′) ≤ H(R′) + H(B′)`. -/
theorem ent_le_ent_marg (q : α × β → ℝ) (hq : ∀ z, 0 ≤ q z) (hq1 : ∑ z, q z = 1) :
    ent q ≤ ent (margA q) + ent (margB q) := by
  have := mutualInfo_nonneg q hq hq1
  rw [mutualInfo_eq q hq] at this
  linarith

end Joint

/-! ## The Gibbs state -/

section Gibbs

variable {β : Type*} [Fintype β] [Nonempty β] (b : ℝ) (E : β → ℝ)

/-- Partition function `Z = Σ e^{−βE}`. -/
noncomputable def partition : ℝ := ∑ y, exp (-b * E y)

/-- The Gibbs state `γ = e^{−βE}/Z`. -/
noncomputable def gibbs (y : β) : ℝ := exp (-b * E y) / partition b E

theorem partition_pos : 0 < partition b E :=
  sum_pos (fun _ _ => exp_pos _) univ_nonempty

theorem gibbs_pos (y : β) : 0 < gibbs b E y := div_pos (exp_pos _) (partition_pos b E)

theorem gibbs_sum_one : ∑ y, gibbs b E y = 1 := by
  unfold gibbs
  rw [← sum_div]
  exact div_self (partition_pos b E).ne'

theorem log_gibbs (y : β) : log (gibbs b E y) = -b * E y - log (partition b E) := by
  rw [gibbs, log_div (exp_pos _).ne' (partition_pos b E).ne', log_exp]

/-- `H(γ) = β⟨E⟩_γ + ln Z`. -/
theorem ent_gibbs : ent (gibbs b E) = b * ∑ y, gibbs b E y * E y + log (partition b E) := by
  unfold ent
  have : ∑ y, negMulLog (gibbs b E y)
      = b * ∑ y, gibbs b E y * E y + log (partition b E) * ∑ y, gibbs b E y := by
    rw [mul_sum, mul_sum, ← sum_add_distrib]
    refine sum_congr rfl fun y _ => ?_
    rw [negMulLog, log_gibbs]
    ring
  rw [this, gibbs_sum_one, mul_one]

/-- `H(a) ≤ β⟨E⟩_a + ln Z` for every law `a` on the bath. -/
theorem ent_le_energy (a : β → ℝ) (ha : ∀ y, 0 ≤ a y) (ha1 : ∑ y, a y = 1) :
    ent a ≤ b * ∑ y, a y * E y + log (partition b E) := by
  have hk := kl_nonneg a (gibbs b E) ha (fun y => (gibbs_pos b E y).le)
    (fun y h => absurd h (gibbs_pos b E y).ne') ha1 (gibbs_sum_one b E)
  rw [sum_congr rfl fun y _ =>
    mul_log_div_eq (ha y) (gibbs_pos b E y).le (fun h => absurd h (gibbs_pos b E y).ne')] at hk
  have : ∑ y, (-negMulLog (a y) - a y * log (gibbs b E y))
      = -ent a + b * ∑ y, a y * E y + log (partition b E) * ∑ y, a y := by
    unfold ent
    rw [mul_sum, mul_sum, ← sum_neg_distrib, ← sum_add_distrib, ← sum_add_distrib]
    refine sum_congr rfl fun y _ => ?_
    rw [log_gibbs]
    ring
  rw [this, ha1, mul_one] at hk
  linarith

end Gibbs

/-! ## Reversible reset against a thermal bath -/

section Reset

variable {α β : Type*} [Fintype α] [Fintype β] [Nonempty β]

/-- The joint law after the reversible map `σ`, starting from `p ⊗ γ`. -/
noncomputable def evolve (p : α → ℝ) (b : ℝ) (E : β → ℝ) (σ : α × β ≃ α × β) (z : α × β) : ℝ :=
  p (σ.symm z).1 * gibbs b E (σ.symm z).2

variable (p : α → ℝ) (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1) (b : ℝ) (E : β → ℝ)
  (σ : α × β ≃ α × β)

omit [Fintype α] in
include hp in
theorem evolve_nonneg (z : α × β) : 0 ≤ evolve p b E σ z :=
  mul_nonneg (hp _) (gibbs_pos b E _).le

include hp1 in
theorem evolve_sum : ∑ z, evolve p b E σ z = 1 := by
  unfold evolve
  rw [Equiv.sum_comp σ.symm (fun z => p z.1 * gibbs b E z.2), Fintype.sum_prod_type,
    ← sum_mul_sum, hp1, gibbs_sum_one, one_mul]

include hp1 in
/-- **Reversible dynamics conserves the joint entropy**, which starts at
`H(p) + H(γ)`. -/
theorem ent_evolve : ent (evolve p b E σ) = ent p + ent (gibbs b E) := by
  unfold ent evolve
  rw [Equiv.sum_comp σ.symm (fun z => negMulLog (p z.1 * gibbs b E z.2)), Fintype.sum_prod_type]
  simp only [negMulLog_mul, sum_add_distrib, ← mul_sum, ← sum_mul, gibbs_sum_one, hp1, one_mul]

/-- Heat delivered to the bath: its energy gain `ΔQ_B = ⟨E⟩_{q_B} − ⟨E⟩_γ`. -/
noncomputable def heat : ℝ :=
  ∑ y, margB (evolve p b E σ) y * E y - ∑ y, gibbs b E y * E y

/-- Entropy removed from the register: `ΔS_R = H(p) − H(q_R)`. -/
noncomputable def entDrop : ℝ := ent p - ent (margA (evolve p b E σ))

include hp hp1 in
/-- **The Reeb–Wolf identity.** `β ΔQ_B − ΔS_R = I(R′ : B′) + D(q_B ‖ γ)`. -/
theorem reeb_wolf_identity :
    b * heat p b E σ - entDrop p b E σ
      = mutualInfo (evolve p b E σ)
        + ∑ y, margB (evolve p b E σ) y * log (margB (evolve p b E σ) y / gibbs b E y) := by
  set q := evolve p b E σ
  have hq := evolve_nonneg p hp b E σ
  have hqB : ∀ y, 0 ≤ margB q y := fun y => sum_nonneg fun x _ => hq _
  have hqB1 : ∑ y, margB q y = 1 := by rw [sum_margB]; exact evolve_sum p hp1 b E σ
  have hD : ∑ y, margB q y * log (margB q y / gibbs b E y)
      = -ent (margB q) + b * ∑ y, margB q y * E y + log (partition b E) := by
    rw [sum_congr rfl fun y _ => mul_log_div_eq (hqB y) (gibbs_pos b E y).le
      (fun h => absurd h (gibbs_pos b E y).ne')]
    have : ∑ y, (-negMulLog (margB q y) - margB q y * log (gibbs b E y))
        = -ent (margB q) + b * ∑ y, margB q y * E y + log (partition b E) * ∑ y, margB q y := by
      unfold ent
      rw [mul_sum, mul_sum, ← sum_neg_distrib, ← sum_add_distrib, ← sum_add_distrib]
      refine sum_congr rfl fun y _ => ?_
      rw [log_gibbs]
      ring
    rw [this, hqB1, mul_one]
  rw [hD, mutualInfo_eq q hq, ent_evolve p hp1 b E σ, ent_gibbs]
  unfold heat entDrop
  ring

include hp hp1 in
/-- **Landauer's bound.** `β ΔQ_B ≥ ΔS_R`. -/
theorem landauer : entDrop p b E σ ≤ b * heat p b E σ := by
  have hid := reeb_wolf_identity p hp hp1 b E σ
  set q := evolve p b E σ
  have hq := evolve_nonneg p hp b E σ
  have hq1 := evolve_sum p hp1 b E σ
  have hI := mutualInfo_nonneg q hq hq1
  have hqB : ∀ y, 0 ≤ margB q y := fun y => sum_nonneg fun x _ => hq _
  have hqB1 : ∑ y, margB q y = 1 := by rw [sum_margB]; exact hq1
  have hK := kl_nonneg (margB q) (gibbs b E) hqB (fun y => (gibbs_pos b E y).le)
    (fun y h => absurd h (gibbs_pos b E y).ne') hqB1 (gibbs_sum_one b E)
  linarith

include hp hp1 in
/-- **Landauer erasure.** Resetting the register to a deterministic state
(`H(q_R) = 0`) at temperature `T` costs heat `Q_B ≥ k_BT · H(p)`. -/
theorem landauer_erasure {kT : ℝ} (hkT : 0 < kT) (hb : b = 1 / kT)
    (hreset : ent (margA (evolve p b E σ)) = 0) : kT * ent p ≤ heat p b E σ := by
  subst hb
  have h := landauer p hp hp1 (1 / kT) E σ
  rw [entDrop, hreset, sub_zero, div_mul_eq_mul_div, one_mul, le_div_iff₀ hkT] at h
  linarith

include hp hp1 in
/-- **Guard 1 (canon §8.1), derived.** If the reset removes at least
`I_M + D_err + δ_I` nats from the register, the bath absorbs them:
`Q_B / k_BT ≥ I_M + D_err + δ_I`. -/
theorem guard_one {kT IM Derr δI : ℝ} (hb : b = 1 / kT)
    (hexport : IM + Derr + δI ≤ entDrop p b E σ) : heat p b E σ / kT ≥ IM + Derr + δI := by
  subst hb
  have h := landauer p hp hp1 (1 / kT) E σ
  rw [div_mul_eq_mul_div, one_mul] at h
  linarith

include hp hp1 in
/-- **Cycle work floor with guard 1 derived.** With the reset modelled as
reversible dynamics against a Gibbs bath, gross charging of the escrow loss
gives `W ≥ k_BT(I_M + D_err + δ_I) + (1 − η)C` with no second-law hypothesis. -/
theorem cycle_work_floor_derived {kT IM Derr δI η C W : ℝ} (hkT : 0 < kT) (hb : b = 1 / kT)
    (hexport : IM + Derr + δI ≤ entDrop p b E σ) (hcharge : W ≥ heat p b E σ + (1 - η) * C) :
    W ≥ kT * (IM + Derr + δI) + (1 - η) * C :=
  Snuffy.ThermoLedger.cycle_work_floor hkT (guard_one p hp hp1 b E σ hb hexport) hcharge

end Reset

end Snuffy.Landauer
