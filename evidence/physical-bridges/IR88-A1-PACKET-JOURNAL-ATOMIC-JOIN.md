# IR-88 — Cross-source A1 packet acceptance ↔ durable journal receipt join

**Why this matters more than another independent checklist:** Original A1 T2.1 authenticated sequence, T2.2 causal message admission and T2.3 ACK-after-durable-journal can each be locally source-level verified yet fail to preserve any accepted packet if the *join* between acceptance and persistence is merely a volatile queue.

IR-88 constructs that missing join, with a concrete adversarial crash countermodel, and does not quietly assume physical crash consistency.

## Failure discovered

The source-level `unsafeQueuedIngress` accepts an authenticated/epoch-correct/sequence-correct/causally admitted packet into IR-85/86's session and simultaneously adds its payload ONLY to IR-87's pending queue. The modeled reboot discards pending writes.

A Lean theorem proves an accepted packet can remain in session while its payload is ABSENT from the durable journal after reboot. Thus **local IR-85 packet validity + local IR-87 acknowledgement discipline do not imply received history is retained**.

This is a real cross-module gap with relevance to historical continuation and actual trace provenance.

## Repair proved in the source model

Define `ReceiptPersistent`:

```text
for every accepted packet p:
  p.payload is present in journal.durable
```

Define `JointSafe` as the conjunction of:
- `IR85.ValidSession`: source auth/epoch/next-sequence sound accepted records;
- `IR87.AckSound`: every ACK corresponds to a committed journal entry;
- `ReceiptPersistent`: every accepted packet payload actually exists in the durable source journal.

The repaired `commitIngress` executes a modeled **queue → durable flush transaction** before adding the packet to the accepted session, only after the IR-86 field permit passes. The Lean proof establishes separately that this preserves all three invariants, including every previously accepted packet.

It then proves by induction that `JointSafe` holds after **arbitrary finite sequences of authorized packet-ingress and modeled reboot events** from any `JointSafe` initial joint state.

A synthetic test shows that commit-before-acceptance survives the modeled reboot while the weak queue-before-acceptance version fails.

## What remains unproved in the real physical universe

The source transaction is defined atomically by Lean semantics; it is NOT a hardware guarantee that the disk persists all data, that an ACK and durable write are consistent under sudden real power loss, or that all physical packet paths use the modeled two-phase transaction. Proof obligations include:
- actual full hardware crash/commit semantics, including cache flush, fsync, torn writes, firmware power-loss protection, quorum availability and malicious rollback;
- cryptographic packet authenticity and stable session freshness/replay resistance, accurate physical time/distance and link route;
- a trustworthy event/receipt identity: **payload value alone does not uniquely identify a living particular or historical continuity**. Different packets could carry equal payloads; a real X3 witness requires stable event identity and immutable provenance;
- inter-interval service/liveness, physical effect correspondence, freedom to change, replenishment, all originally defined X3 stages and universal feasible priority competition.

**Original X3 has not been weakened or declared physically completed.** IR-88 is a concrete substantive source-level composition repair; full physical proof is open.
