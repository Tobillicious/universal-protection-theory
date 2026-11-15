# G3-PROD-01 — bounded local writer / generation-fenced recovery prototype

**Status: research-only integration candidate. NOT production ready.**

This Linux Unix-socket reference-monitor experiment uses a local SQLite authority/effect-intent journal and a fixed private output directory. An optional `SignedG3Writer` composition uses PR #456's G3 and G-Mesh verifier instances, plus a trusted event-id-to-output-digest manifest. It is an **additive research candidate**, not a replacement for PR #456 or a general-purpose deployable system.

## Run tests

```sh
cd evidence/execution-boundary/g3_prod_01
python3 -m unittest -v test_g3_monitor.py test_g3_signed_bridge.py
```

Requires Linux, Python 3.9+, and private writable test directories. The original isolated harness passed eight local unit tests on 15 November 2026. The branch has eleven monitor tests, an expanded signed-bridge suite (including actual subprocess revocation), and a Linux separate-UID fixture. Verify exact-head GitHub CI for the complete results.

## Demonstrated in the limited test harness

- Startup increments authority epoch and disarms effects.
- Stale epochs and held state deny writes; local epoch and effect intentions use the same SQLite database (WAL, synchronous FULL).
- Only bounded content may be written, to hash-derived names in an independently configured private output directory. The request does not select arbitrary paths.
- Socket requests are one-per-connection, byte-bounded, checked against Linux SO_PEERCRED UIDs, and concurrency-limited.
- Unresolved previously journaled intentions block unrelated writes; existing output contents and type are verified.
- Output bytes are fully written and fsynced to a private staging inode before a no-overwrite hard-link publication. Orphan staging files are detected as integrity failures requiring trusted review.

## Release blockers: do not deploy

1. **Unsafe bare writer remains exposed as a research fixture**: `Store.write` does NOT enforce cryptographic authorization. Only `SignedG3Writer.write` reuses PR #456's G3 signed permit and current signed mesh handshake, and checks a trusted output manifest. Provisioning the bare `Store` as an application-facing server would be unsafe. These synthetic checks do not establish the original six real-world X3 duties, human consent, or external policy correctness.
2. **Disarmed demonstration startup**: Store.arm is trusted in-process/test only. The CLI remains disarmed; never expose arm/revoke on the untrusted application socket.
3. **No measured multi-UID isolation**: The tests emulate UID rejection but do not provision distinct system accounts, mount namespaces, MAC/seccomp, inherited-FD hygiene, or non-bypass guarantees. Host root or kernel can bypass.
4. **Crash consistency gaps**: clean close/reopen is tested; SIGKILL, power loss, fsync boundaries, filesystem faults and atomic publication are not yet tested. Staging and publication crash points still require fault injection; orphan staging files fail closed.
5. **Physical-domain gap**: No hazard analysis, real consent, actual-world six-X3 grounding, hardware interlocks, actuators, distributed consensus, or universally protective result.
6. **Rollback and resource gaps**: Local SQLite is not anchored against privileged rollback; the socket directory must be securely provisioned. Additional process/resource exhaustion and race testing is required.
7. **Broker/protocol and transaction constraints**: The signed bridge accepts PR #456's signed envelope only when instantiated by a trusted owner; it uses three separate SQLite stores and process-local locks, not distributed atomicity. Signed envelope revalidation cannot eliminate remote revocation races. No fully provisioned multi-UID runtime or live consent verification exists. Do not attach an untrusted agent or external service as if the system were production G3.

## Next exact engineering integration

