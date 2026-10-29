#!/usr/bin/env python3
"""Port Paper 12's standalone Lean modules into the canon under unique namespaces.

Each file has exactly one namespace and no imports. The namespace is renamed to
Snuffy.Book.<Module> (namespace/end/open lines and qualified references), the
statements are otherwise byte-identical, and a provenance header is prepended.
Usage: port_book.py SRC_DIR OUT_DIR
"""
import hashlib
import os
import re
import sys

SKIP = {"UPTFence", "UPTLawLife", "NegativeControl", "PositiveControl"}  # already in canon / controls

src, out = sys.argv[1], sys.argv[2]
os.makedirs(out, exist_ok=True)
for name in sorted(os.listdir(src)):
    if not name.endswith(".lean"):
        continue
    mod = name[:-5]
    if mod in SKIP:
        continue
    text = open(os.path.join(src, name)).read()
    sha = hashlib.sha256(text.encode()).hexdigest()
    m = re.search(r"^namespace (\S+)", text, re.M)
    if not m:
        sys.exit(f"{name}: no namespace")
    old, new = m.group(1), f"Snuffy.Book.{mod}"
    text = re.sub(rf"^namespace {re.escape(old)}\b", f"namespace {new}", text, flags=re.M)
    text = re.sub(rf"^end {re.escape(old)}\b", f"end {new}", text, flags=re.M)
    text = re.sub(rf"\bopen {re.escape(old)}\b", f"open {new}", text)
    text = re.sub(rf"(?<![\w.]){re.escape(old)}\.", f"{new}.", text)
    header = (f"/-! Ported from Book I v2.0.5, Paper 12 evidence "
              f"(`evidence/papers-11-12/lean/{name}`, sha256 `{sha}`).\n"
              f"Namespace `{old}` renamed to `{new}` for the canon's joint audit; "
              f"statements and proofs unchanged. -/\n\n")
    open(os.path.join(out, f"Book{mod}.lean"), "w").write(header + text)
    print(f"Book{mod}  {old} -> {new}")
