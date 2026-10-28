# IR-90 — Original A1 T3.2 descendant authority non-escalation

**Recovered original A1 source:** T3.2 describes delegation under the condition that descendant capabilities cannot exceed the delegating parent's authority.

## Formal source construction

`subsetCheck parent child` is an executable Boolean which tests EACH child capability's membership in the finite parent list. Its Lean soundness proof establishes `∀cap∈child, cap∈parent`; it is not an informal label for an unproven subset predicate.

A source `DelegationState` carries an immutable root authority and a list of delegated descendants. `delegate` adds a child list only after the executable subset gate passes. A source-level non-escalation invariant says **every admitted descendant's capability is contained in root authority**, and is proved invariant under arbitrary finite descendant proposals, including rejected attempts.

An explicit theorem composes T3.2 with the already proved **A1 T1.1 source global permission mask**: if all parent capabilities are permitted by that mask, then all admitted descendant capabilities also lie inside it. This is a genuine cross-A1 logical join of original T3.2 and T1.1.

## Hostile negative control

An unchecked delegate transition can issue capability 7 to a descendant whose parent possesses only capability 1. The state no longer satisfies the subset invariant. The exact scope check therefore makes a difference to model safety.

## Critical limits

- Authority is a list of abstract natural-number capability identifiers. Permission semantics, key provenance and cryptographic delegation signatures are not derived.
- The parent authority is **immutable** in this small source model. Real revocation, leases, transfer of capability, inheritance chains, concurrent permission changes, aliasing and retention of rights after parent changes need a stronger transition system.
- Source containment of capability identifiers is not hardware MMU/IOMMU isolation or physical containment of effects. A descendant might have unmodeled interfaces.
- Avoid confusing delegated authority protection with **free choice and ability to change** of a protected X3 particular. A limited child authority does not prove autonomy, historical continuation, service or original universal maximality.
- All original T3.2 physical installation and the entire nine-transition A1 plant correspondence remain OPEN.

**Status:** formal source-level implication and counterexample after pinned Lean CI, not actual physically proven non-escalation.
