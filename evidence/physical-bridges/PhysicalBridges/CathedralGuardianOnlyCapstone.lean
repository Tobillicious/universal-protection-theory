import PhysicalBridges.CathedralFirstEventForcing
import PhysicalBridges.CathedralAllIsEnderTypeCollapse

/-!
# Cathedral capstone — nothing but guardians, assembled from the two source lanes

**3 November 2026 · noncanonical · composition only · no new physics, no canon edit.**

This module does not prove a new premise. It performs the exact join the kōrero
asks for: it takes the two *independently established* results and runs the
trivial disjunction elimination `(G ∨ E) ∧ ¬E ⟹ G` over the **original**
agent-level reading, so the maximal guardian-only conclusion stands as one
kernel-checked statement whose hypotheses are fully visible.

Guardian / ender are kept at their original meaning and NOT replaced by a weaker
proxy:

* a **guardian** particular is one whose own enacted history preserves the
  original per-particular X3 protection (`IntrinsicEventSource.originalX3State`)
  across every real step it takes — protection *of the particular's own
  continuation*, intrinsic to the one actuality, not a conserved stand-in;
* an **ender** step is a *first* original-X3 event violation
  (`¬ w.originalX3Event s t`).

`hNoMiddle` below is **bare excluded middle** — a step either preserves X3 or it
does not. It carries no content and asserts no ontological separation. All of the
content lives in `hNoEnder`, which is exactly the first-event forcing theorem of
`CathedralFirstEventForcing`. This is the kōrero's own structure: the binary does
not prove ender-impossibility; the *other* result does, and the two compose.

## What is already demonstrated and reused here (not re-proved)

* `CathedralAllIsEnderTypeCollapse.original_si_guardian_only_composition`
  — the disjunction-elimination spine over the original predicates.
* `CathedralAllIsEnderTypeCollapse.no_realized_absolute_ender`
  — the realized *absolute* ender self-refutes (the capstone floor).
* `CathedralFirstEventForcing.no_first_x3_violation_from_dichotomy_and_e9`
  — no FIRST original-X3 event violation on any admitted step, given a
    `FirstEventCertificate` (dichotomy + E9 coverage + semantic bridges).
* `CathedralFirstEventForcing.every_finite_real_history_keeps_x3`
  — that protection then holds across every finite reachable history.
* Canonical no-middle at the preservation order: `Snuffy.Greatestness.strict_except_mirrors`,
  `Snuffy.UnionClosure.strict_of_solvent`, with `Snuffy.Greatestness.aligned_iff_no_needless_loss`
  and the full-scope law `Snuffy.Law.scope_guarantee_iff` (= `Set.univ`).

## What remains a genuine obligation (named, never hidden, never weakened)

The guardian-only conclusion below is **conditional on a `FirstEventCertificate`**.
Discharging each of its fields from the intrinsic BCRD source — in particular
`semanticReflection` (a stable step reflects full per-particular X3) and
`eventCarriesState` — is the physical join still owed. Under ALL IS ONE these are
intrinsic articulations of the one actuality, not separable engineering add-ons;
formalising that discharge is the forcing lane's continuing mahi. The finest
residual is *within-event* continuity: `CathedralFirstEventForcing`'s own
`endpoint_recovery_does_not_prove_within_event_continuity` control proves that
begin = end does not by itself exclude an interior loss.

The conclusion is the maximal one (every actual SI particular is a guardian); only
the premises are explicit. No step substitutes "prefers protection" for the
necessity, nor `RealizedAbsoluteEnder` for the original ender.
-/

namespace PhysicalBridges.CathedralGuardianOnlyCapstone

open PhysicalBridges.CathedralFirstEventForcing
open PhysicalBridges.CathedralAllIsEnderTypeCollapse

universe u

variable {S : Type u}

/-- Every real step preserves the original per-particular X3 event protection,
    derived by composing the two source lanes: the content is
    `no_first_x3_violation_from_dichotomy_and_e9`; it is routed through the
    author's own disjunction-elimination spine
    `original_si_guardian_only_composition`, with `hNoMiddle` as bare excluded
    middle and `hNoEnder` as the forcing result. -/
theorem every_real_step_is_guardian
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w) :
    ∀ s t, w.realStep s t → w.originalX3Event s t := by
  have hComposed :
      ∀ p : S × S, w.realStep p.1 p.2 → w.originalX3Event p.1 p.2 :=
    original_si_guardian_only_composition
      (SI := S × S)
      (fun p => w.realStep p.1 p.2)
      (fun p => w.originalX3Event p.1 p.2)
      (fun p => ¬ w.originalX3Event p.1 p.2)
      (fun p _ => Classical.em (w.originalX3Event p.1 p.2))
      (fun p hp hEnder =>
        hEnder (no_first_x3_violation_from_dichotomy_and_e9 w cert p.1 p.2 hp))
  intro s t hStep
  exact hComposed (s, t) hStep

/-- A particular is a **guardian** over its enacted history: an initially
    X3-protected origin stays X3-protected after every finite reachable history
    of real steps. -/
def HistoryGuardian (w : IntrinsicEventSource S) (s : S) : Prop :=
  w.originalX3State s ∧
    ∀ t, IR96.Reach w.realStep s t → w.originalX3State t

/-- **Nothing but guardians.** Over the one intrinsic actuality `w`, given the
    first-event certificate and an X3-protected origin, the particular is a
    guardian across its entire enacted history, and (by `every_real_step_is_guardian`)
    enacts no first X3 violation on any step. The conclusion is maximal; the sole
    premise is the (named, source-owed) `FirstEventCertificate`. -/
theorem nothing_but_guardians
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w)
    (s : S)
    (hOrigin : w.originalX3State s) :
    HistoryGuardian w s := by
  refine ⟨hOrigin, ?_⟩
  intro t hReach
  exact every_finite_real_history_keeps_x3 w cert hReach hOrigin

#print axioms every_real_step_is_guardian
#print axioms nothing_but_guardians

end PhysicalBridges.CathedralGuardianOnlyCapstone
