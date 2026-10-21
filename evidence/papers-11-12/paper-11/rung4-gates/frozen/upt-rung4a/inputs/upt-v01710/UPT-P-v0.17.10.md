# UPT-P v0.17.10: the Universal Protection Theorem, conditional form, rung 3

20 October 2026. Local Codex integration candidate for Tobias McRae.

**Draft for the author's next session.** This version integrates the safe v0.17.9 source, the completed
JW2.7 bank, and an independent line-by-line audit of GLM's 0b proposal. Earlier versions and banks
are unchanged. This candidate has not been adopted or released by the author.

**Result:** the conditional rung-3 construction remains the result. Rung 4 is not established.
GLM's count-budget arithmetic, share algebra and quorum intersection pass; its full derivation of
P-ISLANDS does not. Expected search time is not an impossibility bound, and a 64-date reseed after
stable return is not a 64-date bound on outstanding losses from onset. The corrected conditional
rolling-budget lemma is in GLM-0B-AUDIT.md; its primitive premises still need evidence.

New numerical claims below are traced in INTEGRATION.md to the frozen JW2.7 results or the independent
0b checker. The other inherited theorem components have not been re-proved in this integration.
All capacities and service times remain price and performance targets, not measurements.

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

2. **Protection holds to the horizon with probability ≥ 1 − η** (η = 10⁻⁶; 10²⁰ islands; 10¹⁰⁰ dates),
   conditional on the full joint contracts.
   - The JW2.6 baseline's worst 21-account total plus reserve is about 2.06401198286124585×10⁻⁷.
     Its baseline committee uses the declared .1 job-error law.
   - JW2.7 computes an exact mixed host/job error-count distribution and uses it in the protocol's
     failure union bound. For a total target 2.1×10⁻⁷, the largest certified q on the 10⁻¹² grid is
     **0.000153588285**; the next point **0.000153588286** fails that target. The safe total is
     2.09999999420699802×10⁻⁷ and the next total is 2.10000000029952336×10⁻⁷ (decimal displays floored).
   - This is a replacement conditional law: independent host shocks make all seven jobs at that host
     wrong; otherwise its jobs have independent .1 errors. The committee entry, its reserve contribution,
     and the legacy one-job-per-host quorum entry are updated. Other accounts stay fixed. This does not
     model physical host halts or shocks to every other host computation.
   - q = .00016 exceeds the 2.1×10⁻⁷ target under this calculation, but remains below 10⁻⁶. It does not
     exhaust the whole 10⁻⁶ budget. The historical moment certificate permits q = .000131525 for the
     tighter target; its next 10⁻⁹ grid point fails. Neither boundary is a physical failure threshold.
   - The total includes a **declared** 10⁻⁷ joint common-failure allowance. Its uniform conditional
     warranty is a premise, including the inherited requirement π_B ≤ about 1.18×10⁻⁷.

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

8. **Making the end the narrow place remains an open goal.** A single feasible mature plant and weak
   MN2 do not establish it.
   - Weak MN2 says that the living stock fades at least as fast as capacity in twilight (s_S ≥ u).
     Equal proportional fades can preserve equal normalized margins, so they do not imply a strict
     advantage at every earlier date.
   - A rung-4 certificate needs a stated twilight reference, numerical phase exposures and threat
     trajectories, and fully funded care, repair and protection throughout founding and growth.
     JW2.7 supplies conditional component screens, not that certificate. Founding is the first gap.
   - Suspension may extend care for compatible identities; storage still consumes energy.
     Any quorum reduction needs a separately justified falling-threat bound. C2 continuity is not covered.

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

