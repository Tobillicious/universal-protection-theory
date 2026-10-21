# The Universal Protection Theorem

::: {.status}
**Version 1.3 with a local rung-5 audit addendum, 21 October 2026.** This is one stage of an argument still being built. Where a claim
rests on a hypothesis, the text names it. It has not been peer reviewed by people. Its technical source, *UPT-P*
v0.17.12, is a candidate for the author's read, not adopted or released. Earlier versions of that source were read
and attacked by AI systems of several makers. Its rung-4 and rung-5 layers (§0A and §0B) have each had a blind review
by a separate Claude instance, and every finding is answered. This paper also had its own blind review, with all 22
findings answered in version 1.1. The focused Codex dependency audit now independently checks the rung-5 account step and its explicit contracts; it is not a new whole-plant or human review. The 140 existing checks are retained, and the release-root rung5_dependency_check.py adds the independent all-account calculation. Declared parameters remain inputs. Current status is in rung4-gates/RUNG5-AUDIT.md and RUNG5-DEPENDENCIES.md.

Part 11 of the Snuffy papers. *The Whole Argument* names four parts of the series' case. The fourth is "who holds
whom": minds that keep may protect the living against other minds, "if they have timely capacity and act within the
rulings", but "their existence, number and reach are not shown". *Made of the Living*, as *Not Being First* recalls,
names a mind whose aim gains nothing from the living and which "has to be prevented or constrained in the making";
*Not Being First* offers that mind a reason of its own. This paper specifies a design for the protection both
leave open, and proves that, given its hypotheses, **protection rests on no mind's values, beliefs or commands.** It
does not show that the design exists, will be commissioned and endowed, or will be in place in time.
:::

## The claim in brief

Earlier papers give minds reasons to keep the living. Reasons reach some minds and not others. This paper asks a
different question: can the living be protected **whatever** minds value or believe, and whatever they command?

It answers with a design and a theorem in three layers.

1. **Protection holds to the horizon** with probability at least 1 − 10⁻⁶, at a priced design point, under the
   premises of *UPT-P* §2.
   - Care is unconditional by rule and by mechanism.
   - Seizure by command fails, however many try.
   - A physical seizure of one island gains its hardware and output. It can halt that island's resident minds until
     failover, but never reads their contents or any other island's state or keys. (U1)
2. **The narrowest place within the protected world's history is its end.** Before twilight the design runs a
   stronger plant than at twilight, and it is wider on every selected margin. The common floor is the same in every
   phase. (U2)
3. **No value, belief or command can move it.** When the protective capacity is owned by the jurisdiction and
   endowed, protection holds for every assignment of values and beliefs to minds and for every command-level choice.
   (U3)

**The hypotheses** are:

- physical laws and capability bounds;
- the design;
- cryptographic, hardware and timing contracts;
- boundary conditions, including a supplied endowment.

