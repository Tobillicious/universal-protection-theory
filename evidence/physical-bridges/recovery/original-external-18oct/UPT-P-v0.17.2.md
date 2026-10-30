# UPT-P v0.17.2: the Universal Protection Theorem, conditional form

19 October 2026. Tobias McRae (author), with Claude and Codex. **Author-side candidate**, not
independently reviewed by a human. v0.17 and v0.17.1 are kept unchanged beside this file.

**What v0.17.2 adds:**
- the fresh hostile review of v0.17.1 (16 findings, all accepted; `calibration-fresh-claude/SCORE-v0.17.1.md`);
- DOOM-UNDER-CARE15 and CARRYFORWARD-UNDER-CARE15;
- PREMISES-DERIVED;
- COORDINATION-SEAM;
- SEIZURE-AND-DISCLOSURE;
- a new integrity threshold (`work/check_integrity.py`).

Values marked **[JW1.8]** come from author modules. Codex is recomputing them now in the integrated
model (BRIEF-CODEX-JW1.8-INTEGRATE.md), and a fresh review of SEIZURE-AND-DISCLOSURE is running
against a sealed key. **Until both return, every [JW1.8] value is a hypothesis.**

---

## 0. The statement

**The target.** *"Every mind either has a reason of its own to keep the living free, or is held by
minds that do, and the arrangement lasts."*

**Theorem UPT-P (conditional form).** Take a world W, a protective jurisdiction in it, and a horizon
T up to the world's natural end T_end. Suppose the premises of §2 hold. Then there is a protocol, the
joint construction of §3, under which:

1. **Care is unconditional by rule.** No protocol rule withdraws care, punishes by starvation, or
   inspects or gates on a mind's inner states. Exclusion removes only privileges (CARE15).
   - Every protected mind, whatever its label, conduct or contribution, is *owed* essential care and
     the conditions of its own continuation and direction.
   - That this is *delivered* is a probabilistic guarantee (conclusion 2). It is not certain at every
     date.
   - Under Mode I a corrupt host can read the plaintext it hosts; that is charged as a leak. Altering
     a live mind's state needs a forgery of verifiable execution, which is a §2 premise.
2. **Protection holds to the horizon, with probability ≥ 1 − η.** Protection failures (care,
   holding, rescue, physical, integrity, or certificate-premise) anywhere before T have total
   probability at most η.
   - In the witness, η = 10⁻⁶ over m = 10²⁰ islands and T = 10¹⁰⁰ dates.
   - Margins grow only logarithmically in T·m/η (Margin Law, CH).
   - **Most of η is declared, not derived.** 10⁻⁷ is the declared allowance for common-mode and
     premise error, and the derived accounts are about 10⁻⁷. If π_B > 1.2×10⁻⁶, this conclusion fails.
3. **Keeping is a strict best response** for providers in the stated valuation class, at every
   history in the incentive domain.
   - This holds without surveillance of minds, with privacy leaks charged (MONO-IC, Mode I).
   - **With the command quota q = 1 per date [JW1.8], the all-history disclosure debit is bounded
     with no extra continuation argument.** It is .001031, against a clean P/D advantage of
     .00127–.00137.
   - **This is conditional on the corruption envelope** (open problem 1). It is also thin: 18.6% of
     the margin remains, and the break-even quota is 1.47.
   - "Against arbitrary behaviour" is restricted. The domain's complement is reached with negligible
     probability *under the episode law*. Coordinated others can leave the domain at will, which
     conclusions 5 and 6 handle.
4. **Harm is held, not prevented.** Minds that value ending, or whose gains exceed the deterrence
   threshold, are held: capacity absorbs their load. Extraction is deterred inside the domain for
   seizable gains capped by conservation and the declared reach.
