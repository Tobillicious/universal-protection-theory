# IR-83 — Recovered A1 source-level DMA / host-controller mediation

## Source provenance, and what the Zenodo link actually contributes

The inspected **user-preserved** ZIP `Snuffy-X3-Korero-Preservation-2026-10-24(1).zip` contains a 24 October 2026 recovery snapshot `2026-10-24-glm-phase-a/A1-REGISTER.md` and original source snapshots `lean/ControllerCertificate.lean`, `FIFOInstance.lean`, `IntegrationCertificate.lean`, `P2P3.lean`. The user also supplied the related Zenodo DOI `10.5281/zenodo.23599528`.

**Important provenance distinction:** The original Zenodo record could not be freshly downloaded or byte-compared in the current execution. The checked content below comes from the conversation-attached preservation ZIP, not an independently established byte-identical Zenodo file.

Preserved A1 register SHA-256: `730ed3b798deb73a95d674b376eec80f934826d55d6a200965b64e67bd206cdd`.
Preserved ZIP SHA-256: `51d6b59c63164064c11586ccaa0af8520de8c0e4b66840a7257865a19f2c3d84`.

## The exact original A1 register distinctions

The nine rows of `A1-REGISTER.md` are grouped as:

- **Host (T1.1):** memory/page mapping with `capabilities ⊆ permitted_mask`. The register explicitly leaves **real MMU bounds checking** and preservation of the permitted mask as plant obligations. IR-83 models ordinary primary writes but DOES NOT prove these page/mask constraints.
- **Host (T1.2):** DMA must have `dma_addr ∈ authorized_window`. Its real IOMMU/bus/window enforcement is an explicit **plant obligation**. THIS is the direct IR-82/IR-83 join.
- **Host (T1.3):** context switches must obey `privilege ≤ ring_target`; the physical ring/privilege implementation remains an obligation. IR-83 uses an explicit numerical privilege ceiling, which needs a separately confirmed mapping to any real CPU ring convention.
- **Field (T2.1–T2.3):** packet ingestion (authenticated sequence), relativistic bus message (clock/spacetime feasibility), storage sync (hash/merkle durable journal). IR-83 proves none of their implementation certificates.
- **Generated (T3.1–T3.3):** commissioning (escrow sufficient for initial and continuing costs), delegation (descendant authority non-escalation), retirement (terminated and locks absent before release). IR-83 proves none of these positive duties or physical bindings.

The original register calls its rows **adopted**, with compilation-level operator carriers and **unverified per-row physical installation**. The scalar ring `typed_gate_decomposition` in archived `IntegrationCertificate.lean` shows a conditional algebraic decomposition given projector relations. It does not establish real IOMMU address filtering.

## What IR-83 actually proves

Extend IR-82's tagged primary/maintenance address model by a **separate DMA bus master** whose request target can intentionally be `Addr.maintenance slot`. A source-level DMA gate executes a memory write ONLY if the target is `Addr.primary slot` and `slot < authorizedWindow`. Every maintenance target and every outside-window primary address is rejected.

Model a context-switch request with a source-level numerical `requestedPrivilege ≤ privilegeCeiling` admission check, plus arbitrary primary CPU writes. Prove, for any initial state, every address in the maintenance domain, and **every finite mixed sequence** of these three modeled host operations, that the maintenance cell is exactly unchanged.

Additionally, starting with an unaccepted maintenance authentication/epoch flag, compose this result with IR-81's actual supervisor transition: no finite admitted mixed host trace can make the supervisor authorize an exit from hold.

A deliberately *unrestricted* DMA transition CAN change a maintenance cell despite IR-82's proof for primary CPU writes. This is the precise negative control exposing why A1 T1.2 cannot be waived.

## What cannot be promoted

- This is a **source-level host-transition submodel**, not a derivation of the real nine-transport exhaustive A1 plant. IR-83 does not cover T1.1 page-grant subset semantics or any T2/T3 physical carrier.
- Authenticity of maintenance keys, secure epoch freshness, effective separation of bus masters/MMIO aliases, physical DMA/IOMMU register programming, hardware clocks/SEUs, real actuator gating and live service are **not proved**.
- The archived `ControllerCertificate.lean` provides rational arithmetic on specified controller workload/deadline cells, and `FIFOInstance.lean` verifies a specified finite FIFO workload. Neither proves an indefinite physical service guarantee without workload completeness and future-demand assumptions.
- The archived `P2P3.lean` contains several parameterized physics and workload lemmas; its theorem names do not supply a proof that every arbitrary original X3 physical plant satisfies their assumptions.
- The original strongest X3 universality, same-particular historical continuation, free change of choice and all priority stages remain OPEN.

**Required next genuine physical join:** complete and independently testable inventory of all real bus masters and their memory/write effects, plus a source-to-physical refinement for each A1 transition. Then prove that each permitted physical effect is represented by the modeled authorized transition; a list of source-level nine rows alone does not establish this completeness.
