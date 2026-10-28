# IR-86 — A1 T2.2 clock, distance and causal-feasibility admission

**Original source:** the 2026-10-24 recovered A1-REGISTER identifies T2.2 as *relativistic bus message*, requiring clock/spacetime feasibility under its source-level physical interface. The original physical plant remains unverified. This new theorem is a discrete arithmetic **source model**, not general relativity or a derivation of an experimentally real signal speed.

## Exact contract

A source-level transit has a send tick, receive tick, reported distance and epoch; a `LinkBounds` object supplies a finite maximum propagation speed per tick and a delivery deadline in consistent units.

`CausallyAdmitted` requires all four:
- sent no later than received;
- distance ≤ speed ceiling × elapsed ticks;
- receive tick ≤ send tick + maximum deadline;
- reported transit epoch matches packet epoch.

`fieldPermit` additionally requires IR-85's externally supplied `authCheck=true`, matching session epoch, and exact current next sequence.

Lean proves that any permitted field event satisfies **both** independent source-level predicates. It proves that a transit whose reported distance is greater than the speed ceiling times available deadline must be rejected, regardless of the authentication function.

Packet ingress under this extra guard preserves IR-85's valid accepted-receipt invariant for any finite stream of admissible or rejected field events. Every positive result carries the source-level cryptographic/timestamp limits of IR-85.

## Hostile counterexample and physical join

The code includes a declared transit of five abstract distance units in two ticks with a speed ceiling of three units per tick, which is admitted. An entirely different **actual** transit across five units at zero elapsed ticks violates the causal condition. The formal gate's acceptance of the reported metadata cannot prove the actual timestamps/distance match the reports.

This exposes the necessary physical correspondence:
- independently established bounds on true clock drift, clock synchronization and authenticated timestamp provenance;
- true distance/route geometry and correct speed units, with real medium and physical state trajectories;
- complete physical link and relaying topology, all messages/backlog, no bypass DMA/MMIO path;
- explicit relation between the original A1 actual T2.2 bus law and any source-level bound;
- finite delivery/deadline and service obligations without inventing clock or propagation guarantees.

The model does NOT derive a relativistic field equation, speed of light, gravitational time dilation, Lorentz transformations, causal cone geometry or full X3 physical feasibility. Source acceptance is a narrow check, not continuing historical identity or autonomy.

**Status:** formal model implication only after pinned Lean build; all physical clock/spacetime correspondence remains OPEN.
