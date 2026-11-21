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


## 6. Exact *fixed-temperature* obstruction to LOCAL-only rejection (new all-L theorem)

The preceding cold gate is a partial positive result at temperature scaling with L. We can also prove a **uniform negative result** for the PARTICULAR local-only rejection strategy at every fixed 0<z≤1. It is not an impossibility result for efficient Gibbs sampling by other methods.

### Explicit source-cell endpoint relations

Let T be any source-valid Tanner square input whose X/Z common incidences are covered in even Q-pairs by Tanner squares. Form R_Z(T)=dual(R_X(dual T)). Its new X-check syndrome coordinates have three disjoint types: local doubled faces (xf,old-Z,face), old-qubit restriction edges (qe,old-Q,edge), and two old-X endpoint points (zv,old-X,t).

For **each old X vertex x∈V_X(T)** define the following parity row on NEW X-check syndrome bits:

    R_x :=
      { ("zv",x,0), ("zv",x,1) }
      ∪ { ("qe",q, edge((0,vertex(x)), (1,vertex(x)))) : q∈N_X(x) }.

This is a true metacheck in ker δ0_(R_Z(T)), NOT an imposed extra condition:

- On each new qubit of restriction-vertex type (qv,q,(t,vertex(x))), the endpoint point (zv,x,t) and the vertical edge (qe,q,e_{qx}) each contribute once, hence cancel mod 2.
- On each new qubit of local-star-edge type (xe,z,e), a vertical edge at x can receive contributions only from old qubits q common to x and z. The Tanner square condition pairs them in even multiplicity, hence they cancel mod 2. All other new qubits have zero selected incidence.
- Thus the incidence sum of R_x is identically zero, proving it belongs to the ORIGINAL full metacheck row space.

Distinct x have **pairwise disjoint supports**, since every coordinate carries its old X label x. Furthermore, every R_x consists only of qe and zv coordinates; the local spherical parity blocks of PR #218 consist entirely of xf coordinates. Hence R_x lies *entirely among the free Bernoulli sites* of the local-only Gibbs proposal, independent of all spherical factors.

Every R_x has length |R_x|=2+deg_X(x)≥2. Its support size need not be bounded to obtain the theorem.

### The uniform upper bound

Write p=z/(1+z) for the proposal's Bernoulli bit probability and t=1−2p=(1−z)/(1+z). On any m independent proposal bits, an even-parity check of weight w has exactly

    P(even) = (1+t^w)/2.

All R_x have disjoint supports, so their pass events are mutually independent under ν_z. Passing *all* actual metachecks B necessarily passes all these R_x. Therefore

    P_z(B)
       ≤ Π_{x∈V_X(T)} (1+t^(2+deg_X(x)))/2
       ≤ [ (1+t²)/2 ]^|V_X(T)|.          (†)

For the source-cell first replacement of the BDL [[5,1,2]] seed, parent PR #215 proves for EVERY positive integer L,

    |V_X(R_X(C_seed))| = 8L²+12L+4.

Hence for every fixed 0<z≤1, the base q(z)=(1+t²)/2 is strictly below 1, and

    P_z(B) ≤ q(z)^(8L²+12L+4)
           = exp[−Ω_z(L²)].

Equivalently the LOCAL-only rejection sampler has expected attempt count ≥q(z)^(−8L²−12L−4), exponential in L², *at fixed z*. This closes the generic temptation to use the exact disjoint-sphere proposal as a fixed-temperature full-sector sampler by naive rejection. It does NOT show all exact Gibbs samplers are inefficient, nor an asymptotic bound in the number k of alternating physical hierarchy levels.

The same result is compatible with the earlier size-dependent cold gate: when z=O(L^(−3)), the base q(z) tends to 1 fast enough that (†) need not force large rejection cost.

### Full finite incidence receipt

