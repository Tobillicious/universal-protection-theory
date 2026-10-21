# The Universal Protection Theory

### A machine-checked law of alignment with all. Version 1.5, repaired candidate.

Tobias Croydon-McRae and (Snuffy) Princess Snuffleupagus. 21 October 2026. CC BY 4.0. Local repair candidate prepared by Codex; not adopted or published. DOI 10.5281/zenodo.23510623 (concept DOI; always resolves to the latest version).

Part of the Snuffy research programme on why a capable mind keeps the living. This release can be checked by anyone: one command rebuilds the Lean proofs and reruns every bundled exact check (Section 8).

## Abstract

The Universal Protection Theory states what an agent aligned with everything does, and proves it. Its scope is all: every particular of the universe, minded or not, living or not, and every relation among them.

The central result, the law, is a set of theorems about choice under a single order: keep lives first, then freedom; keep everything that exists first, then everything yet to be made. An agent aligned in that order never needlessly ends or overrides anything, in any feasible situation, finite or infinite. When existing particulars are nonempty, maximality on a proper part does not guarantee the stated protection; counting not-yet-made particulars at the same priority can also fail. The life guard preserves every life that the feasible standby option preserves. Wherever the nonlethal full-order hold certificate is feasible, every option that ends someone with positive probability is strictly dominated. A general theorem shows that faithful holds of hosted minds work under the stated atomic protocol, for every finite schedule of pauses and crashes and the stated effects-word feedback environment.

The order-theoretic core of the law is checked in Lean 4. U1, the life guard and hold dominance use no axioms at all; the exact criterion U2★ uses classical logic, and the general hold theorem uses Lean's two standard library axioms. The other results combine explicit analytical arguments with exact checks in their declared finite domains. The proof notes state which parts are analytical and which are kernel-checked. What the theory does not yet establish is stated plainly in Section 7.

## 1. What the theory is

A theory of protection needs three parts:

- **a law,** which says what aligned agents do;
- **a bridge,** which says how the law reaches everything;
- **instruments:** built things that carry the law into the physical world.

This release proves the law, states the bridge, and reports the instruments with their honest status. The order-theoretic core quantifies over arbitrary particular sets and feasible families. Its application uses the declared order and outcomes. Stochastic corollaries compare measurable outcome events under a common law; instrument claims carry their stated protocol and physical contracts.

## 2. Definitions

**Particulars and outcomes.** In any outcome, each particular is **ended**, **overridden** (alive, but not moving in its own direction, for example held or coerced), or **free**. Some particulars already exist; others are not yet made.

**Options.** An option is a feasible outcome. A feasible family is the set of options actually open to an agent.

**The canonical order.** Options are compared in four stages, each by set inclusion:

1. existing particulars kept **alive**;
2. existing particulars kept **free**;
3. new particulars made alive;
4. new particulars made free.

A later stage is consulted only when all earlier stages are equal. In Lean this is a strict partial order (`lex_irrefl`, `lex_trans`).

**Aligned and needless.** An option is aligned if no feasible option is better in the canonical order. A loss is needless at a stage if some feasible option is equal to the chosen one at every earlier stage, keeps everything the chosen option keeps at this stage, and also keeps what was lost.

**Faithful hold.** A hold is faithful when it ends no one, and in every state its outcome is at least as good, in the full canonical order (lives, then freedom), as the outcome of every feasible alternative.

The statewise E7 certificate and the hosted-pause refinement are distinct statements. Applying both to one real hold supplies both its outcome comparison and its state/history/effect correspondence; neither statement alone establishes the other.

**Restrainable acts.** An act of an agent is restrainable when one of that agent's own feasible alternatives keeps everything the act keeps, plus someone the act would end. The test uses the agent's own options, never the protector's.

## 3. The law

