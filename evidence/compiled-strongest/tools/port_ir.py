#!/usr/bin/env python3
"""Port the IR dependency closure into the canon (staging). Usage: port_ir.py ROOT OUT_DIR

* import PhysicalBridges.X  -> import Snuffy.X
* import UPTExistence       -> import Snuffy.BookUPTExistence; UPTExist.* -> Snuffy.Book.UPTExistence.*
* import ContextualObservation -> import Snuffy.BookContextualObservation;
  CodexObservation.* -> Snuffy.Book.ContextualObservation.* (module ported too)
* import ControllerFence    -> import Snuffy.ControllerFence (canon copy, same declarations)
* lines `#print axioms ...` removed (the canon's SummitsAudit audits every theorem)
Namespaces PhysicalBridges.* are kept (already unique). A provenance header records the source hash.
"""
import hashlib
import os
import re
import subprocess
import sys

root, out = sys.argv[1], sys.argv[2]
pb = os.path.join(root, "evidence/physical-bridges")
closure = subprocess.run([sys.executable, os.path.join(os.path.dirname(__file__), "ir_closure.py"), root],
                         capture_output=True, text=True, check=True).stdout.splitlines()[1].split()
os.makedirs(out, exist_ok=True)


def rewrite(text):
    text = re.sub(r"^import PhysicalBridges\.(\S+)", r"import Snuffy.\1", text, flags=re.M)
    text = re.sub(r"^import UPTExistence$", "import Snuffy.BookUPTExistence", text, flags=re.M)
    text = re.sub(r"^import ContextualObservation$", "import Snuffy.BookContextualObservation", text, flags=re.M)
    text = re.sub(r"^import ControllerFence$", "import Snuffy.ControllerFence", text, flags=re.M)
    text = re.sub(r"(?<![\w.])UPTExist\b", "Snuffy.Book.UPTExistence", text)
    text = re.sub(r"(?<![\w.])CodexObservation\b", "Snuffy.Book.ContextualObservation", text)
    text = re.sub(r"^#print axioms .*\n", "", text, flags=re.M)
    text = re.sub(r"^#eval ", "-- (finite check, run in the source repository's CI) #eval ", text, flags=re.M)
    return text


order = []
# ContextualObservation from Paper 12 modules, namespace renamed
co_src = os.path.join(root, "evidence/papers-11-12/lean/modules/ContextualObservation.lean")
co = open(co_src).read()
sha = hashlib.sha256(co.encode()).hexdigest()
co = rewrite(co)
open(os.path.join(out, "BookContextualObservation.lean"), "w").write(
    f"/-! Ported from `evidence/papers-11-12/lean/modules/ContextualObservation.lean` "
    f"(sha256 `{sha}`); namespace renamed for the canon's joint audit. -/\n\n" + co)
order.append("BookContextualObservation")
for mod in closure:
    p = os.path.join(pb, "PhysicalBridges", mod + ".lean")
    if not os.path.exists(p):
        continue
    text = open(p).read()
    sha = hashlib.sha256(text.encode()).hexdigest()
    body = rewrite(text)
    # Lean requires imports first: keep them at the top, header after.
    lines = body.split("\n")
    imports = [l for l in lines if l.startswith("import ")]
    rest = [l for l in lines if not l.startswith("import ")]
    header = (f"/-! Ported from `Tobillicious/universal-protection-theory` "
              f"`evidence/physical-bridges/PhysicalBridges/{mod}.lean` at main `740abbb` "
              f"(sha256 `{sha}`); imports redirected to the canon, inline `#print axioms` "
              f"removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/")
    opts = ["set_option linter.unusedVariables false", "set_option linter.unnecessarySimpa false",
            "set_option linter.unusedSimpArgs false"]
    open(os.path.join(out, mod + ".lean"), "w").write("\n".join(imports + ["", header] + opts + rest))
    order.append(mod)
print(" ".join(order))
