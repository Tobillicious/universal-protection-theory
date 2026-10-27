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
