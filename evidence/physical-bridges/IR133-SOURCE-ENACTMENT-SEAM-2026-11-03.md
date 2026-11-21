# IR-133: Readout -> captured event -> source generator -> enacted action

Date: 2026-11-03. Source-level conditional Lean theorem, NOT proof of actual BCRD physical-source completeness or installed X3.

Parent draft: PR #227. Inherited modules: IR125 (real transition separation and captured event), IR123 (complete physical event trace and calibrated burden), Oct10 (actual-generator particular continuation), Cathedral cut guardian (common safe action and mandatory actual mediation), IR98 (unchanged full-feasible two-priority maximality).

## What this strengthens

PR #227 needed two separate contracts:
1. EventToGenerator: every real transition has a witness, and every witness corresponds to a genuine source generator.
2. hEnacted: every real transition is an admitted successor under the policy action selected from the actual observation.

IR-133 creates a SOURCE-SEAM certificate factoring these into independently testable physical fields. The structure SourceEnactmentReceipt requires:

| Field | Independently required proof | Why it cannot be inferred from other fields |
|---|---|---|
| separates | Four observable projections distinguish every actually relevant physical step, modulo independently justified samePhysical equivalence | Hidden fifth coordinate changes despite unchanged readouts |
| dagCaptured | Every actual DAG readout change emits a durable causal event | Detectable event can remain unlogged |
| fluxCaptured | Every actual flux change emits a durable causal event | Energy redistribution can escape net flux |
| gaugeCaptured | Every actual gauge readout change emits a durable causal event | Gauge constraints alone do not imply observability |
| actuatorCaptured | Every actual actuation readout change emits a durable causal event | Actuation may bypass a cooperative file lock |
| neutralCaptured | Every real equivalence/no-op step also has a captured event if the claim says EVERY step | No-op path can lack a record |
| authenticGenerator | Every captured physical transition has a genuine independently sourced generator witness | Event labels must not be post-hoc source names |
| enforcedAction | Every captured real transition is allowed by the actual action selected by the controller observation | A recorded bypass is not automatically blocked or mediated |

The theorem captured_event_for_every_real_transition is an application of the actual IR125.full_step_capture_from_four_channels lemma. The theorem captured_events_supply_both_load_bearing_interfaces derives BOTH source coverage and the enacted-action contract needed by PR #227. The theorem captured_source_run_retains_original_order_protections applies those results to the SAME real physical execution, leaving all original X3 semantic and feasible-family obligations as explicit antecedents.

An additional countermodel captured_event_does_not_imply_enacted_policy_action gives a fully captured physical event that is nevertheless NOT admitted by the selected source policy action. This demonstrates why physical mediation needs its own independent proof.

## Boundaries and next physical tests

These are Lean implications, not claims that the certificate fields hold in nature. The four readouts are not proved complete for physical BCRD; all physically possible bypass, latent, environmental, third-party or unrepresented interactions remain potential counterexamples. The samePhysical equivalence must not erase real changes to subject activity, consent or future options.

A cooperative software journal lock with a clean hold acknowledgement does not certify independent OS/hardware actuation authority. Environmental disturbance effects may appear as possible successors under a chosen policy; this is not the assertion that the policy causes the environment.

A future external audit would need a well-defined physical plant, independent sensor and action authority, calibrated effect measurements, complete challenge and fault-injection ingress inventory, real event/source labels and a measured final-application-time linearization witness. Explicitly test direct file writes, clock/epoch rollback, delayed queue release, latent changes, outside actuators and power-loss paths. An unsupported fifth cause must keep the global physical protection claim OPEN.

The companion machine-readable source-enactment-obligations.json lists all eight subordinate external-physical requirements. The audit validator rejects missing/renamed fields or unsupported promotion but cannot itself verify hardware.

X3, canonical manuscripts, commissioning and author publishing decisions unchanged.


## Synthetic hostile fixture: independent source capture and authorization tables

The additional check_ir133_source_enactment.py is an executable finite input test of the same eight IR-133 certificate conditions. It uses independently written real-step, sensor, captured-event, source-generator and actual selected policy-action tables, with no inference from a log to either authority or generator.

The positive four-state example checks the complete certificate. Six mutants must each be REJECTED:
1. A hidden physical fifth state with identical four projections (readout-separation failure).
2. A changed real flux readout with no emitted event (capture failure).
3. An unrecorded physically neutral step (neutral-event failure).
4. A captured event with no authentic source-generator correspondence (source-label failure).
5. A recorded and authenticated physical event that bypassed the selected action relation (enactment failure).
6. A valid source action not selected by the controller's actual observation (selected-policy failure).

The test is synthetic; it does not provide a physically complete transition inventory or independent hardware authority. It protects the formal integration against accidentally accepting precisely these six known unsound shortcuts. Pinned CI runs the test with the Lean kernel and the documentary promotion gate.
