# IR-91 — A1 T3.3 controller retirement / custody-release finality

**Original source:** The recovered A1-REGISTER T3.3 clause requires terminated control and absent held locks before release. IR-91 additionally checks **no pending effect**, **no in-flight effect**, and **positive handoff acknowledgement**, following the separate IR-32/33 in-flight and protected-history custody concerns.

**Essential distinction:** Terminating or retiring a *controller* is not permission to terminate a protected living particular. An absorbing retired device is not an absorbing mind or an automatically preserved history.

## Lean model

A controller state tracks `controllerTerminated`, `heldLocks`, `pendingEffects`, `inFlightEffects`, `handoffAcknowledged` and `custodyReleased`.

The source-level `releasePermit` passes only when the controller is terminated, both effect counts and lock count are zero, and a handoff receipt has been recorded. `releaseCustody` does nothing otherwise. Other preparatory events can terminate the controller, decrement locks, mark effects drained, and record a handoff receipt. **Once released, the modeled retired controller is absorbing** and cannot resume generating new source events.

Lean proves the permission's precise postconditions and, from any initially `ReleaseSafe` state, proves `ReleaseSafe` survives **all finite sequences** of these source lifecycle transitions.

## Hostile countermodel

A weaker rule that checks only "terminated and heldLocks=0" may release custody with an in-flight effect still pending and no handoff receipt. That breaks the stronger finality and continuity-interface safety condition even though it superficially satisfies original T3.3's basic syntactic gate.

## Remaining physical and X3 obligations

- A counter value of zero is not by itself a complete proof no unobserved physical effects, thermal tail, cache writeback, actuator momentum or asynchronous packet remains. The source counts must be refined to an actual comprehensive inventory and real effect barrier; IR-32/33 provide **conditional modeled** quiescence results.
- A source `handoffAcknowledged=true` is not a proof any protected particular's actual continuing process remains intact, their autonomy is preserved, or an authenticated caretaker has sufficient long-term resources.
- No source event automatically proves physical relay release, device termination, lock reclamation, storage cleanup, actual transfer of cryptographic/physical authority, lease expiry or secure revocation.
- The controller's absorbing retired state cannot be silently substituted for the protected subjects' continuing life or freedom.
- Original full X3 all-history physical feasibility and global priority/maximality remain OPEN.

This is the ninth original A1 transition class **at the source-model level**, not the completed physical nine-transition installation.
