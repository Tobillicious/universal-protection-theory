# IR-39 — Nonvacuous, fully specified one-step service witness

IR-37 and IR-38 prove conditional bounded service given an absorbing
goal and a decreasing physical/belief progress rank. Those premises
cannot be treated as established for a real device merely because
the logical implication is machine-checked.

This small executable mathematical instance makes the assumptions
concrete:
- The modeled actual state begins `false`, meaning *not served*.
- The sensor outputs `()` for both `false` and `true`; it supplies
  no information distinguishing the initial possibilities.
- The initial belief is nonempty and contains BOTH physical states.
- The modeled safe action sets the physical state to `true`.
- The belief update excludes `false` after the transition.
- A specific progress rank (1 if `false` is possible, otherwise 0)
  is strictly decreasing until service is guaranteed.
- The theorem imports IR-38 to prove that the actual physical state
  is safe and served after one step.

This is a substantive nonvacuity test for the proof *schema*, not a
physical example or a guarantee for real control hardware. In a real
instrument, sensor ambiguity, physical disturbances, durable effects,
service semantics and available actions require independent evidence.
The original X3 priorities remain unchanged.
