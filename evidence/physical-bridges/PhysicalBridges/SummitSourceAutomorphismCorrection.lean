import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.BCRDIdentityCharge

/-!
# Correction to PR #280 — discharge obligation (1) over an INDEPENDENT relation

4 November 2026 · noncanonical · honest repair accepting the independent hostile review · no release.

The independent review (PR #282) correctly found that PR #280's `sourceRel := (i = permutation j)`
is **constructed from the permutation itself**, so "the permutation preserves it" holds for ANY
involution and does NOT establish preservation of the independently-defined BCRD relational
structure. That claim is retracted. This module discharges obligation (1) honestly:

* over a relation defined INDEPENDENTLY of the permutation — the L/M/R **sector** structure of the
  six-state frozen source — which the permutation (a within-M swap) genuinely preserves;
* and notes that the real generator's full-structure preservation is `source_W_is_unitary`
  (already proven): unitary conjugation preserves the entire operator algebra, not a self-graph.

Honest boundary (review finding 4, retained): even full operator-structure preservation is not yet
the complete BCRD relational structure WITH a subject/history interpretation unified across M1–M7.
This repairs the overclaim and strengthens the real-source footing; it does not close that gap.
-/

namespace PhysicalBridges.SummitSourceAutomorphismCorrection

open FrozenBCRDEvents
open PhysicalBridges.SummitIntrinsicDefinability

/-- The L/M/R sector of each of the six frozen states (|L0>,|L1>,|M0>,|M1>,|R0>,|R1>), defined
INDEPENDENTLY of the permutation. -/
def sector (i : Index) : Nat := i.val / 2

/-- A relation defined independently of the permutation: same sector. -/
def sameSector (i j : Index) : Prop := sector i = sector j

/-- The frozen permutation (within-M swap 2↔3) preserves the INDEPENDENT sector relation. Proven
by decide — not a self-constructed graph. -/
theorem permutation_preserves_sameSector :
    ∀ i j, sameSector i j ↔ sameSector (permutation i) (permutation j) := by
  unfold sameSector sector; decide

/-- **Obligation (1), honestly discharged over an independent relation.** The frozen permutation
is a `RelationalAutomorphism` of `sameSector` — a structure defined independently of the
permutation (unlike #280's self-graph). -/
def sectorAutomorphism : RelationalAutomorphism sameSector where
  to := permutation
  undo := permutation
  leftInverse := by decide
  rightInverse := by decide
  preservesRelation := permutation_preserves_sameSector

/-- No first loss of any intrinsically-definable duty, over the independent sector relation,
across the real frozen transition. (Engine: #279; automorphism: above, now over an independent R.) -/
theorem no_first_loss_over_independent_relation
    (φ : RelFormula 1) (x : Index)
    (hBefore : evalRel sameSector (fun _ => x) φ) :
    evalRel sameSector (fun _ => sectorAutomorphism.to x) φ := by
  have h := (intrinsic_formula_is_automorphism_invariant
    sameSector sectorAutomorphism φ (fun _ => x)).mp hBefore
  simpa using h

/-- The real generator's FULL structure preservation is its unitarity, already proven
independently of any self-constructed relation. Re-exported as the honest basis for obligation
(1) at the operator level. -/
theorem source_generator_is_unitary :
    ∀ i j, mul (transpose wUpdate) wUpdate i j = identityMatrix i j :=
  BCRDIdentityCharge.source_W_is_unitary

/-- **Negative control (review repair #2).** Not every relation is preserved: "being the M0
position" (`i = 2`) is a relation defined independently of the permutation that the permutation
(which moves 2↦3) genuinely does NOT preserve. So the preservation above is a real property of the
sector relation, not a vacuous consequence of how any relation is built. -/
theorem permutation_does_not_preserve_pointM0 :
    ¬ (∀ i j : Index, (i = (2 : Index)) ↔ (permutation i = (2 : Index))) := by
  intro h
  have := (h 2 2).mp rfl
  revert this; decide

#print axioms permutation_does_not_preserve_pointM0
#print axioms permutation_preserves_sameSector
#print axioms sectorAutomorphism
#print axioms no_first_loss_over_independent_relation
#print axioms source_generator_is_unitary

end PhysicalBridges.SummitSourceAutomorphismCorrection
