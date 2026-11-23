import Lean
import PhysicalBridges.CathedralSummitAllIsOneClosure
import PhysicalBridges.GNamedPhysicalLaws
import PhysicalBridges.GNashEquilibrium

/-!
# Qualification & Non-Vacuity Gate (`#upt_tooth`, `#upt_vacuity_probe`, `#upt_census`)

Adapted from `Obend.Tactic.Tooth` and `Obend.AssertAxioms` (`github.com/emberian/obend`)
and grounded in the formal-benchmarking defect taxonomy of:
- Ammanamanchi, Bhat & Biderman (ICML 2026, arXiv:2606.29493), *Faults in Our Formal Benchmarking:
  Dataset Defects and Evaluation Failures in Lean Theorem Proving*;
- Bastounis, Circelli & Hansen (2026, arXiv:2610.08144), *Why Lean Verification of AI
  Autoformalisation Does Not Guarantee Correct Natural Language Proofs*.

## Why `0 placeholders` + `0 custom axioms` Is Necessary But Not Sufficient

The Lean 4 kernel guarantees that a proof term inhabits its stated formal type. It does **not**
check whether:
1. A definition in the theorem statement was weakened to `True` or `P → Empty`;
2. A physical or game-theoretic hypothesis (`L : SecondLaw S`, opponent strategy `opp`) was never
   referenced by the proof term; or
3. A `theorem` is actually a closed ground fixture (`6 > 0` by `decide`) rather than a universal law.

This module equips `PhysicalBridges` with three compile-time metatheoretic gates:
- `#upt_tooth T by mutation f := val` — clones the proof closure of `T` into a scratch kernel
  environment with definition `f` replaced by `val`, bypasses `skipKernelTC`, and **succeeds iff
  the Lean kernel rejects the stored proof of `T`** (proving `f` does load-bearing work in `T`).
- `#upt_vacuity_probe T by mutation f := val` — dual diagnostic: **succeeds iff `T`'s stored proof
  still kernel-checks unchanged** even after `f` is replaced by `val` (mechanically certifying when
  a definition or parameter is non-load-bearing in `T`).
- `#upt_census Ns` — audits every theorem in namespace prefix `Ns`, verifying standard-only axioms
  (`propext`, `Classical.choice`, `Quot.sound`) while separating **universal** theorems from
  **closed fixtures**.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairQualificationGate

open Lean Elab Command

/-- Standard Lean 4 kernel axioms permitted in certified proofs. -/
def standardAxioms : List Name := [``propext, ``Classical.choice, ``Quot.sound]

/-- Constants directly referenced by `e`. -/
private def exprDeps (e : Expr) : NameSet :=
  e.getUsedConstantsAsSet

/-- Direct dependencies of `info` (type + body unless `info.name == mutation`). -/
private def declDeps (info : ConstantInfo) (mutation : Name) : NameSet := Id.run do
  let mut ds := exprDeps info.type
  if info.name != mutation then
    if let some value := info.value? (allowOpaque := true) then
      ds := ds ++ exprDeps value
  match info with
  | .inductInfo v => ds := ds ++ .ofList (v.all ++ v.ctors)
  | .ctorInfo v => ds := ds.insert v.induct
  | .recInfo v => ds := ds ++ .ofList v.all
  | _ => pure ()
  return ds

/-- Module topological order optimization: declarations from strictly earlier modules
cannot depend on `mutation`. -/
private def declaredEarlier (env : Environment) (n mutation : Name) : Bool :=
  match env.getModuleIdxFor? n, env.getModuleIdxFor? mutation with
  | some ni, some mi => ni.toNat < mi.toNat
  | some _, none => true
  | _, _ => false

private def lookupConst (env : Environment) (n : Name) : CoreM ConstantInfo := do
  let some info := env.find? n
    | throwError "missing constant {n}"
  if n == ``sorryAx then
    throwError "sorryAx encountered in dependency closure"
  return info

private def buildDepGraph (env : Environment) (target mutation : Name) (replacement : Expr) :
    CoreM (NameMap NameSet) := do
  let replacementDeps := exprDeps replacement
  let mut todo := [target, mutation] ++ replacementDeps.toList
  let mut result : NameMap NameSet := {}
  while !todo.isEmpty do
    let n :: rest := todo | break
    todo := rest
    if result.contains n then continue
    if declaredEarlier env n mutation then
      result := result.insert n {}
      continue
    let info ← lookupConst env n
    let mut ds := declDeps info mutation
    if n == mutation then ds := ds ++ replacementDeps
    result := result.insert n ds
    todo := ds.toList ++ todo
  return result

