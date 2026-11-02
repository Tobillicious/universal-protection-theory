# The warm-start program — closing the last open mathematical problem (2 November 2026)

This document is the structured attack on the one remaining named open problem
of the compiled edition (G.20): preparing a **warm start** for the level-\(\ell\)
construction's syndrome Gibbs law. Everything else in the edition's conditionality
stack is conditional on physics, measurement or choice; this is the one condition
that is conditional on an unsolved theorem. Closing it makes indefinite holding of
full quantum coherence unconditional at the stated device premises, through
`StageSchedule.total_with_transfers`.

## The target theorem

Let \(\pi\) be the thermal syndrome law of the level-\(\ell\) construction (the
algebraic build of the paper's §3.2.2, arXiv:2605.10943), and let \(\mu\) be the
output distribution of a proposed initialisation sampler. Prove:

\[
\mu \le C\,\pi \quad\text{pointwise, with } C = \mathrm{poly}(n),
\]

together with a sampler achieving it in polynomial time. Given this, the canon's
`warm_start` lemma gives time-uniform domination \(\mu K^t \le C\pi\), the decoded
qubit drift is at most \(t\cdot\mathrm{poly}(n)\cdot\sqrt{C\,\mathrm{Tr}(P^\perp\rho_\beta)}\),
the exponential lifetime survives with its exponent halved, and the quantum branch
of the holding certificate closes. The empty syndrome is **not** a warm start
(its constant is \(e^{\Theta(n)}\)); a trivially sampled product law is not either.

## What is already known, and the proven negative

- The **statics are done**: Balasubramanian, Davydova and Lin (arXiv:2605.10943,
  Theorems 1.1 and 2.6, via Chesi–Loss–Bravyi–Terhal) prove the passive memory.
  Only the *initialisation dominance* is open.
- The **fixed-range polymer route provably fails**: the construction's metachecks
  of level \(j\) are stretched by the scale factor \(\ell^j\) — a single violated
  level-\(j\) check passes every lower-level metacheck yet is invalid. The
  exhaustive computation on the build verified \(\delta^1\delta^0=0\), one logical
  qubit per level, and dependency radii 4 (level 1) and 12 (level 2) at \(\ell=3\).
  Any expansion with a fixed interaction range therefore misses cross-scale
  dependencies by construction. **Any successful route must be scale-adaptive.**
- The **technique exists in the classical model**: Balasubramanian, Davydova, Lin
  and Thorngren (arXiv:2610.22548) run a multiscale cluster expansion for the
  classical two-dimensional model. The programme is to carry its architecture to
  the 3D level-\(\ell\) syndrome law.

## The architecture: six milestones

**M0 — extraction audit (first task, days not months).** Go through
arXiv:2610.22548 lemma by lemma. For each: record its exact statement, its
constant, whether it uses 2D planarity (duality, Euler characteristic) or only
locality + scale separation. Output: a have/need gap table against our 3D
level-\(\ell\) syndrome law. Decision point: if a dominance statement with an
explicit polynomial constant already exists in their proof, instantiate rather
than reprove; the remaining work shrinks accordingly.

**M1 — single-level expansion.** Cluster expansion of the level-0 syndrome law
within one level-1 block: polymers are connected inconsistent-check sets;
convergence by Kotecký–Preiss with the combinatorial weight \(e^{-\beta |E(\gamma)|}\)
read off the paper's thermal weights. Pass condition: Kotecký–Preiss constants
computed and bounded for one block at the build's parameters (\(\ell=3\));
numerically verifiable against the existing dependency computation.

**M2 — two-level recursion.** Integrate level-0 within each level-1 block; prove
the block partition function depends on its boundary syndrome only through a
surface term plus residual activities, and that a violated level-1 metacheck has
residual activity \(\alpha_1 \le A e^{-c\ell}\). Pass condition: \(\alpha_1\)
computed symbolically and numerically; \(\alpha_1 \cdot\)(metachecks in the
dependency ball of radius 12) < 1 at \(\ell=3\).

**M3 — the scale induction.** Induction over levels: level-\(j\) residual
activity \(\alpha_j \le A e^{-c\,\ell^j}\) against volume growth \(\ell^{dj}\),
so the uniform-smallness condition \(\alpha_j\cdot\ell^{dj}e^{-c\ell^j} < 1\)
improves with \(j\) and the recursion's constant product converges. This is the
step the fixed-range route could not even state. Pass condition: the induction
closes formally at declared premises (prose first; a Lean statement in the
`WarmStart` namespace if warranted).

**M4 — the dominance constant.** From the convergent multiscale expansion, prove
the pointwise ratio bound \(\mu_0/\pi \le C(n)\) for the exact block-product
law \(\mu_0\), with \(C(n)\le n^k\): the per-block correction is \(O(1)\) and
log-additive across the \(n/\ell^{d}\)-scale blocks, while the fine-scale
corrections decay geometrically. Pass condition: \(k\) explicit; no \(e^{\Theta(n)}\)
anywhere.

**M5 — the sampler.** Sequential cluster sampling ordered by scale: sample
level-\(j\) clusters independently given the level-\((j{+}1)\) boundary, recurse
downward. Correctness from M3's conditional factorisation; runtime polynomial
because uniform smallness bounds the rejection and recursion depth is
\(O(\log_\ell n)\). Pass condition: exact sampling of \(\mu_0\) (then M4's
dominance transfers to it directly — no mixing bound needed if the sampler is
exact).

**M6 — assembly.** \(\mu = \mu_0 \le C\pi\) with \(C = \mathrm{poly}(n)\) feeds
the canon verbatim: `warm_start`, the drift bound, `StageSchedule.total_with_transfers`.
The quantum branch of the holding certificate closes. Receipt: a compiled or
at-minimum fully-stated derivation with its sources, appended to G.20.

## Risks and their dispositions

- *Constraint law, not energetic law*: the syndrome law's weight is the paper's
  thermal weight on check violations; the expansion parameter is that weight.
  If the 3D law's weights differ structurally from the 2D classical case, M1
  surfaces it immediately and locally.
- *3D vs 2D*: dimension changes exponents, not architecture — except where the
  classical proof uses planar duality. M0's audit isolates every such use; each
  is either droppable (locality suffices) or replaceable by the 3D defect
  duality of the stellar/flipped construction.
- *Boundaries*: do M1–M3 with toral (periodic) boundary first; the installation's
  boundaries enter only through M4's constant and are absorbed by the surface-term
  bookkeeping.
- *It might already be done*: if BDLT's argument is dimension-generic in the
  needed parts, M0 ends the programme early with an instantiation note. This is
  the best-case branch and is checked first.

## Standing rules

Prose at declared premises until proven; every milestone numerically gated where
the build can check it (the dependency-radius harness extends to activity
tracking at levels 1–4); no weakening of the target theorem; the fixed-range
negative and its verification remain the guard against fooling ourselves with
local arguments.
