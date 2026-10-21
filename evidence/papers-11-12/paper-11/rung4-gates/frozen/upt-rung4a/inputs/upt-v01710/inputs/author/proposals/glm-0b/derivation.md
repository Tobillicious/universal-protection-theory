# Problem 0b — a conditional derivation of P-ISLANDS's k ≤ 2 as a race

**Status: PROPOSAL, not a proof.** The honest conclusion of this document is:

> **Under assumptions A1–A9 and design facts D1–D7**, with only conservation of energy
> (PL1) and finite signal speed (PL2) as physics, a coalition cannot disable more than
> k = 2 whole islands of a 400-island pool within any reseed period of ≤ 64 dates,
> **and** it cannot destroy any specific mind's image copies by disabling islands.
> The load-bearing quantitative drivers are **assumed** (A4, A5, A7); removing any of
> them collapses the bound. P-ISLANDS is therefore *conditionally reduced* to an
> explicit, exact-checkable list of physical/architectural inequalities — not derived
> from raw physics alone.

This matches the author's own framing (UPT-P v0.17.8 §2: P-ISLANDS "may be derivable
from physical limits, as a race decided by physics"; "Deriving it is open problem 0b";
and JW2.6 REPORT: "No substantial global coordinated-attacker fraction is inferred
from k = 2"). Everything below is written so an independent checker can recompute it:
the exact arithmetic is in `scratch/check_0b.py` (run `python3 -B scratch/check_0b.py`;
output in §7 and `scratch/check_0b.out`).

---

## 1. The race in one paragraph

A coalition that wants to defeat the pool must, within **one reseed period** of `T`
dates (a lost island stays counted until it is reseeded — D2), finance and execute
**disablements of whole islands**. Each such disablement is a physical act that must
overpower the island's own plant for at least one counting tick (PL1: the coalition's
draw cannot undercut the island's draw and still erase it), so each disablement has a
minimium resource cost. The defender's re-drawing of secret mirror placement
(P-REDRAW, D3–D5) makes *targeted* erasure a lost race: the coalition's knowledge of
placement goes stale faster than blind search converges, so damage to any specific
mind degrades to a ~1.26×10⁻⁵ blind-hit probability. The decisive inequality is the
**count race**:

    eps · T · N  <  3 · f_m · τ_dis        (disablements financed per period < 3)

which is invariant under rescaling of the plant's energy unit (the island envelope
`P_i` cancels). Everything else in the model supports this or degrades gracefully.

---

## 2. Variables (every one: unit, and PHYS / DESIGN / ASSUMED / DERIVED)

### Design facts D1–D7 (from UPT-P v0.17.8 §0/§2 and codex/upt-jw26)

| Sym | Meaning | Unit | Class |
|---|---|---|---|
| D1: `N = 400` | logical islands per pool | islands | **DESIGN** (JW2.6 CONTRACT §1) |
| D2: `T = 64` | reseed period; losses count until reseeded; repeated flapping cannot reset the count | dates | **DESIGN** (CONTRACT §13; UPT §2) |
| D3: images per mind | home `h` + two full encrypted foreign mirrors, placed by a keyed PRF (secret, non-adjacent), mirrors do not execute | images | **DESIGN** (CONTRACT §2; UPT §2 repair) |
| D4: keys | fresh 512-bit state key every checkpoint, degree-2 Shamir 3-of-5 over GF(2¹⁶) (`0x1100b`), shares at h..h+4; two observed shares leak nothing | — | **DESIGN** (CONTRACT §4) |
| D5: authority | 202-of-400 pool journal, 172-of-242 local; two 202 quorums intersect in ≥ 4 islands | votes | **DESIGN** (CONTRACT §6) |
| D6: plant per island | 242 compute hosts + 80 passive sites; island energy envelope `P_i` per date | hosts, sites, energy-units | **DESIGN** (price targets, CONTRACT §16) — **not measurements** |
| D7: checkpoint cadence | full ciphertext captured every ≤ 3/4 date, clock-padded; sealed prefetch below 63/128 date; re-mirror is continuous | date | **DESIGN** (CONTRACT §§10–11) |

### Physical laws PL1–PL2 (the only physics numerically invoked)

