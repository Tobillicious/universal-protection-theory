# G3 R6: exact fixed-marker effect evidence packet — source-first, no invented subjects

**17 November 2026 | documentation-only | primary integration review.**
This packet narrows the existing #588 original-six ↔ G3 crosswalk to one ACTUAL exercised Linux synthetic marker fixture. It is an evidence *index*, not new mathematics, new consent semantics, a new decision engine, effect authorization, production telemetry or discharge of #517's universal premises.

## Immutable source examined

On source snapshot `d695cb3833c3a4c55a29302009bacc54c80f382c` (draft #597 ancestor), reviewed:

- `evidence/execution-boundary/test_koru_authority_owned_marker_service.py`, `AuthorityOwnedMarkerTests`;
- `evidence/execution-boundary/test_koru_no_inherited_fd_executor.py`, `NoInheritedFdTests`;
- `evidence/execution-boundary/koru_runtime_evidence.py` for exact checkout and CI-source/binary inventory;
- #588 crosswalk for the *existing* `AllActualEffectsRefineJoint` and `AuthenticSixReflections` Lean interfaces, drawn from merged #517.

**Source review is not a new execution of tests.** CI and artifact digests must be collected for the final exact head. The case here is **one zero-byte `fixed.marker` resource** under an authority-owned temporary directory, one `fixed_marker` operation and controller `hold`, with separate Linux test UIDs.

## Observed technical fixture evidence — what the code actually tests

| Exact test entrypoint | Fixture observation/expected assertion | Claim bounded by that evidence |
| --- | --- | --- |
| `AuthorityOwnedMarkerTests.test_authority_mediates_one_fixed_marker` | Executor request returns `synthetic_effect_returned`; marker exists, UID `AUTH=65533`, size zero; second attempt `authority_denied` | One specific authority-owned marker creation and once-only behavior |
| `AuthorityOwnedMarkerTests.test_hold_first_blocks_effect` | Controller submits `hold`; executor's subsequent marker request is denied and marker directory stays empty | HOLD-first ordering in this tested executable path |
| `AuthorityOwnedMarkerTests.test_unauthorized_peer_cannot_start_or_hold` | Distinct `REQUESTER/EXECUTOR/CONTROLLER` UIDs denied inappropriate requests | Specific kernel peer-credential/operation negative controls |
| `AuthorityOwnedMarkerTests.test_executor_and_requester_cannot_bypass_authority_via_dac` | Separate UIDs cannot directly create marker or modify authority DB paths | DAC constraints for these exact paths and UIDs |
| `AuthorityOwnedMarkerTests.test_restart_preserves_started_and_blocks_repeat` | Server restart does not permit second marker creation | Tested once-only durability under ordinary process restart |
| `NoInheritedFdTests.test_explicit_write_descriptor_leak_bypasses_private_path_dac` | Intentionally passes a writable FD and writes to another fixture file | **Counterexample**: direct pathname DAC alone is insufficient |
| `NoInheritedFdTests.test_close_fds_prevents_same_write_descriptor_leak` | Without passed FD, the child's write fails | Closed-descriptor mitigation in this launch mode |
| `NoInheritedFdTests.test_fixed_launcher_can_request_one_authority_owned_effect` | Confined executor succeeds once via authority; repeat denied | Positive end-to-end *synthetic* authority path |
| `NoInheritedFdTests.test_hold_first_denies_fixed_launcher` | Committed HOLD precedes launcher; marker remains absent | Negative synthetic effect path under HOLD |

The above code assertions do **not** constitute an independently retained before/after event stream. The fixture creates and observes its own local temp files and state and therefore is inside the CI/test administrator's evidence domain.

## Explicit candidate `realStep` / `read` evidence obligations

- **Real step scope candidate:** runtime transitions of the specified fixed-marker authority under exact source/kernel/UID/runtime configuration, including marker creation, repeat denial, HOLD-first denial, restart and effect-time races. Specify external observable outcomes and whether a *denial attempt* is itself represented as a real transition, rather than defining `realStep` to mean “was authorized.”
- **Actual observables:** marker inode/owner/size/absence, admitted/denied request, exact event identity, authority journal revision/HOLD generation, process UID/executable and kernel errors. Attach independently captured before/after receipts and tamper-evident custody. Current test assertions are useful examples but not independent field measurements.
- **State interpretation `read`:** create a complete, reviewed mapping from those observed states/history to the exact existing joint-model components. Avoid discarding potentially relevant distinctions in authority, history, ownership, provenance, denied attempts or rollback.
- **Coverage:** enumerate every effect route of the bounded environment rather than taking passing marker tests as proof of complete mediation. In particular #600 at `f5ff0a57005880f944aeeda80047207503915660` demonstrates permitted outbound alternate AF_UNIX destination reachability after confinement. **R5=OPEN** until constrained or explicitly excluded by a defensible effect-boundary proof and negative controls.
- **Independent observation/custody:** R4 #590/#591 simulated preserved operator floor is not yet an independently governed off-host witness. The proposed two-computer rehearsal #597 tests technical separation, not automatically administrative independence.

No existing observed receipt reviewed here instantiates the complete premise
`AllActualEffectsRefineJoint` for *every actual effect* in an independently fixed environment. **`hCoverage: unresolved`.**

## Authentic six: no invented subjects or truth flags

| Existing original X3 obligation | Fixture signal | Still-required authentic subject/effect evidence |
| --- | --- | --- |
| Historical continuity | Durable journal, once-only restart | Genuine owed particular and identity/history continuity through event |
| Authorization | Distinct UID and op entitlement, signed event reference from other branches | Independently authenticated subject authority, delegation, revocation, consent/protective substitute |
| Freedom | No real subject/alternative assessment in marker fixture | Independently identified meaningful choices and protected alternatives |
| Restraint | Fixed op, negative HOLD and bounded resource | Actual subject-specific proportionality and justifiable limitation |
| Maximality | No independently observed feasible-alternative set | Real choice set and original maximum criterion, not arbitrary Boolean |
| Provenance | Event reference, authority journal, reproducible source | Authenticated subject/source→decision→observed effect chain, independently held |

A Linux UID is **not** an authenticated ethical subject. A successful signature or rights-record equality is **not** informed consent. If the bounded fixture has no independently authenticated owed subject, mark all subject-specific authentic reflections **unresolved / out of evidence scope**, not vacuously proved by setting `P` empty or `owed` false.

Thus **`hMeaning: unresolved`** for any claim about real subjects. Retain existing original-six theorems unchanged.

## R7 receipt template for a future actual event

Record one row per event, tied to independent copies of evidence:

- Exact 40-hex repo SHA, Git blob digests for authority/launcher/filter/rights/HOLD and runner/kernel/Python.
- Observer identity and distinct administration; capture method, time and SHA-256 of immutable before/after receipts.
- Subject/source identity and owed status as independently established, with fields for **unresolved** rather than fabricated values.
- Event ID, operation, authority/HOLD generation, execution/denial, marker before/after identity/owner/size and journal entry.
- Actual `realStep`/total `read` mapping reviewed by a separate verifier.
- Six separate authentic reflection evidence pointers, with each explicit status: verified for scoped event / unresolved / contradicted.
- R5 alternate-effect inventory exact SHA; R4 independent checkpoint revision/administrator acknowledgment; negative tests and exclusions.
- Reviewer and signed conclusion **only for the selected exact scope**; no synthetic event is permission to claim universal original-six protection.

## Acceptance boundary

This packet helps identify what is already concretely tested, and specifies what **cannot** be inferred. It does not satisfy independent subject evidence, R4 off-host custody, R5 complete mediation, or R7 third-party replay. Review by the primary integration agent before reconciling #597 with #600 or later R5 changes. No merge/deployment or new effect permission.
