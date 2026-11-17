"""Read-only source-change guard for the historical J/K fencing -> G3 R5 join.

This is a *syntax/structure regression test*, not proof of OS isolation,
cryptographic unforgeability, real-world effect completeness or authentic X3.
No effect is executed or permission issued.
"""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent

def _single_function(tree, name):
    matches = [n for n in ast.walk(tree)
               if isinstance(n, ast.FunctionDef) and n.name == name]
    if len(matches) != 1:
        raise ValueError("historical target function drift: " + name)
    return matches[0]

def _require(source, terms, reason):
    if any(term not in source for term in terms):
        raise ValueError(reason)

def check_bridge_source(target_source, authority_source):
    """Fail on known removal of either source-side historical fence obligation."""
    if not isinstance(target_source, str) or not isinstance(authority_source, str):
        raise ValueError("source must be text")
    historical = ast.parse(target_source)
    current = ast.parse(authority_source)
    for name in ("append", "apply", "admit"):
        _single_function(historical, name)
    _single_function(current, "write_fixed_marker")
    historical_text = ast.unparse(historical)
    current_text = ast.unparse(current)
    _require(historical_text,
             ("with lock:", "r = admit(m) or apply(m)",
              "state['floor'] = max(state['floor'], m['g'])",
              "fullsync(fh)", "floor_at_apply"),
             "historical J/K check-at-apply or durability drift")
    _require(current_text,
             ("self.server.journal.admit(OPERATION, self.server.expected)",
              "self.server.fence.execute_synthetic(",
              "self.server.journal.hold()",
              "self.server.write_fixed_marker",
              "os.fsync(fd)", "os.fsync(self.dirfd)"),
             "current authority-owned effect/HOLD source drift")
    return True

def verify_checkout(root=ROOT):
    return check_bridge_source(
        (root / "target.py").read_text(),
        (root / "koru_authority_owned_marker_service.py").read_text())

if __name__ == "__main__":
    verify_checkout()
    print("Historical fencing and current R5 source-structure guard checked")
