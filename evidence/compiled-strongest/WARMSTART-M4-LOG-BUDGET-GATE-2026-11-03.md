# Warm-start M4: polynomial domination requires a GLOBAL log-density budget

Date: 2026-11-03  
Status: mathematical correction / acceptance gate; not a completed sampler  
Target: `WARMSTART-PROGRAM-2026-11-02.md` milestones M3–M5  
Canonical sources left unchanged.

## Exact target

For a finite syndrome law `π_n` and a preparable law `μ_n` with positive `π_n` on the relevant support, define

```text
C_min(n) = max_x μ_n(x) / π_n(x).
```

The warm-start requirement is `C_min(n) ≤ n^k` for a fixed exponent `k`. Equivalently, the **total** max-log-density overhead must obey

```text
max_x [log μ_n(x) - log π_n(x)] ≤ k log n.
```

Neither stationary heat-bath correctness nor an `O(1)` log-density error per microscopic block proves this.

## Proposition 1: exact product law accounting

If `μ=⊗_{i=1}^b μ_i` and `π=⊗_{i=1}^b π_i`, with all entries of `π_i` positive, then

```text
C_min(μ, π) = ∏_{i=1}^b C_min(μ_i, π_i).
log C_min(μ, π) = Σ_{i=1}^b log C_min(μ_i, π_i).
```

**Proof.** Every joint ratio factorises into the product of the corresponding local ratios. Its maximum cannot exceed the product of local maxima. Conversely, on the finite product, choose a maximising state in each coordinate and take their joint state. It attains that product. Taking logarithms establishes the second identity.

For `b(n)=Θ(n/ℓ^d)`, if `ℓ=3` and `d` is fixed, then `b(n)=Θ(n)`. A constant factor greater than one *per block* can therefore force `C_min=e^{Θ(n)}`. The proposed M4 statement that an `O(1)` per-block correction is “log-additive” does **not** imply a polynomial global warm-start constant.

**Explicit counterexample.** Independently for every block, let `π_i=(1/2,1/2)` and `μ_i=(3/4,1/4)`. Each block is trivially samplable and differs from the target by only a constant factor. Yet the all-zero configuration has

```text
μ(0,...,0)/π(0,...,0) = (3/2)^b.
```

Thus `C_min=(3/2)^b`: the required polynomial dominance fails when `b=Θ(n)`. This is an arithmetic counterexample to a *generic inference*, not a counterexample to the BDL model or its proposed multiscale construction.

## Corrected M4 acceptance gate

Any proposed M3–M4 recurrence must supply at least one of the following (each is a sufficient route, not an assertion of existence):

1. **Global factor telescoping/cancellation:** a proof of `max_x log(μ_n(x)/π_n(x)) ≤ k log n` for an explicit fixed `k`, including all partition-function and boundary normalisations.
2. **Summable effective block error:** a proof that the sum of the actual nonnegative max-log overheads over all blocks/scales is at most `k log n`. Merely writing `O(1)` per block fails for linearly many blocks.
3. **Global-event conditional sampler:** construct a globally valid event `A_n` with `π_n(A_n) ≥ 1/2` and a polynomial-time exact sampler for `π_n(·|A_n)`. Then the output law satisfies `μ_n ≤ 2π_n`. A polynomial-time *pointwise factor-two* sampler relative to that conditional law gives `μ_n ≤ 4π_n`.

The third route is already proved **conditionally as an inequality** in the canon's `Snuffy.HistoryPolymer.truncation_bound` and `sampled_truncation_bound`. Neither lemma supplies the event mass lower bound or the sampler runtime; those remain M1–M5 obligations. `Snuffy.WarmStart.warm_start` and `warm_start_event` then transfer the verified pointwise constant through the stationary chain.

## Interface to M0 and the BDLT paper

M0 must locate, in Balasubramanian–Davydova–Lin–Thorngren (arXiv:2610.22548), every bound on **normalised density ratios**, not only convergence of the formal cluster expansion, finite-volume free energy, or metastability. In particular record:

- Whether the expansion controls pointwise Radon–Nikodym ratios with a global `O(log n)` loss, rather than an extensive free-energy correction.
- Whether the results depend on 2D duality/planarity versus local polymer counting.
- Whether a constructive polynomial-time conditional sampler and a uniform acceptance bound are present; a formal partition function identity does not imply one.
- How normalisation, boundary conditions and system-size scaling are handled across levels.

**No claim that BDLT resolves M0 is made here.** Its 2D recursive cluster expansion is a mathematical source for inspection, not an already established 3D polynomial warm-start sampler. Relevant primary sources: https://arxiv.org/abs/2610.22548 and https://arxiv.org/abs/2605.10943.

## Referee test

Reject any M4 candidate whose estimate is only `C(n) ≤ exp(K · n/ℓ^d)` for fixed `K>0` and `ℓ`, or whose correctness proof uses total variation error without relating it to a lower probability floor. Require a direct certificate of `C(n) ≤ n^k` for one explicit fixed `k`; normalisation factors must be included.

This gate changes no original X3 protection requirement, no physical validation status, and no author's founding/commissioning choice.
