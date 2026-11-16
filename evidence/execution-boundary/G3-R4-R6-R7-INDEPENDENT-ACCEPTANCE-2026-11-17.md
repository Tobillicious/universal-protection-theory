# G3 R4/R6/R7 independent acceptance protocol — research-only

**Scope:** Review of the bounded, same-host, authority-owned `fixed.marker` fixture. **Draft only; no deployment, release certification, new HOLD authority, new theorem or modification of existing proof statements.** Source baseline: #596 head `135f7e8b61a5ebdb9437dd886d1dab242f1b5b1a`. All measurements and future claims must bind to the *current* candidate SHA, not assume ancestor CI transfers.

## Find before build — reused components

- R4: #559–#562 signed monotonic history, retained third anchor and one-step repair; #584–#585 operator-signed challenge and custody floor; #587–#589 pinned mTLS transport and bounded handshakes; #590–#591 coordinated rollback tests; #596 joint test assembly. **Recovery remains history-only; `authorizes_effect: false`.**
- R6: existing `PhysicalBridges/OriginalX3Full.lean`; merged #402, #405, #407, #516, #517; and draft #586/#588 evidence crosswalk. Apply, do not rewrite, the six original obligations.
- R7: #580 manifest and dossier, #581 runtime receipts, #582/#583 joined in #592, and #596 exact-head CI plus R5 tests.

## R4: independent custody acceptance, not merely distinct keys

**Required custody separation (human-reviewed evidence):**
1. Identify the application-host administrator and *different* operator custodian/controller, including separately controlled cloud account, root credentials, key store, storage and backups. Redact secrets; verify access boundaries independently. A second process, UID, key or simulated filesystem directory alone does not count.
2. Evidence that the operator retains a monotonic checkpoint *outside* the application rollback domain, independently provisioned and never accepting caller-supplied revision/digest for signature.
3. Verify signed all-of-two witness histories, challenge nonce, pinned operator key, signed checkpoint revision/digest/predecessor, and durable operator audit records with anchored generation/HOLD correspondence.
4. Perform a controlled application-host full data rollback **while external custodian records survive**. A fresh separately administered read must expose the later HOLD/history floor; recovery must fail closed on mismatch and never authorize a marker.
5. Test stale/replayed nonce, forged and rotated keys, forged client certificates, operator service outage, split-brain histories, simultaneous checkpoint advancement, and crash between attestation and local reconciliation. Record all negative outcomes.
6. Explicitly assess the **effect-stop** failure boundary: if the application authority is unreachable or hostile, remote retained history alone cannot commit HOLD into its SQLite effect transaction. Do not describe historical custody as off-host instantaneous effect revocation.

**Stop conditions:** shared administrative rollback authority; unavailable custodian with local-only fallback; operator response authorizes effects; any fail-open local rollback; missing custody audit; no independent reviewer of separation.

**Current evidence:** #591/#596 simulated surviving floor, challenge and rollback tests. **Open:** operationally independent off-host administration, externally supervised destructive rollback and effect-stop availability on compromised host.

## R6: instantiate existing X3/refinement interfaces, never infer from green CI

Exactly as identified by #588, the external theorem interfaces require:

