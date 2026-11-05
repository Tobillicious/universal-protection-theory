# Bridge-discharge correspondence ledger — guardian-only, source-to-theorem

**4 November 2026 · consolidation only · no canon edit · no release.**

This ledger states, for the guardian-only discharge (PRs #253–#258), exactly which
premises are **mathematically derived**, which are **operationally measured** physical
facts, which are **required physical premises** (visible, not unconditional), and which
are **open**. It is written to the standard of an independent read-only audit, and it
records — rather than papers over — the three findings of the 2026-11-04 external audit.

## Top-level theorem

`CathedralBridgeDischargeAssembly.nothing_but_guardians_from_instrument`

```
(m : MeasuredInstrument S) (s : S) (hOrigin : m.x3State s) : HistoryGuardian (toSource m) s
```

Depends on **no axioms** (Lean `#print axioms` clean). It is a **conditional** result:
its content is entirely in what `MeasuredInstrument` asserts. This ledger classifies
every one of those assertions. The honest headline is therefore:

> Guardian-only histories are **reduced**, with no axioms and no opaque certificate, to
> the fields of `MeasuredInstrument`. The reduction is complete; the fields are not all
> yet derived from the frozen BCRD source. The ones that are not are named below.

## Field-by-field classification

| `MeasuredInstrument` field | Certificate field it discharges | Status |
|---|---|---|
| `classifies`, `keeperExclusive`, `e9Coverage` | `noMiddle`, `exclusive`, `e9Covers` | **Source classifier** — structural; must come from the BCRD step relation. *Currently supplied.* |
| `keeperEffectBounded` | `keeperStable` | **Measured** — keeper steps stay within envelope. |
| `recoverableEffectBounded` | `refreshStable` | **Derivable** from Branch A (`branchA_refresh_stable`, incr 3) given per-step refresh witness. *Currently supplied as a field, not invoked.* |
| `detectionBudget`, `interceptedEffectBounded` | `detectionBeforeDeadline`, `timelyInterlockStable` | **Derivable** from Branch B (`branchB_timely_interlock_stable`, incr 2) given per-step episode witness. *Currently supplied as fields, not invoked.* |
| `coherentWorkOrFence`, `coherentWorkBound`, `coherentFenceBudget`, `coherentFenceEffectBounded` | the coherent work/power-fence fields | **Derivable** from Branch C (incr 3; `unaffordable_coherent_ender_is_infeasible`) given per-step witness. *Currently supplied as fields, not invoked.* |
| `controlCorrect` | `semanticReflection` | **REQUIRED PHYSICAL PREMISE — NOT unconditional.** `effect ≤ threshold` (a number) does **not** by itself entail the particular's continuation/authorization are preserved. Countermodel (review H1): a step with zero measured effect meets the threshold yet is unauthorised — the inequality holds, the conclusion fails. This is the genuine controller-correctness premise (the controller protects the *particular*, not just bounds a scalar). It must be warranted from the BCRD source + E9, or stand as a named physical premise. **Not derived.** It is **NOT** supplied by PR #254 — see H2 below. |
| `stateCarry` | `eventCarriesState` | **REQUIRED PHYSICAL/SEMANTIC PREMISE.** That preserved continuation/authorization carry the X3 state forward. Grounded in intrinsic relations (incr 1), but still supplied, not source-derived. |

## Operationally measured inputs (the circularity guard set)

Per the first-harm audit (#250), these must be **measured on the installed instrument**,
never stipulated as admissibility — the #227/#229 ledger rows:

- stabilizer coverage with code distance `d` against the actual error channels;
- QND syndrome sampling within the accepted latency budget (`a/c + τ_sensor + consensus + τ_fb + τ_reset < lightcone margin`);
- per-site power threshold `ε_sens` with the quantum-speed-limit rate bound;
- solvency: measured income flux ≥ demand;
- refresh-from-record tracking envelope `λ_env < threshold`.

A conditional guardian-only result standing on *these measured facts* is the honest
target. It is **not** unconditional, and must never be published as such.

## The three audit findings, recorded as the current frontier

1. **`controlCorrect` is not derived.** Priority A/B: construct the instrument from the
   frozen BCRD source and derive `controlCorrect`/`stateCarry` from real continuation and
   authorization relations — not a numerical threshold, and not a renamed hypothesis
   equivalent to the conclusion. Acceptance test: no protection conclusion smuggled into
   an input type.
2. **E9 witnesses not invoked.** Priority C: have the assembly call
   `branchA_refresh_stable` / `branchB_timely_interlock_stable` / Branch-C lemmas with
   source-specific witnesses, so each certificate field traces back through a theorem to
   its physical assumptions. (Impedance to resolve: the increments bound a window value
   `physical t`; the assembly uses `effect s t ≤ threshold s t` — these must be unified.)
3. **`ender` conflation.** `ender` in `CathedralFirstEventForcing` means *a flagged
   hostile attempt* (which E9 covers); `Ender_original` in `CathedralAllIsEnderTypeCollapse`
   means *an agent/step that commits a realized first X3 violation*. The non-vacuity
   witness labelled an intercepted attempt `ender := True` while `continues/authorized :=
   True` — consistent with "attempt, intercepted," NOT with "realized violation." These
   must be distinguished explicitly. The realized-violation-impossibility is
   `every_real_step_keeps_x3` (every step, even a flagged attempt, satisfies
   `originalX3Event`); see `flagged_attempt_still_protected`. The agent-level #252 premises
   `G∨E` and `¬E` still need their own bridges at the original identical definitions.

## Second hostile review (2026-11-04, independent) — additional recorded findings

Converges with the above. Two findings beyond the three already recorded:

- **H2 — `#254` proves a *weaker* proposition than `#258` uses.**
  `full_intrinsic_source_recovers_semantics` recovers `eventScreen = continues ∨
  authorized` (a **disjunction**). `#258`'s `originalX3Event = continues ∧ authorized`
  (a **conjunction**). Exact recovery of the disjunction does **not** establish the
  conjunction, and decoding a field from an object that already contains it is not a
  derivation from primitive dynamics. **Correction to a prior claim:** `#254` refutes
  IR-138's "not recoverable from source" (correct), but it does **not** supply `#258`'s
  `controlCorrect`/`semanticReflection` bridge. That bridge is a distinct, still-open
  obligation. (This retracts the earlier "cashes in #254" framing.)
- **H6 — the substantive-reflection witness is vacuous.** `#255`'s
  `semantic_reflection_is_substantive` sets `physicalStable := False` throughout, so
  `controlCorrect`'s hypothesis never fires; it does not witness that the bridge carries
  content. A genuine witness needs `physicalStable` true with a real derivation of
  continuation/authorization. Likewise the `Unit` witnesses (H6) show inhabitability,
  not a nontrivial BCRD execution.

Both reviews' verdict: **reject as evidence of unconditional physical UPT; accept as a
valid conditional certificate assembly.** That is this ledger's position exactly.

## What is genuinely established (stated at true strength)

- The ontological composition `(G∨E) ∧ ¬E ⟹ G` and the forcing chain are kernel-checked,
  no axioms beyond the standard three, no `sorry`.
- The guardian-only history result is **reduced** to `MeasuredInstrument` with the
  certificate **constructed, not assumed**.
- No realized first X3 violation occurs on any admitted step of the realized source
  (`every_real_step_keeps_x3`), conditional on the instrument fields above.

## What is NOT established (must not be published as if it were)

- That `controlCorrect`/`stateCarry` follow from the BCRD source (open — priority A/B).
- That the measured instrument facts hold of any real instrument (physical commissioning).
- The agent-level #252 premises at original guardian/ender definitions (open bridge).
- Within-event continuity beyond endpoint recovery (#251 `hiddenInternalLoss` control).

**Canon and published editions remain unchanged until an independent audit of the
source-derived construction is complete.**
