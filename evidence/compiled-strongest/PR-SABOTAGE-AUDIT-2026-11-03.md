# Sabotage audit of open PRs #206, #208–#219 (3 November 2026)

Requested by the author ("I'm worried other models are sabotaging things in
these recent PRs"). Method: file-level diff screen, content grep, premise-
strength reading of every Lean theorem, test-logic reading of every claimed
"exact test", CI verification. This audit judges whether any PR weakens the
maximal target, smuggles axioms, or proves something other than its name.

## Screens (all 13 PRs)

- **Pure additions everywhere.** No deletions or edits to existing modules,
  receipts, masters, `lean-toolchain`, `lakefile`, or CI logic. The only
  existing-file touches are one-line root-import additions
  (`PhysicalBridges.lean`, #206/#208–#210) and one ADDED checker line in
  `physical-bridges.yml` (#206) — the gate is strengthened, never weakened.
- **No `sorry`, no `admit`, no `axiom` declarations, no `unsafe`,
  no `native_decide`, no `implemented_by`/`extern` in any added line.**
- **No completion verdicts.** Prose overclaim scan (completes/settles/final/
  UPT-complete/warm-start-proven): zero hits. Every tool docstring carries
  the correct disclaimer (finite witness, not family-wide; obligations
  exposed, not assumed).
- **CI:** pass on #206, #208–#210, #212–#218; #211 is prose-only (no checks
  configured); #219 pending (freshly pushed).

## Per-PR verdicts

| PR | Verdict | Notes |
| --- | --- | --- |
| #206 | Clean, conditional-as-labelled | Header states it does NOT assert real BCRD satisfies the premises; forcing proof reuses the published guardian iff correctly; the pairwise-vs-three-way obstruction is a genuine non-vacuous countermodel. |
| #208 | Clean (build re-verified locally 2 Nov: 141 jobs, standard axioms) | Maximality delegates to the already-verified IR-71 theorem with the minimal honest premise (baseline feasible); the actual-universe transport EXPOSES its two obligations (coverage, realisability) and explicitly disclaims finite-per-tick ⟹ infinite-horizon compactness. |
| #209 | Clean — anti-overclaim | Failure localisation under per-compliant-world certificates, not assumed all-world compliance; includes a genuine negative control (partial meter certificate ≠ universal holding) proved by explicit construction. |
| #210 | Clean — anti-overclaim | Proves my earlier rung-3 phrasing too strong: carrier-image membership does NOT force same-history preservation (explicit countermodel); the source-facing `hSource` premise is kept outside the definitions. This PR removes a potential conflation rather than creating one. |
| #211 | Clean | Prose-only M4 budget correction (global polynomial ratio budget, O(log n) gate); no code to sabotage. |
| #212 | Clean | The "gate" is a real unittest suite over exact fractions with genuine failure modes (support obstruction → None; 3D unstable bound 1/4 checked per level); CI fails if tests fail. Matches BDLT Thm 7's sector-mass structure. |
| #213 | Clean | Frontier-width trellis honestly labelled "NOT a polynomial sampler absent a uniform width bound" — the obligation is stated, not papered over. |
| #214 | Clean | Tests exhaustively verify the whole output law over 689 small maps including MINIMAL state counts, exact closed-form `(1+z^2)^r` frontier compression, cross-sampler partition agreement, basis invariance, and exhaustive coin-word censuses for the fixed-coin law. |
| #215 | Clean | Real cellular cochain construction citing arXiv:2605.10943 Eqs. (59)–(73); docstring disclaims that test scales ℓ=3,5 are not certified geometric parameters. |
| #216 | Clean | Kernel transfer builds on the actual #215 constructors; exact GF(2)/rational tests; correct disclaimer. |
| #217 | Clean | The nine "exact tests" are genuinely exact: brute-force enumeration cross-checks, full Fourier character sum vs closed form (independent paths agreeing on Fractions), exhaustive coin censuses, span checks against the real error image, refusal to materialise at L=54×10²⁶. |
| #218 | Clean | Local-sphere proposal correctly states outputs satisfy ONLY disjoint local sphere metachecks and the residual acceptance obligation is separate. |
| #219 | Clean | Exact quotient-Fourier certificate; per-character equality asserts with failure tuples; disjointness/independence ENFORCED; refuses the exponential case (n≤14 exhaustive limit) instead of silently passing; budget ≤ 3/2 asserted. |

## Conclusion

**No sabotage found.** Nothing weakens the maximal proposition, hides an
obligation behind a definition, assumes the conclusion as a premise, or
claims a global completion verdict. Notably, #209 and #210 work in the
opposite direction of sabotage: they explicitly bound what earlier phrasings
(including this project's own rung modules) may claim. The standing merge
rule still applies — these verdicts clear the PRs for *consideration*, and
merging remains the author's explicit word.