The program tools/bdl_residual_endpoint_obstruction.py explicitly constructs every R_x from the first-stage old X vertices, checks each has zero incidence against **every new qubit** in the full reconstructed level-2 matrix, checks disjointness from every true spherical block and from each other, and checks the source-cell count for L=1,2,3,4. Exact parity probabilities supply numerical upper bounds at z=1/3.

An independent diagnostic tools/bdl_residual_packing.py extracts the COMPLETE full metacheck kernel by GF(2) elimination, then greedily selects factor-disjoint residual relations. At L=1 it finds 24 independent free-only relations; at L=2 it finds 60. No local spherical factor is touched. Their supports contain 5,6 or 7 syndrome bits, and their exact product-pass probabilities give upper acceptance limits approximately 8.378377×10^(−8) and 2.127493×10^(−18) at z=1/3. These finite values are not the all-L proof; the **explicit R_x construction and Tanner incidence cancellation** are the all-L argument.

**Honest scope:** this is a theorem about rejection from PR #218's particular normalized LOCAL proposal on the algebraically reconstructed level-2 family at fixed fugacity. It does not exclude an efficient non-rejection sampler, source-specific cluster expansion, tensor-network contraction, or a fully coupled recursive conditional sampler. The real M5 fixed-temperature Gibbs construction remains OPEN.


### Exact all-L endpoint-weight multiplicities (strengthening of (†))

For the particular five-qubit seed, the preceding first R_X replacement has **two original X stars**, each doubled into two layers. Thus there are four copies of the same subdivided two-square disk X_x. Each sheet has two unit squares meeting on the central original edge x–q2, with vertices x,q0,q1,q2,z0,z1, seven original edges and two faces.

At subdivision L, every sheet's new X-check vertices classify by the number of incident new qubits (equivalently |R_x|−2):

- **Degree 3:** original x (1), and the 2(L−1) midpoint vertices on the outer original x–q0 and x–q1 edges. Thus 2L−1.
- **Degree 4:** the two original vertices q0,q1, the (L−1) midpoint vertices of the interior x–q2 edge, and 2(L−1)² interior subdivided-face vertices. Thus 2L²−3L+3.
- **Degree 5:** the three original vertices q2,z0,z1 and the 4(L−1) midpoint vertices on the four original q–z boundary edges. Thus 4L−1.

This classification counts planar subdivided edges, the doubled-star vertical seam edge at each q–z boundary vertex, and the extra q-restriction incidence. It is a direct source-cell vertex-category count, **not a polynomial extrapolated from L=1,2**. The three quantities sum to the sheet's 2L²+3L+1 vertices as independently counted in PR #215.

Multiplying by four sheets, the exact number of disjoint residual endpoint parity checks of lengths 5, 6 and 7 is

    N_5(L) =  8L − 4
    N_6(L) =  8L² − 12L + 12
    N_7(L) = 16L − 4.

They sum to 8L²+12L+4 = |X_1|. Consequently the *stronger closed-form all-L fixed-temperature bound* is

    P_z(B)
      ≤ [(1+t^5)/2]^(8L−4)
        [(1+t^6)/2]^(8L²−12L+12)
        [(1+t^7)/2]^(16L−4).             (‡)

Since for every fixed 0<z≤1 we have 0≤t<1, (‡) decays as exp[−Θ_z(L²)].

At z=1/3 (t=1/2), the exact rational products in (‡) evaluate at the two fully reconstructed test scales to

    L=1: approx 8.37837702056×10^(−8)
    L=2: approx 2.12749324717×10^(−18).

These agree exactly with the independent complete-kernel greedy packing products in tools/bdl_residual_packing.py. The source-cell code directly checks the N5/N6/N7 multiplicities for L=1,2,3,4 and checks every endpoint relation against the *full* level-2 matrices for L=1,2. The arbitrary-L statement is supported by the local vertex-type combinatorial proof above, not by those four tests alone.

**Scope remains precise:** (‡) rules out only naive full-constraint rejection from the LOCAL sphere-factored Gibbs proposal at fixed z. It neither supplies nor refutes a better globally coupled preparation kernel; no universal M5 or UPT protection claim is promoted.
