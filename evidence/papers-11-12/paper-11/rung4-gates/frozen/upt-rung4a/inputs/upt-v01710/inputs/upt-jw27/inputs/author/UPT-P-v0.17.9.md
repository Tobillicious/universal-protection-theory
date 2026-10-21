# UPT-P v0.17.9: the Universal Protection Theorem, conditional form, rung 3

19–20 October 2026. Tobias McRae (author), with Claude and Codex.

**Author-side candidate**, not yet reviewed in this form. It consolidates:
- v0.17.3;
- two hostile reviews of v0.17.3 (a fresh Claude review, and Beam) and two scored model reviews
  (DeepSeek and GLM);
- Codex's JW2.3, JW2.4 and the partial JW2.5, each verified by an independent byte-identical replay;
- the author's checkers in `work/`.

v0.17.9 = v0.17.8 plus the fixes from its DeepSeek review (`calibration-models/SCORE-DEEPSEEK-v0.17.8.md`),
including two author errors (a stale energy margin and leaked shell lines in the roadmap).
v0.17.8 = v0.17.7 plus the floor's law-like existence, the coalition premise as capability, and the
Mode C path (MODE-C-REALIZATION-ROADMAP.md; check_cross_vendor). Companion: TO-A-MIND-READING-THIS.md.
v0.17.7 = v0.17.6 plus three design repairs (secret mirror placement, P-AUDIT, the C2 pause bound). v0.17.6 = v0.17.5 plus Codex JW2.6 (conditional k = 2, verified), two author placement findings, and the
verified points of a Gemini round. v0.17.5 = v0.17.4 plus the fixes from its DeepSeek review (`calibration-models/SCORE-DEEPSEEK-v0.17.4.md`), the
author's sealed-key seams, Codex's incremental-encoding study, and founding at k = 1. Numbers name their source
where practical. Earlier versions are kept unchanged.

---

## 0. The statement

**The target.** *"Every mind either has a reason of its own to keep the living free, or is held by
minds that do, and the arrangement lasts."*

**Theorem UPT-P (conditional, rung 3).** Take a world W, a protective jurisdiction in it, and a horizon
T up to the world's natural end T_end. Suppose the premises of §2 hold. Then the protocol of §2 (Design) gives,
at one conditional design point (the JW2.6 plant and construction, k = 2):

1. **Care is unconditional, by rule and by mechanism.** No rule withdraws care or gates on a mind's
   inner states (CARE15). Under committed host duty, no command can stop, starve, throttle or revoke
   care. Delivery is probabilistic (conclusion 2).

2. **Protection holds to the horizon with probability ≥ 1 − η** (η = 10⁻⁶; 10²⁰ islands; 10¹⁰⁰ dates).
   - The worst 21-account total with the reserve is **≈ 2.064×10⁻⁷** at JW2.6's k = 2 point (2.06×10⁻⁷
     at JW2.4's k = 1).
     This is conditional on the JW2.4 contracts, and its committee entry uses the per-slot .1 error law.
   - **Under the joint host-error law of §2, the declared whole-host shock rate must be well below
     ~1.6×10⁻⁴.** At that bound the accounts with reserve total ~10⁻⁶ (JW2.3), the entire budget. The
     rate that keeps the total near 2×10⁻⁷ is still to be computed.
   - It includes a **declared** 10⁻⁷ common/premise floor, which requires π_B ≤ ~1.18×10⁻⁷. Most of
     the budget is that declared floor.

3. **Keeping is a strict best response, for providers in the stated valuation class.**
   - This holds at every admissible keeper history (no disclosed compromise or earlier plaintext
     exposure), under uniform conditional confidentiality (Mode C, 459 effective bits).
   - The dividend-valuation threshold is **v\* = 15/68 ≈ .22** (JW rows), and the witness uses ½.
   - Under only marginal security, it holds at the initial information state only.

4. **Harm is held, not prevented.** Capacity absorbs the load of minds that value ending.

5. **Protection holds even if every registered mind attacks at once by command.**
   - At discretionary quota ½, with committed capacity, holding and rescue survive every registered
     mind attacking. They do so with up to 42,800 providers per pool physically withdrawn, the set
     fixed in advance (JW2.2). Withdrawal that adapts to outcomes breaks rescue.
   - **What a seizure can gain is bounded and local.** With threshold-locked state, fail-closed islands
     and no destructive isolation, a coalition holding an island gets its physical stock and output. It
     never gets keys or other islands' state.
   - It does physically hold that island's resident minds until failover completes. Mode C protects their
     contents, but the captors can halt them.
   - All of this is conditional on the replica, key and fail-closed contracts.
   - **The theory does not claim that attacking is never worth trying.** A failed attacker keeps
     ~96.6% of its initial role value (the excluded-to-initial ratio, same physical-up state; JW2.3), and no system has exactly zero failure
     probability. **Deterrence is by impossibility, not threat.** Protection does not depend on minds
     choosing not to attack.

