# Warm-start M5 — finite exact metacheck-constrained Gibbs sampler

3 November 2026. Status: **constructive finite-model result, not a family-wide polynomial-time 3D sampler**.

Code: evidence/compiled-strongest/tools/finite_syndrome_trellis.py

Primary source: Balasubramanian, Davydova and Lin, arXiv:2605.10943v1, https://arxiv.org/html/2605.10943v1 (§2.1, §4, §5.4, and the open initialization question in §1.3). This generic finite algorithm is not yet instantiated on their complete published hierarchy.

## A. Construct full syndrome constraints from the source map

Let H:F₂^q→F₂^m be an actual CSS error-to-syndrome matrix, supplied by its q columns. Gaussian elimination calculates a basis for ker(H^T). With these vectors as rows of A, finite-dimensional linear algebra gives

    ker(A) = (ker(H^T))^⊥ = im(H).

Thus every sampled string satisfying Aσ=0 is a genuine syndrome, and every genuine syndrome is included. This is not a guessed collection of local metachecks. The computation works with rank deficiency and redundant error columns. The Gibbs law under an additive commuting stabilizer Hamiltonian is proportional to z^|σ| over im(H), for positive fugacity z=exp(-β). Every syndrome has an equal number |ker H| of error preimages.

For computation the implementation takes strictly positive rational z. Its extension to an arbitrary real temperature requires a representation/error model; it does not assume a real-number sampling oracle.

## B. Exact normalized trellis sampler

Fix a permutation of the m syndrome coordinates. For each parity row R record its first and last positions. After i assigned bits, retain its accumulated parity only for rows crossing the prefix/suffix cut (first_R < i ≤ last_R). Let the maximum number of crossing rows be w.

A transition assigning bit b∈{0,1} toggles the parity of incident rows when b=1. Every row finishing at position i must have even parity, otherwise discard the transition. Therefore complete valid paths are precisely ker(A), with no removed physical constraints.

Define B_m(())=1 and the backward recurrence:

    B_i(s) = Σ_{b, valid T_i(s,b)} z^b B_{i+1}(T_i(s,b)).

Descending induction proves that B_i(s) is the total fugacity weight of the valid suffixes extending state s. In particular B_0(())=Z, the *full* partition function. At step i sample

    P(b|s) = z^b B_{i+1}(T_i(s,b))/B_i(s),

with probability zero for invalid transitions. Telescoping the B factors proves

    P(output σ)=z^|σ|/Z  if Aσ=0;   0 otherwise.

This gives **exact** finite sampling and exact normalization, not an approximate mixing or factorized-independence claim. The random-bit draw is rational and exact. An independent brute-force comparison validates each configuration probability on test instances.

## C. Error representatives without an oracle

The source function named syndrome_preimage solves He=σ over F₂ by polynomial Gaussian elimination on the actual columns of H. It provides a concrete Pauli-error vector e for an allowed syndrome, and rejects a syndrome outside im(H). It does not supply a physical circuit or an initially encoded logical state. A quantum-state preparation lift must still instantiate the existing canonical ThermalEncoding algebra with authentic, implementable code operators and the desired logical/reference protection.

## D. Conditional decoder-stable law

If the BDL stable-event predicate A is computed correctly, rejection from this exact Gibbs sampler returns the law π(.|A) conditional on termination. Under BDL's low-temperature theorem at k≥3, §5.4 supplies

    π(A) ≥ 3/4.

Consequently the unlimited repetition algorithm has E[attempts]=1/π(A)≤4/3, geometric failure tail at most (1/4)^t after t attempts, and exact pointwise warm-start ratio

    μ(σ)/π(σ) ≤ 1/π(A) ≤ 4/3.

The finite capped implementation can raise on too many rejections. When it returns, its conditional output law remains exact. Neither a working full BDL stability predicate nor an actual 3D construction has been plugged into this code. It is not a black-box conditional sampler: its *unconditional* Gibbs samples are constructed by the explicit trellis.

## E. The crucial runtime obstruction

For m syndrome variables, r metacheck rows, and maximum live-row width w, the DP performs O(poly(m,r)·2^w) exact rational arithmetic operations and uses O(poly(m,r)·2^w) space. For rational z of polynomial bit-length, partition-message numerator and denominator lengths are polynomial in input size. Linear algebra for the complete constraints and Pauli representative is polynomial.

Therefore **if** one derives an explicit ordering for every actual 3D code level with w=O(log m), this is a polynomial-time exact sampler for that family. That condition is **not proved** here. BDL §1.3 expressly notes that its metacheck matrix is not LDPC and that energy bottlenecks may obstruct rapid initialization. Local degree or bounded action menus do not entail logarithmic frontier width.

An ordering sensitivity test uses the constraints (i,r+i). Natural order has w=r, whereas interleaving the pairs gives w=1, with the same exact partition function (1+z²)^r. This shows that a bad natural ordering proves nothing about optimal width, while a good toy ordering proves nothing about the full 3D hierarchy.

## Verification and next mathematical bridge

Run:

    python3 evidence/compiled-strongest/tools/finite_syndrome_trellis.py

Eight tests check full GF(2) syndrome support, Pauli preimages, rank deficiency, normalized Z for multiple fugacities/orders, **the complete finite output law**, ordering-dependent width, accepted conditional sampling, and invalid inputs.

Next: extract authenticated H_X and H_Z matrices from the level-0/1/2 3D construction, compute all metacheck rows and frontier widths, and inspect whether the recursive geometry gives O(log m) width or requires another globally normalized multiscale factorization. Also connect the actual efficient decoder-stable membership test, not a substitute predicate.

No new claim of universal physical protection, no weakening of X3, and no change to commissioning or founding choice. This result supplies a concrete executable mathematical M5 interface and precisely identifies the remaining family-specific complexity obligation.
