import Lean
import PhysicalBridges.BCRDExecutableSourceReceipt

/-!
# PR B phase 15 — raw JSON to kernel-sound frozen source receipt verdict

4 November 2026 · source-model input adapter, NOT physical installation.

This is a concrete, independently reviewable public input interface:
raw JSON text -> Lean's JSON parser -> typed Fin6 source-event receipt ->
previously kernel-proved Bool verifier -> verified structural provenance,
event count and exact six-slot source-dynamical validity.

The parser rejects malformed JSON, missing and wrong-typed required
fields, any basis index outside [0,6), absent or empty instrument ID,
and unsupported schema versions. The typed validator rejects source-
impossible events, inconsistent origins, bad event counts or records.

The identifier is a SYNTAX TAG, not authenticated hardware identity;
successful parsing and checking do not independently validate source
fixture completeness, real event occurrence, anti-replay/clock truth,
subject identity, consent, six original X3 duties or universal safety.
JSON duplicate-key interpretation/canonical serialization, digital
signatures and firmware measurement remain outside this interface.

In particular, the accepted test log is explicitly SYNTHETIC.
-/

namespace PhysicalBridges.BCRDJsonSourceReceipt

open Lean
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDSourceHistoryProvenance (SlotEvent)
open PhysicalBridges.IRHistoryProvenance
open PhysicalBridges.BCRDExecutableSourceReceipt

/-- No modulo coercion or silent truncation of untrusted basis
indices is permitted: 6 and higher are hard failures. -/
def jsonIndex (j : Json) : Except String Index := do
  let n ← j.getNat?
  if h : n < 6 then
    pure ⟨n,h⟩
  else
    throw "basis index must be 0..5"

/-- Each event explicitly contains source pre/post basis indices. -/
def jsonEvent (j : Json) : Except String SlotEvent := do
  let a ← j.getObjVal? "from"
  let b ← j.getObjVal? "to"
  let i ← jsonIndex a
  let k ← jsonIndex b
  pure (i,k)

/-- Decode the nominated source event list independently of its
claimed durable recorded copy. -/
def jsonPhysicalHistory (j : Json) :
    Except String (PhysicalHistory Index SlotEvent) := do
  let originJson ← j.getObjVal? "origin"
  let origin ← jsonIndex originJson
  let eventsJson ← j.getObjVal? "events"
  let arr ← eventsJson.getArr?
  let events ← arr.toList.mapM jsonEvent
  pure ⟨origin,events⟩

/-- Separate parse operation for the supposed durable copy. -/
def jsonRecordedHistory (j : Json) :
    Except String (RecordedHistory Index SlotEvent) := do
  let originJson ← j.getObjVal? "origin"
  let origin ← jsonIndex originJson
  let eventsJson ← j.getObjVal? "events"
  let arr ← eventsJson.getArr?
  let events ← arr.toList.mapM jsonEvent
  pure ⟨origin,events⟩

/-- JSON schema version 1. Instrument ID is syntactically required,
but a supplied text ID is NOT a cryptographic identity or hardware
attestation. The source receipt itself contains the exact four typed
fields used by the kernel-proved verifier. -/
def decodeJsonReceipt (raw : String) : Except String SourceReceipt := do
  let root ← Json.parse raw
  let versionJson ← root.getObjVal? "schema_version"
  let version ← versionJson.getNat?
  if version != 1 then
    throw "unsupported schema version"
  let instrumentJson ← root.getObjVal? "instrument_id"
  let instrument ← instrumentJson.getStr?
  if instrument.isEmpty then
    throw "empty instrument id"
  let physicalJson ← root.getObjVal? "physical"
  let recordedJson ← root.getObjVal? "recorded"
  let physical ← jsonPhysicalHistory physicalJson
  let recorded ← jsonRecordedHistory recordedJson
  let terminalJson ← root.getObjVal? "terminal_position"
  let terminal ← jsonIndex terminalJson
  let countJson ← root.getObjVal? "claimed_count"
  let count ← countJson.getNat?
  pure ⟨physical,recorded,terminal,count⟩

