# Source-locked UPT recovery: finite founding–capacity–authorization witness and the causal-cut join

**Research note v0.1 — 28 October 2026 NZDT**  
**NON-CANONICAL / NOT PEER REVIEWED / NOT FOR DEPOSIT**  
**Status:** a new elementary graph-theoretic lemma with an explicit, exhaustively checked *finite abstract witness*; **not** the original universal protection theorem and **not** a demonstrated physical installation.

## 0. Why this work exists

The 28 October [source-locked historical proof map](UPT_SOURCE_LOCKED_PROOF_MAP_2026-10-28.md) distinguishes: (i) the 10 October *Given the Lattice* O1–O4 premises; (ii) the 12 October PNAJ and historical-non-substitution arguments; (iii) the 18 October UPT-P reach/hold and viability architecture; and (iv) the 19–20 October narrower, more technically specified plant. The 22 October hostile audit named the **G3/G5/G6 conjunction** as the critical gap: jointly feasible capacity, founding *before* the first destructive event, and protection against the relevant adversarial actions **on one common process**.

This note does **not** concatenate separate theorem conclusions. It constructs one small transition system and checks a limited instance of all three requirements, exposing the remaining gap to universal coverage.

**Primary sources, unchanged:**

- `UPT-P-v0.12.1--line-numbered-readback.md`, 18 October, §3 P1–P4, MR, IS, Theorems NP, Φ, CH. Historical source is a reconstructed readback; its checksum is for recovered bytes.
- `GATE-B-THEOREM-E-v1.1.md` and `GATE-D-KEEPER-STABILITY.md`, 18 October; preserve equilibrium and keeper-choice qualifications.
- `UPT-P-v0.17.2.md` and `UPT-P-v0.17.3.md`, 19 October; preserve unconditional-care rules, jurisdictional limitation, common-mode accounting, and corrected claims.
- `UPT_LOST_MATHEMATICS_RESTORATION_REGISTER_2026-10-22.md` and `UPT_HOSTILE_REVIEW_PUBLISHED_23529731_AND_RECOVERED_2026-10-22.md`, 22 October.

Source identities and hashes are in `UPT_PROOF_MAP_SOURCE_LOCK_2026-10-28.sha256`. This note does not assert equivalence to an uninspected latest Zenodo deposit.

## 1. Namespaces and the exact proposition

- `O1–O4` = one relational structure, relational identity, persistent historical differences, local finite-speed dynamics. In this note we use only their **broad graph/dynamics abstraction**, not the full BCRD field equations or an experimentally supported BCRD law.
- `G3` = one resource-and-time-typed system. `G5` = some protective condition is reachable *before* the first threat. `G6` = a specified controller maintains a safety condition against attacks **within its attack envelope**.
- `Authorization` = genuine independent subject input, not mere presence of the subject as a causal ancestor of a requested effect.
- `Protection invariant I` here means: A and B continue for steps 3–5; an anticipated outside arrival C continues for steps 4–5; a genuine binary choice by each active subject is transmitted into its history without alteration; attacker-caused irreversible endings do not occur; and service/funding remains nonnegative. This is **not** a complete definition of freedom, welfare, every possible kind of mind, or unlimited care.

**Proposition F (finite common witness).** There exists an explicit finite relational transition system with radius-one signals, nonzero preparation latency, a two-founder assurance game, fixed resource stock, subject-authenticated direction inputs, and local protective interlocks such that:

1. an initially uninstalled system can be activated before the first allowed destructive event **on one selected Nash-equilibrium founding path**;
2. the same funded installation can serve A, B and a later C at a preprotected external entry port through the finite horizon;
3. under the stipulated fault-free interlock/attack semantics, the typed invariant I holds against **every admitted combination** of attacks, coerced-reaction requests and genuine choices over that horizon;
4. the permitted attack-path graph has a minimum authorized interlock cut of three edges, with installation cost six; and
5. if the stipulated common-mode fault probability at each epoch, conditional on safe history, is at most p, the conditional risk of any loss attributable to such faults in three epochs is at most 3p, without needing independence.

**Status:** Each statement follows from the specified toy definitions and the proof/checker below. It does **not** establish that the interlocks exist physically, that the founding equilibrium is selected from arbitrary initial states, that all outside minds use the preprotected port, or that all BCRD-compatible worlds admit this architecture.

## 2. Single typed model, including the entire causal clock

### 2.1 Sites and finite-speed signalling