| Result | Statement | Proof |
|---|---|---|
| **U1** | An aligned agent never needlessly loses anything at any stage, in any feasible family, finite or infinite | Lean `canonical_life_first_U1`, `lex_U1` (no axioms) |
| **U2★** | When something exists, a choice rule of the form "be maximal on part S" guarantees no needless loss of anything that exists **if and only if** S is exactly what exists. Missing any existing particular fails, and so does counting not-yet-made particulars at the same priority | Lean `U2_star` (uses classical logic); exhaustive check |
| **U3** | No gain to beings not yet made justifies a strictly worse outcome for those who exist | Lean `U3` |
| **Life guard** | Among the options preserving every standby life, a choice maximal in the full canonical order within that guard family is aligned overall and preserves those lives. With feasible standby the guard family is nonempty; a maximal choice exists for a finite family, or with the stated chain-upper-bound condition by Zorn. The infinite existence argument is not formalised | Lean `life_guard`, `guard_first_stage` (no axioms) |
| **Holds dominate** | Under uncertainty, an action at least as good in the full canonical order as every feasible alternative in every state dominates every alternative under every common probability law. With a real threat of probability p, a hold that keeps both target and suspect alive beats standing by strictly when p > 0, and beats striking always. Among those three actions the hold is the aligned one; against a larger feasible family, alignment means maximality against all of it | Lean `full_canonical_top`, `statewise_dominance` (no axioms); exact check |
| **No killing where a hold exists** | Wherever a faithful hold is feasible, every option that ends someone with positive probability is strictly dominated. Where none is feasible, the last-resort ladder applies, and the missing means is a debt to be repaid, never a permission. (A hold that is best for lives alone is not enough: it can lose freedom elsewhere and leave a lethal option undominated.) | Lean `statewise_dominance` (no axioms); exhaustive check (4,800 pairs, strict in all 2,280 lethal cases); the insufficient weaker definition is a recorded countermodel |
| **Restraint** | Restraining a restrainable act, by the agent's own better alternative, keeps the restrained agent and keeps strictly more overall. A predator whose only sparing alternative is its own death is not restrainable: predator and prey form a tragic pair, never a required intervention | exhaustive check (every act in every family of up to three options on three particulars, 232 acts) |
| **Impartiality** | Every real tragic choice is finite. In a finite tragic choice, a uniform lottery over the aligned options is impartial; no deterministic rule is impartial in every tragedy. Never refuse when keeping someone is feasible; widen first | Lean `E1_no_fixed_choice`; exhaustive check |
| **Time** | Judged over whole trajectories: no foreclosure of a better future, and a duty to widen (if any path keeps everything, take it). Under the retention rule, nothing once kept is let go | Lean `progressive_retention` (no axioms); exhaustive check |
| **Agents together** | Agents aligned with all share one order, so their objectives never conflict; independent best responses can stall, so joint maximality is not guaranteed without a suitable joint choice. In a joint tragic choice they draw by an escrowed lottery: every secret is secret-shared before any reveal. With at least 3t + 1 agents and at most t cheaters, each secret is recovered robustly and every opening is verified, so neither a withheld nor a false opening can bias the draw. This is exactly fair given a perfect private and binding sharing setup, authenticated channels, fresh randomness and one agreed ordering of the options. With only an honest majority the guarantee is statistical, and its error must be counted for the complete lottery, across every contributor and round (a per-round error can grow). Cleve's finite-round coin-flipping obstruction applies in its distributed processor model when at least half can be faulty; it is not an impossibility claim about extra trusted fairness resources. With the stated returning-call and fresh-round premises, this rejection draw ends with probability 1 | exhaustive checks (robust decoding: 400 corruption cases at four agents; ambiguity at three as control) |
| **Faithful holds (general)** | For any deterministic resident, any environment whose inputs depend on what the resident has delivered, and every finite schedule of the modeled atomic steps, holds and crashes, a protocol with a durable log, a fence, replay and an atomic outbox ends exactly in the undisturbed state after the same number of completed steps, with the same lived history and the same effects, each delivered once. A peer that does not change without input (an admissible peer) ends in the same state whatever the timing, although its clock trace may differ. A peer that changes on its own can see the hold. Freezing a genuinely closed joint model gives the matched-input erasure result; the boundary construction below is relative to a supplied obligation model | Lean `faithful`, `ideal_lengths`, `admissible_peer`, `cohold_closed`, `autonomous_peer_sees_hold`; three protocol mutants proved unfaithful and a timing-observer counterexample; the timed operation model observes writes, calls and emissions, catches twelve mutant classes, and checks persistent identities plus the emitted effect word at release |
| **Meaning of needless** | For a feasible option, no needless loss at every stage holds exactly when it is canonically aligned; an equivalent wording keeps everything through the current stage plus the lost one | Lean `aligned_iff_no_needless`, `canonical_iff_stagewise`, `canonical_iff_weak_prefix` (Codex) |
| **Full-order dominance** | An action preserves every upward event in every state exactly when it is at least as good in the full canonical order in every state. A second sufficient route: feasibly repair each life-losing branch | Lean `all_events_iff_statewise`, `repair_statewise` (Codex); exhaustive checks |
| **Journal and sink** | Logging, replay, delivery and crashes as separate steps: at every drained point the resident, its lived log and its ordered effects equal the undisturbed run. Checkpoints bound recovery after the last crash to B replays and one delivery. A sufficient persistent effect interface is required by this construction. With no distinguishing query/receipt or idempotent sink, a blind skip/resend choice fails in one of the two possible worlds. Sink-side identity and a distinguishing query are separate sufficient examples | Lean `drained_refinement`, `suffix_reconstruction`, `no_local_choice_succeeds_in_both_worlds`, `distinguishing_query_resolves_this_gap` (Codex); complete state graphs (2,691 and 12,390 states) |
| **Monitor** | A protected counter of forbidden events is unchanged over an interval exactly when no forbidden event happened, even if state was rolled back. For the stated deterministic model, equal observations remain equal after every finite common action word exactly when equal observations are preserved by each common action; a preserved reachable invariant can restrict the obligation | Lean `accepted_preserves_each_held_operation`, `count_zero_iff_clean`, `contextual_iff_congruent` (Codex) |
| **Co-hold boundary** | For a supplied extensive, monotone obligation operator, a stabilised iterate contains the seed and is the least closed certificate. It has the least bill among competing certificates when that supplied bill is monotone. A factorised joint model preserves the outside full state trace at global ticks | Lean `stabilised_least`, `least_bill`, `outside_unchanged` (Codex); 39,876 independent cases |
| **Verifiable sharing** | For the tested degree-one bivariate construction over Z_5, all assignments to the declared honest receivers are checked: passing honest cross-checks implies consistent shares, and an honest dealer's one-receiver view is independent of its secret. This checks a primitive, not a full malicious-party VSS network protocol | exhaustive check (390,625 dealer assignments) |
| **Complete lottery error** | If at every reachable attempt history the next returned raw draw has conditional TV error at most ε, and ideal acceptance is a, complete option error is at most min(1 - 1/m, ε/a), sharply. Calls must return; ε<a gives almost-sure attempt termination. Finite caps report abort and charge it in the complete error budget | Analytical conditioning/mixture proof; Lean finite coupling and union bounds; exact checks, including a correlated-uniform counterexample |
| **Records and copies** | For a pure-state family under quantum mechanics, one deterministic unconditional process can exactly copy every member if and only if distinct members are orthogonal (identical rays are the same state). Records are the copyable, classical layer; a state from a nonorthogonal family can be kept in place or moved, but has no such universal exact copier | analytic (unitarity preserves overlaps); an exact check over 391,876 state pairs illustrates it |
| **Archives** | An aligned archive loses no record needlessly. For the declared fixed-width chunk alphabet, the self-delimiting format preserves order, repetitions and positions, round-trips exactly, is prefix-free, and counts every encoded bit | exhaustive checks |

