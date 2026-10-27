# IR-16 — Explicit finite-model viability witness

To counter the risk of proving only vacuous **if a fixed point exists**
conditionals, we construct a real finite transition system with 3
states, 2 actions and one disturbance value.

- `origin` can remain safe forever by choosing false;
- `fragile` is safe for the instant, yet no action avoids the failed
  state on the next step;
- `failed` is unsafe.

The specific set obtained by one pruning step is proved **nonempty**
and **stable** by a closed Lean case check, rather than assuming
stability or inhabitedness. The existing IR-9 theorems then give a
greatest robust invariant state set and an indefinitely invariant
policy over every finite trace.

This is only a nonvacuity witness for a tiny **synthetic system**.
It does not establish nonemptiness, finite rank, correct observation,
external-channel bounds or correct physical plant correspondence
for the proposed actual instrument.
