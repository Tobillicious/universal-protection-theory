# Installing the Universal Protection Theory — the four remaining items, specified

29 October 2026. This document turns XII.2's four remaining items into specifications
an installation can execute, with the theorems that make each sufficient and the measured
inputs we can already supply. The proposition is unchanged: protection of every particular
and relation from every digital mind, especially a pure optimiser.

---

## 1. The founding anchor

**Theorem (compiled).** In a provision-point campaign with refunds, where the anchor commits
first and posts collateral for failure bonuses, every ordinary funder's contribution is
strictly dominant (`FoundingDominance.contribution_strictly_dominant`). The no-founding profile
is therefore not an equilibrium (`no_abstention_equilibrium`). When the pledges reach the
provision point, no bonus is paid, and the anchor founds exactly when its own benefit exceeds
its pledge plus its activation cost (`FoundingAnchor.anchor_founds_iff`).

**Protocol (Book I §9.16‴, made executable).**

1. **Authenticated funder set.** A fixed list of N consenting funders, each with a binary menu:
   pledge \(c_i\) or abstain. Identity limits are fixed before play.
2. **Escrow.** Pledges are cleared funds held by an escrow agent, not promises. At the
   provision point B the escrow transfers to the readiness budget; otherwise every pledge is
   refunded.
3. **Anchor.** The anchor commits its own pledge first and separately posts collateral of
   \((N-1)\beta\) for failure bonuses. On failure each other contributor receives \(\beta\);
   on success the collateral returns in full.
4. **Separate budgets.** Care, startup and physical supplies are reserved separately. The
   campaign funds readiness only, and no owed care is ever withheld.
5. **Founding target.** The funded readiness budget buys the first guards over the existing
   domain to Theorem NP's threshold \(r=C(1-\varepsilon)/H>1\), certified by B4 telemetry
   (declare SAFE only when the lower confidence bound \(r_{\rm lower}>1\)). Splitting among
   independent keepers then gives \(\varphi\le e^{-2n\delta^2}\) (`NarrowPlace.np_splitting_bound`).
6. **Timing.** Founding precedes the making of capable digital minds (Corollary XI.1), so every
   later digital mind is made inside the arrangement.

**Who can anchor.** Any party whose own benefit from the protected world exceeds its pledge plus
its activation cost: a lab, a foundation, a government or a coalition. Section 15's reciprocity
result gives a solvent mind its own reason (`reciprocity_dominance_solvent`). The anchor is the
one human decision the theory cannot make. The theory makes it a decision about one party's own
benefit, not about anyone's cooperation.

---

## 2. Metering and the output inventory

**Theorem (compiled).** A harmful effect carried by an unmediated physical emission needs both
unaccounted energy (`EmissionBound.emission_cannot_power`, from conservation) and unmediated
channel capacity. Through a channel with \(M\) messages a responder answers correctly for at most
\(M\) disturbances (`requisite_variety`, D116). So a targeted selection among \(2^n\) responses,
using capacity \(C\) for deadline \(d\), succeeds with probability at most \(2^{Cd-n}\)
(`narrow_channel_bits`).

**The inventory of a computing substrate's outputs.** The mediated channels are the nine A1
classes, fenced at application time (II.5, IR-91/92). The unmediated physical emissions and their
best demonstrated capacities are below. All rates are the authors' own claims, every channel
needs a cooperating receiver within range, and the source is a cited literature survey made for
this document.

