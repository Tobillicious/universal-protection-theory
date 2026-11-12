
## Checkpoint 7 — formula transport and exact six-field decomposition

Continuation of P56 dependency review. P01–P56 and O01–O08 retained.
Pinned source commit: `037b74f3785d65d4c495a92ced958683a079bfc4`.
Verification: source proof-body review only; Lean and Lake were not found on PATH in this environment.

### General formula transport
[AllIsDynamicRelationalTransport.lean](https://github.com/Tobillicious/universal-protection-theory/blob/037b74f3785d65d4c495a92ced958683a079bfc4/evidence/physical-bridges/PhysicalBridges/AllIsDynamicRelationalTransport.lean)
Blob: `79c0bea59b4fef2308ec54af7dd2f06b54546cbf`.

every_intrinsic_formula_transports was read in full. Structural induction covers every constructor of RelFormula:
- related: the supplied relation biconditional.
- equal: congrArg forwards; apply the inverse and its left-inverse law backwards.
- and_: combine the two induction biconditionals.
- not_: not_congr retains both directions.
- exists_: map a before witness with F.to. For an after witness y, choose F.undo y and use the right-inverse law. map_extended_environment_between_types aligns the extended binder environment by Fin case analysis.

This checks the previously unreviewed general transport dependency of the whole-W six-report theorem. The inverse is essential to the after-to-before existential direction. The theorem covers formulas in the specified relation/equality language, including derived universal quantification; interpreting authentic original duties in that language remains a separate task.

### Exact grouping and failure exclusions
[RouteBOriginalSixFirstViolation.lean](https://github.com/Tobillicious/universal-protection-theory/blob/037b74f3785d65d4c495a92ced958683a079bfc4/evidence/physical-bridges/PhysicalBridges/RouteBOriginalSixFirstViolation.lean)
Blob: `6cb34304685394699abbf73999ce6e7dfc76ee80`.

original_six_iff_three_complete_groups was checked field by field:
| Group | Original fields |
| --- | --- |
| IdentityAndProvenance | historicalContinuity, provenance |
| AgencyAndFreedom | authorization, freedom |
| RestraintAndMaximality | restraint, maximality |

The reverse proof reconstructs OriginalX3 in its original field order. No field is discarded.

first_six_violation_iff_one_of_three_first_failures uses classical cases on the three conjunctions. A failed six-field conjunction forces at least one failed group; each failed group contradicts the corresponding projections of six-field truth. The failure groups can overlap: this is exhaustive coverage, not a disjoint partition.

no_first_original_violation_iff_every_owed_six converts absence of an existential bad event into universal protection by classical case analysis. route_B_three_first_failure_exclusions_iff_original_six then rewrites by these two equivalences and distributes negation over the three alternatives.

Important definition detail: FirstOriginalViolation and the three First...Failure predicates quantify a violating edge. They contain no ordering condition selecting the chronologically earliest violation. The all-edges equivalence is exactly what their definitions support. Chronological earliestness should not be attributed to these identifiers without another theorem.

### Review outcome and next handoff
The two previously deferred dependency bodies are now source-reviewed. P56's immediate logical chain is traceable through formula transport, six-source transport, three original-duty exclusions, their exact grouping, and the reflection equivalence. This does not constitute an independent compiler or axiom receipt.

Next reuse this completed logical chain and seek an independently constructed authentic reflection certificate for the same actual domain (O04), rather than reopening the regrouping proof. Complete-objective source covariance and the physical-domain interpretation still retain their recorded dependency and application obligations. No new Lean mathematics was introduced.
