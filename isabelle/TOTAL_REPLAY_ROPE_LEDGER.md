# Isabelle/HOL total replay — rope and loose-end ledger

**Objective:** independently replay the complete UPT proof graph in Isabelle/HOL, not merely G2, with faithful semantics and explicit physical and ethical interfaces. No claim of completed replay.

## Rope classes
- **Green (checked):** Isabelle session builds from a pinned version; theorem has no admitted gaps; its exact premises and source crosswalk are reviewed.
- **Amber (conditional):** theorem checks, but a premise, interpretation, source correspondence or event coverage remains open.
- **Red (unresolved):** missing formal source, counterexample, invalid translation, unverified build, or empirical claim unsupported by evidence.
- **Blue (philosophical/cultural):** normative or culturally situated premises requiring argument and provenance, not silently converted into physics.

## Replay order and belay points

| Stage | Anchor | Mandatory loose-end check |
| --- | --- | --- |
| 0 | Inventory original Lean theorem DAG and frozen SHA | File/theorem/signature/axioms, original summit chain and PR provenance |
| 1 | Something IS, logical foundations | Separate tautological non-deniability from stronger persistence or physics |
| 2 | Whole, parts, relations, source/BCRD | Independent subject/source interpretation and non-vacuity |
| 3 | Koru: first, complete, Time | No unary numeric surrogate; operational, physical and history-preservation claims separated |
| 4 | Thermodynamics, quantum, gravity | Mathematical model versus empirical correspondence; no invented universal coverage |
| 5 | Hume's fulcrum, Archimedes' lever | Preserve the positive ethical bridge; list every normative premise explicitly |
| 6 | Tīkanga operator family | Recover exact author notation, cultural provenance and review; do not invent |
| 7 | Six original X3 duties | All six independent, every owed particular, every actual event, no proxy |
| 8 | Route A, Route B, Hillary Step | Match original theorem signatures and exact joins |
| 9 | Hume–Hillary Reciprocal Hand | Both participants protected; physical mutuality and silence are not consent |
| 10 | G1 physical hold | Instrument, actual-event coverage, measured thresholds, probability assumptions |
| 11 | G2 greatest flourishing | Existence, feasible benefit, dominance, solvency, freedom and authenticity |
| 12 | G3 and capstone | Distinguish conditional closure from claims of universal physical or theological necessity |
| 13 | Infinity arguments | Trace each distinct inference, avoid circularity or duplicative assumptions |
| 14 | Total theorem replay | Build every session, audit axioms, source fidelity, countermodels and outstanding conditions |

## Required source-to-Isabelle record per theorem

- Lean source SHA, path, theorem signature, imports and hypotheses.
- Isabelle session/path/theorem statement, imports, proof and build result.
- Semantic correspondence review: types, quantifiers, modalities, actual-event meaning, particular scope, provenance, Koru.
- Axiom/dependency audit, including no `sorry`, no unsupported axiomatization and no vacuous witness.
- Status (green/amber/red/blue), reviewer, exact unresolved obligations.

## Initial actual state

- `G2_Hume_Hillary_Join.thy`: uncompiled conditional interface, no total replay.
- `G2_Aristotle_Greatestness.thy`: uncompiled conditional universal-six and greatestness interface, not a proof of benefit or existence.
- `ROOT`: Isabelle session definition, build not yet observed.
- Earlier Lean sources: remain unchanged; their presence or historical CI descriptions do not certify translation.

## Immediate next climbing tasks

1. Pin an Isabelle version and run `isabelle build -D isabelle`; record exact logs.
2. Build a generated or manually reviewed theorem inventory from the canonical frozen Lean SHA; no substitutions.
3. Port the earliest dependency-complete foundation slice, including explicit assumptions and at least one non-vacuous model.
4. Add negative tests for consent-by-physical-mutuality and for two-field X3 proxies.
5. Only then attempt an end-to-end G2 theorem; G3 remains downstream.

**Summit criterion:** independent Isabelle kernel verification of the intended assembled statement, with all assumptions and source fidelity accounted for. Even a successful formal replay does not by itself prove the real-world physical interpretation.