- `AllActualEffectsRefineJoint`: an independently defined actual step relation `realStep`, a faithful and total state interpretation `read`, and evidence **for every in-scope actual transition** that it refines the existing protected joint step. A test-only marker is not universal real-event coverage.
- `AuthenticSixReflections`: subject- and event-specific independent evidence of **historicalContinuity, authorization, freedom, restraint, maximality, provenance**, over every genuinely owed particular. Do not define `owed` to omit inconvenient subjects or use an empty subject domain to discharge a meaningful real-subject claim.
- Use existing authentic rights/same-event research (#472/#473/#488, #507, and `g3_rights_composition/same_event.py`) only as *partial evidence*. Verified signatures, equality of event IDs or six asserted Boolean flags **do not prove genuine consent or all six reflections**.
- Require an independently observed before/after effect record, actor/subject identity and authorization provenance, revocation/HOLD generation and ordering, all possible actuator paths (R5), complete source→joint state mapping, and separately custodial audit history (R4).
- Record each premise separately as `verified for scoped event`, `unresolved`, or `contradicted`; do not manufacture witnesses or silently convert unknown to true.

**Stop conditions:** missing subject identity, invented authorization/consent, insufficient alternate-effect coverage, omitted subject, substituted theorem premise, or mistaking formal conditional proof for verified actual-world premise.

**Current evidence:** existing formal interfaces/proofs and evidence crosswalk #588. **Open:** authentic in-scope subjects, independent observation and fully instantiated real-effect premises.

## R7: independent acceptance replay on immutable exact head

1. Independent reviewer records the full 40-character SHA and downloads exactly that commit, with repository URL, runner image/kernel, CPU architecture, Python and cryptography versions, and exact binary/source digests.
2. Re-run the **same-head** entire CI matrix (six workflows), including cross-UID authority/HOLD, no-replay SIGKILL, R4 rollback+mTLS availability, R5 negative probes, source-fingerprint and runtime-identity tests. Record job IDs, timestamps and test counts; do not borrow earlier head successes.
3. Independently validate the actual runtime process executable, UID and copied source before trusting an inventory produced by the runner itself. This remains observational, not hardware-backed or independently signed live attestation.
4. Repeat controlled adverse tests: denial of alternative effects and descriptor tricks, socket/backlog saturation with authorized HOLD, rollback/history conflicts, operator loss, wrong signing key, wrong interpreter and mismatched checkout SHA.
5. Reproduce the independent custody demonstration using operator-admin controlled storage, not a local copy deliberately excluded from rollback by the tester.
6. For R6, reviewer examines *actual* subject/effect source evidence and maps every required theorem premise. If premise evidence is absent, sign off only on the bounded technical fixture, never the real-world original-six claim.
7. Produce a human-authored, signed review decision tied to immutable head SHA and evidence digests: `ACCEPT bounded research`, `REJECT`, or `HOLD unresolved`. Even an ACCEPT is **not** permission to merge, deploy, expand scope, or claim universal G3.

**Automatic HOLD review outcome** whenever any R4 custody evidence, R6 authentic effect/subject evidence, or R7 independent replay is absent; do not equate this review status with an executable HOLD command or introduce new HOLD authorities.

## R7 integration blocker: R5 green hostile control is evidence of a remaining bypass

- **Reviewed R5 source:** draft #600 at exact head `f5ff0a57005880f944aeeda80047207503915660`, stacked on #599 and #598. Its test `test_koru_r5_other_unix_destination.py` launches a UID-dropped child that installs the real FD-audit/Landlock/seccomp chain, then successfully connects to and exchanges bytes with an unrelated AF_UNIX abstract socket. Six workflows were green at this head; success is **confirmation of the bypass**, not a passing mediation gate.
- **Concrete R5 gap:** current kernel policy allows `connect()` to arbitrary AF_UNIX destinations, while the fixed executable legitimately requires one authority connection. The operator recovery checkpoint endpoint and its SSH-tunnel research path must not be interpreted as effect-path enforcement.
- **Acceptance decision now:** `R5=OPEN`, `R7 release=HOLD unresolved` for any claim that *all* executor effects are confined to the designated authority. R4/R6/R7 work must not silently adopt #600 as a restrictive policy fix.
- **Required Agent 2 handoff:** a separately reviewed restriction that pins or mediates the actual outbound destination (and preconnected/received FD alternatives), preserves the legitimate authority request and emergency HOLD, maintains protection under UID/FD tricks, and passes negative destination controls on the *same* exact candidate head. Classic seccomp BPF by itself cannot inspect arbitrary sockaddr path bytes at `connect()`. Design choice remains Agent 2's responsibility.
- **Integration replay:** #597 and #600 are independent draft descendants of #596. Their passing CI does not establish a single combined candidate. Primary integrator must reconcile both branches, verify dependency blob pins and rerun all required jobs on one exact combined SHA **before** any bounded research acceptance. Do not merge or deploy based on ancestor green badges.

## New upstream specialist evidence — review #602 and #601 before combining

These are *independently developed draft branches*; #597 does not contain their code and may not claim their tests or fixes.

### R4 Agent 3 #602 — post-repair checkpoint stability

- Exact reviewed draft head: `b2f0d29161dfa432d24de9c1caa2ba9fa3054116`, stacked on #591; source file `koru_operator_checkpoint_recovery.py`.
- Recovery formerly checked the operator checkpoint only before observer repair; operator history can advance after the initial signed read. #602 introduces a distinct **second nonce and fresh operator challenge after observer CAS**, followed by another anchor check.
- Three new tests in `test_koru_operator_post_recovery_recheck.py`: unchanged history with two different nonces; later operator advancement during observer repair; and second-read outage. The latter two must refuse history-success. Observer CAS may already have committed; no rollback or effect permit is implied.
- **Integration dependency:** if primary integration agent selects #602, incorporate its source and regression entrypoint into the combined candidate and update the R7 R4 required-module manifest. The original #597 R4 tests cover different pre-reconciliation interleavings and remain complementary. Never copy #602's test list into #597's current workflow without first stacking its actual source.
- **Residual limit:** two signed reads are not cross-host atomicity or independent administrative custody. A new operator update immediately after the second read remains possible. External HOLD/effect linearization stays exclusively with the existing authority.

### R5 Agent 2 #601 — same-UID peer impersonation

- Exact reviewed draft head: `7995b10860a224798c9d9eec91ebd2442f396858`, stacked on #600; new `test_koru_r5_same_uid_peer_impersonation.py`.
- The disposable Linux fake server uses the expected authority UID, but a different socket pathname and **no authentic authority journal or protected marker**. It emits the syntactically positive `{"ok":true,"code":"synthetic_effect_returned"}` response. The unchanged fixed executor's ability to accept it is a negative control for authority-instance provenance, not an authentic effect.
- **Acceptance blocker:** `SO_PEERCRED` UID validation plus a positive response cannot alone prove that the intended authority instance performed any protected action. Treat `synthetic_effect_returned` as an **untrusted client observation** unless bound to the reviewed authority endpoint identity, durable journal event and independently observed effect. Never feed the fake success into `AllActualEffectsRefineJoint` or `AuthenticSixReflections` as a real protected event.
- Primary integrator should require separately reviewed **actual destination / authority-instance binding** and negative impersonation tests alongside real marker success, HOLD-first denial, restart and rollback. Do not implement a parallel HOLD signer or weaken peer-identity checks.

### Exact-head specialist validation at this review

- #602 (`b2f0d29161dfa432d24de9c1caa2ba9fa3054116`): **6/6 GitHub workflow conclusions succeeded**, including Linux integration. Recheck on combined head; does not establish external operator custody.
- #603 (`e6572641c8e06717df9cbd7472c5fc418e760548`): **6/6 GitHub workflow conclusions succeeded**, including authenticated dual-witness observation. Recheck on combined head.
- #601 (`7995b10860a224798c9d9eec91ebd2442f396858`): **6/6 GitHub workflow conclusions succeeded**. Its hostile fake-peer test is evidence that the fixed client accepts a same-UID impostor reply; passing means the negative control reproduced, **not** that R5 was secured.
- #604 (`b8ecd27dbdad05090aaaea17ec39d6d3f2b769c0`): five workflows succeeded; Linux integration still running when reviewed. **Not all-green yet**.
- #597 own exact-head CI must be independently checked after its R7 manifest regex repair; past `314699d...` Linux failure was in the manifest checker and is not evidence of a HOLD/protection bypass. Distinguish test-gate bugs from security failures while never bypassing failing checks.

### R7 combined-head rule

#601 is stacked above #600 → #599 → #598 → #596; #602 is separately stacked above #591; and our #597 is stacked above #596. Green workflows on any of those **different SHAs** are not evidence of their combined behavior. Reconcile in a single isolated primary-integration draft, re-check all source pins and workflow registrations, rerun six CI workflows plus specific hostile controls on its exact head, and obtain independent reviewer approval. No merge or deploy before gates are discharged.

## Current combined R5 peer-PID research change — trusted bootstrap still required

The single #597 draft now contains a **changed frozen launcher** requiring both the expected UID and an exact expected process PID for the Unix peer, checked through `SO_PEERCRED` **before** the fixed-marker request is sent. Missing/nonpositive trusted PID and mismatched peer process fail closed. The exact launcher blob pin is updated and tests cover genuine fixture authority PID success, wrong PID denial, missing PID and same-UID fake-peer denial. The older #601 positive-looking fake response is the **pre-fix negative baseline**, not the expected outcome of these current candidate tests.

**Security assumption not discharged:** the PID is a *privileged, independently observed launcher input*. The method does not authenticate that input, prevent PID reuse/restart races, isolate a compromised local root or legitimate same-UID administrator, prevent creating connections to unauthorized Unix sockets, or establish an authentic effect receipt. Therefore `R5=OPEN`. The planned stable authority-instance bootstrap and destination confinement must be reviewed separately. These edits are not a production-ready fix and cannot replace the authority's existing HOLD-first transaction or original-six evidence.

**Required exact-head acceptance:** on the same combined #597 SHA, run fixed-launcher marker success, first-HOLD denial, restart/second attempt refusal, same-UID forged peer denial, previously demonstrated other-AF_UNIX-destination negative control and source freeze/pin checks. Do not infer their outcome from an ancestor's green workflows.

## Report template — one reviewer, one exact SHA

- Reviewer and independently administered role (verified, not asserted):
- Repo and exact 40-char HEAD:
- Parent PR chain, reviewed code/changed file digests:
- R4 operator/admin custody separation evidence:
- R4 rollback, outage, forged reply and race outcomes:
- R6 chosen actual-effect scope, independently identified owed particulars:
- R6 six individual premise-evidence links and unresolved/contradicted entries:
- R5 dependency: exact finished kernel mediation inventory SHA and negative tests (owned by Agent 2):
- R7 environment, all CI job links/test counts, external replay differences:
- Assumptions and excluded adversaries:
- Independent reviewer decision and rationale:
- **Do not merge/deploy until primary integrator explicitly reviews all unresolved gates.**

## Important nonclaims

No external administrator, subject or consent is created by this document. No tests were executed solely by adding the document. The prior six green workflows on #596 validate the earlier head, not this new document commit. This is an *acceptance protocol*, not independent evidence satisfying R4, R6 or R7, and not a claim of unconditional physical protection.
