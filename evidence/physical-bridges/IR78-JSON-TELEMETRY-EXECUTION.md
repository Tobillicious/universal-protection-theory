# IR-78 — Fail-closed JSON telemetry ingestion and executable CI certificates

**Source:** Gemini's verified trace-checker idea, repaired in IR-77.
This module accepts **raw JSON text** through Lean's `Lean.Json.parse`
and field decoders. It is a software-level certificate for a **finite
recorded** trace; it does not certify reality or infinite X3.

## Verified implication

```lean
verifyJsonText raw = true
  → ∃ cert, decodeTraceJson raw = .ok cert ∧
      IRTypedTraceChecker.TraceValid cert.cfg cert.records
```

The theorem is kernel-checked in Lean. Its corollary proves the
recorded energy of every accepted row is ≥ the declared reserve.

The decoder fails closed when the JSON is malformed; required
record fields are absent or mistyped; the sample period is zero;
the instrument ID is blank; the schema version is not 1; or the
unit tags are not exactly `microjoule` and `scaled-scalar`.
All five fields on every row are explicitly parsed as integer or
natural-number numeric JSON values: timestamp, measuredEnergy,
measuredValue, powerInput and drainRate. No externally trusted
Python-to-Lean data-conversion script is required.

The executable IR-77 step checks further reject consecutive tick
gaps, missing baseline, invalid balance, insufficient logged supply,
recorded reserve violations and excessive recorded drift.

### Run with the pinned Lean toolchain

From `evidence/physical-bridges`:

```sh
lake env lean --run checks/ir78_check_file.lean fixtures/ir78-valid.json
# Expected exit 0, IR78_RECORDED_TRACE_CHECK_PASSED

lake env lean --run checks/ir78_check_file.lean fixtures/ir78-bad-tick.json
# Expected nonzero exit, IR78_RECORDED_TRACE_CHECK_FAILED

lake env lean --run checks/ir78_check_file.lean fixtures/ir78-missing-field.json
# Expected nonzero exit, IR78_RECORDED_TRACE_CHECK_FAILED
```

The CI workflow executes these real-file positive and negative
controls after pinned Lean proof compilation.

An accepted JSON text declares:
- `schema_version: 1`.
- `energy_unit: "microjoule"`; signed integer energy credits and per-
  interval supplied and spent *energy* are all in this unit. Note the
  historical `powerInput` and `drainRate` names are misleading: the
  implemented equality is **energy per step**, not instantaneous watts.
- `value_unit: "scaled-scalar"`; its physical quantity, scale
  and sensor calibration must be stated separately in an instrument
  contract.
- `sample_period_ns`, a positive declared period; a timestamp
  increment proves only the LOG labels advance by one, not real
  nanoseconds or absence of events between measurements.
- `instrument_id`, a nonempty label which is not a signature or
  authenticated hardware identity.
- `config: {"reserve":...,"kappa":...}` and `records:[...]`.

## What the end-to-end theorem does NOT certify

1. **Honest logging:** A malicious sensor/controller can emit a
   perfectly well-formed and checker-approved JSON trace that differs
   from actual voltages, energy or physical effects. IR-77 proves a
   separate *conditional* sensor-error margin theorem; the source
   must be externally authenticated/calibrated.
2. **Complete measurement:** an unobserved transient or physical
   bypass between logged ticks need not be witnessed by integer tick
   labels. Exhaustive causal-route mediation and bounded intersample
   physics remain independently necessary.
3. **Authentic fixed units:** the strings `microjoule` and
   `scaled-scalar` only identify a declared scale. A file is free
   to misstate them. Physical calibration does not follow from a tag.
4. **Cryptographic provenance and duplicate-key normalization:**
   the standard JSON parser's handling of duplicate keys is not
   independently certified by IR-78 as a canonical authenticated
   transport. A true deployment needs strict canonicalization or
   a signed canonical format, anti-replay nonce/session binding,
   monotonic secure clock and independent collection.
5. **Future behavior:** even indefinitely many *possible* source
   trace checks do not establish all-horizon robust feasibility
   without a uniform policy, physical replenishment and all
   disturbance coverage (IR-72/74).
6. **Original X3:** neither retained particular identity, continued
   service, independent freedom to change, third/higher original
   priorities nor universal full feasible maximality follows from
   an energy/threshold log. IR-75's all-protocol necessary area-cut
   traffic and IR-76's physical bath transport are separate issues.

This certificate improves the evidence-generation architecture,
not its empirically unproved physics. No archived Zenodo text or
original X3 scope is edited.