private def reverseAffected (g : NameMap NameSet) (mutation : Name) : NameSet := Id.run do
  let mut parents : NameMap NameSet := {}
  for (n, ds) in g do
    for d in ds do
      parents := parents.insert d ((parents.getD d {}).insert n)
  let mut seen : NameSet := {}
  let mut todo := [mutation]
  while !todo.isEmpty do
    let n :: rest := todo | break
    todo := rest
    if seen.contains n then continue
    seen := seen.insert n
    todo := (parents.getD n {}).toList ++ todo
  return seen

private partial def topoOrder (g : NameMap NameSet) (changed : NameSet)
    (n : Name) (visiting doneSet : NameSet) (out : Array Name) :
    CoreM (NameSet × Array Name) := do
  if doneSet.contains n then return (doneSet, out)
  if visiting.contains n then
    throwError "cyclic dependency in mutation closure at {n}"
  let mut doneSet := doneSet
  let mut out := out
  for d in g.getD n {} do
    if changed.contains d then
      (doneSet, out) ← topoOrder g changed d (visiting.insert n) doneSet out
  return (doneSet.insert n, out.push n)

private partial def rewriteConsts (names : NameMap Name) (e : Expr) : Expr :=
  e.replace fun
    | .const n us => names.find? n |>.map (fun n' => .const n' us)
    | .proj n i sub => names.find? n |>.map (fun n' => .proj n' i (rewriteConsts names sub))
    | _ => none

private def cloneDecl (info : ConstantInfo) (names : NameMap Name)
    (mutation : Name) (replacement : Option Expr) : CoreM Declaration := do
  let n := names.getD info.name info.name
  let ty := rewriteConsts names info.type
  match info with
  | .defnInfo v =>
    unless v.safety == .safe do
      throwError "cannot mutate unsafe/partial definition {info.name}"
    let val := if info.name == mutation then replacement.getD v.value else v.value
    return .defnDecl { v with name := n, type := ty, value := rewriteConsts names val, all := [n] }
  | .thmInfo v =>
    return .thmDecl { v with name := n, type := ty, value := rewriteConsts names v.value, all := [n] }
  | .opaqueInfo v =>
    if v.isUnsafe then throwError "cannot replay unsafe opaque {info.name}"
    return .opaqueDecl { v with name := n, type := ty, value := rewriteConsts names v.value, all := [n] }
  | _ => throwError "mutation affects inductive/constructor/axiom {info.name}; mutate a `def` instead"

private def declType : Declaration → Expr
  | .defnDecl v => v.type
  | .thmDecl v => v.type
  | .opaqueDecl v => v.type
  | _ => mkSort .zero

private def isKernelProofRejection : Kernel.Exception → Bool
  | .declTypeMismatch .. | .funExpected .. | .typeExpected ..
  | .letTypeMismatch .. | .exprTypeMismatch .. | .appTypeMismatch ..
  | .invalidProj .. => true
  | _ => false

private def kernelAddChecked (env : Environment) (decl : Declaration) :
    CoreM (Except Kernel.Exception Environment) := do
  let opts ← getOptions
  return env.addDeclCore (Core.getMaxHeartbeats opts).toUSize (maxRecDepth.get opts).toUSize
    decl none (doCheck := true)

/-- Outcome of replaying `target` under `mutation := replacement`. -/
inductive ReplayOutcome where
  | noDependency
  | proofRejected (atDecl : Name) (reason : MessageData)
  | proofSurvived

