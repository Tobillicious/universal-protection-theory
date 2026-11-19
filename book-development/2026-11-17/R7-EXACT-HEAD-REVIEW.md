# G3 R7 research evidence — exact-head verification

18 November 2026 · PR #646 · provider and source verification

**The reported research milestone is confirmed at commit `9f9a11f3b14fcddab358e50f0ea8f90b88f02066`: eight successful triggered workflows, 138 combined tests, seven separate receipt regressions, and eight matching selected source digests.** The downloaded receipt preserves the unresolved external gates. Its source also retains a known R5 evidence-parser defect described below.

This review inspected GitHub's metadata, actual CI job log, downloaded artifact, workflow, receipt generator, seven regression tests and all eight fingerprinted source files. It did not rerun the combined local suite.

## Exact candidate and CI record

[PR #646](https://github.com/Tobillicious/universal-protection-theory/pull/646) was open and draft when inspected, with the stated exact head. All eight returned workflow conclusions for that head were completed/successful:

| Workflow | Run ID |
| --- | --- |
| Combined R4–R6 protection evidence replay | 44071329647 |
| R5 strict kernel denial evidence | 44071330306 |
| R6 separate-process effect observation | 44071329864 |
| G3 kernel identity threat-model tests | 44071329849 |
| Physical bridge proofs | 44071329627 |
| Full-law agent entrypoint integrity | 44071329850 |
| Koru shadow verifier | 44071329630 |
| UPT summit packet | 44071329973 |

The combined [run 44071329647](https://github.com/Tobillicious/universal-protection-theory/actions/runs/44071329647), job `133998013405`, records checkout of the full exact SHA. Its log has separate successful summaries for **seven receipt regressions** and **138 combined tests**, followed by the receipt-generation message. These are observed unittest counts, not 145 independent threat scenarios or proofs of physical premises.

The workflow uses the existing R4 rollback, R5 strict-probe/parser and R6 marker-observer tests. It pins Python 3.13 and cryptography 46.0.4, checks the command pipeline's exit status, and uploads the scoped receipt. It does not substitute an earlier candidate's pass.

## Artifact identity and contents

GitHub metadata binds artifact `14323700025`, named `g3-r7-same-head-research-replay`, to the exact combined run and head.

The downloaded ZIP matches its provider-advertised SHA-256:

`734483ea0cc4b0a537d9d5131356f9f21deab58a9dfe962f73b71ce55f02688c`.

Its sole JSON member has SHA-256:

`7871f2a38debf2abfa228a5c6f4d626a9729bb1ce7e9033ea9b87f79dd0c4ec3`.

The record identifies schema `g3-r7-same-head-research-replay-v1`, the correct commit and test count 138. The exact downloaded bytes, provider metadata and relevant CI log are retained in `references/`.

## All eight selected source fingerprints verified

The eight files were fetched independently at the exact Git commit. Every SHA-256 matches the receipt:

- operator checkpoint recovery;
- operator checkpoint custodian;
- operator checkpoint mTLS transport;
- fixed executor;
- seccomp receive/socket fence;
- R5 kernel-denial evidence parser;
- R6 read-only marker observer;
- R6 observer tests.

The filename-to-digest comparison is recorded in `r7-pinned-source-verification.json`; the complete result is `r7-exact-head-verification.json`. This validates the selected byte identities for this artifact. It does not certify the full interpreter, imported dependency closure, execution host, independent administrator or authentic subject interpretation.

## The R5 parser finding applies at this historical receipt pin

The candidate's R5 parser has digest:

`605b089925b5d5049477ca1936b8b7cf5e9454ce44835b0160ed029e2691dab0`.

It is byte-identical to the already reviewed PR #643 head `00dcb4b`. Therefore the existing offline counterexamples apply without rerunning the combined suite: padded/fragmented target-call records can be omitted while the v3 parser returns PASS. The address-kind counterexamples also apply. These are evidence-parser false acceptances, not a demonstrated kernel bypass.

The updated local patch `repairs/pr643-denial-parser-00dcb4b.patch` addresses those cases while retaining the newer target attribution. Its previously completed 18-test receipt is retained. The exact-head CI success and artifact identity are real; neither removes a source defect absent from the tested cases.

The correction was later committed to #643 at `2bf026aee3c344d18c4923c0988c65b368b7cc08` and integrated into #646 at `5142ab3f144eddf746f0e21e7660bbf01474042b`, with six and twelve successful triggered workflows respectively. Those later commits improve the current source. They do not replace the bytes or parser used to produce the older receipt reviewed in this document.

## Receipt claims and their boundary

The receipt correctly keeps all these fields false:

- independently administered R4 custody verified;
- all actual R5 effects covered;
- authentic R6 six-duty reflections verified;
- independent R7 reviewer acceptance;
- production certification;
- universal physical protection;
- effect authorization.

The generator rejects the tested stale/malformed identity, failed/ambiguous log and symlink cases. It is a recorder of observed evidence, not an independent source of administrative truth. Generic calls to it do not themselves prove a clean checkout, causal log-to-execution linkage, full source closure or external acceptance. The pinned-source and provider/log checks above establish additional links for the specific artifact reviewed here.

## Result and next evidence

**Accepted as a bounded research-evidence milestone:** a traceable combined-head CI record and archived receipt, with the selected source identities verified.

**External G3 acceptance remains unresolved.** The existing R4/R6/R7 protocol calls for an independently controlled retained checkpoint, evidence of the real effect inventory, authentic per-subject original-six meanings and an external acceptance decision. A separate CI process or service under the application administrator's rollback control does not supply those facts.

Zelda-Fitzgerald is the selected application/test host. Te Kete's production systems are not designated as a G3 custodian. A two-host rehearsal can use the existing protocol, but actual administrative independence must be evidenced rather than inferred from a second hostname.

The next work reuses the existing external acceptance and custody handoff documents. It does not require another round of the same local protection tests or a new protection architecture. No external operator, authentic subject or acceptance signature is invented by this review.