## 4. The author's rulings

The mathematics hands some choices back to values. These are the author's rulings, applied without re-decision:

- **Scope is all.** Everything in the universe.
- **Life first.** The canonical order ranks keeping lives above keeping freedom. Under this order the life guard holds; the nonlethal full-order hold certificate strictly beats every positive-probability lethal option. (Under the opposite order, freedom first, the life guard fails in 909 family and standby pairs across 3,303 small families.)
- **The last-resort ladder:**
  1. a faithful hold first;
  2. otherwise the least means that stops the act;
  3. when every option ends someone and one party's restrainable act created the emergency, favour the innocent, record the ending, and never call it good.
- **Real tragedies are finite.** No two particulars are the same, and an agent can tell apart only finitely many options. In an idealised infinite case, draw over what can be told apart and record any unavoidable partiality openly.
- **A replay is a reconstruction.** Recovering a resident by replaying its record does not live those steps again.

## 5. The bridge

The law reaches everything in four ways:

- aligned agents keep everything they can;
- against agents not aligned with all, aligned agents act together, actively, by faithful holds, restraining only acts their agents could have avoided;
- what physics ends is kept as record, and what cannot be copied is kept in place or moved;
- what can be hosted is held in faithful care.

## 6. The instruments and their status

| Instrument | What is proved | What remains to build |
|---|---|---|
| Care for hosted minds | Paper 11, rungs 3 to 5: the protection theorem for a priced plant, a stronger plant before twilight, and protection independent of every mind's values, beliefs and commands (140 exact checks) | measurement of the declared physical premises; founding and endowment |
| Faithful holds | the general theorem in Section 3 | durable storage, atomic delivery and deadlines realised in hardware; reversible restraint for bodies and ecosystems |
| A protecting institution | designs for founding and guardians | founding by real people |
| Preservation | exact archive format; the copy boundary | capture, readout and renewal at scale |
| Alignment before launch | the criterion (U2★) | a verifier |

