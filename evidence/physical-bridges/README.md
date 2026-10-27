# Physical-interface proof bridges — working research track

**Public status (27 October 2026):** Formally checked *conditional*
and synthetic-model theorems, not a physically demonstrated universal
protection or preservation theorem. Separate from the Snuffy 2.0.5
published DOI and not a modification of the canonical source modules.

## Reproduce the results

From the repository root:

```bash
cd evidence/physical-bridges
lake build
python3 checks.py
python3 viability_checks.py
python3 instrument_checks.py
python3 lifecycle_checks.py
python3 verify_assurance.py
```

The `lean-toolchain` file pins the Lean version. GitHub Actions stages
the **unchanged original** UPTFence, ControllerFinality,
ControllerFence, UPTExistence and ContextualObservation sources for
source-level imports, then compiles the bridge suite and enforces a
transitive axiom audit across the `PhysicalBridges` namespace. To
replay those imports manually, run from the repository root before
`lake build`:

```bash
cp evidence/papers-11-12/lean/modules/UPTFence.lean evidence/physical-bridges/UPTFence.lean
cp evidence/papers-11-12/lean/modules/ControllerFinality.lean evidence/physical-bridges/ControllerFinality.lean
cp evidence/papers-11-12/lean/modules/ControllerFence.lean evidence/physical-bridges/ControllerFence.lean
cp evidence/papers-11-12/lean/UPTExistence.lean evidence/physical-bridges/UPTExistence.lean
cp evidence/papers-11-12/lean/modules/ContextualObservation.lean evidence/physical-bridges/ContextualObservation.lean
```

These five files are copied *for local replay only*. Do not commit
their staged copies in place of the original published source.

## Actual results and boundaries

