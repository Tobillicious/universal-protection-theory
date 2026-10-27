# IR-8: Concrete history to abstract continuation

The inherited source `ContextualObservation.lean` establishes that local observation congruence entails preservation of future observations. The new IR-8 module imports that **unchanged actual source** and adds a separate forward-simulation layer:

- physical state C and abstract record state A
- a named relation R(C,A), not merely an equality of snapshots
- each physical event in the supplied alphabet has a corresponding abstract event
- R is preserved under every corresponding event, and matching outputs remain equal
- then for any finite event trace the physical and model outputs agree

**Still unproved:** the physical event alphabet covers every relevant operation, including intermediate transients, external channels, faults and stalled or infinite executions; the relation captures historical continuity of the particular being rather than mere observational equivalence; preservation of identity across re-entry; experimentally demonstrated correct readouts.

A negative example has two distinct physical states with identical observations. Therefore IR-8 does NOT prove historical or subjective continuity from output equality. It supplies a usable formal contract for an actual interface proof and prevents a misleading inference.
