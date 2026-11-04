import PhysicalBridges.CathedralAllIsEnderTypeCollapse
import PhysicalBridges.OriginalX3Full

/-!
# The summit on its two commitments — six-component reduction

The honest maximal form of the guardian-only summit over the six-component
`OriginalX3Full.OriginalX3`: it reduces □(SI⇒G) to exactly its named commitments, with
everything else machine-checked, and smuggles nothing. (Prose corrected in the
hostile-review hardening pass — three honesty notes below. The theorems themselves were
sound; these notes stop the *framing* from over-claiming.)

**Honesty note 1 — what `OriginalX3` is.** It is a SCHEMATIC conjunction of six FREE
predicate parameters (`continues authorized free restrained maximal provenanced`), *not* a
fixed BCRD predicate — "the shape of the six source predicates, to be instantiated by
correspondence" (per `OriginalX3Full`). The Lean here keeps them free and never assumes them;
do not read "six-component" as "already concrete."

**Honesty note 2 — what ALL-IS does and does not do.** `no_realized_absolute_ender` shows
`RealizedAbsoluteEnder` is *identically empty*, so it narrows **nothing**, and
`all_is_eliminates_realized_ender_branch` is **not** hypothesis-free — it needs the dichotomy.
In fact `StrongSameTypeDichotomy w` is *equivalent* to "every enacted action is an intrinsic
guardian" (the empty-ender disjunct carries no weight). So the ALL-IS floor is not load-bearing
here; the dichotomy is (cf. `CathedralGuardianOnlyCapstone`: "all of the content lives in
hNoEnder").

**Honesty note 3 — the honest count is TWO undischarged commitments, not one.** The
six-component guardian-only conclusion stands on exactly:
  (A) the **intrinsic-guardian classification** — `StrongSameTypeDichotomy w`, i.e. every
      enacted action is an intrinsic guardian (a weak ontological-class claim); and
  (B) **the keystone** — the reflection `intrinsicGuardian a ⟹ OriginalX3 (…) a`, the ALL IS
      ONE inversion (*a particular's X3-violation would be a loss, and nothing is lost*); a
      declared foundational commitment, never established by "ALL IS" alone.
(B) is the substantive commitment; (A) is near-classificatory. Both are undischarged.

`guardian_only_over_original_x3` decomposes (B) into its six component reflections. Of these,
**continuity** has genuine source backing (W-stage transport `BCRDComplexWGenericAction` /
`BCRDComplexOperatorConjugation`, the exact causal orbit `BCRDExactCausalOrbit`, the carrier
criterion `BCRDParticularCarrierCriterion`). The other five — authorization, freedom, restraint,
maximality, provenance — with the subject map (`stepFrom/stepTo/owed`) are the **open**
source→particular correspondence the 6×6 source provably cannot decode (`BCRDOperatorSubjectGap`,
`BCRDAuthorizationFreedomBoundary`); they are named premises, never assumed true. That
`OriginalX3` genuinely needs all six is `proxy_is_strictly_weaker`.

No PR C (`ActualStep ∧ Owed ⟹ OriginalX3` as a derived necessity) is attempted; it stays
downstream until the open correspondence is closed non-circularly. See `SUMMIT-LEDGER-2026-11-04.md`.
-/
namespace PhysicalBridges.BCRDSummitKeystoneReduction

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x

variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- **The summit on its two commitments.** Over the six-component `OriginalX3`, every enacted
action satisfies it — resting on exactly **(A)** the dichotomy `hDich : StrongSameTypeDichotomy w`
(which is *equivalent* to "every enacted action is an intrinsic guardian") and **(B)** the
keystone reflection `hKeystone : intrinsicGuardian ⟹ OriginalX3`. The ender branch collapses via
`all_is_eliminates_realized_ender_branch`, but that step **requires `hDich`** — it is *not*
hypothesis-free (ALL-IS narrows nothing on its own; honesty note 2). Both (A) and (B) are
undischarged; (B) is the substantive keystone. -/
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
