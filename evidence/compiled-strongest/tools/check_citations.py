#!/usr/bin/env python3
"""Resolve recovered-part citations against declarations, namespaces and modules.

A resolved hypothesis identifier is reported as an identifier, not a proved
theorem. Namespace suffixes and the optional Snuffy prefix are recognised.
Source comments and strings supply no declarations or identifiers.
"""
import collections
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parents[1]
LEAN = HERE.parent / "CANON-EDITION-V4.2-WORKING/lean/Snuffy"
if not LEAN.is_dir():
    LEAN = HERE / "lean/Snuffy"  # self-contained mirror/deposit layout
PARTS = ["PARTS-V-VIII.md", "PARTS-IX-XII.md"]
IDENT = r"[A-Za-z_][\w']*"
DECL = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|noncomputable|unsafe)\s+)*(?:theorem|lemma|def|structure|abbrev|inductive|class|instance)\s+([^\s:({\[]+)")


def code_only(text):
    """Preserve newlines while masking nested Lean comments and quoted strings."""
    out, i, depth = [], 0, 0
    while i < len(text):
        if depth:
            if text.startswith("/-", i): depth += 1; out.extend("  "); i += 2
            elif text.startswith("-/", i): depth -= 1; out.extend("  "); i += 2
            else: out.append("\n" if text[i] == "\n" else " "); i += 1
        elif text.startswith("/-", i): depth = 1; out.extend("  "); i += 2
        elif text.startswith("--", i):
            end = text.find("\n", i)
            if end < 0: end = len(text)
            out.extend(" " * (end - i)); i = end
        elif text[i] == '"':
            out.append(" "); i += 1
            while i < len(text):
                c = text[i]; out.append("\n" if c == "\n" else " "); i += 1
                if c == "\\" and i < len(text): out.append(" "); i += 1
                elif c == '"': break
        else: out.append(text[i]); i += 1
    return "".join(out)


def strip_snuffy(name):
    return name.removeprefix("_root_.").removeprefix("Snuffy.")


def inventory(root):
    mods, qualified, namespaces, identifiers = {}, set(), set(), set()
    for p in sorted(root.rglob("*.lean")):
        mod = ".".join(p.relative_to(root).with_suffix("").parts)
        code = code_only(p.read_text())
        identifiers.update(re.findall(IDENT, code))
        stack, names = [], set()
        for line in code.splitlines():
            ns = ".".join(x for kind, x in stack if kind == "ns")
            if m := re.match(r"\s*namespace\s+(\S+)", line):
                stack.append(("ns", m[1])); namespaces.add(strip_snuffy(".".join(x for k, x in stack if k == "ns")))
            elif re.match(r"\s*(?:noncomputable\s+)?section(?:\s+\S+)?\s*$", line): stack.append(("section", ""))
            elif re.match(r"\s*end(?:\s+\S+)?\s*$", line):
                if stack: stack.pop()
            elif m := DECL.match(line):
                short = m[1]
                if short == ":": continue  # anonymous instance
                names.add(short.split(".")[-1])
                qualified.add(strip_snuffy((ns + "." if ns else "") + short))
        mods[mod] = names
    return mods, qualified, namespaces, identifiers


def resolve(token, inv):
    mods, qualified, namespaces, identifiers = inv
    token = strip_snuffy(token)
    segs = token.split(".")
    if token in mods: return "module"
    if token in qualified or any(q.endswith("." + token) for q in qualified): return "declaration"
    if token in namespaces or any(q.endswith("." + token) for q in namespaces): return "namespace"
    for k in range(len(segs) - 1, 0, -1):
        prefix = ".".join(segs[:k])
        if prefix in mods:
            return "declaration" if segs[-1] in mods[prefix] else None
    if len(segs) == 1:
        if any(token in ns for ns in mods.values()): return "declaration"
        if token[0].islower() and token in identifiers: return "identifier"
    return None


def main():
    inv = inventory(LEAN)
    counts, missing = collections.Counter(), []
    for part in PARTS:
        for ln, line in enumerate((HERE / part).read_text().splitlines(), 1):
            for token in re.findall(r"`([^`\s]+)`", line):
                token = token.strip(".,;:()")
                if not re.fullmatch(r"[A-Za-z][\w.']*", token): continue
                if token.endswith((".md", ".py", ".json", ".txt", ".lean", ".sh")): continue
                relevant = token[0].isupper() or "_" in token or re.match(r"^[a-z]+[A-Z]", token)
                if not relevant: continue
                category = resolve(token, inv)
                if category: counts[category] += 1
                else: missing.append((part, ln, token))
    print(f"modules {len(inv[0])}, citations checked {sum(counts.values())+len(missing)}, unresolved {len(missing)}")
    print("resolved " + ", ".join(f"{key} {val}" for key, val in sorted(counts.items())))
    for part, ln, token in missing: print(f"  {part}:{ln} `{token}` unresolved")
    return bool(missing)


if __name__ == "__main__":
    sys.exit(main())
