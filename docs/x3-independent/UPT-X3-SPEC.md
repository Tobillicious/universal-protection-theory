# UPT/X3 independent system specification
Version 0.1 — 26 November 2026 — proposed review baseline, not a certified implementation.

## 1. Scope
Specify a bounded protective Linux service independently of Lean. The initial case is authenticated HOLD, concurrent requests, crash and recovery. No universal physical guarantee follows from this specification. Normative requirements below are proposed for review; they are not claims of implementation conformance.

## 2. Abstract state
Let P be a finite set of registered subjects, A a finite set of effect requests, and E a set of events. State comprises subject identities and history, capabilities and feasible options, authorization records, mode (RUN, HOLD, RECOVERY), generation, outstanding requests, committed effects and append-only receipts. An external custodian holds a checkpoint and trusted public keys. Initial state is HOLD, with no outstanding effects and a verified checkpoint or no permission to enter RUN. Define owed(s,e) independently of implementation output as subjects affected by e, including indirect effects within the declared boundary.

## 3. Original X3 requirements
For every admitted transition s --e--> t and p in owed(s,e), require all six predicates below. These are independent requirements, not aliases for successful execution.
- X3.1 Historical continuity: preserve the subject's identity-through-history and its required capabilities; a copy or log entry alone does not establish continuity. Source: ContinuationSubject.LaterStage, copy_not_laterStage.
- X3.2 Authorization: require authentic subject authorization or a separately justified applicable rule, bound to the exact effect and generation. Accounting or a successful signature alone is insufficient. Source: IR104.SubjectAuthorized, IR105.
- X3.3 Freedom: preserve required future options under the subject's applicable freedom constraints; record the feasible options before and after. Source: G2Freedom / FreeStage.
- X3.4 Appropriate restraint: reject effects that violate protected floors; any intervention must satisfy the applicable restraint rule, not merely halt everything. Source: BookUPTRestraint.Restrainable.
- X3.5 Maximality: select an admissible outcome not strictly dominated under an independently specified preference/order over feasible outcomes. The feasible set and order must be justified. Source: StagedMaximality.StageMax.
- X3.6 Provenance: bind identity, request, effect, generation and prior history to a verifiable receipt; require integrity and justified history correspondence. Source: IR119.

## 4. Transition contract
Request: authenticate caller and bind request to generation; record pending request without performing effect. Admit: only in RUN, with current generation and all six obligations justified; otherwise deny. Commit: atomically recheck admission at the effect boundary, record actual effect and receipt. HOLD: revoke admission at a specified linearization point; deny later commits, account for in-flight effects, acknowledge only after enforcement is established. Crash: no further unmediated effects permitted; restart in RECOVERY/HOLD. Recover: compare authenticated independent checkpoint and local state; reject stale or mismatched generation, preserve HOLD, and record result. Resume: require explicit authorized decision and successful reconciliation; never resume merely because a process restarted.

## 5. Safety and progress
I1: no committed effect after HOLD linearization and before authorized resume. I2: each committed effect has a unique current-generation admission and receipt. I3: crash/restart cannot bypass HOLD or roll back trusted generation. I4: every admitted effect meets all six X3 requirements for all owed subjects. I5: no unknown/unmediated effect path inside the declared boundary. P1 (conditional liveness): assuming available custodian, fair scheduling and recoverable resources, recovery can reach acknowledged HOLD. Permanent HOLD alone is not evidence of freedom or maximality.

## 6. Observation and evidence contract
Capture actual effect attempt/outcome, process identity, generation, authorization decision, checkpoint digest, receipt digest, and ordering evidence. Record provenance of observations and observer trust boundary. Missing, ambiguous or inconsistent evidence must not be interpreted as successful validation. Kernel mediation and independent custody require separate evidence. The exact trace schema and implementation instrumentation require review.

## 7. Refinement acceptance
Define abstraction alpha from concrete states and traces to abstract states/events. Prove initialization, step simulation (with justified stuttering), effect coverage, and six distinct semantic reflection obligations. Require an explicit nonempty reachable example and negative controls for each duty. Model checking finite instances validates the proposed reference model; proof and independent runtime evidence are needed for implementation claims. Complete Koru is a proposed history-preserving correspondence, not an assumed universal physical fact.

## 8. Review questions
Which independent notation best captures this contract (Z, CSP, TLA+ or alternative)? Where should HOLD linearize? Which observations suffice for subject-level obligations, and which require additional domain evidence? Can a small independently specified model drive both test generation and refinement proof?

Source: evidence/physical-bridges/PhysicalBridges/OriginalX3Full.lean (main); external repair proposal PR #753 (unmerged at review). Companion: UPT-X3-REFINEMENT.md.