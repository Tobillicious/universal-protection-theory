/-
Phase A integration — compiled components of the second received wave (24 October 2026).

1. A1: the submitted decomposition K = M P + E(I−P) reduces the typed-gate condition
   P K P = K P to P M P = M P exactly; compiled here in any ring (p idempotent).
2. A2: the complete FIFO deadline guarantee under outage inflation, proven by induction —
   with the interval workload premise (the earlier submission's own step-2 condition).
   Note: the per-job-only premise of the newest sketch is insufficient in general (two
   unit-budget jobs released together against a one-unit slack break it); the interval
   premise below is what the max-plus recurrence actually needs, and the theorem is then
   unconditional given that premise. No sorry.
3. A3: the original H8 upper bound at FULL strength, proven for the complete symmetric
   two-node transport family (all alpha, beta > 0, all shares) — Ψ ≤ Ψ_min(1+(HHI−1/2)/(1/2)).
   Plus two exact three-node equilateral instances recording, for the sharpened pātai,
   what the submitted general derivation must exclude or repair.
-/

import Snuffy.FIFOInstance
import Snuffy.TransportLaw

/-! ## A1: typed-gate decomposition -/

section Gate
variable {R : Type*} [Ring R]

/-- Submitted refinement structure: K = M·P + E·(I−P). The gate condition for K reduces
exactly to the gate condition for M: (1−P)·P = 0 kills the rejection branch. -/
theorem typed_gate_decomposition (p m e : R) (hp : p*p = p) (hM : p*m*p = m*p) :
    p*(m*p + e*(1 - p))*p = (m*p + e*(1 - p))*p := by
  have h0 : (1 - p)*p = 0 := by
    rw [sub_mul, one_mul, hp, sub_self]
  have hl : p*(m*p + e*(1 - p))*p = p*m*p := by
    simp only [mul_add, add_mul, mul_assoc, h0, mul_zero, add_zero, hp]
  have hr : (m*p + e*(1 - p))*p = m*p := by
    simp only [add_mul, mul_assoc, h0, mul_zero, add_zero, hp]
  rw [hl, hr]
  exact hM

end Gate

/-! ## A2: interval-workload FIFO deadline guarantee (no sorry) -/

/-- Total remaining budget of a suffix. -/
def sumB : List (ℚ × ℚ) → ℚ
  | [] => 0
  | (_, b) :: tail => b + sumB tail

/-- Interval workload condition at deadline D: for every job k of the suffix chain,
F_k + (remaining budgets after k) ≤ D — i.e. max(base, r_k) + b_k + Σ_{j>k} b_j ≤ D,
recursively. This is the contiguous-interval premise r_k + Σ_{j=k}^N b_j ≤ d_N of the
earlier submission's A2.1 step 2, with the recurrence's carry-in tracked exactly. -/
def intervalOK : List (ℚ × ℚ) → ℚ → ℚ → Prop
  | [], base, D => base ≤ D
  | (r, b) :: tail, base, D =>
      max base r + b + sumB tail ≤ D ∧ intervalOK tail (max base r + b) D

/-- Every job meets the deadline D under the interval workload condition: the exact
max-plus recurrence with outage-inflated budgets (b already includes the 1/(1−δ̄)
factor) satisfies F ≤ D. -/
theorem finish_interval_deadline (L : List (ℚ × ℚ)) :
    ∀ base D, intervalOK L base D → finishQ base L ≤ D := by
  induction L with
  | nil => intro base D h; exact h
  | cons head tail IH =>
      intro base D h
      obtain ⟨_h1, h2⟩ := h
      obtain ⟨r, b⟩ := head
      exact IH (max base r + b) D h2

/-! ## A3: the original H8 bound at full strength on the two-node transport family -/

/-- Dissipation of the symmetric two-node transport model with distance-squared β,
local resistance α, share vector (t, 1−t): transport 2β·u² + local α·(t²+(1−t)²). -/
def psi2 (β α t : ℚ) : ℚ := 2*β*(t*(1-t))^2 + α*(t^2 + (1-t)^2)

theorem psi2_uniform (β α : ℚ) : psi2 β α (1/2) = β/8 + α/2 := by
  unfold psi2; ring

/-- FULL-STRENGTH original H8 bound on the complete two-node transport family:
for every α, β > 0 and every share t ∈ [0,1],
Ψ(t) ≤ Ψ_min·(1 + (HHI(t) − 1/2)/(1 − 1/2)). -/
theorem h8_bound_two_node (α β t : ℚ) (_hα : 0 < α) (hβ : 0 < β)
    (ht : 0 ≤ t) (ht' : t ≤ 1) :
    psi2 β α t ≤ (β/8 + α/2)*(1 + ((t^2 + (1-t)^2) - 1/2)/(1 - 1/2)) := by
  have hnn : 0 ≤ t*(1-t) := by nlinarith [ht, ht']
  have hu : t*(1-t) ≤ 1/4 := by nlinarith [sq_nonneg (2*t - 1)]
  unfold psi2
  have hhh : t^2 + (1-t)^2 = 1 - 2*(t*(1-t)) := by ring
  have hu2 : 2*(t*(1-t))^2 ≤ (t*(1-t))/2 := by nlinarith [hu, hnn]
  have hb : 2*β*(t*(1-t))^2 + β*(t*(1-t))/2 ≤ β/4 := by nlinarith [hu2, hu, hβ]
  have hR : (β/8 + α/2)*(1 + ((1 - 2*(t*(1-t))) - 1/2)/(1 - 1/2))
      = β/4 - β*(t*(1-t))/2 + α - 2*α*(t*(1-t)) := by
    field_simp; ring
  rw [hhh, hR]
  linarith [hb]

/-! ## A3 pātai instances: the equilateral three-node transport family (exact) -/

/-- Equilateral three-node distances: 0 on the diagonal, 1 off it. -/
def d3 : Fin 3 → Fin 3 → ℚ := fun i j => if i = j then 0 else 1

/-- Instance 1 (bounds the submitted derivation): with α = β = 1 and s = (1/2, 1/2, 0),
the original upper-bound form is exceeded by exactly 25/216:
Ψ = 1/8 + 1/2 = 5/8 = 135/216, bound = (2/27 + 1/3)(5/4) = 110/216, Ψ − bound = 25/216 > 0. -/
example :
    transportPsi d3 1 (fun i => if i = 0 then 1/2 else if i = 1 then 1/2 else 0)
      - (2/27 + 1/3)*(1 + (1/2 - 1/3)/(1 - 1/3)) = 25/216 := by
  unfold transportPsi hhiQ d3
  norm_num [Fin.sum_univ_three]

/-- Instance 2 (traffic-model question): with β = 10, α = 1, the monopoly allocation
(1,0,0) has STRICTLY LOWER cost than uniform under the submitted traffic law f = s_i·s_j:
Ψ(monopoly) = 1 < Ψ_min = 200/27 + 1/3 = 209/27 (off-diagonal d = 10, so d² = 100) —
a monopolist ships nothing between nodes and pays no transport. The intended traffic
model for H8 must make monopoly pay transit. -/
example :
    transportPsi (fun (i j : Fin 3) => if i = j then (0:ℚ) else 10) 1
        (fun i => if i = 0 then 1 else 0) = 1
      ∧ transportPsi (fun (i j : Fin 3) => if i = j then (0:ℚ) else 10) 1
        (fun _ => 1/3) = 209/27 := by
  unfold transportPsi hhiQ
  norm_num [Fin.sum_univ_three]

/-! ## Axiom reports -/

