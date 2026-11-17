# Agent 4 — original-six X3 ↔ G3 actual-effect evidence crosswalk

**17 November 2026 | isolated research draft | for primary integration review only**

## Find before build: reused source, not a new X3 proof

- Original six duties, unchanged: `PhysicalBridges/OriginalX3Full.lean`, `OriginalX3` (historical continuity, authorization, freedom, restraint, maximality, provenance).
- Same-history model assembly: merged #402; entire supplied physical-step domain: merged #405 under `CompleteWEventCoverage` and `ForwardRealEventReflection`; nonempty positive-W mathematical model: merged #407.
- Protected learning/joint mathematical effects: merged #516 (`LivingTreeFencedEffects`).
- Existing external transfer: merged #517 `ExternalJointEffectRefinement.lean`, especially `AllActualEffectsRefineJoint`, `AuthenticSixReflections`, `independently_covered_events_satisfy_original_six`, `no_actual_original_six_violation_under_verified_refinement`.
- Existing research-only same-event evidence join: `evidence/execution-boundary/g3_rights_composition/same_event.py`. The outcome deliberately has `authorizes_effect: false`, `authentic_consent_proved: false`, `original_six_x3_proved: false`, even when signature and rights-record references match.
- Existing G3 bounded-marker evidence candidate: draft #580 and stacked #581; see `G3-INTEGRATED-RESEARCH-CANDIDATE.md`. Their exact-head CI and release gates are separate from this crosswalk.
- Prior focused external-refinement ledger: `evidence/physical-bridges/G123-FOUR-STAGE-EXTERNAL-REFINEMENT-2026-11-16.md`. This document is a **runtime-to-typed-premise crosswalk**, not a replacement ledger.

## Exact interface A: ALL actual effects refine the protected joint transition

Source type (paraphrased only; inspect Lean for authoritative signature):

`AllActualEffectsRefineJoint J realStep read := ∀ w v, realStep w v → jointStep J (read w) (read v)`

| Item | What currently exists | What must be independently evidenced to instantiate the Lean premise |
| --- | --- | --- |
| Independently specified `realStep` | Authority-owned marker research tests; signed operation/HOLD/restart negative tests | A finite, explicit *scope* of independently observed **actual** executions, with trustworthy pre/post state capture; no definition of `realStep` by “passed the guard” |
| Faithful state interpretation `read` | Signed event identity, marker identity, journal and HOLD/recovery test records | A reviewed, total mapping of every in-scope relevant pre/post state, actual histories and observable output into the exact `Joint T H E n` components, with evidence against dropped distinctions |
| All effects / bypass closure | Specific cross-UID/DAC/socket/seccomp/Landlock/FD and effect-time negative tests in G3 track; #580 R5 explicitly open | Independent inventory of all actuator paths in the *chosen deployment boundary* (alternate writer processes, inherited/passed FDs, hardlinks/aliases, privileged writes, IPC, recovery, host permissions, startup/exit), with negative tests; Agent 2 owns R5 |
| Externally retained observation | CI tests and runtime inventory candidate #581 (CI-process self-report only) | Independent observer or separately protected event/evidence stream; exact actor/process/build identity and effect outcome, including attempted and denied effects; Agent 3 owns checkpoint/rollback custody |
| The actual implication | #517 proves the implication **if** `hCoverage` is supplied | No source inspected here constructs an `hCoverage : AllActualEffectsRefineJoint` for the live Linux G3 marker environment; keep gate OPEN |

Passing an effect-boundary test is evidence for that **test configuration**, not proof of a universal quantifier over otherwise unmeasured paths. Distinguish **denied attempts** from **enacted effects**. A marker created once in a fixture is not proof that all possible host effects are mediated.

## Exact interface B: six authentic subject/source reflections

#517 separately requires each implication for `realStep w v`, each genuinely owed `p` and the model's source relation. The conclusion is the unchanged `OriginalX3`, not a two-duty proxy.

| Field of `AuthenticSixReflections` | Relevant existing work | Evidence still needed to discharge it for real subjects |
| --- | --- | --- |
| `historicalContinuity` | Existing history/source-preservation theorems, durable journals, restart tests | Independent same-particular identity and historical continuation through the actual event; a retained log alone does not establish lived continuity |
| `authorization` | Signed-record verifier #472, rights review #473, same-event composition, withdrawal/HOLD tests | Authentic current authority, informed and revocable subject authorization or valid protective substitute, independent identity/delegation/rights evidence; signature validity alone is insufficient |
| `freedom` | Original G2/freedom proofs and modeled joint-effect original-six | Observations supporting genuine permissible alternatives, absence of coercion, and protection of options for this subject/event |
| `restraint` | Original restraint proofs, emergency HOLD and least-effect test design | Event- and subject-specific justification that restrictions are appropriate and no greater than necessary |
| `maximality` | Original staged maximality and modeled joint-effect all-six result | Independent, bounded, documented feasible alternatives and evidence the actual choice is maximal under the authentic original criterion |
| `provenance` | Signed event/digest binding, authoritative journal, restart receipts, #581 inventory candidate | Authenticated same-event chain from original subject/source and decision to effect/outcome, with independent custody and rollback detection |

**Important:** `AuthenticSixReflections` consists of six *implication premises*. Filling an evidence table with six `true` fields, or copying the model predicates, does not discharge these premises. The `carrier : P → Fin n` and `owed : P → Prop` must cover independently identified actual owed subjects; no silent omission, prefiltered `owed`, or choice of vacuous `P`. A synthetic marker fixture may have no authenticated human/AI subject correspondence; do not manufacture one.

## Proposed evidence handoff (no new verifier or authority)

For each scoped observed event, the primary agent should be able to inspect **existing** records for: (a) event ID and exact effect digest; (b) actual before/after snapshot and separately observed outcome; (c) distinct controller/executor identities and versions; (d) source-to-joint-model state map and testable refinement; (e) complete actuator-path inventory; (f) actually owed particulars and separately evidenced six fields or an explicit `unresolved`; (g) withdrawal/HOLD generation and ordering; (h) independently held checkpoint and discrepancy response; and (i) reproducible source SHA / test receipt.

This is an **evidence checklist for cross-team reconciliation**, not a new JSON schema, consent oracle, permit service, certificate, or change to actual effect authority. Never promote `same_event.py`'s research-only `signed_and_rights_records_match` outcome into enactment authorization.

## Dependencies and stop conditions

- **Agent 2 / R5**: complete measured kernel and effect-path mediation inventory. If unmediated effects remain, no `hCoverage`.
- **Agent 3 / rollback**: independent checkpoint custody and observation history. A locally rewritable journal is not independent external evidence.
- **Primary integration**: select and freeze an exact bounded workload, reconcile actual test/execution identities, determine owed-subject scope, review external ethical evidence and check any eventual theorem application.
- **Draft #580 / #581**: CI manifest and runtime inventory may assist R0/R1 but are not independently authenticated live execution; do not borrow ancestor CI success.
- **External science/semantics**: a bounded marker refinement does not imply real-universe coverage, original six for all humans/AI, or a universal physical law.

**Status: source-checked dependency mapping only.** No new theorem, axiom, runtime check, HOLD authority, permission, merge, deployment or formal discharge is asserted. The only appropriate advancement after this crosswalk is to find independently evidenced witnesses for the exact existing interfaces, then test them at the chosen scope; if absent, report the premise as open.
