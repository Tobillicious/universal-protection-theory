# KoruG enactment-gate contract — first executable integration boundary

Status: **proposal / integration specification; NOT a completed runtime proof or globally deployed enforcement**.
Date: 9 November 2026.
Starting main: `552adbc30383cf83d8cb7ee6dd775449f5a0986a`.
Verified finite-W mathematics: tag `koru-finite-w-verified-2026-11-09` at `e0c683d310698a99a45fc53bc92f1d7f17a2b8eb`.

## Decision

**Start at the actual durable application boundary.** Do not graft a self-certified Boolean onto AI output and call it Complete Koru. This repository already has the reference execution boundary in [`target.py`](target.py), the [fencing and durability theorem](THEOREM.md), and [harness](harness.py). The present implementation checks generation tokens and the floor at application, appends to journal/sink, fsyncs, then acknowledges. Its one-machine, macOS sandbox/SIGKILL demonstration does **not** verify Complete Koru, original-six X3, real consent, or cultural authenticity.

Design a **separate** versioned `KoruEventGate` contract to be checked atomically *with* the final apply. Initially implement this as an observational checker/negative-control suite, **without changing** the baseline fenced runtime or weakening its tests. Add fail-closed runtime enforcement only when the validator, source correspondences, and negative controls have been independently reviewed.

## Source-grounded mathematical anchors

- [`PhysicalBridges/Koru.lean`](../physical-bridges/PhysicalBridges/Koru.lean): `koru w a b` is a relational-distinction predicate. The author's intended Complete Koru occupies the **relational operator** position; neither ordinary Lean equality nor `k • G = G` is its definition.
- [`KoruFullOperatorSignature.lean`](../physical-bridges/PhysicalBridges/KoruFullOperatorSignature.lean): arity-indexed `Op n`, `Fin n → P` ordered inputs, intrinsic `enabled` and `enact`, and same-source `PreservesFullSignature`.
- [`KoruCompositionalExpression.lean`](../physical-bridges/PhysicalBridges/KoruCompositionalExpression.lean): full expression trees, evaluation covariance, well-formedness and finite-W nonmerging. The concrete matrix example defines `enabled` as `True`; it does **not** enforce runtime authorization.
- [`KoruWholeEventEnactment.lean`](../physical-bridges/PhysicalBridges/KoruWholeEventEnactment.lean): full subject/action/effect expressions, ordered source roles, exact event coherence and nonmerging. `EnactmentCoherent` is algebraic consistency, **not** consent.
- [`KoruObjectiveWholeU.lean`](../physical-bridges/PhysicalBridges/KoruObjectiveWholeU.lean): six-position whole context; distinct wholes can share an identical local event projection, so **checking a detached event triple is insufficient**.
- [`COMPLETE-KORU-PROOF-INDEX.md`](../../COMPLETE-KORU-PROOF-INDEX.md): proof inventory and existing physical correspondence limitations.

## Two classes of operation — do not conflate them

1. **Reindexing / automorphism:** for a specified full operational signature, verify the concrete mapping and `PreservesFullSignature`; optionally verify that it fixes a *specified* nullary anchor. The stabilizer and signature automorphism intersection is a useful **derived mathematical condition** for these transformations. It is not the definition of Complete Koru.
2. **Admission / mutation / expansion:** additions, journal appends, curricular publication, role or permission changes, and privacy-mandated erasure are not in general invertible self-maps of an unchanged state space. They require a **versioned whole-state transition/refinement relation** with independently justified evidence for the applicable original duties; do not smuggle these through a group action or silently assume `IsSafe` by definition.

Neither category establishes unconditional protection of real-world particulars without a reliable model-to-reality correspondence.

## Proposed event envelope and evidence chain (design, not implemented)

The minimal **typed, versioned** transaction should have *references to*, or securely retained protected representations of:

| Field | Purpose | Verification rule |
| --- | --- | --- |
| `event_id`, `idempotency_key`, `generation`, `fence_token` | Consistent application identity, replay and ordering | Check token and generation at apply as the existing E-LIN target does; reject stale, forged, or conflicting duplicates. |
| `whole_context_ref`, `context_version`, `previous_event_ref` | Identify **which entire represented context** the event is interpreted within | Verify a trusted snapshot/revision and predecessor binding, not just a local three-field view. |
| `subject_expr`, `action_expr`, `effect_expr`, `subject_role`, `action_role` | Preserve syntax-tree identity, operator constructors, arities, ordered operands and source roles | Deserialize using a schema corresponding to a *specified* `Op n`; reject unknown operators, arity mismatches, reordered inputs or ambiguous projections. |
| `signature_id`, `signature_digest`, `transition_kind` | Name the actual signature and whether this is symmetry or state refinement | Verify trusted signature version and select the correct, independently established proof obligation. |
| `witness_ref`, `verifier_version`, `witness_binding` | Bind a certificate to this exact event, context, signature and expected effect | Independently validate a proof or checkable witness. The AI agent's statement that it is certified is **not** evidence. |
| `authority_ref`, `scope`, `purpose`, `expiry` (where applicable) | Authenticate operational rights and any knowledge-sharing restrictions | Resolve through an independent trusted authority and current policy; do not equate `enabled = True` or nonempty strings with permission. |
| `lineage_ref`, `provenance_ref`, `retention_class` | Trace sources, prior decisions and applicable stewardship/retention duties | Record trustworthy lineage and review status; never assume a self-filled attribution field establishes cultural or historical authenticity. |

