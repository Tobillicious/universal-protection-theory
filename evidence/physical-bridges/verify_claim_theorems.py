#!/usr/bin/env python3
"""Bind formal assurance claims to exact imported Lean theorem declarations.

Run after a fresh pinned ``lake build``. This probe checks declaration kind,
defining module, elaborated type, direct theorem dependencies and transitive
axioms from Lean's imported environment. Source fingerprints bind that result
to reviewed files. It does not validate measurements or automatically prove
that a natural-language interpretation follows from its bound proposition.
"""
import argparse
import copy
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
STANDARD_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
NAME = re.compile(r"[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)+")
PREFIX = "UPT_CLAIM_BINDING "
PROBE = r'''import Lean
import PhysicalBridges
open Lean Elab Command
private def reportBinding (n : Name) : CommandElabM Unit := do
  let env ← getEnv
  let some ci := env.find? n | throwError "Missing declaration {n}"
  let .thmInfo thm := ci | throwError "Not a theorem {n}"
  let some modIdx := env.getModuleIdxFor? n | throwError "Not imported {n}"
  let moduleName := env.header.moduleNames[modIdx]!
  let axioms ← collectAxioms n
  let deps := thm.type.getUsedConstants ++ thm.value.getUsedConstants
  let theoremDeps := deps.filter fun d =>
    match env.find? d with
    | some (.thmInfo _) => true
    | _ => false
  let statement ← liftTermElabM do
    return (← Meta.ppExpr thm.type).pretty
  let payload := Json.mkObj [
    ("name", toJson n.toString),
    ("module", toJson moduleName.toString),
    ("statement", toJson statement),
    ("type", toJson (reprStr thm.type)),
    ("axioms", toJson (axioms.map Name.toString)),
    ("direct_theorems", toJson (theoremDeps.map Name.toString))]
  liftIO <| IO.println ("UPT_CLAIM_BINDING " ++ payload.compress)
'''


class BindingError(RuntimeError):
    pass


def require(condition, message):
    if not condition:
        raise BindingError(message)


def digest(value):
    return hashlib.sha256(value).hexdigest()


def claim_fingerprint(claim):
    fields = {k: claim[k] for k in ("id", "scope", "status", "module", "assumptions")}
    return digest(json.dumps(fields, sort_keys=True, separators=(",", ":")).encode())