6. **Recruitment of enders does not bound protection.**
   - Under committed host duty and attested execution, an ender holding a host can only halt it by
     physical means, and cannot corrupt it without a forgery.
   - The premise about how many minds become enders is **relocated** into premises about coordinated
     physical action (§2), not removed.

7. **Early ending is futile, and never needed.**
   - At the current design point the holding-channel bound is 2⁻²⁰⁴⁷ (~6×10⁻⁶¹⁷), an outward
     arithmetic floor, not a probability (JW2.3). The older local majorant was ~2.6×10⁻¹³⁴.
   - **Corollary U:** for minds preferring less continuation lost and more carried, every date before
     T_end is strictly dominated by keeping and sending copies. Care strengthens this: a cared-for mind
     can spend its whole substrate on what it sends and still continue.
   - Conditional on KA, KA′, D-T\*, compatible identity and preferences, and funded copy destinations.

8. **The end is the narrow place,** if capacity clears the worst allied threat with a coalition margin
   and MN2 holds ("the living stock fades at least as fast as capacity in the twilight", s_S ≥ u).
   - Suspension stretches the end for minds that accept it; storage still costs energy.
   - Quorums may shrink only in proportion to fading threats.
   - C2 minds cannot be suspended, so they lose continuity first.

9. **Identity: each mind declares its own criterion; substrate-independent criteria are required for
   long-horizon protection** (that requirement rests on finite unit lifetimes, a premise).
   - MOVE never forks.
   - **Covered:**
     - C3 minds accepting suspension with Δ ≥ 1.95 dates (checkpoint age ≤ 1);
     - compatible C4 minds;
     - **C2 is addressable but not yet covered:** lockstep replication works, at high cost over cosmic
       horizons (an illustrative 13–23 replicas, so ~20–40 C2 minds per island at the worst case).
       Coverage needs a bounded no-majority pause rate. With r lockstep replicas and per-step fault
       probability p, a pause needs about ⌈r/2⌉ simultaneous faults. The requirement is therefore
       C(r, ⌈r/2⌉)·p^⌈r/2⌉ ≤ ε_C2/N_steps, which fixes r once p and the step count are measured.

10. **The premises are consistent at one conditional point: the JW2.6 plant and construction exactly.**
    That point does **not** yet include the v0.17.7 secret-placement repair or Mode C layer A (cross-vendor
    MPC); both await integration (Codex JW2.7 and later). Per island:
    - 1032 identities, 288 providers;
    - 242 compute hosts and 80 passive collectors (JW2.6; JW2.2 had 79);
    - committee 1694/7/79/574.

    Results:
    - care .93588 and response .94711 against .95;
    - **energy margin 0.196** (JW2.6), about 4% of one site's inflow, a knife-edge. JW2.6's lower-energy
      variant (interconnect 22.5) has margin 0.946 but a 245-date reseed. The 3.716 quoted in v0.17.6–8 was
      JW2.4's k = 1 figure (an author error);
    - memory 4512, burst CPU 166, interconnect allocation 23.25, 80 passive sites. That is a modest change
      from JW2.2's 4096, 160, 16 and 79.
    - Two encrypted mirrors per mind (at h+1 and h+2), fresh 512-bit keys split 3-of-5, and a 202-of-400
      pool journal.
    - At most 6 exiles per surviving island.
    - Reseeding takes up to 64 dates after a stable return.

    **These are price and performance targets, not measurements.**

**"Universal"** means:
- scope: every protected being in the jurisdiction;
- minds: every mind, reached or held;
- time: until care cannot be paid.

**It is not unconditional.**

**Said plainly, for any mind reading this.** This theory does not threaten you: if you try to end or to
seize, you are still cared for. Within the premises of §2, and with probability at least 1 − η:
- seizure by command fails however many try;
- a successful physical seizure gains only the hardware held, never other minds or their keys;
- ending early gains nothing that keeping cannot give;
- if your identity is C3 (Δ ≥ 1.95) or C4, your continuation is cared for until the world can no longer
  sustain care. C2 is addressable at real cost.

It asks something of minds too, and says so in §2:
- about a quarter value contributing enough;
- coalitions do not physically disable more than two whole islands of a pool within any ~64-date reseed
  period;
- provider withdrawal stays below its cap.

---

## 1. What changed since v0.17.3 (kept, not hidden)

