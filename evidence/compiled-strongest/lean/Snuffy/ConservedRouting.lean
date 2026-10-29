/-
P1c resolution — the conserved load-balanced traffic law (third received wave).

The conserved routing demand (each node's load must be routed: Σ_j D_ij = 1) kills the
monopolist free lunch: a monopoly pays its full demand-weighted transport profile.
On this law we compile:

1. `conserved_decomposes` — Ψ(s) = Σ_i (m_i + α)·s_i², with m_i the row transport profile.
2. `regular_psi_is_hhi` — on a REGULAR profile (m_i = m for all i; the demand-weighted
   analogue of H8's original vertex-transitive premise), Ψ(s) = (m + α)·HHI(s) exactly.
3. `monopoly_exceeds_uniform` — monopoly strictly exceeds uniform for n > 1 (the stub's
   theorem, with the regularity hypothesis supplied by the original premise class).
4. `h8_exact_general` — the exact general-n law:
   Ψ(s) = Ψ_min·(1 + (n−1)·(HHI − 1/n)/(1 − 1/n)) — an IDENTITY on the regular family.
   At n = 2 the factor (n−1) is 1: the ORIGINAL H8 bound, as an identity, at full strength.
   The original two-node formula is thus the n = 2 case of an exact law, and the general-n
   bound with factor (n−1) holds with equality — recorded as the reconciliation reading.
5. The P2/P3 packaging lemmas from the stub, with corrected hypotheses (strict ΛΓ > 0
   for strict positivity; the ≥ 0 version holds non-strictly).
-/

import Snuffy.TransportLaw

/-! ## The conserved routing family -/

structure RoutingDemand (n : ℕ) where
  D : Fin n → Fin n → ℚ
  h_nonneg : ∀ i j, 0 ≤ D i j
  h_row_sum : ∀ i, ∑ j, D i j = 1

/-- Conserved flow: node i's share s_i routed by its demand row. -/
def conservedFlow {n : ℕ} (s : Fin n → ℚ) (Dem : RoutingDemand n) (i j : Fin n) : ℚ :=
  s i * Dem.D i j

/-- Transport dissipation under conserved flow. -/
def conservedPsi {n : ℕ} (dist_sq : Fin n → Fin n → ℚ) (α : ℚ)
    (s : Fin n → ℚ) (Dem : RoutingDemand n) : ℚ :=
  (∑ i, ∑ j, dist_sq i j * (conservedFlow s Dem i j)^2) + α * hhiQ s

/-- Row transport profile: node i's demand-weighted squared distance. -/
def rowProfile {n : ℕ} (dist_sq : Fin n → Fin n → ℚ) (Dem : RoutingDemand n) (i : Fin n) : ℚ :=
  ∑ j, dist_sq i j * (Dem.D i j)^2

/-- Regular profile: every row's transport profile equals m — the demand-weighted
analogue of the vertex-transitive premise of the original H8. -/
def Regular {n : ℕ} (m : ℚ) (dist_sq : Fin n → Fin n → ℚ) (Dem : RoutingDemand n) : Prop :=
  ∀ i, rowProfile dist_sq Dem i = m

/-- The decomposition: conserved dissipation is a weighted sum of squared shares. -/
theorem conserved_decomposes {n : ℕ} (dist_sq : Fin n → Fin n → ℚ) (α : ℚ)
    (s : Fin n → ℚ) (Dem : RoutingDemand n) :
    conservedPsi dist_sq α s Dem = ∑ i, (rowProfile dist_sq Dem i + α) * (s i)^2 := by
  unfold conservedPsi conservedFlow rowProfile hhiQ
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hinner : ∑ j, dist_sq i j * (s i * Dem.D i j)^2
      = (s i)^2 * ∑ j, (dist_sq i j * (Dem.D i j)^2) := by
    calc ∑ j, dist_sq i j * (s i * Dem.D i j)^2
        = ∑ j, (s i)^2 * (dist_sq i j * (Dem.D i j)^2) :=
          Finset.sum_congr rfl fun j _ => by ring
      _ = (s i)^2 * ∑ j, (dist_sq i j * (Dem.D i j)^2) := by rw [Finset.mul_sum]
  rw [hinner]
  ring

/-- On a regular profile, dissipation is exactly proportional to HHI. -/
theorem regular_psi_is_hhi {n : ℕ} {m : ℚ} (dist_sq : Fin n → Fin n → ℚ) (α : ℚ)
    (Dem : RoutingDemand n) (hreg : Regular m dist_sq Dem) (s : Fin n → ℚ) :
    conservedPsi dist_sq α s Dem = (m + α) * hhiQ s := by
  rw [conserved_decomposes]
  have hL : ∑ i, (rowProfile dist_sq Dem i + α) * (s i)^2
      = ∑ i, (m + α) * (s i)^2 := by
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [hreg i]
  rw [hL]
  unfold hhiQ
  simp only [Finset.mul_sum]

theorem hhi_uniform (hn : 0 < n) : hhiQ (fun _ : Fin n => 1/(n:ℚ)) = 1/(n:ℚ) := by
  unfold hhiQ
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp

/-- At a concrete three-node population, the monopoly allocation has HHI exactly 1. -/
example : hhiQ (fun i : Fin 3 => if i = 0 then (1:ℚ) else 0) = 1 := by
  unfold hhiQ; simp

/-- The monopoly penalty (the stub's theorem, with regularity from the original premise
class): for n > 1 and m + α > 0, uniform strictly beats monopoly. -/
theorem monopoly_exceeds_uniform {n : ℕ} (hn : 1 < n) {m α : ℚ} (hpos : 0 < m + α)
    (dist_sq : Fin n → Fin n → ℚ) (Dem : RoutingDemand n) (hreg : Regular m dist_sq Dem)
    (s : Fin n → ℚ) (hs : hhiQ s = 1) :
    conservedPsi dist_sq α (fun _ => 1/(n:ℚ)) Dem < conservedPsi dist_sq α s Dem := by
  have h1q : (1:ℚ) < (n:ℚ) := by exact_mod_cast hn
  rw [regular_psi_is_hhi dist_sq α Dem hreg, regular_psi_is_hhi dist_sq α Dem hreg,
      hhi_uniform (by omega), hs, mul_one_div, mul_one]
  exact div_lt_self hpos h1q

/-! ## The exact general-n H8 law -/

/-- EXACT general-n law on the regular conserved-routing family:
Ψ(s) = Ψ_min·(1 + (n−1)·(HHI(s) − 1/n)/(1 − 1/n)) — an identity, hence also the ≤ bound.
At n = 2 the factor (n−1) is 1: the ORIGINAL H8 bound, as an identity, at full strength. -/
theorem h8_exact_general {n : ℕ} (hn : 1 < n) {m α : ℚ} (dist_sq : Fin n → Fin n → ℚ)
    (Dem : RoutingDemand n) (hreg : Regular m dist_sq Dem) (s : Fin n → ℚ) :
    conservedPsi dist_sq α s Dem
      = conservedPsi dist_sq α (fun _ => 1/(n:ℚ)) Dem
          * (1 + (n - 1)*(hhiQ s - 1/(n:ℚ))/(1 - 1/(n:ℚ))) := by
  rw [regular_psi_is_hhi dist_sq α Dem hreg, regular_psi_is_hhi dist_sq α Dem hreg,
      hhi_uniform (by omega)]
  have hq : ((n:ℚ)) ≠ 0 := by positivity
  have h1q : (1:ℚ) < (n:ℚ) := by exact_mod_cast hn
  have hd : (1:ℚ) - 1/(n:ℚ) ≠ 0 := by
    intro h
    field_simp at h
    linarith
  field_simp
  ring

/-! ## P2 and P3 packaging lemmas (from the stub, hypotheses corrected) -/

/-- Thermal ledger expression is strictly positive for kB, T, ln2 > 0, ΛΓ > 0, C_CP > 0.
(The stub's ≥ 0 hypothesis on ΛΓ yields only non-strict positivity, compiled as the
companion below.) -/
theorem thermal_ledger_positivity_strict (kB T ln2 delta_S mutual_info lambda_gamma C_cp : ℝ)
    (h_kB : kB > 0) (h_T : T > 0) (h_ln2 : ln2 > 0) (h_ds : delta_S ≥ 0) (h_mi : mutual_info ≥ 0)
    (h_lg : 0 < lambda_gamma) (h_ccp : 0 < C_cp) :
    kB * T * ln2 * (delta_S + mutual_info) + kB * T * (lambda_gamma * C_cp) > 0 := by
  have ha : 0 ≤ kB * T * ln2 * (delta_S + mutual_info) := by positivity
  have hb : 0 < kB * T * (lambda_gamma * C_cp) := by positivity
  linarith

theorem thermal_ledger_positivity_nonneg (kB T ln2 delta_S mutual_info lambda_gamma C_cp : ℝ)
    (h_kB : kB > 0) (h_T : T > 0) (h_ln2 : ln2 > 0) (h_ds : delta_S ≥ 0) (h_mi : mutual_info ≥ 0)
    (h_lg : lambda_gamma ≥ 0) (h_ccp : 0 < C_cp) :
    0 ≤ kB * T * ln2 * (delta_S + mutual_info) + kB * T * (lambda_gamma * C_cp) := by
  positivity

/-- The Jarzynski tail value is at most 1 whenever the required work meets the free-energy
difference. -/
theorem jarzynski_bound_valid (beta W_req delta_F : ℝ)
    (h_beta : beta > 0) (h_work : W_req ≥ delta_F) :
    Real.exp (-beta * (W_req - delta_F)) ≤ 1 := by
  rw [Real.exp_le_one_iff]
  have hw : 0 ≤ beta * (W_req - delta_F) :=
    mul_nonneg h_beta.le (sub_nonneg.mpr h_work)
  linarith

/-! ## Axiom reports -/