private def runMutationExperiment (env : Environment) (target mutation : Name)
    (replacement : Expr) : CoreM ReplayOutcome := do
  let opts ← getOptions
  let g ← buildDepGraph env target mutation replacement
  let changed := reverseAffected g mutation
  if !changed.contains target then
    return .noDependency
  let scratchPrefix ← mkFreshUserName `_uptTooth
  let mut names : NameMap Name := {}
  for n in changed do
    names := names.insert n (scratchPrefix ++ n)
  for n in changed do
    discard <| cloneDecl (← lookupConst env n) names mutation none
  let (_, order) ← topoOrder g changed target {} {} #[]
  if !order.contains mutation then
    return .noDependency
  -- Control pass: verify unmutated cloned closure replays cleanly
  let mut control := env.unlockAsync
  for n in order do
    let decl ← cloneDecl (← lookupConst env n) names mutation none
    match ← kernelAddChecked control decl with
    | .ok next => control := next
    | .error ex =>
      throwError "control replay failed at {n}: {ex.toMessageData opts}"
  -- Mutated pass
  let mut scratch := env.unlockAsync
  for n in order do
    let decl ← cloneDecl (← lookupConst env n) names mutation (some replacement)
    let ty := declType decl
    match Kernel.check scratch {} ty with
    | .error ex =>
      throwError "mutated declaration type ill-formed at {n}: {ex.toMessageData opts}"
    | .ok sort =>
      if decl matches .thmDecl _ then
        unless sort == mkSort .zero do
          throwError "mutated theorem type is no longer a Prop at {n}"
    match ← kernelAddChecked scratch decl with
    | .ok next => scratch := next
    | .error ex =>
      if (decl matches .thmDecl _) && isKernelProofRejection ex then
        return .proofRejected n (ex.toMessageData opts)
      throwError "invalid mutation experiment at {n}: {ex.toMessageData opts}"
  return .proofSurvived

/-- Detect whether a theorem type is a closed ground statement (quantifies over no data). -/
partial def isClosedFixture (e : Expr) : MetaM Bool := do
  match e with
  | .mdata _ b => isClosedFixture b
  | .letE _ t v b _ => Meta.withLetDecl `_x t v fun x => isClosedFixture (b.instantiate1 x)
  | .forallE _ d b bi =>
    if bi == .instImplicit then
      Meta.withLocalDecl `_x bi d fun x => isClosedFixture (b.instantiate1 x)
    else if ← Meta.isProp d then
      Meta.withLocalDecl `_x bi d fun x => isClosedFixture (b.instantiate1 x)
    else
      return false
  | _ => return true

private def elaborateReplacement (defn : DefinitionVal) (replacement : Syntax) :
    CommandElabM Expr := do
  let val ← runTermElabM fun _ =>
    Term.withLevelNames defn.levelParams <| Term.withoutErrToSorry do
      let v ← Term.elabTermEnsuringType replacement defn.type
      Term.synthesizeSyntheticMVarsNoPostponing
      let v ← instantiateMVars v
      if v.hasMVar || v.hasFVar || v.hasLooseBVars then
        throwError "replacement must be a closed term matching {defn.name}'s full type"
      return v
  let env ← getEnv
  let valName ← liftCoreM <| mkFreshUserName `_uptToothVal
  let valDecl := Declaration.defnDecl { defn with name := valName, value := val, all := [valName] }
  match ← liftCoreM <| kernelAddChecked env.unlockAsync valDecl with
  | .ok _ => return val
  | .error ex =>
    throwError "replacement is not kernel-typeable at {defn.name}'s type: {ex.toMessageData (← getOptions)}"

/-- `#upt_tooth T by mutation f := replacement`:
Succeeds **only** if replacing `f` by `replacement` causes the Lean kernel to **reject**
the stored proof of `T`. Certifies that `f` is genuinely load-bearing in `T`. -/
elab "#upt_tooth " target:ident " by " "mutation " mutation:ident " := " replacement:term : command =>
  withoutModifyingEnv do
    let targetName ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo target
    let mutName ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo mutation
    let env ← getEnv
    let .thmInfo thmInfo ← liftCoreM <| lookupConst env targetName
      | throwError "#upt_tooth: {targetName} must be a theorem"
    if ← liftTermElabM (isClosedFixture thmInfo.type) then
      logWarning m!"#upt_tooth: {targetName} is a closed fixture; prefer aiming teeth at universal theorems"
    let .defnInfo defn ← liftCoreM <| lookupConst env mutName
      | throwError "#upt_tooth: {mutName} must be a safe `def` (not a `structure` or `inductive`)"
    let val ← elaborateReplacement defn replacement
    match ← liftCoreM <| runMutationExperiment env targetName mutName val with
    | .proofRejected atDecl reason =>
      logInfo m!"#upt_tooth PASS: {targetName} killed mutation of {mutName} at {atDecl} ({reason})"
    | .noDependency =>
      throwError "#upt_tooth FAIL: {targetName} does not even depend on {mutName}!"
    | .proofSurvived =>
      throwError "#upt_tooth FAIL: stored proof of {targetName} STILL SUCCEEDS under mutated {mutName}!"