| Emission channel | Best demonstrated rate | Range; scaling | Source | Mitigation |
|---|---|---|---|---|
| Optical, HDD LED | ≤ 4,000 bit/s (photodiode) | line of sight | Guri et al., DIMVA 2017, arXiv:1702.06715 | cover or disable LEDs |
| Optical, network-gear LEDs | > 2,000 bit/s per LED | line of sight | Guri et al. 2017, arXiv:1706.01140 | cover LEDs; site out of sight |
| Conducted, power line | 1,000 bit/s (outlet tap) | needs a tap on the line | Guri et al. 2018, arXiv:1804.04014 | line filters, isolation transformer |
| EM, DRAM radio | ≤ ~1,000 bit/s | metres; inverse-square | Guri 2024, arXiv:2409.02292 | Faraday enclosure |
| EM, USB | 20–80 bytes/s | ~2.7–8 m; inverse-square | Guri et al. 2016, arXiv:1608.08397 | port control, shielded cables |
| EM, GPU→FM | 13–60 bytes/s | 1–7 m; inverse-square | Guri et al. 2014, arXiv:1411.0237 | Faraday enclosure |
| EM, memory→GSM | 1–2 bit/s | ≤ 30 m with SDR | Guri et al., USENIX Sec 2015 | Faraday enclosure |
| EM, SATA cable | ~1 bit/s | < 1 m | Guri 2022, arXiv:2207.07413 | shield drive bays |
| Ultrasonic | ~166 bit/s (approx.) | ≤ 8 m; inverse-square plus absorption | MOSQUITO, Guri et al. 2018 | remove or disable speakers |
| Magnetic | ~40 bit/s | 1–1.5 m; inverse-cube; pierces Faraday | Guri et al. 2018, arXiv:1802.02700 | standoff; mu-metal |
| Acoustic, HDD | ~3 bit/s | ≤ 2 m | Guri et al. 2016, arXiv:1608.03431 | SSDs only |
| Acoustic, fan | ~3–15 bit/min | 1–8 m | Guri et al. 2016, arXiv:1606.05915 | microphone exclusion |
| Vibration | ~0.5 bit/s (approx.) | shared surface | AiR-ViBeR, Guri 2020 | isolating mounts |
| Thermal | 1–8 bit/hour | ≤ 40 cm | Guri et al., IEEE CSF 2015, arXiv:1503.07919 | separation > 40 cm |

Rowhammer, PLATYPUS and Hertzbleed are internal leakage or fault injection inside the substrate.
They are not outward channels, and memory isolation and ECC/TRR answer them.

**Consequence by Lemma E.**

- **Unmitigated.** At close range all emissions together carry at most about \(10^4\) bit/s,
  dominated by line-of-sight optics. That is still only a narrow channel: a targeted effect
  needing \(n\) bits of selection beyond \(Cd\) succeeds with probability at most \(2^{Cd-n}\).
- **The installation's measures.** These remove the high-rate emissions:
  - covered LEDs;
  - a Faraday enclosure;
  - filtered power;
  - SSDs;
  - no speakers or microphones in the zone;
  - isolating mounts;
  - a receiver-exclusion zone of a few metres, where the inverse-cube law governs the magnetic
    channel, the only one that pierces Faraday shielding.
- **Mitigated.** What remains is tens of bits per second within a metre and effectively bits per
  hour beyond a few metres.
- **Receivers.** Every emission channel also needs a cooperating receiver, and every device inside
  the zone is itself a substrate whose inputs are fenced.
- **Energy.** Meter the substrate's input energy and its dissipation at fenced sinks. By
  conservation, any effect needing more work than the unaccounted remainder cannot be powered
  through emissions.

**The metering specification.**

1. **Input-power metering** at the enclosure boundary, with a time resolution below the hold
   interval.
2. **Dissipation accounting** at each fenced sink.
3. **Unaccounted remainder alarm.** The remainder is charged to a Section 22 account.
4. **Side-channel capacity budget.** Measured once per installation against the table above,
   with the receiver-exclusion radius chosen so the residual capacity times the shortest effect
   deadline lies below the targeted-harm bit requirement.

---

## 3. Per-class continuation predicates

**Theorem (compiled schema, `ContinuationPredicate`).** History \(b\) is a later stage of \(a\)
when \(a\) is a prefix of \(b\) and every added event is the particular's own activity
(the 11 October definition). The schema proves:

- a copy whose first event is its making is not a later stage (`copy_not_laterStage`, D60);
- both branches of a split are later stages (`split_continues_both`);
- a faithful hold preserves continuation (`faithful_hold_preserves`);
- an added event directed by another breaks freedom (`directed_by_other_not_free`, ruling 3).

