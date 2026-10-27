# IR-18 — Two-sided physical safety and resource depletion

IR-1R and IR-2 bound increasing scalar hazards, but life-preserving
equipment might also need a **lower bound** on usable energy, retained
substrate, historical resource, free capacity, or continuity margin.

The two-sided theorem has two separately checked facts:

- `post <= current + maxIncrease`, controlling overshoot;
- `current <= post + maxLoss`, controlling loss or depletion.

Given conservative *both-direction* sensor error and a gate that
reserves slack for both changes, Lean proves `lower <= post <= upper`.

A finite sum variant handles unbounded numbers of typed events under
explicit aggregate increase and loss budgets, and a counterexample
shows that satisfying only the upper guard can deplete the lower
protected threshold.

A final infeasibility theorem proves that if the combined physical
margins exceed the admissible interval, **no observation can satisfy
both guards**. Safe impossibility must not be treated as a proof of a
living, nonempty feasible set.

No actual resource floor, channel calibration, interval threshold or
biological/identity relevance has been established. The real physical
instrument must supply those meanings and measurements.
