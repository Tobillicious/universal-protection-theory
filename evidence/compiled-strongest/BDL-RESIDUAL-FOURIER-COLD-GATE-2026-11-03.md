# BDL level-2 residual Gibbs: exact quotient Fourier elimination and a constructive cold-regime acceptance gate

Date: 3 November 2026
Status: **proved finite-code identity + size-dependent cold-regime exact sampler certificate; fixed-temperature/family-wide M5 still OPEN**.
Stacking: this PR is based on draft PR #218 (disjoint local spheres), which depends on #216 (symbolic kernel) and #215 (source-cell reconstruction). It edits no earlier file. Exact test: tools/bdl_residual_quotient.py.

Primary source: Balasubramanian, Davydova & Lin, *A passive self-correcting quantum memory in three dimensions*, arXiv:2605.10943v1, §§2–3. This mathematical reduction concerns the GF(2) syndrome law of the reconstructed algebraic two-level Tanner complex at arbitrary integer subdivision L≥1. The source's random geometric-embedding parameter and physical encoded initialization are NOT certified by this calculation.

## 1. Exact quotient-Fourier elimination

Let A_full be a complete full-rank parity presentation of the **actual** hard sector of the level-2 reconstructed code. PR #218 gives disjoint independent spherical relation rows with support S_1,...,S_c, each of size s. Extend these to a basis of row(A_full) using d additional independent residual rows R_1,...,R_d. Thus

    row(A_full) = U_loc ⊕ V_res;
    U_loc = span(S_1,...,S_c),  dim U_loc = c;
    V_res = span(R_1,...,R_d),  dim V_res = d.

This direct sum is **of parity-check row spaces**, not an assumption that the physical syndrome Gibbs distribution factorizes.

For the equal-energy commuting-stabilizer Gibbs syndrome law, let z=e^(−β), take 0≤z≤1 and define t=(1−z)/(1+z). Write m for the total syndrome bit count and Z_full(z)=Σ_{x:A_full x=0} z^|x|. The ordinary binary character identity gives

    Z_full(z)
      = (1+z)^m 2^(−c−d) Σ_{v∈V_res} Σ_{u∈U_loc} t^|v+u|.

Every u∈U_loc independently chooses whether to flip each **disjoint** sphere block. For a fixed residual dual word v define b(v) as the number of its occupied coordinates outside all local spheres, and a_i(v)=|v∩S_i|. The 2^c local choices sum *exactly*:

    Σ_{u∈U_loc} t^|v+u|
      = t^b(v) Π_i [t^a_i(v) + t^(s−a_i(v))].

Consequently,

    Z_full(z)
      = (1+z)^m / 2^(c+d) · Σ_{v∈V_res}
          t^b(v) Π_i [t^a_i(v)+t^(s−a_i(v))].

For the local-only Gibbs law ν constructed in PR #218, the complete local partition is

    Z_loc(z)
      = (1+z)^m 2^(−c) (1+t^s)^c
      = (1+z)^f Z_even(s,z)^c,

where f=m−cs and Z_even(s,z)=[(1+z)^s+(1−z)^s]/2. Therefore the **exact residual acceptance probability** is

    P_z(B) := ν_z(A_full x=0)
      = Z_full/Z_loc
      = 2^(−d) Σ_{v∈V_res} t^b(v)
           Π_i [t^a_i(v)+t^(s−a_i(v))] / [1+t^s].

This is valid for ANY complement V_res; changing the complement reindexes the cosets and leaves the result unchanged. It removes all 2^c spherical dual combinations from the Fourier calculation. **It still contains 2^d residual terms** and, by itself, is NOT a polynomial algorithm.

At z=1 (t=0), the only nonzero summand is v=0 because V_res intersects U_loc only at 0. Thus P_1(B)=2^(−d). At z=0 (t=1), every term is 1 and P_0(B)=1. These reproduce PR #218's rejection barrier and the zero-defect limit exactly.

## 2. New monotonicity theorem

**Claim.** For any disjoint even-parity local blocks and any additional independent binary linear parity checks, the conditional acceptance P_z(B) is **nonincreasing in z∈[0,1]**. In particular

    2^(−d) ≤ P_z(B) ≤ 1.

**Proof.** Let t=e^(−u), u≥0. For any block of size s and a∈{0,...,s},

    g_a(t) = [t^a+t^(s−a)]/[1+t^s]
           = cosh((s/2−a)u)/cosh((s/2)u).

Write h=|s/2−a| ≤s/2. The u-derivative of log(g_a) is

    h tanh(hu) − (s/2) tanh((s/2)u) ≤ 0,

because x↦x tanh(xu) is nondecreasing for x≥0. So g_a increases with t. Every outside factor t^b also increases with t, and every term in the quotient-Fourier sum is nonnegative for 0≤t≤1. Hence P increases with t and therefore decreases with z, since t=(1−z)/(1+z). The endpoint values above give the bounds. QED.

This monotonicity does **not** prove the acceptance is polynomially large at a fixed physical fugacity. The unconditional lower bound 2^(−d) is exponentially small in d.

## 3. Stronger constructive cold-regime gate than naive Bernoulli rejection

The zero syndrome belongs to the full constraint kernel and has Gibbs weight 1. Since ν_z is normalized,

    P_z(B) ≥ ν_z(0)=1/Z_loc(z).

