# IR-123/124 physical-event coverage — independent validation protocol
**Working referee specification · 28 October 2026 · NOT a physical certificate**

## Purpose and scope

The source-level results now establish:

- **IR-121:** finite-trace physical-burden proxy under separately metered residual effects, conserved per-particular escrow, cumulative duties, executable required options and faithful records.
- **IR-122:** source-event witness plus independently sound physical replay, per-event bound, landed-count reconciliation and residual-spend reconciliation implies IR-121's metered-harm bound.
- **IR-123:** a genuinely independently specified real-step relation with *every step matched by an event witness* yields a complete **finite** event list. Per-step calibrated effect bounds and endpoint correspondence then produce the IR-122 physical-event certificate.
- **IR-124:** the IR-123 one-step coverage obligation is proved for a specified four-cause toy plant (actuator, environmental, latent, bypass). A fifth unclassified physical cause invalidates that coverage. The witness tracks causal kind and physical impact, not only an equal numeric effect.

None establishes that any real installation, any actual subject, or the entire BCRD physical domain has only those events. **A complete model alphabet is not a complete physics inventory.** The actual instrument, sensors, measured effects, and physical system of interest have not been identified or independently audited in this document.

## Minimum installation dossier

Before evaluating a physical installation, specify and independently record:

1. **Scope and protected process.** Physical installation boundary; actual subsystems and external interfaces; target hazard and units (e.g., device temperature, delivered electrical energy, mechanical excursion); finite protected time window; residual tail; explicitly excluded processes. Do not present one engineering hazard proxy as same-subject continuity.
2. **Independent true-state readout.** Sensor modality, calibration chain, uncertainty interval, failure modes, sampling interval, tamper model, calibration dates and an independent way to detect sensor common-mode failures. An internally generated source log is not an independent physical measurement.
3. **Real transition relation.** A separately developed physical plant model or a defensible empirical operational envelope for events including actuator commands, actuator in-flight/pending deliveries, environmental influences, latent/stored-energy release and bypass paths. Every non-negligible channel must be within the boundary or have a justified quantified residual bound.
4. **Causal event witness.** Every physically consequential transition must be linked to a causally attributable physical event with provenance, not post hoc fitted to a known type merely because its final scalar magnitude matches. A genuine unknown cause must produce `unclassified` and fail certification, not a convenient surrogate source label.
5. **Timestamps and consistency.** Independently synchronized monotonic clock and bounded skew; actual physical apply time; controller fence/close time; arrival/delivery times; sample times; durable journal commit and rollback/replay protection.
6. **Event-by-event quantities.** For each physical event and every specified protected hazard: independent `trueEffect` upper bound and common units; declared source `channel.charge`; `residual`; `landed` delta; `spent` delta. Physical calibration and measurement uncertainty must be included in the inequality.

## Source theorem to evidence map

| Checked premise | Required independent evidence | Reject when |
|---|---|---|
| IR-123 `hCoverage` | Real physical transition taxonomy, independent event capture, observed causal event per consequential transition, specified boundary, explicit positive evidence for no omitted channels within scope | A real step occurs without a valid witness; the sensor cannot distinguish causes and cannot supply a conservative ambiguity certificate |
| IR-123 `hCalibrated` | Per-event physical effect ceiling under stated conditions and uncertainties, independently checked against plant readout | Actual measured effect exceeds declared ceiling or calibration provenance cannot be established |
| IR-123 `hInitialPhysical` and `hFinalPhysical` | Independent pre/post physical hazard readings with uncertainty; a documented numerical relation to installed state | Source snapshot is trusted without comparison to the real plant |
| IR-122 `eventChargeSound` | Actual effect <= source charge + residual, eventwise across all witnessed causes | An effect is assigned zero charge and zero residual merely because it is absent from the digital source |
| IR-122 `modeledChargePaid` | Exact joined source-delivery receipt; every charged physical event reconciled to IR-32 `landed` increase | Sum of charged event effects exceeds landed delta |
| IR-122 `residualsDebited` | Independently held residual metering/escrow receipt; all non-source effects settled into monotonically increasing `spent` | Residual effects exceed the newly debited escrow |
| IR-121 `escrowConserved` | Independent attestations of initial escrow plus current free/reserved/spent totals; no free replenishment | Escrow balance changes without a separately authorized source |
| IR-121 `ReservedGuard` | Per-particular burden proxy + both committed queues + unspent escrow <= certified ceiling; required capabilities actually executable | One owed particular is omitted, a new entrant lacks reserve, or an executable required option is only nominal |
| IR-119 `FaithfulAll` | Source history and witness-record provenance bound to actual event sequence; anti-replay, anti-fabrication and origin authenticity | A copied/replayed identifier or record is substituted for the actual continuing process |

