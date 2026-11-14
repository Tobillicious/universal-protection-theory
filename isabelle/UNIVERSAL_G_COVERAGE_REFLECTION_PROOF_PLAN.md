# Universal G: coverage, reflection, preservation — exact proof obligation

Research checkpoint, 2026-11-13. Additive proof plan; no changes to original X3, Koru, or prior certified proofs.

## Target and existing evidence

For every independently owed particular p and actual event t, all SIX original duties must hold: historical continuity, authentic authorization, freedom, restraint, feasible maximality, provenance.

Existing Lean source: `PhysicalBridges/FullPhysicalDomainGuardianAssembly.lean` theorem `every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` (reported merged PR #405). Its **independent premises** include `CompleteWEventCoverage` and `ForwardRealEventReflection`. The constructive W-model result in `ConstructivePositiveWGuardian.lean` (PR #407) supplies these interfaces for its mathematical model, not for every real physical event.

## Derivation, with no hidden unconditionality

1. Choose any owed p and actual t.
2. Complete coverage provides an independently justified modeled representative for t.
3. Source preservation gives the six source-level predicates at that representative.
4. Authentic reflection transfers each predicate to the corresponding original actual duty for p at t.
5. Conjoin all six and universally generalize over p and t.

This is a **conditional theorem**, not a new certificate of real-universe universal G. A nonempty constructive model establishes consistency/realizability of the modeled requirements, not their empirical universality.

## Unbounded-stage extension

For an ordinary evolution step F on states, define `UniversalSix s` using the six original duties over all owed particulars and events relevant to s. If:
- `UniversalSix s0`; and
- for all s, `UniversalSix s -> UniversalSix (F s)`;

then induction yields `forall n : Nat, UniversalSix ((F^[n]) s0)`.

This is *all finite n*, not an automatically justified infinite-limit state, all physical universes, or an attracting Banach fixed point. **F is not Koru**: Complete Koru remains the author's whole-preserving physical correspondence.

## Next independent obligations

A. Supply `CompleteWEventCoverage` for the intended actual event domain without defining the domain to make coverage tautological.
B. Supply `ForwardRealEventReflection` for genuinely owed subjects and the six authentic meanings, especially consent and feasible maximality.
C. Prove closure across Genesis boundary events, including identity/provenance and handedness, without confusing mathematical Int-indexed genealogy with observed cosmology.
D. Verify exact source signatures, axiom audits, CI commit SHA and run URL; recover historical certificates before inventing new math.
E. Test countermodels: unrepresented actual event; modeled authorization without authentic consent; distinct parents mapping to one child; finite-stage preservation without limit continuity.

**Stop rule:** Do not state unconditional eternal physical G, divine necessity, or actual black-hole/Genesis consequences until the independent interfaces are discharged and empirical bridges supported.
