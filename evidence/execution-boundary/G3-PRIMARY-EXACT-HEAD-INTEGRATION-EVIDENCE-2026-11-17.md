# G3 primary integration evidence — 2026-11-17

**Status: R5 bounded CI PASS; combined G3 acceptance HOLD.** Non-deploying draft. No independent release decision. This document is an audit ledger, not a new verifier, policy or effect authority.

## Frozen input and exact receipts

- Base integration code: PR #615 head `be1b66e49a9eed897a7d175ed0896b17d6ec1d48`, stacked over #614 `d67b38f4f679e5c861c89de76a45e2b132718031` and #613/#612/#610/#597/#596.
- #614 failed run 44013859280: 903 tests, 4 failures + 3 errors, due to the `koru_seccomp_fd_receive_fence.py` Git blob pin mismatch. The syscall trace step was skipped. This was **not** evidence of a ptrace/SO_PEERCRED race.
- #615 updates only the reviewed `koru_pinned_security_dependencies.py` fingerprint: `a02e7522140641503e0d8638c93eb43da2c7d0f7` → `5ae5d10ed095e84a7c96df40a0045cc396fbe435`; it does not disable source freezing.
- #615 exact-head workflow run **44014769932**, job **133809932977**: completed success; **903 tests OK**, then syscall-trace qualification completed success. Observed **3 confined children** (trace PIDs 4404, 4406, 4411). This is bounded observed behavior, **not** complete syscall mediation or full effect-path inventory.
- Other #615 exact-head workflows completed success (6/6 total): G3 kernel identity threat-model tests 44014769922; Physical bridge proofs 44014769952; Full-law agent entrypoint integrity 44014769950; G3 cross-UID signed HOLD 44014769932; Koru shadow verifier 44014769823; UPT summit publication packet 44014769825.
- R5 observed-syscall artifact **14298487541**, uploaded ZIP SHA-256 `9b1ac3e92d661b2c67a8719ce976f40b447da8acc8f40964f76fef88c54e25f0`.
- Runtime inventory artifact **14298687047**, uploaded ZIP SHA-256 `df8cf3b82e6dfa49b84c3ded9e010d6152f5be6efb077baaf6a502f305836158`.
- CI links: https://github.com/Tobillicious/universal-protection-theory/actions/runs/44014769932 and https://github.com/Tobillicious/universal-protection-theory/pull/615 .
- Those artifact digests are GitHub-uploaded **ZIP** digests, not an independently verified signature or external custody receipt. Independent download, inspection and replay remain to be done at this document branch's eventual commit.

## R4 source reconciliation (already in #615 ancestry)

- `koru_operator_checkpoint_custodian.py` at #614 was source-identical to #606's implementation, including `OperatorManagedWitnessReads`.
- `koru_operator_checkpoint_recovery.py` at #614 was source-identical to #602's implementation, including the post-recovery independently challenged nonce/recheck.
- #615 Linux 903-test suite contains relevant signed-history, operator rollback, dual mTLS, bound-reader and post-recovery-recheck negative controls; successful tests were observed in the job log. Do **not** cherry-pick #602/#606 blindly or duplicate their code.
- **Open:** independent off-host administrator/storage/key separation; hostile-host rollback with externally surviving checkpoint; independent historical custody; effect-stop availability. Same-host positive tests do not establish these.
- Historical custody remains `authorizes_effect: false`; HOLD/effect transaction authority stays singular.

## R6 unchanged theorem interface

Existing `evidence/physical-bridges/PhysicalBridges/ExternalJointEffectRefinement.lean` is unchanged.
`AllActualEffectsRefineJoint J realStep read` requires a separately defined `realStep`, faithful `read` and proof for **every actual in-scope effect**: **hCoverage OPEN**. No complete independently measured actuator/effect-path inventory or non-vacuous faithful joint-state map is submitted here.
`AuthenticSixReflections` fields require real owed subjects and independent event/subject evidence:

| Field | Model / partial source | Authentic actual-subject witness |
|---|---|---|
| `historicalContinuity` | historical preservation and journal/restart machinery | **OPEN**: same-particular continuity for every owed actual event |
| `authorization` | signed rights, withdrawal/HOLD research | **OPEN**: genuine current informed/revocable authority or justified substitute |
| `freedom` | G2/original-six model | **OPEN**: feasible alternatives and absence of coercion |
| `restraint` | HOLD/least-effect model | **OPEN**: subject-specific proportional restriction |
| `maximality` | staged original-six model | **OPEN**: authentic bounded comparison with feasible alternatives |
| `provenance` | signatures, event digests, journals | **OPEN**: independently authenticated source→decision→actual effect chain |

The copied Agent 4 crosswalk from #588 is unchanged source. It does not establish these obligations, consent or `hCoverage`.

## R7 acceptance and stop conditions

**R5 limited CI result: PASS** on #615 head, with all six workflow conclusions and three observed child traces. Not a claim of exhaustive mediation.

**Combined G3: HOLD.** This branch adds documentary evidence only. A new **branch-head SHA** must be frozen and its own required CI checked before accepting even this combined documentation candidate; ancestor #615 CI is not silently inherited. No externally independently administered R4 custody, complete effect-path closure, R6 actual-subject witnesses, independent R7 reviewer replay or scope-limited approval is yet evidenced.

Next: primary integrator independently compare branch head with #615 (only copied crosswalk + this ledger), run exact-head workflows, download/inspect trace and runtime artifact contents, independently confirm one live authorized connection and one expected positive/two denied outcomes, test alternate effect paths, then obtain off-host custody/actual-subject evidence if the claim requires it. Do not fabricate real effects or predeclare PASS.

No new mathematics, protection authority, source weakening, merge or deployment.