| Theorem area | Checked conditional conclusion | Not established |
| --- | --- | --- |
| IR-1R–IR-3 | Conservative post-effect bounds, charged interference and greatest one-step observation-safe permits | Sensor accuracy, application-time hardware guards and complete physical mediation |
| IR-4–IR-9 | Robust finite-trace invariance, partial-observation policy criteria, state kernels and source-level controller/record joins | Nonempty safe kernel or realistic observation model for an actual plant |
| IR-10, IR-17, IR-20 | Selected policy and original UPT order can be joined under full-feasible no-improver and implementation hypotheses | That any actual full-feasible set meets those premises, or that all freedoms can be jointly realized |
| IR-11–IR-16 | Idealized device, environmental drift, belief-state viability, ranked termination, typed effect accounting and finite nonvacuity examples | Device manufacture, measured effect bounds or comprehensive channel inventory |
| IR-18–IR-25 | Upper/lower physical margins, evolving beliefs, positive examples, time-to-charge bounds and explicit residual escrow | Clock progress, real effect-to-charge correspondence, unmodeled residuals and signed physical dynamics |
| IR-26–IR-30 | Append-only origin-labeled records, quorum-certified no-fork semantics, deferred-effect countermodels and fresh queue-empty acknowledgement | Cryptographic/network deployment, no in-flight actuator effects, subjective/personal identity |
| IR-31–IR-34, IR-36 | Admission-closed and in-flight physical quiescence; durable apply-time epoch fencing, including multiple modeled actuators | Real device enumeration, atomicity, complete effect-channel coverage and durable floors across every failover |
| IR-37–IR-39 | Robust ranked bounded service, source-level physical/belief service join and a nonvacuous synthetic one-step example | A verified real-world decreasing service rank, delivered freedom, observation and physical-effect fidelity |
| IR-41 | Conditional wall-clock bound composed with physical-state service, assuming real committed events and maximum inter-step delay | True event timestamps, actual event scheduling and an independently demonstrated upper latency bound |
| IR-43–IR-44 | A non-goal belief stutter obstructs strict all-step progress; a finite stall-count budget restores a conditional bounded-service implication | Actual verified stall-frequency bound, physical progress-event classifier and faithful event completion |
| IR-46–IR-47 | Source-level clocked bounded-stall service and concrete two-progress/one-stall synthetic witness | Verified physical event completion, real stall budget, accurate timestamps and delivered actual service |
| IR-49 | Source-level proof of actual modeled physical endpoint safe, served and clock-bounded under observation-history policy with finite stalls | Complete real-world sensing and channels, stall/scheduler bounds, observed effect delivery and continuing-particular semantics |
| IR-51–IR-54 | Every represented microstep safe under guards; sample-to-unsampled upper envelope; bounded age for irregular sampling; physical application-time sensor/actuator guard | Actual continuous causal microstep coverage, calibrated rise/sensor age bounds and final actuator atomicity |
| IR-56 | The original unbounded `UPTExist.chainKey` cannot admit an everywhere-faithful finite retention-profile quotient | Exact original full-feasible space and applicable non-finite maximality/selection arguments |
| IR-57 | Uniform per-instance physical effect margin from bounded consequential channel count and calibrated per-channel effects, joined to IR-2/53/54 | Empirical exhaustive channel coverage, uniform physical degree/impact caps and genuine final-effect authorization |
| IR-66 | Infinite full-feasible inclusion-maximal retention and one-stage original lex order for countably indexed finite-obstruction worlds; derives nonempty chain-union upper bounds; real incompatible-pair example and original-chain countercontrol | Whether original physical/X3 feasible outcomes satisfy finitary obstruction character; actual history/priority semantics, multi-stage lex order and operational realizability |
| IR-67 | Original finite-list lexicographic maximality for unrestricted infinite stagewise retention outcomes when finite-obstruction constraints are independent; separate direct coupled two-stage infinite example and counterexample to independent maxima | Derive generic coupled original full-feasible infinite-order existence and real X3 physical stage constraints, historical freedom semantics and implemented selection |
| IR-68 | General full-feasible infinite two-stage original lexicographic maximum for arbitrary **coupled finite forbidden patterns** across both priority layers, via two successive infinite greedy phases | Actual physical X3 finite-obstruction character, third/higher coupled priorities, semantic completeness, computable selection and physical realization |
| IR-69 | Derive (not postulate) finite forbidden patterns from **nonnegative additive resource capacities and finite causal conflicts**; source-level original two-priority maximality and a rigorous non-finitary infinite-tail counterexample | Show original physical X3 feasibility is exhausted by these or other finite-witness constraints, with measured costs, complete routes, historical semantics and executable realization |
| IR-70 | Exact iff: arbitrary two-priority feasible predicate has finite forbidden representation iff every infeasibility has a finite forcing witness; source-level original-order maximality from this condition and positive-duty counterexample | Establish for actual original physical/X3 feasibility or derive a broader theory respecting mandatory positive protection, infinite-tail constraints and genuine implementation |
| IR-71 | Construct infinite full-feasible two-stage maximal extension **from a feasible mandatory retention baseline**, retaining positive original duties through cross-priority finite conflicts and bounded resources; full predicate is not downward-closed | Existence/physical realizability of actual mandatory X3 baseline, historical semantics, source-complete constraints and infinite-tail obligations |
| IR-72 | Infinite discrete physical-history safety from **all** finite robust viability horizons and bounded two-action choice, deriving one common policy for every disturbance stream; infinite-action counterexample | Actual archived nine-transition plant refinement, finite/compact physically valid action set, uniform all-horizon viability derived from budgets and faults, real historical continuation, service/liveness and original X3 full maximality |
| IR-73 | Finite true-history prefix witnesses for missed bounded service deadlines and safety threshold breaches; unbounded eventual-service non-refutability counterexample | Actual sensor/true-state refinement, physical deadline and verified service receipts, preservation of all original X3 historical-continuation and unbounded liveness clauses |
| IR-74 | Finite positive-cost energy bank fails all-horizon robust viability; **uniform paid replenishment** derives robust reserve invariance, all horizons and one infinite safe model policy, with adverse-disturbance counterexample | Physically warranted uniform supply/maintenance/energy consumption, actual continuing service, historical identity, full original X3 state refinement and freedoms |
| IR-77 | **Executable typed telemetry checker** with structural Lean soundness, initial-state/tick/energy-balance/descent validation, calibration-error margin transfer and forged/missing-data negative tests | Independently verified JSON decoding and authenticated sensor-to-true-physics correspondence, timestamp/interval completeness, real calibration, indefinite robust policy, original X3 historical service/freedom predicates |
| IR-78 | End-to-end **Lean JSON-text decoder and certified typed checker** with executable CLI and CI raw-file pass/fail fixtures; parser-to-record validity and reserve soundness proved source-level | Authenticated physical sensor/clock/provenance, canonical duplicate-field protection, real unit calibration/inter-sample effects, all-horizon robust physical X3 viability and full freedom/continuation semantics |
| IR-79 | Derived bounded fault→detection→effect-fence→quiescence latency and all-tick conditional physical-effect safety margin; imported IR-32 fully drained barrier plus bypass, prior-breach and absorbing-no-service hostile controls | Real alarm visibility and response time, physical effect-path completeness, stored-energy/flyback, disturbance envelope, authenticated measurement and live X3 positive continuation |
| IR-80 | Necessary full magnetic/kinetic energy clamp capacity and leak/remnant obstruction, energy≠peak-voltage countermodel, correlated sensor agreement failure, conditional one-sound-channel margin and dual-watchdog modeled fail-closed logic | Actual L/I/stored-energy and dynamic voltage/thermal/mechanical envelopes, common-mode independence, complete causal channels, continuous-time dynamics and original X3 continuity/freedom |
| IR-75 | Original-X3 conditional area-cut traffic theorem from an independently warranted **uniform new-information recovery converse**, decoder side-info ledger, per-edge capacity and paid-power floor; hostile large-cut and side-information countermodels | Derive the compulsory physical information-demand scaling from unreduced BCRD, prove complete decoder/recovery channel inventory and calibrate true edge power/window |
| IR-76 | Original X3 **unit-speed outward packet recency** theorem, complete-access-source conditional cutoff, stationary-stream and retained-historical-copy countermodels | Derive genuine BCRD bath outgoing transport/chirality, true complete decoder input inventory and quantum causal data-processing factorization; no general correlation decay to work gap yet |

