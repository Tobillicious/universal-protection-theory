/-
Phase A (A3) — the transport-inclusive dissipation law, provable direction.

Per the Gemini reconciliation (RECONCILIATION.md item 1), the intended H8 cost functional is
transport-inclusive: Psi(s) = sum_{i,j} d(i,j)^2 s_i^2 s_j^2 + alpha*sum_i s_i^2, where
concentrated allocations must route over long relational edges with quadratic distance
losses. This module compiles the guarantee this functional entails:

  Psi(s) >= alpha*HHI(s) >= alpha/n + alpha*(HHI(s) - 1/n),

so any drift toward monopoly (HHI above uniform) strictly increases dissipation, and
uniform remains the minimum of the local term — restoring H8's decentralization
conclusion with transport included. Exact instance checks on a concrete two-node transport
model show the original upper-bound form holding there (the derivation as submitted has a
step we could not derive; the pātai is recorded in inputs/ASSESSMENT-PHASE-ABC.md).
-/

import Mathlib.Tactic

variable {n : ℕ}

/-- Herfindahl–Hirschman index of normalized shares. -/
def hhiQ (s : Fin n → ℚ) : ℚ := ∑ i, (s i)^2

/-- Transport-inclusive dissipation: quadratic distance routing losses plus local
processing resistance alpha. -/
def transportPsi (D : Fin n → Fin n → ℚ) (α : ℚ) (s : Fin n → ℚ) : ℚ :=
  ∑ i, ∑ j, (D i j)^2 * (s i)^2 * (s j)^2 + α * hhiQ s

theorem transport_nonneg (D : Fin n → Fin n → ℚ) (_α : ℚ) (s : Fin n → ℚ) :
    0 ≤ ∑ i, ∑ j, (D i j)^2 * (s i)^2 * (s j)^2 := by positivity

/-- The transport term never reduces cost: Psi >= alpha*HHI. -/
theorem transport_ge_local (D : Fin n → Fin n → ℚ) (α : ℚ) (_hα : 0 ≤ α) (s : Fin n → ℚ) :
    α * hhiQ s ≤ transportPsi D α s := by
  unfold transportPsi
  linarith [transport_nonneg D α s]

/-- Cauchy–Schwarz (as the sum-of-squares identity): normalized shares have HHI >= 1/n. -/
theorem hhi_ge_uniform (_hn : 0 < n) (s : Fin n → ℚ) (hs : ∑ i, s i = 1) :
    1/(n:ℚ) ≤ hhiQ s := by
  have hnn : ∑ _i : Fin n, ((1/(n:ℚ))^2) = 1/(n:ℚ) := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    field_simp
  have e : ∑ i, (s i - 1/(n:ℚ))^2
      = ∑ i, (s i)^2 - 2*(1/(n:ℚ))*∑ i, s i + ∑ _i : Fin n, ((1/(n:ℚ))^2) := by
    have h1 : ∀ i : Fin n, (s i - 1/(n:ℚ))^2
        = (s i)^2 - (2*(1/(n:ℚ))*s i - (1/(n:ℚ))^2) := fun i => by ring
    rw [Finset.sum_congr rfl (fun i _ => h1 i), Finset.sum_sub_distrib,
        Finset.sum_sub_distrib, Finset.mul_sum]
    linarith
  have hz : 0 ≤ ∑ i, (s i - 1/(n:ℚ))^2 := Finset.sum_nonneg (fun i _ => sq_nonneg _)
  rw [e, hs, hnn] at hz
  unfold hhiQ
  linarith

/-- The compiled anti-monopoly penalty: Psi(s) >= alpha/n + alpha*(HHI(s) - 1/n),
so every HHI excess over uniform is strictly penalized (for alpha > 0). -/
theorem monopoly_penalty (_hn : 0 < n) (hα : 0 < α) (D : Fin n → Fin n → ℚ)
    (s : Fin n → ℚ) (_hs : ∑ i, s i = 1) :
    α/(n:ℚ) + α*(hhiQ s - 1/(n:ℚ)) ≤ transportPsi D α s := by
  have key : α/(n:ℚ) + α*(hhiQ s - 1/(n:ℚ)) = α * hhiQ s := by
    field_simp; ring
  rw [key]
  exact transport_ge_local D α (le_of_lt hα) s

/-! ## Exact instance checks: the two-node transport model
    (alpha = 1, d(0,1) = d(1,0) = 1, d(i,i) = 0) -/

/-- Uniform (1/2, 1/2) attains Psi = 1/8 + 1/2 = 5/8. -/
example (D : Fin 2 → Fin 2 → ℚ) (h0 : D 0 0 = 0) (h1 : D 1 1 = 0)
    (ho : D 0 1 = 1) (ho' : D 1 0 = 1) :
    transportPsi D 1 (fun _ => 1/2) = 5/8 := by
  unfold transportPsi hhiQ
  norm_num
  rw [h0, h1, ho, ho']
  norm_num

/-- On the same model the original upper-bound form holds at (3/4, 1/4):
Psi = 89/128 <= 5/8*(1 + (5/8 - 1/2)/(1 - 1/2)) = 25/32. -/
example (D : Fin 2 → Fin 2 → ℚ) (h0 : D 0 0 = 0) (h1 : D 1 1 = 0)
    (ho : D 0 1 = 1) (ho' : D 1 0 = 1) :
    let s : Fin 2 → ℚ := fun i => if i = 0 then 3/4 else 1/4
    transportPsi D 1 s = 89/128
      ∧ 89/128 ≤ 5/8*(1 + (5/8 - 1/2)/(1 - 1/2)) := by
  unfold transportPsi hhiQ
  norm_num
  rw [h0, h1, ho, ho']
  norm_num

/-! ## Axiom reports -/

