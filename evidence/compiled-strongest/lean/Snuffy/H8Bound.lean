/-
Snuffy — Canon Edition v4.1: bridge 8, the original H8 bound at full strength,

  Ψ ≤ Ψ_min (1 + (HHI − 1/n)/(1 − 1/n)),

derived from one cost-law inequality: the concentration cost is at most the
baseline. With `δᵢ = sᵢ − 1/n`, `Σδᵢ² = HHI − 1/n` (`variance_identity`).

  * h8_of_concentration_bound — if the cost above baseline is at most `λ Σδᵢ²`
    and `λ(1 − 1/n) ≤ Ψ_min`, the H8 bound holds for every allocation.
  * h8_graph — the transport-inclusive form: cost `Ψ_min + δᵀQδ` with any
    matrix `Q` (the graph-Laplacian transport form included) whose quadratic
    form is at most `λ|δ|²`; H8 holds whenever `λ(1 − 1/n) ≤ Ψ_min`.
  * routing_bound, h8_routed — J-H8 on the BCRD graph. The optimal transport
    cost is at most that of any routing `J = Rδ` of the deviations over edges
    of length `d_e`, and by Cauchy–Schwarz
    `ν Σ_e d_e² J_e² ≤ ν (Σ_e d_e² Σ_i R_ei²) Σδᵢ²`. So H8 holds whenever
    `ν (Σ_e d_e² Σ_i R_ei²)(1 − 1/n) ≤ Ψ_min`: a constant read off the graph
    metric (for tree routing, `Σ_i` of the squared edge lengths on `i`'s path).
  * h8_iff — the isotropic cost `Ψ_min + κΣδᵢ²` satisfies H8 at every
    allocation iff `κ(1 − 1/n) ≤ Ψ_min`: the condition is exact.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.BridgeH8

open Finset Matrix

namespace Snuffy.H8Bound

open GeminiBridgeH8

lemma one_sub_u_pos {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (uniform : (n : ℝ) * u = 1) : 0 < 1 - u := by
  have hn' : (2 : ℝ) ≤ n := by exact_mod_cast hn
  nlinarith

/-- **H8 from the concentration bound.** -/
theorem h8_of_concentration_bound {n : ℕ} (hn : 2 ≤ n) (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i = 1) (uniform : (n : ℝ) * u = 1) {Ψmin lam extra : ℝ}
    (hextra : extra ≤ lam * ∑ i, (s i - u) ^ 2) (hlam : lam * (1 - u) ≤ Ψmin) :
    Ψmin + extra ≤ Ψmin * (1 + (energy s - u) / (1 - u)) := by
  have hpos := one_sub_u_pos hn uniform
  have hV : 0 ≤ ∑ i, (s i - u) ^ 2 := sum_nonneg fun i _ => sq_nonneg _
  rw [variance_identity s u normalized uniform] at hextra hV
  have key : lam * (energy s - u) ≤ Ψmin * ((energy s - u) / (1 - u)) := by
    rw [mul_div_assoc', le_div_iff₀ hpos]
    nlinarith
  nlinarith

/-- **H8, transport-inclusive graph form.** -/
theorem h8_graph {n : ℕ} (hn : 2 ≤ n) (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i = 1) (uniform : (n : ℝ) * u = 1) (Q : Matrix (Fin n) (Fin n) ℝ)
    {Ψmin lam : ℝ} (hQ : ∀ x : Fin n → ℝ, x ⬝ᵥ (Q *ᵥ x) ≤ lam * (x ⬝ᵥ x))
    (hlam : lam * (1 - u) ≤ Ψmin) :
    Ψmin + (fun i => s i - u) ⬝ᵥ (Q *ᵥ fun i => s i - u) ≤
      Ψmin * (1 + (energy s - u) / (1 - u)) := by
  apply h8_of_concentration_bound hn s u normalized uniform _ hlam
  have h := hQ (fun i => s i - u)
  have hdot : (fun i => s i - u) ⬝ᵥ (fun i => s i - u) = ∑ i, (s i - u) ^ 2 := by
    simp [dotProduct, sq]
  rwa [hdot] at h

/-- **H8 is exact.** The isotropic cost satisfies H8 at every allocation iff
`κ(1 − 1/n) ≤ Ψ_min`. -/
theorem h8_iff {n : ℕ} (hn : 2 ≤ n) (u : ℝ) (uniform : (n : ℝ) * u = 1) (Ψmin κ : ℝ) :
    (∀ s : Fin n → ℝ, ∑ i, s i = 1 →
        Ψmin + κ * ∑ i, (s i - u) ^ 2 ≤ Ψmin * (1 + (energy s - u) / (1 - u))) ↔
      κ * (1 - u) ≤ Ψmin := by
  have hpos := one_sub_u_pos hn uniform
  constructor
  · intro h
    let i0 : Fin n := ⟨0, by omega⟩
    let e : Fin n → ℝ := fun j => if j = i0 then 1 else 0
    have he : ∑ j, e j = 1 := by simp [e]
    have hen : energy e = 1 := by
      unfold energy
      have : ∀ j, e j ^ 2 = e j := fun j => by by_cases hj : j = i0 <;> simp [e, hj]
      simp_rw [this]
      exact he
    have hv := variance_identity e u he uniform
    have := h e he
    rw [hv, hen, div_self hpos.ne'] at this
    linarith
  · intro hk s hs
    exact h8_of_concentration_bound hn s u hs uniform le_rfl hk

/-- **Routing bound** (Cauchy–Schwarz on every edge). -/
theorem routing_bound {E V : Type*} [Fintype E] [Fintype V] (w : E → ℝ) (hw : ∀ e, 0 ≤ w e)
    (R : E → V → ℝ) (δ : V → ℝ) :
    ∑ e, w e * (∑ i, R e i * δ i) ^ 2 ≤ (∑ e, w e * ∑ i, R e i ^ 2) * ∑ i, δ i ^ 2 := by
  rw [sum_mul]
  apply sum_le_sum
  intro e _
  rw [mul_assoc]
  exact mul_le_mul_of_nonneg_left (sum_mul_sq_le_sq_mul_sq _ _ _) (hw e)

/-- **J-H8 on the BCRD graph.** If the network's transport cost is at most that
of a routing `J = Rδ` over edges of length `d_e` (the optimal flow is), H8
holds whenever `ν (Σ_e d_e² Σ_i R_ei²)(1 − 1/n) ≤ Ψ_min`. -/
theorem h8_routed {n : ℕ} (hn : 2 ≤ n) (s : Fin n → ℝ) (u : ℝ)
    (normalized : ∑ i, s i = 1) (uniform : (n : ℝ) * u = 1) {E : Type*} [Fintype E]
    (d : E → ℝ) (R : E → Fin n → ℝ) {ν Ψmin T : ℝ} (hν : 0 ≤ ν)
    (htrans : T ≤ ν * ∑ e, d e ^ 2 * (∑ i, R e i * (s i - u)) ^ 2)
    (hgraph : ν * (∑ e, d e ^ 2 * ∑ i, R e i ^ 2) * (1 - u) ≤ Ψmin) :
    Ψmin + T ≤ Ψmin * (1 + (energy s - u) / (1 - u)) := by
  apply h8_of_concentration_bound hn s u normalized uniform _ hgraph
  have hr := routing_bound (fun e => d e ^ 2) (fun e => sq_nonneg _) R (fun i => s i - u)
  calc T ≤ ν * ∑ e, d e ^ 2 * (∑ i, R e i * (s i - u)) ^ 2 := htrans
    _ ≤ ν * ((∑ e, d e ^ 2 * ∑ i, R e i ^ 2) * ∑ i, (s i - u) ^ 2) :=
        mul_le_mul_of_nonneg_left hr hν
    _ = ν * (∑ e, d e ^ 2 * ∑ i, R e i ^ 2) * ∑ i, (s i - u) ^ 2 := by ring

end Snuffy.H8Bound
