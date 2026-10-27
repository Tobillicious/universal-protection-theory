# IR-43 — An adversarial stutter obstructs robust bounded service

IR-37–IR-41 establish conditional service and timing under a progress
rank that strictly decreases on **every admissible non-goal step**.
That premise is strong and can fail even if a helpful action or
disturbance exists.

Formal result: if an invariant, unserved state admits any disturbance
that returns to exactly the same state, no natural-number rank can
decrease strictly under every admissible disturbance there.

Stronger observation-level result: for an IR-19 observation-history
belief controller, a disturbance that leaves the entire current
non-served belief unchanged likewise refutes any robust strictly
decreasing **belief** potential. The proof imports the actual IR-38
types and operators rather than substituting true-state clairvoyance.

The synthetic witness has an initially unserved actual state, a
sensor that emits the same observation in all possible states,
a helpful disturbance that delivers service, and an adverse
disturbance that preserves the initial uncertainty. A robust
bounded-service rank does not exist for this world.

## Implication

A universal real-time service claim needs **one of**:
- verified elimination of the adversarial stuttering channel;
- a separate, explicitly proved bound on how often stutters can occur;
- stronger verified fairness or scheduling premises, with their
  corresponding (possibly probabilistic) guarantee stated accurately.

None of those premises can be derived from machine-checked safety alone.
This counterexample does not weaken the original full UPT freedoms;
it prevents stronger service conclusions being stated without support.
No emergency claim or physical plant is established.
