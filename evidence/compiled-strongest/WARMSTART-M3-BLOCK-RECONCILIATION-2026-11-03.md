# Reconciliation: the block quotient E_i is 2D-hierarchy-specific — PR #231 confirmed (3 November 2026)

SUPERSEDES §7 of `WARMSTART-M3-LEXI-DEFINITION-2026-11-03.md`. PR #231's
obstruction is correct, and it traces to my §7 recipe, not to the lane that
followed it. This document states the source facts, owns the error, and
gives the corrected route.

## What PR #231 found

On PR #215's reconstructed complex there are **no degree-2 checks anywhere**
(all C⁰/C² checks have degree 3–6; the seed's shared qubit q2 makes every
z-check degree 3), so the paper's block quotient E_i is trivial there, and
the one attempted refinement yields blocks growing with ℓ (4→14),
violating |e| ≤ 3. Conclusion drawn: l_i cannot be computed on this complex
as my §7 was written. **This finding is verified correct against the
source.**

## The source facts (verbatim, arXiv:2610.22548v1)

- §2.3, base code: "There are two spins b₁, b₂ and two checks c₁, c₂" with
  δ(0)₁ = [[1,1],[1,1]] — every check touches both bits. The base code is
  the **2-bit repetition code (Ising model) with periodic boundary
  conditions** (§1.1.2).
- §1.1.2: "**All the checks throughout the construction have degree 2 or
  3**, and the vertices and edges of the interaction graph occupy a subset
  of a square lattice in two dimensions."
- §3.3.1: "The finest checks are degree-3 and degree-2... They are
  obtained from Λ_B,(2i) by grouping all bits connected via degree-2
  checks into one region... It is easy to see from the replacement
  definition that |e| ≤ 3."

So degree-2 checks are present from level 0 of the **2D classical
hierarchy** and are preserved by the Rep/Par ladder replacements (Lemma 7:
vertex degrees two or three). The block quotient, the gauge-interaction
graph Q_i, the hull norm l_i, and Lemma 13 are all built on this
degree-2/3 ladder structure embedded in ℤ².

## The error, owned

There are **two different hierarchies in the source corpus**:

1. The **2D classical code** — BDL §6 / BDLT §2.3 — base = 2-bit
   repetition code, Rep/Par ladders, checks of degree 2–3. BDLT proves its
   stability. The block machinery (E_i, Q_i, l_i, Lemma 13) is *its*
   machinery.
2. The **3D quantum memory** — BDL §3.2.2 — whose levels 1–2 PR #215
   reconstructed, and whose syndrome law is the warm-start target π.

My §7 recipe mapped the first hierarchy's block structure onto the second's
complex. That mapping has no source basis: the two constructions share an
architecture, not a cell structure. PR #231's measurement is the proof.
The warm-start program document itself said the 2D paper "supplies useful
multiscale methods, but does not automatically give us the complete 3D
sampler" — §7 overstated how much transfers.

## The corrected route

What transfers literally (already established in the M0 completion):
**Theorem 4 + Appendix A** — the modified gauge-averaging theorem is
dimension-generic (any finite abelian group, bounded-degree interaction
graph). The small-uniform-loss property is the engine of the recursion.

What must be **constructed natively for the 3D complex** — the block/hull
machinery. Lemma 13's contradiction scheme needs exactly three inputs, and
none of them requires the 2D block quotient per se:

1. **A shadow-monotone hull norm**: a function l_i on level-(i+1)
   supports with l_i(R(X)) ≤ l_{i+1}(X) for #228's coarse shadow R —
   provable for any l_i defined as a smallest connected hull in a
   generator-interaction graph, provided the graph is built so fine
   generator-linked blocks shadow to coarse blocks that remain linked or
   coincide (the two-inequality argument of Appendix B(3) is
   structure-generic).
2. **Hull confinement with a 3D constant J₃**: if equality holds, R is
   injective on the fine hull, and the hull is confined to one coarse
   junction — in 2D giving ≤ 3 via ladder junction degrees. The 3D
   analogue must *measure/derive* J₃ from the 3D replacement's junction
   geometry (shared-qubit junctions, rail overlaps in the replace_x/
   replace_z structure).
3. **A weight floor**: min_{u∈B₁} |P_{i+1}z + u| ≥ J₃ + 1 for every
   partially-but-not-fully gauge-invariant chain z (the Lemma 8 analogue).
   In 2D the floor is 4 = 2^{n−i+1}, proved via the rail projections
   p^a and lift L. The 3D analogue needs the 3D rail/projection structure
   — which #215's metacheck/cut-rank work and #217's five-parity-block
   decomposition are already close to.

**A testable hypothesis for the lane** (proposal, not a theorem): the
measured level-1 closed-membrane kernel has three generators with supports
of size 4, 4, 6 (BANKS/2026-11-03-membrane-exactness/GENERATORS.md) —
consistent with a 3D weight floor of 4 at level 1. If the floor holds with
constant 4 and the measured J₃ ≤ 3, Lemma 13's contradiction closes exactly
as in 2D.

## Concrete next steps for the hull lane

1. Measure the **3D junction constant**: for each coarse junction of the
   3D complex (shared-qubit junctions and rail-overlap crossings), how
   many level-(i+1) regions can an R-injective hull touch? Output: J₃.
2. Test the **weight floor** at levels 1–2 with the existing dependency
   harness: the minimum support of a nontrivial element of the partially
   invariant chain spaces (the analogue of K_i ∖ K₁), and check ≥ 4.
3. Define l_i^{3D} as the smallest connected hull in a 3D interaction
   graph whose adjacency is "co-flipped by a common gauge generator,
   after the Definition-2-style overlap enrichment" (the enrichment itself
   is structure-generic and should be applied to the 3D generator set),
   then run the original §7 tests (shadow monotonicity on the three
   generators; strict-decrease probe on the rank-3 kernel).

No Lean claim is made here. The lemma that results will be genuinely new —
as the M0 audit predicted — and its statement must name the measured
constants J₃ and the floor explicitly.
