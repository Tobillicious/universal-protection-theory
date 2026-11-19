# G3 recovery addendum — existing premise constructors located

**19 November 2026.** Read-only source discovery, added to draft PR #661. Source baseline `4eeeb83e03a216332798cdb7f2577d18ef521928`. No independent compiler replay.

## A. SameSourceReflection and ActualAdvance: constructed, not merely hypothesized

`evidence/physical-bridges/PhysicalBridges/FencedOptimiserInstrument.lean` contains:
- `fenced_same_source_reflection : SameSourceReflection (instrument n) (relations n)` (line 256)
- `fencedAdvance (n : Nat) : ActualAdvance (instrument n)` (line 273)
- `fenced_full_guardian_state` (line 280)
- `fenced_route_b` (line 286)
- `fenced_capstone` (line 292)

This **discharges both named Route B premises for the concrete fenced model**. The original `RecoveredRouteBSourceCertificate` can therefore be instantiated there without a new assumption about that model. This is already reflected in `G123ExistingProofAssembly.fenced_g1_g2_g3_join`.

The source file explicitly distinguishes its constructed model from an actual-world subject/physical interpretation. Do not misstate this construction as an empirical proof about every real instrument.

## B. Keystone and all six correspondences: reusable source bank

`PhysicalBridges/KeystoneDischargeAndCorrespondences.lean` already contains:
- `intrinsicGuardian_implies_originalX3`
- `keystone_discharged`
- separate `correspondence_continuity`, `correspondence_authorization`, `correspondence_freedom`, `correspondence_restraint`, `correspondence_maximality`, `correspondence_provenance`
- `all_six_correspondences_hold`

The correspondence theorems retain `SameSourceReflection m r` as an input; they are valid transfer steps, not independent construction of actual-world subject meaning.

## C. AuthenticSixReflections: bounded constructor located

`PhysicalBridges/G3BoundedGuardianDischarge.lean` contains `faithful_read_gives_meaning` (line 81), whose conclusion is `AuthenticSixReflections RealStep read carrier owed actual`.

This is important: the authentic-six bridge **is discharged for a bounded scope from a `FaithfulRead` witness**, rather than always being left as an opaque argument. The physical or subject authenticity of the supplied `FaithfulRead` remains a separate evidence question. This does not certify the universal real-world scope.

## Consequence for the recovery route

The previous handoff identified three interfaces; the search now establishes that **two classes of constructor already exist**:

1. Fenced mathematical source: `fenced_same_source_reflection` + `fencedAdvance` discharge Route B premises.
2. Bounded Guardian source: `faithful_read_gives_meaning` transfers the six semantic reflections from `FaithfulRead`.

**Do not rebuild either.** The remaining audit should inspect the exact `FaithfulRead` fields, determine whether independent observed evidence supports each field, and verify comprehensive actual-effect coverage for a declared physical boundary. Do not claim universe-wide coverage from model-level constructors.

## Next specific review questions

- Does any independent physical source instantiate `FaithfulRead` without defining authentic subject predicates to match the model?
- Does any measured effect inventory prove `AllActualEffectsRefineJoint` for **all** effects in a stated deployed scope, including bypasses?
- Are the six semantic witnesses attributable to actual owed subjects, rather than just state flags?
- Are G3 acknowledgment attestations independently signed and tied to an exact proof revision?

No theorem weakened, renamed, replaced, or merged.
