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


## F. Exact stability-definition and RG-zero event join (source-checked)

New verifier: evidence/compiled-strongest/tools/bdl_stability_interface.py, with four additional exact finite-model tests.

**BDL Definition 5.1 (source §5.1):** for the actual CSS error map H=δ¹, stabilizer map G=δ⁰ with HG=0, and a specified decoder f satisfying Hf(σ)=σ, a syndrome σ is stable against each weight-one error e_j precisely when

    f(σ)+f(σ+H e_j)+e_j  ∈ im(G).

The verifier checks all q single-coordinate errors, validates HG=0 and decoder outputs, and computes membership in im(G) by Gaussian elimination. This is a decidable finite algorithm with polynomial overhead *when* f has polynomial evaluation cost, but **the actual BDL RG decoder f is not implemented**. It is not permissible to replace f by an arbitrary right inverse: the tests exhibit a three-qubit repetition complex in which stability at σ=0 changes with the choice of f.

**BDL Lemma 5.2 (source §5.1.2):** for their *specific locally computable RG decoder*, the simpler condition that coarse-graining reaches σ₂=0 is sufficient for stability. **Not equivalent in general.** The source §5.4 proves that its complement has Gibbs probability at most 2·2^(-2^(k-1)) in each CSS sector. Thus the two-sector event

    A_k := {σ₂,X = 0 AND σ₂,Z = 0}

has probability at least 1−4·2^(-2^(k-1)) ≥3/4 for k≥3, under the paper's stated inverse-temperature conditions. This gives an explicitly testable *sufficient stable subset* whose conditional Gibbs law has C≤4/3. To use it, one needs the authentic RG coarse-graining implementation; our finite verifier and a random coarse map do not provide that source correspondence.

**Optional direct conditioning if and only if linearity is verified:** if the actual coarse event has a proven linear parity-matrix description Cσ=0, the exact conditioned Gibbs law can be sampled directly by appending the rows of C to the complete metacheck system A. Its partition function is Z_{A,C}, and its mass under the original law is exactly Z_{A,C}/Z_A. The test on a three-syndrome-bit instance checks event mass 5/6 and exact conditioned sampling, without Gibbs rejection. No claim that the BDL RG coarse operation is linear is made; if it is nonlinear, use the general verified predicate and rejection route instead.

Additional primary source anchors:
- §5.1 Definition 5.1 and Lemma 5.2: https://arxiv.org/html/2605.10943v1#S5.SS1
- §5.4 Corollary 5.14: https://arxiv.org/html/2605.10943v1#S5.SS4
- §4.1 local computability and level-by-level coarse-graining: https://arxiv.org/html/2605.10943v1#S4.SS1

New workflow checks **12** exact tests across both scripts. These are finite source-interface checks, not a 3D construction-scale sampler certificate.


## G. First authenticated source fixture: the BDL level-0 [[5,1,2]] Tanner seed

Source: §3.3, Eqs. (106)–(109) and image https://arxiv.org/html/2605.10943v1/figs-4/Tanner-base.png , interpreted with the Tanner incidence conventions of §2.2 (blue X-check, black qubit, red Z-check). This is the published seed, not an invented toy matrix.

Label the five black qubits NW, NE, CENTER, SW, SE by 0,1,2,3,4. The blue top/bottom X-check supports are (0,1,2) and (2,3,4); the red left/right Z-check supports are (0,2,3) and (1,2,4). The executable fixture evidence/compiled-strongest/tools/bdl_seed_surface_code.py verifies:

- Every X/Z pair overlaps on an even number of qubits, so H_Z H_X^T = 0.
- Both check matrices have rank 2; thus five physical qubits encode 5−2−2=1 logical qubit.
- Exhaustive nontrivial-homology enumeration confirms both logical distances are 2, agreeing with the paper's [[5,1,2]] claim.
- Each seed's two-bit syndrome map is surjective; computed metacheck left-nullspace is empty (w=0).
- The exact sector partition function is (1+z)^2 and each sampled syndrome has a constructed error preimage He=σ.

This **closes a true source-correspondence test only at level 0**. The interesting quantum memory is the *iterated* (R_Z∘R_X)^k family. The level-0 free syndrome law has no evidence about higher-level metacheck width or an efficient full-family sampler. Do not invoke the k≥3 stable-event probability bound at seed level.


## H. Important distinction between the two 3D embeddings

The fully proved exponential-lifetime result with the source-level §5.4 low-temperature bound belongs to the construction with **random embedding** (Theorem 3.16 and Corollary 5.14). The paper's **explicitly embedded ℓ=8 variant** in §6 is a different branch: its geometric locality is established, and §6.2.6 sketches the corresponding lifetime argument, but the authors state in §1.2.4 that they leave the **complete proof of exponential memory lifetime for that version to future work**.

Therefore do NOT apply the proven k≥3 stable-event probability bound to the explicit ℓ=8 family as if its corresponding full proof were present. A completed sampler for the latter would still need the physical stability/Peierls theorem transferred and verified. The level-0 Tanner seed used above is shared structural starting material, not proof of either family-wide installation.
