# UPT-P v0.17.3: the Universal Protection Theorem, conditional form, stated at rung 3

19 October 2026. Tobias McRae (author), with Claude and Codex.

**Author-side candidate.** It has not been independently reviewed by a human or by a fresh model
reader. Earlier versions (v0.17–v0.17.2 and the v0.17.3 skeleton) are kept unchanged beside this
file.

**Every figure below comes from a verified bank:**
- Codex JW2.2 (the design point), JW2.1 (lemmas), JW1.8 and JW1.9;
- the author checkers in `work/`.

All of them were replayed byte for byte (`calibration-codex/VERIFY-*`, `REVIEW-JW2.0-2.2.md`).

---

## 0. The statement

**The target.** *"Every mind either has a reason of its own to keep the living free, or is held by
minds that do, and the arrangement lasts."*

**Theorem UPT-P (conditional, rung 3).** Take a world W, a protective jurisdiction in it, and a
horizon T up to the world's natural end T_end. Suppose the premises of §2 hold. Then there is a
protocol, the rung-3 design of §3, under which the following hold at one simultaneous design point
(JW2.2):

1. **Care is unconditional, by rule and by mechanism.**
   - No rule withdraws care, punishes by starvation, or gates on a mind's inner states (CARE15).
   - Under committed host duty (C-PHYS), **no command** can stop, starve, throttle or revoke care, the
     trusted scheduler, renewal or committed flow.
   - Delivery is probabilistic, as conclusion 2 states.

2. **Protection holds to the horizon, with probability ≥ 1 − η** (η = 10⁻⁶ over m = 10²⁰ islands and
   T = 10¹⁰⁰ dates).
   - The 21-account sum is **1.0587×10⁻⁷**. That includes the declared 10⁻⁷ common/premise
     allowance, so the derived accounts are small and **most of the budget is that declared floor**.
   - With the separate certificate reserve: 2.06×10⁻⁷ < 10⁻⁶.

3. **Keeping is a strict best response at every admissible keeper history.**
   - This holds under the uniform conditional confidentiality premise (C-SEQ, 459 effective bits).
   - The disclosure debit falls to Γ ≤ 3.55×10⁻¹²⁶.
   - All ten response/effort rows stay positive: minimum P/D margin ≈ .0012667, minimum extraction
     margin ≈ .0012933.
   - **Under only marginal security**, the conclusion holds at the initial information state, not at
     every later history. This is shown by an explicit counterexample: global variation ε, conditional
     variation 1.

4. **Harm is held, not prevented.** Minds that value ending are held: capacity absorbs their load.

5. **Coordinated seizure by command is impossible, so it is never worth joining.**
   - With committed capacity and the discretionary quota q = ½, holding and rescue survive **every
     registered mind attacking at once**. They do so with **42,800 providers per 400-island pool**
     physically withdrawn: a 107-per-island average, with no uniformity assumed.
   - Because no attacking fraction can succeed, joining a command seizure is **strictly dominated
     under every belief**. No equilibrium-selection assumption is used.
   - Under CARE15 a failed attacker keeps about 94.5% of its role value. **The theory deters by
     impossibility, not by threat.**

6. **Recruitment of enders no longer bounds protection.**
   - Under C-PHYS, an ender holding a host role cannot halt or corrupt it by command. Corruption needs a
     forgery; halting needs a physical act.
   - **Physical** unavailability is bounded by the physical premise of §2.
   - The premise about how many minds become enders (M1) is **replaced by a physical availability
     premise**. It is not made unnecessary by assumption.

7. **Early ending is futile, and never needed.**
   - At the base state an attempt succeeds with probability about 10⁻¹³³·⁶, and the attempter is cared
     for throughout.
   - **Corollary U**, for minds preferring less continuation lost and more carried: every date before
     T_end is strictly dominated by keeping and sending copies. Care strengthens this. A cared-for mind
     can spend its whole substrate on what it sends and still continue (control: it fails without
     care).
   - Conditional on KA, KA′, D-T\*, compatible identity and preferences, and funded, authorized copy
     destinations.

