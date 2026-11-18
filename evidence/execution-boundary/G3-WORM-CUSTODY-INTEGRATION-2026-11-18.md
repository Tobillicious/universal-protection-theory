# G3 WORM custody — find-before-build research integration

## Reused existing capabilities
- `g3_real_effect_inventory_handoff.inspect`: source- and scope-bound R5 effect-path inventory joined to the same R6 event packet.
- `koru_operator_checkpoint_recovery.verify_operator_response`: existing challenge-bound Ed25519 R4 retained operator checkpoint. No new signing or HOLD authority.
- Existing cross-UID/HOLD/rollback adversarial tests remain unchanged.

## Implemented
- Canonical bundle contains exact source commit, event bytes hash, inventory bytes hash, preexisting joint evidence hash, explicit scope, operator signed checkpoint, and unresolved evidence list.
- Offline read-only verifier reconstructs the exact bundle from independently supplied evidence bytes, public key, challenge nonce, expected floor and commit.
- Local `O_EXCL` and `fsync` handoff detects duplicate filenames; a hostile test deliberately proves local admin tampering is possible and detectable if pristine bundle bytes/hashes are independently retained.
- Scoped synthetic negative tests: swapped inventory, swapped packet, old checkpoint, replayed challenge, forged operator signature, duplicate fields, falsely asserted universal protection, and unsafe/symlinked destination.

## Scope, safety and evidence boundary
This is **not** independently operated physical WORM. A local host administrator can delete or replace its files; this module neither enforces retention nor verifies organizational independence. Genuine WORM requires an independently administered storage/control plane, fixed retention and immutable audit policy, and externally obtained/checkable digest and reading evidence. A signed operator history is not an effect permission or world-wide protection theorem.

`hCoverage_proved`, `hMeaning_proved`, `independent_custody_verified`, and `universal_G3_proved` remain false, regardless of test successes. The implementation never changes Zelda, permits an effect, clears HOLD, publishes a release, or changes the original six duties or Koru.

## Review acceptance
Require exact-head Python CI success plus independent verification of source and custody architecture. Then provision an independently administered WORM sink outside the application rollback domain; test retention and post-rollback read with independent reviewers. Keep R5 complete actual-effect mediation and R6 authentic original-six reflections as separate proof obligations. Do not merge or deploy without review.