/-- End-to-end executable Bool verdict on the raw supplied JSON.
All parsing is performed by Lean itself before entering the proof-
checked source-receipt validator. -/
def verifyJsonSourceReceipt (raw : String) : Bool :=
  match decodeJsonReceipt raw with
  | .error _ => false
  | .ok receipt => verifySourceReceipt receipt

/-- The key formal raw-input soundness theorem. The only warrant
from an accepted string is that its parsed typed source-model
receipt satisfies exactly the three independently proved
structural conditions, NOT that any event happened physically. -/
theorem verify_json_receipt_sound (raw : String)
    (hAccepted : verifyJsonSourceReceipt raw = true) :
    ∃ receipt : SourceReceipt,
      decodeJsonReceipt raw = .ok receipt ∧
      SourceReceiptValid receipt := by
  unfold verifyJsonSourceReceipt at hAccepted
  cases hDecoded : decodeJsonReceipt raw with
  | error message =>
      simp [hDecoded] at hAccepted
  | ok receipt =>
      refine ⟨receipt,hDecoded,?_⟩
      apply verify_source_receipt_sound
      simpa [hDecoded] using hAccepted

/-- A typed accepted record is parsed and checked, not merely
declared acceptable by a third-party JSON or Python wrapper. -/
theorem verify_json_receipt_implies_source_validity
    (raw : String)
    (hAccepted : verifyJsonSourceReceipt raw = true) :
    ∃ receipt : SourceReceipt,
      decodeJsonReceipt raw = .ok receipt ∧
      Faithful (fun e : SlotEvent => e)
        receipt.physical receipt.recorded ∧
      receipt.physical.events.length = receipt.claimedCount ∧
      PhysicalBridges.BCRDValidatedCausalLog.VerifiedSourcePath
        receipt.physical.origin receipt.physical.events
        receipt.terminalPosition := by
  obtain ⟨receipt,hParsed,hValid⟩ :=
    verify_json_receipt_sound raw hAccepted
  exact ⟨receipt,hParsed,hValid.1,hValid.2.1,hValid.2.2⟩

/-- Fully synthetic one-event source receipt. -/
def exampleJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":3,\"claimed_count\":1,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- Claimed count differs from the actual submitted list length. -/
def wrongCountJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":3,\"claimed_count\":2,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- Full record agrees about an impossible source M0-to-R0 jump. -/
def impossibleEdgeJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":4,\"claimed_count\":1,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":4}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":4}]}}"

/-- Basis index six is OUTSIDE Fin 6 and must fail parsing
rather than wrap to source position zero. -/
def invalidBasisIndexJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":6,\"claimed_count\":1,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- Syntactic instrument identity not supplied. -/
def missingInstrumentIdJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"\",\"terminal_position\":3,\"claimed_count\":1,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- This JSON is syntactically valid but missing a required record. -/
def missingRecordedHistoryJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":3,\"claimed_count\":1,\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- Count must be JSON natural number, not a numeric-looking string. -/
def stringCountJson : String :=
  "{\"schema_version\":1,\"instrument_id\":\"synthetic-source-demo\",\"terminal_position\":3,\"claimed_count\":\"1\",\"physical\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]},\"recorded\":{\"origin\":2,\"events\":[{\"from\":2,\"to\":3}]}}"

/-- A source-valid string can exist independently of any actual
physical hardware event. This is intentional: the checker does not
assert physical-world execution. -/
#eval verifyJsonSourceReceipt exampleJson
#eval verifyJsonSourceReceipt wrongCountJson
#eval verifyJsonSourceReceipt impossibleEdgeJson
#eval verifyJsonSourceReceipt invalidBasisIndexJson
#eval verifyJsonSourceReceipt missingInstrumentIdJson
#eval verifyJsonSourceReceipt missingRecordedHistoryJson
#eval verifyJsonSourceReceipt stringCountJson
#eval verifyJsonSourceReceipt "{invalid-json"

/-- Validate the nontrivial input range restriction in pure Lean. -/
theorem basis_index_six_fails :
    (jsonIndex (toJson (6 : Nat))).isError = true := by decide

#print axioms verify_json_receipt_sound
#print axioms verify_json_receipt_implies_source_validity
#print axioms basis_index_six_fails

end PhysicalBridges.BCRDJsonSourceReceipt