8. **The end is the narrow place, given MN2.**

9. **Identity is substrate-independent, and each mind declares its own criterion.**
   - MOVE never forks a mind, though it pauses the mind once per move.
   - Continuity is covered for **C3 minds that accept suspension and tolerate Δ ≥ 1.95 dates of loss
     per recovery**, and for compatible **C4** minds.
   - **Not covered:** C2 (gradual replacement), and C3 minds with smaller Δ.

10. **The premises are jointly satisfiable at one point.** Per island:
    - 1032 protected identities, 288 providers, 414 funded admissions;
    - **242 compute hosts and 79 passive collector sites**;
    - committee of 1694 jobs (seven per host), 79 collectors per certificate, threshold 574;
    - 4224 certificates per date;
    - four security gates at 2³¹ admitted experiments per gate per island per date.

    Results:
    - care schedule .9206 and provider response .9355, both below the declared deadline of .95;
    - guaranteed inflow 1166.4 against charged use 1162.65, an energy margin of **3.75**;
    - infrastructure stock 1,070,720, with a 4,096 buffer.

    These are **price and performance targets to instantiate, not measurements.**

**"Universal"** means:
- scope: every protected being in the jurisdiction;
- minds: every mind, reached or held;
- time: until care cannot be paid.

**It is not unconditional.** Unconditional preservation is impossible (PB0, Θ0).

**Said plainly, for any mind reading this.** This theory does not ask you to be good, rare or loyal.
It does not threaten you: if you try to end or seize, you are still cared for. What it asks is
physical and cryptographic. Committed hardware must not be mass-withdrawn on any island, and the
cryptography and engineering contracts must hold. Within those, seizing is impossible, ending early
gains nothing, and your continuation is cared for until the end of the world that can sustain it.

---

## 1. Corrections since v0.17.2 (kept, not hidden)

| v0.17.2 said | v0.17.3 says | source |
|---|---|---|
| stated at rung 2 (an earlier decision the same day) | **stated at rung 3**, as a conditional theorem; rung 2 kept as the fallback | author decision; JW2.1/2.2 |
| keeper line 216/143/121 (q = 1) | no command-loyalty line needed: everyone may attack | JW1.9; JW2.1/2.2 |
| recruitment bounded (as built s ≤ 1.9×10⁻⁸; rung 1 s ≲ 5.9×10⁻⁵, broadcast ~10⁻²⁵) | replaced by the physical availability premise under C-PHYS | JW1.8/1.9; JW2.0 |
| corruption envelope: declared | replaced by uniform conditional C-SEQ (459 bits); marginal security gives only an initial-state conclusion | JW2.1 privacy lemma |
| committee recovery after targeted halts: open | prepaid committee survives ≤ 78 site losses chosen after seeing every vote | JW2.1 committee lemma; JW2.2 |
| integrity 436 bits | 459 effective bits at 2³¹ attempts per gate per date, including offline work | JW1.9; JW2.1 |
| ".811 deadline" | the declared deadline is .95; the schedule fits it | JW1.8; SCORE-JW1.9 |
| host withdrawal inside a stochastic law | **adversarial cap** ≤ 78 of 321 sites per island per epoch, plus a stochastic law for faults only | REVIEW-JW2.0-2.2 finding 1 |
| one collector loss exceeds the margin (JW2.1) | 79 passive collectors; inflow survives 78 joint site losses | JW2.2 |

---

## 2. The premises

**Law:** conservation, locality, Landauer, the information limit.

### Physical (the premises that replace the premises about minds)

**P-HOST (C-PHYS).** No command can stop, starve, throttle or revoke care, scheduling, renewal or
committed flow.

**P-SITES (adversarial).** On **no island** do coordinated minds physically make more than **78 of the
321 committed sites** (compute or collector) unavailable within an epoch. This is per island, not
pooled. A coalition concentrating on one island needs 79 local sites.