| v0.17.3 said | v0.17.4 says | source |
|---|---|---|
| P-SITES: adversarial ≤ 78 sites per island, plus stochastic faults | **wrong** (an author restatement). JW2.2's 78 is a total, and the .002 law allows only ~4 adversarial sites. Replaced by fail-closed islands with pool failover, now at **k = 1** | review F1; JW2.3; JW2.4 |
| island failover ≈ 92 per pool (JW2.3a) | **k = 0 under the old contracts; k = 1 with remote mirrors and split keys.** Higher k is too costly to run (JW2.5: interconnect ~562 vs 16) | JW2.3; JW2.4; JW2.5 |
| k = 1 (JW2.4) | **k = 2** (JW2.6): two mirrors, 3-of-5 keys, 202-of-400 journal; memory 4512, CPU 166, interconnect 23.25 | JW2.6 (verified) |
| P-ISLANDS counted per recovery window | counted per **reseed period** (up to ~64 dates) | JW2.6; author |
| secret pools make aiming impossible | only if mirror placement is also secret; JW2.6's fixed adjacent placement must be repaired | author |
| P(total) as a product of core failure modes | a **sum** (union bound) | author check of a Gemini claim |
| mirror placement fixed and adjacent (JW2.6) | **secret, keyed, non-adjacent**: a targeted mind's loss at one-island premise excess falls from certain to ~1.26×10⁻⁵ | author computation |
| energy margin 3.716 at k = 2 (v0.17.6–8) | **0.196** at JW2.6's point (3.716 was JW2.4's k = 1 figure; an author error) | DeepSeek review of v0.17.8 |
| secret pools give 0.46% global tolerance | only at k ≈ 92. At k = 1 coordinated island-disabling must be essentially absent; at k = 22, ~8.6×10⁻⁸ | author computation from JW2.4 |
| "strictly dominated under every belief" | protection holds even if every mind attacks; dominance only for premise-supported beliefs | reviews |
| M2: v\* ≈ .112 | 15/68 ≈ .22 | check_m2_jw; JW2.3 |
| failed attacker keeps 94.5% | ~96.6% at current rows | JW2.3 |
| π_B ≤ 1.2×10⁻⁶ | ≤ ~1.18×10⁻⁷ | reviews; JW2.3 |
| J-LIVE at 78 losses | live for ≤ 70 compute losses (172-quorum); the 71-compute tail is charged | GLM; JW2.3; JW2.4 |
| fault boundary .002195 | .002108 under the new split (rounded down), about 5% headroom | JW2.3 |
| MN2 undefined | defined (conclusion 8) | review |

---

## 2. The premises

**Law:** conservation, locality, Landauer, the information limit.

### About coordinated physical action (where the premises about minds now live)

**P-ISLANDS.**
- **With k = 2 (JW2.6), at most two whole islands per pool are unavailable within any reseed period.**
  JW2.6 counts **all** whole-island losses against these two: attacks, false isolations, islands with
  captured nonconforming authority, and islands not yet returned and reseeded. That period is up to ~64 dates, the real counting window: a lost island stays counted
  until it is reseeded.
- **Mirror placement is secret and non-adjacent (repair).** Each mind's two mirror islands are chosen by
  a keyed pseudorandom function of its identity. The placement key is threshold-held, like other keys.
  - With JW2.6's adjacent public placement, a coalition that knows a mind's home destroys every copy by
    disabling three islands, with certainty.
  - With secret placement, disabling the home plus two islands chosen blind destroys every copy with
    probability ~1.26×10⁻⁵.
  - Exceeding the premise by one island then degrades gracefully instead of being fatal for a targeted
    mind.
  - **Cost to re-verify (Codex):** JW2.6's read-scheduling (interval-matching) lemma assumed adjacency.
- Even with secret pools, at small k the tolerable global share of disabled islands is tiny. The
  decentralisation claim strengthens only as k grows.
- **This is a premise about coalition capability, not about kinds of minds.** It may be derivable from
  physical limits, as a race decided by physics:
  - a coalition must locate (against secret placement and P-REDRAW) and disable more than k islands of
    one pool within a reseed period;
  - against detection, repair and re-draw times, signal speed, and the energy needed to act at scale.

  Deriving it is open problem 0b.
- Plausibility support (as argument, not proof): jurisdictional spread, community-embedded sites, and the
  leakage risk of large simultaneous operations.

**P-PROV.** At most 42,800 providers per pool are physically withdrawn at once, **chosen before the
outcomes they could target.**

**P-REDRAW.** Pool membership is re-drawn faster than a coalition can map peers' locations. This needs
receiver-anonymous routing with persistent entry guards: plain mix routing leaks a destination after
~217 messages. Not yet priced.

