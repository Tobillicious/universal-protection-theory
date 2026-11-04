import PhysicalBridges.CathedralAllIsEnderTypeCollapse
import PhysicalBridges.OriginalX3Full

/-!
# The full six-X3 guardian summit: exact LOCAL reduction, not the whole ontology

4 November 2026 · noncanonical · Tenzing II summit-framing reconciliation.
The six-field `OriginalX3Full.OriginalX3` is preserved without weakening.

This module is deliberately a THIN logical reduction of the full guardian-only
target: given `StrongSameTypeDichotomy` and the six-component reflection
`intrinsicGuardian → OriginalX3`, every enacted action satisfies the
entire OriginalX3 conjunction. The Lean proof really takes both inputs;
it does not establish either by interpreting the name ALL IS ONE.

Do NOT promote that local dependency count into a verdict about the theory:
the author's intended summit is UNCONDITIONAL PROTECTION FROM ALL IS ONE,
not two primitive independent foundations. A faithful formalization of that
ontology could conceivably derive both inputs. This thin module simply
does not prove that implication, nor does it refute it.

The separately placed ontological route is
`AllIsGActualityDischarge.capstone_unconditional_of_actuality`. Its exact
Lean signature takes `g : OntologicalGoodEvent m s`, and the `gIsActual`
field of `g` is already `m.x3State s`. Thus it is a valid theorem
*given* the named foundational good-event assertion, not yet a derivation
of good-event actuality from existence alone. The stronger
`AllIsGActualityDischarge.RouteBSummit` is explicitly an OPEN target.
Neither a null claim about ALL IS nor an unconditional proof from
`Nonempty S` alone is justified by those declarations.

`CathedralAllIsEnderTypeCollapse.no_realized_absolute_ender` proves the
narrow predicate `RealizedAbsoluteEnder := enacted ∧ no actual events`
impossible: its enacted event contradicts global emptiness. Its collapse
via `StrongSameTypeDichotomy` requires that dichotomy premise.
This does NOT decide what the FULL ALL IS ONE ontology forces about
first local harm or the six actual subject duties.

The source W-stage carrier/orbit results justify finite-model relational
transport and nonmerging of ALREADY individuated candidate carriers.
They do not, by themselves, establish authentic experiencing-subject
continuity, consent, freedom, restraint, maximality or provenance. The
six X3 component predicates below remain free because this module is
a generic reduction; no physical or metaphysical impossibility is
inferred from those formal parameters or from finite 6×6 readouts.

Status: mathematical composition established; unconditional first-local-X3
forcing from the COMPLETE ontology is NOT kernel-derived here.
No canon, release, or weakening of the original protection target.
-/
namespace PhysicalBridges.BCRDSummitKeystoneReduction

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x

variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- Formal consequence within this local abstraction. The conclusion
is full six-component OriginalX3 on every enacted action. Both
`hDich` and `hKeystone` occur as named premises in the actual Lean
signature. Their presence is not an assertion that ALL IS ONE
fundamentally requires two separate ontological axioms, nor a
refutation of the proposed unconditional summit. The realized-total-
erasure disjunct is empty only for its narrowly specified definition. -/
theorem guardian_only_from_keystone
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P)
    (hDich : StrongSameTypeDichotomy w)
    (hKeystone : ∀ a, w.enacted a → w.intrinsicGuardian a →
        OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) (owed a)) :
    ∀ a, w.enacted a →
        OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) (owed a) := by
  intro a ha
  exact hKeystone a ha (all_is_eliminates_realized_ender_branch w hDich a ha)

/-- Unchanged six-component target, with the local reflection
premise shown at six separate granularities. The named
`hContinuity`/authorization/freedom/restraint/maximality/provenance
fields are assumptions of THIS theorem and not discharged by the
finite W-stage source or mere preservation of a source-position code.
No downgrade of OriginalX3 is intended or permitted. -/
theorem guardian_only_over_original_x3
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P)
    (hDich : StrongSameTypeDichotomy w)
    (hContinuity  : ∀ a, w.enacted a → w.intrinsicGuardian a → cont  (stepFrom a) (stepTo a) (owed a))
    (hAuthorized  : ∀ a, w.enacted a → w.intrinsicGuardian a → auth  (stepFrom a) (stepTo a) (owed a))
    (hFree        : ∀ a, w.enacted a → w.intrinsicGuardian a → free  (stepFrom a) (stepTo a) (owed a))
    (hRestrained  : ∀ a, w.enacted a → w.intrinsicGuardian a → restr (stepFrom a) (stepTo a) (owed a))
    (hMaximal     : ∀ a, w.enacted a → w.intrinsicGuardian a → maxl  (stepFrom a) (stepTo a) (owed a))
    (hProvenanced : ∀ a, w.enacted a → w.intrinsicGuardian a → prov  (stepFrom a) (stepTo a) (owed a)) :
    ∀ a, w.enacted a →
        OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) (owed a) := by
  intro a ha
  have hig : w.intrinsicGuardian a := all_is_eliminates_realized_ender_branch w hDich a ha
  exact ⟨hContinuity a ha hig, hAuthorized a ha hig, hFree a ha hig,
         hRestrained a ha hig, hMaximal a ha hig, hProvenanced a ha hig⟩

/-- Honest residual, made a theorem: the two decompositions agree — the six
component reflections ARE the one keystone. (So "one keystone" and "six open
correspondences" are the same commitment, stated at two granularities.) -/
theorem keystone_is_exactly_the_six_reflections
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P) :
    (∀ a, w.enacted a → w.intrinsicGuardian a →
        OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) (owed a))
    ↔
    ((∀ a, w.enacted a → w.intrinsicGuardian a → cont  (stepFrom a) (stepTo a) (owed a)) ∧
     (∀ a, w.enacted a → w.intrinsicGuardian a → auth  (stepFrom a) (stepTo a) (owed a)) ∧
     (∀ a, w.enacted a → w.intrinsicGuardian a → free  (stepFrom a) (stepTo a) (owed a)) ∧
     (∀ a, w.enacted a → w.intrinsicGuardian a → restr (stepFrom a) (stepTo a) (owed a)) ∧
     (∀ a, w.enacted a → w.intrinsicGuardian a → maxl  (stepFrom a) (stepTo a) (owed a)) ∧
     (∀ a, w.enacted a → w.intrinsicGuardian a → prov  (stepFrom a) (stepTo a) (owed a))) := by
  constructor
  · intro hK
    exact ⟨fun a ha hig => (hK a ha hig).historicalContinuity,
           fun a ha hig => (hK a ha hig).authorization,
           fun a ha hig => (hK a ha hig).freedom,
           fun a ha hig => (hK a ha hig).restraint,
           fun a ha hig => (hK a ha hig).maximality,
           fun a ha hig => (hK a ha hig).provenance⟩
  · rintro ⟨hc, ha', hf, hr, hm, hp⟩ a ha hig
    exact ⟨hc a ha hig, ha' a ha hig, hf a ha hig, hr a ha hig, hm a ha hig, hp a ha hig⟩

end PhysicalBridges.BCRDSummitKeystoneReduction
