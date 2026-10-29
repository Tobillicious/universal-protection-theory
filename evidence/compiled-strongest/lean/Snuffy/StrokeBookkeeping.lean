/-
Snuffy — Canon Edition v4.1: the stroke bookkeeping of Theorem 8 derived
(§18.2 Stroke II; Chapter 1, §1.1). `ThermoLedger.stroke_identity` takes
`ΔS_S = I₂ − I₁` as a hypothesis; here it is proved for the feedback stroke.

After Stroke I the system–memory state is block-diagonal in the memory basis.
Stroke II applies the controlled unitary `U = Σ_m U_m ⊗ |m⟩⟨m|`.

  * controlled_unitary — a controlled unitary with unitary blocks is unitary.
  * ptrB_controlled — it leaves the memory's reduced state unchanged on
    states block-diagonal in the memory basis.
  * stroke_entropy_change — therefore the system's entropy change equals the
    change of the system–memory mutual information: `ΔS_S = I₂ − I₁`.
  * stroke_identity_derived — `ThermoLedger.stroke_identity` with its
    correlation hypothesis discharged for the feedback stroke.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.QuantumLandauer

open Matrix Finset
open scoped ComplexOrder

namespace Snuffy.StrokeBookkeeping

open Snuffy.QuantumLandauer

variable {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]

/-- The controlled unitary `Σ_m W_m ⊗ |m⟩⟨m|` (system `α`, memory `β`). -/
def controlled (W : β → Matrix α α ℂ) : Matrix (α × β) (α × β) ℂ :=
  fun z w => if z.2 = w.2 then W z.2 z.1 w.1 else 0