5. **Coordinated seizure needs keepers, and the number is stated.** A seizure is *infeasible
   however many others act* if enough minds that put protection first never join it. At q = 1, per
   island, this means [JW1.8]:
   - **208 of 288 providers** if no one else is a keeper;
   - **135 providers** if half the non-providers are keepers;
   - **61 providers** if every non-provider is a keeper.

   No equilibrium-selection assumption is used on this branch. Incentives alone do not suffice: an
   insatiable mind that keeps what it seizes finds attack risk-dominant even at f* = .80. **This is
   premise M3, and it is a demanding one: 72% of providers.**
6. **Enders are held at scale, at a stated rate.**
   - Recruitment is bounded by **per-island occupancy**, because harmful episodes occupy corrupt
     hosts. That gives **s ≤ .00996 per active ender per date** [JW1.8], so at most about 1.0% pure
     enders at one contact per date.
   - Locally, the binding coalition is 25 corrupt hosts (R_bind = 25), not 40.
   - A single island tolerates a coordinated dormant burst of **15** (author module, every
     threshold) or **11–12** (integrated, r = .87–.90). Larger bursts need pooled holding and
     rescue (JW1.7), recomputed at q = 1 [JW1.8].
   - Locally, only broadcast-persuasion rates around 10⁻⁴⁰ are certifiable: negligible, not zero.
   - **The share of the living engaged in harmful episodes** is constant in JW's static world, about
     5.8×10⁻⁸. It falls like 1/t only if the cared-for population grows while onsets stay absolute.
7. **Early ending is futile, not doom.** At the base state an attempt succeeds with probability
   about 10⁻¹³³·⁶, with expected gain about 10⁻¹²⁵ against a role value of .17. The attempter is cared
   for throughout; nothing it has is threatened.
   - At the domain edge the bound fails: at e = 41, success is about .145. Those histories are
     reached with probability charged to η.
   - "Dissipation" applies only to total success, when no keeper is left in reach.
   - The old (c), withdrawing a world's insurance, is withdrawn: it is a survival gap.
8. **The end is the narrow place, given MN2.** If capacity clears the worst allied threat with a
   coalition margin, and premise MN2 (s_S ≥ u) holds, the holding ratio stays above 1 until the
   twilight. T_end, where care cannot be paid, is then the only remaining bottleneck.
   - **Corollary U** (only T_end is undominated) holds for minds that prefer less continuation lost.
     It needs KA′ and D-T\*.
   - Its old proof used PK, which CARE15 withdraws. Whether U survives without PK is open (problem 8).
9. **The premises are jointly satisfiable for the per-island accounts.** The witness meets them, with
   CERT15 ≤ 1.117×10⁻⁷ at JW1.7's conditional worst point.
   - Pooled holding and rescue are built (JW1.7).
   - The q = 1 quota, the keeper line and occupancy are being integrated [JW1.8].

**"Universal"** means:
- scope: every protected being in the jurisdiction;
- minds: every mind, reached or held;
- time: until the world can no longer sustain care.

**It is not unconditional.** Unconditional preservation is impossible (PB0, Θ0).

---

## 1. Corrections since v0.17.1 (kept, not hidden)

