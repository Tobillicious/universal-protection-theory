import Lean
import Snuffy.IRTypedTraceChecker

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRJsonTraceChecker.lean` at main `740abbb` (sha256 `bfb1c42ef6b957e82f7449455d6776deea13ec16fdae2f14faba6ac1e7adb7b8`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-78: end-to-end JSON TEXT → TYPED telemetry decoding →
existing IR-77 Boolean checker → kernel-proved RECORDED trace contract.

The standard Lean JSON parser and JSON integer field decoders are used
on raw text. Missing, noninteger, wrong-typed, invalid-unit/version
and malformed inputs fail closed in the executable wrapper. No
independently handwritten external Python conversion is trusted.

Important trust limits: input bytes, complete physical inventory,
unit calibration, sensor/clock truth, JSON duplication/canonical
serialization and cryptographic signatures remain external evidence.
Do not infer actual physical safety or infinite X3 from finite JSON.
-/

namespace PhysicalBridges.IRJsonTraceChecker

open Lean
open IRTypedTraceChecker

structure JsonTrace where
  schemaVersion : Nat
  instrumentId : String
  energyUnit : String
  valueUnit : String
  samplePeriodNs : Nat
  cfg : CheckConfig
  records : List TelemetryRecord
deriving Repr

def objNat (j : Json) (key : String) : Except String Nat := do
  let v ← j.getObjVal? key
  v.getNat?

def objInt (j : Json) (key : String) : Except String Int := do
  let v ← j.getObjVal? key
  v.getInt?

def objStr (j : Json) (key : String) : Except String String := do
  let v ← j.getObjVal? key
  v.getStr?

def decodeRecord (j : Json) : Except String TelemetryRecord := do
  let timestamp ← objNat j "timestamp"
  let measuredEnergy ← objInt j "measuredEnergy"
  let measuredValue ← objInt j "measuredValue"
  let powerInput ← objInt j "powerInput"
  let drainRate ← objInt j "drainRate"
  pure {
    timestamp := timestamp
    measuredEnergy := measuredEnergy
    measuredValue := measuredValue
    powerInput := powerInput
    drainRate := drainRate
  }

def decodeConfig (j : Json) : Except String CheckConfig := do
  let reserve ← objInt j "reserve"
  let kappa ← objInt j "kappa"
  pure { reserve := reserve, kappa := kappa }

/-- Deliberately hard-coded synthetic calibration schema version and
units, rejecting unspecified scales. These strings are merely tags,
not independently validated SI calibrations. -/
def decodeTraceJson (raw : String) : Except String JsonTrace := do
  let j ← Json.parse raw
  let schemaVersion ← objNat j "schema_version"
  if schemaVersion != 1 then
    throw "unsupported schema_version"
  let energyUnit ← objStr j "energy_unit"
  if energyUnit != "microjoule" then
    throw "unsupported energy_unit"
  let valueUnit ← objStr j "value_unit"
  if valueUnit != "scaled-scalar" then
    throw "unsupported value_unit"
  let samplePeriodNs ← objNat j "sample_period_ns"
  if samplePeriodNs == 0 then
    throw "zero sample_period_ns"
  let instrumentId ← objStr j "instrument_id"
  if instrumentId.isEmpty then
    throw "empty instrument_id"
  let cfgJson ← j.getObjVal? "config"
  let cfg ← decodeConfig cfgJson
  let recordsJson ← j.getObjVal? "records"
  let arr ← recordsJson.getArr?
  let records ← arr.toList.mapM decodeRecord
  pure {
    schemaVersion := schemaVersion
    instrumentId := instrumentId
    energyUnit := energyUnit
    valueUnit := valueUnit
    samplePeriodNs := samplePeriodNs
    cfg := cfg
    records := records
  }

/-- Computational pass/fail on JSON text. An error in parsing any
REQUIRED field or a failed IR-77 trace condition returns false. -/
def verifyJsonText (raw : String) : Bool :=
  match decodeTraceJson raw with
  | .error _ => false
  | .ok cert => verifyTraceData cert.cfg cert.records

/-- The important end-to-end formal implication. No unproved
"parser integrity" hypothesis appears: the theorem refers to
the concrete Lean Json.parse/getInt? decoding expression above.
It proves accepted TEXT parses to a valid TYPED recorded trace,
not that the text came from authenticated true physical hardware. -/
theorem verifyJsonText_sound
    (raw : String)
    (hAccepted : verifyJsonText raw = true) :
    ∃ cert : JsonTrace,
      decodeTraceJson raw = .ok cert ∧
      TraceValid cert.cfg cert.records := by
  unfold verifyJsonText at hAccepted
  cases hDecoded : decodeTraceJson raw with
  | error message =>
      simp [hDecoded] at hAccepted
  | ok cert =>
      refine ⟨cert,rfl,?_⟩
      exact verifyTraceData_sound cert.cfg cert.records
        (by simpa [hDecoded] using hAccepted)

/-- Any accepted JSON text has recorded energy at/above reserve
for every row, using the previously verified IR-77 source theorem. -/
theorem verifyJsonText_recorded_reserve
    (raw : String)
    (hAccepted : verifyJsonText raw = true) :
    ∃ cert : JsonTrace,
      decodeTraceJson raw = .ok cert ∧
      ∀ r, r ∈ cert.records →
        cert.cfg.reserve ≤ r.measuredEnergy := by
  obtain ⟨cert,hDecode,hValid⟩ :=
    verifyJsonText_sound raw hAccepted
  refine ⟨cert,hDecode,?_⟩
  exact IRTypedTraceChecker.accepted_trace_every_record_above_reserve
    cert.cfg cert.records (by
      have hPass : verifyTraceData cert.cfg cert.records = true := by
        simpa [verifyJsonText,hDecode] using hAccepted
      exact hPass)

/-- Synthetic JSON fixture checked wholly within Lean's expression
evaluator, for an externally specified fake instrument ID. -/
def goodJson : String := "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":1,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2},{\"timestamp\":2,\"measuredEnergy\":11,\"measuredValue\":98,\"powerInput\":2,\"drainRate\":2}]}"

-- (finite check, run in the source repository's CI) #eval verifyJsonText goodJson

def missing_field_json : String :=
  "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0}]}"

-- (finite check, run in the source repository's CI) #eval verifyJsonText missing_field_json

def mistyped_timestamp_json : String :=
  "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":\"0\",\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0}]}"

-- (finite check, run in the source repository's CI) #eval verifyJsonText mistyped_timestamp_json

def unsupported_unit_json : String :=
  "{\"schema_version\":1,\"energy_unit\":\"joule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":1,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2},{\"timestamp\":2,\"measuredEnergy\":11,\"measuredValue\":98,\"powerInput\":2,\"drainRate\":2}]}"

-- (finite check, run in the source repository's CI) #eval verifyJsonText unsupported_unit_json

def invalid_step_json : String :=
  "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":9,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2}]}"

-- (finite check, run in the source repository's CI) #eval verifyJsonText invalid_step_json

-- (finite check, run in the source repository's CI) #eval verifyJsonText "{invalid-json"


end PhysicalBridges.IRJsonTraceChecker
