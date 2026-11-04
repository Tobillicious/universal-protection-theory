import Lean
import PhysicalBridges

open Lean Elab Command

/-- Audit the transitive axioms of every public declaration under the actual
compiled project namespace, including definitions used by proof statements. -/
run_cmd do
  let env ← getEnv
  let mut count := 0
  for (name, info) in env.constants.toList do
    if name.toString.startsWith "PhysicalBridges." then
      if let .axiomInfo _ := info then
        throwError "Project namespace contains an axiom declaration: {name}"
      let axs ← collectAxioms name
      for ax in axs do
        unless ax == ``propext || ax == ``Classical.choice || ax == ``Quot.sound do
          throwError "Disallowed transitive axiom {ax} in {name}"
      count := count + 1
  unless count > 0 do
    throwError "No compiled project declarations were audited"
  logInfo m!"PASS: {count} compiled declarations have only permitted transitive axioms"
