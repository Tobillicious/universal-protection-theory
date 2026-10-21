#!/usr/bin/env python3
"""Common-floor sub-allowances (author side, Claude, 20 Oct 2026). Exact Fractions. Declared targets, not measurements.
The floor is a SUM over its gaps (any one breaks the system), so sub-allowances must add to <= the ledger's
common_plus_premise account (1e-7), which is read from the frozen rung4a screen."""
import json, sys
from fractions import Fraction as F
SCREEN = str(__import__("pathlib").Path(__file__).resolve().parent / "frozen" / "upt-rung4a") + "/K3-SCREEN.json"
rows = json.load(open(SCREEN))["all21_screen"]["rows"]
floor = {F(r["accounts"]["common_plus_premise"]["exact"]) for r in rows.values()}
R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))
check("FL.0 every ledger row carries the same common account 1e-7", floor == {F(1, 10**7)})
FLOOR = F(1, 10**7)
sub = {"verified_core_spec": F(15, 10**9), "verified_core_hardware_below_ISA": F(15, 10**9),
       "verified_core_proof_checker": F(15, 10**9), "verified_core_compiler": F(15, 10**9),
       "erasure": F(1, 10**8), "clocks_retirement_keys": F(1, 10**8),
       "attestation_host_duty_hardware": F(1, 10**8), "journal_impl_and_validator": F(1, 10**8)}
check("FL.1 sub-allowances sum to at most the floor (a sum, never a product)", sum(sub.values()) <= FLOOR, float(sum(sub.values())))
check("FL.2 all sub-allowances positive (no gap assumed free)", all(v > 0 for v in sub.values()))
control("FL.1 adding a fifth verified-core gap at 1.5e-8 without rebalancing", sum(sub.values()) + F(15, 10**9) <= FLOOR)
control("FL.1 treating the four verified-core gaps as a product (would understate the floor)",
        F(15, 10**9) ** 4 >= F(15, 10**9), "a product is only valid when ALL must fail")
# Seam 1 (20 Oct): the information-limit lower bound eta >= pi_B (1 - rho_L) must not exceed the declared floor.
rho_L = F(3, 20)                                   # as defined in the earlier INDIST checker
pi_max = FLOOR / (1 - rho_L)
check("FL.3 consistency: floor >= pi_B(1-rho_L) iff pi_B <= (20/17)e-7", pi_max == F(20, 17) * F(1, 10**7), float(pi_max))
control("FL.3 pi_B = 1.18e-7 (the old rounded-up figure) keeps the lower bound under the floor", F(118, 10**9) * (1 - rho_L) <= FLOOR,
        float(F(118, 10**9) * (1 - rho_L)))

# Item 12: the lockstep timing account for C2 minds (declared, outside the common floor).
C2_LOCK = F(1, 10**8)
worst_total = max(F(r["with_reserve"]["exact"]) for r in rows.values())
check("FL.4 the ledger with the C2 lockstep account added stays within 1e-6", worst_total + C2_LOCK <= F(1, 10**6), float(worst_total + C2_LOCK))
control("FL.4 a lockstep account of 8e-7 would exceed the budget", worst_total + F(8, 10**7) <= F(1, 10**6))

ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
