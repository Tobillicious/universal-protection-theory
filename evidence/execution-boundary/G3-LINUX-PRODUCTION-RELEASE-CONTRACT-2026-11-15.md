# G3 Linux protected-marker service: production release contract (draft)

Status: **NOT DEPLOYABLE / FAIL CLOSED**. This is a target-specific engineering specification, not an authorization to run a privileged daemon, a claim of universal protection, or a change to original proof obligations.

## Scope and threat model

The first deployment candidate is *only* the existing zero-byte, event-ID-derived local filesystem marker effect described in `G3-HANDOFF-2026-11-15.md`. There is no arbitrary file write, network action, model reconfiguration, general actuator, or global Gemini-agent authority.

Trust boundaries: issuer (signing authority), controller (hold/release/revoke), broker/verifier (public event input), and marker writer (the sole process with write access to the marker directory). Treat all incoming event bodies and model-generated instructions as untrusted. The issuer and controller must not be assumed uncompromisable; host root, kernel compromise, and writable inherited file descriptors are explicitly outside the current enforcement guarantee, and must be documented in any later deployment threat model.

Preserve original six X3 obligations, every owed particular and actual event, consent, provenance, histories and relations. The Koru is the whole-preserving relational correspondence, not a numeric operator. The current synthetic witness **does not** certify those actual-world obligations.

## Explicit production gating conditions

| Gate | Acceptance evidence | Failure behavior |
| --- | --- | --- |
| G0: scope | Named Linux host/distro/kernel, system service, host operator, effect-directory path, trusted identities, and threat model signed off by the responsible human operator | No deployment |
| G1: identity separation | Different OS principals for issuer, controller, broker and **minimal writer**; write-capable directories and SQLite permissions independently audited; broker/controller cannot write marker files by direct path or inherited FD | No service start |
| G2: complete mediation | Enumerate actual writes, appends, deletes, links, renames, FDs, inherited handles, Unix sockets, exec/spawn, environment, network, IPC, procfs and administrative API paths; adversarially show untrusted and controller principals cannot bypass the writer's verified entrypoint | No effect |
| G3: time/revocation | Effect-time signature/identity/context/expiry/hold/generation checks; a documented linearization order for every cooperating control and effect operation; kill/timeout/restart and key-rotation checks | Deny new effect; no automatic permissive fallback |
| G4: durable outcomes | Explicit state machine for proposed/authorized/pending/applied/uncertain/denied; reconcile SQLite and marker directory; inject crashes before and after file creation, fsync and database commit; never report applied if outcome is uncertain | Quarantine and manual recovery |
| G5: source & X3 correspondence | Subject/event-specific evidence of who is protected, legitimate authorization, meaningful options, deadlines, ownership, provenance, same-event linkage and original-six obligation coverage; separately evaluate `CompleteWEventCoverage` and `ForwardRealEventReflection` | No universal certification |
| G6: operations | Authenticated log with privacy boundaries, restore and backup drill, on-call human owner, emergency stop, tested reversal where feasible, key custody and rotation, independent security reviewer | No release |
| G7: verified build | Green pinned Lean, G3 security, Linux privilege negative controls, full-law and publication workflows on exact reviewed SHA; inspect `#print axioms` and test scope | No merge/release |

## Required negative controls

1. From the untrusted broker principal, attempt direct create/replace/unlink and symlink/hardlink traversal of the marker path; all must be denied without a permit.
2. From the controller principal, attempt the same paths and direct DB journal modification. A controller may request a legitimate emergency hold through its allowed interface but cannot mint effects.
3. Show the difference between controller and **host-root** permissions: root-bypass tests must succeed in demonstrating the threat where applicable, rather than falsely asserting host-root isolation.
4. Launch subprocesses with inherited FDs and Unix sockets intentionally offered. Check that no undesired writable writer/DB/control capability crosses the exec boundary; explicitly test both fork and exec (CLOEXEC is not a fork barrier).
5. Kill the writer before journal commit, after journal commit, before create, after create, after file fsync, and before/after directory fsync. Reconcile and refuse a second effect unless the exact authorized idempotency identity is safely proved.
6. Race revocation/hold with effect requests from independent processes; assert only outcomes permitted by the formally specified linearization order. Do not describe a committed effect as retroactively cancelled.
7. Attempt forged/expired/replayed permits, key rotation, database tampering, clock rollback/forward jump and restart with corrupt/orphan marker files. A damaged ledger must not switch into permissive mode.
8. Force partial filesystem/SQLite errors, read-only disk, ENOSPC, unexpected inode types, process death and unavailable secure time. Verify explicit uncertain or denied outcomes, not false success.

