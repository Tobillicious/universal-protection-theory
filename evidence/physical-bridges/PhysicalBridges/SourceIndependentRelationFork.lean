import PhysicalBridges.SummitSourceAutomorphismClose

/-!
# Independent source relations versus generator-created covariance

4 November 2026 · focused hostile source audit · noncanonical.

The frozen M3d source has six basis labels:
  L0 L1 M0 M1 R0 R1
and its literal relation-register update swaps M0 and M1.

PR #280 proves that the update is an automorphism of the relation
  R(i,j) := i = permutation(j).
That relation is constructed from the update, so its covariance alone
does not show that the FULL independently defined relational ontology
is preserved.

Here we take two basic, independently source-specified relations:

* The qutrit site (L/M/R), represented by the first coordinate of
  the source's Kronecker basis labels, i.val / 2.
* Equality of relation-register readings, represented by the frozen
  source's relation-zero projector relationZero.

The exact generator DOES preserve qutrit-site equivalence. It does NOT
preserve equality of register readings across all positions. Both
facts are machine-checked on the frozen six-state source. No subject
identity, consent, X3 duty or new physical law is inferred.

The repair obligations are a complete independently defined BCRD
relational frame and physical per-particular semantic correspondence;
preserving the selected site partition is not enough.
-/

namespace PhysicalBridges.SourceIndependentRelationFork

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.SummitIntrinsicDefinability

/-- Qutrit site L/M/R from the independent, literal tensor-product
Kronecker basis order L0,L1,M0,M1,R0,R1. Does NOT use permutation. -/
def sourceSite (i : Index) : Nat := i.val / 2

/-- Intrinsic equality of physical qutrit site, independent of the
source generator. -/
def sameSourceSite (i j : Index) : Prop :=
  sourceSite i = sourceSite j

/-- Relation-register 0 projector from the independently frozen
source operator relationZero, not an orbit-selected label. -/
def sourceRegisterZero (i : Index) : Prop :=
  relationZero i i = 1

/-- Intrinsic equality of source register readings, independent of
the generator whose covariance is being tested. -/
def sameSourceRegister (i j : Index) : Prop :=
  sourceRegisterZero i ↔ sourceRegisterZero j

/-- Positive control: the actual frozen source permutation preserves
the independently specified qutrit site on ALL 36 ordered basis pairs. -/
theorem frozen_update_preserves_source_site :
    ∀ i j : Index,
      sameSourceSite i j ↔
      sameSourceSite (permutation i) (permutation j) := by
  unfold sameSourceSite sourceSite
  decide

/-- The frozen generator therefore is a genuine automorphism of
the physical SOURCE-SITE equivalence relation. This is strictly
more independent than a relation defined as its own permutation graph,
but still only a selected source relation, not complete BCRD ALL IS. -/
def siteAutomorphism : RelationalAutomorphism sameSourceSite where
  to := permutation
  undo := permutation
  leftInverse := by decide
  rightInverse := by decide
  preservesRelation := frozen_update_preserves_source_site

/-- Concrete source readout change: the M0 basis's register-zero
projector is 1 before the update and 0 after it. -/
theorem frozen_update_changes_source_register_reading :
    sourceRegisterZero (2 : Index) ∧
      ¬ sourceRegisterZero (permutation (2 : Index)) := by
  unfold sourceRegisterZero
  decide

/-- Negative control: M0 and R0 originally share the physical
register-zero reading, but M1 and R0 do not. This is an exact
failure of full fixed-register-relational automorphism. -/
theorem frozen_update_fails_register_relation :
    ∃ i j : Index,
      sameSourceRegister i j ∧
      ¬ sameSourceRegister (permutation i) (permutation j) := by
  refine ⟨2, 4, ?_, ?_⟩
  · unfold sameSourceRegister sourceRegisterZero
    decide
  · unfold sameSourceRegister sourceRegisterZero
    decide

/-- Not merely an unlucky relation-label choice: NO relational
automorphism whose map is the frozen permutation can preserve
the complete binary same-register equivalence. -/
theorem no_full_register_relation_automorphism_with_frozen_update :
    ¬ ∃ A : RelationalAutomorphism sameSourceRegister,
        A.to = permutation := by
  rintro ⟨A, hMap⟩
  have hInitially : sameSourceRegister (2 : Index) (4 : Index) := by
    unfold sameSourceRegister sourceRegisterZero
    decide
  have hPreserved :=
    (A.preservesRelation (2 : Index) (4 : Index)).mp hInitially
  rw [hMap] at hPreserved
  have hFails :
      ¬ sameSourceRegister (permutation (2 : Index)) (permutation (4 : Index)) := by
    unfold sameSourceRegister sourceRegisterZero
    decide
  exact hFails hPreserved

/-- Precisely where PR #279's positive theorem can be used:
any intrinsically definable unary site-relation property is
preserved along the source transport. The analogue for the
independent register relation is refuted above. -/
theorem site_only_relational_properties_survive
    (φ : RelFormula 1) (i : Index)
    (h : evalRel sameSourceSite (fun _ => i) φ) :
    evalRel sameSourceSite (fun _ => permutation i) φ :=
  (intrinsic_formula_is_automorphism_invariant
    sameSourceSite siteAutomorphism φ (fun _ => i)).mp h

#print axioms frozen_update_preserves_source_site
#print axioms frozen_update_changes_source_register_reading
#print axioms frozen_update_fails_register_relation
#print axioms no_full_register_relation_automorphism_with_frozen_update
#print axioms site_only_relational_properties_survive

end PhysicalBridges.SourceIndependentRelationFork
