# R4 two-computer custody handoff — prepare today, execute only with separate operator control

**Research-only.** Zelda-Fitzgerald is the application/workload host. A second computer may become an operator *test* host when available. Mere physical separation does not establish independent administration, tamper-resistant custody, effect-stop liveness, or G3 certification.

## Reuse and baseline
- #584–#585 operator challenge signer and independently retained floor; #587–#589 existing pinned mTLS **loopback-only** research endpoint.
- #590/#591 local rollback-surviving operator contrast; #597 all-store rollback negative control.
- #564 one authoritative effect-time HOLD transaction. External records are **history witnesses only**, with `authorizes_effect: false`.
- #588 / merged #517 authentic real-effect interfaces and R6 gaps; do not invent subject identity, rights, consent or theorem witnesses.

## Today — no additional computer required
1. Freeze candidate 40-character SHA, exact PR dependency chain, approved source/blob digests, and externally reviewed test names.
2. Run the existing single-host tests in disposable GitHub Linux CI. Compare **surviving operator** and **all stores rolled back** contrast results; confirm the latter shows a fresh valid signature over rolled-back history if the operator is under the same rollback domain.
3. Prepare an operator custody inventory (no private keys in repo): legal/operational controller, distinct administrator/root/cloud account, physically/logically separate storage and backups, key custody, recovery access, network admission, audit-log custody, and who can change either machine.
4. Treat unknown administrator independence as **OPEN**; do not label a same-person laptop demonstration independently governed.

## Two-computer rehearsal — when available
1. Keep operator signing key and retained history *on the operator computer only*. Provision independently reviewed public-key pins and certificates to client; NEVER copy the signing secret, seed, unencrypted key backup or operator database onto Zelda-Fitzgerald or into a GitHub artifact.
2. Explicitly address the existing transport limit: `LoopbackOperatorCheckpointService` binds to `127.0.0.1` and the client also requires a loopback address. **It does not directly support a second computer.** Do not silently widen bind addresses, disable TLS peer pinning, or claim off-host tests with unmodified loopback code. Any transport adaptation needs a separately reviewed draft PR, host-level firewall, mutual TLS identity, certificate rotation, timeouts, replay protection, and independent reproducibility. An authenticated, narrowly confined transport can be proposed only after review.
3. Operator computer retains the signed history floor and produces fresh challenge-bound replies from its own store, never from client-supplied revision/digest. Record cryptographic receipt digest and timestamp without exposing secrets.
4. Record a HOLD/history advancement using the existing protocol. Independently observe that the operator's floor advances and persists across its own process restart.
5. In a disposable application test environment only, intentionally restore local witness, anchor, and observer stores to pre-HOLD snapshots; confirm a fresh operator read still reports the later revision and denies stale reconciliation. **Never roll back production rights/HOLD history.**
6. Attempt stale/replayed nonce, forged operator identity, expired/changed certificate, operator outage and inconsistent witnesses. All uncertain outcomes must deny recovery; any operator response remains history-only.
7. Simulate an application administrator compromise while the operator computer remains out of the attacker's permissions. Document actual admin/credential separation and test **operator** history survival; separate physical computers under one administrator do not demonstrate independence from that administrator.
8. Have an external reviewer inspect head SHA, process/UID identity, network framing, signed receipts and actual administrator/account boundaries. R7 conclusion remains HOLD if any required evidence is absent.

## Evidence and stop conditions
Required receipts: immutable commit SHA; source and binary digests; operator public-key fingerprint (NOT private key); witness receipt digests; checkpoint revision/digest/predecessor; specific host/admin identity attestation; independent before/after snapshots; denied attempts; reproducible test/run IDs; separate operator custodian acknowledgement.

Stop immediately if keys are shared, transport is unreviewed, the operator signs caller-proposed state, histories diverge, any backup/recovery can lower retained operator history without independent detection, external HOLD is mistaken for a signed checkpoint read, or anyone promotes an unknown authentic subject/rights assumption to verified.

**Current status:** No off-host test has been performed. This is a procedural preparation document and is not authorization to merge, deploy, conduct a live attack, or certify G3.
