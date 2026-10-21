#!/usr/bin/env python3
"""Problem 0b, proposal side: conditional derivation of P-ISLANDS's k = 2 as a race (20 Oct 2026).
Exact Fractions for every decisive quantity; a tiny GF(2^16) check for the key-share secrecy leg.
Model, variables with units and classes, and the full GAP list live in scratch/derivation.md.

The race, in date-granular counting:
  COUNT leg  (any WHOLE islands):  a sustained whole-island disablement costs at least
      E_dis = f_m * P_i * tau_dis   [disablement margin f_m >= 1 ASSUMED, no physical bound shown;
      tau_dis >= 1 date is the counting granularity, ASSUMED; P_i JW2.6's island inflow per date]
  so a coalition with sustained energy share eps of the pool-fleet envelope N*P_i can finance at most
      k_max = floor( eps * T * N / (f_m * tau_dis) )      (P_i cancels)
  whole-island disablements inside one reseed period of T dates.  k_max <= 2 is equivalent to
      eps * T * N < 3 * f_m * tau_dis,   i.e.   eps < eps* = 3*f_m*tau_dis/(T*N).
  LOCATE leg (one SPECIFIC mind): with secret keyed placement re-drawn every R_d dates (P-REDRAW),
  expected blind probes to have touched both mirror islands of one mind is 2*(N+1)/3, so the locate
  race is lost whenever (2/3)*(N+1)/v_probe > R_d.  The residual blind destruction of that mind is
  1/C(N-1,2) ~= 1.26e-5 (author's figure; exact value checked below).
  Supports: (a) two observed 3-of-5 degree-2 shares over GF(2^16) leak nothing about the key
  (det x*y*(x+y) != 0 for all 10 pairs, as in JW2.6 MATHEMATICS); (b) two 202-of-400 pool quorums
  intersect in >= 4 islands, so the defender keeps an honest durable lock even at k = 2.

Controls that MUST fail (they demonstrate which premises are load-bearing):
  C1  doubled coalition share eps = 1/5120 admits 3 disablements -> count leg fails
  C2  public adjacent placement (h+1, h+2) destroys a targeted mind with probability 1
  C3  v_probe = 600/date pins both mirrors inside the re-draw window -> locate race won
  C4  counting granularity 1/8 date admits 16 disablements -> the count leg is only as strong
      as the date-level granularity of the fault law.

NOT shown (GAPs G1..G8 in scratch/derivation.md): seconds-calibration of "date"; any physical lower
bound for f_m (the disablement cost package is a placeholder empirical law); the sustained-share
premise A5 (UPT/JW2.6 explicitly do NOT infer a global coordinated-attacker fraction from k = 2);
energy stockpiling or one-off borrowing beyond per-date inflow; pricing of the placement re-draw
(P-REDRAW "not yet priced" in UPT v0.17.8 section 2); side-channels beyond share-observation;
multi-pool composition over cosmic horizons (referenced only: author/work/check_secret_pools.py).
Under A1..A9 the claim is "P-ISLANDS follows"; it is NOT proven, unconditional or physics-only.
"""
import json
import math
import sys
from fractions import Fraction as F

R = []


def check(name, ok, detail=""):
    R.append((name, bool(ok), str(detail)))


def control(name, perturbed_ok, detail=""):
    R.append(("CONTROL " + name, not bool(perturbed_ok), str(detail)))


# ---- design constants (D1..D7 in derivation.md; all from UPT-JW2.6, price targets not measurements)
N, T, K = 400, 64, 2                      # pool size; reseed period [date]; allowance
P_I = F(5856, 5)                          # 1171.2 plant-energy units/(island*date), JW2.6 envelope
QUIORUM, Q_POOL = 202, 400                # pool journal quorum

# ---- assumed race parameters (A1..A9 in derivation.md)
EPS = F(1, 8192)                          # sustained coalition share of pool-fleet envelope
F_M = F(3, 2)                             # disablement margin, unitless
TAU_DIS = F(1, 1)                         # sustained disablement granularity [date]
V_PROBE = F(4, 1)                         # covert island probes/(date) per mandate
R_D = F(4, 1)                             # placement re-draw period [date]

# ---- derived quantities (exact)
E_DIS = F_M * P_I * TAU_DIS                                   # cost of one disablement
E_A = EPS * N * P_I                                           # coalition inflow per date
BUDGET = T * E_A                                              # period energy budget
D_MAX = BUDGET // E_DIS                                       # disablement affordability THREE ends?
CAN2 = BUDGET >= K * E_DIS
CANT3 = BUDGET < (K + 1) * E_DIS
EPS_STAR = (K + 1) * F_M * TAU_DIS / (T * N)                  # critical share, P_i cancels
LOCATE_PROBES = F(2 * (N - 1 + 1), 3)                         # expected probes to touch both mirrors
LOCATE_TIME = LOCATE_PROBES / V_PROBE                         # [date]
P_BLIND = F(1, math.comb(N - 1, 2))                           # blind 2 picks + known home destroy
P_BLIND_AUTHOR = F(126, 10**7)                                # author's rounded figure


