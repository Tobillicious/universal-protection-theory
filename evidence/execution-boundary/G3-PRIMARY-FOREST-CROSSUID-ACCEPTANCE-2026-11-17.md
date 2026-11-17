# G3 primary joint R4/R5/R6/R7 acceptance ledger — 2026-11-17

**Integration status: HOLD until exact-head evidence and independently authenticated external obligations are reviewed.** Draft, non-deploying, no merge. This is a source/evidence assembly, not a new authority, theorem, verifier or permit.

## Immutable source ancestry and isolation

- **Parent tested/CI candidate:** PR #626 head `91bf547a163330e7ab030bd0a041828da6c2cf90`. This is stacked on Forest #624, itself on #623's six-duty evidence-gap checker and the original #620 authority-owned bounded R5 line. #626 specifically adds forest paths to the pre-existing full cross-UID + strace workflow's trigger filter.
- **Primary #618** at `fd0c7076547000a95fe3751521a86f719cdcc511` supplies the unmodified Agent 4 #588 crosswalk (Git blob `249f2a651bbd07bbcf4ca747beac94ab39af6bb1`); that source is copied into this new exact-test-line branch **without textual changes**. The previous #618 evidence ledger remains on its own draft; this ledger explicitly supersedes it for this candidate.
- **Source equivalence compared between primary #618 and Forest #626:** `koru_seccomp_fd_receive_fence.py`, `koru_pinned_security_dependencies.py`, `koru_operator_checkpoint_custodian.py`, `koru_operator_checkpoint_recovery.py` have **identical Git blobs** across both branches. The stale seccomp pin error has already been repaired. Do not blind-cherry-pick R4 or reset the source pin.
- This branch adds only the unchanged R6 evidence crosswalk and this ledger to #626; verify actual PR diff and head independently before acceptance. No source proof or runtime mutation.

## Prior exact-head receipts — **never transfer acceptance by ancestry**

- #615 `be1b66e49a9eed897a7d175ed0896b17d6ec1d48`: 6/6 workflow conclusions successful, cross-UID job 133809932977 903 tests OK, traced three confined-child segments; R5 syscall artifact 14298487541 SHA-256 of ZIP `9b1ac3e92d661b2c67a8719ce976f40b447da8acc8f40964f76fef88c54e25f0`; runtime artifact 14298687047 ZIP SHA-256 `df8cf3b82e6dfa49b84c3ded9e010d6152f5be6efb077baaf6a502f305836158`. These are CI upload checksums, **not independently signed custody receipts**.
- Forest #624 `d892670ded4b5fe82d55afbec833e56055821635`: six GitHub workflow conclusions successful, including bounded forest review; full cross-UID workflow not among those six.
- #626 `91bf547a163330e7ab030bd0a041828da6c2cf90`: five reported CI workflows successful and cross-UID workflow `44017683559` still in progress when inspected. A success of this parent, if later obtained, does not automatically qualify this new branch SHA.
- New candidate SHA is the commit containing **this ledger**. Do not annotate exact-head CI PASS until all required workflows complete on precisely that SHA. Existing workflow `pull_request.paths` filters may skip the full cross-UID suite when **only** documentation files change, even if #626 added forest paths; absence is NOT a passing check.

## R4 recovery and custody

- Existing custodian module includes `OperatorManagedWitnessReads` bound dual pinned mTLS adapters (#606). Existing recovery module includes fresh post-repair operator nonce/recheck (#602). Source exact-content comparison is confirmed; tests must still run on this candidate.
- All historical checkpoint responses remain history-only, **`authorizes_effect: false`**; they cannot independently authorize or revoke effects.
- **OPEN**: off-host administrator/root/account/key/storage separation, externally surviving full rollback, tamper-resistant and durable operator custody, independently witnessed outage/forgery/replay controls and effect-stop liveness.

## R5 bounded effect and adversarial evidence

- Candidate reuses existing fixed authority-owned marker workload, source pins, seccomp/FD audits and strict R5 syscall trace checker, plus #620 authority-owned alternative and #623/#624 six-duty evidence-gap/negative controls. Forest checker deliberately does not infer protection from Boolean fixture assertions.
- Required **exact-head receipts**: 903-or-current tests without failures, three qualified traced fixed children, exactly one authorized live AF_UNIX authority connection, one approved effect and two HOLD-denied attempts in each prescribed test, explicit negative controls for wrong peer/other socket, descriptor transfer, startup FD, crash/replay, source drift and effect-time withdrawal, plus separately archived trace/runtime artifacts and identity/digests.
- **OPEN**: independently enumerated *all* in-scope actual effect paths and bypass closure. Observational syscall traces and bounded marker tests do not imply OS-wide complete mediation.

## R6 original-six external theorem

- No modifications to `PhysicalBridges/ExternalJointEffectRefinement.lean`, `OriginalX3Full.lean`, G1 or G2. Existing theorem `independently_covered_events_satisfy_original_six` depends on `hCoverage : AllActualEffectsRefineJoint J realStep read` and `hMeaning : AuthenticSixReflections realStep read carrier owed actual`.
- **hCoverage OPEN:** independently specified real transitions, faithful total non-vacuous `read` mapping and every actual in-scope event's `jointStep` refinement have not been evidenced.
- **Six hMeaning fields OPEN individually:** historicalContinuity (actual identity/history), authorization (authentic current source authority), freedom (real alternatives/no coercion), restraint (justified proportionality), maximality (authentic feasible comparison), provenance (independently retained source-to-effect chain).
- The copied #588 crosswalk details source/evidence handoffs. No synthetic consent, omitted owed particular, self-attested Boolean or fixture-only observation discharges these universal premises.

## R7 stop / independent acceptance

**HOLD** pending: complete new head CI including cross-UID; downloaded inspected trace and runtime receipts with reproducible SHA; independent external custody and rollback evidence; R5 exhaustive bounded workload mediation; R6 authentic actual-effect/subject six-field witnesses; independent verifier acceptance. No merge/deployment.

One possible follow-on (only if review requires it) is a **narrow path-trigger update** to cause the full cross-UID suite to execute on updates to this acceptance ledger or Agent 4 evidence crosswalk. Do not weaken the existing tests; accept that a manually triggered read-only research replay or separately reviewed workflow filter may be needed.
