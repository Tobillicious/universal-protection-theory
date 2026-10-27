# IR-9 — Greatest robustly invariant subset at a verified fixed point

**Distinguish three claims.**

1. Every iteration removes states where no action guarantees staying inside the preceding safety set under all modelled disturbances.
2. Every genuinely robustly invariant subset of the original safety envelope survives **every** pruning round. This is a general theorem, not a finite-model observation.
3. If a pruning round stabilises, its result is itself robustly invariant and contains all safe robustly invariant subsets. Hence it is the greatest invariant subset under inclusion. A state-dependent policy can be selected when the action type is inhabited and its trace safety certified.

**Unproved obligations:** numerical/physical bounds for the transitions and disturbances; nonempty kernel; a termination bound for the specific finite-state implementation or a fixed-point theorem over richer infinite-state models; uniformity over indistinguishable observations (IR-6); historical identity/continuation; and unrestricted original UPT feasibility (IR-7).

This is the descending safety-viability analogue of a closure/fixed-point construction; it is not an assertion that a real-world greatest physically possible preservation state has been identified.
