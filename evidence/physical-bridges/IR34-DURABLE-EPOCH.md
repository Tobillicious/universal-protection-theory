# IR-34 — Crash-recovery durability of the effect generation floor

IR-33 proved that old physical effects can be rejected at their
final application boundary if the controller's raised epoch floor is
authoritative. A software crash or actuator failover can invalidate
that condition if the raised floor was stored only in volatile memory.

This module separates a *durable generation floor* from an actuator's
*live enforcement floor*. A protected hold atomically advances both;
a recovery operation resets the live floor from the durable value.
A proof shows that any finite sequence of hold, restart and delivery
operations still rejects effects bearing credentials from before
the original hold, even when those effects remain queued.

The negative control proves that a volatile-only floor update appears
correct immediately after the hold, but a restart can resurrect an
old permission and allow a positive effect to land.

**Physical premises not established:** actual crash-consistent storage,
write ordering, monotonic counters across failover, remote replica
consistency, trusted epoch/capability signatures, physical commit-point
enforcement, and all bypass channels. In particular, the modeled
atomicity of durable/live updates is a definition, NOT measured
hardware behavior. The theorem covers old queued effects under the
closed model, and does not freeze environmental dynamics or decide
subjective/historical identity.
