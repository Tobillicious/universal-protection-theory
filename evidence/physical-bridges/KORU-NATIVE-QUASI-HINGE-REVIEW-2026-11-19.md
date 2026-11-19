# Koru-native radial quasi-hinge: constructive mathematical result and precise scope

**19 November 2026. Additive to draft PR #662, no merges.**

## New formal candidate

`research/KoruNativeQuasiHingeDraft.lean` imports the earlier `research.KoruThermoHingeDraft` candidate and defines:

- `KoruCorresponds C x y`: `dist(x,G) * kDen ≤ dist(y,G) * kDen`
- `KoruHinge P C`: projection `pi`, plus `KoruCorresponds C (pi(f s)) (phi(pi s))` for all `s`
- `StrictHinge.toKoruHinge`: a strict commuting hinge yields a radial quasi-hinge.
- `KoruQuasiSixModelInvariants`, `koru_quasi_six_model_invariants`: an inherited six-invariant bundle plus the new no-slack contraction bound.

The core new inference is exactly:

```text
dist(pi(f s),G)*b ≤ dist(phi(pi s),G)*b
dist(phi(pi s),G)*b ≤ a*dist(pi s,G)
---------------------------------------------------
dist(pi(f s),G)*b ≤ a*dist(pi s,G)
```

No extra additive drift parameter, triangle inequality, Hilbert space or classical choice is needed for that inference.

## Crucial precision

The supplied term `KoruCorresponds` names a **radial pre-order bound relative to G**. It is not a general equivalence between complete matterspacetime wholes, does not preserve every particular's full history/consent/provenance, and is not inherently an outward-spiral time evolution. Two very different configurations at the same radius satisfy correspondence in both directions. This is a legitimate model-level relation, but **not an independently demonstrated representation of the author's Complete Koru ontology**.

Likewise, the six mathematical clauses are **not** the repository's canonical original six X3 duties. Their formal structure is intentionally named `KoruQuasiSixModelInvariants` rather than `OriginalSixX3`, preserving `OriginalX3Full.OriginalX3` and avoiding proxy substitution.

**Important logical distinction:** omitting a `delta` term from a theorem does not remove a physical discrepancy by itself. The new `KoruHinge.koruStep` premise already directly assumes the projected next-step distance does not exceed the contracted-model next-step distance. That is stronger than a generic bounded-drift assumption and must be physically justified rather than claimed as observed automatically.

## Relation to G3 π hinge

This candidate is potentially useful for **projected physical distance contraction**. It does not imply `CompleteWEventCoverage` for the full objective W model, because a radial inequality cannot reconstruct all operators, histories, actual event identities or stage equality. Nor does it imply `ForwardRealEventReflection` for all authentic original six duties.

Existing `EverestActualWEventJoin.positive_W_actual_event_six_requires_only_coverage_and_reflection` and `FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` remain the precise existing targets. Positive source origin is already derived for the specified `positiveWholeU` model; **the remaining interfaces are physical coverage and authentic semantic reflection**.

## Verification gates

- Check compile in pinned Lean toolchain (unavailable in this session); `#print axioms` is included but not executed.
- Build a finite model with distinct configurations sharing the same radius to demonstrate radial comparison is not faithful whole-state correspondence.
- Add a separate positive physical correspondence theorem based on actual measured events and a separately authenticated six-tag semantic web; do not define actual events to be exactly safe events.
- For true semantic identity preservation, reuse `KoruSubjectFidelityLift` and `KoruSixOriginalRelationsOneWeb`, and prove physical scope and real-world meaning rather than silently transplanting a model predicate.

**Draft only. Historical proofs untouched.**