omit [DecidableEq α] [Fintype β] [DecidableEq β] in
theorem ptrB_isHermitian {ρ : Matrix (α × β) (α × β) ℂ} (hρ : ρ.IsHermitian) :
    (ptrB ρ).IsHermitian := by
  refine IsHermitian.ext fun k k' => ?_
  simp only [ptrB, star_sum]
  exact sum_congr rfl fun i _ => hρ.apply (i, k) (i, k')

omit [DecidableEq α] in
theorem controlled_mul_apply (W : β → Matrix α α ℂ) (M : Matrix (α × β) (α × β) ℂ)
    (i : α) (m : β) (z : α × β) :
    (controlled W * M) (i, m) z = ∑ k, W m i k * M (k, m) z := by
  simp only [mul_apply, Fintype.sum_prod_type, controlled, ite_mul, zero_mul]
  exact sum_congr rfl fun k _ => by rw [sum_ite_eq]; simp

omit [DecidableEq α] in
theorem mul_star_controlled_apply (W : β → Matrix α α ℂ) (M : Matrix (α × β) (α × β) ℂ)
    (z : α × β) (j : α) (m' : β) :
    (M * star (controlled W)) z (j, m') = ∑ k, M z (k, m') * star (W m' j k) := by
  simp only [mul_apply, Fintype.sum_prod_type, star_apply, controlled, apply_ite (star : ℂ → ℂ),
    star_zero, mul_ite, mul_zero]
  exact sum_congr rfl fun k _ => by rw [sum_ite_eq]; simp

/-- **A controlled unitary is unitary.** -/
theorem controlled_unitary (W : β → Matrix α α ℂ) (hW : ∀ m, W m ∈ unitaryGroup α ℂ) :
    controlled W ∈ unitaryGroup (α × β) ℂ := by
  rw [mem_unitaryGroup_iff]
  ext ⟨i, m⟩ ⟨j, m'⟩
  rw [controlled_mul_apply]
  simp only [star_apply, controlled, apply_ite (star : ℂ → ℂ), star_zero, mul_ite, mul_zero,
    one_apply, Prod.mk.injEq]
  by_cases hm : m' = m
  · subst hm
    simp only [ite_true, and_true]
    have h := congrFun (congrFun (mem_unitaryGroup_iff.mp (hW m')) i) j
    simp only [mul_apply, star_apply, one_apply] at h
    exact h
  · simp only [hm, ite_false, sum_const_zero]
    have hne : ¬ (i = j ∧ m = m') := fun h => hm h.2.symm
    simp only [hne, ite_false]

/-- **The memory's reduced state is unchanged** by a controlled unitary acting
on a state block-diagonal in the memory basis. -/
theorem ptrB_controlled (W : β → Matrix α α ℂ) (hW : ∀ m, W m ∈ unitaryGroup α ℂ)
    (ρ : Matrix (α × β) (α × β) ℂ) (hblock : ∀ i j m m', m ≠ m' → ρ (i, m) (j, m') = 0) :
    ptrB (controlled W * ρ * star (controlled W)) = ptrB ρ := by
  ext m m'
  simp only [ptrB]
  have hentry : ∀ i, (controlled W * ρ * star (controlled W)) (i, m) (i, m')
      = ∑ j, ∑ k, W m i j * ρ (j, m) (k, m') * star (W m' i k) := by
    intro i
    rw [Matrix.mul_assoc, controlled_mul_apply]
    refine sum_congr rfl fun j _ => ?_
    rw [mul_star_controlled_apply, Finset.mul_sum]
    exact sum_congr rfl fun k _ => by ring
  simp_rw [hentry]
  by_cases hm : m = m'
  · subst hm
    have hcol : ∀ j k, ∑ i, W m i j * star (W m i k) = if k = j then 1 else 0 := by
      intro j k
      have h := congrFun (congrFun (mem_unitaryGroup_iff'.mp (hW m)) k) j
      simp only [mul_apply, star_apply, one_apply] at h
      rw [← h]
      exact sum_congr rfl fun i _ => mul_comm _ _
    rw [sum_comm]
    refine sum_congr rfl fun j _ => ?_
    rw [sum_comm]
    have : ∀ k, ∑ i, W m i j * ρ (j, m) (k, m) * star (W m i k)
        = ρ (j, m) (k, m) * (if k = j then 1 else 0) := by
      intro k
      rw [← hcol j k, Finset.mul_sum]
      exact sum_congr rfl fun i _ => by ring
    simp_rw [this, mul_ite, mul_one, mul_zero, sum_ite_eq', mem_univ, ite_true]
  · have hz : ∀ j k, ρ (j, m) (k, m') = 0 := fun j k => hblock j k m m' hm
    simp only [hz, mul_zero, zero_mul, sum_const_zero]

/-- The system–memory mutual information `I = S(S) + S(M) − S(SM)`. -/
noncomputable def qmi {ρ : Matrix (α × β) (α × β) ℂ} (hρ : ρ.IsHermitian) : ℝ :=
  vnEnt (ptrA_isHermitian hρ) + vnEnt (ptrB_isHermitian hρ) - vnEnt hρ

/-- **ΔS_S = I₂ − I₁ for the feedback stroke.** For a state block-diagonal in
the memory basis and a controlled unitary with unitary blocks, the system's
entropy change equals the change of the system–memory mutual information. -/
theorem stroke_entropy_change (W : β → Matrix α α ℂ) (hW : ∀ m, W m ∈ unitaryGroup α ℂ)
    {ρ : Matrix (α × β) (α × β) ℂ} (hρ : ρ.IsHermitian)
    (hblock : ∀ i j m m', m ≠ m' → ρ (i, m) (j, m') = 0)
    (hρ' : (controlled W * ρ * star (controlled W)).IsHermitian) :
    vnEnt (ptrA_isHermitian hρ') - vnEnt (ptrA_isHermitian hρ) = qmi hρ' - qmi hρ := by
  have hS : vnEnt hρ' = vnEnt hρ := vnEnt_unitary_conj hρ (controlled_unitary W hW) hρ'
  have hM : vnEnt (ptrB_isHermitian hρ') = vnEnt (ptrB_isHermitian hρ) := by
    apply vnEnt_congr
    rw [ptrB_controlled W hW ρ hblock]
  unfold qmi
  rw [hS, hM]
  ring

/-- **The stroke identity with its correlation hypothesis derived.** With the
first law `U₂ − U₁ = W − Q` for the system across the feedback stroke, the
system's free-energy change is `β W − β Q + I₁ − I₂`, where `I₁, I₂` are the
system–memory mutual informations before and after the controlled unitary. -/
theorem stroke_identity_derived (W : β → Matrix α α ℂ) (hW : ∀ m, W m ∈ unitaryGroup α ℂ)
    {ρ : Matrix (α × β) (α × β) ℂ} (hρ : ρ.IsHermitian)
    (hblock : ∀ i j m m', m ≠ m' → ρ (i, m) (j, m') = 0)
    (hρ' : (controlled W * ρ * star (controlled W)).IsHermitian)
    {β' lnZ U₁ U₂ Wk Q : ℝ} (hfirst : U₂ - U₁ = Wk - Q) :
    (-vnEnt (ptrA_isHermitian hρ') + β' * U₂ + lnZ) - (-vnEnt (ptrA_isHermitian hρ) + β' * U₁ + lnZ)
      = β' * Wk - β' * Q + qmi hρ - qmi hρ' :=
  Snuffy.ThermoLedger.stroke_identity hfirst (stroke_entropy_change W hW hρ hblock hρ')

end Snuffy.StrokeBookkeeping
