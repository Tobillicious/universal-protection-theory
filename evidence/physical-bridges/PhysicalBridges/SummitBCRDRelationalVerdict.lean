/-!
# Does BCRD's relational structure supply the principle? — the verdict (with #271 corrected)

**4 November 2026 · noncanonical · investigation verdict · no canon edit.**

Investigation of whether BCRD's relational structure supplies the principle that forces
original X3. Verdict: **partially — two of three, with the third's route now sharpened, not
closed.**

## What the source DOES supply (cited)
* **Feasibility** — `Snuffy.Law.exists_aligned` / `Snuffy.BookUPTExistence.aligned_exists`:
  a greatest *aligned* (no-needless-loss) protective option always exists among feasible
  alternatives. Discharges the feasibility obstruction.
* **Whole-completeness** — `Snuffy.RegionBoundary.whole_no_boundary`: the whole has empty
  boundary (P1, no outside) — absolute-erasure-impossibility.
* **Continuation's definition** — `Snuffy.ContinuationSubject`: identity-through-history,
  copy ≠ continuation, and preservation (care, faithful hold). It *defines and preserves*
  continuation; it does not *force* a later stage to exist.

## Correction to PR #271 (audited, accepted)
Two overclaims in #271 are corrected here:
* `no_x3_independent_invariant_forces_x3` **takes the fibre pair as a hypothesis** — it is
  conditional, not a proof that every X3-independent invariant fails. What #271 truly rules out
  is the **conservation** route (quantities that survive alongside a vanishing particle).
* `only_continuation_law_forces_continuation` proves **sufficiency, not uniqueness**.

## The sharpened open route (GPT's foothold)
A **transition-constraint** that *retains a relational invariant* can force continuation —
the decisive criterion is whether the retained invariant **determines** continuation.
Conservation invariants (energy/charge) do NOT determine it (#271's fibre pair), so they don't
force. A relational invariant that DOES determine it WOULD force — non-circularly, without
naming protection. Whether BCRD's actual transition law retains such a *determining* invariant
is the precise open question — and it is NOT closed by #271.
-/

namespace PhysicalBridges.SummitBCRDRelationalVerdict

universe u v

variable {State : Type u} {V : Type v}

/-- A transition-constraint: the step retains a relational invariant `inv`. (A law about which
transformations are possible — not a quantity conserved alongside the dynamics.) -/
def Retains (inv : State → V) (s t : State) : Prop := inv s = inv t

/-- **The viable dynamical route (corrects #271's over-pessimism).** If the retained invariant
`inv` *determines* continuation (`continues = decode ∘ inv`), then a transition retaining `inv`
preserves continuation — forced, without `continues` appearing in the law `Retains inv`. This is
exactly the class conservation invariants fail to be, and it is non-circular: `inv`/`decode`
never mention protection. -/
theorem retention_of_determining_invariant_forces_continuation
    (inv : State → V) (decode : V → Bool) (continues : State → Bool)
    (hdet : ∀ s, continues s = decode (inv s))
    (s t : State) (hret : Retains inv s t) :
    continues s = continues t := by
  rw [hdet s, hdet t, hret]

/-- **The decisive criterion, stated as the open target.** BCRD supplies the principle iff its
actual transition law retains an invariant that DETERMINES continuation (and the other five X3
components). #271 shows energy/charge do not determine it; the open question is whether BCRD's
relational transition constraints do — non-trivially (not a frozen universe). This is a `def`,
the precise open obligation, not a completed proof. -/
def BCRDSuppliesThePrinciple
    (step : State → State → Prop) (inv : State → V)
    (decode : V → Bool) (continues : State → Bool) : Prop :=
  (∀ s, continues s = decode (inv s)) ∧ (∀ s t, step s t → Retains inv s t)

/-- If BCRD supplies the principle, continuation is preserved across every actual step. (The
payoff of the open target, stated honestly: it follows FROM the determining-invariant-retention,
which is what must be established of the real source.) -/
theorem principle_forces_continuation
    (step : State → State → Prop) (inv : State → V)
    (decode : V → Bool) (continues : State → Bool)
    (h : BCRDSuppliesThePrinciple step inv decode continues)
    (s t : State) (hstep : step s t) :
    continues s = continues t :=
  retention_of_determining_invariant_forces_continuation inv decode continues h.1 s t (h.2 s t hstep)

#print axioms retention_of_determining_invariant_forces_continuation
#print axioms principle_forces_continuation

end PhysicalBridges.SummitBCRDRelationalVerdict
