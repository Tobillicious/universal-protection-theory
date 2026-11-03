# IR-138 — original-X3 semantic correspondence needs a per-event, per-particular witness

**3 November 2026 | focused draft | no canon, full-X3 or physical status promotion**

## Exact research question

The source and enacted-guardian lemmas in PRs #227 and #229 assemble correct **conditional finite-run implications**. The physical correspondence obligation remains: how does a source-labelled, accounted and authorized-looking event establish *the real individual* retained the relevant history, consent and agency, not merely a conserved property or nominal state label?

This draft examines a **necessary bounded event-level information distinction**. It does not re-prove or weaken original X3.

### Source code anchors

- `IR105AuthorizationIndependence.lean`: a captured/causally participating source can fail its independently defined consent-or-continuation screen. A real subject's mere participation is not consent.
- `Oct10ParticularContinuationBridge.lean`: `Certified` preserves independently supplied `owed`, `active`, `causal`, and `TwoWayChoice`; a physical subjective-identity warrant is **not** derived.
- `IR132ExactBoundaryReconstruction.lean`: `ExactDecoder` requires its target semantic judgment to be constant on the accessible-readout fibres.
- PR #227: ledger `continuing_particular_semantics` is `OPEN_EXTERNAL` and `event_to_source_generator` / `real_step_coverage` are independently `OPEN_EXTERNAL`.
- PR #229: `separates`, `authenticGenerator`, `enforcedAction` and the four readout capture fields are `OPEN_EXTERNAL`, without any authenticated individual consent or subjective-continuity source.
- PR #246: sectoral parity guarding and reversible H2 dynamics do not imply protection of local B-site occupation; both remain **physical proxies**, not actual subjects.

## New machine-checked source diagnostic

`PhysicalBridges/IR138PerParticularEventReflection.lean` defines a finite `ParticularEvent` with:

1. a **nonidentity physical state change**, a source generator label and the charged work amount;
2. separate event-level `continues m` and `authorized m` readouts for **two labelled particulars**;
3. the IR105-style conservative screen `eventScreen e m := continues m ∨ authorized m`.

The screen is deliberately **weaker** than the full original X3 (which includes genuine subject history, valid consent, future agency and maximality). Its failure nonetheless blocks any inference that *this particular bounded duty* is secured from a too-thin readout.

Two histories, `consentedEvent` and `coercedEvent`, have:

- identical **before and after** source states (a real nonidentity transition, not a stuttering trace);
- identical source generator labels and identical work charge;
- the second individual continuing in BOTH histories;
- the first individual NOT continuing in either, but **genuinely authorized** in the first and **unauthorized** in the second.

Therefore source accounting, even perfect matching to the named modeled generator and exact numerical charges, cannot determine the first individual's authorization or real continuity in this finite case. This is an underdetermination test, **not** evidence of a real-world harmed subject.

### Formal mathematical results

- `same_source_event_different_particular_semantics` — one source readout, opposite individual semantic status.
- `one_covered_event_passes_other_fails` — the consented event passes the bounded screen for *each* particular; coerced one fails for the first.
- `accounted_subject_participation_cannot_decide_consent` — exact reuse of IR105's existing screen keeps causal input distinct from actual authorization.
- `any_exact_particular_report_must_separate` — ANY instrument and decoder sound on all considered events must distinguish the two histories.
- `no_endpoint_source_charge_decoder_for_first_particular` — source state endpoints, generator ID and charge cannot supply `IR132.ExactDecoder` for this subject event.
- `aggregate_good_flag_hides_bad_particular` — an aggregate "someone passes" readout can be true while the first individual fails.
- `ideal_packet_exact_for_each_particular` — the *ideal* per-particular continuation+consent packet is mathematically sufficient to decode the screen.
- `validated_witness_supports_per_particular_event_screen` — an explicitly independently validated semantic readout and passing per-individual classifications imply the bounded event screen. The **fidelity premise** is the true external obligation.

The ideal packet is constructed from the toy event's underlying Boolean flags. **No real physical sensor, no authentic subjective witness, and no complete real-world source correspondences are thereby built.** An implementation would require genuinely independent subjects, instrument semantics, causal/consent evidence and action provenance.

## Why this affects the forcing theorem

It is not enough to derive:

```
real effect → recorded source generator → controller action
```

to prove actual original-X3 protection. There must also be independently justified *semantic event reflection*:

```
actual physical event
   ├── source generator, action and cost
   └── per-subject historical/continuation/consent evidence
                                  ↓
                 original-X3 obligations for that event
```

The semantic relation is not created by naming a source predicate `Protected`. In a fully instantiated system, every physical change (including transient harm followed by a nominally restored endpoint) and every affected individual must be covered.

This is a **necessary information-separation gate** for claiming a *readout-based exact semantic certificate* on the chosen event class; it is not a theorem that all possible fundamental physical protection mechanisms must have an instrument, nor a complete solution to first-harm physics. A stronger source law might make some histories physically inadmissible; **derive that independently from BCRD if proposed**. Otherwise these histories remain logical alternatives requiring discriminatory evidence.

## Smallest external witness needed next

A serious candidate requires an **independently verified** physical example with:

1. explicit independently identified subject and *history reference* (not a mutable ID or file);
2. exactly specified real event and source actuator/generator that caused it;
3. authenticated consent OR independently warranted continuation of that **same** subject across the event, and a proof of the relevance of this dichotomy to the full X3;
4. complete mediation/readout and the finite possibility of bypass effects;
5. negative event with identical source-facing readouts but different external semantic facts, to test false acceptance;
6. a scope-limited, reproducing fixture, physical provenance and independent calibration. If the event is synthetic, mark it **SYNTHETIC**; if no source instrument exists, mark **OPEN_EXTERNAL**.

This asks for a **discriminating witness**, not an imagined way to measure subjective experience directly. If independent ground truth for subjective continuity cannot be established, state that limitation plainly: original-X3 physical semantic certification is still open.

## Exact open joins and research routing

| Existing join | What IR-138 adds | Status |
|---|---|---|
| #227 `real_step_coverage` | finite two-event readout falsifier for insufficient instrument data | OPEN_EXTERNAL |
| #227 `event_to_source_generator` | source generator alone cannot determine consent/continuity | OPEN_EXTERNAL |
| #227 `continuing_particular_semantics` | full per-individual historical/consent correspondence required | OPEN_EXTERNAL |
| #227 `enacted_mediation` | controller/effect authority remains separately necessary | OPEN_EXTERNAL |
| #229 `separates` | exact semantic-fibre distinction not established by nominal four-channel schema | OPEN_EXTERNAL |
| #229 `authenticGenerator`, `enforcedAction` | source mapping/action authority are different from consent | OPEN_EXTERNAL |
| #247 GLM review | independent finite-first-harm and evidence audit assigned | awaiting review, no results attributed |

No existing ledger entries are marked closed. No canon/X3 changes. No source observations are invented. Separate from PR #245's ontology and from PR #246's symmetry-based forcing, this is a narrow **semantic information** obstruction.

## Decision gate

- If independent data demonstrably distinguishes all real original-X3-relevant per-particular events in a stated scope, build its authentic readout/decoder certificate and join to #229.
- If a specific BCRD law demonstrably forbids the unsafe event, prove that law without defining permission by X3-safety.
- Otherwise retain the **OPEN_EXTERNAL** semantic and event-coverage claims, and do not infer universal protection from a nominally certified source trajectory.

Full original X3, physical universality, global time, and genuinely subjective interpretation remain unproved.