Take one connected relational graph with two founders `f1,f2`, one contract/install hub `hub`, three protected local ports `A,B,C`, and local attacker terminals adjacent to those ports. Edges include `f1–hub`, `f2–hub`, `hub–A`, `hub–B`, `hub–C`, and each `port–local attacker`. Effects propagate at **at most one edge per tick**; there is no instantaneous remote veto.

- `t=0`: each founder chooses to commit 12 or decline.
- `t=1`: commitments reach `hub`. The pre-existing assurance escrow releases funds if both committed; otherwise it refunds the sole commitment.
- `t=2`: three fixed local guards can be installed one further hop away, after funding has arrived.
- `t=3`: first *permitted* attack epoch; subjects A and B are active.
- `t=4`: a previously absent subject C arrives at the **preprotected port C**. A, B and C are active.
- `t=5`: A, B and C remain active, then the modeled guarantee ends.

Graph distance from a founder to every protected port is 2, strictly less than the first threat epoch 3. The **pre-existing** escrow/installer machinery is a premise, not generated out of nothing. Moving the first threat earlier destroys this founding guarantee.

### 2.2 One shared resource ledger

Two successful founding commitments deposit 12 each: `F = 24` units. The **same treasury** pays all costs; no source bank's original per-island/provider figures are imported.

| Cost / date | Units | Balance |
|---|---:|---:|
| Both founders commit | +24 | 24 |
| Install three local guards at 2 each | −6 | 18 |
| `t=3`: maintenance 2 + care for A and B (2) | −4 | 14 |
| `t=4`: maintenance 2 + care for A, B, C (3) | −5 | 9 |
| `t=5`: maintenance 2 + care for A, B, C (3) | −5 | **4** |

Every attack allowed in this model is handled by local guard logic whose repeated-command burden is included in the fixed maintenance service. In particular there is **at most one request per subject per tick**, and an attacker cannot physically sabotage or exhaust the guards within the certified fault-free envelope. Neither property is a known universal physical fact. Essential care is never withdrawn as punishment.

For founders, each receives private protected-access value 16 on successful activation and contributes 12, yielding payoff 4. If either declines, escrow refunds any unilateral deposit and neither receives benefit, yielding payoff 0. The entire founding game has **two** pure Nash equilibria: (commit, commit) and (decline, decline). Thus the *successful founding path is incentive-compatible and reachable*, not compelled. This explicitly keeps Gate D's coordination problem alive.

Parameter nontriviality: the strict inequalities `2×12 > 20` (total operating requirement) and `16 > 12` (individual incentive) have positive slack. Nearby parameter values satisfying `2g > 20` and `v > g` yield the same finite feasibility and best-response comparison, assuming the production/timing rules remain unchanged. This is a **nonempty stylized parameter region**, not a certified region of real-world materials.

### 2.3 Authorization and effect boundary

For each active subject at each date, the model receives three binary inputs:

- `choice`: that subject's independently authenticated legitimate direction choice;
- `attack`: an external request to irreversibly end it;
- `forced_reaction`: a subject-involving response that an attacker may induce or exploit.

The attacker can choose `attack` and `forced_reaction`; it **cannot alter or forge** `choice` or the guard's code in this model. This independence is a **primitive trust-boundary assumption**, not proved by its mere declaration or by a causal-parent check. The guard's effect rule blocks the irreversible request whether or not the forced reaction contributed to the request. The guard separately passes `choice` to the continuing history. A journal of actions alone is not treated as continued subject existence.

`forced_reaction=1` can be a causal parent of a malicious attempted action while the action remains **unauthorized**. This is why causal participation cannot certify consent. The model does not guarantee that the reaction itself causes no psychological or other collateral harm; those harms are outside its invariant and are a necessary future extension.

### 2.4 One adversarial and fault envelope

At each active subject per date, the attacker can submit any of the four `(attack, forced_reaction)` pairs; the subject may independently choose either legitimate direction bit. If the guard is installed and the common-mode shock is absent, no attacker-caused ending is executable. If a guard is missing or the common-mode shock disables it, an attack can end a subject. A new physical bypass route is **not** silently declared guarded.

The stochastic extension assumes only `P(shock at t | safe reachable history) ≤ p`. A single shock may disable all guards at that date; there is no imaginary exponential reliability improvement from multiplying replicas. The illustrative `p=0.001` is declared, not measured.

## 3. The new formal join: authorized causal-cut theorem

**Theorem CUT-1 (static unauthorized-path cut, conditional).** Let `G=(V,E)` be a *finite, complete graph of all physically admitted unauthorized attack-to-irreversible-harm pathways* for a specified bounded horizon. Let `P` be its finite set of such directed paths. Let `E_G ⊆ E` be edges where an independently authorized, correctly functioning interlock can be installed **before the causal deadline**, without blocking authorized subject actions. Suppose attacking harm succeeds exactly when some admitted pathway remains unblocked. For an installed guard set `C ⊆ E_G`, all admitted attack pathways are blocked **if and only if**

