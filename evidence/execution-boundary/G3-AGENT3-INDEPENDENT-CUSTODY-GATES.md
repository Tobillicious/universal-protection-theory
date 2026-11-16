# G3 Agent 3: independently administered HOLD and historical recovery

**Candidate:** research-only, stacked on #562. No production administration, off-host deployment, privileged rollback resistance, or unconditional effect protection is asserted.

## Reuse: do not create a competing authority
- #559–#560: two distinct pinned mTLS services, Ed25519 history receipts, all-of-two agreement.
- #561–#562: retained third anchor and explicit one-step recovery of an anchor-first partial observer commit.
- #564: one authoritative HOLD/effect SQLite ordering domain; externally published witness records are **history replicas**, not independent effect grants or competing HOLD truth.

## New gate
`koru_operator_checkpoint_recovery.py` requires a **third independently pinned Ed25519 operator key** and an operator-signed response to a new 256-bit challenge. That response covers the exact retained anchor revision, digest, and predecessor before invoking the existing two-witness, one-step reconciliation. A stale packet, guessed/replayed nonce, wrong key, inconsistent checkpoint, uncertain witness response, or noncontiguous floor is refused. It returns `authorizes_effect: false`.

The third operator service **must retain its own checkpoint independently**, and sign only the state in independently retained custody after authenticating the request. It MUST NOT sign a caller-proposed checkpoint merely because the caller supplied it. The caller pins the operator public key from separate, authenticated provisioning, not from a remote response. The tests simulate this interface locally; they cannot establish real operational independence.

## Deployment gates not met
1. Provision third-party operator, separate cloud/account/root authority, isolated signing key custody, authenticated enrollment/rotation, durable independent append-only or monotonic history, audit trail and disaster-recovery custody.
2. Expose operator read through an authenticated remote transport with strict schema, deadline, replay controls, challenge-response and operator-held authoritative floor. Validate both actual operator custody and the source/build identity of the reader.
3. Test split-brain, coordinated local rollback, root compromise of the application host, operator outage and stale replay; if operator unavailable, deny reconciliation (do not downgrade to local-only).
4. Preserve #564 single ordering authority: externally administered emergency HOLD submissions must enter that authority's locked effect domain and be durably committed **before** acknowledgement. If the authority host is compromised/unreachable, this construction does not guarantee effect-stop liveness; move enforcement/effect ownership or employ a separately fenced epoch/lease design.
5. Test concurrent checkpoint change during one-step repair and a process crash between operator attestation and observer commit. Recovery results must never be reused as effect permission.
6. Independently reproduce the exact-head Linux CI and obtain external administrator attestations before any promotion.

**Known limitation:** A signed challenge response proves possession of a key and asserted checkpoint value, *not* independent administration, freshness against a malicious signing service, or resistance to rollback of the operator's own store. A shared administrator can compromise all of them. Do not merge or deploy this branch as a G3 certificate.


## Simulated operator-owned custody service (#585)

`koru_operator_checkpoint_custodian.py` prevents caller-proposed checkpoint signing: the signer reads only its own monotonic `ClientRevisionFloor`, advanced by matching two verified Ed25519 witness receipts under the existing contiguous-CAS logic. The observer cannot cause the operator to sign its desired revision merely by sending a requested digest. The new tests cover stale operator state, agreed HOLD advancement and one-step repair, witnessed rollback, divergent receipts, missing custody storage, and wrong operator signing key.

**Still a simulation:** This class can run under the same user/admin as the requester. Its SQLite floor can be rolled back by the operator's own administrator, and compromise of the key or two signing witnesses defeats historical authenticity. The remote service transport, independent trust root, operator enrollment and audit, and cross-host effect-time HOLD fence remain to be implemented. A custody observation is never permission to perform an effect.


## Pinned TLS operator read boundary

`koru_operator_checkpoint_mtls.py` adds a loopback-only TLS server requiring a pinned client certificate and a challenge-only request `{"op":"checkpoint","nonce":"<64 hex chars>"}`. The handler does not expose `observe_pair`, checkpoint provisioning, history rewrites, HOLD updates, or effect execution. The client pins the server's DER certificate hash and verifies the Ed25519 reply with the independently configured operator key.

This deliberately provides a **transport fixture**, not an independently operated public endpoint. Production adaptation requires host and administration isolation, credential lifecycle/rotation, TLS peer governance, explicit custody audit records, durable monotonic rollback countermeasures, bounded handler resources/reads, and external proof that the administrator does not also control the application. The history-only reply does not authorize an effect or guarantee emergency HOLD delivery.


## Coordinated rollback regression (Agent 3 A04)

`test_koru_operator_surviving_rollback.py` creates a positive control: both signed witness journals, the observer floor and the retained local anchor advance to a HOLD revision, with the operator floor observing the same revision. The test restores **all four application-owned files** to their pre-HOLD versions while deliberately preserving the operator's separate floor. A fresh network challenge to the operator still reports the advanced revision; reconciliation against the rewound local anchor is denied, and the operator's history is not lowered. Additional tests exercise old signed receipts and missing operator custody storage.

**Threat-model precision:** This is a coordinated *logical application rollback* simulation on one disposable CI host. The operator floor survives by explicit test construction. It is not evidence of independent administrators, external storage, availability under host compromise, nor a universal emergency HOLD enforcement guarantee. An attacker who can roll back the operator custody file or signing service remains outside the achieved guarantee. The historical checkpoint is deliberately not an effect permit.

**Dependencies:** Builds on draft #587, itself stacked on #585 → #584 and #562 (signed witnesses and partial recovery). Emergency HOLD/effect linearization remains owned exclusively by the existing authority (#564 and later), not by the operator checkpoint read endpoint.
