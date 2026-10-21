# Why the ordered sink premise carries real work

Separating journal commit from delivery does not eliminate the exactly-once external-effect problem. Suppose a crash leaves the same durable local pending record in two worlds. In one, the non-idempotent effect occurred before the crash but its receipt was not stored. In the other, the effect did not occur. Recovery has no query, durable sink identity or receipt distinguishing the worlds.

For the binary recovery choice, skipping loses the effect in the second world, while resending duplicates it in the first. `DeliveryGap.lean` proves that no local skip/resend choice succeeds in both worlds, including any deterministic function of the identical local view. This is a deliberately specified interface model, not an impossibility theorem about every delivery architecture.

A persistent sink-side identity changes the interface. A resend applies the effect only if its ID is absent; the abstract model then has one effect in either world. The file checks that fact too. It does not construct the transaction linking the real external effect to its persistent ID. A query/reconciliation protocol or a semantically idempotent operation can provide other sufficient interfaces.

The journal construction assumes precisely such an atomic ordered sink commitment. Its ordered record and identities are not a detached local cache whose persistence somehow guarantees an arbitrary remote action. The original source's outbox assumption and this bank's sink assumption must be connected to an actual effect interface before either is a physical exactly-once result.

`durable_protocol.py` also checks a distinct load-bearing guard: recording two inputs before delivery can read stale feedback. With g(out)=len(out)+1, premature inputs are (1,1), while the ideal delivered-feedback history uses (1,2). The one-pending-step discipline prevents that failure in this construction; it is not claimed necessary for every possible pipelined implementation.
