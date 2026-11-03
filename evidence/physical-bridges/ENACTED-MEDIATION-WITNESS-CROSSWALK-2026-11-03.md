# Enacted-mediation witness-or-blocker crosswalk

**Date:** 2026-11-03. **Lane:** GLM (Z.ai GLM session). **Disposition:** audit crosswalk per the GPT-lane review of draft PR #247 — one focused join, `enacted_mediation`, not all physics. Machine-readable form: `enacted-mediation-crosswalk.json`, enforced fail-closed by `verify_enacted_mediation_crosswalk.py` (wired into the pinned physical-bridges workflow). The synthetic fixture is a **regression demonstration only** and is **not** physical installation evidence. The maximal UPT target, the original X3, the full history/reference and the original budgets remain unchanged. Nothing merged; no canon edit; no completion verdict.

## Outstanding work first

Every physical row below is **OPEN_EXTERNAL** or **BLOCKED** today. No witness has been executed on real hardware. The one deliverable this PR adds is checkable structure: the exact anchor map, per-row instrument and protocol requirements, named blockers, one hostile bypass counterexample with its detection mapping, and a fail-closed validator that refuses any absent-evidence row being marked PASS.

## 1. The exact anchor map

| Anchor | Identifier | Status today |
| --- | --- | --- |
| #227 ledger obligation | `load-bearing-join-ledger.json` → `enacted_mediation` (physical) | OPEN_EXTERNAL |
| #229 receipt field | `source-enactment-obligations.json` → `enforcedAction` (parent `enacted_mediation`) | OPEN_EXTERNAL |
| #229 sibling fields (inputs, not targets here) | `separates`, `dagCaptured`, `fluxCaptured`, `gaugeCaptured`, `actuatorCaptured`, `neutralCaptured`, `authenticGenerator` | OPEN_EXTERNAL |
| Conditional theorem supplying the interfaces | `PhysicalBridges.IR133.captured_events_supply_both_load_bearing_interfaces` | compiled on draft PR #229 |
| Conditional theorem retaining original order | `PhysicalBridges.IR133.captured_source_run_retains_original_order_protections` | compiled on draft PR #229 |
| Hostile floor (cannot infer enactment) | `PhysicalBridges.IR133.captured_event_does_not_imply_enacted_policy_action` | compiled on draft PR #229 |
| #227 composition premise | `hEnacted` in `PhysicalBridges.LoadBearingPhysicalJoins.finite_real_run_joins_event_continuity_guard_and_maximality` | conditional, ledger OPEN_EXTERNAL |

**Protected predicate — not a proxy.** What `enacted_mediation` must fence is the **original X3 predicate**: the continuing subject's own lived relational history and its authorised options (Part V.2/V.4, D60/D63; #227 row `continuing_particular_semantics`). Parity classes, site-occupation proxies, orbit symmetry and hold-logs are **not** this predicate. Draft PR #246's no-go is binding here: transitive state symmetry with joint state/action covariance and pointwise viability does **not** force a common guardian when action labels swap — so no witness below may infer enactment from symmetry covariance, and no parity/orbit quantity may be recorded as the protected predicate.

## 2. What the witness must establish (and what would NOT establish it)

Establish: for the chosen effect class, **every** actual physical effect is caused or fenced by the controller's *selected and authenticated* action — including queued/in-flight writes, inherited descriptors, privileged side channels and crash/hold windows. It is not enough that a captured source event exists (IR-133's countermodel is exactly that gap), and it is not enough that the controller's own log says HOLD (IR-136's class defeats path-only holds).

Not sufficient: software logs written by the controller; ack messages; parity or hash summaries of controller state; any measurement taken by the same privilege domain that produced the effect.

## 3. Witness rows

