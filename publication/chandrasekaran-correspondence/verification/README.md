# Guardian continuation supplement

Additive to the previous fixed-point replay package, retained in `previous/`.

- `GuardianContinuation.lean`: constructive greatest postfixed predicate, fixed-point equivalence, maximality, successor and injective distinction. No custom axioms or `sorry` in this new file. Run `lean GuardianContinuation.lean` with Lean 4; not executed here.
- `GuardianContinuation.mch` and `GuardianContinuationMutant.mch`: finite B models for record-preserving transitions and an erasing boundary mutant. Run `probcli GuardianContinuation.mch -model_check` and the equivalent command for the mutant; CLI version/options may vary. ProB not installed here; these are pending replay. `Align` and cyclic phase operations are separate; no model of real cosmology, nor actual six-duty certification.
- `check_continuation.py`: executed with Python 3, standard library only. Finite greatest fixed-point calculation, reachable-state exploration, erasure control, reversible geometry control and distance bound. `results.txt` records the actual execution. Edges count unique successor states per source, not operation labels.
- The ghost `initial` is an audit reference, not itself an accessible physical record. Phase 2 to phase 0 is a stipulated boundary transition, not derived physics. The model does not claim new information is generated at each turn.
