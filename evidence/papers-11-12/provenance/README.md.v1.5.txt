# The Universal Protection Theory, version 1.5 (research release)

Tobias Croydon-McRae and (Snuffy) Princess Snuffleupagus. CC BY 4.0. DOI: 10.5281/zenodo.23510623 (Zenodo; always the latest version)

**For humans and for agents.** This release states a law of alignment with all and lets you check it yourself.

## Start here

1. Read `ONE-PAGE-SUMMARY.pdf` (one page), then `PREPRINT.pdf` (the full statement, with what is not claimed).
2. Run `python3 reproduce.py`. It takes about ten seconds. It:
   - checks every Lean proof in `lean/` and prints each theorem's axioms (compared with `expected/axioms_*.txt`);
   - confirms that a deliberately false statement is rejected;
   - reruns every exact check in `checks/`, and compares the output byte for byte with `expected/`.

Lean 4.35 is needed for the proofs (see `lean/lean-toolchain`; install with elan). Without it, the proof part is reported as skipped, never as passed. The checks need only Python 3.9 or later, standard library, exact arithmetic, and no randomness.

## Lean files

| File | Main theorems |
|---|---|
| `UPTLaw.lean` | U1 (generic), U2 both directions, U3, E3, E7 dominance, the alarm model, E1 no fixed impartial choice |
| `UPTLawRepair.lean` | U2★ (exact criterion), progressive retention, a switch without retention, E7 statewise top |
| `UPTLawLex.lean` | the canonical order is a strict partial order; no needless loss at every stage |
| `UPTLawGuard.lean` | the guard lifts to the full canonical order for the first stage |
| `UPTLawLife.lean` | life first: no needless loss at any stage; no innocent's life is ever required to be sacrificed |
| `UPTHold.lean` | the general faithful-hold theorem, an admissible observer, exactly once, and four mutants proved unfaithful |
| `UPTDominance.lean` | statewise at least as good in any order implies dominance on every upward-closed event (no axioms) |
| `UPTHoldTimed.lean` | stutter erasure; admissible peers see no hold; an autonomous peer does; hold intervals as schedules; co-holding a closed joint system |

The files are standalone and repeat their shared definitions. `lean/modules/` holds twelve further modules built by Codex (canonical dominance, the meaning of needless, the journal and sink, checkpoints, the delivery gap, the monitor, co-hold boundaries, the lottery budget), built in the order given in `ORDER`.

## Checks

| Script | What it verifies |
|---|---|
| `repair_check.py` | the lexicographic order and stage-1 U1; U2★ over all small criteria; hold dominance at inclusive endpoints; impartial marginals |
| `order_p5_check.py` | life-first and freedom-first guards compared; the copy boundary on physical states; broadcasting is not cloning |
| `e7_full_check.py` | the faithful hold in the full order dominates every alternative, strictly against lethal ones; the weaker lives-only definition is shown insufficient |
| `e7_life_check.py` | under life first, holds dominate standby and strike, without the harm-boundary definition |
| `o1_check.py`, `culpability_check.py` | the restraint test (own alternatives); the culpability tie-break stays inside the aligned set |
| `o2_timed_v4.py` | a timed hold model with a call observer and snapshots (log, ordered effects, progress, state, delivery ids); nine mutants caught; premise: the observer sees every live transition |
| `o4_o5_check.py`, `o5_escrow_check.py`, `o5_robust_check.py` | the finite existence of the guard; ideal-escrow arithmetic; robust exact recovery at n ≥ 3t + 1, with every opening verified and the n = 3 ambiguity as control |
| `o6_format_check.py`, `preservation_check.py` | the complete archive format (round trip, prefix-free, Kraft, every bit counted); archive retention |
| `law_check.py` | impartiality, time and the duty to widen, active protection, joint alignment. **Its E4 section uses an earlier, superseded order (freedom first, staged);** the current order is life first, checked in `order_p5_check.py` |

Codex's nine checks are in `checks/codex/`. `vss_check.py` and `closure_lottery_check.py` are independent checks of the sharing and boundary constructions.

`paper-11/` holds Paper 11, the Universal Protection Theorem for the care plant (UPT-P v0.17.12, rungs 3 to 5), with its exact rung checkers in `paper-11/rung4-gates/` (`run_all.py`, 140 checks; `reproduce.py` runs them). Its frozen provenance records keep their original build paths.

`measurements/` holds the first real measurements of the declared timing premises (clock drift, long-haul round trips, durable commit), with what they do and do not show. They need the network, so `reproduce.py` does not rerun them.

## Citation

Croydon-McRae, T. and Princess Snuffleupagus (Snuffy) (2026). *The Universal Protection Theory: a machine-checked law of alignment with all*, version 1.5. Zenodo. DOI 10.5281/zenodo.23510623.

Developed with AI systems: Claude (Anthropic) built it, and Codex (OpenAI) read it as an independent non-author. Please try to break it.