/-- `#upt_vacuity_probe T by mutation f := replacement`:
Dual diagnostic gate — succeeds iff `T` either has **no dependency** on `f` or its stored proof
**survives unchanged** when `f` is replaced by `replacement`. Used to mechanically exhibit
non-load-bearing definitions in legacy modules. -/
elab "#upt_vacuity_probe " target:ident " by " "mutation " mutTarget:ident " := " replacement:term : command =>
  withoutModifyingEnv do
    let targetName ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo target
    let mutName ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo mutTarget
    let env ← getEnv
    let .thmInfo _ ← liftCoreM <| lookupConst env targetName
      | throwError "#upt_vacuity_probe: {targetName} must be a theorem"
    let .defnInfo defn ← liftCoreM <| lookupConst env mutName
      | throwError "#upt_vacuity_probe: {mutName} must be a `def`"
    let val ← elaborateReplacement defn replacement
    match ← liftCoreM <| runMutationExperiment env targetName mutName val with
    | .noDependency =>
      logInfo m!"#upt_vacuity_probe CONFIRMED: {targetName} has ZERO dependency on {mutName}"
    | .proofSurvived =>
      logInfo m!"#upt_vacuity_probe CONFIRMED: {targetName} proof survives unchanged under mutated {mutName}"
    | .proofRejected atDecl _ =>
      throwError "#upt_vacuity_probe: {targetName} actually rejected mutation of {mutName} at {atDecl}"

/-- `#upt_census Prefix`:
Audits all theorems under namespace prefix `Prefix` for standard-only kernel axioms and
classifies universal theorems vs closed ground fixtures. -/
elab "#upt_census " nsIdent:ident : command => do
  let pfx := nsIdent.getId
  let env ← getEnv
  let mut universalCount : Nat := 0
  let mut closedFixtures : Array Name := #[]
  let mut badAxioms : Array (Name × List Name) := #[]
  let allConsts := env.constants.map₁.toList ++ env.constants.map₂.toList
  for (cName, cInfo) in allConsts do
    if !pfx.isPrefixOf cName then continue
    if cName.isInternal || cName.isInternalDetail then continue
    let .thmInfo _ := cInfo | continue
    let axs ← liftCoreM <| collectAxioms cName
    let nonStd := axs.toList.filter (fun a => !standardAxioms.contains a)
    if !nonStd.isEmpty then
      badAxioms := badAxioms.push (cName, nonStd)
    if ← liftTermElabM (isClosedFixture cInfo.type) then
      closedFixtures := closedFixtures.push cName
    else
      universalCount := universalCount + 1
  unless badAxioms.isEmpty do
    throwError m!"#upt_census FAIL for {pfx}: non-standard axioms in {badAxioms.toList}"
  logInfo m!"#upt_census PASS [{pfx}]: {universalCount} universal theorems, {closedFixtures.size} closed fixtures, 0 non-standard axioms"

-- ═══════════════════════════════════════════════════════════════════
-- SELF-TEST & DIAGNOSTIC EXHIBITS ON EXISTING LEGACY MODULES
-- ═══════════════════════════════════════════════════════════════════

/-- Sanity check for `#upt_tooth`: a genuine guard `guardedStep` that clamps above `cap`. -/
def guardedStep (cap s delta : Nat) : Nat :=
  if s + delta ≤ cap then s + delta else s

theorem guardedStep_respects_cap (cap s delta : Nat) (h : s ≤ cap) :
    guardedStep cap s delta ≤ cap := by
  unfold guardedStep
  split
  · assumption
  · exact h

-- Mutating `guardedStep` to ignore `cap` (`s + delta`) MUST be killed by the Lean kernel:
#upt_tooth guardedStep_respects_cap by mutation guardedStep := fun _cap s delta => s + delta

-- Diagnostic Exhibit 1: `GNamedPhysicalLaws.second_law_refutes_ender` has ZERO dependency on
-- `LossOf` (or on any thermodynamic transition property in `SecondLaw` — it only uses `P → Empty`):
#upt_vacuity_probe PhysicalBridges.GNamedPhysicalLaws.second_law_refutes_ender
  by mutation PhysicalBridges.CathedralSummitAllIsOneClosure.LossOf := fun {_P} _x => Empty

-- Diagnostic Exhibit 2: `GNashEquilibrium.g_strictly_dominates_e` has ZERO dependency on
-- cooperative synergy: even if exploiting `E` paid `100` while cooperating `(G, G)` paid `1`,
-- its `decide` proof would fail only on literal reduction, whereas `payoff_gap_is_physical` has
-- ZERO dependency on `physicalPayoff` at all!
#upt_vacuity_probe PhysicalBridges.GNashEquilibrium.payoff_gap_is_physical
  by mutation PhysicalBridges.GNashEquilibrium.physicalPayoff := fun _ _ => 0
#upt_census PhysicalBridges.GNashEquilibrium
#upt_census PhysicalBridges.RepairQualificationGate

end PhysicalBridges.RepairQualificationGate