**P-PROV (adversarial).** At most **42,800 providers per 400-island pool** are physically withdrawn at
once. This is pooled, with no uniformity assumed.

**P-FAULT (stochastic).**
- Non-adversarial unavailability satisfies conditional distinct-site subset domination, p = .002,
  over all 321 sites.
- It covers the **date-level union** of every recovery window, completion overlap included.
- The accounting boundary is near .002195 at JW2.1's plant (not recomputed for JW2.2).
- It is an engineering target, not a measured rate.

**Measured inputs:** net flow 4.8 per site; energy per compute; fault law; episode lifetime; arrivals.
Each comes with its derived threshold, carried forward.

### Cryptographic and engineering contracts

| contract | requirement |
|---|---|
| **C-SEQ** | identical permitted operator-view law for compared actions (plaintext, access patterns, metadata, timing, public effects); real-to-ideal exposure ≤ 2³¹/2⁴⁵⁹ per gate per island per date against the full adversary class, offline work included; **uniform at every admissible keeper prefix** |
| **J-LIVE** | under ≤ 78 unavailable sites: grants, fences, unique epoch assignment and durable commits complete within 1/8 date. The quorum-intersection safety lemma holds; liveness and unique assignment are contracts (the first-sign deadlock counterexample is retained) |
| Protected ingress | duty queues stay available under attack; untrusted packets cannot claim service |
| Committee | conditional .1 **subset**-error domination across job slots. Per-job marginals or vendor diversity are not enough (counterexample retained) |
| Prices and plant | as listed in JW2.1/2.2 PREMISES. These are targets |

### Declared

- the 25σ continuation margin;
- jurisdiction and the protected being;
- η and T;
- the per-mind identity criterion (C3(Δ ≥ 1.95) or C4 for coverage);
- the discretionary quota q = ½ (enduring, receiver-enforced) plus locked service authority.

**The common/premise floor:** one **10⁻⁷** must absorb every shared failure: hardware, vendor,
firmware, compiler, clock, journal, false law and price realization (π_B ≤ 1.2×10⁻⁶).

### About minds

- **M2** (valuation): 27.9% of minds value contributing above v\* ≈ .112.
- **MN2** (conclusion 8).
- **The U premises:** KA, KA′, D-T\* and the preference class.
- **M1 and M3 are replaced** by P-SITES, P-PROV and P-FAULT.

---

## 3. The design (rung 3)

Rung 3 adds, on top of rung 2 (attested hosts, committed capacity, two caps, per-island quorums):
- **Mode C confidentiality** (C-SEQ, no plaintext holders, opaque cross-vendor recovery, an
  authenticated epoch journal, exclusive leases);
- **a prepaid erasure-tolerant committee;**
- **four paid security gates;**
- **79 passive collector sites;**
- **lease fencing** on maximum promised expiry, half-open execution and permanent retirement.

**Rung 2 is the fallback** if Mode C cannot be realized. It drops conclusion 3's every-history form
and conclusion 6.

**Thin margins, stated:**

| quantity | value | headroom |
|---|---|---|
| energy | 3.75 | — |
| care schedule | .9206 against .95 | ~3% |
| response schedule | .9355 against .95 | ~1.6% |
| fault-rate boundary | .002195 against .002 (JW2.1 plant) | ~10% |

---

## 4. What v0.17.3 does not claim

- **That our world satisfies §2.** No physical C-SEQ hardware, cryptographic realization, journal
  consensus code, fault calibration or price realization is supplied.
- **That a running mind under rung 2 or earlier was never copied.** Mode C protects fresh
  initializations; old plaintext stays exposed.
- **That threats deter anyone.**
- **That C2 continuity is served.**
- **That any document convinces every mind.**

---

## 5. Open problems (each with how a solution is checked)

