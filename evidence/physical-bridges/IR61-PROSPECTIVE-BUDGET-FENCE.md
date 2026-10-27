# IR-61 — Prospective modeled actuator fence with an external-effect reserve

**Formally checked in the pinned Lean 4.35 build (working review branch).** Source-level extension of IR-59 and IR-60,
using the unchanged inherited `IRDurableEpoch.deliver` semantics.

## What changes mathematically

IR-60's final-threshold result required a *post-hoc* inequality about
the entire trace. IR-61 implements an operational guard for `deliver`:
before delivery, the guarded machine computes

`current_total + possible_fresh_delivery_impact + remaining_external_reserve <= threshold`

If the inequality fails, the modeled actuator **does not deliver**.
It leaves pending work in place. The effect impact comes from the
inherited queued credential/effect pair and IR-59's checked delivery
operation, not from a newly postulated safe outcome relation.

Independent environmental, latent, and bypass events are **not**
intercepted by that actuator check. Instead the model explicitly spends
a `remainingExternal` reserve for each such event. The theorem's
`TraceFits` premise requires the *actual represented* side effect to
fit the remaining allowance at every step.

Given a valid initial durable hold, an initial threshold margin for
the entire external reserve, and a `TraceFits` certificate, every
finite guarded run preserves

`modeled_current_physical_total + remaining_external <= threshold`.

Thus the current modeled effect is below threshold at every recorded
operational step, without assuming the final fresh-delivery total. A
separate compiled prefix theorem extracts valid budget certificates for
any earlier subtrace from the certificate for a complete event sequence.

Two adversarial witnesses matter: fresh effect 2 with threshold 1
is refused at delivery; bypass effect 2 with reserve 0 still executes,
violates the margin, and has no valid `TraceFits` certificate.

## Status and interpretation

This is a **constructive prospective protocol theorem in a synthetic
model**. It is stronger than an entirely retrospective final-bound
certificate, but it is not a physically deployed permit.

### What remains OPEN

- Evidence that every physical effect is represented in the chosen
  nine-constructor grammar, or a demonstrated refinement from the
  archived original nine transitions
- Empirical residual and external-effect budget, including
  environmental, latent, precommitted and bypass paths
- Trustworthy readout of the pending effect before the actual final
  physical landing; atomic enforcement of the modeled `deliver` guard
- Calibrated error, latency, actual continuous-time microtrajectories
  and devices outside the modeled register
- Authentication and controlled issuance of fresh-generation credentials
- Resource funding/escrow liquidation trigger, full X3 realisability,
  and continuation of historical subjects

The controller cannot force `TraceFits` to hold for unconstrained
exogenous events. The proof is conditional on that real-world obligation.

**Do not promote to a universal zero-breach or physical safety claim.**
