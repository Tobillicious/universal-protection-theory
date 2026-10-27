# Independent review request: Snuffy physical-interface bridges

**27 October 2026 • Public working research track • Not peer reviewed**

This repository contains formalized *conditional* implications about
protection, constrained control, recording, and finite histories.
Lean compilation and the axiom audit validate formal consequences
under the written hypotheses. They do not demonstrate a deployed
physical system or subjective continuation, and they do not establish
that every proposed preservation freedom is physically jointly possible.

## Where adversarial reviewers can contribute

**Formal methods** — Independently rerun the pinned Lean module suite;
inspect every theorem signature for vacuity, hidden cofinality,
nonempty-set and effect-coverage premises; verify the scope of
`ControllerFence`, `UPTFence`, and `UPTExistence` source imports.

**Control and distributed systems** — Attack the separation between
log finality and actuator finality. Examine queued effects before and
after hold, stale acknowledgements, common-mode failure,
partial observability, atomic check-at-apply and rollback limitations.

**Physical measurement** — Identify one concrete instrument and
bound all real consequential channels, including ambient drift,
external coupling, latent effects and unmetered residuals. A closed
Lean data type is not evidence that the world has no other channels.

**Philosophy and semantics** — Test the link between a faithful
event record and the continuing particular. A replayable coded
history and immutable origin ID do not independently prove
subjective identity or persistence.

**Safety versus delivered service** — A controller can hold forever without delivering freedom or service. Challenge the IR-37/38 progress-rank premises, IR-39 synthetic example, and IR-41 real-time bound. A limit in mathematical steps does not establish a real-time deadline unless physical event execution, timestamp fidelity and maximum delay have been verified.

**Adversarial stalling versus bounded fairness** — IR-43 formally refutes a guaranteed all-disturbance service rank if an unserved belief can remain unchanged; IR-44 proves a *different, trace-relative* bounded-service result if a justified maximum number of nonproductive events exists. Seek real physical stalled-event histories, invalid event classifiers and unbounded recovery/failover delays. No all-night or next-morning real-world outcome follows from a count bound alone.

**Original feasibility/maximality** — Test the full originally
defined feasible set, faithfulness of retention profiles, and whether
a physical implementation realizes the selected outcome without
quietly excluding better feasible options.

## How to report a result

Please open an issue with: (1) a precise target theorem or premise,
(2) a smallest counterexample or verification procedure, (3) source
paths/commit SHA, and (4) a proposed disposition:
formal error, uncovered physical channel, semantic gap, documented
assumption, or independently supported evidence.

The [assurance ledger](evidence/physical-bridges/assurance-ledger.json)
currently contains NO purported empirical proof that the complete
physical or historical-preservation conditions have been met.
Independent review is encouraged precisely because those
obligations are substantive.

These are research artifacts, not emergency alerts or operational
proof of any imminent threat.