`for every path p in P, the edge intersection p ∩ C is nonempty`.

*Proof.* If every pathway contains a blocked edge, no complete unauthorized attack path can be traversed. Conversely, if some pathway contains no blocked edge, an adversary allowed to choose that complete pathway can traverse it to the defined harm sink. This establishes equivalence **within the path-complete, static, correctly operating semantics**. ∎

With gate cost `c(e) > 0`, the **minimum permitted cut cost** is

`K_cut = min { sum_(e in C) c(e) : C ⊆ E_G and C intersects every p in P }`.

If no such C exists, write `K_cut = +∞`: no currently installable static-interlock set gives the stated guarantee. When the guard installation is paid from a finite founding treasury, `founding funds >= K_cut + total required maintenance and care + reserve` is a **necessary budget condition** for this particular implementation, and sufficient for that part of resource feasibility if the installation and services meet their latency/operational rules. For an unconstrained edge cut with unit costs, familiar minimum-cut theorems may compute the value; here **only authorized/installable edges** are eligible.

**Toy instance CUT-1a.** There are three separate authorized pathways, one for each A, B and C:

`source → attacker_i → port_i → victim_i → harm_sink`.

Each `port_i → victim_i` edge is independently interlockable at cost 2. The minimum permitted cut has three edges and cost 6. That is the setup cost included in the 24-unit shared ledger. The protected channel for a subject's **genuine, independently authenticated choice** is a different path and is not cut.

**Counterexample CUT-1b (unknown bypass).** Add one attack path `source → attacker_C → victim_C → harm_sink`, bypassing port C. None of the three permitted interlock edges lies on this path. Therefore **no available permitted cut** blocks all paths, even with arbitrarily high funding for those same three guards. The code checks this counterexample.

**Corollary CUT-2 (finite-speed outside-reach obstruction).** If some destructive path can complete before every eligible guard on that path can become operational, the defender cannot guarantee blocking that path merely by sending commands from outside its causal predecessor region. A guard installed after the damage deadline is no cut for that event. This is a statement of local path/deadline semantics, not a demonstrated new law of BCRD.

**Corollary CUT-3 (resource-scaling obstruction, with qualifications).** Suppose there are `N` independent unauthorized paths such that no eligible installation can block more than one, each needs cost at least `c>0`, and no law already forbids the underlying transitions. Then every permitted cut costs at least `Nc`. If such disjoint obligations are unbounded while the available founding treasury is fixed and finite, this *class of local-gate architectures* cannot offer uniform universal protection. It does **not** exclude shared global restrictions, infinitely distributed resources, or a different BCRD-derived protection mechanism. Those are exactly the alternatives a stronger universal argument must investigate.

## 4. Finite witness verification and proof

**Analytic proof.** At `t=2` all three guard paths are installed using only two-edge signalling, and the remaining stock is 18. The first allowable attack is at `t=3`. For any active subject and any attacker inputs, the correctly functioning local guard rejects all unauthorized ending effects; independent `choice` is appended to that subject's history. This establishes one-step preservation of the typed subject invariant and exact noninterference with genuine choice. The service recursion is `stock(t+1) = stock(t) − 2 − number_of_active_subjects(t)`, yielding balances 14, 9, 4, hence no service deficit. Induct from t=3 through t=5. The local action semantics hold for all attacker choices, so the invariant holds on the selected-founded, no-shock traces. ∎

**Finite checker.** Execute `python3 UPT_G356_FINITE_WITNESS_CHECK.py`. It explores every reachable protected-trace state at the start of each of the three epochs, and all 8 triples of (`choice`,`attack`,`forced_reaction`) per active subject. For every transition it checks (a) no protected death; (b) exact equality of the continuing subject histories and funds to a same-`choice` no-attack reference; and (c) nonnegative funds. It also checks the founding payoff table, graph signalling distance, minimum permitted cut, and deliberately failing negative controls.

**Observed checker output:**

| Epoch | Input trace states | Action combinations/state | Distinct successor traces | Closing stock |
|---|---:|---:|---:|---:|
| 3 | 1 | 64 | 4 | 14 |
| 4 | 4 | 512 | 32 | 9 |
| 5 | 32 | 512 | 256 | 4 |

