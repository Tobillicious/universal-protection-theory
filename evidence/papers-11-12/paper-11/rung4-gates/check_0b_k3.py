#!/usr/bin/env python3
"""Problem 0b at k = 3: P-K3 from site-level primitives (author side, Claude, 20 Oct 2026). Exact Fractions.

Builds on Codex's corrected rolling-budget lemma (upt-v01710/GLM-0B-AUDIT.md):
    outstanding(t) <= floor((B + r L) / E_min) + F_other.
New here:
  (i)  E_min is derived from a SITE-level floor: a whole island is unavailable only when more than its local
       tolerance fails (k3: 72 of 242 compute sites; k2/TW-1: 71). Under design rule D-SPREAD (no single
       physical action disables more than s sites of one island), E_min >= ceil(t_loss / s) * e_site.
  (ii) L is pinned by gate G1: L = D + 32 (D = onset -> stable physical return, incl. detection; 32 = repair).
Premises left primitive: e_site, s, B, r, D, F_other. Illustrative numbers are not measurements."""
import json, sys
from fractions import Fraction as F
from math import ceil, floor

R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))

def e_min(t_loss, s, e_site): return ceil(F(t_loss, s)) * e_site
def outstanding(B, r, L, Emin, F_other): return floor((B + r * L) / Emin) + F_other
def certificate(B, r, L, Emin, F_other, k): return B + r * L < (k - F_other + 1) * Emin   # Codex's exact equivalence

# the lemma's equivalence, exhaustively on a small grid (integer budget certificate <=> outstanding <= k)
grid_ok = all((outstanding(F(B), F(r), F(L), F(E), Fo) <= k) == certificate(F(B), F(r), F(L), F(E), Fo, k)
              for B in range(0, 30, 3) for r in range(0, 4) for L in range(1, 12, 2) for E in range(1, 9)
              for Fo in range(0, 3) for k in range(Fo, 5))
check("0b.1 certificate <=> outstanding <= k (exhaustive small grid)", grid_ok)

# site-to-island composition
check("0b.2 k3 island loss needs 72 compute-site failures (242 hosts, quorum 171)", 242 - 171 + 1 == 72)
check("0b.3 TW-1 island loss needs 71 (242 hosts, quorum 172)", 242 - 172 + 1 == 71)
e, s = F(1), 1                     # normalise: e_site = 1, one site per action (full spread)
E3, E2 = e_min(72, s, e), e_min(71, s, e)
check("0b.4 full spread: E_min(k3) = 72 e_site, E_min(k2) = 71 e_site", (E3, E2) == (72, 71))
control("0b.4 an island concentrated in one place (s = 242): one action suffices", e_min(72, 242, e) > e)

# rung-4 consistency: at the SAME physical premises, the k3 certificate admits a strictly larger coalition
# envelope than TW-1's, and over a shorter exposure window (32 vs 64 repair dates).
def allowance(k, Emin, F_other): return (k - F_other + 1) * Emin      # strict upper bound on B + r L
D = F(8)                                                               # illustrative onset->return
for Fo in (0, 1, 2):
    a3, a2 = allowance(3, E3, Fo), allowance(2, E2, Fo)
    check(f"0b.5 F_other={Fo}: k3 allowance {a3} > TW-1 allowance {a2}", a3 > a2, (a3, a2))
# largest admissible coalition rate r (B = 0) at each phase: r < allowance / L
for Fo in (0, 1):
    r3 = allowance(3, E3, Fo) / (D + 32); r2 = allowance(2, E2, Fo) / (D + 64)
    check(f"0b.6 F_other={Fo}: admissible coalition rate k3 {float(r3):.3f} > TW-1 {float(r2):.3f} site-costs/date", r3 > r2)
def rate(k, t_loss, repair, Fo): return allowance(k, e_min(t_loss, s, e), Fo) / (D + repair)
for name, args in [("k reverted to 2", (2, 72, 32)), ("tolerance reverted to 71", (3, 71, 32)), ("repair reverted to 64", (3, 72, 64))]:
    check(f"0b.6b with one k3 change reverted ({name}), the other two still beat TW-1", rate(*args, 1) > rate(2, 71, 64, 1), float(rate(*args, 1)))
control("0b.6 all three k3 changes reverted (k=2, 71, 64): strict gain over TW-1", rate(2, 71, 64, 1) > rate(2, 71, 64, 1))
# partial spread degrades gracefully: with s sites per action, E_min = ceil(72/s) e
check("0b.7 partial spread s = 8: E_min = 9 e_site", e_min(72, 8, e) == 9)
# P-K3 holds as soon as the certificate holds; e.g. F_other = 1, B = 0, D = 8: any r < 216/40 = 5.4 site-costs/date
check("0b.8 example: F_other=1, B=0, D=8 -> P-K3 for every r < 27/5", allowance(3, E3, 1) / (D + 32) == F(27, 5))
control("0b.8 r = 27/5 exactly (strict inequality fails)", certificate(F(0), F(27, 5), D + 32, E3, 1, 3))
control("0b.8 four other-cause losses reserved (F_other = 4 > k)", certificate(F(0), F(0), D + 32, E3, 4, 3))

ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