def validate_static(ledger, bindings):
    require(ledger.get("schema_version") == 1, "Unsupported assurance-ledger schema")
    ledger_claims = ledger.get("claims")
    require(isinstance(ledger_claims, list) and ledger_claims, "Missing assurance claims")
    ledger_ids = [c.get("id") for c in ledger_claims]
    require(all(isinstance(name, str) and name for name in ledger_ids) and
            len(ledger_ids) == len(set(ledger_ids)), "Duplicate/invalid assurance claim id")
    require(bindings.get("schema_version") == 1, "Unsupported theorem-binding schema")
    require(bindings.get("toolchain") == (ROOT / "lean-toolchain").read_text().strip(),
            "The binding was reviewed against a different toolchain")
    formal = {c["id"]: c for c in ledger_claims if c["status"] == "FORMALLY_CHECKED"}
    entries = bindings.get("claims")
    require(isinstance(entries, list) and entries, "Missing claim bindings")
    ids = [c.get("id") for c in entries]
    require(len(ids) == len(set(ids)), "Duplicate theorem-binding claim id")
    require(set(ids) == set(formal), "Formal ledger claims and exact theorem bindings differ")
    imported = set((ROOT / "PhysicalBridges.lean").read_text().splitlines())
    records = {}
    for entry in entries:
        claim = formal[entry["id"]]
        require(claim["scope"] in {"formal", "synthetic"},
                f"{claim['id']}: a model proof cannot certify physical/semantic evidence")
        require(entry.get("claim_fingerprint") == claim_fingerprint(claim),
                f"{claim['id']}: claim scope/module/assumptions changed since review")
        module = claim["module"]
        require(NAME.fullmatch(module) and module.startswith("PhysicalBridges."),
                f"{claim['id']}: invalid source module")
        require(entry.get("module") == module, f"{claim['id']}: module binding mismatch")
        require(f"import {module}" in imported, f"{claim['id']}: module absent from root imports")
        source_path = module.replace(".", "/") + ".lean"
        require(entry.get("source") == source_path, f"{claim['id']}: source path mismatch")
        source = ROOT / source_path
        require(source.is_file(), f"{claim['id']}: source file missing")
        body = source.read_text()
        require(entry.get("source_sha256") == digest(source.read_bytes()),
                f"{claim['id']}: reviewed source fingerprint changed")
        require(entry.get("major_hypotheses") == claim["assumptions"],
                f"{claim['id']}: missing or stale major-hypothesis annotation")
        category = "synthetic_example" if claim["scope"] == "synthetic" else "conditional_mathematical_result"
        require(entry.get("category") == category, f"{claim['id']}: evidence category changed")
        require(isinstance(entry.get("conclusion"), str) and entry["conclusion"].strip(),
                f"{claim['id']}: missing conclusion annotation")
        proofs = entry.get("theorems")
        require(isinstance(proofs, list) and proofs, f"{claim['id']}: no exact supporting theorem")
        for record in proofs + entry.get("negative_controls", []):
            name = record.get("name", "")
            require(NAME.fullmatch(name), f"{claim['id']}: malformed declaration name")
            require(name.startswith(module + "."), f"{name}: namespace/module mismatch")
            line = record.get("source_line")
            require(isinstance(line, int) and line > 0, f"{name}: invalid source location")
            lines = body.splitlines()
            require(line <= len(lines), f"{name}: source line no longer exists")
            short = name.rsplit(".", 1)[1]
            require(re.search(r"\b(?:theorem|lemma)\s+" + re.escape(short) + r"(?:$|\s|[:({])", lines[line-1]),
                    f"{name}: declaration absent at reviewed source location")
            require(isinstance(record.get("type_sha256"), str) and
                    re.fullmatch(r"[0-9a-f]{64}", record["type_sha256"]),
                    f"{name}: missing elaborated-type fingerprint")
            require(isinstance(record.get("direct_theorem_dependencies"), list),
                    f"{name}: missing dependency list")
            require(set(record.get("axioms", [])) <= STANDARD_AXIOMS,
                    f"{name}: binding advertises a nonstandard axiom")
            if name in records:
                require(records[name] == (module, record), f"{name}: conflicting bindings")
            records[name] = (module, record)
    return records


def observe(names, lake):
    for name in names:
        require(NAME.fullmatch(name), "Unsafe or malformed Lean declaration name")
    with tempfile.TemporaryDirectory(prefix="upt-claim-binding-") as temp:
        path = Path(temp) / "ClaimBinding.lean"
        path.write_text(PROBE + "\n".join(f"run_cmd reportBinding `{name}" for name in names) + "\n")
        result = subprocess.run([lake, "env", "lean", str(path)], cwd=ROOT,
                                text=True, capture_output=True, timeout=180)
    require(result.returncode == 0, "Lean declaration probe failed:\n" + result.stdout + result.stderr)
    require(not result.stderr, "Lean probe wrote stderr: " + result.stderr)
    observations = {}
    for line in result.stdout.splitlines():
        require(line.startswith(PREFIX), "Unexpected Lean output: " + line[:200])
        value = json.loads(line[len(PREFIX):])
        name = value["name"]
        require(name not in observations, "Duplicate Lean probe output: " + name)
        observations[name] = value
    require(set(observations) == set(names), "Lean probe did not return every requested declaration")
    return observations


def validate_observations(records, observations):
    require(set(records) == set(observations), "Declaration observation coverage mismatch")
    for name, (module, expected) in records.items():
        actual = observations[name]
        require(actual["module"] == module, f"{name}: theorem defined in a different module")
        require(digest(actual["type"].encode()) == expected["type_sha256"],
                f"{name}: elaborated proposition changed")
        require(actual["statement"] == expected.get("statement"),
                f"{name}: displayed theorem statement changed")
        require(sorted(set(actual["direct_theorems"])) == expected["direct_theorem_dependencies"],
                f"{name}: direct theorem dependencies changed")
        actual_axioms = sorted(set(actual["axioms"]))
        require(set(actual_axioms) <= STANDARD_AXIOMS, f"{name}: nonstandard transitive axioms")
        require(actual_axioms == expected["axioms"], f"{name}: transitive axiom dependencies changed")