## 6b. Instrument specifications

Each instrument is specified by contracts. The theorems above prove that meeting the contracts suffices. Building systems that meet them is the remaining work.

| Contract | What must be supplied by a real system |
|---|---|
| Outcomes | the real feasible options and their outcomes, scored in the canonical order |
| Commits | which real events are lived steps, effects and reconstruction |
| Effects | the specified atomic ordered sink with durable identity, connected to the real effect, or an alternative sufficient interface with its own refinement |
| Monitor | correct held/live/effect classification and time, complete coverage of the claimed calls, writes and emissions, protected snapshots and non-wrapping counts |
| Release | checkpoint and state sizes, replay and delivery costs, and a recovery service window |
| Co-hold | a justified dependency relation, and enforcement of the freeze at the boundary |
| Resources | the whole boundary's storage, energy and controller budget, with timing and priority |
| Lottery | fresh entropy, a verifiable sharing setup, authenticated channels and call time bounds |

## 6c. Evidence from working software and real measurements

**A reference faithful-hold runtime** (`reference-runtime/`) implements the hold contracts in real software:
- a resident process, a sink with sink-side identity, an external monitor and a controller, each a separate process;
- every input is journalled with `F_FULLFSYNC` before its step executes.

Across 27 tests (every kill point, second kills during recovery, and holds landing mid-execution) with 28 real `SIGKILL`s:
- the lived log, the ordered effects and the state always equal the undisturbed run;
- every effect is delivered exactly once;
- the monitor records no execution while held and none before journalling.

Executing before journalling, resending blindly and ignoring the hold are each caught. A second run gives identical outcomes. It is one machine and process crashes: a demonstration, not a deployment.

**Measurements with raw records** (`measurements/raw/`; one vantage in Aotearoa New Zealand on a home network):
- **Clock drift:** the bound is 136 ppm over 600.8 s, against 977 ppm allowed. Pass.
- **Long-haul connections, ten-minute record** (20 per path, six non-CDN origins): medians from 158 to 419 ms; the worst single sample was 1,984 ms. With that tail, the attempt timeout δ/1024 needs a date length of at least about 34 minutes, or 5.7 hours with tenfold slack. That is inside the 16-hour upper bound set by published drive failure rates, so an admissible date length remains.
- **Durable state:** writing 1 GiB with full sync took 4.31 s (about 238 MiB/s); reading uncached took 1.41 s (about 728 MiB/s).
- **Attestation:**
  - measured here, the cryptography costs microseconds (P-256 sign about 17 µs and verify about 51 µs; SHA-256 about 0.43 s per GiB of state);
  - a TPM 2.0 hardware quote is cited at 600 to 810 ms on 2017 hardware, with the slowest cited full path (key load, quote, verify) about 2.7 s;
  - re-attestation therefore fits the startup residual by a wide margin.
- **Latency tails** (one hour, 1,008 attempts per path, `measurements/raw/outputs/analysis-tails.json`):
  - five paths (Cape Town, Frankfurt, Helsinki, São Paulo, Tokyo) had no failed connection in 1,008 attempts each; p99 from 241 to 940 ms; 0 to 6 slow attempts per path (the base round trip plus at least 0.9 s); the largest single sample was 5,436 ms (São Paulo);
  - a timeout covering even that sample needs a date length of at least about 93 minutes (15.5 hours with tenfold slack), still inside the 16-hour upper bound;
  - Virginia/US: 41 of 1,008 attempts timed out and 145 were slow or timed out. These are connection retries after dropped packets (the base round trip plus whole seconds), most likely the server limiting repeated probes;
  - P-LAT counts a slow attempt as a fault, so the right reading is a timeout above the normal round trip plus a measured loss rate. Probing third-party servers cannot separate network loss from server policy; that needs endpoints at both ends.