| v0.17.1 said | v0.17.2 says | source |
|---|---|---|
| recruitment s ≤ .026 pooled | **s ≤ .00996**, set by per-island occupancy; π_lex ≲ 1.0% | review F1; check_occupancy_m1 |
| "no stockpiling: intensity ≤ λ at every history" | **withdrawn** (it contradicted recruitment and bursts). Replaced by: *capability* cannot be stockpiled (F7 quota per date); *intentions* are bounded through π_lex, BURST and occupancy | review F2 |
| local binding coalition 40 | **25** (quorum and edition fail at 25 corrupt hosts) | review F3 |
| DOOM: "doom for whoever tries", "dissipates and stands alone" | **futility**, at the base state only; (b) only on total success; (c) withdrawn | review F4; DOOM-UNDER-CARE15 |
| Corollary U unqualified | limited to its preference class; KA′ and D-T\* listed; PK withdrawn | review F5 |
| enders' share falls like (ln T)/T | constant ≈ 5.8×10⁻⁸ in the static witness | review F6; CARRYFORWARD |
| only conclusion 3 depends on the disclosure bound | conclusions 2, 3, 4 and 9 all do; the bound now closes at q = 1 [JW1.8], conditional on the envelope | review F7; check_quota_disclosure |
| CERT15 "at the actual worst admissible point" 1.885e-7 | that figure was earlier accounts only. JW1.7's conditional maximum is 1.117e-7 | review F8 |
| (no integrity premise) | verifiable execution at ≥ 436-bit forgery resistance | review F8; check_integrity |
| common-mode error classed as law | **declared** (D/P). INDIST gives only a lower bound | review F9 |
| burst tolerance 19 | 15 (every threshold), 11–12 integrated | review F12 |
| "no positive broadcast rate certifiable" | rates around 10⁻⁴⁰ are certifiable: negligible, not zero | review F13 |
| "five independent review rounds" | several rounds were by co-authoring models (Codex wrote R13–R18 and the JW repairs) | self-found |
| margin .00344 (QUOTA-UNIFIES) | .00127–.00137 integrated; break-even quota 1.47 | review F12; correction appended |

---

## 2. The premises

**Classes:**
- **L:** physical law.
- **D:** derived, now a theorem with a checker.
- **M:** measured; its error goes into η_cert.
- **P:** about minds; it stays a premise, stated with its number.
- **Dec:** declared, a choice or calibrated input.

### Law

| premise | class | value |
|---|---|---|
| conservation; locality; Landauer; the information limit | L | — |

### Measured and declared inputs, each with its derived threshold

| premise | class | value used | threshold the theorem needs |
|---|---|---|---|
| continuation margin of the protected state | Dec | 25σ Gaussian | a calibrated distribution, not a law |
| guaranteed net flow per flow host | M | 4.8, fixed | every account is stated at 4.8 |
| energy per compute e_c | M | 1/127 | 10–413 extra hosts for e_c from 1/127 to 1/2 |
| verification job cost | M | — | ≤ 7.25×10⁻⁴ per job |
| care-host failure fraction | M | — | ≤ 10⁻³ |
| attack-conversion ratio χ | M | — | ≤ 3.5425 |
| fault law, persistence | M | onset 1/30, recovery 1/2 | — |
| episode lifetime | D + M | 28 dates, then halving; mean 30 | — |
| corruption per edition | D | 64×10⁻⁶ = M + 2M/30 | from the declared occupancy cap 6×10⁻⁵ |
| pooled interconnect | M | — | rescue within 0.811 of a date (JW1.7) |
| unsustained arrivals | M + P | Poisson(10), or P-POOL | — |
| cross-island common causes | M | measured | locality forbids direct influence only |

### Design choices

| premise | class | value used | threshold the theorem needs |
|---|---|---|---|
| command quota | Dec | **q = 1 per date** [JW1.8] | ≤ 1.47 for disclosure. Legitimate command needs (rescue, the committee, admissions) must fit under q: **not yet audited** [JW1.8] |
| receiver-enforced quotas; copies not admitted across pools | Dec | new | needed by the exit route (open problem 5) |

### Cryptography and integrity

| premise | class | value used | threshold the theorem needs |
|---|---|---|---|
| action privacy (Mode I) | P (crypto) | 2⁻¹⁰⁰ per keeper-date, ≤ 3 plaintext holders, assignment secrecy | no encryption security proof; leaks charged as incentive debits |
| **live-state integrity** | P (crypto) | verifiable execution | **≥ 436-bit forgery resistance** per keeper-date. Majority voting would need 43 holders, and that many plaintext holders breaks the privacy margin |

### Facts about minds

| premise | class | value used | threshold the theorem needs |
|---|---|---|---|
| **M1: pure enders** | P | — | π_lex ≲ 1.0% at one contact per date (occupancy) [JW1.8] |
| **M2: what minds value** | P | — | 27.9% of minds value the dividend above v\* ≈ .112; outside options below ≈ .0083 per date |
| **M3: keepers hold capacity** | P | — | the keeper line of conclusion 5 [JW1.8] |
| MN2 | P | s_S ≥ u | needed by conclusion 8 |

