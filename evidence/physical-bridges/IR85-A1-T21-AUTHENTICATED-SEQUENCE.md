# IR-85 — Recovered A1 T2.1 authenticated sequence ingress

**Original A1 source:** `2026-10-24-glm-phase-a/A1-REGISTER.md` in the user's preserved X3 archive describes T2.1 *packet ingestion with authenticated sequence*. The register treats source-level adoption separately from actual packet/HMAC and physical ingress installation. No full byte comparison to the live Zenodo DOI is claimed.

## New exact Lean model

A packet carries an explicit `epoch`, `sequence`, `payload`, and `tag`. A session carries a fixed `epoch`, the **next exact sequence**, and accepted packets. The source-level ingestion gate admits a packet only when:
1. `authCheck packet = true` for an **externally supplied** predicate;
2. packet epoch equals current session epoch;
3. sequence equals exactly the current `nextSequence`.

Acceptance increments nextSequence and records the packet; rejection leaves the session untouched. The counter uses unbounded mathematical `Nat` (no hardware integer wrap) and stores receipts in reverse acceptance order.

Lean proves:
- permitted packet implies all three exact gate conditions;
- any failed authentication, wrong epoch, or wrong sequence cannot alter the session;
- replaying the **same admitted packet immediately** is rejected on its changed sequence;
- the session invariant `∀ accepted p, authCheck p=true ∧ p.epoch=session.epoch ∧ p.sequence < session.nextSequence` holds after any finite packet stream from any initially valid session;
- session epoch remains invariant through every admitted ingress transition;
- finite sequences of packet-only ingress cannot alter tagged maintenance memory or change IR-81 supervisory mode *under the explicit field-state framing*.

## Hostile controls

- If the sequence predicate is removed, the very same packet may be recorded twice in the same epoch (source-level replay).
- If `authCheck` is a permissive constant-true predicate, a packet with an arbitrary tag still passes. The source theorem **does not prove HMAC authenticity**, MAC unforgeability, correct key management, producer identity, or actual secure transport.
- Field-only source transitions explicitly do not write maintenance; a real DMA/MMIO ingress path that can write maintenance is a distinct threat requiring IR-83's admitted DMA/IOMMU physical refinement.
- A correct packet sequence is not proof of bounded eventual delivery, of complete instrument observations, or of same-particular X3 continuing service.

## Remaining physical/reconstruction obligations

Crypto algorithm and security definition, authenticated origins/keys, nonce/epoch freshness, replay caches across reboots, counter overflow, delayed/reordered packet semantics, transport completeness, faults and timeouts, physical bus-master DMA privileges, and every original T2/T3 transition's actual implementation remain OPEN. Even meeting T2.1's source-model contract cannot by itself establish all-horizon robust original X3 viability, true historical continuity, autonomous choice or original universal maximality.

**Provenance rule:** Do not promote these Boolean accept tests to physical authenticated evidence without independently supplied cryptographic and implementation proof.
