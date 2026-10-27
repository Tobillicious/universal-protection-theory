# Physical-bridge independent instrument verification protocol (working)

**Purpose:** provide a falsifiable, ethics-aware engineering test plan for
one specifically chosen instrument. The Lean theorems are conditional and
the current repo does **not** establish a working, physically validated
universal preservation plant, survival guarantee or historical/subjective
identity continuity.

This document is a **test specification, not a completed experiment**.
No field observations or real devices are claimed.

## 1. Specify one exact bounded device before interpreting any proof

Record an exact physical system identifier, revision, firmware/RTL hash,
sensor and actuator topology, environmental ranges, clock source,
authority/replica roster, failover mechanism and physical effect boundary.
Provide diagrams of the actual hardware and the test fixture. Clearly
state what is *inside* and *outside* the causal model, including power,
heat, mechanical motion, externally coupled systems and uncontrollable
environmental processes.

Never test unproven protection on living subjects, and do not perform
intrusive tests on systems you do not own or have explicit authorization
to assess. Obtain appropriate institutional safety/ethics approval for
any study affecting people, animals, clinical facilities or critical
infrastructure.

## 2. Per-channel inventory and physical residuals — IR-15/23/24/25

List each effect-producing path: authorized writes; in-flight commands;
pre-authorized latent effects; network retries; reboot replay; direct
physical bypass; background drift; future-persisting effects. Measure a
physically consequential quantity in explicit units and direction, not a
CPU cost or bookkeeping proxy. For each path independently challenge:
(1) event capture completeness, (2) physically worst-case impact,
(3) delayed effects, (4) discrepancy between charge and effect, and
(5) whether an unmetered route remains.

**Adversarial pass criterion:** the physical effect-to-charge inequality
holds under all *specified tested* cases with a justified bound that
covers the intended operating envelope. Samples alone do not prove
universal upper bounds absent supporting physical theory, confidence
model and independently verified coverage. Otherwise record **OPEN**.

## 3. Physical fence, quiescence and recovery — IR-29–36

Reproduce, in a **controlled laboratory**, an accepted effect queued
before a hold; its transit through each in-flight, actuator and final
apply queue; a hold exactly at each transition boundary; crash/restart
and failover at every relevant instruction/commit boundary.

Test BOTH physical routes separately:

- **Complete quiescence:** close admissions atomically and verify all
  in-flight and actuator pending queues are drained/cancelled before
  issuing a current quiescence acknowledgment.
- **Final apply-time fence:** verify all old-token physical effects are
  rejected at their actual final commit points and that the floor
  remains durably monotone across every relevant reboot/replica path.

Require an observed counterexample to the intentionally broken
variants (stale ack; volatile-only epoch; admission-only check;
unfenced secondary device), and verify those exact attacks cannot
succeed in the claimed corrected implementation. Preserve signed raw
logs and video/instrument traces with device revision, units and
synchronization error. A green CI build of synthetic code does not
count as physical evidence.

## 4. Continuous-time sampling — IR-1R/18/41

Specify sensor calibration and error bars, sampling interval,
worst-case detection latency, actuator effect latency, and upper
*inter-step* time bounds. Monitor the physical trajectory between
two logged endpoints: checking only the endpoints can miss a dangerous
transient. Build a stated worst-case or credible interval with explicit
assumptions and measurement resolution.

**Critical:** a bound measured in controller steps must not be stated
as a real-world deadline without trustworthy timestamps and
independent evidence that each required physical event completes
within its alleged maximum latency, including stalls and failures.

## 5. Partial observability and service — IR-13/19/37–41

Define physical states, disturbance domain, observation map, initial
belief covering the actual state, admissible actions and protected
predicate. Try to falsify every possible-state update, not merely the
observed trace. Seek two physical states with the same observation
requiring incompatible safe actions.

Separate *safety* from actual beneficial *service*. Show that the
service predicate is physically meaningful and absorbing under the
model; validate a strictly decreasing rank across **every** modeled
disturbance until service or document a weaker fairness assumption.
An indefinite safe hold with no delivery is not a service result.

## 6. Historical provenance and continuing particulars — IR-26/28

Test append-only record durability, replay integrity, origin-label
fidelity, encoder injectivity or correct identity detection and
authentic quorum membership. Distinguish those from the unproven
semantic identification of a physical subject across intervention.
No equality of recorded bit strings should be marketed as proof of
subjective continuity.

## 7. Evidence, independence and pass/fail discipline

For each physical claim attach: source data URI, SHA256, physical unit,
test procedure, instrument revision, method, date, uncertainty model,
failure-case coverage and identifiable independent reviewer. Do not
promote an untested field to `MEASURED` or `VALIDATED`.

A report must use one of:
- `OPEN` (not evaluated), `FAILED` (counterexample found),
- `LIMITED` (some controlled tests, insufficent for general bound),
- `MEASURED` (evidence-backed measurement within stated range).

The label `MEASURED` is **not** an unrestricted physical theorem or
a claim of independent replication. A broader safety claim must
include a complete hypothesis-to-measurement map and explicit
model/environment applicability limits.

An example unmeasured template is in
[`instrument-evidence-template.json`](instrument-evidence-template.json).
The CI validator deliberately prevents false completion/validation
from missing raw evidence, missing unit ranges, or fictional device
references. The validator checks structure only, never scientific
truthfulness.

### Highest-priority falsification attempts

1. One hidden consequential physical channel invalidates the global
   effect budget.
2. One effect already physically committed invalidates a supposed
   cancellable hold.
3. One in-flight command or stale failover device invalidates a
   fleet-wide quiescence claim.
4. One hidden state with no common safe action invalidates an
   observation-only service policy.
5. One clock stall invalidates a real-time service deadline.
6. One unfaithful encoder or discontinuous physical history invalidates
   an overstrong identity interpretation.

**The appropriate public description remains: independently
reproducible conditional formal research with unverified physical
and semantic interface premises.**
