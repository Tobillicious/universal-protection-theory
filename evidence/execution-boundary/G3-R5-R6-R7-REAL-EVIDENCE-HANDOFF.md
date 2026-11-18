# G3 R5/R6/R7 offline evidence handoff

**Scope:** research verification of independently collected files for a *bounded* environment. Passing CI or a valid signature is not physical completeness, authentic consent, independent custody, or universal protection.

## Evidence files

- `events.json`: existing `g3-r6-zelda-observed-events-v1` packet, with full source commit, bounded scope, same-event effect IDs, owed subjects and all six original X3 duty references.
- `inventory.json`: independently collected `g3-r5-physical-inventory-v1` effect-route and bypass inventory. Include exactly the same scope and source commit, event IDs and effect paths. This module tracks: direct file writes, inherited write FDs, pathname and abstract Unix sockets, network sockets, process creation, alternate writers, and privileged host admin. A claim that a class was examined is not proof.
- Optional detached `review.json`, Ed25519 signature, and *public* reviewer key from an independent review. Obtain the expected raw-key SHA256 from a separate trusted channel. **Never publish private keys.**

## Read-only invocation

```bash
python3 -B evidence/execution-boundary/g3_real_effect_inventory_handoff.py \
  --event-packet /path/to/events.json \
  --effect-inventory /path/to/inventory.json \
  --expected-commit FULL_40_HEX_SOURCE_COMMIT
```

For independent R7 signature verification, add:

```bash
  --review /path/to/review.json \
  --signature-hex-file /path/to/review.sig.hex \
  --reviewer-pubkey-hex-file /path/to/reviewer.pub.hex \
  --pinned-reviewer-pubkey-sha256 INDEPENDENT_64_HEX_SHA256
```

Run on reviewer-owned copies, not on Zelda. The command does not start or control Docker, change HOLD, generate keys, authorize effects, merge or deploy.

The resulting JSON reports SHA256 digests of both exact files, the length-framed joint digest, unresolved R5/R6 gaps and optional signature validity. **Exit status 0 means structurally processed only**, never physical acceptance. The verifier always leaves the universal and effect-authorization flags false.

## External gates unchanged

Real independently administered custody and quorum signers (R4), demonstrated exhaustive scoped writer/bypass coverage (R5), actual owed-subject original-six reflections (R6), independent R7 review, and universal actual-world correspondence remain independently unverified.

**Never clear Zelda's recorded generation-2 HOLD on the basis of this report.**