1. Retain [PR #456](https://github.com/Tobillicious/universal-protection-theory/pull/456) as the authoritative current G3/G-Mesh cryptographic admission and model evidence path.
2. Define one bounded target application and enumerate all effects, identities, OS permissions and policy rights; deny direct protected output writes using **actual OS isolation**, not merely application wrappers.
3. Specify and implement a **trusted commit-time authorization interface**: exact signed event and permit; fresh G-Mesh lease, generation and revocation; appropriate original six-X3 evidence; and an actual rights/consent source. Do not substitute an integer epoch for these checks.
4. Reconcile separate G3 and G-Mesh SQLite stores, or specify a verified authority decision with an enforceable commit fence, avoiding time-of-check/time-of-use escapes.
5. Make output publication atomic when possible, with durable staging, fsync, rename and exact fault injection at each step. Guarantee fail-closed behavior on integrity uncertainty, and verify recovery by observation.
6. Exercise separate UIDs, namespaces, fd inheritance, symlink/hard-link, lock contention, hostile slow clients, exhausted resources, restart and revocation races. Independently review the resulting evidence.

This addition is intentionally separate from Lean and the historical UPT proofs. No theorem, publication, DOI, or original proof chain is changed or weakened.

## Signed bridge research path

`g3_signed_bridge.py` defines `SignedG3Writer(Store)`, which requires a trusted provisioned PR #456 `SyntheticEffectGate`, a lease-enabled `GMeshProtocolHandler`, an integer trusted clock, and an immutable-by-copy digest manifest mapping admitted event identifiers to exact HTML bytes. The bridge demands the event ID, event digest, mesh authority, signed G-Mesh handshake and G3 permit to agree, then holds **these exact three in-process handler locks** while it journals and writes. The mesh handshake is consumed before the G3 and filesystem operation, so failures must be handled as terminal denial/retry with a fresh sequence. This demonstrates composition, **not a single transaction** or cross-process revocation safety. `Store.arm()` remains trusted-test-only; the demonstration CLI remains disarmed.

## Cross-process local epoch fencing (research)

`g3_cross_process_fence.py` adds a **cooperating-process-only**, private Linux `flock` barrier around the signed writer's startup, arm, hold, and write. A separate trusted control process can call `revoke_writer(db_path, fence_path)`, acquiring the **same** lock and transactionally increasing the local writer epoch while halting future effects. A new subprocess regression checks that revocation blocks on a writer-held fence and that a completed revocation causes subsequent signed requests to fail *before* consuming a signed mesh sequence or writing a synthetic G3 effect.

This is a useful local ordering property, not universal or distributed revocation: all legitimate writers/controllers MUST use the same protected lock inode and the same database. An uncontrolled process, root, an inherited directory FD, a replaced trust root, a separate G-Mesh process, or a remote lease revocation can still violate the broader protection objective. The original G3 and mesh stores are still separate; **no cross-store atomicity, fail-safe physical effect claim, or six-X3 real-world certification is established**.

The source contains a test-only ability to arm the research writer and an unprotected bare `Store` fixture; the production rollout must remove or strongly isolate these before any exposure.

## Integrated cross-agent test wave (PRs #464–#466)

The `g3_monitor.py` bounded socket handler now uses an absolute monotonic read deadline, exactly one newline-delimited request frame, and strict operation allowlisting. `test_g3_monitor.py` includes hostile slow-trickle and multi-frame cases, staged-publication error injection, directory-fsync failure, and subprocess `os._exit` crash windows before/after publication. The signed writer and separate-UID tests from this PR are retained. CI must pass at the **new combined head**, not merely the original stacked PR heads. Python simulated failures and `os._exit` are not physical power-loss validation.

## Research commit-time lease and permit recheck

The signed writer now passes a `pre_publish` check into the bounded Store. It checks the trusted local clock against the signed handshake deadline, controller lease deadline, and Ed25519 event permit expiry after staging-file `fsync` and immediately before local link publication. It also rechecks the in-process G3 and G-Mesh halt/generation/authority state, and refuses to report completion for recovered existing output when the check fails. On denial, the prior signed synthetic dispatch and durable `INTENT` may remain; staging is discarded without publishing a new HTML file. Negative tests advance the clock between authorization and publication and verify denial.

**Limitations:** this is a last *local* check, not an atomic time/remote-revocation guarantee. A deadline could expire between the check and the filesystem syscall, especially under scheduler stalls; independent G-Mesh processes, process crashes, clock tampering, power loss, kernel/root bypass and remote authority synchronization remain outside this proof. A lease renewed after denied/uncertain staging does not itself authorize recovery: a new signed event-bound handshake and verified current G3 rights are required. Do not certify this research fixture for live protection.

## Published inode DAC hardening (research defense-in-depth)

Before linking an HTML output to its public filename, the writer changes its private staging inode to owner-read-only `0400`, flushes it with `fsync`, and closes the writable staging FD. The owner-read-only mode is present on the final inode from its first visible instant. New tests assert the mode, a single linked inode, no writer-process writable descriptor to the output after publication, and normal non-root `O_WRONLY` reopening denial. **This is not a solution to the SCM_RIGHTS and hard-link counterexamples in PR #475**: a previously-open writable FD stays writable after chmod, the owner can change permissions again, and root or an improperly isolated actor can bypass discretionary permissions. Therefore host FD/capability controls and an independent complete-mediation audit remain hard release requirements. No live application deployment or physical X3 certificate is implied.
