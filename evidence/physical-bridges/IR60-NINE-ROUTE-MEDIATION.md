# IR-60 — Nine-constructor closed-route mediation, not physical completeness

**Status:** Pinned Lean 4.35 proof build and transitive axiom audit passed on the IR-60 review branch. Source-level composition of IR-59 and IR-15 in a deliberately closed synthetic operational model.

## Positive result

A concrete transition function is defined for **nine typed constructors**:
`hold`, `restart`, `inject`, `deliver`, `sample`, `tick`,
`environmental`, `latent`, and `bypass`. Unlike a theorem with a
free arbitrary step relation, the proof actually performs nine cases.

The model reuses the *unchanged* source-level
`IRPostHoldInjection.step` and its inherited
`IRDurableEpoch.deliver` at physical actuator landing. Typed side
effects are charged through `IRChannelInventory.charge` and counted
in a separate synthetic physical register.

After a durable hold, for **all finite event traces of these nine
constructors**:

- revoked-credential landings remain excluded;
- modeled actuator landings equal the initial landed register plus the
  recorded impact of fresh-generation deliveries;
- modeled side-channel physical effects equal their exact typed charges;
- the modeled total physical register equals baseline + fresh delivered
  impact + side charges;
- a threshold bound follows **only** if the margin covers both fresh
  delivered effects and side charges.

The compiled monotonicity proof additionally shows that, if the final
margin covers all represented effects, **every event-boundary prefix**
of the same trace is bounded. This relies on a nondecreasing model
register; it does not establish safety during unknown continuous motion
between recorded events.

The margin condition refers to the complete resulting trace and is
a **post-hoc mathematical certificate**. It is not a physically
deployed pre-effect authorization gate.

This is a closed-model *exact partition*, not an unconditional
zero-breach theorem.

## Important countermodels

A `bypass 2` operation can exceed threshold 1 even when revocation
works perfectly. A token with generation 1 can deliver effect 2 after
holding generation 0, with the same breach. Thus the final-application
revocation check alone cannot protect against bypasses or incorrectly
authorized new-generation work.

## Scope warnings and outstanding obligations

1. These are **nine newly specified model constructors**. We have **not**
   established that they match or exhaust the nine claimed physical
   transitions from archived Zenodo 23599528.
2. The total side-channel register is updated because it is *defined*
   to include the three typed external paths. Real environment, latent
   effects, hardware bypasses, irreversible precommitted effects and
   all unknown channels may not respect that representation.
3. The `sample` and `tick` cases alone do not prove measurement
   fidelity, non-Zeno timing or observation age bounds.
4. `inject` accepts arbitrary *fresh* credentials: their minting,
   physical authorization and actual harm envelopes are still OPEN.
5. The code is conditional on a physical correspondence map between
   real world trajectories and **these exact constructors**, and
   a measured bound on every relevant effect. No such map was measured.
6. The all-prefix result holds only at modeled event boundaries.\n   IR-51/52 continuous and missing-sample safety obligations remain OPEN.\n7. Original X3, full-feasible maximality, and subjective or historical
   continuation are not modified or newly proved.

## Next genuine physical seam

Define a plant-specific refinement relation `R(real, model)` and
prove *every* admissible real physical transition has a corresponding
model event with physical effect bounded by the model and residual
escrow. That exhaustive simulation obligation cannot be discharged by
simply writing down `Event` or assuming `R` holds. Independent plant
inventory, failure injection and measurements are required.