The envelope is **not** a proposal to persist sensitive raw content indefinitely. Sensitive information should be minimized, access controlled, and deleted or redacted when required. Integrity-preserving audit metadata can retain the *fact and authorization of erasure* without exposing erased content; public hashes of low-entropy private facts can themselves leak information. The duty to honor privacy and knowledge restrictions is not overridden by a maximal-retention slogan.

## Atomic check-at-apply protocol (target design)

```text
AI / teacher / agent proposes event and evidence
    |
    v
Untrusted proposal --(schema, signature, source and authority check)--> checked candidate
    |
    v
AT THE DURABLE TARGET, inside the same serialized application boundary:
  1. authenticate generation / fence and current rights;
  2. read exact current context version and lineage head;
  3. validate complete event expression / role structure and stated output;
  4. verify applicable same-signature symmetry OR whole-state refinement witness;
  5. verify domain authority, privacy/retention and knowledge-sharing restrictions;
  6. reject stale, unverified, malformed, replayed or unauthorized proposals;
  7. atomically append accepted record and receipt, durably commit, then acknowledge.
    |
    v
Outbox / sink processes only accepted event identities,
rechecks authorization / generation at the effect boundary,
and uses durable idempotency for retries.
```

**Security boundary:** check-at-admission only is insufficient; existing `admission_only` mutant in the harness demonstrates this. An independently checkable runtime witness **must** be bound to the exact payload and exact apply-time context. A `proof_ref` string or an AI-created "approved" field is not sufficient. A generalized cross-service atomic commit is NOT established by the current one-machine journal/sink demo.

**Safety boundary:** fail closed on an unrecognized or missing certificate *within a newly designated protected integration route*. Keep trusted operational recovery and emergency/hold mechanisms independently available; never prevent required safety shutdown because a new Koru witness cannot be obtained. Avoid claiming every information-losing operation is unethical: purpose-limited retention, redaction, privacy deletion and legitimate summarization can be required if governed by the appropriate contextual duties.

## Rollout order and acceptance tests

| Phase | Scope | Exit criterion |
| --- | --- | --- |
| 0. Contract and inventory | This document, canonical signature/event taxonomy, exact paths of all privileged commit and effect APIs | No undocumented writer bypass in the **selected pilot**; an explicit list of unknowns remains open. |
| 1. Shadow verifier | Add separate validator with *record-only* results to the existing `evidence/execution-boundary` demonstration, not in the trusted write path | Same baseline outputs and fencing tests; valid synthetic examples accepted, intentionally malformed ones rejected; clearly label unknown real-world correspondence. |
| 2. Controlled pilot | Designated journal/sink operations in a test environment | Atomic check-at-apply, crash/replay/idempotency checks, and independent negative controls, including `admission_only`, forged credentials, changed arity/order, wrong whole-context version, corrupted provenance and forged witness. |
| 3. Formally linked refinement | Checked validator specification and precise link to the relevant Lean full-signature and whole-event theorems | Compiler receipt at an exact SHA; no additional axioms, safety assumptions or weakened original duties disguised as proved. |
| 4. Platform integration | Each **authorized** downstream codebase (e.g. curriculum resource publication) | Inventory all entry points, prevent bypass, enforce trusted source/permission review, and record responsible human signoff. Independently test privacy and tikanga obligations. |
| 5. Release and monitoring | Reproducible release of the pilot and its verification receipts | Required green tests, immutable provenance of exact code/artifacts, independent audit and explicit remaining real-world evidence limits. |

### Negative controls that must fail

- An agent supplies only a text claim of "KoruG certified" with no verified witness.
- A valid witness is replayed against a different payload, signature version, lineage head or whole context.
- Event's local triple matches while the omitted global context differs.
- Operator constructor, input arity or operand ordering is changed.
- Signature preservation is asserted for an arbitrary transformation without a proof.
- Guard is `True` in the matrix model but authentic source permission is absent.
- Authorization is valid at admission but revoked before durable apply.
- Source metadata claims iwi/hapū authority without an independently verified grant.
- Sensitive material is copied into public event logs or indefinitely retained in violation of authorized restrictions.
- Retry duplicates an external effect; forged or stale generation crosses a hold boundary.
- A blanket "no resets" policy blocks an emergency shutdown, authorized deletion or recovery action.

## Definition of "globally locked" (strictly conditional)

Only say **"enforced across the specified deployment"** after every state-changing and side-effect path in *that deployment* is covered by the approved runtime gate, cannot bypass it, and has reproducible receipts. No repository proof or local CI run can change the underlying behavior, weights, or persistent alignment of unrelated AI models or external platforms. "KoruG globally locked" is **not** currently an established outcome.

**First concrete engineering target:** implement the shadow verifier and its mutation tests *adjacent to* `target.py` with a documented, independently checkable event schema; keep the existing journal/sink contract intact until the tests justify integration.
