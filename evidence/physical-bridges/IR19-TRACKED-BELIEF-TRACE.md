# IR-19 — Physical state + evolving belief across every finite trace

Prior IR-13 showed safety for a *single* observation update. This
new module carries a tracked pair:
- the actual modeled physical state;
- the current **belief**, representing all physical states consistent
  with the observation history.

The policy acts on that belief only. Each disturbance advances the real
physical state, then the new observation updates the belief. Lean proves
by induction that the actual state remains a member of the belief,
the belief stays in the fixed-point viability family, and the actual
physical state is safe **after every finite sequence** of disturbances.

This proof imports the actual IR-13 source and derives its policy from
the stabilized belief-kernel theorem, rather than assuming statewise
omniscient access.

### Remaining load-bearing obligations

- an accurate initial belief containing the actual state;
- an appropriate model of observations, including latency and losses;
- complete modeled successor/disturbance relation;
- a nonempty, actually stabilized belief kernel for the instrument;
- feasible ongoing belief updates with bounded memory/compute;
- any actual physical correspondence or identity semantics.

The theorem does **not** infer historical/personal identity or
infinite-time continuity from observational correctness.
