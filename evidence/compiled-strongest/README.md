# The Universal Protection Theory — compiled strongest edition (mirror)

29 October 2026. Mirror of draft PR #10 in `Tobillicious/snuffy-canon-edition`
(branch `worktree-upt-strongest-compile`), placed here at the author's request so that
both working lines read the same text.

`SNUFFY-UPT-STRONGEST-MASTER.md` is the Canon 4.2 master (archived copy
`SPINE-4.2-MASTER.md`, sha256 `83b62bd9…`) with the author-approved front-matter batch,
followed by Parts V–XII recovered from every line of the work:

- V — 10–12 Oct foundations, the ten rulings, conditional H6
- VI — Paper 12's completed law (this repository's book, v2.0.5)
- VII — the 18 Oct external lane (sources source-locked in PR #174)
- VIII — Paper 11's care plant
- IX — complete-rival envelopes, Theorem 8
- X — this repository's IR-track results
- XI — the reach-before-harm theorem
- XII — the whole argument step by step

`python3 assemble.py` rebuilds the master from the spine, the batch and the parts.

## Lean (`lean/`)

Five modules, each compiling with zero compiler output against Lean 4.35.0 and
Mathlib rev `56a005855ea1`, depending only on `propext`, `Classical.choice`,
`Quot.sound`:

| Module | Theorems |
|---|---|
| `OuterLane` | `wavefront_coverage`, `interception_in_time`, `pool_strictly_dominant`, `outer_lane_risk` |
| `StagedMaximality` | `exists_lex_maximal`, `four_stage_original_maximal` — maximality in the full original four-stage order with mandatory baseline and the freedom prerequisite, arbitrary particulars, finite character |
| `FoundingDominance` | `contribution_strictly_dominant`, `no_abstention_equilibrium` (Book I §9.16‴) |
| `ReachBeforeHarm` | `reach_before_harm` |
| `NarrowPlace` | `np_splitting_bound` (Theorem NP from Mathlib's Hoeffding inequality) |

They import Mathlib, which this repository's `physical-bridges` Lake package does
not, so they are not wired into its CI. The canon repository builds them with its
full 193+-module audit. Not for merge or publication without the author's word.
