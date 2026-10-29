# Reference faithful-hold runtime

Python standard-library prototype on the measured Mac. The resident, monitor, sink and controller are separate processes.
A full-sync journal precedes each live step; sink-side effect identities support exactly-once recovery.
The application guard serializes HOLD acknowledgement with the actual journal/live step and sink check/commit.
Actual executions are recorded separately from permit grants. Request-to-acknowledgement delay is measured separately.

## Verification on 29 October 2026

- Deterministic suite: 28 cases, 28 real SIGKILLs, all faithful cases pass and all three mutants are caught.
- Forced permit/application pause: the original helper falsely passed with an actual step during HOLD;
  the shared application guard prevents that interleaving after acknowledgement.
- Forced sink integration: an in-flight commit finishes before HOLD acknowledges; subsequent deliveries are refused.
  The direct-write bypass is retained as a negative control.
- Source-bound campaign: 4,000 crash trials (4,771 real SIGKILLs), 0 failures;
  1,000 holds, 0 failures. No actual execution or delivery inside an acknowledged hold.
- Largest observed request-to-acknowledgement delay: 57.54805 ms.
  Observed resumption median 17.66491 ms, maximum 181.06318 ms.
- Per-account one-sided 95% binomial-model bounds: 0.0007486526880178257 and 0.002991249545095331.
  These are trial-distribution intervals, not worst-history conditional-kernel certificates or hard timing bounds.

Rerun with `RT_TMP=<scratch> python3 -B harness.py`, or
`RT_TMP=<scratch> python3 -B campaign.py 4000 1000 20261030 out.json`.
The completed replacement campaign is `../campaign-application-guard-2026-10-29.json` and includes source hashes.
Earlier raw results remain separate history.

## Exact scope

This is a cooperative source prototype. It uses one filesystem principal, trusts complete event reporting,
and represents the external effect by the durable local sink append. A writer with direct filesystem
access can bypass it. Power-loss survival, hostile-process isolation, all physical output paths,
original continuation/freedom semantics and worst-case request-to-acknowledgement bounds are not established
by these process-crash and hold tests. The full theory target remains unchanged.
