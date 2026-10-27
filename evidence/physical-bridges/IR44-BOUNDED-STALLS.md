# IR-44 — Bounded stalls permit service without all-step progress

IR-43 exposes a genuine limitation of earlier IR-37/38 service
certificates: an unserved state with an allowed stuttering transition
cannot support a rank strictly decreasing for *every* possible step.

This repair gives a separate sufficient contract that **allows stalls**.
Choose a productive-event predicate over the actual disturbance list:

- Productive events strictly decrease a natural-valued progress rank
  whenever service has not yet been delivered.
- Nonproductive events may stutter but may not increase the rank.
- The actual completed physical trace has at most `maxStalls`
  nonproductive events.
- The service goal, once reached, remains true.
- Every invariant state with rank zero has already reached the goal.

Lean then proves that a trace with at least
`initialRank + maxStalls` genuinely completed events must have
delivered service. The proof is **trace-relative**; unlike a
worst-case all-disturbance bound, it requires independently certified
stall accounting. It does not infer any such certificate from hope,
an unverified claim of fairness, or the existence of some good move.

Still open: whether an actual instrument can detect all stall events,
bound total stalls in advance, guarantee completed physical events,
provide an accurate service predicate, and satisfy the original X3
freedoms. A rank bound is not a real-time bound without separate
physical timing evidence (IR-41).
