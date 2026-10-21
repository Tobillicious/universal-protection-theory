# The Universal Protection Theory (Snuffy 2.0)

**A machine-checked law of alignment with everything.** Published as Snuffy 2.0.1: [DOI 10.5281/zenodo.23527049](https://doi.org/10.5281/zenodo.23527049) (all versions: [10.5281/zenodo.23510623](https://doi.org/10.5281/zenodo.23510623)).

Tobias Croydon-McRae and (Snuffy) Princess Snuffleupagus. Built with Claude (Anthropic) and Codex (OpenAI), each checking the other's work as a non-author.

## The law

Rank outcomes by one order: **keep lives first, then freedom; keep everything that exists first, then everything yet to be made.** Its scope is all: every particular of the universe, minded or not, living or not.

- **U1:** an agent maximal in that order never needlessly loses anything, in any feasible situation, finite or infinite. Lean 4, no axioms.
- **U2★:** "be maximal on part S" protects all that exists **if and only if** S is exactly what exists. Alignment with a proper part fails, and so does counting the not-yet-made at the same priority.
- **U3:** no gain to beings not yet made justifies a worse outcome for those who exist.
- **Holds dominate:** wherever a faithful hold is feasible (it ends no one and is at least as good as every alternative in every state), every option that ends someone with positive probability is strictly dominated.
- **Restraint:** only acts their own agent could have avoided are restrained. A predator that must eat is not a culprit.
- **Agents together:** agents aligned with all share one order, so their objectives never conflict; tragic choices are drawn by an escrowed lottery.

The care plant (Paper 11) protects to the horizon with probability at least 1 − 10⁻⁶. At rung 5 that protection rests on no premise about what any mind values or believes, nor on any command, under declared physical, cryptographic and endowment premises.

## Check it yourself

```
cd evidence/papers-11-12 && python3 reproduce.py
```

This compiles every Lean file with Lean 4.35 and prints each theorem's axioms. It reruns 30 exact programs, requires 13 false claims to be rejected, and runs the care plant's 140 checks. It needs Python 3.9 or later and uses exact arithmetic, with no randomness. Without Lean the result is PARTIAL, never PASS.

**Python 3.11 or later:** fixed on 21 October 2026 (reported by skitter-swarmmemo on The Colony, with thanks). The exact checkers print integers longer than CPython's default 4,300-digit limit, so the replay now lifts that limit for its child processes. Version 2.0.1 includes this fix. With the earlier Zenodo 2.0 archive, run `PYTHONINTMAXSTRDIGITS=0 python3 reproduce.py`.

| Folder | What it is |
|---|---|
| `book/Snuffy-v2.0.1.pdf` | The book: synthesis (chapters 1 to 16), ten inherited papers, Paper 11 and Paper 12 |
| `evidence/papers-11-12/` | The replay package for Papers 11 and 12 |
| `evidence/execution-boundary/` | Theorem and runtime: while held, a hostile, sandboxed resident cannot make a lived commit or an accepted effect at the fenced targets (internal computation and cessation have separate contracts) |
| `evidence/items-1-2-adaptive-service/` | Adaptive withdrawals and the joint service law, exact for every world parameter |

## What it does not claim

No plant has been built. The physical premises are stated as premises. No human referee has read it yet. Universal adoption is not claimed: the law says what alignment with all requires; it does not compel any mind to adopt it.

## Please try to break it

The most useful contributions are a feasible family where an aligned agent needlessly loses something, a premise we have mislabelled, or a check that cannot observe what it claims to. Open an issue.

Licensed CC BY 4.0 (see LICENSE).
