#!/usr/bin/env python3
"""Freshly compile/kernel-replay the seven-module Part XIV dependency closure.

The unchanged 324 modules are hash-matched to run 10, not freshly rebuilt.
No network access is performed here. Supply an existing pinned Mathlib project.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import runpy
import shutil
import subprocess
import tempfile
import time

EDITION = Path(__file__).resolve().parents[1]
SOURCE = EDITION / "lean"
MODULES = (
    "FoundingDominance", "FoundingPivotal", "FoundingAnchor", "NarrowPlace",
    "CorrelatedHolding", "EnergyFounding", "SwarmFounding",
)
IMPORT_ONLY = {"FoundingDominance", "FoundingAnchor", "NarrowPlace"}
NEW = {"EnergyFounding", "SwarmFounding"}
MATHLIB_REV = "56a005855ea17e0b0958f73ec801ae140b0a1679"
ALLOWED_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
BASE_BODY_HASHES = {
    "FoundingDominance": "0078e6b9c4cf58aa3e453121a5028ca8a5b00e40ba953ba867af8945deb566d9",
    "FoundingAnchor": "ac5c7a9ef9321c770e3640a8af0b26587608daf3d0ee3c66281452a51714fffa",
    "NarrowPlace": "3501b4a3fa0359b008b379eb17bccad98ab108d3552d9a07237dbfc0e87e4e1f",
}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_inherited_sources():
    text = (EDITION / "RECEIPT-327-RUN10.txt").read_text()
    assert text.rstrip().endswith("## overall: PASS")
    recorded = dict(re.findall(
        r"^##\s+([0-9a-f]{64})\s+(Snuffy/[^\s]+\.lean)$", text, re.M))
    assert len(recorded) == 327
    matched, changed = [], []
    for digest, relative in recorded.items():
        module = Path(relative).stem
        (matched if sha(SOURCE / relative) == digest else changed).append(module)
    assert set(changed) == IMPORT_ONLY, changed
    canon = {p.stem for p in (SOURCE / "Snuffy").glob("*.lean")}
    assert canon == set(matched) | IMPORT_ONLY | NEW
    for module, digest in BASE_BODY_HASHES.items():
        body = "\n".join(line for line in (SOURCE / "Snuffy" / (module + ".lean"))
                         .read_text().splitlines() if not line.startswith("import "))
        assert hashlib.sha256(body.encode()).hexdigest() == digest, module
    # A changed transitive import must not leave an unchecked downstream file.
    for module in canon - set(MODULES):
        imports = set(re.findall(r"^import Snuffy\.(\w+)$",
                                (SOURCE / "Snuffy" / (module + ".lean")).read_text(), re.M))
        assert not imports.intersection(MODULES), (module, imports)
    return {"receipt": "RECEIPT-327-RUN10.txt", "unchanged_modules": len(matched),
            "changed_imports": sorted(changed), "new_modules": sorted(NEW),
            "fresh_scope": list(MODULES), "canon_modules": len(canon)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mathlib-project", type=Path, required=True)
    parser.add_argument("--receipt-dir", type=Path, required=True)
    parser.add_argument("--corpus-root", type=Path, default=EDITION.parents[1])
    args = parser.parse_args()
    project = args.mathlib_project.resolve()
    output = args.receipt_dir.resolve()
    output.mkdir(parents=True, exist_ok=True)
    env = os.environ.copy()
    env["LEAN_NUM_THREADS"] = "1"
    env["CORPUS_ROOT"] = str(args.corpus_root.resolve())
    results = {"scope": verify_inherited_sources(), "steps": []}

    def run(name, command, *, cwd=project, quiet=False, timeout=600):
        start = time.monotonic()
        p = subprocess.run(command, cwd=cwd, env=env, capture_output=True,
                           timeout=timeout)
        log = p.stdout + p.stderr
        (output / (name + ".log")).write_bytes(log)
        results["steps"].append({"name": name, "exit": p.returncode,
                                 "output_bytes": len(log),
                                 "seconds": round(time.monotonic() - start, 3)})
        print(f"{name}: exit={p.returncode} output-bytes={len(log)}", flush=True)
        if p.returncode or (quiet and log):
            raise RuntimeError(f"{name} failed its gate:\n{log.decode()}")
        return p.stdout.decode()

    lean = shutil.which("lean")
    lake = shutil.which("lake")
    assert lean and lake, "Lean and Lake must be on PATH"
    version = run("lean-version", [lean, "--version"])
    assert "version 4.35.0," in version, version
    revision = run("mathlib-revision", ["git", "rev-parse", "HEAD"],
                   cwd=project / ".lake/packages/mathlib").strip()
    assert revision == MATHLIB_REV, revision
    base_path = run("lake-path", [lake, "env", "printenv", "LEAN_PATH"]).strip()
    theorem_parser = runpy.run_path(str(SOURCE / "gen-index.py"))["theorems"]
    names = [name for module in MODULES for name in
             theorem_parser(SOURCE / "Snuffy" / (module + ".lean"))]
    assert len(names) == 24, names
    with tempfile.TemporaryDirectory(prefix="upt-energy-swarm-") as directory:
        build = Path(directory)
        (build / "Snuffy").mkdir()
        env["LEAN_PATH"] = base_path + os.pathsep + str(build)
        results["sources"] = {}
        for module in MODULES:
            source = SOURCE / "Snuffy" / (module + ".lean")
            obj = build / "Snuffy" / (module + ".olean")
            run("compile-" + module,
                [lean, "-R", str(SOURCE), "-o", str(obj), str(source)], quiet=True)
            results["sources"][module] = {"source_sha256": sha(source),
                                           "object_sha256": sha(obj)}
        # An explicit namespace prevents leanchecker from scanning Mathlib.
        checker = run("leanchecker-path", [lake, "env", "which", "leanchecker"]).strip()
        assert Path(checker).is_file()
        replay = run("kernel-replay", [checker, "-v", "Snuffy"])
        replayed = re.findall(r"^replaying Snuffy\.(\w+)$", replay, re.M)
        assert len(replayed) == len(MODULES) and set(replayed) == set(MODULES), replay
        audit = "\n".join("import Snuffy." + m for m in MODULES) + "\n\n"
        audit += "\n".join("#print axioms " + n for n in names) + "\n"
        audit_file = build / "Audit.lean"
        audit_file.write_text(audit)
        (output / "audit-source.txt").write_text(audit)
        printed = run("axiom-audit", [lean, str(audit_file)])
        normalized = re.sub(r",\s*\n\s*", ", ", printed)
        rows = re.findall(r"'([^']+)' (depends on axioms: \[[^\]]*\]|"
                          r"does not depend on any axioms)", normalized)
        assert len(rows) == len(names) and {n for n, _ in rows} == set(names), printed
        for name, row in rows:
            if "depends on axioms:" in row:
                used = set(re.findall(r"[\w.]+", row.split("[", 1)[1][:-1]))
                assert used <= ALLOWED_AXIOMS, (name, used)
        results["audited_statements"] = len(rows)
    # The original strict gate is used unchanged. CI's checkout has no author
    # BANKS; pass --corpus-root locally to scan the author's real corpus too.
    run("completeness", [os.sys.executable, str(SOURCE / "check-complete.py")])
    run("claims", [os.sys.executable, str(SOURCE / "check-claims.py")])
    results["status"] = "PASS"
    (output / "RECEIPT.json").write_text(json.dumps(results, indent=2) + "\n")
    print("PASS: seven fresh modules; 24 audited statements; 324 unchanged receipt matches.")


if __name__ == "__main__":
    main()
