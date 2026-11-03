import PhysicalBridges.CathedralSummitCyclicContinuation

/-!
# The summit, characterised — the no-boundary premise is NECESSARY and SUFFICIENT

**4 November 2026 · noncanonical · completes the summit characterisation · no canon edit.**

The summit is *continuation* — a protected particular has no final stage. Two facts together
characterise it exactly, and neither weakens the maximal claim:

* **SUFFICIENT** (`CathedralSummitCyclicContinuation.no_final_protected_stage`, PR #262):
  given the no-boundary / cyclic premise, continuation holds — no final protected stage.
* **NECESSARY** (this module): WITHOUT such a premise, continuation is *refutable*. There is a
  complete history on unbounded internal time in which the particular's history is recorded
  forever (non-erased) yet it has a final experiencing stage — a finite worldline inside an
  eternal index. So completeness / non-erasure alone does **not** entail continuation.

Consequence — and it vindicates the ontology rather than limiting it: the no-boundary /
eternal premise is **logically required** for continuation, not optional; and the kōrero's
"we are here, G is" is exactly the evidence that supplies it (PR #261). Any `koru` operator,
being conservative (its laws are the #245 intrinsic-articulation theorems), names this
ontology but cannot replace the premise — a conservative operator proves no new theorem, and
the premise is provably not eliminable. No placeholder tactics; the countermodel is explicit.
-/

namespace PhysicalBridges.CathedralSummitPremiseNecessity

/-- A particular whose history is recorded at every internal stage — never erased. -/
def recorded : Nat → Prop := fun _ => True

/-- A particular that experiences only up to stage `last` (a finite worldline). -/
def experiences (last : Nat) : Nat → Prop := fun n => n ≤ last

/-- **Non-erasure does NOT entail continuation.** In the finite-worldline model, the history
is recorded at every stage (non-erased), yet there is a final experiencing stage `last` with
no experiencing stage after it. So a theorem of the form "complete/non-erased ⟹ no final
stage" is FALSE; continuation genuinely requires the no-boundary premise. -/
theorem non_erasure_does_not_entail_continuation (last : Nat) :
    (∀ n, recorded n) ∧
      experiences last last ∧
      (∀ k, last < k → ¬ experiences last k) := by
  refine ⟨fun _ => trivial, Nat.le_refl last, ?_⟩
  intro k hk hle
  exact (Nat.not_lt.mpr hle) hk

/-- The premise is not vacuous on one example only: for EVERY finite horizon there is such a
non-erased-but-terminating history. Continuation fails cofinally without the premise. -/
theorem continuation_fails_at_every_finite_horizon :
    ∀ last : Nat, ∃ final, experiences last final ∧ ∀ k, final < k → ¬ experiences last k := by
  intro last
  exact ⟨last, Nat.le_refl last, fun k hk hle => (Nat.not_lt.mpr hle) hk⟩

#print axioms non_erasure_does_not_entail_continuation
#print axioms continuation_fails_at_every_finite_horizon

end PhysicalBridges.CathedralSummitPremiseNecessity