def regressions(ledger, bindings, records, observations, lake):
    checked = []
    def rejects(label, operation):
        try:
            operation()
        except BindingError:
            checked.append(label)
        else:
            raise BindingError("Negative control was accepted: " + label)
    missing = copy.deepcopy(bindings)
    missing["claims"].pop()
    rejects("missing_formal_claim_binding", lambda: validate_static(ledger, missing))
    duplicate = copy.deepcopy(bindings)
    duplicate["claims"].append(duplicate["claims"][0])
    rejects("duplicate_claim_binding", lambda: validate_static(ledger, duplicate))
    promoted = copy.deepcopy(ledger)
    next(c for c in promoted["claims"] if c["id"] == bindings["claims"][0]["id"])["scope"] = "physical"
    rejects("model_proof_promoted_to_physical", lambda: validate_static(promoted, bindings))
    stale = copy.deepcopy(bindings)
    stale["claims"][0]["source_sha256"] = "0" * 64
    rejects("stale_source_fingerprint", lambda: validate_static(ledger, stale))
    name = next(iter(records))
    wrong_module = copy.deepcopy(observations)
    wrong_module[name]["module"] = "PhysicalBridges.OtherModule"
    rejects("wrong_defining_module", lambda: validate_observations(records, wrong_module))
    wrong_type = copy.deepcopy(observations)
    wrong_type[name]["type"] = "False"
    rejects("changed_elaborated_proposition", lambda: validate_observations(records, wrong_type))
    wrong_deps = copy.deepcopy(observations)
    wrong_deps[name]["direct_theorems"].append("Phantom.dependency")
    rejects("changed_proof_dependencies", lambda: validate_observations(records, wrong_deps))
    bad_axiom = copy.deepcopy(observations)
    bad_axiom[name]["axioms"].append("sorryAx")
    rejects("nonstandard_transitive_axiom", lambda: validate_observations(records, bad_axiom))
    rejects("phantom_theorem_rejected_by_lean", lambda: observe(
        ["PhysicalBridges.IRPhysicalGuard.PhantomMissingTheorem"], lake))
    rejects("definition_is_not_theorem", lambda: observe(
        ["PhysicalBridges.IRServiceProgress.frozenStep"], lake))
    return checked


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ledger", type=Path, default=ROOT / "assurance-ledger.json")
    parser.add_argument("--bindings", type=Path, default=ROOT / "claim-theorems.json")
    parser.add_argument("--lake", default=os.environ.get("LAKE", "lake"))
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--receipt", type=Path)
    args = parser.parse_args()
    ledger = json.loads(args.ledger.read_text())
    bindings = json.loads(args.bindings.read_text())
    version = subprocess.run([args.lake, "env", "lean", "--version"], cwd=ROOT,
                             text=True, capture_output=True, timeout=30)
    expected_version = bindings["toolchain"].rsplit(":v", 1)[-1]
    require(version.returncode == 0 and not version.stderr and
            re.search(r"\bversion " + re.escape(expected_version) + r"(?:,|\))", version.stdout),
            "Actual Lean executable does not match the reviewed pinned toolchain")
    records = validate_static(ledger, bindings)
    observations = observe(list(records), args.lake)
    validate_observations(records, observations)
    controls = regressions(ledger, bindings, records, observations, args.lake) if args.self_test else []
    receipt = {"pass": True, "formal_claims": len(bindings["claims"]),
               "bound_theorem_declarations": len(records), "negative_controls": controls,
               "toolchain": bindings["toolchain"],
               "ledger_sha256": digest(args.ledger.read_bytes()),
               "bindings_sha256": digest(args.bindings.read_bytes()),
               "scope": "Exact imported theorem/source binding; not physical or semantic validation"}
    if args.receipt:
        args.receipt.write_text(json.dumps(receipt, indent=2) + "\n")
    print(json.dumps(receipt, sort_keys=True))


if __name__ == "__main__":
    try:
        main()
    except (BindingError, KeyError, ValueError, OSError, subprocess.SubprocessError) as error:
        raise SystemExit("FAIL: " + str(error))
