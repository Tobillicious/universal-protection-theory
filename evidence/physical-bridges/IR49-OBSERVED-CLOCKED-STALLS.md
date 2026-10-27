# IR-49 — Actual physical-state service under partial observation,
bounded stalls, and a conditional clock

IR-38 proves service to the actual modeled physical endpoint under an
all-disturbance rank. IR-43 establishes that an unserved belief
stutter obstructs that strong premise. IR-44/46 permit bounded stalls
but previously operated over generic controlled state.

This module imports their actual Lean theorem signatures and composes
them over IR-19's **actual-state plus evolving observation-history
belief**, with actions selected solely from the belief.

The conditional conclusion simultaneously yields:
- the final belief remains in the controller's safe viability family;
- the actual modeled physical endpoint belongs to that belief;
- the actual endpoint satisfies the safety predicate;
- the actual endpoint **really satisfies the modeled service goal**;
- the authenticated completed-event clock meets the specified bound
  when the supplied trace is exactly `initialBeliefRank+maxStalls` long.

A real physical implementation must independently establish ALL of:
valid observation and channel coverage; well-founded meaningful
service rank; a correct productive-event classifier; the maximum
stall count; actual event completion; a maximum inter-event delay;
durable service semantics; and faithful identification of particulars
and originally defined freedoms.

The theorem is not empirical verification and makes no emergency or
universal deployment claim. Original X3 and canonical sources unchanged.