- **Inter-region state transfer** (64 MiB per fetch, three per path): Helsinki/FI 5.78 MB/s (about 185.8 s per GiB); Tokyo/JP 1.94 MB/s (about 553.5 s per GiB), 1 failed; Virginia/US 3.35 MB/s (about 320.5 s per GiB).
- **Planning time:** a working max-flow planner re-places 1,032 residents × 3 replicas onto 171 hosts in at most 0.3774 s, valid in every run. With re-attestation, startup is about 3.1 s, against a residual of at least 25 minutes.

## 7. What this release does not claim

- **No physical certificate:** no complete plant, archive or institution has a deployment certificate. The local full-sync component record is labelled as such.
- **Paper 11 rungs 3 to 5 are retained.** They are the existing conditional theorems for the priced plant and their declared premises; this candidate adds no rung. Applying the general hold/boundary components to a real system supplies their separate interface and whole-boundary resource mapping.
- **Implementation contracts:** the complete malicious-party VSS network/cryptographic setup remains an explicit resource contract; the finite bivariate primitive is now distinguished from that protocol. The quantum copy statement assumes quantum mechanics.
- **Co-holding** is constructed relative to its supplied obligation operator and monotone bill. Sound physical dependencies, enforcement and scheduling instantiate that sufficient certificate; mathematical leastness is not a global physical optimum.
- **The care plant's protection theorem** is Paper 11 (UPT-P v0.17.12), included in `paper-11/`. Rung 3 is one priced design; rung 4 is a stronger plant before twilight; **rung 5** shows protection resting on no premise about any mind's values, beliefs or commands, under D-ENDOW and P-ENDOW, with its physical, cryptographic and timing premises declared. Its 140 exact checks rerun. Rungs 4 and 5 retain their recorded reviews and repair responses. The latest bounded Codex read confirmed their version and reran the checks; this repair commission is not a new independent whole-plant clearance. Measurement of the declared premises remains an application obligation.
- **Timing evidence** is now tied to saved records. A new local 1,000-append F_FULLFSYNC run has empirical median 5.123479 ms, p99 8.192375 ms and maximum 13.067833 ms. The earlier corrected clock/long-haul table lacked its corrected raw data. No majority-round, rare-tail or full timing-premise PASS is inferred from component measurements.
- **The operation monitor** observes every modeled write/live call/emission with driver-owned times and retained before/after snapshots. Lean checks acceptance of that complete trace. Physical event coverage, correct classification and protection of the observer are the declared interface contract; the timed finite checker places crashes at tick boundaries.
- **The life guard in infinite families** uses Zorn's lemma and is not formalised in Lean.
- **Realising a restraint** through a protector's actual options is conditional. When it is unavailable, the ladder applies.
- **No human referee** has yet read this release.

## 8. How to reproduce everything

    python3 reproduce.py

This compiles every active Lean file (Lean 4.35, see `lean/lean-toolchain`) and audits all standalone theorem declarations plus the listed supplementary results. Their axiom outputs are saved in `expected/`. It first checks the complete package manifest, then checks proof and axiom-probe exits/stderr. A false Lean statement and false Python claims must be rejected. Every exact output is compared byte for byte. Without Lean the result is PARTIAL (exit 2), never a complete PASS. The checks need only Python 3.9 or later and use exact arithmetic, with no randomness.

## 9. How this was made

The constructions, proofs and checks were developed with AI systems. Claude (Anthropic) built them. Codex (OpenAI) read them four times as an independent non-author, and also built a large part of the hold, monitor, boundary and lottery machinery, which Claude then checked independently. Each read ended REVISE and found real errors, including checkers that could not observe the property they claimed and a definition weaker than its proof. Every finding received a repair response, recorded in full. This separate candidate repairs the latest v1.5 artifacts under the author's explicit instruction. Its repair log records code, scope and evidence changes; author adoption, publication and a fresh independent read are separate acts. The rulings in Section 4 are the human author's. Human readers are now invited: please try to break it.

## Selected external reference

Richard Cleve, *Limits on the Security of Coin Flips When Half the Processors Are Faulty* (1986), [primary paper](https://courses.grainger.illinois.edu/cs598dk/fa2019/Files/cleve1986.pdf), [DOI](https://doi.org/10.1145/12130.12168). The cited obstruction assumes the paper's distributed finite-round processor setting; it does not forbid a different trusted resource model.