### Carried-forward and floor premises

| premise | class | value used | threshold the theorem needs |
|---|---|---|---|
| KA′, D-T\* | D/P | — | needed by Corollary U |
| P1, P2, P2′ | L + M | physics allows care to T_end, margins fit | — |
| corrupt hosts per good edition | Dec | ≤ 24 | — |
| the rest of JW1.6/1.7 PREMISES: published-d exogeneity, endowed plant, MPC cap 3648, 2²⁸ authentication cap, host plant capacities | Dec | listed there | — |
| jurisdiction; protected being (uncertain sentience) | Dec | R13.1 | a choice |
| identity (private continuation = S_m, ALIGN15) | Dec | semantic | open problem 6 |
| common-mode error | Dec | η_common + η_premise = 10⁻⁷ | **π_B ≤ 1.2×10⁻⁶** (INDIST lower bound) |

---

## 3. The witness (JW1.7, with JW1.8 in progress)

**Per island:**
- 288 providers (capacity 16, two rescues, wear 3.76);
- 238 flow hosts at 4.8;
- 526 cohort minds, 88 berths, 418 admissions;
- population cap 1032.

**Pools and totals:**
- pools of 400, with pooled holding and rescue (joint deadline 0.811);
- pool founding needs about 2,100 providers;
- CERT15 conditional maximum 1.117×10⁻⁷ at (r = .90, μ = 6.31).

**Thin margins, stated:**
- energy remainder ≈ 0.031 per date;
- quota margin 18.6%;
- the integrated P/D advantage is only .00127–.00137.

---

## 4. What v0.17.2 does not claim

- **That our world satisfies §2.** M1–M3 and the crypto premises need arguments and measurement.
- **Information-theoretic privacy.** Mode C is a fallback.
- **That a seizure cannot copy a running mind under Mode I.** It can. Exit (open problem 5) would
  stop *ending*, not copying.
- **That any document convinces every mind.** That depends on what minds value.
- **Belief-free protection without keepers.** M3 is irreducible: incentives alone cannot stop a
  coordinated insatiable majority.

---

## 5. Open problems (each with how a solution is checked)

1. **The conditional corruption envelope.** Route: named detection plus exclusion, so the keeper's
   posterior is at most the prior. *Check:* JW1.8 task 4, and a hostile reader on silent corruption.
2. **π_B.** Make failure worlds distinguishable. *Check:* new independent modalities, without
   moving the premise.
3. **Legitimate command needs under q = 1.** *Check:* JW1.8 task 1 audit.
4. **Pooled quorums and editions,** to lift per-island occupancy. *Check:* JW1.8 task 3 option.
5. **Exit: a seizure that ends no one.** Care is ~0.2% of capacity, so unseized capacity carries
   every exile unless > 99.8% is seized. 107 replicas give (½)^107 < 10⁻³². *Needs:* identity,
   Mode C for running state, receiver-enforced quotas, and storage cost.
6. **Identity:** when a recovered mind counts as continuation (ALIGN15).
7. **Pool founding** at about 2,100 providers, and private-flow funding.
8. **Corollary U without PK.**
9. **Reversible computation** and the Landauer floor.

---

## 6. How to check this

- **The author bank:** `~/Documents/2026/Snuffy-Book/upt-joint-claude-2026-10-18/` (HANDOFF.md;
  checkers in `work/`, stdlib Python, exact Fractions, `python3 -B`, two identical runs each).
- **Codex's banks:** `~/Documents/Codex/2026-10-19/`.
- **Scoring:** reviewers are scored against keys sealed before they read.

**Next:**
- JW1.8;
- the fresh review of SEIZURE-AND-DISCLOSURE;
- then v0.17.3;
- then one careful human reader.