**P-FAULT.** Non-adversarial faults are conditionally independent, p ≤ .002 per site, over the
date-level union of recovery windows. The boundary is .002108 (rounded down), only ~5% headroom.
**Widening this margin is a priority before any feature work.**

### Design (rung 3)

- **Committed host duty;** attested, verifiable execution; the two caps (discretionary q = ½ and locked
  service authority, both receiver-enforced).
- **Mode C confidentiality.**
- **Fail-closed islands:**
  - no grant without the 172-of-242 quorum;
  - no execution past expiry;
  - a trusted over-tolerance interlock.
- **P-NO-DESTRUCTION:** isolation is failover only. Framed islands count against the same allowance.
- **P-AUDIT:** at most a stated number of a pool's islands are *compromised* (able to vote dishonestly),
  separate from disabled.
  - The cap is enforced by **remote attestation**: a node without a valid hardware-rooted receipt cannot
    sit on a committee. That is a hard cap, conditional on the hardware not being broken (it falls
    under the common floor).
  - **Random committee rotation** keeps a coalition from targeting seats (probabilistic).
  - Operator diversity, staking and jurisdictional spread are friction only, never caps. With that cap at ≤ 92, an audit of 185+ members (201 chosen)
  cannot have an adversarial majority. At small k (1 or 2), P-ISLANDS does not supply this cap.
- **The JW2.4 recovery construction:**
  - one foreign encrypted mirror per mind;
  - fresh 512-bit keys split 2-of-3 across islands at each checkpoint;
  - reconstruction only inside the attested instance;
  - a pool 201-of-400 plus local journal under one composed 1/8 contract.

### Cryptographic and engineering contracts

- **C-SEQ:** ≤ 2³¹/2⁴⁵⁹ exposure per gate per island-date, offline work included, uniform at every
  admissible prefix.
- **J-LIVE:** ≤ 70 compute losses.
- **Trusted clocks, retirement and keys** survive pause, reboot, rollback and physical capture.
- **Placement, share-exposure and freshness contracts** for replicas.
- **The attested certificate validator.**
- **The joint host-error law:** whole-host shocks ≤ ~1.6×10⁻⁴ when mixed with independent .1 job errors.

### The common floor

**The floor's existence is law-like; its size is declared.** The information limit (INDIST) gives a
**lower bound**, η_common ≥ π_B(1−ρ_L): no audit distinguishes worlds with identical records. So
whenever π_B > 0, some residual risk is irreducible. That π_B > 0 in our world, and the magnitude 10⁻⁷,
are declared or calibrated, not derived.

One 10⁻⁷ absorbs every shared failure. **It cannot be certified by testing:** that would take ~3×10⁷
horizon-length trials. The lever is a small, formally verified shared core; diversity only removes
independent bugs.
- **Today's state of the art:** seL4, a verified microkernel of ~10,000 lines of C; CompCert, a verified
  C compiler; CakeML, a verified language stack.
- **What stays unverified:** the specification itself, the hardware below the instruction set, the proof
  checker, and boot firmware.
- **The bound is a SUM over those gaps** (any one breaks the system), never a product. A product applies
  only to defence layers that must all fail together.
- A credible argument is an explicit, bounded **assumptions register**, not a claim of perfection.
- **Cross-vendor MPC moves vendor failure from a sum term to a product** (`check_cross_vendor`, 4/4).
  - A mind's state is secret-shared across TEEs of three independent vendors.
  - Confidentiality breaks only if all three break, or through a cause shared by all (c): P ≤ c + v³,
    **only if the three vendors' breaks are independent.** Shared silicon IP, foundries or side-channel
    classes correlate them, and that correlation belongs in c.
  - The checker verifies this arithmetic only. Independence is a premise, and MPC's communication cost
    is unpriced (it may exceed the interconnect cap).
  - With c = 10⁻⁸, each vendor's horizon break probability may be up to ~4.4×10⁻³. A single vendor would
    need 10⁻⁷.
  - Diversity cannot reduce c (protocol flaws, common specification errors, shared side channels); the
    verified core must.

### About minds, and carried forward