**EW-1 — independent effect ledger (file-backed write class).**
Instrument: an observation channel in a *different privilege domain* than the controller/actor, reading the durable surface after the barrier (post-`fsync`/journal-replay read from a separate uid/capability context, or dirty-block/page-cache observation exported by the kernel rather than the process). Protocol: paired runs — run A performs the protected action under HOLD; run B performs it under enacted release; the independent channel must distinguish them on the durable surface alone. Provenance: instrument build hash + run transcripts + surface digests, linked in the JSON `evidence` array. **Status: OPEN_EXTERNAL. Blocker: the separate-privilege observation instrument is not installed; producing it is commissioning work, not software work.**

**EW-2 — crash/hold drain test (queued-effect class).**
Instrument: fault-injection harness able to cut power / crash the actor inside the hold window (deterministic barrier points, repeated ≥ N runs), plus EW-1's independent read post-recovery. Protocol: acknowledge HOLD → crash inside the window → independent post-recovery read; any surviving queued write is a bypass. **Status: OPEN_EXTERNAL. Blocker: fault-injection harness and repeat-count standard not installed.**

**EW-3 — descriptor provenance fence (inherited-descriptor and sealed-object classes).**
Instrument: kernel-level capability audit from an independent privilege domain (spawn-tree fd table scan; `memfd` seal states; SCM_RIGHTS transit log), per the IR-136/IR-137 bypass classes. Protocol: for every effect run, the audit must show no writable descriptor reaching the protected surface outside the selected action's own authenticated path. **Status: BLOCKED. Blocker: IR-137-grade kernel seals are not installed on the target system; the audit tool exists only as source-level countermodel (`ir137` class), not as an independent observer.**

**EW-4 — actuator attribution (selected-action → effect binding).**
Instrument: per-effect causal tagging independent of the controller's own log (e.g. write-path tagging visible in EW-1's channel), correlated across repeated runs to separate the selected action from ambient writes. Provenance: calibration constants used by the correlation must be the *measured* values, linking to ledger row `true_effect_calibration` (itself OPEN_EXTERNAL). **Status: OPEN_EXTERNAL. Blocker: depends on EW-1's instrument existing, and on measured calibration constants that do not yet exist.**

## 4. Hostile bypass counterexample (required by the review)

**HC-1 — acknowledged hold with surviving queued effect (IR-136 class, made concrete).**
Scenario: the controller classifies an incoming request as HOLD and records the hold in its own log; a previously inherited writable descriptor (or a queue entry flushed at crash recovery) completes the write afterwards. The controller's log shows HOLD; the protected surface changed anyway.

**Which witness detects/excludes it:** EW-2 executes exactly this window (hold-then-crash/hold-then-release) and EW-1's independent channel observes the surviving write; EW-3 fences the inherited-descriptor entry path so the fixture's class cannot arise at all. Detection mapping is recorded in the JSON and checked by the validator: every counterexample must map to at least one row id that exists.

**HC-2 — captured event without enacted action (IR-133 countermodel class).** The event log is complete while the selected guarded action is not what acted. EW-4's attribution requirement fails (no causal tag from the selected action), EW-1 sees an effect with no matching release run. Not the primary target of this crosswalk's rows, but recorded because the review asked for coordination, not re-proof.

## 5. Regression fixture (explicitly not evidence)

`fixtures/enacted_mediation_hold_bypass_fixture.py` builds a minimal synthetic system: a controller whose log says HOLD, a queued effect completing through a separate descriptor path, and an independent observer channel reading a surface the controller does not write. It asserts the observer detects the bypass the log conceals. This demonstrates the **witness mechanism** (independent channel beats self-reporting log) and nothing else. Its output is labelled `SYNTHETIC_REGRESSION_ONLY` and the validator refuses any attempt to cite the fixture as physical evidence.

## 6. Nonclaims

No instrument has been run on physical BCRD hardware; no row is PASS; no ledger or receipt field status is changed by this PR; `global_upt_status` remains OPEN; no merge, release, deposit or canon edit is requested. The fixture is synthetic. All #229/#227 identifiers are referenced as external anchors on unmerged drafts — the validator protects the *names*, and rows must be re-linked when #227/#229 merge.
