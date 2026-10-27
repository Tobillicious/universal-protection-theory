# IR-10 — Conditional End-to-End Instrument and Preservation Certificate

**Status:** Draft theorem assembled from IR-1R through IR-9 and source-level imports of the unchanged UPT controller, order, and observation files. It is not an installation certificate and is not an amendment to published Snuffy texts.

## Exactly what the composite theorem concludes

Given the explicit premises below, a single **implementable outcome** is globally maximal under the **original** UPT stagewise order, and an **observation-only policy realizing that same outcome** is certified to preserve a specified physical safety predicate and its robust viability kernel at every finite disturbance-trace index.

The theorem also establishes that the supplied certified hold leaves the physical state unchanged **if** physical state at both endpoints is correctly represented by the fenced target log; and that the resulting post-hold concrete process has the same **observations** as the abstract record over every finite event history **if** the stated step-refinement relation and observation interpretation are sound.

## The premises are not harmless

1. **Certified controller hold:** Valid retirement, receipts, no release, and target application-time semantics as in the unchanged `ControllerFence` source.
2. **Complete physical/log correspondence:** The actual physical state both before and after the hold equals a declared function of the target log. This is substantially stronger than log immutability and currently not an empirical finding.
3. **Physical post-effect envelope:** Sensor error, external drift, uniform total interference budget, jump bounds, and check-at-apply gate all cover real effect channels.
4. **Stable kernel and viable initial state:** The descending safety predecessor has reached a fixed point, and the actual held state belongs to it. No existence or nonemptiness is inferred.
5. **Observation adequacy:** The chosen policy is uniformly viable across all safe physical states sharing its observation; partial observability can otherwise make statewise viability insufficient.
6. **Historical-record simulation:** Every modeled physical disturbance/action step preserves the concrete-to-record relation; a readout is a correct projection of each related state. This does **not** establish subjective or personal historical identity.
7. **Full-feasible cofinality:** Every originally feasible outcome excluded by the physically safe menu is strictly dominated in the original UPT order by a safe-menu outcome. This is an unproved and strong physical/semantic feasibility assumption.
8. **Outcome-to-policy realization:** Every eligible safe-menu outcome is actually implemented by an observation-uniform viable policy. Merely selecting a globally maximal outcome does not produce an implementing policy.

## Scope and boundaries

The theorem quantifies over *every finite disturbance trace* of the supplied transition system, without probabilistic or independence assumptions; it does **not** certify absence of infinite-time Zeno processes, transition coverage, true physical continuity or unknown disturbance channels. The universal normative scope of X3 is not restricted or weakened, but its physical feasibility is not established.

The greatest-kernel assertion is a model-relative inclusion result about safe invariant subsets, **not** the universal greatest jointly realizable set of all freedoms. No coercion, guaranteed adoption by advanced systems, or actual deployment is proved.

## Replay

GitHub Actions stages the untouched inherited source files and runs Lean 4.35 with:

```sh
cd evidence/physical-bridges
lake build
python3 checks.py
python3 viability_checks.py
```

Review the `#print axioms conditional_end_to_end_certificate` output. The explicit premises in the theorem type remain assumptions even when the Lean axiom report has no `sorryAx`.

## Next material research, not wording changes

- Prove an operational forward-simulation from a concrete instrument rather than supplying one.
- Replace the log-function equality by a physically justified guarded refinement accommodating independent drift and continuing dynamics.
- Prove a finite-state stabilization bound *within the installed model* and nonempty observable viability.
- Prove the full cofinality and outcome-policy implementation obligations without narrowing the original feasible set.
- Establish the intended histories' semantic identity separately from observation matching.
