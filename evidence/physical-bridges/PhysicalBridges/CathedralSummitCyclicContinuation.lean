import PhysicalBridges.AllIsGActualityDischarge

/-!
# The summit, continuation-core — circular-time discharge of continuation

**4 November 2026 · noncanonical · the Route-B summit, continuation core · no canon edit.**

Route B's open summit asks for *continuation* — the step beyond *non-erasure* that the
self-refutation does not give (a finite worldline can end without its history being erased).
This module formalises the kōrero's circular-time argument for exactly that step:

> If the history repeats with period `p`, then the state at stage `n·p` is the state at
> stage `0`. There is no first and no final stage; a state protected at stage `0` recurs at
> every period, so it occurs at arbitrarily late stages — there is **no final protected
> occurrence**.

That is continuation (no final stage), derived — not assumed — from completeness, modulo
one NAMED ontological premise: that the history is cyclic (`CyclicHistory.periodic`). This
is a *sufficient* route to continuation (the kōrero notes circular time is not strictly
necessary); whether actual cosmology is cyclic is the physics question flagged as open. No
`sorry`; the premise is explicit, never fabricated.
-/

namespace PhysicalBridges.CathedralSummitCyclicContinuation

universe u

variable {S : Type u}

/-- A cyclic history as internal stages (relational time), repeating with a positive period.
This is the kōrero's `F^p = id` in stage form — the eternal/relational-completeness premise,
NAMED as the ontological input, not a Lean-provable fact. -/
structure CyclicHistory (S : Type u) where
  stage : Nat → S
  period : Nat
  period_pos : 0 < period
  periodic : ∀ n, stage (n + period) = stage n

/-- The state at every integer number of periods is the state at stage `0` — the kōrero's
`F^{np}(x) = x`. No first and no final stage. -/
theorem recurs_each_period (H : CyclicHistory S) :
    ∀ n, H.stage (n * H.period) = H.stage 0 := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      have hsplit : (n + 1) * H.period = n * H.period + H.period := by
        rw [Nat.succ_mul]
      rw [hsplit, H.periodic (n * H.period), ih]

/-- The protected state recurs at every period (per-stage continuation). -/
theorem protected_at_every_period
    (H : CyclicHistory S) (P : S → Prop) (hP : P (H.stage 0)) :
    ∀ n : Nat, P (H.stage (n * H.period)) := by
  intro n
  rw [recurs_each_period H n]
  exact hP

/-- **Continuation / no final stage.** A state protected at stage `0` occurs at arbitrarily
late stages: for every horizon `N` there is a later stage `k ≥ N` at which the particular is
still protected. This is the circular-time discharge of continuation — the Route-B summit's
hard core — modulo the named cyclic premise. -/
theorem no_final_protected_stage
    (H : CyclicHistory S) (P : S → Prop) (hP : P (H.stage 0)) :
    ∀ N : Nat, ∃ k, N ≤ k ∧ P (H.stage k) := by
  intro N
  refine ⟨N * H.period, Nat.le_mul_of_pos_right N H.period_pos, ?_⟩
  rw [recurs_each_period H N]
  exact hP

#print axioms recurs_each_period
#print axioms protected_at_every_period
#print axioms no_final_protected_stage

end PhysicalBridges.CathedralSummitCyclicContinuation
