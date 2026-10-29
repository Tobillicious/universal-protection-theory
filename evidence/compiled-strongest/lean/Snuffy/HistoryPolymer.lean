/-
Snuffy — full decoding histories for constructive thermal preparation.

The alternating BDL coarse maps give a deterministic history support bound.
Local zero-valid constraint systems restrict to separated support components.
The final finite-probability lemmas give the one-sided density guarantees for
large-polymer truncation, finite feed-forward branch sampling and CSS products.

The concrete BDL constraint scopes and the algorithmic cluster-expansion
application are derived in HISTORY-POLYMER-CONSTRUCTIVE-SAMPLER.md. This file
does not postulate a polymer gap, a mixing rate or an initially warm law.
-/

import Snuffy.WarmStart

open Finset

namespace Snuffy.HistoryPolymer

/-- A halving chain pays for every finite prefix and its remaining tail. -/
theorem halving_prefix (w : ℕ → ℝ) (hhalf : ∀ i, 2 * w (i + 1) ≤ w i) (n : ℕ) :
    (∑ i ∈ range n, w i) + 2 * w n ≤ 2 * w 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [sum_range_succ]
      have hh := hhalf n
      linarith

/-- Non-increasing intermediate steps plus halving every pair bound the
entire occupied history by four times the finest syndrome support. -/
theorem paired_history_bound (w : ℕ → ℝ) (hw : ∀ i, 0 ≤ w i)
    (hodd : ∀ i, w (2 * i + 1) ≤ w (2 * i))
    (hpair : ∀ i, 2 * w (2 * (i + 1)) ≤ w (2 * i)) (n : ℕ) :
    ∑ i ∈ range n, (w (2 * i) + w (2 * i + 1)) ≤ 4 * w 0 := by
  have hp := halving_prefix (fun i => w (2 * i)) hpair n
  have hn := hw (2 * n)
  have hs : (∑ i ∈ range n, w (2 * i)) ≤ 2 * w 0 := by
    simpa only [Nat.mul_zero] using (show (∑ i ∈ range n, w (2 * i)) ≤ 2 * w (2 * 0) by linarith)
  calc
    (∑ i ∈ range n, (w (2 * i) + w (2 * i + 1)))
        ≤ ∑ i ∈ range n, 2 * w (2 * i) :=
      sum_le_sum fun i _ => by have hi := hodd i; linarith
    _ = 2 * ∑ i ∈ range n, w (2 * i) := (mul_sum _ _ _).symm
    _ ≤ 4 * w 0 := by linarith

section Constraints

variable {V F : Type*} [DecidableEq V]

/-- A finite-scope constraint system with the all-zero assignment accepted. -/
structure LocalSystem (V F : Type*) where
  scope : F → Finset V
  accepts : F → (V → Bool) → Prop
  depends : ∀ f x y, (∀ v ∈ scope f, x v = y v) → (accepts f x ↔ accepts f y)
  zero_valid : ∀ f, accepts f (fun _ => false)

def Valid (L : LocalSystem V F) (x : V → Bool) : Prop := ∀ f, L.accepts f x

def restrict (C : Finset V) (x : V → Bool) (v : V) : Bool := if v ∈ C then x v else false

/-- No constraint meets both the occupied component and another occupied
component. Constraint scopes are cliques in the actual primal graph. -/
def Separated (L : LocalSystem V F) (x : V → Bool) (C : Finset V) : Prop :=
  ∀ f u, u ∈ L.scope f → u ∈ C → x u = true →
    ∀ v, v ∈ L.scope f → x v = true → v ∈ C

/-- Restricting a valid history to one separated occupied component keeps
every local constraint, and hence every encoded global validity condition. -/
theorem component_valid (L : LocalSystem V F) (x : V → Bool) (hx : Valid L x)
    (C : Finset V) (hsep : Separated L x C) : Valid L (restrict C x) := by
  intro f
  by_cases hmeet : ∃ u, u ∈ L.scope f ∧ u ∈ C ∧ x u = true
  · obtain ⟨u, hu, hC, hxu⟩ := hmeet
    apply (L.depends f (restrict C x) x ?_).mpr (hx f)
    intro v hv
    by_cases hvc : v ∈ C
    · simp [restrict, hvc]
    · have hz : x v = false := by
        cases hvx : x v with
        | false => rfl
        | true => exact False.elim (hvc (hsep f u hu hC hxu v hv hvx))
      simp [restrict, hvc, hz]
  · apply (L.depends f (restrict C x) (fun _ => false) ?_).mpr (L.zero_valid f)
    intro v hv
    by_cases hvc : v ∈ C
    · have hz : x v = false := by
        cases hvx : x v with
        | false => rfl
        | true => exact False.elim (hmeet ⟨v, hv, hvc, hvx⟩)
      simp [restrict, hvc, hz]
    · simp [restrict, hvc]

end Constraints

section Probability

variable {S : Type*} [DecidableEq S]

/-- Conditioning on an event of mass at least one half costs a pointwise
factor at most two; excluded rare configurations may receive zero mass. -/
theorem truncation_bound (π : S → ℝ) (hπ : ∀ x, 0 ≤ π x) (A : Finset S)
    (hmass : (1 : ℝ) / 2 ≤ ∑ y ∈ A, π y) (x : S) :
    (if x ∈ A then π x / (∑ y ∈ A, π y) else 0) ≤ 2 * π x := by
  by_cases hx : x ∈ A
  · simp only [hx, ite_true]
    have hp : 0 < ∑ y ∈ A, π y := by linarith
    apply (div_le_iff₀ hp).mpr
    have hn := hπ x
    nlinarith
  · simp only [hx, ite_false]
    exact mul_nonneg (by norm_num) (hπ x)

/-- A finite feed-forward sampler with factor two relative to the truncated
law has factor four relative to the original law. -/
theorem sampled_truncation_bound (π μ : S → ℝ) (hπ : ∀ x, 0 ≤ π x) (A : Finset S)
    (hmass : (1 : ℝ) / 2 ≤ ∑ y ∈ A, π y)
    (hμ : ∀ x, μ x ≤ 2 * (if x ∈ A then π x / (∑ y ∈ A, π y) else 0)) (x : S) :
    μ x ≤ 4 * π x := by
  have ht := truncation_bound π hπ A hmass x
  have hm := hμ x
  linarith

end Probability

/-- Compare probabilities along the same finite branch path. This is not a
pointwise same-state inequality between consecutive probability laws. -/
theorem branch_path_bound (a b : ℕ → ℝ) {C : ℝ} (ha : ∀ i, 0 ≤ a i)
    (n : ℕ)
    (hab : ∀ i < n, a i ≤ C * b i) :
    (∏ i ∈ range n, a i) ≤ C ^ n * ∏ i ∈ range n, b i := by
  calc
    (∏ i ∈ range n, a i) ≤ ∏ i ∈ range n, (C * b i) :=
      prod_le_prod₀ (fun i _ => ha i) (fun i hi => hab i (mem_range.mp hi))
    _ = C ^ n * ∏ i ∈ range n, b i := by rw [prod_mul_distrib]; simp

end Snuffy.HistoryPolymer
