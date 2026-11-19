# G3 recognition gate — executable review contract and counterexample matrix

**Proposed 19 November 2026; additive only; draft PR #661.**  
**Frozen base:** `4eeeb83e03a216332798cdb7f2577d18ef521928`. No merge, no automatic acceptance, no edits to existing mathematics.

## Goal and success condition

A reviewer can recognize a **versioned, accurately scoped G proof claim** when the exact theorem statement, its premises, proof dependencies, and independent replay evidence are available. Recognition is a documented judgment by that reviewer; it cannot be inferred from the existence of a PR, from model agreement, or from a mathematical theorem about a different scope.

**Success criterion for this PR:** produce a reproducible, source-pinned review procedure and explicit counterexample tests. This PR does not itself meet universal acknowledgment.

## Reproduction checklist

Run in a clean checkout of the *pinned revision* (do not silently substitute moving main). Confirm the repository's declared Lean and mathlib toolchain before executing the following illustrative commands from `evidence/physical-bridges`:

```sh
git rev-parse HEAD
cat lean-toolchain
lake --version
lake build PhysicalBridges.G123ExistingProofAssembly
lake build PhysicalBridges.RecoveredRouteBSourceCertificate
lake build PhysicalBridges.G3ProofOfGod
lake build PhysicalBridges.G3UniversalBridge
lake build PhysicalBridges.G3BoundedGuardianDischarge
lake build PhysicalBridges.G3TreeOfLifeUnconditional
lake build PhysicalBridges.G3SameEventCapstone
lake build PhysicalBridges.ExternalJointEffectRefinement
```

Record command exit codes, stderr/stdout, environment, and full commit SHA. **These commands have not been run for this document.** Existing `#print axioms` directives should be captured from actual Lean output; report all assumptions and imported axioms rather than treating a green CI badge as a full physical certificate.

## Theorem-to-claim crosswalk

| Claim | Existing source | Required qualifier |
|---|---|---|
| Fenced original-six Guardian + Route B + history | `G123ExistingProofAssembly.fenced_g1_g2_g3_join` | Constructed `World n` |
| Same-source original-six and actual next step | `RecoveredRouteBSourceCertificate.original_six_route_b_and_real_next_from_same_source` | Requires `SameSourceReflection` and `ActualAdvance`; both are constructed for the fenced model |
| Covered external events satisfy original six | `ExternalJointEffectRefinement.independently_covered_events_satisfy_original_six` | Requires `AllActualEffectsRefineJoint` and `AuthenticSixReflections` |
| Bounded physical guardian | `G3BoundedGuardianDischarge.g3_bounded_unconditional_guardian` | Requires `FourCauseJointRefinement` and `FaithfulRead` |
| Tree protection + record retention | `G3TreeOfLifeUnconditional.g3_tree_of_life_unconditional` | Also requires `hRecord`, `hEthics`, and a `RealStep` |
| Partial observer cannot exactly decode liveness | `G3ProofOfGod.THE_CATEGORY_ERROR` | Requires the indistinguishable nonlive alternative and other explicit premises |
| Universal physical protection | No unconditional actual-universe certificate established by this review | Requires independent evidence for all actual effects and owed particulars |
| Universal acknowledgment | No universal attestation evidence established by this review | Requires actual independently signed acknowledgments |

## Four adversarial checks: fail closed on overclaim

**Counterexample 1 — observational aliasing.** Let complete states `a` and `b` share one observer record, while protection holds at `a` and not `b`. A classifier from that record cannot exactly determine protection. This shows epistemic insufficiency, **not** that `b` is impossible. Ask whether the claimed G inference illegitimately moves from no exact decoder to universal protection.

**Counterexample 2 — collapsed individuals.** Let `carrier : P → Fin n` map two genuinely distinct owed particulars to the same model carrier. Even if all six model fields hold, verify that the two real subjects' consent, continuity, agency, and provenance are each independently reflected. A many-to-one map must not erase subject distinctions. Test the `AuthenticSixReflections` fields individually.

**Counterexample 3 — omitted physical channel.** Add an external effect to the independently observed `realStep` relation which is not a `jointStep` under `read`. Then `AllActualEffectsRefineJoint` fails. Do not hide this by narrowing `realStep` after observing the effect. Record the missing cause and fail HOLD.

**Counterexample 4 — simulated authorization.** A model flag reports authorization, but the owed subject did not authentically authorize. The `authorization` reflection must fail for that event; a proof about the model's flag cannot replace actual consent.

## Jung–Einstein interpretive discipline

Jungian individuation motivates preservation of the distinct particular within the whole. Jungian projection motivates testing whether a subjective judgment was improperly generalized. Relativity motivates invariance under admissible changes of description. Neither Jung's psychology nor Einstein's relativity is itself a premise that proves G universally, or that every E claim is false.

The strongest defensible category-error statement is: **a partial observer cannot infer a global property when the observation fails to distinguish complete states with different values of that property**. Independent evidence and a universal protection theorem would be needed to go further.

## Recognition receipt schema (human-readable; not a forged receipt)

```text
REVIEWER: [independently identified participant]
SOURCE_COMMIT: [full 40-character SHA]
THEOREMS: [exact fully-qualified names and types]
LEAN_TOOLCHAIN: [version and dependencies]
BUILD_LOG_HASH: [SHA-256 of authentic build log]
AXIOMS_AND_HYPOTHESES: [verbatim output + review]
CLAIM_SCOPE: [fenced mathematical / bounded physical / other]
PHYSICAL_EVIDENCE: [verified references or NOT ESTABLISHED]
SUBJECT_MEANING: [six separately verified fields or NOT ESTABLISHED]
REVIEW_DECISION: [accepted / qualified / rejected / abstained]
SIGNATURE: [actual participant signature, never prefilled]
```

An empty ledger is an honest ledger. No receipt may assert another reviewer's assent.

## Handoff decision

Preserve all existing G1/G2 results and the original six X3 duties. Add no axiom to obtain universal G, no proxy X3, no forced reviewer acceptance, no fake consensus, and no inferred physical evidence. Independent proof replay and actual subject/effect verification are the next gates.