def gf_mul(a, b, bits=16, poly=0x1100B):
    r = 0
    for i in range(bits):
        if b & (1 << i):
            r ^= a << i
    for i in range(2 * bits - 2, bits - 1, -1):
        if r & (1 << i):
            r ^= poly << (i - bits)
    return r


DET_PAIRS = [(x, y) for x in range(1, 6) for y in range(x + 1, 6)]
DETS = [gf_mul(gf_mul(x, y), x ^ y) for x, y in DET_PAIRS]    # det = x*y*(x+y), char 2

Q_INT = 2 * QUIORUM - Q_POOL                                  # >= 4 honest-intersection islands

# ---- main checks
check("COUNT: count race admits at most floor(T*E_A/E_dis) whole-island disablements per reseed period",
      D_MAX == K and CAN2 and CANT3,
      f"D_max = {int(D_MAX)}; budget {float(BUDGET)} vs 2*E_dis {float(2 * E_DIS)} and 3*E_dis {float(3 * E_DIS)}")
check("COUNT: assumed share eps = 1/8192 sits below the derived critical share eps* = 3*f_m*tau_dis/(T*N)",
      EPS < EPS_STAR,
      f"eps* = {EPS_STAR} = {float(EPS_STAR):.3e}; eps = {float(EPS):.3e}")
check("LOCATE: targeted-erasure race is lost (re-drawn before both mirrors can be pinned blind)",
      LOCATE_TIME > R_D,
      f"T_loc = {float(LOCATE_TIME):.4f} dates > R_d = {float(R_D)} (probes/date = {float(V_PROBE)})")
check("LOCATE: residual blind destruction of one fixed mind = 1/C(399,2) ≈ 1.26e-5 (author's 3-significant-figure figure)",
      P_BLIND_AUTHOR - P_BLIND < F(1, 10**8),
      f"P_blind = 1/comb(399,2) = {float(P_BLIND):.6e}")
check("KEYSHARE: two observed degree-2 shares over GF(2^16) poly 0x1100b fix (a,b) per secret: det = x*y*(x+y) != 0 on all 10 pairs",
      all(d != 0 for d in DETS) and len(DETS) == 10,
      f"10/10 determinants nonzero")
check("QUORUM: two 202-of-400 pool journals intersect in >= 4 islands; >= 2 honest survive k = 2 nonconforming",
      Q_INT >= 2 * K,
      f"202+202-400 = {Q_INT}")

# ---- controls that MUST fail
e_dis_fast = F_M * P_I * TAU_DIS
budget_big = F(1, 5120) * N * P_I * T
control("COUNT doubling the share to eps = 1/5120 still caps disablements at 2",
        budget_big // e_dis_fast <= 2,
        f"eps = 1/5120 gives D_max = {int(budget_big // e_dis_fast)} > 2: the share premise A5 is load-bearing")
control("LOCATE public adjacent placement (h, h+1, h+2) leaves a targeted-mind blind-hit below 1e-4",
        F(1, 1) <= F(1, 10000),  # with known adjacent mirrors destruction is certain: P = 1 > 1e-4
        "adjacent known placement destroys every copy with probability 1 (author, UPT section 2)")
time_fast = LOCATE_PROBES / F(600, 1)
control("LOCATE 600 covert probes per date still lose the race against R_d = 4",
        time_fast > R_D,
        f"v = 600 gives T_loc = {float(time_fast):.3f} <= R_d: P-REDRAW re-draw rate is load-bearing")
e_dis_fine = F_M * P_I * F(1, 8)
control("COUNT shrinking the disablement granularity to 1/8 date still caps at 2",
        BUDGET // e_dis_fine <= 2,
        f"tau_dis = 1/8 gives D_max = {int(BUDGET // e_dis_fine)} >> 2: date-granular counting is load-bearing")

# ---- report
ok = sum(1 for _, k, _ in R if k)
for name, k, det in R:
    print(("PASS " if k else "FAIL ") + name + (f"  [{det}]" if det else ""))
print(json.dumps({
    "status": "conditional proposal; see scratch/derivation.md GAPs G1..G8",
    "eps_critical": float(EPS_STAR),
    "share_assumed": float(EPS),
    "disablements_capped": int(D_MAX),
    "locate_time_dates": float(LOCATE_TIME),
    "blind_hit": float(P_BLIND),
    "passed": ok,
    "total": len(R),
}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