This elementary but decisive bound requires no knowledge of the other residual rows, provided they are homogeneous parity checks.

For c disjoint even-parity spheres of s bits each and f unconstrained coordinates,

    Z_loc(z) = (1+z)^f [Σ_{j even} binom(s,j) z^j]^c.

For every z≥0,

    (1+z)^f ≤ exp(fz)
    Σ_{j even} binom(s,j) z^j
      ≤ Σ_{j even} (sz)^j/j!
      = cosh(sz) ≤ exp((sz)^2/2).

Thus

    P_z(B) ≥ exp[−fz − c s² z²/2].                (★)

The second exponential uses the elementary inequality log(cosh x)≤x²/2 for x≥0; no cluster expansion or unstated independent-source assumption is used.

For the reconstructed level-2 BDL seed, the proven source-cell counts are

    c(L) = 8L² + 12L + 2
    s(L) = 8L(L+1)
    m(L) = 64L⁴ + 256L³ + 336L² + 160L + 24
    f(L) = m−cs = 96L³ + 224L² + 144L + 24
    d(L) = 3c+2 = 24L²+36L+8.

Define h(L)=ceil(sqrt(c(L))) and the **explicit rational cold fugacity**

    z_gate(L) = 1 / [f(L) + s(L) h(L)].

If 0<z≤z_gate(L), then fz≤1 and c s² z²≤1, so by (★)

    P_z(B) ≥ exp(−3/2) > 1/5.

Therefore the **explicit rejection algorithm** which draws exact independent local-sphere Gibbs samples (PR #218) and checks the ORIGINAL complete residual constraints has expected attempts

    E[attempts] = 1/P_z(B) < 5.

Every accepted output has the *exact* normalized FULL hard-sector Gibbs distribution, not merely the local surrogate. If the binary full-matrix membership test is computed by Gaussian elimination (polynomial in the level-2 system size m) and local rational samples use polynomial-bit coins, this is an **expected-polynomial-time exact full level-2 syndrome sampler at the stated size-dependent temperature**. A finite attempt cap must explicitly report failure, not silently alter the output law. An expected-runtime guarantee is not a deterministic worst-case deadline or complete pathwise-work certificate.

For L=1: (m,c,s,f,d)=(840,22,16,488,68), z_gate=1/568.
For L=2: (m,c,s,f,d)=(4760,58,48,1976,176), z_gate=1/2360.

The exact rational tests actually establish Z_loc(z_gate)<5 on these small formal scales; the analytical exponential bound supplies the all-L mathematical guarantee.

The crude direct unconstrained-Bernoulli rejection gate would require z=O(1/m)=O(L^(−4)) for constant expected acceptance. Conditioning the disjoint spheres first improves the **sufficient** asymptotic gate to z=O(L^(−3))=O(m^(−3/4)), with source-derived f and c. This does not assert optimality.

A weaker polynomial-expected-attempt condition is any **source-verified** z with fz + c s² z²/2 ≤ K log m for a fixed K, since then P_z(B)≥m^(−K). No statement about fixed-temperature polynomial acceptance follows.

## 4. Tests and exactness boundaries

Run from this stacked branch:

    python3 evidence/compiled-strongest/tools/bdl_residual_quotient.py

The source includes:
- the exact independent-check validation and quotient-Fourier formula using Fraction arithmetic;
- **four small independent linear systems**, five fugacities each, comparing the quotient formula against a distinct exhaustive enumeration of ALL 2^m syndromes, including z=0 and z=1;
- finite-grid monotonicity regression and endpoint identities;
- sampling of the exact local-only parity law, with every local parity checked;
- symbolic BDL counts for L=1,2,3,5,8 and explicit rational gate budgets;
- fully exact positive-fraction bounds 1/Z_loc(z_gate)>1/5 at L=1 and L=2.

Finite tests are independent receipts, not substitutes for the algebraic proof. In the large original model a complement basis must be generated from the complete actual δ map, not guessed from local spheres.

## 5. Critical remaining obligations

- **Fixed inverse temperature:** z_gate(L) tends to zero as L grows. For fixed z>0 this proof supplies no polynomial rejection bound; if further R_X/R_Z levels make m grow, the full-family condition requires a separate uniform source theorem. This is a **cold-scaling partial result**, not the physical warm-start M5 closure.
- **Full BDL source geometry:** published random-embedding parameters and actual physical placement of these code objects have not been installed or independently verified.
- **Physical quantum preparation:** a classical syndrome and Pauli preimage are not an implemented encoded logical-reference-preserving thermal state; correct encoder and hardware channels remain open.
- **Stability conditional:** full Gibbs sampling alone is not a decoder-stable event sample, though the previously proven source stable-event mass could be combined after an authentic RG predicate is implemented.
- **Pathwise resources:** running expected polynomially many classical coin and parity operations is not an unlimited hardware-work guarantee, and worst-case rare branches remain explicitly costed by a geometric tail.
- **X3 and founding:** original X3 is not weakened; physical installation, commissioning/founding and publication are unchanged.

Next serious advance: find a **fixed-temperature** residual conditional factorisation or source-uniform residual likelihood bound, rather than mistaking the cold gate for closure.
