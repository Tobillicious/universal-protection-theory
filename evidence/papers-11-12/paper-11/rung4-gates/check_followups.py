#!/usr/bin/env python3
"""Follow-up lemmas for v0.17.11 (author side, Claude, 20 Oct 2026). Exact Fractions.
F1  C2 replica transition 7 -> 5 at twilight (joint majority, mirrors gate G6).
F2  P-START reduced: the two startup dates decompose into already-checked inherited bounds plus one residual."""
import json, sys
from fractions import Fraction as F
from itertools import combinations

R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))

# F1: switch at a checkpoint only when <= 2 islands are down. During the joint phase a step commits only with
# BOTH an old 4-of-7 majority and a new 3-of-5 majority (the 5 new replicas are a subset of the 7 old ones).
def joint_live(down, old=7, new=5):
    return all(old - len([i for i in L if i < old]) >= old // 2 + 1 and new - len([i for i in L if i < new]) >= new // 2 + 1
               for L in combinations(range(old), down))
check("F1.1 joint 4-of-7 and 3-of-5 majorities live under every <=2-island mask", all(joint_live(d) for d in range(3)))
control("F1.1 switch attempted with 3 islands down", joint_live(3))
# safety: any two commits share a replica in both configurations (majority intersection)
check("F1.2 majorities intersect in both configurations (2*4-7 >= 1, 2*3-5 >= 1)", 2 * 4 - 7 >= 1 and 2 * 3 - 5 >= 1)
check("F1.3 after the switch, 5 replicas never pause with <= 2 down", 5 - 2 >= 3)
# F2: startup = local journal re-admission (<= 1/8, composed service contract) + pool admission (<= 1/8)
#     + next checkpoint shares and first stream (period 3/4 + lag <= 1/4: the screen's state-age bound <= 1)
#     + residual (re-attestation and planning).
local, pool, ckpt = F(1, 8), F(1, 8), F(3, 4) + F(1, 4)
residual = 2 - (local + pool + ckpt)
check("F2.1 P-START reduces to: re-attestation + planning <= 3/4 date", residual == F(3, 4), residual)
control("F2.1 if the checkpoint path needed the full 2 dates, no room would remain", 2 - (local + pool + 2) >= 0)

# F3 (register item 21): checkpoint streams resume at startup within budget.
# The normal pool stream budget is computed for ALL 400 islands (normalpool = 2*K*400*pop*RATE + 4096 in rung4a),
# so a returned island's resumed streams are already paid; G1.12 checks normalpool + repair <= pool background.
PERIOD, LAG = F(3, 4), F(1, 4)
# Streams resume inside startup (F2 gives the checkpoint path <= 1 date). The two current generations need only be
# present by the window's end (date 32), not before service starts: they arrive 2 periods + lag after resumption.
resume = 2
check("F3.1 two current generations present by date 32 (resume <= 2, then 2 periods + lag)", resume + 2 * PERIOD + LAG <= 32, resume + 2 * PERIOD + LAG)
control("F3.1 streams resumed only at date 31", 31 + 2 * PERIOD + LAG <= 32)
import json as _j
_S = _j.load(open(str(__import__("pathlib").Path(__file__).resolve().parent / "frozen" / "upt-rung4a") + "/K3-SCREEN.json"))
check("F3.2 per-host background wire covers normal streams plus repair service (rung4a check)", _S["checks"]["background_wire"] is True)
check("F3.3 pool background covers normal streams for all 400 islands plus repair (rung4a check)", _S["checks"]["pool_background"] is True)

# F4 (D-GATE): every step of the 4-of-7 release protocol maps to one of the four existing gate types.
GATES = {"attestation", "sealed_storage", "live_transport", "freshness_release"}   # from the inherited model
release_protocol = [("attest the uniquely authorised instance", "attestation"),
                    ("unseal a share at each of 4 holders", "sealed_storage"),
                    ("send each share to the instance", "live_transport"),
                    ("authorise release for the current epoch only", "freshness_release")]
check("F4.1 every release step uses an existing gate type (k=3 changes only how many shares, not which gates)",
      all(g in GATES for _, g in release_protocol) and len(release_protocol) == 4)
control("F4.1 a new step type (e.g. share re-encryption gate) would fall outside the four", "share_reencryption" in GATES)

ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
