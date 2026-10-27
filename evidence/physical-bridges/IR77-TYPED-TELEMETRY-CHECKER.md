# IR-77 — Verified typed telemetry checker: precise trust boundary

**Input inspiration:** Gemini proposed replacing load-bearing informal `PhysicalInterfaceContract` hypotheses with an executable trace checker. This is a good *finite-evidence* architecture, but the proposed example had a misspelt `TelepiryRecord`, a `sorry`, no first-row check, and a proof conclusion false even for singleton bad logs. It also conflated log correctness with real physical correctness and finite recorded traces with all future physical histories.

**Implemented Lean module:** `PhysicalBridges.IRTypedTraceChecker` (pinned Lean 4.35).

## Accepted record type (already parsed; not raw JSON)

```text
TelemetryRecord:
  timestamp: Nat
  measuredEnergy: Int
  measuredValue: Int
  powerInput: Int
  drainRate: Int

CheckConfig:
  reserve: Int
  kappa: Int
```

All signed quantities must use *the same externally declared and independently calibrated fixed-point units*. `kappa` is per **one certified time tick** (not arbitrary elapsed real time); `powerInput` and `drainRate` represent energy delivered/consumed **per interval** in the same fixed-point energy units, despite the original illustrative column names. A production schema should name them `suppliedEnergy` and `spentEnergy`.

The **first** record represents the pre-interval state and must have timestamp zero, zero supplied/spent intervals, and recorded energy at least the configured reserve. The checker also rejects a negative reserve or negative kappa.

Every subsequent record must represent the next consecutive tick, with nonnegative supplied/spent integer energy, `spent ≤ supplied`, exact logged energy balance, recorded energy at least reserve, and logged scalar descent no greater than kappa.

The `spent ≤ supplied` requirement is a *sufficient contract for indefinite-reserve construction when independently uniform for all disturbances*, but overly restrictive as a characterization of arbitrary legitimate battery operation: energy may validly decrease during a finite interval while staying above reserve. Do not call this a sound-and-complete X3 feasibility decider.

## Verified source-level theorem

```lean
verifyTraceData cfg records = true
  -> TraceValid cfg records
```

A structural proof over arbitrary lists is checked in Lean. Corollaries prove every accepted recorded energy is at or above reserve, each recorded transition is balanced, and all certified steps have input energy at least spent energy. A valid three-record example and hostile controls are kernel-checked.

**Negative controls:** empty or invalid initial state, skipped tick, forged energy-balance value, undersupplied step, excessive recorded scalar descent. The source also constructs an observational alias: an accepted record sequence is consistent with a *separately postulated* actual physical energy value below reserve if **no measurement/refinement correspondence is supplied**. That is why `true` from a recorded-data checker is not unconditional physical certification.

## Required external evidence and what can really be claimed

| Boundary | What checker establishes | What must still be supplied |
| --- | --- | --- |
| Data parsing | Decidable soundness for **typed Lean records** | A verified/independently validated JSON parser and exact schema for dates, integer magnitudes, rejection of missing fields, overflow, duplicates and unit metadata |
| Integrity | No fact about file authenticity | Cryptographic authentication chain, anti-rollback, producer/collector independence, secure timestamps and independent audit of signed raw bytes |
| Sensing | Logical inequalities for **logged values** | Calibrated error envelope linking the sensor to actual temperature/energy or physical quantity; signed truth mapping and interval coverage |
| Continuous physics | Consecutive integer tick labels | Inter-sample safety bounds, unobserved transients, all causal channels and physically complete mediation |
| Resource accounting | Each logged interval has nonnegative inputs/cost and balances in typed integer arithmetic | Engineering proof true supply, drain, storage loss, thermal/quantum effects and maintenance costs are measured and budgeted in consistent dimensions |
| Physical robustness | One **finite actual log segment**, if the above semantic joins hold | Independent universal bound over all admitted future disturbances; only then can IR-74's all-horizon invariant be invoked |
| Original X3 | No subject-continuation claim | Historical identity, actual delivered protected service, autonomous choice, all original priorities, all feasible futures, source-complete physical implementation |
| IR-75 cut work | No cut-information measurements are checked in IR-77 | Per-protocol *required* new information converse, all side info, actual cut capacity, active-edge power and nonbypass completeness |

**No 'zero trust' claim:** even a perfect decidable Lean program with no user `axiom` relies on the meaning and fidelity of its parsed data, the compiler/runtime environment, proof-kernel and hardware chain. The result removes one class of mistaken manual arithmetic and makes a source-level acceptance predicate auditable, which is useful. It does not replace physical measurement premises with logic.

**No 'zero breach' claim:** if the checker accepts a finite trace, it does not prove the future will be compliant, or that a physical fault between measured ticks was absent.

**Source and canon:** Original X3 and Zenodo 23599528 are unmodified. This repair is compatible with original strongest X3 targets, but supplies only a narrower concrete evidence subsystem. Only claim it is FORMALLY_CHECKED after pinned CI and assurance-ledger checks pass.