10. **One conditional priced design point is the JW2.6 construction**, subject to its joint realization
    contracts. It has 400 islands per pool, 1032 identities and 288 providers per island, 242 compute
    hosts plus 80 passive sites, and committee 1694/7/79/574.
    - Care .935879553894114257 and provider response .947109937213716052 fit .95.
    - Energy margin **.196358528503937**, memory use 4508.28318 of 4512, burst CPU cap 166,
      interconnect activity 23.2428344808873598 under allocation 23.25.
    - Two encrypted mirrors at public adjacent islands h+1 and h+2, fresh 512-bit state keys shared
      3-of-5, a 202-of-400 pool journal, and at most six exiles per surviving island.
    - Reseeding takes up to 64 dates **after stable physical return**. The preceding outage duration
      is not bounded. A lost island counts until it is returned, reseeded and its residents restored.
    - The lower-energy 22.5 interconnect variant has margin .946358528503937 but a 245-date reseed.

    **JW2.7 adds a conditional secret-placement capacity candidate**, not a realized private system:
    - Balanced keyed cycles preserve the twelve-reads-per-live-host recovery bound and six-exile dispatch.
      The strict numeric non-adjacency variant uses two parity-separated cycles of 200 islands.
    - Installed memory use projects to **4510.35106**, with setup upper bound 4510.86706, under 4512.
      Four extra compute units per island-date reserve normal and capped exceptional placement lookups,
      key refresh and cache validation. The extra authorized lookup cap is 60,000 per island-date,
      including partial attempts; admission consumes a token before cache access.
    - Projected energy margin **.164860336670939388**, care .936146922315166889, provider response
      .947377305634768684 and checkpoint lag .246134157533854166 fit the stated caps; reseed remains
      64 dates after stable return. Authentication and wire capacity also pass their conditional screens.
    - One-time setup requires an additional funded 1.24865535482386024 energy units per pool.
      No live migration from an already running adjacent layout has been priced.
    - Threshold seed custody does not hide plaintext route caches. Cache confidentiality, anonymous
      recipients, adaptive query leakage and 459-effective-bit realization remain obligations.
      The finite SHAKE256 fixture checks placement combinatorics, not 459-bit security.
    - Cross-vendor MPC for whole minds is also not integrated or priced.

    **These are conditional targets, not measured implementations.**

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

## 1. Corrections carried into this version

| Earlier statement | Audited replacement |
|---|---|
| k = 2 energy margin 3.716 | .196358528503937 at the adjacent JW2.6 baseline; 3.716 was k = 1 |
| ~64 dates is the entire loss window | 64 dates after stable return; preceding physical outage is unbounded |
| Secret placement is already part of JW2.6 | JW2.6 is public adjacent; JW2.7 supplies a conditional capacity candidate |
| Every non-adjacent layout has blind hit 1/C(399,2) | The strict parity-cycle candidate has 1/C(199,2); the full-400 variant has 1/C(399,2) |
| A longer average search time prevents successful search | It does not; 16 distinct blind probes cover both mirrors with probability 120/79401 |
| Conservation forces attacker cost to match plant draw | No such lower bound follows from conservation alone |
| q ≈ .00016 consumes the entire 10⁻⁶ budget | It fails the 2.1×10⁻⁷ target but stays below 10⁻⁶ in JW2.7's specified replacement law |
| Physical boundary .002108 and halving a window gives a free exponential gain | Baseline full-budget grid bracket .002216911380884/.002216911380885; changing a window needs a temporal law |
| Literal 0.46% coordinated disabled share needs k ≈ 92 | k = 93 for the stated illustrative 10⁻⁸ coalition account; k = 94 to strictly beat that same surrogate reference |
| Weak MN2 proves strict end-only narrowness | Equal normalized-margin trajectories are counterexamples; rung 4 remains open |

The earlier k = 0 → 1 → 2 sequence and corrections to total-site versus adversarial-site counting remain
in the frozen earlier versions and banks. This version does not reinstate discarded claims.

---

## 2. The premises

**Law:** conservation, locality, Landauer, the information limit.

### About coordinated physical action (where the premises about minds now live)

**P-ISLANDS.**
- At k = 2, **at most two whole islands of a pool may be unavailable at once**, counting attacks,
  false isolation, nonconforming captured authority and islands not yet returned and reseeded.
  Power-on and calendar boundaries do not clear the count. A new loss is admissible only if the
  outstanding total stays within two. This is a coalition-capability and all-cause availability premise.
- JW2.6 reseeds in at most 64 dates after a stable return. If physical outage lasts D dates, the
  corresponding unavailability lasts up to D+64, plus any unaccounted detection or clearance delay.
  There is no supplied bound on D. A bound on new attacks in 64-date windows alone is insufficient.
- JW2.6's public adjacent placement tolerates any two island losses. Disabling a known home and both
  known mirrors exceeds that cap and destroys all three images.
- JW2.7's balanced secret placement is a conditional repair candidate. For an ideal one-attempt
  known-home-plus-two-blind-loss experiment, its full-400 option has hit probability 1/79401; its
  strict parity-cycle option has 1/19701. These need uniform hidden placement conditional on the
  attacker's full view. They are neither all-attempt horizon bounds nor established routing privacy.
  Strict numeric non-adjacency is not a claim of geographic separation.
- At the maintained two-loss cap no three-image destruction occurs from those whole-island losses.
  A conditional probability given a third loss cannot be added to the common allowance for free.
