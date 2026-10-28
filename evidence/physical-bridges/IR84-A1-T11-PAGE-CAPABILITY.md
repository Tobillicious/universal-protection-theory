# IR-84 — A1 T1.1 source-level page capability closure

**Original source:** user-preserved 2026-10-24 X3 preservation archive, `2026-10-24-glm-phase-a/A1-REGISTER.md`, original T1.1: page capability grants must be a subset of `permitted_mask`, with actual MMU/page-bound checks declared as plant obligations.

**Earlier bridges:** IR-82 protects tagged maintenance memory against arbitrary modeled primary CPU writes; IR-83 extends that isolation to admitted source-level DMA writes (T1.2) and context switches (T1.3). IR-84 completes all three **MODELED source-level host transition classes** using a real inductive invariant rather than checking each class in isolation.

## Exact new theorem

The state includes:
- a host state (IR-83 memory and privilege level);
- an immutable source-level permission mask `Nat → Bool`;
- a list of currently granted abstract capabilities.

The permitted invariant is `∀cap ∈ installed, permittedMask cap = true`. A proposed grant is executed only when `permittedMask cap = true`; a forbidden grant leaves the state unchanged. The mixed event type admits either one IR-83 host event (primary write, DMA, context switch) or a page grant.

Lean proves:
1. Every admitted step preserves the ENTIRE mask by extensional equality.
2. Every admitted step preserves the invariant that all installed capabilities are inside the mask; on a permitted grant this is a constructive list-membership proof.
3. Every admitted step preserves IR-83's source-level privilege ceiling and maintenance memory unchanged.
4. **For every finite mixed sequence** of T1.1 page grants and T1.2/T1.3 host events, the mask, capability closure, privilege ceiling, and all maintenance cells remain intact. This is an inductive source-level statement independent of an arbitrary fixed number of operations.
5. By composing maintenance-register preservation with IR-81, a supervisor whose two-register maintenance authorization initially rejects cannot be authorized to exit hold by any admitted mixed host operation.
6. Negative control: an unchecked grant can install capability 7 with a mask that permits nothing, violating `capabilities ⊆ permitted_mask`. Consequently checking the mask is necessary in this submodel.

## Limits / remaining original X3 joins

The model uses abstract natural-number capability identifiers and a **fixed** permission function, not an actual page table, MMU, IOMMU, privilege ring, process isolation boundary or physical address. It neither proves grant uniqueness/revocation/alias correctness nor validates that a real plant can maintain immutable permissions. The nine-transition original A1 register also includes T2 packet/message/journal and T3 commissioning/delegation/retirement whose source and physical semantics must be verified separately.

No result in IR-84 proves a physical hardware implementation, indefinitely sustained service, particular historical identity, freedom to change or original X3 universal maximality. Those remain OPEN, not weakened.

**Status:** source-level Lean theorem after pinned CI, not yet physical instrument evidence. See `PhysicalBridges/IRA1PageCapability.lean`.
