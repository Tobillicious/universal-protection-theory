# G3 X3 join recovery — find before build (17 November 2026)

**Review-only integration crosswalk. No original-X3 source definition, Lean proof, executable effect gate or canonical Koru definition is changed.**

## Recovered theorem route

1. Merged **#402**: `KoruOneRealizedTraceAssembly.koru_holding_six_x3_total_E_one_realized_trace` combines complete source Koru, holding, original-six X3 and Total-E on **one supplied realized history**, with explicit source/event/semantic premises.
2. Merged **#405**: `FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` and `physical_domain_has_no_original_six_violation_or_absolute_E` quantify over every event of the **independently supplied** `physicalStep` relation. They require `CompleteWEventCoverage` and `ForwardRealEventReflection`. The theorem does not certify that the supplied relation includes every actual physical event.
3. Merged **#407**: `ConstructivePositiveWGuardian.positive_W_mathematical_guardian_exists_and_protects_every_step` constructs a nonempty positive-W process, internally discharging those two gates through `canonicalPositiveWStep` and the **formal source-pullback** interpretation `canonicalPositiveWSubjects`. This is a mathematical existence theorem, not empirical human-subject semantics.
4. Merged **#517**: `ExternalJointEffectRefinement.independently_covered_events_satisfy_original_six` and `no_actual_original_six_violation_under_verified_refinement` reuse the unchanged original six in a distinct **external-effect** interface. The inputs are `AllActualEffectsRefineJoint J realStep read` and `AuthenticSixReflections realStep read carrier owed actual`; the latter consists of six independent forward implications, not one unchecked safe/consent boolean.

The strongest source-to-actual-event conditional bridge already exists in #517. **Do not add a seventh X3 verifier or restate the six duties unless a specific failure in the existing interfaces is demonstrated.**

## Recovered executable evidence components

- Merged **#472**: `g3_authority_evidence/authority_evidence.py` verifies a pinned signed record; provenance alone does not certify a real subject's authority.
- Merged **#473**: `g3_rights_review/rights_review.py` reviews a separately trusted subject-bound rights record.
- Merged **#488**: `g3_rights_composition/same_event.py` explicitly binds signed serial to trusted rights-record reference, one subject, action, scope, purpose, effect digest, time and generation. Even its successful output has **`authorizes_effect: false`, `authentic_consent_proved: false`, `original_six_x3_proved: false`**.
- Merged **#507**: `g3_prod_01/g3_cross_process_fence.py` opt-in veto-bound writer and `g3_rights_veto/rights_veto.py` serialize durable withdrawal with signed publication under a shared private filesystem lock; missing/invalid veto journal fails closed. The *legacy* writer is not retroactively protected by this path.
- Merged **#517**: Lean external joint-effect refinement is **conditional** and not a runtime evidence producer.
- Draft **#572–#583**: separate bounded synthetic `fixed.marker` authority/effect service and source/runtime identity experiments. They are **not the same deployed writer** as #507 and cannot inherit its consent/withdrawal claims by name.

## Exact seam still needing evidence

**S1 — Effect-domain correspondence:** Independently define the actual effect relation `realStep` and show it includes every event in the explicitly declared system scope, including errors, crash/recovery transitions, bypass channels and effects that can happen without an authorization request. Do not define `realStep` as “safe effects”.

**S2 — Joint step refinement:** For each such externally observed event, provide an independently checked `read : W → Joint T H E n` into the already defined joint state and verify `AllActualEffectsRefineJoint J realStep read`. Signed source hashes, an admission log or a correct fixed marker are **not alone** a witness of this proposition.

**S3 — Authentic particular correspondence:** Establish which actual subjects are owed duties, an authenticated `carrier` mapping, and six separate real-subject reflection obligations of `AuthenticSixReflections` (historical continuity, authorization, freedom, restraint, maximality, provenance). Do not promote `review_complete` or no-veto to consent or all-six X3.

**S4 — Same-event binding at effect time:** Tie the physical/effect event, signed claim serial, trusted rights record, subject identity, scope, digest, withdrawal generation, and actual effect outcome to **the same** event. Confirm the chosen executable path actually uses the opt-in bound writer or an independently proven equivalent, and that legacy/off-path effects are excluded by OS enforcement.

**S5 — Independent evidence/reviewer custody:** Source-provenance and same-host journals cannot demonstrate actual subject meaning or independence of a rollback witness administered on the same compromised host. Require independently collected evidence and a reviewer procedure that cannot issue effect authorization.

## Non-duplication / acceptance protocol

- First search the current merged modules and historical PR sources for an **existing** exact discharge of S1–S5; retain source identifiers and full hypothesis lists.
- If all five are found: assemble a concrete theorem invocation and replay exact-head Lean and real effect tests; record the actual event/subject scope.
- If some are missing: state the **single missing premise**, provide a falsifiable witness/test and patch only the identified executable or evidence adapter. Keep source model/theorems unchanged.
- For R5 complete mediation, independently verify all alternate kernel effect routes, not merely the intended request path.
- For release, require one combined exact-head review candidate with authentic external subject and event evidence, reproducible runtime identity, independent history custody and kernel-level fault/bypass tests.

**Status:** theorem route and evidence primitives recovered by read-only source inspection; no demonstration that S1–S5 are all discharged for the current synthetic marker, signed document writer, or the whole physical universe. This report makes no such claim.