| Sym | Meaning | Status |
|---|---|---|
| PL1 | conservation of energy / locality: resource accounting is additive; an act that erases an island's active plant cannot be financed by less than the island's own sustained draw (plus a margin) | **PHYS** (conservation). The *margin* f_m and the *granularity* τ_dis that turn this into a number are **ASSUMED** (A4, A7) |
| PL2 | finite signal speed: information and acts propagate at ≤ c; inter-island coordination implies a propagation floor | **PHYS-consistent** but left **uncalibrated** (no seconds: GAP G1). Not numerically load-bearing in the checker |

Parity/cosmological facts (10²⁰ islands, 10¹⁰⁰ dates) are only referenced, not re-derived here (GAP G8).

### Assumed parameters A1–A9 (each is what a line-by-line checker attacks)

| Sym | Meaning | Unit | Basis |
|---|---|---|---|
| A1: `v_probe = 4` | covert island-probes the coalition sustains per date per targeted mind | probes/date | **ASSUMED** (illustrative; bounded by wire/CPU/burst attention budgets — not derived) |
| A2: `R_d = 4` | placement re-draw / re-key period | dates | **ASSUMED value of a DESIGN GOAL** (P-REDRAW "re-drawn faster than a coalition can map peers' locations"; UPT §2 says re-draw is "not yet priced" — GAP G5) |
| A3 | every whole-island disablement is detected and the loss counted within the period (failover slots: ≤ 6 exiles/live island at 398 survivors; pool journal quorum survives) | — | **DESIGN** (JW2.6 CONTRACT §9) with assumed realization |
| A4: `f_m = 3/2` | disablement margin: cost of one sustained island disablement ≥ `f_m × P_i × τ_dis` | − | **ASSUMED**. Conservation alone gives `f_m ≥ 1` as a floor only if the erasee's draw must be matched; the multiplicative margin and the whole "cost package" for seizing 242 hosts + 80 sites are a placeholder empirical law (GAP G2) |
| A5: `ε = 1/8192` | coalition's **sustained** share of the pool-fleet energy envelope `N·P_i` | fraction | **ASSUMED** (GAP G3: no mechanism derives a global coordinated share; JW2.6 explicitly declines to) |
| A6 | placement secrecy holds against observation: share-observations leak nothing extra (exact check included); no other side channel is priced | bits | **ASSUMED** (computational; the 459-bit uniform C-SEQ premise is inherited, not derived here — GAP G6) |
| A7: `τ_dis = 1` | counting granularity: a disablement is sustained ≥ 1 date (the fault law is date-level) | date | **ASSUMED** (GAP G7: rolling sub-date sabotage unmodeled) |
| A8 | disablement events themselves leak no placement information (blind hits stay blind) | — | **ASSUMED** |
| A9 | no stockpiling: the coalition cannot bank or borrow energy beyond its per-date inflow share across the period | — | **ASSUMED** (GAP G4) |

### Derived quantities (exact, all recomputed by the checker)

