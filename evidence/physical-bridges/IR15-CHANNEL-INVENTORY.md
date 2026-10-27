# IR-15 — Closed-channel accounting and bypass controls

This PR formalizes a **typed closed list of modeled channels**:
authorised operations, environment dynamics, latent/delayed effects,
and bypass effects. Each has an explicit nonnegative influence charge.

The code proves that an independently updated physical register equals its
starting value plus the complete modeled charge sum on **every finite trace**.
An independent accounting register remains coupled from an initialized state,
and a gate comparing the *whole* charge budget against the threshold suffices.

## Mandatory hostile controls

- A deliberately incomplete meter omits `bypass` and `latent` charges.
  Lean proves it can report zero while the physical effect is positive.
- For every proposed finite aggregate bound, a one-event trace with larger
  charge exists unless the system **enforces** the bound.

## What this does NOT establish

The actual instrument might have an unknown channel not included in the
`Channel` enumeration. Nothing in Lean can prove real-world completeness
merely because an algebraic data type has four constructors. Environmental
or continuous/negative/delayed dynamics, effect calibration, gate enforcement,
sensor semantics and all physical hardware verification remain separate.
The proof only concerns finite, nonnegative modeled scalar contributions.
