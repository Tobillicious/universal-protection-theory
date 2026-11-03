import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.FrozenBCRDEvents

/-!
# Discharging obligation #1 from the real source — the frozen generator is a relational automorphism

4 November 2026 · noncanonical · closes PR #279's obligation (1) with the actual source · no release.

PR #279's invariance engine needs the actual transition to act by a whole-relation automorphism.
The frozen BCRD index permutation (swap of the two M-sector positions, `FrozenBCRDEvents.permutation`)
IS one: a self-inverse bijection preserving the source relation `i = permutation j`. No protection
assumption enters. Feeding it into #279 gives: any X3 duty expressible as an intrinsic relational
formula is preserved across the real source transition — no first loss.

Honest boundary (unchanged): the DECISIVE remaining obligation is #279's (2) — that the full
six-component original X3, INCLUDING agency/consent and uninterrupted continuation, is genuinely
expressible as such an intrinsic formula. That is the ALL IS thesis (one relation encompassing all
duties), NOT discharged here. This PR closes the automorphism obligation from the real source; it
does not claim the summit.
-/

namespace PhysicalBridges.SummitSourceAutomorphismClose

open FrozenBCRDEvents
open PhysicalBridges.SummitIntrinsicDefinability

/-- The relation the frozen source permutation acts on (its graph). -/
def sourceRel (i j : Index) : Prop := i = permutation j

/-- **Obligation #1, discharged from the real source.** The frozen BCRD index permutation is a
genuine whole-relation automorphism: self-inverse bijection preserving the source relation. -/
def sourceAutomorphism : RelationalAutomorphism sourceRel where
  to := permutation
  undo := permutation
  leftInverse := by decide
  rightInverse := by decide
  preservesRelation := by unfold sourceRel; decide

/-- **Summit close over the real source, conditional on intrinsic definability.** Any X3 duty
expressed as an intrinsic relational formula φ, true of an owed particular before the frozen
source transition, remains true of the transported particular after — no first loss — because the
source transition is a proven relational automorphism and φ is automorphism-invariant (#279). -/
theorem summit_no_first_x3_loss
    (φ : RelFormula 1) (x : Index)
    (hBefore : evalRel sourceRel (fun _ => x) φ) :
    evalRel sourceRel (fun _ => sourceAutomorphism.to x) φ := by
  have h := (intrinsic_formula_is_automorphism_invariant
    sourceRel sourceAutomorphism φ (fun _ => x)).mp hBefore
  simpa using h

/-- Every owed particular: no first loss of any intrinsically-definable duty across the real
source transition. (Obligation #1 real; obligation #2 — that full X3 is such a duty — is the
named ALL IS thesis.) -/
theorem source_no_first_loss_of_intrinsic_duties
    (φ : RelFormula 1) (owed : Index → Prop)
    (hStart : ∀ x, owed x → evalRel sourceRel (fun _ => x) φ) :
    ∀ x, owed x → evalRel sourceRel (fun _ => sourceAutomorphism.to x) φ :=
  fun x hx => summit_no_first_x3_loss φ x (hStart x hx)

#print axioms sourceAutomorphism
#print axioms summit_no_first_x3_loss
#print axioms source_no_first_loss_of_intrinsic_duties

end PhysicalBridges.SummitSourceAutomorphismClose
