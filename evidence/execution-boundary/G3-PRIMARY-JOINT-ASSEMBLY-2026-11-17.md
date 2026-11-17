# G3 primary-agent joint assembly checkpoint — 17 November 2026

**Draft, research-only. No merge, deployment, competing HOLD authority, or physical/universal protection claim.**

## Immutable source and parent

- Base: PR #615, `be1b66e49a9eed897a7d175ed0896b17d6ec1d48`. No executable change to R5 in this integration branch.
- R5 ancestry: #597 → #608/#609 → #610 → #612 → #613 → #614 → #615 (some are reconciled fixes, not a claim all PR heads merged).
- R4 source/recovery: existing #559–#562, #584–#591, #602–#604, #606. The parent already contains `koru_operator_checkpoint_custodian.py`, `OperatorManagedWitnessReads`, and `test_koru_operator_post_recovery_recheck.py`; do not duplicate/rewrite them.
- R6 documentation: recover **unchanged** Agent 4 PR #588 crosswalk from Git blob `249f2a651bbd07bbcf4ca747beac94ab39af6bb1`, with no modification to original-six theorem sources or definitions.
- Authoritative R6 theorem source remains `evidence/physical-bridges/PhysicalBridges/ExternalJointEffectRefinement.lean` on main, Git blob `6f7ce25fd3c5fe5646779466c03ef24b6c703303`. It was not present/retrievable on the R5 head; reconciling the entire Lean source/import ancestry without weakening any theorem is a separate exact-source acceptance requirement.

## Verified parent execution

- PR #615 exact-head CI: **6/6 successful**.
- Workflow `44014769932`, `disposable-linux`: **903 unit tests passed**, plus a separate two-test phase passing.
- R5 trace qualification: **3 fixed-child traces qualified**, observational and non-exhaustive.
- Archived artifacts: `g3-r5-observed-syscalls` (artifact ID `14298487541`); `g3-runtime-inventory` (artifact ID `14298687047`). Review archive contents/digests independently before treating them as external custody receipts.
- Do not transfer this parent-head CI result to this integration commit. Run all six workflows on the final exact head.

## Release-obligation matrix (must not be auto-checked from green CI)

| Gate | Status | Evidence still required |
| --- | --- | --- |
| R4 custody | Local protocol and regressions present | Independently administered, off-host monotonic custody; separate administrative control; witnessed controlled rollback and outage response |
| R5 bounded confinement | Parent CI green; 3 observed traces | Independent source/trace review, effect path and FD coverage, actual authority instance binding, no unmediated effects in a declared scope |
| R6 hCoverage | OPEN | Independently defined `realStep`, total faithful `read`, exhaustive in-scope before/after actual-effect observations and bypass inventory |
| R6 hMeaning | OPEN, six separate fields | Genuine owed-subject evidence for historicalContinuity, authorization, freedom, restraint, maximality, provenance |
| R7 acceptance | OPEN | Frozen combined SHA, exact-head CI, independent hostile controls, external receipt/custody digests and signed reviewer decision |

**Scope:** Linux fixed-marker research fixture. Historical checkpoint reading never grants effect authority. The existing transactional authority remains sole HOLD/effect decision maker.

**Decision until gates close:** HOLD for release and universal G3. Bounded CI evidence may be reported at its exact tested SHA only.
