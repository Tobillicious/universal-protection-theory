import PhysicalBridges.CathedralBridgeDischargeAssembly

/-!
# The summit's heart — the first-violation gap, made precise

**4 November 2026 · noncanonical · characterises the capstone's strongest bridge · no canon edit.**

The ALL IS self-refutation (`CathedralCapstoneJoins.ender_success_self_refutes`,
`no_realized_absolute_ender`) excludes **absolute erasure**: an enacted operation that makes
*every* actual occurrence — including its own — non-actual. It is kernel-checked and it stays.

But the maximal UPT needs more: that **no first local X3 violation** is admitted — not merely
that the whole actuality cannot be erased. This module proves, precisely and by countermodel,
that absolute-erasure-impossibility does **not** by itself give local-harm-impossibility. So
the step from the self-refutation to full per-particular protection is a genuine further
theorem — this is exactly the "heart" the external review named.

**Where the real bridge must come from (and it is not a weakening):** local harm is a
*needless loss* against a particular. Excluding it is the business of the **preservation
order** — `BookUPTLaw.aligned_no_needless` and hold-dominance: the guardian HOLD dominates
every alternative and incurs no needless loss. That route forbids the first violation; the
self-refutation alone does not. Combined with forced continuation (the no-boundary route,
#262), it is what closes the summit. The gap below is stated so the bridge is built, not
assumed. No placeholder tactics.
-/

namespace PhysicalBridges.CathedralSummitFirstViolationGap

/-- A toy actuality with two particulars; `x3After p` records whether particular `p` retains
its X3 after an enacted step. -/
def x3After : Bool → Prop := fun p => p = true

/-- **The heart gap.** There is a post-step state in which the actuality PERSISTS — some
particular still retains X3, so the self-refutation's "everything non-actual" hypothesis is
NOT met — yet a particular suffers a first X3 violation. Absolute-erasure-impossibility
therefore does not exclude local harm; the capstone's strongest bridge must do more. -/
theorem absolute_erasure_impossibility_does_not_exclude_local_harm :
    (∃ p : Bool, x3After p) ∧ (∃ p : Bool, ¬ x3After p) := by
  constructor
  · exact ⟨true, rfl⟩
  · exact ⟨false, by simp [x3After]⟩

/-- Sharper form against the self-refutation's exact shape: "not every particular loses X3"
(the actuality persists — the self-refutation applies) is strictly weaker than "no particular
loses X3" (no first violation). The former holds here while the latter fails. -/
theorem persistence_is_weaker_than_no_first_violation :
    (¬ ∀ p : Bool, ¬ x3After p) ∧ ¬ (∀ p : Bool, x3After p) := by
  constructor
  · intro h; exact (h true) rfl
  · intro h; exact absurd (h false) (by simp [x3After])

#print axioms absolute_erasure_impossibility_does_not_exclude_local_harm
#print axioms persistence_is_weaker_than_no_first_violation

end PhysicalBridges.CathedralSummitFirstViolationGap