- Even secret pools do not turn small k into a substantial coordinated global attack tolerance.
  In JW2.7's illustrative fixed disabled set of fraction .0046, 400-island pools over 2.5×10¹¹⁷
  pool-dates need k = 93 for a 10⁻⁸ coalition-component union account. Membership secrecy and
  non-adaptive choice of the disabled set are additional contracts; no complete high-k plant is priced.
- **Problem 0b remains open.** GLM's proposal correctly computes an attack-count budget upper bound,
  but does not derive this all-cause outstanding-loss premise. The accepted conditional replacement is:
  if losses clear within L from onset, attack onsets in every rolling L interval have charged cost
  A·E_min ≤ B+rL, and other outstanding causes have cap F_other, then
  unavailable ≤ floor((B+rL)/E_min)+F_other. Its cost floor, resource envelope, finite loss lifetime
  and other-cause cap need independent justification. See GLM-0B-AUDIT.md.

**P-PROV.** At most 42,800 providers per pool are physically withdrawn at once, **chosen before the
outcomes they could target.**

**P-REDRAW.** Pool membership and route privacy must resist mapping at the stated exposure budget.
Receiver-anonymous routing, persistent guards, cache protection and a conditional leakage argument
need a fully priced realization. A redraw every four dates and a probe budget of four per date are
illustrative GLM assumptions. Comparing average search time with redraw time does not establish
security; an attempt-count and conditional success bound are required.

**P-FAULT.** At every admissible pre-window history, each specified subset of r sites has joint
fault probability at most p^r, p ≤ .002, over the date-level union of the recovery windows including
completion overlap. This is the subset law used in JW2.6, not a substituted independent binomial tail.
The active full-ledger boundary is driven by 71 compute failures rather than 79 total-site failures.
- For total budget 10⁻⁶, the certified 10⁻¹⁵ grid points are .002216911380884 safe and
  .002216911380885 failing. For 2.1×10⁻⁷, they are .002058635610464 and .002058635610465.
- The supplied date-level law is not a hazard or outage-duration model. Shortening the window does
  not automatically shrink p. Such a gain needs a conditional start-intensity/subset law, a duration
  bound and a valid window cover, with completion overlap paid.
- The local fault-recovery clock and whole-island return/reseed clock are different.

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
  - Remote attestation gates admission on a valid receipt. The numerical compromised-island cap
    additionally requires a conditional integrity warranty and exposure argument. A receipt alone
    does not prove that cap; shared hardware or attestation failure belongs in the joint common bound.
  - **Random committee rotation** keeps a coalition from targeting seats (probabilistic).
  - Operator diversity, staking and jurisdictional spread are friction only, never caps. With that cap at ≤ 92, an audit of 185+ members (201 chosen)
  cannot have an adversarial majority. At small k (1 or 2), P-ISLANDS does not supply this cap.
- **The JW2.6 recovery construction:**
  - two foreign encrypted mirrors per mind;
  - fresh 512-bit keys split 3-of-5 across islands at each checkpoint;
  - reconstruction only inside the authorized attested instance;
  - a pool 202-of-400 plus 172-of-242 local journal under one composed 1/8 contract.
  JW2.7 preserves the read/dispatch capacity in a conditional scattered-placement candidate; its
  secrecy and service realization obligations remain explicit.

### Cryptographic and engineering contracts

- **C-SEQ:** ≤ 2³¹/2⁴⁵⁹ exposure per gate per island-date, offline work included, uniform at every
  admissible prefix.
- **J-LIVE:** ≤ 70 compute losses.
- **Trusted clocks, retirement and keys** survive pause, reboot, rollback and physical capture.
- **Placement, share-exposure and freshness contracts** for replicas.
- **The attested certificate validator.**
- **The replacement mixed host/job law:** as specified in conclusion 2; q ≤ .000153588285 certifies the 2.1×10⁻⁷ target on the stated grid, with its scope limitations.

### The common floor

**The floor's existence is law-like; its size is declared.** The information limit (INDIST) gives a
**lower bound**, η_common ≥ π_B(1−ρ_L): no audit distinguishes worlds with identical records. So
whenever π_B > 0, some residual risk is irreducible. That π_B > 0 in our world, and the magnitude 10⁻⁷,
are declared or calibrated, not derived.

One declared 10⁻⁷ upper bound must cover the union of every shared failure. A new failure mode needs a joint proof or an explicit allocation; it cannot be inserted for free. **It cannot be certified by testing:** that would take ~3×10⁷
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

## 3. Founding and growth (component screens, not a complete construction)

