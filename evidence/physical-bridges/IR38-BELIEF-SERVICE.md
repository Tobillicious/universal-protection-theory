# IR-38 — Bounded service under genuinely partial observation

IR-37 proves a standalone rank-based eventual-service implication.
IR-19 separately proves actual physical state and evolving belief remain
in a safe observation model over arbitrary finite disturbance histories.

This new Lean module **joins the actual source theorems**. The controller
selects actions using the current *belief* of possible physical states,
not hidden access to its true physical state. An actual physical state
is retained in that belief throughout execution, and the viability
family remains closed. An absorbing service goal is certified only if
ALL still-possible states satisfy that goal.

From those facts plus a **robust strictly decreasing rank over the
belief** until service, the theorem proves that every disturbance
sequence of the required length leaves the actual physical state both
safe AND served.

The rank must decrease under *all* modeled disturbances, so a
controller cannot assert service by relying on a favourable or fair
scheduler without proving the necessary scheduling premise.

Remaining open: real hardware and sensor fidelity, complete physical
event coverage, nonempty reachable kernel, existence of a decreasing
service rank, validity of the service/goal persistence predicate,
realization of original freedoms, and historical personal identity.
The theorem is conditional, and does not change X3.