**Logical form:** the Lean kernel establishes that the stated conclusions
follow from the stated hypotheses. `#print axioms` and the transitive
audit do **not** mean there are no load-bearing theorem parameters.
`propext`, `Classical.choice` and `Quot.sound` are the explicit
permitted foundational axioms in the bridge audit.

The shared mainline builds and source-level reviewer notes make the
formal work more reproducible; publication here does not represent
independent human refereeing or scientific validation.


## Finite-profile feasibility audit

`IRFiniteProfileObstruction` (IR-56) additionally proves **no finite complete faithful quotient exists** for the original infinite `UPTExist.chainKey`: coverage and fidelity cannot be presumed for arbitrary infinite families. This does not undermine IRProfileAudit's conditional validity, but requires a different full-feasible argument in non-finitely-quotientable models.\n\nThe separate `PhysicalBridges.IRProfileAudit` source-level module
shows how `IRSelectedMaximality.NoExcludedImprover` can be **derived**
from a finite catalogue of verified retention profiles even when the
original full feasible outcome type is infinite. The result requires
complete profile *coverage*, exact fidelity of all original stagewise
retention facts, and an explicit obstruction certificate for each
profile. A synthetic infinite-outcome example and hostile controls
exhibit why incomplete or unfaithful profiles are unsafe. **No
real-world profile coverage or historical retention fidelity is
established by the example.** See
[IR-PROFILE-FEASIBILITY-AUDIT.md](IR-PROFILE-FEASIBILITY-AUDIT.md).

## Physical/semantic assurance is tracked explicitly

See [assurance-ledger.json](assurance-ledger.json) and
[IR27-ASSURANCE-LEDGER.md](IR27-ASSURANCE-LEDGER.md).
Physical instrument deployment, residual effect calibration,
actual sensor and clock bounds, original feasible-outcome coverage,
and historical subject continuity remain `DECLARED` or `OPEN`.
The claim checker validates the evidence *format*, not its authenticity.

### The next testable tasks

1. Select and document **one concrete instrument** and its finite
   controller, actuator, sensor and environment interfaces.
2. Construct an independently auditable list of all physical causal
   channels, including bypass, latent and pre-authorized deferred
   effects; instrument and challenge each claimed bound.
3. Measure timings, fault envelopes, actuator quiescence and physical
   residuals, and show how each measured fact maps to a specific
   named Lean hypothesis.
4. Independently review the provenance/continuation semantics and
   the original full feasible-outcome claims. Neither follows from
   correct replay of event labels.

For detailed theorem-by-theorem comments, browse
`PhysicalBridges/*.lean` and the `IR*-*.md` bridge notes.

To contribute, provide an exact failing trace, an omitted real-world
channel, a proof dependency or a falsifying feasible outcome and open
a GitHub issue or PR. No sensational claims or unsupported extrapolation
are needed.
