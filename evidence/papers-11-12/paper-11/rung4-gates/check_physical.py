#!/usr/bin/env python3
"""Physical facts behind the measurement hypotheses (author side, 20 Oct 2026). Exact Fractions; integer powers.
Sources are cited in PHYSICAL-FACTS.md. delta = length of one model date in seconds (a declared choice)."""
import json, sys
from fractions import Fraction as F
R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))
# 1. Landauer: k_B is exact in the 2019 SI. ln 2 is bracketed by rationals.
kB = F(1380649, 10**29); T = 300
LN2_LO, LN2_HI = F(693147180, 10**9), F(693147181, 10**9)
lo, hi = kB * T * LN2_LO, kB * T * LN2_HI
check("PF.1 Landauer cost per erased bit at 300 K lies in [2.8709e-21, 2.8710e-21] J", F(28709, 10**25) <= lo and hi <= F(28710, 10**25), float(lo))
# 2. Signal speed in silica fibre: c exact in SI, n = 1.468 (standard single-mode)
c = 299792458; n = F(1468, 1000)
us_per_km = n * 1000 / c * 10**6
check("PF.2 fibre one-way delay is 4.89-4.90 us per km", F(489, 100) <= us_per_km <= F(490, 100), float(us_per_km))
# 3. Earth-scale round trip: half the equatorial circumference (antipodal, about 20,038 km) out and back in fibre
rtt_max = 2 * 20038 * us_per_km / 10**6          # seconds
delta_min = rtt_max * 1024                        # P-LAT timeout (delta/1024) must exceed the physical round trip
check("PF.3 P-LAT's timeout exceeds any on-Earth fibre round trip once delta >= 201 s", 200 < delta_min <= 201, float(delta_min))
control("PF.3 a 60-second date cannot clear an antipodal round trip", F(60, 1024) >= rtt_max)
# 4. P-FAULT from measured annual failure rates a: per-window p = 1 - (1-a)^(w/365), window w = 32 dates.
# p <= p* (ledger boundary .002384) iff (1-a)^(32*d) >= (1-p*)^365, with d = delta in days (integer powers, exact).
pstar = F(2384, 10**6)
def fits(a, d_num, d_den):           # delta = d_num/d_den days -> window = 32*d_num/d_den days
    return (1 - a) ** (32 * d_num) >= (1 - pstar) ** (365 * d_den)
bb, sg_lo, sg_hi = F(136, 10**4), F(2, 100), F(4, 100)   # Backblaze 2025 AFR; Schroeder-Gibson common 2-4%
check("PF.4 at delta = 1 day, the 2025 drive-fleet rate (1.36%) gives p within the ledger boundary", fits(bb, 1, 1))
check("PF.5 at delta = 1 day, a 2% replacement rate fits", fits(sg_lo, 1, 1))
check("PF.6 at delta = 1 day, a 4% replacement rate does not fit, so delta must be shorter", not fits(sg_hi, 1, 1))
check("PF.7 at delta = 16 hours, even a 4% rate fits", fits(sg_hi, 2, 3))
control("PF.7 a 13% outlier rate at delta = 16 hours", fits(F(13, 100), 2, 3))
# 5. The admissible window for the date: both constraints hold for delta in [201 s, 16 h] at a 4% rate.
check("PF.8 an admissible date length exists: 201 s < 16 h (57,600 s)", delta_min < 57600)
# Item 10b: physical cost of computation. NVIDIA H100 SXM datasheet: 700 W maximum TDP, 1,979 TFLOPS FP16 with sparsity, half that dense.
j_per_flop = F(700, 9895 * 10**11)             # 700 W / 989.5e12 FLOP/s
ratio = j_per_flop / hi                         # against the Landauer cost per erased bit (upper end)
check("PF.11 a current accelerator spends about 7.07e-13 J per dense FP16 operation", F(707, 10**15) <= j_per_flop <= F(708, 10**15), float(j_per_flop))
check("PF.12 that is about 2.5e8 times the Landauer cost of one bit erasure: engineering, not physics, sets compute energy today", 24 * 10**7 <= ratio <= 25 * 10**7, float(ratio))

ok = sum(1 for _, k, _ in R if k)
for nm, k, d in R: print(("PASS " if k else "FAIL ") + nm + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
