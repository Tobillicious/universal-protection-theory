# G-Mesh recovery checkpoint — 18 November 2026

**Research draft; no deploy, merge, network server, quorum, or effect permission.**

The existing `g_mesh_protocol.py` and `g_mesh_effect_bridge.py` are the canonical signed local lease and bounded effect path from the earlier PRs. Do not replace them with an unimplemented `gmeshctl` command, scripted echo, or a manifest of claimed physical nodes.

## Problem

Zelda's terminal log showed `gmeshctl: command not found`, but a scaling shell script printed success anyway. The repository's v4.7 JSON expresses a proposed 256-node topology, not measured membership or 256 active runtimes. A node receipt is also not a quorum or actual whole-machine protection.

## First repair: offline inventory evidence

`g_mesh_inventory_audit.py` accepts an independently pinned public-key roster and a set of **separately collected** node-signed observations. Each observation binds node ID, deployment, policy, nonce, time, exact source SHA, engine digest and a declared ready status. Unknown, duplicate, missing, stale, forged or mismatched receipts deny success. No keys or invented roster are bundled. A local signer can claim ready dishonestly: the returned fields explicitly deny live-node, custody and effect certification.

Example (provide your own actual files and a trusted timestamp):

```sh
cd evidence/execution-boundary
python3 -m unittest test_g_mesh_inventory_audit.py -v
python3 g_mesh_inventory_audit.py --roster /secure/roster.json --observations /secure/observations.json --at 1795000000
```

The tool is **read-only** and never provisions, starts, changes or authorizes a guardian. No automatic transition from these receipts to `GMeshProtocolHandler.install_authority_lease` is allowed. A signed observation does not substitute for an independently authenticated live challenge response.

## Further G3 work, without weakening the original proofs

1. Restore peer-credential verification; never use the native-macOS `uid = expected_uid` bypass. Keep Zelda's existing Linux guardian state and HOLD intact.
2. Bind fresh independently observed challenge receipts to a separately reviewed node enrolment policy and pinned roster/epoch. Confirm administrative key custody.
3. Specify quorum fault model and membership-change proof before any quorum-derived lease; validate partitions, clock faults, double signing, delayed holds and source identity.
4. Reuse the local authority's lease/permit/HOLD effect-time fences, and independently audit all declared effect paths. Gossip is transport, not enactment authority.
5. Replay R4 custody, R5 mediation, R6 authentic six-particular duties and R7 external acceptance at one immutable exact head.

The current v4.7 topology numbers are **declared**, not empirically verified. No zero-latency or quantum-entanglement claim is warranted by this module.
