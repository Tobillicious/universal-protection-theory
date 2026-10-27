# IR-37–IR-39 — Tracking progress and freedom claims accurately

Lean now distinguishes safe persistence from actual service:

- IR-37: Bounded service is implied by an absorbing service goal,
  preserved invariant and a rank strictly decreasing under every
  non-goal physical disturbance.
- IR-38: The same implication applies to an actual modeled physical
  state tracked by an observation-history belief.
- IR-39: An explicit synthetic nonempty two-state model demonstrates
  actual service in one step despite a completely uninformative sensor.

These theorems remain CONDITIONAL or SYNTHETIC. Three new separate
assurance obligations are explicitly OPEN:

1. A real-world, measured and formally sound rank that descends for
   all relevant disturbance and observation channels.
2. A physically validated meaning of service actually delivered,
   including effect/actuator and sensing correspondence.
3. A faithful connection to the full ORIGINAL freedoms and continuing
   particulars under UPT; no narrowing of the original feasibility order.

The JSON ledger and CI deny a mistaken promotion of these obligations
to formally checked merely because the mathematical implication
builds. Neither the service proofs nor the toy example show that an
actual physical installation exists or that a global emergency is
imminent.
