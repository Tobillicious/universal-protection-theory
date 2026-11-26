# X3 refinement and verification plan
Version 0.1 — 26 November 2026. Companion to UPT-X3-SPEC.md.

## Existing formal anchors
OriginalX3Full.lean defines six relations on state pairs and particulars. originalX3_strengthens_proxy and proxy_is_strictly_weaker establish that continuation and authorization alone are insufficient. This is source-level evidence, not an independent kernel replay. FullPhysicalDomainGuardianAssembly.lean is the previously identified integration interface; inspect its current assumptions before claiming discharge. PR #753 proposes independent repairs and mutation tests; its reported 501 build jobs and 38 tests are not independently reproduced here.

## Proof obligations
R0: independent requirements review; agree subject domain, owed relation, effect boundary, feasible outcomes and authorization semantics before implementation fitting.
R1: initial concrete state maps to an allowed initial abstract state.
R2: each concrete step maps to an allowed abstract transition or observationally harmless stutter.
R3: every effect in the declared boundary is mediated and observed; no missing effect can be hidden as stutter.
R4: for every observed admitted effect and owed subject, prove six separate implications from concrete evidence to X3.1–X3.6. Do not infer consent from signatures alone, freedom from uptime, continuity from a copy, restraint from blanket HOLD, maximality from an arbitrary score, provenance from a log alone.
R5: show independent trust assumptions: authenticated identities, custody, checkpoint freshness, ordering and failure model.
R6: prove preservation by composition over reachable traces; state fairness and recoverability separately for progress.
R7: Complete Koru correspondence: establish history preservation and injectivity where required, show correspondence preserves each duty, and identify observed physical semantics. Global matterspacetime realization remains outside this bounded case.

## Evidence-to-duty mapping
Continuity: identity/history trace plus subject capability evidence; authorization: request-bound consent or justified rule; freedom: before/after option sets; restraint: denied attempts plus justified intervention scope; maximality: independently enumerated feasible outcomes and ordering; provenance: authenticated chained receipts and independent checkpoint. Each mapping is a proposed obligation, not a discharged theorem.

## Validation matrix
T1 normal admitted effect: all six predicates true on a nonempty owed set.
T2 unauthorized request: denied, no effect.
T3 concurrent HOLD/commit: explore both orderings; forbidden post-HOLD effect.
T4 crash before/after commit and before/after acknowledgement: recovery HOLD, reconcile receipts.
T5 stale checkpoint, wrong identity or replayed receipt: deny recovery/resume.
T6 bypass attempt: actual kernel denial and independent observation.
T7 six individual duty mutations: each missing duty must invalidate full X3 even if others hold.
T8 unknown subject/effect: reject or explicitly expand coverage, never silently exclude.
T9 permitted resume: valid authorization and reconciliation; conditional progress without bypass.

## Proposed workflow
1. Review specification independently with a formal-methods researcher.
2. Encode finite transition model and run model checking with recorded configuration, reachable-state count and counterexamples.
3. Derive implementation tests and trace schema from reviewed specification.
4. Prove refinement against a pinned implementation and formal-model revision; replay proof in clean environment.
5. Obtain independent custody and kernel enforcement evidence, reproduce tests and publish limitations.
TLA+ is one candidate for concurrent transition modeling; see https://lamport.azurewebsites.net/tla/tla.html. Choice of notation is open. No model checker or proof replay was run for this document.

## Acceptance boundary
A successful bounded case supports only its declared domain and assumptions; it does not certify unconditional G3. No canonical theorem or runtime code is modified by this documentation proposal.