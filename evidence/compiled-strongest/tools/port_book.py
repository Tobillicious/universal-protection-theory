#!/usr/bin/env python3
"""Port Paper 12 modules, with imports and namespace references preserved.

Usage: port_book.py SRC_DIR OUT_DIR [MODULE ...]
With explicit MODULEs, only those files are written. Dependencies are checked
recursively and redirected to their existing canon ports. No statement or proof
is changed. Inline axiom-print commands move to the joint SummitsAudit.
"""
import hashlib
import re
import sys
from pathlib import Path

SKIP = {"UPTFence", "UPTLawLife", "NegativeControl", "PositiveControl"}
CANON = {"UPTFence", "UPTLawLife"}


def port(src, out, selected):
    src, out = Path(src), Path(out)
    out.mkdir(parents=True, exist_ok=True)
    texts = {p.stem: p.read_text() for p in src.glob("*.lean")}
    roots = selected or sorted(set(texts) - SKIP)

    def closure(mod, seen):
        if mod in seen:
            return
        if mod not in texts:
            raise ValueError(f"source dependency missing: {mod}")
        seen.add(mod)
        for dep in re.findall(r"^import\s+(\S+)\s*$", texts[mod], re.M):
            closure(dep, seen)

    for mod in roots:
        deps = set()
        closure(mod, deps)
        mapping = {}
        for dep in deps:
            match = re.search(r"^namespace\s+(\S+)", texts[dep], re.M)
            if not match:
                raise ValueError(f"{dep}: no namespace")
            old = match.group(1)
            new = old if dep in CANON else f"Snuffy.Book.{dep}"
            if old in mapping and mapping[old] != new:
                raise ValueError(f"{mod}: ambiguous namespace {old}")
            mapping[old] = new
        original = texts[mod]
        if re.search(r"\b(sorry|admit)\b|^\s*axiom\s", original, re.M):
            raise ValueError(f"{mod}: inspect placeholder/axiom before porting")
        body = re.sub(r"^import\s+(\S+)\s*$",
                      lambda m: "import Snuffy." + (m[1] if m[1] in CANON else "Book" + m[1]),
                      original, flags=re.M)
        # One simultaneous replacement prevents rewriting the new names again.
        renames = {a: b for a, b in mapping.items() if a != b}
        if renames:
            pattern = r"(?<![\w.])(" + "|".join(map(re.escape, sorted(renames, key=len, reverse=True))) + r")(?![\w])"
            body = re.sub(pattern, lambda m: renames[m[1]], body)
        body = re.sub(r"^#print axioms .*\n", "", body, flags=re.M)
        imports = re.findall(r"^import .*", body, re.M)
        rest = re.sub(r"^import .*\n", "", body, flags=re.M).lstrip("\n")
        sha = hashlib.sha256(original.encode()).hexdigest()
        header = (f"/-! Ported from Paper 12 `evidence/papers-11-12/lean/modules/{mod}.lean` "
                  f"(source sha256 `{sha}`).\n"
                  f"Namespace renamed to `Snuffy.Book.{mod}`; dependency imports and namespace references "
                  "redirected to the canon. Inline `#print axioms` commands are removed here and every "
                  "public theorem is audited by SummitsAudit. Statements and proofs unchanged. -/\n\n")
        target = out / f"Book{mod}.lean"
        target.write_text(("\n".join(imports) + "\n\n" if imports else "") + header + rest)
        print(f"Book{mod} source-sha256={sha}")


if __name__ == "__main__":
    port(sys.argv[1], sys.argv[2], sys.argv[3:])
