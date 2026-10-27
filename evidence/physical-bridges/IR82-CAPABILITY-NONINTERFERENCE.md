# IR-82 — Source-level primary-memory non-interference

## Purpose and scope

Gemini identified a real omission in re-entry authentication: a typeclass gate or a `primaryRequest=false`-blind state machine alone does not prove that primary software is incapable of mutating the supervisor's authorization register. The proposed sketch `ExecutePrimary cmd state = ExecutePrimary cmd state` proves only reflexivity.

IR-82 supplies an actual explicit address and transition model, connects it to IR-81, and keeps physical memory-map correspondence OPEN.

## Model and source-level theorem

The source `IRCapabilityNoninterference.lean` declares a tagged sum of addresses:

```lean
inductive Addr
  | primary (slot : Nat)
  | maintenance (slot : Nat)
```

Primary commands contain a primary slot and integer word. The **only modeled primary-write transition** updates `Addr.primary slot`. Maintenance slots are `Addr.maintenance slot`. Their disjointness is proved from constructors, not assumed as an additional theorem parameter.

Lean then derives, for EVERY initial memory, arbitrary finite primary program, and every maintenance slot:

```text
readMaint (runPrimary memory primaryCommands) slot
  = readMaint memory slot
```

It proves the **full function projection** of maintenance memory is identical before and after the program; even two arbitrary different primary-memory programs cannot distinguish maintenance states starting from the same maintenance projection. A maintenance-derived two-register authorization/epoch flag therefore remains unchanged through all primary-only writes.

This source theorem is actually composed with **IR-81's** `step .hold`: if the maintenance authorization bit initially rejects, no finite sequence of modeled primary-only writes can authorize exit from operational hold.

An explicitly modeled EXTERNAL maintenance write can change an authorization register. That is a necessary architectural distinction, not an authentication proof. If a rogue physical bus master or a DMA device can write the maintenance cell, it is NOT covered by the source-level `PrimaryWrite` type.

## What Gemini's original argument failed to prove

- A shared physical address map may be affected by MMIO aliases, DMA, debug access, speculative/device writes, peripheral bus masters, reset hardware, electromagnetic faults, power sharing, and analogue coupling. A typed sum only models a deliberate division; it does not certify that the actual silicon physically implements it.
- Separation of address aliases alone does not establish a cryptographic fresh authorization signal, secure key management or resistance to replay. IR-81's `epochFresh` and `sidebandAuth` remain external source-level propositions.
- The original statement tried to derive equality of the **whole** maintenance function by proving only equality for members of an allowed set; the complement requires separately defined write-frame semantics. Here those semantics are explicit and proved for every maintenance slot.
- An external maintenance write is not necessarily authorized merely because it is distinct from the primary CPU.

## Status and next join

**Lean mathematics:** typed disjoint memory, arbitrary finite primary program non-interference, authorization-bit preservation and exact source-level IR-81 guarded hold consequence (after CI passes).

**Open physical/evidentiary:** validated memory/peripheral capability ownership for every bus master and address alias; actual external maintenance-protocol authentication and freshness; DMA/coherent cache effects; memory fault containment; cryptographic anti-forgery; true actuator physical fencing, actual live subject-service continuity and original X3 full priority structure.

This addition changes no archived Zenodo, original X3 normative or universe assumptions.
