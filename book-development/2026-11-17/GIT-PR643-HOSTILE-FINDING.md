# PR #643 hostile finding: a successful syscall record can disappear

17–18 November 2026 · P1 evidence-integrity defect · v4 repair committed

**Current repair checkpoint:** the v4 parser and 18-test source were committed to #643 at `2bf026aee3c344d18c4923c0988c65b368b7cc08` and copied without byte changes into #646 at `5142ab3f144eddf746f0e21e7660bbf01474042b`. All six triggered workflows succeeded at the first head; all twelve succeeded at the integrated head. This supersedes the description of the correction as merely local. Historical observations and artifact limitations below retain their original pins. No actual kernel bypass or universal protection certification is inferred.

**18 November follow-up:** PR #643 advanced to `00dcb4b062e0e26816bdef1053bc4860ac343060`. Its v3 observer improves target attribution, but the padded/fragmented-call false PASS still reproduces. Two additional controls show pathname/abstract address labels can be swapped while passing. The updated local patch is `repairs/pr643-denial-parser-00dcb4b.patch`; it preserves target attribution, fails closed on ambiguous target records, distinguishes address kinds, and advances the schema to v4. All 12 existing and six added tests pass. `r5-parser-hostile-00dcb4b-receipt.json` and `r5-parser-repair-00dcb4b-receipt.txt` record that follow-up. The original v2 finding below is retained at its original source pin.

**Affected revision:** `15251e9da6d8c4d5c956f25bf1f90feaf51697d5`, draft [PR #643](https://github.com/Tobillicious/universal-protection-theory/pull/643).

**Affected source:** [koru_r5_kernel_denial_evidence.py](https://github.com/Tobillicious/universal-protection-theory/blob/15251e9da6d8c4d5c956f25bf1f90feaf51697d5/evidence/execution-boundary/koru_r5_kernel_denial_evidence.py).

The parser claims to reject unexpected or ambiguous post-filter socket/connect outcomes. Its complete-call expression accepts exactly one space before `=`, and an unmatched line is silently skipped. Consequently a successful target syscall can disappear from the receipt.

## Reproduction

Begin with the three synthetic per-process traces accepted by the existing tests: one post-filter socket EPERM and two post-filter connect EPERMs. Add either of these to the first post-filter trace:

```text
socket(AF_UNIX, SOCK_STREAM, 0)     = 5
```

or:

```text
connect(3, {sa_family=AF_UNIX}, 20 <unfinished ...>
<... connect resumed>) = 0
```

At the pinned source, both inputs produce `status=PASS`, `distinct_child_denials_verified=true` and `unexpected_or_ambiguous_outcomes=0`. A dangling unfinished socket record does too. A conventional single-line success with one space is correctly rejected, establishing that the failure depends on the parser's coverage rather than the baseline fixture.

The official [strace manual source](https://github.com/strace/strace/blob/master/doc/strace.1.in) documents unfinished/resumed output. The local proof of the parser defect is the actual returned result for the supplied text; it does not depend on claiming that these extra successful calls occurred in the retained CI run.

See `r5-parser-hostile-receipt.json` for all four original-parser outcomes. These are offline mutations of synthetic trace text. **This review has not demonstrated an actual seccomp/kernel bypass.**

## Repair

`repairs/pr643-denial-parser.patch` applies to the two pinned source/test files. It:

- accepts ordinary horizontal whitespace around the result separator;
- counts unparsed target syscall records, including unfinished/resumed fragments, as insufficient or unexpected evidence;
- advances the observational schema to v3;
- adds four regression cases to the existing test module, so the existing CI entrypoint executes them.

The repair deliberately rejects ambiguous fragments rather than attempting to reconstruct and bless their outcomes. A trace rejected on that basis needs a complete interpretable observation before acceptance.

The eight existing parser tests and four additional regressions pass against the repaired local source. See `r5-parser-repair-receipt.txt`. The repaired code is an evidence-parser change; it changes no effect authority, kernel filter or original-six meaning.

## What the retained artifact does establish

GitHub reports six successful triggered workflows at the pinned #643 head, including [run 44065604365](https://github.com/Tobillicious/universal-protection-theory/actions/runs/44065604365). Its artifact metadata binds ID `14320431327` to that run and head.

The downloaded ZIP matches GitHub's advertised digest:

`240a9258df0ac742b1a3dff90bd450ae906770e3dd9b9b5258e8f76ce11ca554`.

Its extracted JSON matches:

`b037be845a994f7f74402e2366bb5b32eb5ecfb55c8c2b055a325af73c263305`.

The record reports three fenced processes, one socket EPERM, two connect EPERMs, and the v2 parser's PASS. The provider binding and byte identity were checked independently of the document's filename. The underlying raw traces were not retained in this artifact, so this review cannot retrospectively rule out parser-ignored records in that execution.

That is bounded positive evidence with a newly demonstrated parser limitation. It is stronger than an older trace containing zero denied attempts. It does not establish exhaustive mediation, independent off-host custody, authentic subjects, or universal protection.

Draft [PR #644](https://github.com/Tobillicious/universal-protection-theory/pull/644), inspected at `144191f9b2782a61cc451e24b0df70ccefc873f4`, correctly distinguishes the historical permissive AF_UNIX finding from the newer strict-client probes. Its claims should also retain this parser-coverage qualification until the repair is reviewed and the evidence rerun.
