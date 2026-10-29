#!/usr/bin/env python3
"""Completeness gate: every Lean module built in the author's BANKS/ must be in
the canon (lean/Snuffy/) or listed in EXCLUDED-MODULES.txt with a
reason. Writes PROOF-STATE.md and exits 1 if anything is missing.

Usage: CORPUS_ROOT=/path/to/Snuffy-Book python3 check-complete.py

Only BANKS/ is scanned. The WHOLE-EDITION 3.x trees are superseded by the Canon
Edition and UPT-4.1-working-candidate is quarantined (00-START-HERE-CURRENT-STATE.md),
so neither counts. Received inputs, snapshots and canon mirrors are skipped.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SNUFFY = os.path.join(HERE, "Snuffy")
EXCL = os.path.join(HERE, "EXCLUDED-MODULES.txt")
OUT = os.path.join(HERE, "PROOF-STATE.md")
SKIP_DIRS = ("/.lake", "/build", "/.git", "/inputs", "/snapshots", "/prior",
             "pre-foldin-snapshot", "pre-consolidation-snapshot", "pre-law-snapshot",
             "pre-landauer-snapshot", "pre-speedlimit-snapshot", "claude-summit-1-von-neumann")


def corpus_modules(root):
    found, skipped = {}, []
    for dp, dn, fn in os.walk(root):
        for f in fn:
            if f.endswith(".lean") and f != "lakefile.lean":
                rel = os.path.relpath(os.path.join(dp, f), root)
                if any(s in dp for s in SKIP_DIRS):
                    skipped.append(rel)
                else:
                    found.setdefault(f[:-5], []).append(rel)
    return found, skipped


def main():
    root = os.environ.get("CORPUS_ROOT")
    if not root:
        print("## completeness: FAIL (CORPUS_ROOT unset; corpus scan required)")
        return 1
    canon = {f[:-5] for f in os.listdir(SNUFFY) if f.endswith(".lean")}
    build_source = open(os.path.join(HERE, "build-and-audit.sh")).read()
    build_match = re.search(r"^MODULES=\((.*?)\)$", build_source, re.M)
    built = build_match.group(1).split() if build_match else []
    audit_source = open(os.path.join(HERE, "SummitsAudit.lean")).read()
    imported = re.findall(r"^import Snuffy\.(\w+)\s*$", audit_source, re.M)
    manifest_errors = []
    for label, names in (("build", built), ("audit", imported)):
        absent = sorted(canon - set(names))
        extra = sorted(set(names) - canon)
        duplicates = sorted(n for n in set(names) if names.count(n) > 1)
        if absent:
            manifest_errors.append(f"{label} omits canon modules: {', '.join(absent)}")
        if extra:
            manifest_errors.append(f"{label} names absent modules: {', '.join(extra)}")
        if duplicates:
            manifest_errors.append(f"{label} repeats modules: {', '.join(duplicates)}")
    excluded = {}
    if os.path.exists(EXCL):
        for line in open(EXCL):
            line = line.strip()
            if line and not line.startswith("#"):
                name, _, reason = line.partition(" ")
                excluded[name] = reason.strip()
    found, skipped = corpus_modules(os.path.join(root, "BANKS"))
    # exclusions must name modules that actually exist in the scanned corpus
    phantom = sorted(n for n in excluded if n not in found)
    missing = sorted(n for n in found if n not in canon and n not in excluded)
    with open(OUT, "w") as o:
        o.write("# Proof state\n\n")
        o.write(f"Canon modules: {len(canon)}. Corpus module names: {len(found)}. "
                f"Excluded with reason: {len(excluded)}. Missing: {len(missing)}. "
                f"Phantom exclusions: {len(phantom)}. Skipped by directory policy: {len(skipped)}. "
                f"Build/audit manifest errors: {len(manifest_errors)}.\n\n")
        o.write("## Build and audit coverage\n\n")
        o.write(f"Build modules: {len(built)}. Audit imports: {len(imported)}.\n\n")
        for error in manifest_errors:
            o.write(f"- **FAIL:** {error}\n")
        o.write("## Skipped by directory policy (visible, not checked — listed every audit)\n\n")
        for rel in sorted(skipped):
            o.write(f"- `{rel}`\n")
        o.write("\n## Module table\n\n")
        o.write("| Module | In canon | Corpus copies (first) |\n| --- | --- | --- |\n")
        for n in sorted(set(found) | canon):
            state = "yes" if n in canon else ("excluded: " + excluded[n] if n in excluded else "**MISSING**")
            first = found.get(n, ["(canon only)"])[0]
            o.write(f"| `{n}` | {state} | `{first}` |\n")
    print(f"## completeness: canon {len(canon)}, corpus names {len(found)}, "
          f"excluded {len(excluded)}, missing {len(missing)}, "
          f"phantom exclusions {len(phantom)}, skipped-by-policy {len(skipped)}")
    for n in missing:
        print(f"##   MISSING {n}  ({found[n][0]})")
    for n in phantom:
        print(f"##   PHANTOM EXCLUSION {n}  (not in the scanned corpus — remove the entry)")
    print(f"## build/audit coverage: canon {len(canon)}, build {len(built)}, "
          f"audit {len(imported)}, errors {len(manifest_errors)}")
    for error in manifest_errors:
        print(f"##   MANIFEST ERROR {error}")
    return 1 if missing or phantom or manifest_errors else 0


if __name__ == "__main__":
    sys.exit(main())