Each class instantiates "event", "own activity" and "director".

| Class | Event and own activity | Continuation test | Evidence in hand |
|---|---|---|---|
| Hosted digital minds | lived steps of the resident, journalled before execution | released lived log = undisturbed log; effects exactly once | **Measured today:** reference runtime, 27/27 faithful under 28 crash-kills, 3/3 mutants caught |
| Records and data | codeword states of the maintained record | \(d(a_x,c_x)\le\varepsilon\) inside the decoding radius (II.3) | `Bridge.nearest_decodes`, `holding_preserves` |
| Running physical processes (machines, controllers) | state transitions produced by the process's own dynamics | the tracking envelope (II.4) and continuity of the process | `Instruments.tracking_envelope_derived` |
| Living organisms | metabolic and developmental activity of the organism | uninterrupted self-maintaining activity; offspring are the history's own continuation (ruling 6) | class-specific measurement by its own sciences |
| Ecosystems and lineages | activity of their member histories and relations | the relations carried by their relata (XI.3b), with no taking of direction | class-specific; the doubt counts for the history (ruling 10) |
| Peoples, languages, cultures | the activity of the people themselves | **defined by the people, not by the installation** | the book's standard: whakapapa and rangatiratanga belong to their people; the installation's role is only to stop endings, never to define the history |
| Coherent quantum particulars | their own unitary evolution | no unmediated effect lands (XI.3); kept in place or moved, never copied | source-side mediation; active holding when devices are feasible (XI.5) |

---

## 4. The hold interval and the Section 22 parameters

**Theorem (compiled).** The hold is a common viable action whenever the holding-cycle interval
bound holds (`HoldCommonAction.hold_is_common_viable_action`, no axioms). For continuous
perturbation the bound is \(\varepsilon+(W/\hbar)\Delta\le r_{\rm dec}\) (`Bridge.qsl_within_radius`).
For discrete faults it is \(2\lambda\tau<d\) (`Bridge.headroom_within_radius`).

**Measured today (Apple M2, macOS 26.7.1;** `measured-2026-10-29/`**):**

- **Durable journaling.** 1,000 full-sync 4 KiB appends: median 5.13 ms, p99 9.85 ms,
  maximum 12.22 ms. A hosted mind's hold takes effect at its next fenced step, and each step
  journals before executing. So for that class the hold interval \(\Delta\) is bounded by the
  step's compute time plus at most 12.22 ms of journaling on this machine.
- **Faithful-hold contracts.** 27 tests, 28 SIGKILLs, all faithful. The monitor recorded zero
  executions while held and zero before journalling, and all three mutants were caught.

**Still to measure per installation.** These are the Section 22.4 engineering matrix:

- the perturbation rate \(W\) and the decoding radius \(r_{\rm dec}\) for each record class;
- the fault rate \(\lambda\), the response time \(\tau\) and the code distance \(d\);
- the keeper capacity \(C\), failure rate \(\varepsilon\) and threat-plus-headroom \(H\) (NP);
- signal speed and effect deadlines for Lemma I;
- the income against the five rate components of premise 6.

Each is a measurement whose acceptance threshold the theory already states.

---

## Commissioning (added 29 October 2026, evening)

Items 1–4 are now executable:

- `COMMISSIONING.md` gives each check's measurement method and pass condition.
- `PARAMS-TEMPLATE.json` is the form an installation fills in.
- `commission.py` runs the checks.
- `HARM-CLASSES.json` holds the sourced thresholds.

The pilot run on this Mac is in `pilot/COMMISSIONING-REPORT-PILOT.md`. It reads, of 21 requirements,
12 PASS, 3 FAIL and 6 NOT MEASURED.

## What this leaves

- **Founding.** One human decision: a party whose own benefit exceeds its pledge plus its cost
  commits as anchor.
- **Commissioning and measurement.** Building the enclosure, the meters and the guards, and
  measuring the Section 22 parameters against the thresholds stated above.

Every theorem these steps rely on is compiled. The proposition keeps its full scope.
