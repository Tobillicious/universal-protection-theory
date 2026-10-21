# Conditional randomness and complete output

The sharp conditioning/mixture derivation in STATISTICAL-LOTTERY.md assumes the next returned raw law is close to uniform at every reachable attempt history. Uniform unconditional marginals do not suffice.

An exact counterexample uses one uniform Z in field 5 and defines attempt r as (Z+2r) modulo 5. Accept residues 0, 1 and 2, and reduce modulo 3. Every attempt considered without its history is uniform. Nevertheless the first accepted result has probabilities (2/5,2/5,1/5), total variation 2/15 from uniform. Given the first rejection, the second raw law is 3/5 away from uniform. This identifies the missing conditional premise without any simulation.

A fresh uniform two-attempt cap instead has complete law (7/25,7/25,7/25,4/25 abort). Its total variation from a uniform option with no abort is 4/25. Removing the abort outcomes by conditioning would hide availability loss. `checks/conditional_lottery_check.py` checks both exact examples and rejects both stronger false claims.

Returned well-typed draws and call termination are separate from distributional correctness. A cap of N attempts has a wall-clock bound only with a supplied per-call duration bound plus setup/finalisation and timeout policy. Almost-sure attempt termination is not a deterministic time guarantee. These are the same sufficient protocol premises already used in the complete-error derivation; no new instrument rung is introduced.
