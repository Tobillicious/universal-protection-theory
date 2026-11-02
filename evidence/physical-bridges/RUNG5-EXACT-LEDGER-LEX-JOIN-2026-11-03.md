# Rung 5 — exact metered-ledger / original two-priority greatestness join (3 Nov 2026)

## Added source
`PhysicalBridges/Rung5ExactLedgerLexJoin.lean`

This source composes the new `FinitaryActionMenu` result with the existing original-order IR-69 and IR-71 construction without modifying X3, the canonical UPT order, or a physical-source claim.

### Three theorem obligations

1. `retained_fact_quanta_bounded`: from a full additive finite-subset resource ledger, a retained fact's charged level cannot exceed `capacity r / δ r` when `δ r > 0`. This formally connects the previously separate local menu estimate to the resource-accounting semantics.
2. `metered_mandatory_original_lex_maximal`: within the **specified** all-finite-subsets resource model and finite hard incompatibilities, an independently feasible mandatory baseline extends to a maximal outcome in the *existing* `UPTExist.LexAlignedL` two-priority relation. The full modeled feasible family is used. This is an exact instantiation of IR-71, not a new compactness premise.
3. `actual_full_universe_original_lex_maximal`: lifts that maximality to an **actual** feasible family from (a) actual feasibility of the mandatory baseline, (b) completeness of the resource model for every actual feasible competitor, and (c) actual realisability of the selected candidate. It only requires one-sided model completeness, not equality of actual and modeled feasibility sets.

## Critical limitations

- *Per-tick menu finiteness is insufficient for infinite-horizon existence.* The `IRResourceDerivedClosure.EventuallyAbsent` counterexample and `IRFiniteRefutationCriterion` remain live limitations. The proof does not collapse these into a compactness conclusion.
- This supplies an original-order theorem for the existing **two-priority, countably indexed fact type** `Bool × Nat`. It does not by itself prove that every original X3 stage, historical right, or physical particular is represented by those facts.
- Resource and hard-conflict completeness, positive baseline realisability, and actual candidate realisability are **open physical-source/installation correspondence obligations**, not results of this module.
- The source theorem `finalProtected` uses noncomputable feasibility decisions; this is an existence result, not a deployable guardian algorithm.
- No changes to commissioning, founding choice, canonical manuscript, or public release.

## Checks
The file includes `#print axioms` for all three exported theorems. An author or CI kernel receipt must be attached before declaring the increment compiled. No `sorry`, `admit`, or new axioms were added in this source.

## Next attacks

1. Formalise independently checked source-ledger **completeness** (not merely per-channel instrumentation) and **candidate realisability** using IR-117–IR-132 source correspondence without hiding either in a definition.
2. State and test the exact countermodels for omitted infinite-tail constraints and zero-cost/unmetered effects.
3. Connect higher than two priority stages only using the original full priority list; do not silently reinterpret `Bool × Nat` as all of X3.
4. Rung 1 M0: lemma-by-lemma extraction audit of BDLT, separately from this physical-bridge proof.
