# IR-87 — Original A1 T2.3 durable-journal acknowledgement and hash limits

**Archive source:** recovered original A1-REGISTER T2.3: storage synchronization, hash/Merkle and durable journaling. IR-87 models the exact **safety condition that acknowledgements may follow durable commits, not merely queued writes**. It is not a real flash/distributed persistence certificate or a cryptographic Merkle proof.

## Source-level implementation and theorem

The state has volatile `pending` entries, `durable` entries, and `acknowledged` entries. The event sequence includes `queue`, `flush`, and `reboot`:

- `queue(entry)` adds only to pending; it changes neither durable nor acknowledged.
- `flush` of a pending entry models a durable commit *then* adds that entry to acknowledged.
- `reboot` loses pending entries but preserves the modeled durable log and acknowledged entries. That persistence is SOURCE TRANSITION SEMANTICS, not an empirically established physical guarantee.

The source proves by induction that `∀e∈acknowledged, e∈durable` remains true for arbitrary finite mixed runs from a valid initial state. It separately proves that every modeled durable log extends its predecessor by a newest-first prefix, and the original log remains an unchanged suffix even after arbitrary finite queue/flush/reboot cycles.

The source checks that queue alone cannot acknowledge or alter durable storage. A concrete example queues, flushes, reboots and still contains its acknowledged durable entry.

## Adversarial controls

- If a queue operation **acknowledges immediately**, a safe empty initial journal gains an acknowledged entry that has never been committed. This violates the invariant.
- A generic `digestCheck` can prove only that `digest(entries) = claimedRoot`. A constant digest yields identical roots for different journals, demonstrating that hash equality alone does not establish identity of stored history.
- Crash recovery and append-only semantics here are a finite in-memory SOURCE model. Torn writes, fsync semantics, NAND wear, disk controller cache, quorum partial failure, signature provenance, malicious rollback, and concurrent in-flight writes remain external obligations.

## Missing original X3 bridge

We still need to identify the original A1 storage interface, map its actual medium and effect journal semantics to this state machine, demonstrate ACK-after-durable-commit for all physical crash and retry scenarios, prove source log is complete for actual side effects, and bind journal entries to each same particular's history and freedom. Merkle-tree collision resistance and authenticated, append-only root provenance need distinct cryptographic assumptions/tests; a symbolic equality checker does not provide them.

This is **source-level T2.3 conditional formalism** that can be composed with T2.1/2.2 after a faithful physical link is specified. It is not X3 total physical installation or full history-continuation maximality.
