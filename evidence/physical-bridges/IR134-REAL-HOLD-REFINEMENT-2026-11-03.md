# IR-134 — Actual physical effects after acknowledged HOLD

Date: 2026-11-03. Status: conditional FINITE physical-refinement theorem and SOURCE-MATCHED SOFTWARE BYPASS NEGATIVE TEST. Full actual no-bypass UPT remains OPEN.
Parent draft stack: PR #229 → #227. Source modules: IRInFlightQuiescence (IR-32), IR133SourceEnactmentSeam.

## 1. Real source-to-physics join

The source IR-32 pipeline is quiescent only when (a) new admission is closed, (b) in-flight commands are drained, AND (c) pending accepted effects are drained. IR-32 proves no further MODELLED delivered effects under any finite future source-command trace.

The missing physical refinement is newly represented by HoldEffectRefinement with two DISTINCT externally warranted premises:

- everyRealStepHasSourceCommand: every real, independently defined physical step is refined by an actual IR-32 source command. It is forbidden to simply define real physics to be the allowed source transition relation.
- physicalEffectAccounted: for every independent actual physical step p→q, the measured true effect obeys

    trueEffect(q) ≤ trueEffect(p)
      + [sourceLanded(q) − sourceLanded(p)] + residual(p,q).

The nonnegative residual must be separately calibrated against all relevant outside effects, errors, environmental channels, direct OS access, unmetered energy, third-party disturbances, and stale queues. It is NOT defined as zero by construction.

The new Lean theorem quiescent_real_step_residual_bound composes IR-32's exact quiescent_step result with these premises. It derives (a) actual-step source quiescence remains true and (b) trueEffect(q) ≤ trueEffect(p)+residual(p,q).

The stronger theorem all_finite_real_hold_traces_no_effect_growth proves that if EVERY actual step has separately certified residual zero, then any finite real trace from a quiescent initial state cannot increase independently measured physical effect. This explicitly requires independent real source coverage, effect metering, all relevant residuals zero, and no unrepresented physical transition.

The countermodel source_barrier_and_command_match_without_effect_accounting_fail proves why a quiescent modeled pipeline and even a valid trivial source command for the real step do NOT prevent independently defined physical effects from increasing. The physical-effect accounting premise is indispensable.

These are finite conditional implications, not a discovery that real physical processes meet them, and not a reduction of original X3 to a source meter.

## 2. Real patched software sink: negative no-bypass test

Reproduction from the full stacked branch:

    python3 evidence/compiled-strongest/installation/pilot/ir134_real_sink_bypass_probe.py

The probe launches the actual patched reference-runtime sink in a separate process and uses only a temporary directory. It authorizes a normal sink write, obtains a cooperative HOLD ACK, and verifies a new cooperative sink delivery is refused. It then launches an entirely independent OS process that writes directly to the SAME temporary sink.log path after that ACK.

Expected outcome: the cooperative sink maintains its own HOLD, but the independent process still changes that sink.log. That is a correctly DETECTED NO-BYPASS FAILURE for the reference SOFTWARE fixture. It establishes neither the safety nor bypassability of unrelated hardware. It does not touch user files or an external system.

## 3. Six original external proof obligations

The new hold-physical-refinement-obligations.json tracks these as OPEN_EXTERNAL:
1. actual real-step inventory and refinement;
2. independent post-effect measurement and complete residual bound;
3. complete admission/in-flight/pending HOLD ACK criterion at final-application time;
4. OS/hardware-enforced non-cooperative effect gate and outside-writer challenge;
5. environment/side-channel/power-loss/clock/batch and queued faults;
6. independent commissioning, no false promotion, and full operational-domain evidence.

Original IR-133 source-authenticity and selected-action enforcement stay OPEN_EXTERNAL; the reference fixture bypass test must never be used to mark them verified. A documentary verifier fails closed if any of these six conditions is renamed, deleted, claimed closed without independent evidence or tied to a forged all-pass result.

## 4. Reconciliation

The theorem strengthens the previously opaque source-to-effect reasoning in #227/#229: the modeled IR-32 hold is not silently treated as total physical cessation. A full physical installation needs an authenticated causal source, true actuation authority and independent calibration to warrant the two new premises. Those are currently absent, as are independent semantic original-X3 correspondence, global feasible rival coverage, infinite-horizon lifetime/progress and the 3D full-family M0–M6 quantum warm start.

No canonical manuscript change, original X3 weakening, publishing, physical deployment, founding or commissioning certification is asserted.