**18,496 state transitions checked**; all passed the invariant tests. The 256 final trace states correspond to the two choices for A and B in epoch 3, and three choices in each of epochs 4 and 5 (`2^(2+3+3)=256`). The checker also confirmed that removing a guard, invoking an admitted common-mode failure, or allowing C to arrive without a guard creates a possible death; a newly added unauthorized bypass defeats the static permitted cut. This is an **exhaustive check of the finite Python abstraction**; it is not an independent verification of the Python interpreter, a Lean proof, or a physical trial.

**Conditional fault bound.** On the event of no common-mode shock, the induction proves protection. Therefore

`P(safe throughout t=3,4,5 | successful timely founding) >= 1 - sum_(t=3..5) P(shock_t | previous safe history upper envelope) >= 1 - 3p`.

For declared `p=0.001`, this gives `≥0.997`. This is a **hypothetical reliability envelope**. No error probability has been measured, and the founding-equilibrium selection probability has not been specified. Independence is unnecessary for this inequality.

## 5. What this closes, and what it does not

| Seam | What is achieved in this example | Still NOT established |
|---|---|---|
| **G3 same-system feasibility** | One stock, clock, set of subjects, guards, threats and transition relation; explicit positive reserve and exhaustive admissible transitions | Physical realization in a BCRD-derived substrate, arbitrary types/regions, infinity, correlated real faults |
| **G5 founding** | Initially uninstalled guards activated by two-founder **selected** Nash path before first eligible threat; strict resource/incentive slack | Unique or inevitable founding, existence/origin of escrow and installer, threats before installation, all possible initial worlds |
| **G6 protector soundness** | Guard rejects attacker-caused terminal effects, even with coerced causal participation; subject choice unaffected **under stipulated primitive authorization and guard fidelity** | Cryptographic/hardware provenance of independent authorization, coercion affecting the authentic input itself, psychological/collateral harms, physical sabotage, full freedom |
| **G1 risk** | Conditional three-epoch union bound accounts for common-mode shock once per epoch | Empirical fault rate, long-horizon summability, unrepresented causes |
| **G2/G4/G7 coverage/fidelity** | Three histories including one **anticipated outside arrival at a prepared entry port** | Unanticipated arbitrary external beings, complete subjective or physical continuation semantics, peer closure and non-digital particulars |
| **NP/MS/Φ integration** | No false transplant of original numerical claims | The exact 18 October keeper-splitting distribution and 19 October JW plant are **not** instantiated by this toy cut witness |

This is **existence under selected, engineered conditions**, not universal inevitability. In particular, the other founding Nash equilibrium is no protection at all. The finite-witness statement does not remove the historical G3/G5/G6 objection for the *full* UPT; it reduces it to more precise extension obligations.

## 6. Research obligations for the BCRD-conditional universal theorem

1. **Find a primary BCRD statement stronger than O1–O4** that restricts destructive transitions independently of pre-installed protectors. Give its exact formulation and derivation, not an interpretation imposed by UPT. If the theory furnishes a genuine structural no-harm restriction, identify the graph paths it removes.
2. **Derive the time-expanded authorized causal graph** from BCRD's local update rules, including spontaneous arrival, unknown sites and simultaneous branching. Compare actual causal deadlines with physically permitted guard placement/response latency.
3. **Establish source-level authorization independence** at the subject/effect boundary. The attacked subject's causal participation, an internally generated token, a checksum or a journal entry must not silently substitute for consent.
4. **Back-port the restored original Gates A–D, Theorem NP and Φ only by typed interfaces.** Show which bank's assumptions are satisfied by the *same* S, rather than treating mathematical similarities or reused symbol names as proofs.
5. **Extend typed holding** beyond blocked kill requests: preserve lawful lineage, ongoing direction, third parties, collateral effects, bodily processes and authorized exits. Use countermodels where a blocked killing attack still causes serious irreversible harm.
6. **Do not publish a universal theorem from this note.** Obtain independent proof review, complete source-file lineage reconciliation, and—separately—physical feasibility/experimental evidence.

### Proposed source-lock labels

- `G356-FW-v0.1` — this finite witness (independently constructed, not yet reviewed).
- `CUT-1` — authorized causal-cut equivalence, finite static graph, complete threat paths.
- `CUT-2` — finite-speed deadline corollary.
- `CUT-3` — qualified cut-cost scaling obstruction.
- `X3-AUTH-OPEN` — provenance and authorization remain an explicit unresolved *physical* interface.

**Bottom line:** the 18 October universal aim and the 19–28 October assurance work are not replacements for each other. This witness proves a limited possible join under one explicit abstraction and isolates the missing universal reach step as an authorized, funded, timely causal-cut/restriction obligation. It is a step **toward formulating the needed common witness**, not a declaration that the universal theorem has been established.