| Sym | Formula | Value at D+A above | Class |
|---|---|---|---|
| `E_dis` | `f_m · P_i · τ_dis` | 8784/5 = 1756.8 energy-units/disablement | DERIVED (from A4, A7, D6) |
| `E_A` | `ε · N · P_i` | 915/16 = 57.1875 units/date | DERIVED (from A5, D1, D6) |
| period budget | `T · E_A` | 3660 energy-units | DERIVED |
| `D_max` | `⌊T·E_A / E_dis⌋` | 2 | **DERIVED (the count bound)** |
| `ε*` | `3·f_m·τ_dis / (T·N)` | 9/51200 ≈ 1.758×10⁻⁴ | **DERIVED (critical share; `P_i` cancels)** |
| locate time | `T_loc = (2/3)(N+1)/v_probe` | 200/3 ≈ 66.67 dates | DERIVED (order statistics of blind search; A1, A2, D3) |
| blind hit | `P_dest = 1 / C(N−1, 2)` | 1/79401 = 1.2594×10⁻⁵ | DERIVED (matches author's ~1.26×10⁻⁵) |
| quorum overlap | `202+202−400` | 4 ≥ 2 honest at k = 2 | DERIVED (D5: supports the defender's side of the race) |

---

## 3. Model dynamics

### 3.0 Calendar and accounting (the "bigger clock")

The calendar of one reseed period of `T = 64` dates (D2):

```
[ 64 dates of the reseed period; every whole-island loss stays COUNTED until its island is reseeded ]
  attacker events:  probe → (optionally) pin → disable island j
  defender events:  detect (≤ A3) · re-mirror/checkpoint (D7 cadence ¾ date) · re-draw placement (A2) · reseed (≤ 64 dates)
```

Nothing resets the count mid-period: JW2.6 ensures power-on alone cannot clear a loss,
failed flapping cannot clear one, and return/reseed takes up to the whole period
(CONTRACT §13). Hence the correct race arena is exactly one period — an attacker
cannot "pay" for an earlier period's excess in a later one; every period's count must
be held under the same resource race. That is why the bound is *per reseed period*,
not per date or per lifetime.

### 3.1 Leg 1 — the COUNT race (attacks *any* islands; decides the k)

Let the coalition disable `j` whole islands within one period. For island `i`:

- its sustained draw is `P_i` per date (D6), and erasing 242 hosts + 80 sites that
  keep drawing/defending requires, over the disablement's duration, an attacker-side
  commitment ≥ `f_m · P_i · τ_dis` (PL1 + A4 + A7). Units: energy-units per disablement.
- the coalition's total energy inflow is ≤ `ε · N · P_i` per date (A5 + PL1).
  **No-parallelism shortcut**: even if disablements run concurrently, the *sum* of the
  `j` commitments is still charged against the same period inflow `T · ε · N · P_i`
  (additivity, PL1). So financing `j` disablements requires

      j · E_dis ≤ T · E_A     ⇔     j ≤ T · ε · N / (f_m · τ_dis) =: D_max.

  (The plant envelope `P_i` cancels; the bound is independent of the energy unit.)
- The count leg therefore derives: **`D_max ≤ 2` if and only if `ε · T · N < 3 · f_m · τ_dis`.**

At the illustrative parameter point: `T·E_A = 3660`, `2·E_dis = 3513.6 ≤ 3660` (two
disablements affordable), `3·E_dis = 5270.4 > 3660` (three not), so `D_max = 2` — the
premise's value *exactly* at the assumed parameters, with margin ratio `5270.4/3660 ≈ 1.44`.
Equivalently, the derived critical share is `ε* = 9/51200 ≈ 1.758×10⁻⁴`: the
conditional content of the derivation is

> **the count leg P-ISLANDS holds against every coalition whose sustained energy
> share of the pool fleet is below ≈ 0.0176% (at f_m = 3/2, τ_dis = 1 date, T = 64,
> N = 400); the share precondition is A5, an ASSUMED parameter (GAP G3).**

### 3.2 Leg 2 — the LOCATE race (attacks one *specific* mind; decides that damage is graceful)

To destroy mind `m`'s images while `m` lives at home `h`, the coalition must disable
`h` and both mirrors. Mirror islands are chosen by a keyed PRF (D3) from the other
`N−1` islands; without side information (A6/A8) the coalition's probe order is blind.
Order-statistics of blind search: the expected number of probes until *both* marked
islands have been touched is `2(N+1)/3 = 800/3 ≈ 266.67`; at `v_probe = 4`/date the
expected locate time is `T_loc = 200/3 ≈ 66.7` dates. Placement re-draws every
`R_d = 4` dates (A2), invalidating previously learned locations, so the locate race
tight form is:

    T_loc  =  2(N+1)/(3·v_probe)   >   R_d        (defender wins; A2's P-REDRAW form)

At the parameter point `66.7 > 4` with margin ×16.7 — the coalition cannot pin a mind's
mirrors within a re-draw window, so *every* completed-erasure attempt on a specific
mind degrades to blind sampling, with exact destruction probability

    P_dest = 1 / C(N−1, 2) = 1/79401 ≈ 1.2594×10⁻⁵ ,     (author: ~1.26×10⁻⁵ ✓)

computed here (1) as the arithmetic event "h and two blind picks cover the pair of
secret mirror islands", noting the exact author statement is over *known-home +
2 blind islands*, matching; (2) under the assumption A8 that disablements/probes leak
no placement info (GAP G6). This per-mind residual is a probability account that must
live inside the declared 10⁻⁷ common/premise floor's bookkeeping — it is *not* part of
the k-count.

Note the division of labor: **the count leg never uses placement secrecy** (disabling 3 *arbitrary*
islands is not a targeted act), and **the locate leg never tightens the count**. These
are independent races, and the premise needs both: the count caps drawer-scale damage;
secrecy+re-draw caps harm per drawer.

### 3.3 Supporting legs (defender's continuity; exact-checked)

- **Quorum support (D5):** two 202-of-400 pool journals intersect in
  `202+202−400 = 4 ≥ 2` islands, so at k = 2 nonconforming islands ≥ 2 honest
  intersection members keep the durable lock. Without this, a k = 2 coalition could
  split the authority and void the failover side of the race. (This is a safety lemma,
  not consensus liveness — JW2.6 MATHEMATICS.)
- **Key-share secrecy (D4):** two observed degree-2 Shamir shares over GF(2¹⁶)
  determine `(a, b)` uniquely per secret — det `x·y·(x+y) ≠ 0` for all 10 pairs
  (exact finite-field check in the checker, mirroring JW2.6's test). This is the
  arithmetic core of A6 for the share-observation channel only (GAP G6 for the rest).
- **Checkpoint cadence (D7):** re-mirroring every ≤ ¾ date with clock padding keeps
  mirror copies fresh ≤ 1 date older than the primary, so a disablement that starts
  mid-period cannot "wait out" a stale copy — the mirror images a coalition pins are
  current images, and re-draw re-keys the *placement of current images*, which is what
  makes Leg 2 a lost race rather than a stale-target race. Realization obligations
  (composed journal, streaming commitments) belong to JW2.6's contract list, not to
  this derivation.

### 3.4 What the two legs *together* give

Under D1–D7, PL1–PL2 and A1–A9:

    (i)  ε·T·N < 3·f_m·τ_dis                          ⇒  no ≥ 3 island disablements per reseed period
    (ii) 2(N+1)/(3·v_probe) > R_d                     ⇒  no specific-mind erasure by island disabling;
                                                          residual blind hit = 1/C(N−1,2) ≈ 1.26e−5

**(i)+(ii) is exactly P-ISLANDS(k = 2) as stated in UPT §2** ("coordinated minds
disable at most two whole islands per pool within any reseed period"), plus the
author's graceful-degradation note for one-island premise excess.

---

## 4. What is DERIVED vs what is ASSUMED (explicit)

**Derived (exact arithmetic, checker-verified):**
1. The count-leg closed form `D_max = ⌊ε·T·N/(f_m·τ_dis)⌋` and its `P_i`-cancellation
   (energy-unit invariance).
2. The critical-share condition `ε·T·N < 3·f_m·τ_dis` (numbers above: `D_max = 2`,
   `ε* = 9/51200`).
3. The locate-time order-statistic `2(N+1)/3` and the race form `T_loc > R_d`.
4. The blind-hit probability `1/C(N−1,2) = 1.2594×10⁻⁵` (author's ~1.26×10⁻⁵).
5. The 202-quorum intersection `4 ≥ 2` and the 10 Shamir determinants ≠ 0 (GF(2¹⁶)).
6. Load-bearing control failures: doubled share ⇒ `D_max = 3`; adjacent public
   placement ⇒ destruction probability 1; `v_probe = 600` ⇒ locate race won;
   `τ_dis = 1/8` ⇒ `D_max = 16`.

**Assumed (the whole quantitative content rests on these):**
- A4/A5/A7 (the margin `f_m`, the share `ε`, the granularity `τ_dis`): each is a
  *premise about capability and accounting*, moved from "P-ISLANDS says so" to an
  explicit, exactly-checkable slot. Nothing physical pins their values.
- A1/A2/A6/A8/A9 and the realization of A3: probing economics, re-draw pricing,
  side-channel silence, non-stockpiling, detection/failover infrastructure.
- D6's numbers are price targets, not measured hardware (JW2.6 is explicit).
- PL2 is never converted to numbers (GAP G1).

---

## 5. Dependence on the uncalibrated "date"

The model is **written entirely in date units**; "date" is never calibrated to
seconds (UPT uses checkpoint age ≤ 1 date, reseed ≤ 64 dates, no SI mapping — GAP G1).
Consequences, stated exactly:

1. **The count-leg condition `ε·T·N < 3·f_m·τ_dis` is unit-consistent as an inequality
   about dates.** Its empirical content is the relative statement "one sustained
   disablement costs at least `f_m` × the island's own one-date envelope draw".
   Write the date as `s` seconds. Then `T` dates = `T·s` seconds and the counting
   tick `τ_dis` dates = `τ_dis·s` seconds, while the per-date envelope corresponds to
   a per-second envelope `P_i/s`. The affordable count in seconds is
   `⌊ε·(T·s)·N·(P_i/s) / (f_m·(τ_dis·s)·(P_i/s))⌋ = ⌊ε·T·N/(f_m·τ_dis)⌋`: unchanged —
   the **s cancels because both the period and the tick scale together, and both
   costs carry the same plant cadence**. The invariant is therefore a *relative*
   one (disablement cost measured in units of the plant's own per-tick dissipation);
   it would break only if the disablement cost were re-priced as an absolute
   physical constant of work independent of the plant cadence, which no evidence
   in this folder supplies.
2. Concretely controlled in the checker: re-counting at `τ_dis = 1/8` date admits
   `D_max = 16 ≫ 2` — the count premise is only as strong as the date-level
   granularity of the fault law it inherits (A7/G7).
3. PL2 (light speed) can only be *checked*, not used, without calibration: converting
   `a/c` into dates needs actual island separation in metres and a real second-length
   date. That consistency check is **not performed** (GAP G1); all timing content is
   carried by A-parameters instead.

So: **the bound as stated ("≤ 2 per ≤ 64-date reseed period") is date-relative and
unit-invariant under consistent re-granulation; a physically absolute (seconds-based)
reading is NOT claimed and would require the calibration this folder does not contain.**

---

## 6. Conditions under which P-ISLANDS follows (for a reviewer's consumption)

Under **D1–D7 + PL1 + A1–A9**, P-ISLANDS(k = 2, N = 400, reseed period ≤ 64 dates)
follows conditionally iff **all** of:

- **(C1)** count race: `ε·T·N < 3·f_m·τ_dis`;
- **(C2)** locate race: `2·(N+1)/(3·v_probe) > R_d`;
- **(C3)** accounting coherence: losses are date-granularly counted and not
  reset by power-on/flapping (D2), with redemption (reseed) no faster than the period;
- **(C4)** authority coherence: the pool journal survives k nonconforming islands
  (`202+202−400 ≥ 2`), and key-sharing keeps the secret against two observations;
- **(C5)** the blind-hit account `1/C(N−1,2)` per mind per excess island fits inside
  the already-budgeted common-floor/coordinated-load channels (cited from JW2.6's
  accounts; not re-derived here).

Failing any of these fails the premise *conditionally* — demonstrated by C1–C4's
controls in the checker (which must fail), plus the author's own finding that adjacent
public placement makes whole-defeat certain.

---

## 7. Checker and its output

`scratch/check_0b.py` (run `python3 -B scratch/check_0b.py`; exit 0 = all main checks
PASS and every control failed as predicted). Verbatim output:

```
PASS COUNT: count race admits at most floor(T*E_A/E_dis) whole-island disablements per reseed period  [D_max = 2; budget 3660.0 vs 2*E_dis 3513.6 and 3*E_dis 5270.4]
PASS COUNT: assumed share eps = 1/8192 sits below the derived critical share eps* = 3*f_m*tau_dis/(T*N)  [eps* = 9/51200 = 1.758e-04; eps = 1.221e-04]
PASS LOCATE: targeted-erasure race is lost (re-drawn before both mirrors can be pinned blind)  [T_loc = 66.6667 dates > R_d = 4.0 (probes/date = 4.0)]
PASS LOCATE: residual blind destruction of one fixed mind = 1/C(399,2) ≈ 1.26e-5 (author's 3-significant-figure figure)  [P_blind = 1/comb(399,2) = 1.259430e-05]
PASS KEYSHARE: two observed degree-2 shares over GF(2^16) poly 0x1100b fix (a,b) per secret: det = x*y*(x+y) != 0 on all 10 pairs  [10/10 determinants nonzero]
PASS QUORUM: two 202-of-400 pool journals intersect in >= 4 islands; >= 2 honest survive k = 2 nonconforming  [202+202-400 = 4]
PASS CONTROL COUNT doubling the share to eps = 1/5120 still caps disablements at 2  [eps = 1/5120 gives D_max = 3 > 2: the share premise A5 is load-bearing]
PASS CONTROL LOCATE public adjacent placement (h, h+1, h+2) leaves a targeted-mind blind-hit below 1e-4  [adjacent known placement destroys every copy with probability 1 (author, UPT section 2)]
PASS CONTROL LOCATE 600 covert probes per date still lose the race against R_d = 4  [v = 600 gives T_loc = 0.444 <= R_d: P-REDRAW re-draw rate is load-bearing]
PASS CONTROL COUNT shrinking the disablement granularity to 1/8 date still caps at 2  [tau_dis = 1/8 gives D_max = 16 >> 2: date-granular counting is load-bearing]
{"blind_hit": 1.2594299819901513e-05, "disablements_capped": 2, "eps_critical": 0.00017578125, "locate_time_dates": 66.66666666666667, "passed": 10, "share_assumed": 0.0001220703125, "status": "conditional proposal; see scratch/derivation.md GAPs G1..G8", "total": 10}
```

(The "PASS CONTROL" lines mean *the control failed as predicted* — the perturbed
premise does NOT support the k cap; the harness records expected failures as passes.)

---

## 8. GAPs — everything not justified (honest list)

- **G1 — no seconds calibration.** "date" is never tied to SI time; PL2 (signal
  speed) is used only qualitatively. Any absolute (seconds-based) version of the
  race would need island distances, actual per-second power, and a calibrated tick;
  none available here. The bound is date-relative, as §5.
- **G2 — disablement cost is a placeholder.** `E_dis = f_m·P_i·τ_dis` (A4) has no
  physical lower-bound derivation for `f_m`; the real package would include seizing or
  overpowering 242 attested hosts (fail-closed interlocks, capture-resistant clocks)
  and 80 sites across geography, plus labor/robotics — unmodeled. Conservation gives
  at most a floor at matching the plant's own draw; the factor 3/2 and the tick
  structure are assumptions.
- **G3 — no global coordinated share derivable.** A5 (`ε ≤ 1/8192 ≈ 0.0122%`)
  is assumed; JW2.6 explicitly declines to infer a coordinated-attacker fraction from
  k = 2. The derivation's honest content is conditional: *P-ISLANDS holds against
  coalitions below the derived share `ε* = 9/51200 ≈ 0.0176%`*; above `ε*`, a
  400-island pool at 64-date reseed periods is exposed (control C1).
- **G4 — stockpiling/one-off acts.** A9 excludes banking energy or executing a
  large one-off operation financed outside the sustained inflow model (external
  power, borrowed fleets). No reservoir bound is priced; the count leg fails under
  unlimited one-shot credit.
- **G5 — re-draw unpriced.** UPT §2 itself says the P-REDRAW mechanism ("re-drawn
  faster than a coalition can map peers' locations") is "not yet priced";
  `R_d = 4` and `v_probe = 4` are illustrative (A1/A2), not derived; receiver-anonymous
  routing with entry guards is a prerequisite that is likewise unpriced. Control C3
  shows the bound's dependence.
- **G6 — side-channel silence beyond share math.** A6/A8 assert that neither
  ciphertext handling, timing, failover activity, nor the disablement event itself
  leaks placement bits. Only the pure 2-of-5 share-observation claim is derived
  (10 determinants, exact). The 459-effective-bit uniform C-SEQ premise covering "all
  offline work, metadata, timing, placement and access patterns" is inherited, not
  established here.
- **G7 — sub-granularity sabotage.** Disablements shorter than the counting tick
  (rolling harassment of hosts rather than whole islands) are unmodeled; the count
  race's correctness rides on date-level accounting inherited from the fault law.
  Control C4 shows the dependence; the author's J-LIVE/local-fault accounts are the
  intended home for that residual.
- **G8 — multi-pool / cosmic composition.** A single 400-island pool over one
  period is modeled. The global statement (2.5×10¹⁷ pools × 10¹⁰⁰ dates, union bound
  via secret random pools) is only referenced (`author/work/check_secret_pools.py`);
  it rests on pool membership secrecy and re-draw (same GAP G5), and is not re-derived.
- **G9 — realization gap.** Detection (A3), failover, re-mirror streaming (D7),
  committed duty, attested execution: all remain JW2.6-level contract obligations,
  not measured hardware behavior. If any composed service cannot be realized at its
  paid targets, the race's defender side degrades and the condition must be re-derived.
- **G10 — the plausibility list is argument, not physics.** Jurisdictional spread,
  community embedding of sites, and the leakage risk of large simultaneous operations
  (UPT §2) support A4/A5 sociologically only; they are not premises I can derive.

**Bottom line for a line-by-line checker:** every number in this proposal is either
(i) an exact Fraction re-derivable from `scratch/check_0b.py` (all of §2's "derived"
table), (ii) a design fact quotable to UPT/JW2.6 (§2, D-rows), or (iii) an
explicitly ASSUMED parameter (§2, A-rows, GAPs G1–G10). Nothing is claimed as
"proven", "derived", or unconditional; the correct citation is *"under assumptions
A1–A9 (with D1–D7), P-ISLANDS(k=2) follows"*, with the critical-share readout
`ε* = 3·(3/2)·1/(64·400) = 9/51200 ≈ 1.758×10⁻⁴` from the count race and the
locate-race form `2(N+1)/(3·v_probe) > R_d`.
