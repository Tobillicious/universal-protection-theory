# IR-45 — Public assurance of the adversarial-stutter seam

The checked IR-43 theorem exposes a counterexample to guaranteeing
service from mere safety: an unserved belief that can remain unchanged
under one permitted disturbance has no strictly decreasing potential
for every possible disturbance.

The checked IR-44 theorem provides a separate conditional repair.
A verified finite budget on the actual trace's nonproductive events,
strict descent on productive events, non-increase on stalls, absorbing
service and zero-rank service imply a finite bound in COMPLETED steps.

Two physical claims explicitly remain OPEN:
- a defensible maximum number of actual nonproductive events,
  encompassing faults, retries, failover and invisible channels;
- an effect/observation-grounded productive event classifier with
  true rank decrease in the real plant.

Lean proofs and synthetic countermodels do not measure either claim,
and a count of completed events is not a clock. The original UPT
feasibility and X3 freedoms remain unchanged.
