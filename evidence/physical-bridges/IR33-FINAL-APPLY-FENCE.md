# IR-33 — Effect-boundary fencing as an alternative to full queue drain

IR-31 and IR-32 prove the physically safe quiescent route:
close new admissions and fully drain *all* pending and in-flight
effects. Some devices may be able to reject an old effect at
the **last physically consequential operation**, eliminating the
need to wait for every obsolete queued command to disappear.

IR-33 specifies that alternative precisely:
- Each queued effect carries a generation token and physical charge.
- The hardware effect-operation reads an authoritative current floor.
- An effect lands only if its token is at least that floor.
- A certified hold raises the floor above *all* old queued tokens.
- Any finite number of future delivery attempts on those old effects
  produces no modeled physical change.

The model reuses the original UPTFence source's actual certified
log-hold theorem and supplies a negative admission-only
counterexample: a token can be valid when queued but invalid when
it later reaches the effect boundary.

**The limiting condition is substantial:** A device may have already
passed an irreversible physical commit point before the hold, or may
have a bypass/latent channel not checked by the floor. In that case the
IR-33 conclusion **does not apply**; use a physically justified
quiescence/drain/compensation analysis instead.

No real actuator's check-at-apply mechanism, timestamp, credential
authentication, memory ordering, fault tolerance or physical effect
coverage is certified. This is a model-level conditional safety result.
