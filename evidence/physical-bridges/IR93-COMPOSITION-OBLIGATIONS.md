# IR-93: Unified composition — development obligations

**Status:** research scaffold, not a source-level import proof or physically
validated result. This branch adds a generic Lean composition kernel.

## IR-93A global safety
The global transition relation must include controller, environment,
idle, crash, failover and delayed effects. The imported IR-92 product-state
invariant must be mapped to the same global state as IR-49 physical safety,
IR-88 durable receipts, IR-89 resource certificates and IR-90 authority.
Each class must preserve *all* conjuncts, not just its own local invariant.
A cross-component rely/guarantee proof is still required.

## IR-93B bounded service
Define admitted obligations, completed physical service receipts and a
single clock. Derive each deadline from a decreasing progress rank,
finite stalls and a maximum inter-step delay using the actual IR-41,
IR-43–49 source theorem signatures. Include an infinite stutter
countermodel and a forged completion-receipt countermodel.

## IR-93C original-order join
Provide a total faithful map from represented outcomes to original
full-feasible outcomes, an original-order correspondence, and a
derived no-excluded-improver certificate. Use IR-66–71 only with their
respective finite-obstruction/baseline hypotheses. Include an omitted
feasible better-outcome countermodel.

## Review and replay
Run the repository's normal physical-bridges source staging, then
`lake build`, the axiom audit and all checkers. A build has NOT been
verified for this branch yet. No hardware, semantic continuity, full
physical channel inventory or full-feasible correspondence is established.

Do not promote this scaffold to the published edition until the source
adapters and adversarial tests are complete.