## Safe, bounded test matrix for a designated installation

This is a **test design**, not instructions to perform dangerous electrical, biological or AI-system interventions. Use isolated low-energy simulators or bench environments with independently established limits.

- **Normal modeled delivery:** a known source command moves from in-flight through pending to landed. Verify timestamp/order, logged delivery and independent physical effect agreement.
- **Already-in-flight closure:** close admission while modeled effects remain in both queues; verify conservation of `landed + inFlight.sum + pending.sum` and bounded late effects (IR-118).
- **Environmental and latent event:** introduce a safe, externally measured and deliberately non-source effect into the selected bench envelope; verify a **positive** independently debited residual, with no fabricated source landed charge (IR-121/124).
- **Bypass challenge:** simulate a separately controlled event not entering the main command gate. It must be independently observed, assigned a causal class or marked `unclassified`, and funded in residual escrow. Otherwise certification FAILS.
- **Unknown-cause challenge:** exercise a safe event intentionally excluded from the proposed event alphabet. A purported universal `PASS` is a failure; the correct result is **unclassified/not certified** with an explicit update to scope and review.
- **Sensor disagreement/common-mode challenge:** impose synthetic sensor bias/clock skew/data loss in the test harness; verify false confidence is not accepted. Two sensors agreeing is not by itself independent calibration (IR-80).
- **Backlog/escrow exhaustion:** simulate residual effects approaching the declared remaining reserve; test that the safety decision cannot continue at a margin it has already spent.
- **Historical witness and capability challenge:** simulate subject-register deletion, copied origin labels, event replay and revoked future options. Verify independent protections catch these logical failure modes (IR-116/119).

### Pass/fail rule

Accept a **finite scoped source-to-physical certificate** only if every prerequisite above has independently inspectable evidence, every included physical step is covered by its real-step witness, all relevant inequalities hold under declared uncertainty, and unknown causes trigger fail-closed *scope rejection*. A machine-readable record can support audit, but cannot demonstrate what an independently unmeasured plant was doing.

Do not extrapolate a finite bench pass to all possible physical causes, unlimited time, real subject identity, or the original maximal universal X3 claim.

## Required release artifacts

Store, with immutable digests and review ownership: installation boundary and scope; calibrated sensor manifest and uncertainty budget; independently derived plant/transition inventory; causal event records including unknowns; apply/arrival/commit timestamp receipts; actuator and escrow ledgers; source-to-physical reconciliation report; replayable finite tests and counterexamples; independent reviewer disposition; remaining external semantic and universal physical premises.

No release or canonical claim should replace **“validated for this finite bounded instrument and stated scope”** with **“universal physical protection proved.”**

## Referee verdict

IR-123/124 constitute a constructive source-model **coverage criterion** plus a hostile failure mode. They advance the formal verification design, but the next empirical step requires a real designated instrument, noncircular independent measurement, and exhaustive evidence relative to an explicitly specified physical transition class. Real same-continuing-subject semantics, consent and maximal X3 freedom remain independent.
