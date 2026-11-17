# G3 second physical node — non-deploying site acceptance plan

Status: **DESIGN / HOLD — NO DEPLOYMENT OR NETWORK AUTHORITY**  
Scope: potential second **research observer / recovery custodian** at a family home, not a second autonomous agent, writer, replicated authority, or swarm.

## Source baseline

- `g_mesh_protocol.py` has offline, local-only signed handshake/lease and durable emergency-HOLD research fixtures. It explicitly does **not** implement encrypted transport, hardware attestation, network effects, consent certification or universal physical correspondence.
- `test_g_mesh_two_node.py` exercises two **offline** durable SQLite nodes, intentionally dropped/reordered messages, lease expiry, replay, target/issuer mismatch and hold propagation limitations. This is **not** a LAN or WAN node.
- The integrated G3 R4–R6 replay tests the signed lease's short expiry, and rejects generated 24-hour "all-green" leases. A local-green test is not an external node acceptance certificate.
- This plan is an additional required boundary, **not an instruction to run or deploy hardware**.

## Site decision — guardian first, not distributed authority

1. Obtain explicit, informed agreement from the home's owner/resident before placing equipment, using internet, consuming electricity or holding information. No covert monitoring or recording.
2. Name a human operator for each machine and an independent person permitted to withdraw site access. The second machine must not gain unattended control over the first or any household devices.
3. Designate the second machine **read-only** at first: authenticated receipt verification and an independently retained *minimal* recovery witness only. No protected-effect writer, minting authority, agent spawning, outbound automation, household smart-device access, or Docker socket.
4. Start with the second machine **powered off and disconnected** until the entire scope and access policy have been approved. An offline storage or removable-media custody workflow is a valid first experiment.
5. Keep privacy-sensitive contents off the second machine by default. If recovery requires data, define consent, minimization, encryption, recovery access and retention/deletion terms before copying anything.

## R4–R7 acceptance gates for an eventual isolated exercise

| Gate | Required independently observable evidence | Fail / unknown |
| --- | --- | --- |
| Identity & inventory | Machine serial/asset label (kept private), OS/kernel version, exact boot image/source digest, physical access owner, trust assumptions | No network joining or effect authority |
| Network & principal separation | Interface/service inventory; inbound default-deny; no public listener; no automatic port forwarding or UPnP; bounded egress and mutually authenticated endpoint if a future protocol is reviewed; separate OS credentials; no shared root access | Stay disconnected |
| Issuer/lease custody | Public-key trust roots independently pinned, issuer private keys never on observer, bounded expiry, generation, revocation and sequence-floor checks; no self-signed renewal | HOLD / refuse requests |
| Emergency HOLD | Operator-controlled independent stop, including unplug/power-down; restart requires reauthorization; a partition cannot silently broaden rights | Hold remains asserted |
| R4 external recovery | Two independent admin credentials and physical custody; restore and corrupted/replayed checkpoint negatives, provenance, privacy and tested rollback | Treat backup as unproven |
| R5 mediation | Enumerate *all* actual file, network, IPC, device and credential effects for the scoped test; independent kernel negative controls for each; no cross-site control surfaces | Do not authorize effects |
| R6 original six | For each real event and owed subject, independently evidenced historical continuity, authorization, freedom, restraint, maximality, provenance; privacy and meaningful consent are not inferred from a hash | No universal certification |
| R7 acceptance | Independent human reviewer signs precise SHA, host/scope, tests and exceptions; expiry/review cadence documented | Remain research only |

## Safe, non-deploying sequence

**Stage A — inventory:** site operator records hardware/OS and consent *privately*. No software installation, ports, lease issuance or credentials.

**Stage B — physical/offline recovery:** on a disconnected spare machine or removable medium, verify integrity of *synthetic* encrypted test data. Test loss/corruption and prove no private source content is unnecessarily exposed.

**Stage C — isolated two-machine rehearsal:** only after a separately reviewed threat model, use an isolated test network with ephemeral keys, zero household device access, no production data and no privileged operations. Verify expired/forged/replayed leases, dropped HOLD messages, disconnects, crash/restart and read-only custody; ensure disconnection causes denial.

**Stage D — independently authorized pilot:** requires a new, exact-head CI and operator-reviewed implementation with encrypted authenticated transport, independent reviewers, actual R4 custody and bounded effect-path evidence. This plan alone **never** authorizes Stage D.

## Required operator report before any activation

Record only: `site_consent_confirmed`, `owner_and_operator_separate`, `role=read_only_observer`, `network_disconnected`, `keys_provisioned=false`, `services_started=false`, `production_data_copied=false`, `rollback_witness_status`, `unknowns`. Never substitute model-generated mock telemetry for actual observation. Do not publish identities, physical addresses, keys, logs or private home-network details.

**No automatic deployment, PR merge, key rotation, daemon creation, live G-Mesh clustering, or recreation of the deleted swarm.** The ontology that all particulars belong to one whole does not grant authority over distinct people, homes or devices.