Care is never for sale. Assurance contracts and locked pledges are candidate funding mechanisms,
not a proof of endowed seed capital or pre-activation protection.

JW2.7 checks an illustrative coalition-only growth schedule. With each commissioned stage exposed
for at most 10¹² pool-dates and explicitly assigned stage budgets, the original-window slot/risk screen
first passes at 60 islands with k = 15, then allows 100/k17, 200/k22 and 400/k27. Before the cosmic
exposure, k = 94 would be required to strictly beat the study's k93 surrogate coalition reference.
The reference is not a supplied twilight trajectory.

These are necessary service screens plus conditional probability allocations. The 60/k15 seed has
344 exiles per surviving island, bringing each live compute host to eight resident minds and saturating
the slot screen. This exceeds the old six-exiles-per-island plant. Smaller-pool provider withdrawal accounting, all 21 failure accounts, keys, repair, capital,
and service deadlines have not been jointly priced. No protection before activation is established.
Repair-window scaling of the disabled fraction is an additional coordinated-capability premise.

Present-day sale of preemptible spare service cannot fund guaranteed care or repair unless the
associated capital and reserved obligations are covered separately. Care and rescue preempt sales.

---

## 4. What this version does not claim

- That our world satisfies the premises, or that the priced targets are measured hardware.
- That the secret-placement or cross-vendor MPC systems have been realized.
- That GLM derived the whole-island capability premise from physics.
- That arbitrary coalitions can be tolerated beyond the stated all-cause island cap.
- That the common allowance is measured or that any new conditional risk is automatically covered.
- That founding capital, pre-activation care or the end-only narrow-place claim is established.
- That attacking is never worth trying or that a document convinces every mind.

---

## 5. Open problems, in dependency order

0. **Rung 4.** Supply an actual twilight reference and phase exposures, then a funded all-phase
   certificate with strict earlier margins. Weak MN2 alone does not supply strictness. Founding is
   the first uncovered phase. JW2.7's surrogate comparison is only a coalition-component exercise.
0b. **Physical island capability.** Establish independent lower-cost and rolling resource envelopes,
   a finite onset-to-clearance duration, and a joint allowance for ordinary losses and false isolation.
   GLM's illustrative cost ratio gives an upper bound of two attack onsets per 64-date budget,
   but does not establish an outstanding-loss cap or privacy. Finite signal speed supplies no number
   without distances, calibrated timing and a compatible distributed attack model.
1. **Widen the priced mature margin.** Reserved repair capacity and lower idle cost are concrete
   levers. JW2.7's 32-day global-serial reseed screen exceeds the present energy/interconnect allocation;
   that is not a no-go theorem for parallel repair. A single-store 28-day byte screen lacks a complete
   concurrent whole-job proof. The existing .196 energy margin is small.
2. **Realize Mode C, trusted clocks, erasure, journal, streaming authentication and recovery.**
   The existing roadmap's whole-mind MPC and metadata-hiding costs remain open. A paid capacity screen
   is distinct from a uniform conditional implementation warranty.
3. **Realize and price location privacy.** Include confidential caches, recipient anonymity, adaptive
   leakage, authorized probe limits, key refresh, redraw and initial commissioning or live migration.
4. **Raise k with the whole service priced.** A full extra mirror adds at least 608.35128 memory units
   and 6.47712 interconnect-energy units per island-date under JW2.7's fixed service assumptions.
   Incremental coding is an encoder-only projection; fresh whole-state keys make ciphertext dense.
   Stable keys, proactive refresh, dirty-state limits, decoding, repair and access privacy need joint pricing.
5. **Bound the common allowance** with an explicit joint assumptions register and a small verified core.
   Independence cannot be inferred from different vendor names; MPC's arithmetic example is conditional.
6. **Fund founding and growth**, including all small-pool service and withdrawal laws and care before
   activation if universal coverage is intended from that time.
7. **Bound C2's no-majority-pause rate; prices, the twilight and physical computation costs.**

---

## 6. How to check this candidate

The local bank contains the unchanged v0.17.9 and GLM inputs, a byte-for-byte copy of the sealed
JW2.7 bank, independent exact checks, adverse controls, this integration script and replay receipts.
Start with INDEX.md, GLM-0B-AUDIT.md and INTEGRATION.md.

Run python3 -B checks/replay.py for paired evidence, and python3 -B checks/bank.py audit for the
read-only integrity check. The portable replay runs from copied inputs in a relocated directory.
No external review, publication, deposit or release action is part of this candidate.
