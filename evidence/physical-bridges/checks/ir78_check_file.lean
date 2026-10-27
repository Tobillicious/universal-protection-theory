/-
IR-78 CLI entrypoint. Usage from evidence/physical-bridges:
  lake env lean --run checks/ir78_check_file.lean fixtures/ir78-valid.json
The exit status means ONLY the JSON text passes the finite
typed recorded-data checker. It is not physical certification.
-/
import PhysicalBridges.IRJsonTraceChecker

def main (args : List String) : IO UInt32 := do
  match args with
  | [path] =>
      let raw ← IO.FS.readFile path
      if PhysicalBridges.IRJsonTraceChecker.verifyJsonText raw then
        IO.println "IR78_RECORDED_TRACE_CHECK_PASSED"
        pure 0
      else
        IO.eprintln "IR78_RECORDED_TRACE_CHECK_FAILED"
        pure 1
  | _ =>
      IO.eprintln "Usage: ir78_check_file.lean PATH_TO_TELEMETRY_JSON"
      pure 2
