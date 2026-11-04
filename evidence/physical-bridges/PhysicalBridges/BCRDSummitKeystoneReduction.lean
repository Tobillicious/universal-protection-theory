import PhysicalBridges.CathedralAllIsEnderTypeCollapse
import PhysicalBridges.OriginalX3Full

/-!
# The summit on its one keystone — concrete six-component reduction

This is the honest maximal form of the guardian-only summit over the **concrete**
six-component `OriginalX3Full.OriginalX3` (not an abstract placeholder predicate):
it reduces □(SI⇒G) to exactly its named commitments, with everything else
machine-checked, and smuggles nothing.

What is already discharged, from `main`, **hypothesis-free**:
* `no_realized_absolute_ender` — absolute erasure is impossible (the ALL-IS physics);
* hence `all_is_eliminates_realized_ender_branch` collapses the ender branch of the
  same-type dichotomy to the intrinsic-guardian class, for free.

So the concrete six-component guardian-only conclusion stands on exactly:
1. `StrongSameTypeDichotomy` — the source same-type exhaustive dichotomy; and
2. **the keystone** — the reflection `intrinsicGuardian a ⟹ OriginalX3 (…) a`,
   i.e. the ALL IS ONE inversion (*a particular's X3-violation would be a loss, and
   nothing is lost*). This is a **declared foundational commitment**, never
   established by "ALL IS" alone (see `SUMMIT-LEDGER-2026-11-04.md`).

`guardian_only_over_original_x3` decomposes the keystone into its six component
reflections. Of these, **continuity** now has genuine source backing (the all-input
W-stage transport `BCRDComplexWGenericAction` / `BCRDComplexOperatorConjugation`,
the exact causal orbit `BCRDExactCausalOrbit`, and the carrier criterion
`BCRDParticularCarrierCriterion`). The other five — authorization, freedom,
restraint, maximality, provenance — together with the subject map
(`stepFrom/stepTo/owed`) are the **open** source→particular correspondence: the
6×6 source provably cannot decode them (`BCRDOperatorSubjectGap`,
`BCRDAuthorizationFreedomBoundary`). They are named premises here, never assumed
true. That `OriginalX3` genuinely needs all six is `proxy_is_strictly_weaker`.

Nothing here attempts PR C (`ActualStep ∧ Owed ⟹ OriginalX3` as a derived
necessity); that remains downstream until the open correspondence is closed
non-circularly.
-/
namespace PhysicalBridges.BCRDSummitKeystoneReduction

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x

variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- **The summit on its one keystone.** Over the concrete six-component
`OriginalX3`, every enacted action is a guardian — resting on exactly the source
dichotomy and the single keystone reflection (`intrinsicGuardian ⟹ OriginalX3`).
The ender branch is discharged for free by `all_is_eliminates_realized_ender_branch`
(hypothesis-free `no_realized_absolute_ender`). -/
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

/-- The keystone decomposed into its six component reflections. Same conclusion as
`guardian_only_from_keystone`, exhibiting exactly which correspondences carry it.
`hContinuity` is the source-backed one; the other five + the subject map are the
open source→particular correspondence (named, never assumed true). -/
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
