#!/usr/bin/env python3
"""Rung-4 gate lemmas for the k=3 plant (author side, Claude, 20 Oct 2026). Exact integers/Fractions.
Inputs are read from Codex's frozen upt-rung4a/K3-SCREEN.json (read-only). Every check prints PASS/FAIL;
every CONTROL is a perturbation that must FAIL its inequality (it passes as a control when it fails)."""
import json, sys
from fractions import Fraction as F
from math import ceil, floor, comb
from itertools import combinations

SCREEN = str(__import__("pathlib").Path(__file__).resolve().parent / "frozen" / "upt-rung4a") + "/K3-SCREEN.json"
def ex(v): return F(v["exact"]) if isinstance(v, dict) else v
_J = json.load(open(SCREEN))
P = {k: ex(v) for k, v in _J["plant"].items()}; Q = {k: ex(v) for k, v in _J["quantities"].items()}
R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))

N, M, H, K = P["N"], P["M"], P["H"], P["whole_island_tolerance"]
S, REP = P["guaranteed_live_hosts"], P["local_replica_count"]
LOST = H - S                       # 71 whole-window local losses per island
C = REP + 1                        # 74-copy path (rung4a convention)
AUTHQ, QUOTA, HOSTREP = Q["repair_auth_daily_quota"], Q["per_island_reseed_endpoint_quota"], Q["per_host_reseed_endpoint_service_target"]
assert (N, M, H, K, S, REP, LOST, AUTHQ, QUOTA, HOSTREP) == (400, 1032, 242, 3, 171, 73, 71, 2**25, 400000, 16384)

# ---------------- GATE 1: the charged 32-date repair calendar -----------------
AUTH_PER = 4 * 128                              # admitted auth units per header (rung4a)
D = 2 * 2 * (M * H + K * M * C)                 # conservative headers per returned island (rung4a 'returned')
check("G1.0 inventory reproduces rung4a authentication work 980680704", D * AUTH_PER == 980680704, D)
SLOTS_PER_DATE = AUTHQ // AUTH_PER              # 65536 admitted attempts / receiver / date
SERVICE = 30                                    # dates 2..31 after stable return
SPARE = SERVICE * SLOTS_PER_DATE - D
check("G1.1 spare attempt slots over 30 service dates", SPARE == 50688, SPARE)
# Rule X (fail-stop exclusion): a host that is unavailable or fails an attempt is excluded for the rest of the
# window as source and destination, and is counted in that island's whole-window loss set (<= 71).
# Rule W: at most w_s = 1 attempt in flight per (source host, receiver); at most w_d = 8 per destination host.
WS, WD = 1, 8
SOURCE_ISLANDS = N - K                           # the 3 returned islands are never used as sources
def waste(ws, wd, lost=LOST): return SOURCE_ISLANDS * lost * ws + lost * wd
W = waste(WS, WD)
check("G1.2 wasted attempts per receiver <= spare (each excluded host wastes at most its in-flight cap once)",
      W <= SPARE, f"waste {W} <= spare {SPARE}; auth {W*AUTH_PER} <= slack {SPARE*AUTH_PER}")
control("G1.2 w_s = 2 in flight per pair", waste(2, WD) <= SPARE, waste(2, WD))
def waste_no_x(flaps): return flaps * waste(WS, WD)   # without Rule X each host may fail repeatedly
control("G1.2 no exclusion: every lost host fails twice", waste_no_x(2) <= SPARE, waste_no_x(2))
# Rule F (front-loading): base headers are admitted at the full 65536/date until exhausted; every slot after
# that is reserved for retries. Base finishes at service date 29 + 14848/65536; the tail holds SPARE slots, so
# every waste, whenever it occurs (all occur before the last base admission or during the tail itself, and
# each excluded host contributes once), is re-admitted before the deadline.
base_full, base_rem = divmod(D, SLOTS_PER_DATE)
check("G1.3 base work ends inside service date 30; retry tail = spare", (base_full, base_rem) == (29, 14848) and
      SLOTS_PER_DATE - base_rem == SPARE, (base_full, base_rem))