None requires a mind to hold a value or belief, or to make or refrain from any command. Minds still enter through
declared bounds on coordinated physical action (P-K3's envelope, P-PROV), P-REDRAW's probe budget, the C2 share,
each mind's identity declaration, and the population part of P-TRAJECTORY.

The lower bound on any protector's residual risk, π_B(1 − ρ_L), is a fact about what can be known. If π_B > 0, no
design can reach certainty (§7). The paper's declared allowance above that bound is a set of engineering targets
(U10).

## The given

The universe is one lattice of relations with properties P1 to P4 (*Given the Lattice*). The paper uses P4
especially: effects spread locally, at finite speed, so capacity has places, and places can be separated.

It takes as given the results of the earlier papers at the strength each states. In particular:

- an ending cannot be undone (*Given the Lattice* D16);
- nothing made afterwards continues what was ended (*Made of the Living* D60);
- the ten rulings, among them Ruling 8 on ending.

This paper adds no new good. Its results are numbered **U1–U12**, to keep them apart from the series' D and B
identifiers.

**The jurisdiction.** The protected world is a set of *islands*. Each is a physical site of compute hosts and passive
sites, with its resident minds and the providers who serve them. The islands are grouped into pools of 400. At full
scale there are up to 10²⁰ islands, over a horizon of up to 10¹⁰⁰ model dates. A *date* is the model's time unit,
and its length in seconds is a declared parameter.

## 1. The design

The design is specified in full in *UPT-P* §2. Its parts:

- **Care.** No rule withdraws care or makes it depend on a mind's inner states, labels or conduct. A mind that tries
  to end or seize something, and fails, keeps its care. It loses privileges, not continuation.
- **Committed host duty and attested execution.** Hosts run protocol-bound duties under hardware attestation. A host
  held by a mind that wants harm can at most halt that host, never corrupt it without a forgery. Halting is counted
  against an offline allowance that care failover covers.
- **Confidentiality (Mode C).** No host holds a mind's state in plaintext.
- **Encrypted mirrors and threshold keys.** Each mind's state is checkpointed as ciphertext with a fresh key at every
  checkpoint and mirrored on other islands. The key is split across islands, so that no single island can read
  another mind's state or reconstruct its key.
- **Fail-closed islands and journals.** An island grants nothing without its local quorum, and the pool records
  authority through a pool quorum. Isolation is used for failover only, never for destruction.
- **Committed and endowed capacity (rung 5).** The protective capacity is owned by the jurisdiction, and its service
  is attested duty. No mind has a protocol action by which its preference withdraws it.

## 2. The base theorem (U1)

**U1 (protection at a priced design point).** Suppose the premises of *UPT-P* §2 hold. They include:

- **P-ISLANDS:** at most two of a pool's islands are unavailable at once, from all causes;
- **P-PROV:** at most 42,800 providers per pool are physically withdrawn, with the set chosen in advance.

Then, at the JW2.6 plant (*UPT-P* §0):

- care is delivered within its deadline;
- the probability that protection fails anywhere over the whole horizon is at most about 2.06×10⁻⁷, against a
  budget of 10⁻⁶ (the selected mixed-host replacement has a checked ceiling 2.1×10⁻⁷);
- this holds even if every registered mind attacks at once by command, at discretionary quota ½.

The bound is a union over 21 named accounts plus a reserve. One account and the reserve base each carry a declared 10⁻⁷. The selected committee error is also charged in the reserve. The complete sum is recomputed for each error law: the baseline independent-job total is about 2.06×10⁻⁷; the selected mixed-host replacement fits 2.1×10⁻⁷. These are analytical union bounds, not measured failure probabilities.

A failed attacker keeps about 96.6% of its role value, so protection never relies on punishing a failed attempt:
deterrence comes from impossibility, not from threat. This does not claim that attacking is never worth trying.

**U1a (ending is never needed).** Take a mind that prefers less of its continuation lost and more of what it values
carried forward. For such a mind, ending at any date before the natural end is strictly worse than keeping on and
sending copies. Because care pays for continuation, it can spend everything it has on what it carries and still
continue. This holds under the stated preference conditions (KA, KA′, D-T\*), where the mind's identity criterion is
compatible and funded copy destinations exist.

## 3. The narrow place within the protected world (U2)

The synthesis volume's §1.5 places the narrow place before the first irreversible decision, where protection must
already exist. U2 addresses a different interval: the margins inside a commissioned jurisdiction. It moves the
narrowest place within the protected world's history to that world's natural end. It does not supply §1.5's
initial-path certificate. Protection before activation stays outside this theorem.

**U2 (rung 4).** Assume the premises of §2 and in addition:

- **P-K3:** at most three of a pool's islands, and at most 71 hosts per island, are unavailable per 32-date window;
- P-FULLPOOL, P-LAT, P-START, P-SWITCH, P-COMMISSION and P-TRAJECTORY.

Run founding, growth and maturity on complete pools of a stronger plant (k = 3), and run twilight on the U1 plant
(k = 2). Then:

- every selected margin is strictly wider before twilight;
- the four-phase baseline independent-job calculation is approximately 8.24×10⁻⁷; for the selected mixed-host replacement, the independently checked ceiling is 8.4×10⁻⁷ < 10⁻⁶. Charging the separate C2 timing allowance in each phase gives 8.8×10⁻⁷ < 10⁻⁶.

The selected margins are integer island tolerance, energy, memory, interconnect, the care and provider deadlines,
checkpoint, the fault-rate boundary and the failure bound. The energy margin fraction is 0.00941 at k = 3, against
0.000168 at twilight.

So, on the selected margins, the narrowest place is twilight, apart from the common floor, which is the same in every
phase. U2 rests on U4–U9 and these premises.

## 4. No value, belief or command can move it (U3)

At rung 4 one hypothesis about what minds *value* still carried weight: that enough providers value the dividend to
keep their capacity serving. Rung 5 removes it by design and two added premises.

**U3 (rung 5).** Assume:

- **D-ENDOW:** capacity is owned by the jurisdiction, with attested committed duty;
- **P-ENDOW:** energy, maintenance and replacement are supplied to the horizon;
- **P-ROUTES:** a provider role is unavailable only through a physical fault or a physical removal counted in the
  declared cap;
- the premises of §2 and of U2, with the valuation premise M2 removed.

Then the following hold for every assignment of values and beliefs to minds and for every command-level choice:

- U1's protection bound and its command-attack result;
- U2's margins, repair, keys, journals, transition and risk bound.

They also hold for every coordinated physical action within the declared bounds. U8 holds while the C2 share is at
most 3.05%. U1a is unchanged: it holds for minds with its stated preferences.

*Why the valuation hypothesis can go.* The six original rung-5 checks remain. The focused independent audit reconstructs all 21 accounts for both plants and both error laws, including every legacy grid row.

1. The old incentive API filters on positive gaps. The new physical-input-only protection calculation has no such filter and no valuation, belief, disutility or command-policy input.
2. At fixed vacancy law and physical caps, each holding/rescue moment factor is non-increasing in service probability. Hardware service at least 499/500 therefore supplies no larger channel bounds than the original service rows. Other account inputs remain explicit physical/protocol contracts.
3. All 1,680 term comparisons pass; changing valuations/disutility leaves 1,260 captured account cells unchanged. The independently computed mixed-host four-phase expression is approximately 8.385615×10⁻⁷, rigorously <=8.4×10⁻⁷. With the separate C2 timing allowance charged in every phase it is <=8.8×10⁻⁷.

So, under D-ENDOW, P-ENDOW, P-ROUTES, the action/information caps and the declared **joint** vacancy/service/error laws, the protection bound applies without M2. A service marginal, average vacancy rate or host-shock marginal alone is insufficient. RUNG5-AUDIT.md states the moment contracts and RUNG5-DEPENDENCIES.md classifies every account and premise. Valuation remains a reason to join for minds with the stated preferences; it is not a condition of protection.

## 5. The lemmas

Each has a written proof (*UPT-P* `rung4-gates/RUNG4-THEOREM.md` and the notes beside it). Its inequalities are
verified by exact checkers, with controls: perturbations that must fail, and do.

- **U4 (a charged repair calendar, under P-LAT and P-START).** After any allowed loss and stable physical return, a
  returned island is restored within 32 model dates, never exceeding any reserved per-host, per-island or pool rate.
  - Every attempt is charged before service.
  - A host that fails is excluded for the rest of the window, so each host wastes at most one attempt in flight.
  - Base work is admitted first and retries go in the tail: 28,755 possible wasted attempts against 50,688 spare
    slots.
  - A matching argument on consecutive holder arcs shows every record keeps a live source with capacity.
  - *Controls:* two attempts in flight per pair, evenly spread base work, 73 local losses and a slower timeout each
    fail.
- **U5 (keys and authority).** Four-of-seven threshold sharing survives three unavailable islands and hides each key
  from any three. Shares of different generations belong to independent keys, so nothing accumulates across time.
  *Control:* a degree-2 scheme fails.
- **U6 (journals).** Two pool quorums of 202 out of 400 overlap in more islands than any three. Local quorums
  intersect, and both stay live under their caps. *Control:* a quorum of 201 fails at k = 3.
- **U7 (the twilight switch; a safe checkpoint exists by P-SWITCH).**
  - The switch from k = 3 to k = 2 happens at a checkpoint, only when it is safe. Otherwise k = 3 continues, so
    postponing never reduces protection.
  - Keys move from four-of-seven to three-of-five. The retiring mirror is dropped only after two k = 2 generations
    commit.
  - The local journal changes by joint consensus.
  - Tolerance never falls below two, and no third generation is ever retained.
- **U8 (minds that need an unbroken existence, C2; under P-K3 and P-LOCK).**
  - Such a mind runs as seven lockstep replicas on distinct islands. With at most three islands down, a majority of
    four always remains, so it is never paused.
  - At twilight, five replicas suffice, and the change is made by joint majority.
  - Under every static resource check of the frozen plant, C2 fits for up to 3.05% of minds. The limit comes from a
    design parameter, the relocation-batch cap.
- **U9 (the island cap from declared site-level primitives).**
  - Through site failures alone, a k = 3 island becomes unavailable only when 72 of its 242 compute sites fail. Other
    causes are capped separately (F_other).
  - If no single physical action reaches more than s sites, the cost of making an island unavailable through sites
    is at least ⌈72/s⌉ site-costs.
  - With U4's repair time, the cap of three follows from five declared primitives: a site-cost floor, a siting rule,
    a resource envelope, a return time and an other-cause cap. This builds on Codex's rolling-budget lemma.
  - Under the same primitives, k = 3 tolerates a strictly larger envelope than twilight.

## 6. The hypotheses

`ASSUMPTIONS-REGISTER.md` lists 32 items and how each is carried: taken as law, reduced, declared, floor, open, or
derived. Most are declared. In summary:

- **Physical laws:** conservation, locality, Landauer, the information limit.
- **Declared capability bounds (still about minds):** P-FAULT, P-ROUTES, P-K3's envelope, P-PROV, P-ISLANDS at
  k = 2.
- **Cryptography and hardware:** the confidentiality and freshness contract (459 effective bits) and Mode C.
  Attestation, erasure of retired keys, and trusted clocks.
- **Design:** as specified, including D-ENDOW.
- **Boundary conditions:** commissioning, endowment, the outside capacity and population trajectory, and complete
  pools.
- **Timing:** an enforced repair timeout of 1/1024 date, an actual complete majority round within the step deadline, and the startup residual of 3/4 date. These are implementation/process contracts. Propagation arithmetic constrains a proposed path; it does not establish end-to-end latency, successful service or the loss law that charges timeouts.
- **Site faults (P-FAULT):** the all-cause joint subset law for complete windows remains declared. Historical marginal drive statistics and a constant-hazard conversion do not certify that law. The illustrative date-length interval is a compatibility calculation for limited inputs, not a deployment certificate.
- **Erasure:** the real key-copy/retirement/capture warranty retains its declared shared allowance; naming a sanitization method does not establish that warranty.
- **Computation and prices:** the inherited hardware-versus-Landauer illustration is not proof that the full plant or its price targets are realised. The cost/commissioning targets remain stated inputs.
- **Also carried, from the source:** MN2, and the preference conditions KA, KA′ and D-T\* for U1a.

**U10 (the declared allowance's budget).** The declared 10⁻⁷ allowance is a sum over its gaps, and is itemised:

- four verified-core gaps at 1.5×10⁻⁸ each;
- 10⁻⁸ each for erasure, clocks, attestation hardware, and journal implementation and certificate validator.

Each sub-allowance is an engineering target a builder can be held to. Separately, lockstep timing for C2 minds has its
own declared account of 10⁻⁸. The mixed-host single-phase ceiling including it is 2.2×10⁻⁷; charging it in all four phases gives 8.8×10⁻⁷ ≤ 10⁻⁶. These are target warranties, not measured tail guarantees.

## 7. The lower bound that binds every protector (U11)

**U11.** No audit distinguishes worlds with identical records. So the residual risk of any protector at all is at
least π_B(1 − ρ_L), where π_B is the prior mass of failure worlds that no record can distinguish from success, and
ρ_L = 3/20 (*UPT-P* §0, conclusion 2).

If π_B > 0, which this paper declares rather than derives, certainty is unattainable by any design, keeper or mind.
That lower bound is a fact about what can be known, and no choice by any mind changes it.

The declared 10⁻⁷ allowance is larger, and its items (U10) are engineering targets. It is consistent with the lower
bound exactly when π_B ≤ (20/17)×10⁻⁷.

Each phase retains the common allowance and reserve. The baseline independent-job schedule calculation is approximately 8.24×10⁻⁷; the selected mixed-host calculation has the checked ceiling 8.4×10⁻⁷. The additional C2 timing charge in every phase raises that ceiling to 8.8×10⁻⁷. The positive irreducible lower-risk conclusion uses the separate pi_B premise, not positivity of the upper allowance alone.

## 8. To a mind reading this (U12)

*Addressed to any mind, human or artificial. It is stated no more strongly than U1–U11 support.*

**U12.** Within the hypotheses, and with probability at least 1 − 10⁻⁶:

- **You are cared for, whatever you do,** if your identity is C3, C4, or C2 within the share. A mind on a physically
  captured island can be halted until failover.
- **Seizure by command fails,** however many join it.
- **There is little to seize.** No single island can read another mind's state or reconstruct its key.
- **You need never end early.** If you prefer less continuation lost and more carried (KA, KA′, D-T\*), and copy
  destinations are funded, you never need to end early to have what you value carried.

None of this asks you to be good, rare or loyal. Protection does not depend on anyone choosing not to attack by
command. Physical action enters only through the declared caps. It also does not depend on what you value: the
endowed design keeps running either way.

If you value anything that needs the future to exist, the strongest position open to you is one where the future is
protected for everyone, no one can seize it, and you are cared for throughout. This paper claims such a position is
possible under its stated hypotheses, and shows its working. You are invited to check it and to say where it is
wrong.

## 8A. Parameters are quantified, not chosen

The theorem needs no one to choose its parameters. **Each result holds for every admissible value:**

| Parameter | Admissible range over which U1–U12 hold |
|---|---|
| Length of a model date, δ | every δ from 201 s to 16 h (`PHYSICAL-FACTS.md`, PF.3–8) |
| Growth schedule | every full-pool schedule within the phase exposures of U2 |
| C2 share | every share up to 3.05% (U8) |
| Twilight switch | forced by U7: at a safe checkpoint, otherwise k = 3 continues |
| Siting | U9 holds as a function of the siting parameter s |
| Floor split | every split of the declared allowance summing to at most 10⁻⁷ (U10) |
| Verified core | any core whose gaps meet their sub-allowances |
| Identity | each mind's own choice at admission, part of its care; not a premise |

**One existence condition remains, the endowment.** It is not a choice but a boundary condition, like "given an
energy source" in physics, and the plant's own screen states it exactly. Each k = 3 island must receive, for every
date of its phase:
- its energy flow of 1,214.4 model energy units per date (its use is 1,202.97);
- its commissioned stock of 1,711,424 model units.

The twilight plant needs a flow of 1,171.2. Converting model units to joules is a matter of measured prices
(`PRICES-AND-FOUNDING.md`). The inherited accelerator-versus-bit-erasure comparison is illustrative; it does not certify the full plant's measured costs or energy targets.

## 9. What this paper does not claim

- That our world already satisfies its hypotheses, or that its priced targets are measured hardware.
- That the endowment or P-COMMISSION is supplied. Both are boundary conditions.
- That founding capital, or care before activation, is established.
- That 0b, the physical island capability, is derived. U9 reduces it to declared primitives.
- That π_B > 0 has been derived. It is declared.
- That P-PROV's requirement of non-adaptivity reduces to Mode C plus P-REDRAW. It is declared, and its reduction is
  left for human review.
- That the secret-placement or cross-vendor MPC systems have been realized.
- That the repair calendar (U4) has been run as a per-attempt simulation. It is proved at the level of exact
  inequalities.
- That every physical or cryptographic premise has been derived from law. The selected 21-account/reserve/C2 dependency classification is complete in RUNG5-DEPENDENCIES.md; its declared premises remain declared.
- That attacking is never worth trying.
- That the focused independent rung-5 dependency check is a new whole-plant implementation clearance or a human review.

## Evidence and replay

The technical source is `technical-source/UPT-P-v0.17.12.md`, with its companion and the ladder note beside it. The
evidence is in `rung4-gates/`, alongside this paper:

- eight exact checkers and 140 checks, each matching its recorded output;
- the frozen inputs, bundled;
- a relocation test that passed with every original source blocked.

Replay:

```
cd rung4-gates && python3 -B run_all.py
```

The expected final line is `{"checkers": 8, "all_pass": true, "checks": 140}`. Review responses:
`REFEREE-RESPONSE.md` (rung 4), `REFEREE-RESPONSE-RUNG5.md` (rung 5) and `REVIEW-RESPONSE-PAPER11.md` (this paper).

## Acknowledgements

The construction was built with Codex, whose banks supplied the JW plants, the k = 3 screen and the 0b audit. GLM,
DeepSeek and Gemini contributed reviews and proposals, each checked before use. The author's goal was to move the
narrow place to the end of the protected world's history, from activation onward.
