#!/usr/bin/env python3
"""Item 1: C2 resource re-screen on Codex's frozen k = 3 screen (author side, Claude, 20 Oct 2026).
Runs upt-rung4a/checks/k3_screen.py read-only, with one in-memory patch: EXTRA C2 replicas hosted per island are
charged as extra exiles (x -> x + EXTRA, pop = M + x). This is the most conservative charge, since every exile
cost applies: memory, auth, batches, recovery and checkpoint events. A C2 share c means EXTRA = 6 c M per island."""
import json, sys, os, types
from fractions import Fraction as F
FROZEN = str(__import__("pathlib").Path(__file__).resolve().parent / "frozen" / "upt-rung4a")
sys.dont_write_bytecode = True
sys.path.insert(0, FROZEN + "/checks")
SRC = open(FROZEN + "/checks/k3_screen.py").read()
A = "    x=ceil(F(M*K,N-K));pop=M+x;primary=ceil(F(pop,S))\n    assert x==8 and primary==7 and gcd(R,H)==1"
assert SRC.count(A) == 1
PATCHED = SRC.replace(A, "    x=ceil(F(M*K,N-K))+EXTRA;pop=M+x;primary=ceil(F(pop,S))\n    assert gcd(R,H)==1")
def screen(extra):
    mod = types.ModuleType("k3_patched"); mod.__dict__["EXTRA"] = extra
    exec(compile(PATCHED, "k3_patched", "exec"), mod.__dict__)
    return mod.calculate()
R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))
import common
frozen = json.load(open(FROZEN + "/K3-SCREEN.json"))
r0 = json.loads(json.dumps(common.encode(screen(0)), sort_keys=True))
check("C2S.0 patch is faithful: EXTRA = 0 reproduces the frozen screen's quantities and checks",
      r0["quantities"] == frozen["quantities"] and r0["checks"] == frozen["checks"])
def fails(e): return sorted(k for k, v in screen(e)["checks"].items() if not v)
check("C2S.1 all static checks pass at 189 C2 replicas per island", fails(189) == [])
check("C2S.2 the first failure at 190 is only the canonical relocation-batch cap", fails(190) == ["canonical_batch"], fails(190))
check("C2S.3 up to 328, the batch cap is the only failing check (memory, CPU, energy, wire all fit)", fails(328) == ["canonical_batch"], fails(328))
check("C2S.4 at 329 the slot limit also binds", "slots" in fails(329), fails(329))
M = 1032
check("C2S.5 C2 share bound under every static check: 189/(6M) = 63/2064, about 3.05%", F(189, 6 * M) == F(63, 2064), float(F(189, 6 * M)))
control("C2S.1 a 3.1% C2 share (192 replicas) under the existing batch cap", fails(192) == [])
ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R), "c2_share_all_checks": float(F(189, 6 * M))}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
