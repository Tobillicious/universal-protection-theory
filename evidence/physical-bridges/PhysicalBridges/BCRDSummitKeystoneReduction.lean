import PhysicalBridges.CathedralAllIsEnderTypeCollapse
import PhysicalBridges.OriginalX3Full

/-!
# Guardian-only summit — exact premises in the present schematic formalization

4 November 2026, scope-hardened following reciprocal hostile review.
Noncanonical research lane; no change to ALL IS ONE, original X3, or publication.

This module checks the logical reduction of EVERY enacted action satisfying
the six-component `OriginalX3Full.OriginalX3` conjunction. The six components
are freely supplied `continues`, `authorized`, `free`, `restrained`,
`maximal` and `provenanced` predicates. The structure records their complete
six-component TARGET but does not independently instantiate their physical,
experiential, or normative meanings.

## Two explicit hypotheses of THIS theorem, not two primitive laws of reality

1. `StrongSameTypeDichotomy w` is a classification premise for enacted
   actions in the specific `IntrinsicAccount` formalization. Because
   `RealizedAbsoluteEnder` requires both an enacted occurrence and ZERO
   actual occurrences, that narrowly specified absolute-erasure branch
   is inconsistent. Thus the dichotomy is equivalent (over this record)
   to all enacted actions being `intrinsicGuardian`-classified.
2. `hKeystone` is the reflection from that provisional intrinsic class to
   ALL SIX independently interpreted original-X3 obligations.

The logical result follows when BOTH hypotheses are supplied. The current
theorem does not derive either from the full philosophical ALL IS ONE
foundation. Nor does this premise count show ALL IS ONE intrinsically
requires two independent primitive axioms: a richer, faithfully formalized
ontology could in principle entail both. This theorem does not test that.

The absolute-erasure contradiction is *not* a demonstration that the full
ALL IS ONE ontology narrows nothing. It does not rule out local harm, a
first violation of a particular's protection, or an end-valuing strategy.
It only eliminates the narrowly defined enacted-total-erasure predicate.

## No promotion from source transport to experiencing-subject protection

There is genuine SOURCE backing for W-stage transport and the finite
complex carrier/signature results, including model-level nonmerging
conditional on a proposed candidate assignment. This is not a proof
that the same experiencing subject actually continues. In particular
`hContinuity` below is an explicit PREMISE about a freely supplied
`cont` predicate; it is not discharged by W algebra.

The finite source readout countermodels (IR132 and PR B) obstruct exact
decoding of unconstrained subject-status labels from the specified
limited readouts. They do NOT establish that a richer independently
warranted ontology or physical theory can never support subject identity
or authorization. The relevant source-to-particular correspondences
remain open.

No PR C first-local-violation theorem is asserted. No universal physical
protection guarantee or empirical conclusion follows from this module.
-/
namespace PhysicalBridges.BCRDSummitKeystoneReduction

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x

variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- The theorem has two *explicit hypotheses in the current schema*:
a classification premise `hDich`, and a six-component X3 reflection premise
`hKeystone`. It is not a theorem that philosophical ALL IS ONE contains
exactly two independent primitive axioms. The proof's absolute-erasure
elimination only concerns the narrowly specified empty type of realized
total erasure; it is not a complete no-first-X3-violation derivation. -/
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

/-- Decompose the same explicitly supplied keystone into all six
original-X3 predicates, without weakening any. W-stage and complex
source-carrier results concern finite physical-model signatures only.
They do not discharge `hContinuity` for a genuinely experiencing
particular. Each `hContinuity` / `hAuthorized` / `hFree` /
`hRestrained` / `hMaximal` / `hProvenanced` is a named premise, NOT
a theorem of the source or ALL IS ONE as currently formalized. -/
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

/-- Scoped classification accounting, now an actual theorem:
because the SPECIFIED realized-total-erasure branch is impossible,
the corresponding dichotomy is equivalent to universal membership in
the provisional `intrinsicGuardian` class. This does not classify the
author's full ethical/protective guardian or encode ALL IS ONE. -/
theorem scoped_dichotomy_iff_intrinsic_classification
    (w : IntrinsicAccount Event Action) :
    StrongSameTypeDichotomy w ↔
      (∀ a, w.enacted a → w.intrinsicGuardian a) := by
  constructor
  · exact all_is_eliminates_realized_ender_branch w
  · intro h a ha
    exact Or.inl (h a ha)

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

#print axioms scoped_dichotomy_iff_intrinsic_classification

end PhysicalBridges.BCRDSummitKeystoneReduction
