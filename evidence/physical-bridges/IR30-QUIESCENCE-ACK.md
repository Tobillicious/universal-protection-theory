# IR-30 — Current quiescence acknowledgement and finite delivery safety

The IR-29 deferred-effect countermodel establishes a physical truth:
preventing new controller writes need not prevent previously queued
external physical effects from landing.

This follow-up constructs a **separate queue-empty acknowledgement**
in the deliberately idealized actuator model. The Lean proof shows:

- acknowledging quiescence entails the current modeled queue is empty;
- a freshly acknowledged empty queue cannot deliver any physical
  effect under any number of modeled delivery steps;
- composed with the UNCHANGED original `UPTFence.raise_then_nothing_lands`
  theorem, a certified held window has unchanged logs and no modeled
  physical delivery, under the relevant token and queue-empty premises;
- a stale ack is unsafe: the controller gate may look identical before
  and after a new physical effect enters the queue, while only the
  latter can land something.

**Crucial physical implementation obligations:** authentic, atomic
and *current* acknowledgement of the COMPLETE external actuator queue;
no in-flight writes that enter after the ack; correct delivery/cancel
semantics; no latent physical effects outside the queue; timing and
hardware isolation evidence. This model has no new dispatch operations
during the post-ack finite-delivery interval; that exclusion MUST be
enforced in reality, not inferred from the ack bit.

No proof of historical/subjective identity, universal physical safety
or guaranteed real-world quiescence is claimed. X3 unchanged.
