# IR-134 — Source-extracted outcomes, original UPT and recovery audit

**29 October 2026 NZDT · draft/non-canonical · not for publication**

## Motivation and inherited source lineage

IR-20 (PhysicalBridges/IRSelectedEndToEnd.lean) joins selected-policy maximality, abstract record refinement and physical guard predicates. However, its policy-outcome relation named realises is an UNINTERPRETED caller-supplied predicate: it could be true for every policy/outcome pair even when the selected history cannot occur. This is a legitimate conditional theorem, not a proof of actual physical realisation.

This PR does not rewrite original X3, original H5/PNAJ/D115, Snuffy Book I, the author's decisions, or any existing proof. It strengthens one separate source-execution interface, and separately reuses the historical law, IR-25 exact stagewise original-order audit, and IR-116 cumulative subject duties.

Historical anchors:
- 24 October Snuffy v3.7 Whole Edition, S11 Theorem 8: conditional good-event physical protection and joint risk composition.
- 18 October UPT-P-v0.12.1: original every-mind reached-or-held intent, later narrowed operationally in v0.17.2; original coverage is NOT discharged.
- IR-17/20/25: selected full-original-order maximality and finite faithful profile conditions.
- IR-56: finite faithful profiles FAIL for some infinite full-feasible worlds. Keep that counterexample.
- IR-66/67/68/69/70/71: positive conditional infinite feasible-family maximality results, including coupled two stages, finite forbidden patterns, resource-derived closure, finite-refutability and mandatory baseline. These are alternative routes, not superseded by IR-134.
- IR-72: one infinite safe policy under all-horizon robustness and finite action branching, not actual physical installation.
- IR-98/99/100: physical accounting witness still requires independent real source correspondence; do not call its premises derived from reality.
- IR-115/116: watchdog-to-options and monotone owed-cohort protection along traces, with actual same-person and option semantics open.
- 28 October UPT_G356_CAUSAL_CUT_WITNESS_2026-10-28.md: a SINGLE finite founding-capacity-guard toy system; checker recorded 18,496 transitions. It has TWO Nash equilibria, including never founding; real universal reach remains open.
- 23 October R8/G7 review: quorum uniqueness and logically committed history are NOT continuous physical identity; C2 name reused inconsistently.
- 27 October comparison: newer Canon 4.2 does not preserve all earlier rulings, tragic-choice and impartiality and identity/endowment material. Do not infer source priority from edition number.

## New result and exact hypotheses

The Lean file PhysicalBridges/IR134SourceExtractedOutcome.lean introduces:

1. runHistory: the whole state-bearing source trace, including initial state and each intermediate state, NOT just an endpoint register.
2. ExecutedHistory: a trace is feasible precisely when it comes from an explicit policy, disturbance sequence and the SAME supplied transition function. No arbitrary realises predicate can be passed in.
3. fourOriginalKeys: original existing continuation, existing freedom, new continuation, new freedom, in original order, evaluated on complete source histories. Semantics of particularhood, continuation and genuine freedom remain independent physical obligations.
4. original_order_maximality_of_executed_audit: using the existing IR-25 stagewise profile certificates, proves that the chosen physically constructed trace is feasible and original-order maximal among EVERY source-executable trace. This is CONDITIONAL on faithful complete finite profiles, which IR-56 demonstrates are not universally available. The supplied transition system must model all actual physical alternatives for original-world maximality to follow.
5. source_run_is_policy_reachable: any deterministic source run creates a genuine chain of physically typed steps in IR-109 semantics, rather than assuming an arbitrary relation to an implementation.
6. source_run_retains_original_cohort_and_required_options: joins this executable source and IR-116 cumulative-duty theorem. Physical monotonic owed-membership and robust genuine continuity/all-required-option predicates still need independent validation. Does not identify a copied process with the original.
7. arbitrary_realisability_witness_can_be_false: hostile Boolean countermodel where arbitrary caller-defined realises claims an impossible true-only history, while source execution stays false.

## Still OPEN

- Physical source/event inventory and actual environmental disturbances; no BCRD/quantum model has been validated universally.
- Physical and semantic interpretation of all four stage predicates for actual particulars, including identity across forks, authorization, subjective welfare and continued legitimate choice.
- True full original feasible-world coverage, not merely source-model completeness. A missing physical attack/event or resource constraint may defeat the trace theorem.
- A jointly selected policy that delivers the required original-maximal outcome for ALL relevant disturbances; a trace witness for ONE disturbance does not prove robust universal choice.
- Generic infinite four-stage feasibility, rather than finite audit or special infinite two-priority families.
- Founding and external pre-effect reach from arbitrary worlds, initial protection, energy and service, correlated lifetime fault laws and genuine permission.

**Disposition:** one conditional proof obligation is narrowed from arbitrary relation to actual executed source history. Do not promote to an empirical physical or maximal X3 theorem. Independent Lean, source and semantic hostile review required; no merge without review.