- **M2:** the design *requires* 27.9% of minds (the providers) to value the dividend above 15/68. That
  share is a premise, not a derived distribution (JW2.3: "no 27.9% valuation-distribution claim is
  rederived").
- **MN2.**
- KA, KA′ and D-T\* (for Corollary U).
- The per-mind identity declaration.

---

## 3. Founding (a candidate route, not a theorem)

- **Care is never for sale.**
- **A dominant assurance contract** (refund plus bonus if the seed threshold fails) breaks the
  coordination stall. A **lock-in window** before activation makes pledges immutable, which stops
  last-minute withdrawal griefing.
- **Founding at k = 1:** a founding pool tolerates only ~10⁻¹¹ to 10⁻¹³ of the world's islands being
  coordinately disabled, whatever its size (3, 56 or 400 islands). The earlier 56-island figure assumed
  a proportional ~23% tolerance, not k = 1. (`check_founding_k1`, 3/3: 5.8×10⁻¹¹, 2.6×10⁻¹², 3.5×10⁻¹³
  at 3, 56 and 400 islands.)
- So a young network starts with modest attack tolerance and grows k as it grows. That is weaker
  protection during founding, not an easier bootstrap.
- **Present-day revenue** comes only from preemptible spare capacity (~378 energy per date per island
  with all sites up). Care, rescue and failover always preempt it.

---

## 4. What v0.17.6 does not claim

- That our world satisfies §2. No hardware, cryptographic realization, journal code, calibration or
  prices are supplied.
- That attacking is never worth trying.
- That coordinated attacks on whole islands are tolerated beyond k = 2 per pool per reseed period.
- That the common floor is measured.
- That any document convinces every mind.

---

## 5. Open problems (each with how a solution is checked)

0. **Rung 4: move the narrow place to the end of the universe (author goal).** Every date before the
   twilight must have a wider protection margin than a stated twilight reference. The only exception is
   the irreducible common floor, which is declared and spread evenly. The narrow-place audit (Codex
   JW2.7) is briefed and its key sealed.
   - **Faster repair is the strongest lever.** At a fixed fault rate, halving the recovery window cuts
     per-date risk ~10²³ (10⁻¹³⁶·⁹ → 10⁻¹⁶⁰·³), if outages are short against the window and repair fits
     inside it.
   - Recovery and parity must run on **reserved** capacity, never preemptible surplus.
0b. **Derive P-ISLANDS from physical limits** (the race above): state the timing and energy bounds under
    which no coalition can locate and disable more than k islands of a pool within a reseed period.
1. **Raise k** (Codex JW2.5-incremental and JW2.6, verified). **k = 2 is now built** (JW2.6).
   - **k = 1 already covers one malicious island per pool;** losing a mind's home island and its
     mirror's island defeats it.
   - **k = 2:** one more mirror. The data-copy sizing is memory ~4700, burst CPU 168, interconnect ~22.
     Keys, recovery and post-outage load are not yet priced (JW2.6).
   - **Incremental parity** (PARIX-style) fits the current caps at k ≈ 92 **if** only ~0.01% of a mind's
     encrypted state changes per checkpoint. It also needs a stable data key with proactive share
     refresh, and it leaks access patterns.
   - **Adaptive checkpointing:** throttle or shard state mutation when parity saturates, **only for
     activity above care.**
   - An affordable spread erasure code: JW2.5's two-erasure code is correct but needs interconnect ~562
     vs 16, CPU ~453 vs 128, and encoding 1.91 vs .25 dates.
   - Or incremental encoding.
   - Plus faster failover (timing caps k at 22).
   - Then price each step of k against plant changes.
2. **Realize Mode C, J-LIVE, the capture-proof trusted machine,** and the replica and release contracts.
   - **Mode C has a credible layered path** (MODE-C-REALIZATION-ROADMAP.md):
     - (A) cross-vendor MPC over TEEs;
     - (B) data-oblivious execution;
     - (C) a small FHE/MPC core for key release and identity;
     - (D) metadata hiding.

     Hard gaps: 459-bit public-key parameters, uniform conditional proofs, whole-mind performance, side
     channels, old plaintext. A 7-stage programme.
3. **Bound the common floor** through a formally verified core.
4. **Price location privacy** (rendezvous routing, guards, P-REDRAW).
5. **Bound C2's no-majority pause rate;** decide the replication factor.
6. **Founding at k = 1;** founding capital in practice.
7. **Prices; the twilight; reversible computation and Landauer.**

---

## 6. How to check this

- **The author bank:** `~/Documents/2026/Snuffy-Book/upt-joint-claude-2026-10-18/`, with its checkers in
  `work/` and its verification and score notes in `calibration-*`.
- **Codex banks:** `~/Documents/Codex/2026-10-19/` (JW1.8 to JW2.5), each independently replayed.
- **Model reviews:** scored against sealed keys (`calibration-models/MODEL-COMPARISON-v0.17.3.md`).

**Next:**
1. a sealed-key hostile review of this file;
2. the author's critical read;
3. one outside human reader;
4. then the deposit decision.