control("G1.3 base spread evenly over 30 dates (tail per date only 1689 slots) against a final-date waste burst",
        (SPARE // SERVICE) >= W, SPARE // SERVICE)
# Completion: the last admission must leave one P-LAT quantum (1/1024 date = 64 slots) before date 32.
check("G1.3b completion: spare minus the final quantum still covers the waste", SPARE - SLOTS_PER_DATE // 1024 >= W, SPARE - SLOTS_PER_DATE // 1024)
# Rule M (fair merge): each receiver orders its headers by virtual time (j+1/2)/d_m over its n_rec records.
# Lemma: a block of B consecutive positions spans virtual time <= (B + n_rec)/D (every record has at least
# (b-a)d_m - 1 points in [a,b]), so it holds at most floor((B + n_rec) d_m / D) + 1 headers of record m.
B = SLOTS_PER_DATE
n_rec = M + K * M                                 # records feeding one receiver: own primary group + K mirror groups
def blk(d): return floor(F(B + n_rec, 1) * d / D) + 1
d_home, d_mirror = 2 * 2 * H, 2 * 2 * C           # headers one record supplies to its home / to one mirror receiver
per_rec_date_one = blk(d_home)
per_rec_date_all = blk(d_home) + (K - 1) * blk(d_mirror)   # worst record: home + two mirror receivers returned
d_rec_total = d_home + (K - 1) * d_mirror
check("G1.4 per-record per-date sends (derived block bound)", (per_rec_date_all, per_rec_date_one) == (58, 36), (per_rec_date_all, per_rec_date_one))
# Source capacity per date under P-LAT (an attempt completes or is declared failed within 1/1024 date):
# a pair (source host, receiver) carries <= 1024 attempts/date; a source host <= 3*1024 <= HOSTREP.
PAIR = 1024
check("G1.5 per-source-host throughput 3*1024 within reserved host repair service", K * PAIR <= HOSTREP)
# Hall on each surviving island: holders are 73 consecutive hosts mod 242; at most 4 home groups are held
# (one primary + K mirrors), so at most 4*ceil(M/H) = 20 records start at any index. A union component of
# length l (73<=l<=241) holds at most 20(l-72) records and at least l-71 live hosts; full circle >= 171.
starts = 4 * ceil(F(M, H))
def hall(demand, cap, circle_total=None):
    # circle_total: the most that can be asked of one island in the period (never more than what is admitted)
    tot = 4 * M * demand if circle_total is None else min(4 * M * demand, circle_total)
    return all(starts * (l - REP + 1) * demand <= cap * (l - LOST) for l in range(REP, H)) and tot <= cap * S
check("G1.6 Hall, all receivers, per date (cap 3*1024)", hall(per_rec_date_all, K * PAIR))
check("G1.7 Hall, each receiver separately, per date (cap 1024 per pair)", hall(per_rec_date_one, PAIR))
check("G1.8 Hall, whole window, at the full host repair service", hall(d_rec_total, 29 * HOSTREP))
control("G1.7 P-LAT relaxed to 1/512 date", hall(per_rec_date_one, 512))
check("G1.6b margin: Hall still holds at 72 local losses (one live holder per record)", all(starts*(l-REP+1)*per_rec_date_all <= K*PAIR*(l-72) for l in range(REP, H)))
control("G1.6 73 local losses (a record can lose every holder)", all(starts*(l-REP+1)*per_rec_date_all <= K*PAIR*(l-73) for l in range(REP, H)))
# Retries in the tail: retries for records of a component of length l come only from excluded hosts in its arc
# (<= min(LOST, l) sources, one in-flight each) plus excluded destinations at the receiver (<= LOST*WD), and are
# served by >= l-71 live holders in tail time SPARE/SLOTS_PER_DATE at the pair rate.
tail = F(SPARE, SLOTS_PER_DATE)
check("G1.14 tail retries fit per-pair capacity in every component",
      all(min(LOST, l) + LOST * WD <= floor(PAIR * tail) * (l - LOST) for l in range(REP, H + 1)), float(tail))
control("G1.14 retry tail compressed to 1/4 of the spare", all(min(LOST, l) + LOST * WD <= floor(PAIR * tail / 4) * (l - LOST) for l in range(REP, H + 1)))
# Island endpoint quota per date: 3 receivers' admissions, both endpoints charged at one island (conservative),
# plus one 4KiB header/state endpoint and 128 control units.
ep = K * SLOTS_PER_DATE * 2 * (1 + F(1, 65536)) + 4096 + 128
check("G1.9 endpoint work per island per date within 400000 quota", ep <= QUOTA, float(ep))
# Destination host per date (cap HOSTREP): primary group M + mirror records <= K*312, both conservative factors.
dest_records = M + K * Q["per_home_max_holder_records"]
dest_date = dest_records * blk(4)
check("G1.10 destination host per-date load within host repair service", dest_date <= HOSTREP, dest_date)
check("G1.11 destination in-flight cap w_d=8 sustains it under P-LAT", WD * PAIR >= dest_date, WD * PAIR)
# Pool background: 3 receivers' per-date endpoints inside the residual after normal checkpoint traffic.
RATE = F(1384, 1032); pop = Q["population"]
normalpool = 2 * K * 400 * pop * RATE + 4096
check("G1.12 pool background residual covers per-date repair", normalpool + ep <= P["pool_background"],
      float(P["pool_background"] - normalpool - ep))
# Sources exist under every allowed mask: 4 copy islands per home (primary + K mirrors), <= K lost; on the
# surviving island >= REP - LOST = 2 live holders per record. Exhaustive over all 3-subsets of a 7-island window.
ok = all(any(i not in lost for i in range(4)) for lost in combinations(range(7), 3))
check("G1.13 every record keeps a source island under every 3-island mask", ok and REP - LOST >= 2)
control("G1.13 four lost islands", all(any(i not in lost for i in range(4)) for lost in combinations(range(7), 4)))

# ---------------- GATE 2: degree-3 key and authority composition -----------------
T, NSH = K + 1, 2 * K + 1                          # 4-of-7
check("G2.1 availability: K lost shareholders leave >= threshold", NSH - K >= T)
check("G2.2 secrecy: K captured shareholders hold < threshold (degree-3 Shamir hides the secret)", K < T)
# Composition: each checkpoint generation has a fresh, independent 512-bit DEK and fresh coefficients, so shares
# from different generations are shares of independent secrets. Retained generations: 2. A capture set of <=K
# islands observes <=K shares of each generation; no generation reaches threshold, and independence means
# combining generations adds nothing. Brute-force over a small field: any K shares of a degree-K polynomial
# are uniformly distributed regardless of the secret.
p = 7
def views(secret):
    from collections import Counter
    c = Counter()
    for a1 in range(p):
        for a2 in range(p):
            for a3 in range(p):
                c[tuple((secret + a1*x + a2*x*x + a3*x**3) % p for x in (1, 2, 3))] += 1
    return c
v = [views(s) for s in range(p)]
check("G2.3 three shares of a degree-3 polynomial (GF(7) model) are independent of the secret", all(x == v[0] for x in v))
def views2(secret):
    from collections import Counter
    return Counter(tuple((secret + a1*x + a2*x*x) % p for x in (1, 2, 3)) for a1 in range(p) for a2 in range(p))
control("G2.3 degree 2 (3-of-5) observed by three shareholders: view independent of secret",
        all(views2(s) == views2(0) for s in range(p)), "three points determine a degree-2 polynomial")
# Authority: release needs T shares delivered to the uniquely attested instance; captured holders (<=K<T) cannot
# reconstruct, and a stale epoch cannot release because its shares belong to a retired, independent DEK.
check("G2.4 release threshold exceeds any capture set", T > K)

# ---------------- GATE 4: journals, quorums and certificates -----------------
QL, QP = P["local_journal_quorum"], P["pool_journal_quorum"]
check("G4.1 local journal safety: two quorums intersect in > 0 hosts", 2 * QL - H >= 1, 2 * QL - H)
check("G4.2 local journal liveness: >= quorum live under 71 losses", H - LOST >= QL)
check("G4.3 pool journal: two quorums share more islands than any K captured", 2 * QP - N > K, 2 * QP - N)
check("G4.4 pool journal liveness: N - K >= quorum", N - K >= QP)
control("G4.3 pool quorum 201 at K = 3", 2 * 201 - N > K)
check("G4.5 certificate inventory within work cap (rung4a)", Q["certificates"] <= P["certificate_work_cap"])
check("G4.6 canonical batch within cap", Q["canonical_batch"] <= P["canonical_batch_cap"])

# ---------------- GATE 6: the k3 -> k2 twilight transition -----------------
# Transition at a checkpoint boundary, only when <= 2 islands and <= 70 local hosts are unavailable
# (else postponed). Step 1: the next fresh DEK is shared 3-of-5 instead of 4-of-7 (a normal checkpoint op).
# Step 2: the third mirror stream stops; its images are retired after the two retained k2 generations commit.
# Local journal reconfigured 171 -> 172 by joint consensus (both quorums required during the joint phase).
K2, T2, N2 = 2, 3, 5
check("G6.1 k2 sharing: availability and secrecy at 2 losses", N2 - K2 >= T2 and K2 < T2)
check("G6.2 joint-consensus local journal live at <= 70 losses", H - 70 >= max(QL, 172))
check("G6.3 pool journal 202 serves both k3 and k2 (2*202-400 > 2)", 2 * QP - N > K2)
# Generations during overlap: k3 generations g-1, g plus new k2 generation g+1 are of the SAME images on a SUBSET
# of islands; the retiring third mirror holds at most the two k3 generations, never a third. Memory per host
# stays within the k3 cap because the k2 image set is a subset of the k3 one.
check("G6.4 steady k3 memory within cap (the overlap peak equals it: argued in G6, not computed)", Q["memory"] <= P["memory_cap"])
check("G6.5 tolerance never dips below k2 during the transition", min(K, K2) == K2)
control("G6.2 transition attempted at 71 losses", H - 71 >= 172)

# ---------------- ITEM 2: primary snapshot reuse at 73 replicas -----------------
CP_EVENTS = ceil(F(M) * (1 + 2 * F(1, 1024)) / (F(3, 4) - 2 * F(1, 1024))) + 1
x_exiles = ceil(F(M * K, N - K)); pop = M + x_exiles
events = CP_EVENTS + 2 * x_exiles
prim = 2 * C * events
check("G3.1 padded capture events reproduce rung4a (1384 + 2*8)", (CP_EVENTS, x_exiles, pop, events) == (1384, 8, 1040, 1400), events)
check("G3.2 74-copy primary checkpoints both endpoints fit the already-paid 242-host snapshot service",
      prim * (1 + F(1, 65536)) <= H * pop, f"{prim} <= {H*pop}")
check("G3.3 primary checkpoint lag within the checkpoint bound (rung4a)", Q["primary_lag"] <= Q["checkpoint"])
cmax = max(c for c in range(1, 200) if 2 * c * events * (1 + F(1, 65536)) <= H * pop)
check("G3.4 margin: snapshot service fits up to 89 copies", cmax == 89, cmax)
control("G3.2 90 copies", 2 * 90 * events * (1 + F(1, 65536)) <= H * pop)

# ---------------- ITEM 3: inherited accounts at k = 3 -----------------
# care slots: 8 slots per live host; the account charges >= h-132 = 110 down; failure needs pop > 8*(H-d).
d_fail = min(d for d in range(H + 1) if pop > 8 * (H - d))
check("A.1 care-slot account cut (110) is at or below the first failing down-count at k3", 110 <= d_fail, d_fail)
# pool-level provider economy: total protected minds per pool is unchanged by exile redistribution
check("A.2 evacuated minds fit survivors' exile slots (K*M <= (N-K)*x), so the pool total N*M is conserved", K * M <= (N - K) * x_exiles, (K * M, (N - K) * x_exiles))
control("A.2 seven exile slots per survivor", K * M <= (N - K) * 7)
# local quorum term: rung4a adds C(H,72)p^72 because quorum 171 first fails at 72 lost
check("A.3 local quorum first fails at 72 lost hosts", H - 72 < S <= H - 71)
# site-availability term: total site loss cap 79 at k3 -> first excess at 80 sites among H+90
check("A.4 site-loss account counts the first excess (80 of 332)", P["total_site_loss_cap"] + 1 == 80 and H + P["passive_sites"] == 332)

# ---------------- conclusions 1 and 5 recomputed from raw screen fields (referee finding 1) -----------------
J = _J
rows21 = J["all21_screen"]["rows"]
R_k3 = max(F(r["with_reserve"]["exact"]) for r in rows21.values())
tw1 = {k: ex(v) for k, v in J["benchmark_comparison"]["TW1_margins"].items()}   # inherited from frozen JW2.6 via rung4a
check("C5 union 3*R_k3 + R_TW1 < 1e-6, R_k3 recomputed as the worst of all 10 rows", 3 * R_k3 + tw1["failure_bound"] < F(1, 10**6), float(3 * R_k3 + tw1["failure_bound"]))
energy_frac = (Q["energy_flow"] - Q["energy_use"]) / Q["energy_flow"]
check("C1 energy margin fraction recomputed: k3 > TW-1", energy_frac > tw1["energy"], (float(energy_frac), float(tw1["energy"])))
check("C1 memory margin fraction recomputed: k3 > TW-1", (P["memory_cap"] - Q["memory"]) / P["memory_cap"] > tw1["memory"])
check("C1 interconnect margin recomputed: k3 > TW-1", (P["interconnect"] - Q["interconnect_activity"]) / P["interconnect"] > tw1["interconnect"])
check("C1 care, provider, checkpoint margins recomputed: k3 > TW-1",
      (F(19, 20) - Q["care"]) / F(19, 20) > tw1["care"] and (F(19, 20) - Q["provider"]) / F(19, 20) > tw1["provider"]
      and (F(1, 4) - Q["checkpoint"]) / F(1, 4) > tw1["checkpoint"])
check("C1 failure bound: R_k3 < R_TW1", R_k3 < tw1["failure_bound"])
control("C1 TW-1 energy fraction compared against itself", tw1["energy"] > tw1["energy"])

# ---------------- self-review repairs -----------------
# SR-1 Rule M': when destinations are excluded their headers leave the queue; the receiver re-merges the
# remaining queue, so the block bound uses the smallest remaining inventory D' = D - 71 * (headers per dest host).
per_dest = 2 * 2 * (M + K * Q["per_home_max_holder_records"])
Dp = D - LOST * per_dest
def blk2(d, Btot=B, Dtot=Dp): return floor(F(Btot + n_rec, 1) * d / Dtot) + 1
one2 = blk2(d_home); all2 = blk2(d_home) + (K - 1) * blk2(d_mirror)
check("SR-1 re-merged block bound after 71 destination exclusions", (per_dest, Dp, one2, all2) == (7872, 1356480, 50, 82), (one2, all2))
check("SR-1 Hall per receiver after re-merge (pair cap 1024, circle <= admitted 65536)", hall(one2, PAIR, B))
check("SR-1 Hall all receivers after re-merge (cap 3*1024, circle <= 3*65536)", hall(all2, K * PAIR, K * B))
control("SR-1 pair cap 994 after re-merge", hall(one2, 994, B))
# SR-2 placement: every group uses a consecutive 73-holder layout starting at 73*rank + offset_g; for ANY offsets
# the starts per index are <= ceil(M/H) per group, so <= 20 for four groups.
idx = [0] * H
for rank in range(M): idx[(REP * rank) % H] += 1
check("SR-2 one group's starts per index <= 5", max(idx) == ceil(F(M, H)) == 5, max(idx))
two = max(max(idx[i] + idx[(i - o) % H] for i in range(H)) for o in range(H))
check("SR-2b every pair of offsets: <= 10 starts per index (enumerated); four groups <= 20 by summation", two <= 10 and 4 * max(idx) == starts, two)
# SR-3 P-LAT trade-off: halving the admitted rate (twice the window) supports a 1/512 timeout.
one3 = blk2(d_home, B // 4)
check("SR-3 a 1/512 timeout fits at a quarter of the auth rate (about 120 service dates)", hall(one3, 512, B // 4), one3)
control("SR-3 a 1/512 timeout at half the auth rate", hall(blk2(d_home, B // 2), 512, B // 2))
# SR-4 key generation lifetime (two retained checkpoints) lies inside the 32-date window, so a mobile
# capture of distinct islands over a generation's life is bounded by the same <= 3 per window premise.
check("SR-4 generation lifetime 2 * 3/4 date within the recovery window", 2 * F(3, 4) <= 32)

ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R), "waste": W, "spare": SPARE}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