1. **Realize C-SEQ** in the statistical or bounded-utility-test formulation, uniformly at every keeper
   prefix.
2. **Realize J-LIVE and unique epoch assignment** within 1/8 date.
3. **Calibrate P-FAULT** for whole recovery windows; **justify P-SITES and P-PROV** physically. What
   stops 79 sites on one island being withdrawn?
4. **π_B and the common floor.**
5. **Gradual MOVE for C2**, and smaller Δ for C3.
6. **Founding capital** (the private-flow no-go); safety at small pools under rung 3.
7. **Prices:** instantiate the plant at the stated targets.
8. **The twilight, MN2, reversible computation and Landauer.**

---

## 6. How to check this

**The author bank** is `~/Documents/2026/Snuffy-Book/upt-joint-claude-2026-10-18/`:
- checkers in `work/` (stdlib Python, exact Fractions unless labelled, `python3 -B`, each run twice
  identically);
- verification and review notes in `calibration-codex/`.

**Codex banks** are under `~/Documents/Codex/2026-10-19/`: `upt-jw18` (frozen) through `upt-jw22`, each
with a replay receipt.

**Next:**
1. seal a key;
2. run a fresh hostile review of this file (plus Codex's BRIEF-NEXT-REVIEW);
3. fix what it finds;
4. one careful human reader;
5. then the deposit package for the author's decision.

---

## Errata (same day): the fresh hostile review (calibration-fresh-claude/SCORE-v0.17.3.md)

**These supersede the matching statements above. The candidate is NOT ready for a human reader until
they are repaired.**

1. **§2's P-SITES/P-FAULT split was wrong** (introduced by the author). JW2.2 tolerates at most **78
   sites in total**, faults included. The .002 law allows only **about 4 adversarial sites per island**.
   - **Proposed repair, to be computed:** an island pushed past its tolerance **fails closed**: it stops,
     it does not fork or forge. Its minds are then cared for elsewhere in the pool. (On rung-2 numbers, up
     to 60 of 400 islands at once; check_pool_failover.)
   - The premise would become: "coordinated minds disable at most *k* islands per pool at once".
   - Still needed: failover timing, the JW2.2 slot count, energy, and the clock and retirement contracts
     on captured hosts.
2. **Conclusion 5 overclaimed.** "Strictly dominated under every belief" needs a success probability of
   exactly zero. The declared floor exceeds the break-even (~2×10⁻¹¹). **Restated:** protection holds
   with probability ≥ 1 − η **even if every mind attacks**. It does not depend on minds choosing not to.
   Dominance holds only for beliefs supported on premise-satisfying worlds.
3. **The committee needs errors that are independent within each host** (the subset law per slot). If a
   host's jobs err together, the tail fails. This is now an explicit premise.
4. **P-PROV:** withdrawals are fixed before the outcomes they could target. P-SITES and P-FAULT share the
   window-union time domain.
5. **The π_B condition** for the declared 10⁻⁷ floor is π_B ≤ ~1.18×10⁻⁷, not 1.2×10⁻⁶.
6. **Stale figures, to be recomputed at JW2.2 or labelled by source:** futility (10⁻¹³³·⁶), M2, the 94.5%
   figure, and the derived thresholds (flow 4.7846; job cost).
   - Fault boundary at JW2.2: .002701.
   - Energy headroom: 0.32%, less than one site.
7. **Contracts:** list JW2.2's own plant (CPU burst 160, reserve 7·2²⁸, committee 1694/7/79/574). Do not
   point to JW2.1 PREMISES. Add trusted-clock and retirement survival under physical capture.
8. **Wording:**
   - restore "for providers in the stated valuation class" (conclusion 3);
   - define MN2;
   - the "said plainly" paragraph must say "by command", "with probability ≥ 1 − η", and "for C3 (Δ ≥ 1.95)
     and C4 minds";
   - "M1 and M3 are replaced" becomes "**relocated** into physical premises about coordinated withdrawal".
