# IR-22 — Constructive nonempty belief-kernel witness

The earlier IR-6 counterexample proved that some equally observed safe
states require incompatible actions. This complementary witness proves
that partial observation is **not automatically fatal**:

- two states, 0 and 1, are safe;
- both emit exactly the same observation (indeed all states do);
- the safe-belief family explicitly contains them and is nonempty;
- a `false` action holds every physical state in place;
- the belief viability operator is proved fixed from round zero
  without supplying an unverified stabilization assumption;
- the *actual IR-19 finite-trace theorem* constructs a belief-policy
  guaranteeing safe physical endpoints for every modeled finite trace.

It also proves that the alternate action (`true`) is unsafe from
the observation-compatible state 1. This tests the model against a
clairvoyant or insufficiently robust policy.

This is a tiny artificial transition system demonstrating mathematical
nonvacuity. It is NOT evidence that any real preservation instrument
supports a safe policy under its actual sensing, memory and disturbance
channels; it does not establish personal identity or continuing physical
histories. Real system evidence remains necessary.