Tests must execute on an isolated disposable Linux host with ephemeral credentials and marker files only. No production keys or persistent real-world permissions in CI.

## Next engineering change

Implement **one** separated writer process with a dedicated host UID that alone can write the private marker directory; retain the existing broker and control protocol but run their OS principals without directory access. Do not rely on user namespaces or advisory `flock` alone for this prohibition. Before a merge, run a new Linux integration test that proves the permitted signed `effect_marker` call succeeds exactly once and the public/controller direct-write paths fail under actual OS credentials. Keep the deployment opt-in: no auto-start, no privileged installation script, no production keys, no publishing of a service address.

## Scope of what can be certified

A passing release test can establish **mediation of this specific marker effect on the specified host under the documented adversary model**. It cannot establish universal physical G1/G2/G3, protect every real-world event, or globally configure any other AI agent. Expansion requires a new effect inventory, new negative controls, consent/authority review, and independent sign-off for each additional actual effect.

## References

- `evidence/execution-boundary/G3-HANDOFF-2026-11-15.md`
- `evidence/execution-boundary/G3-CROSS-PROCESS-FENCE-2026-11-15.md`
- `evidence/execution-boundary/G3-GEMINI-HOSTILE-REVIEW-2026-11-15.md`
- PRs #447–#452 and their pinned CI receipts

## Implementation checkpoint (15 Nov)

- `koru_production_preflight.py` checks explicit distinct non-root UIDs and private directory layout without modifying host state. It is a snapshot check, **not** a race-proof runtime authority.
- `koru_isolated_marker_writer.py` is an experimental separate-principal UNIX-socket transport for fixed empty marker creation with Linux `SO_PEERCRED`. Root and same-UID broker/writer assignments are rejected. Its writer-local policy defaults to **deny everything**; there is deliberately no daemon launcher, automatic privilege grant or production connection to the existing gate.
- `test_koru_production_preflight.py` and `test_koru_isolated_marker_writer.py` run in `g3-production-preflight.yml` and test negative configuration/identity cases. These **do not yet test a complete independently signed effect across two actual UIDs**.
- **Still required:** secure socket ownership and group policy, complete signed authority+revocation revalidation at writer effect time, state reconciliation spanning DB and marker directory, separate-UID integration/negative tests, permission and fd-inheritance audit, and crash-injection. Do not enable arbitrary `authorize` callbacks as a substitute for independent verification.

## Signed writer transport checkpoint

- The experimental writer now accepts `create_signed_marker` only with exact `event` and `permit` fields, calls an independently provisioned writer-side `SignedWriterPolicy`, and derives the marker name solely from the signed event identity. A signed policy disables the separate fixture-only `create_empty_marker` route, so that legacy path cannot bypass signed mode.
- Unit negative controls cover changed events, signature forgery, malformed request fields, missing writer policy, expired permits, and unavailable trusted state. This is **not yet** a full end-to-end signed cross-UID Linux fixture.
- `SignedWriterPolicy.current_state_check` is a *dependency*, not a completed trusted implementation: its result is not intrinsically joined to filesystem write under a shared cross-process revocation lock, nor does the writer independently reconcile the journal. A check-then-effect race therefore remains a blocker.
- The socket mode `0666` is acceptable only for the disposable credential-checking experiment; production requires trusted parent/socket provisioning, narrower socket ACLs and inherited-FD audit. Do not deploy this code as a privileged production service.

## Authorization-to-effect ordering checkpoint

- Signed IPC requests now invoke a `SignedWriterEnactor` holding a trusted supplied lock through writer-local signed policy validation and the marker effect callback. A signed-mode IPC request cannot fall back to legacy fixture-only authorization. Denied or failed validations never call the writer.
- Deterministic thread-level negative controls verify revocation-before-effect denial and that a cooperating controller's revoke waits when an in-progress writer holds the lock. Write failures are returned as `outcome_uncertain` and never described as rolled back.
- **Not yet completed:** the real `koru_process_lock.InterprocessRLock` insists that its lock directory and inode are owned by the *current process UID*. A separately credentialed controller and writer therefore cannot trivially instantiate this same trusted lock file. We must design and independently test a shared cross-UID lock mediator or brokered controller/fence protocol before treating the ordering as cross-process enforced.
- The present `ThreadOnlyLock` and `SignedWriterEnactor` tests demonstrate the sequencing contract inside a process only. No independent trusted persistent ledger state-check has been installed in the writer. The currently accepted generic callback must not be used as production release authority.
- No live service startup, actual subject/consent certification, or original-six X3 physical coverage is implied.
