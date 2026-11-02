# BDL replacement kernel transport and symbolic two-level Gibbs partition

Date: 2026-11-03
Status: exact abstract GF(2) argument under source's local-connectivity/restriction hypotheses; source-derived finite tests; no family-wide efficient thermal initializer.
Parent: draft PR #215 (cellular replacement); companion sampler PRs #213–214.
Primary source: Balasubramanian, Davydova & Lin (2026), arXiv:2605.10943v1, especially §3.2.2 Eqs. (59)–(73), Lemma 3.8, §3.2.4 Eq. (57), and dual §3.2.5–3.2.6.
https://arxiv.org/html/2605.10943v1

## 1. New general kernel transport lemma

For a Tanner square complex C with nonempty connected X-local cell stars Y_x, write

    δ0_C : F₂^{V_X} → F₂^{V_Q}
    δ1_C : F₂^{V_Q} → F₂^{V_Z}.

Let C'=R_X(C) use the paper's exact local Y_x, Y_q and restrictions (not arbitrary parities). Every new degree-zero vertex has the form (x,v) with v∈Y_x(0).

**Theorem (R_X zero-degree kernel preservation).**

    ker δ0_C' ≅ ker δ0_C.

**Proof.** A vector a' in ker δ0_C' has zero coefficient on every internal edge (x,{v,w}) of Y_x. Each such coefficient is a'(x,v)+a'(x,w). Hence a'(x,v)=a'(x,w) on every edge; connectedness of each Y_x forces a' to be a constant a_x on its entire local star. Conversely, assigning a_x to every vertex of Y_x makes all internal-edge coefficients vanish. The remaining new degree-one generators are (q,v), v∈Y_q(0). Their δ0_C' coefficient is the sum of a_x over all original X vertices x adjacent to q, because the gluing map restricts each constant 0-cochain to the same constant on Y_q. As Y_q is nonempty, these vanish for all q and v **if and only if** δ0_C a=0. Copying and reading the local constants give inverse linear maps. QED.

This uses the original source's connected Y_x and all incidence/restriction maps. It fails as stated for a malformed construction with an empty or disconnected local X-star. The source identifies X_x as a cone over its boundary and Y_x as its suspension, hence Y_x is connected in the intended admissible construction.

**Dual theorem (R_Z top-degree relation preservation).** Apply the same argument to the dual Tanner complex, using the paper's definition R_Z(C)=dual(R_X(dual C)). Thus

    ker (δ1_RZ(C))^T ≅ ker (δ1_C)^T,

or equivalently H²(R_Z(C))≅H²(C). In syndrome language:
- R_X preserves the number **and full linear space** of X-check relations (metachecks of Z-error syndromes);
- R_Z preserves the number **and full linear space** of Z-check relations (metachecks of X-error syndromes).

The theorem is about ONE replacement. It does not assert that the *opposite* replacement cannot create many new relations.

## 2. All-subdivision first-stage rank theorem

Start from BDL's actual [[5,1,2]] Tanner seed: 5 qubits, 2 X checks, 2 Z checks, 4 squares, with one logical qubit, no degree-zero relation.

For integer L≥1 and ell=2L+1, the source-cell counting proof in parent PR #215 gives:

    N_X1=8L²+12L+4
    N_Q1=16L²+32L+12
    N_Z1=8L²+20L+10.

Thus Euler χ1=N_X1−N_Q1+N_Z1=2, for every L≥1. The new kernel theorem gives H⁰_1=H⁰_seed=0. BDL §3.2 proves H¹ is preserved under R_X, so H¹_1=H¹_seed=1. Rank-nullity/Euler then gives

    dim H²_1 = χ1 − dim H⁰_1 + dim H¹_1 = 3.

This is a derivation for every formal positive L, not an interpolation from the first two numerical examples.

Moreover, exactly THREE explicit and linearly independent Z-check parity relations are provided in the test code:

A: all 4L doubled seam faces along the central old qubit q2 plus all 4L+2 edges in its local doubled Y_q2 graph; |A|=8L+2.
B_z0: two doubled z0 point checks plus the three vertical q–z0 edges; |B_z0|=5.
B_z1: the analogous z1 points and three vertical edges; |B_z1|=5.

Each relation has vanishing incidence on every new qubit. Independence is witnessed by A's seam-face coefficient and each B_z's distinct z-point. The dimension theorem proves these span EVERY metacheck (no dropped rows).

The first-stage X-error syndrome has exactly three constraints. The Z-error syndrome has no constraints and its Gibbs bits are independent Bernoulli(z/(1+z)), for the additive equal-energy stabilizer Hamiltonian.

## 3. All-subdivision second-stage rank theorem

Apply R_Z to the first-stage Tanner complex. The dual kernel transport gives H²_2=H²_1=3. BDL's H¹ preservation gives H¹_2=1.

To compute H⁰_2 *without materializing level two*, look at the boundary graph of each first-stage Z vertex, which becomes an X vertex of the dual input to R_X. All boundaries are either a connected 8-vertex/8-edge CYCLE or a connected 5-vertex/4-edge PATH. Counting the original local square, seam, q-edge and endpoint flags gives:

    N_cycle = 8L²+12L+2
    N_path = 8L+8.

Likewise, among first-stage qubits, the degrees toward first-stage X vertices are:
    N_degree1 = 8L+8
    N_degree2 = 16L²+24L+4.

The original new X-check count N_X1 is above. For the R_X diagram of this DUAL Tanner complex, every doubled local X star Y_x has Euler
χ(Y_x)=2−χ(∂X_x): it equals 2 for cycle boundary and 1 for path boundary. Every doubled q-star Y_q has χ(Y_q)=2−degree(q), giving 1 for degree-one and 0 for degree-two. Every z-local complex contributes 2 points. By degree shifts in the source's total complex,

    χ2 = Σ_x χ(Y_x) − Σ_q χ(Y_q) + 2 N_X1
       = 2 N_cycle + N_path − N_degree1 + 2 N_X1
       = 32L²+48L+12.

Euler χ2=H⁰_2−H¹_2+H²_2 gives the exact ALL-L metacheck count

    dim H⁰_2 = χ2 +1−3 = 32L²+48L+10.

For L=1,2 this produces 90 and 234, agreeing with the independently materialized full source-cell matrices in parent PR #215. The source's random geometric perturbation relocates the embedding; it does not alter the stated Tanner incidence specification. However the particular published geometric scales were not materialized and their physical installation remains open.

## 4. Eight-term EXACT partition formula for the opposite, tractable sector

At both levels 1 and 2, the X-error syndrome has only three independent parity relations. For any finite binary law with three independent metachecks A (a 3×m matrix),

    Z_A(z) := Σ_{σ:Aσ=0} z^|σ|
            = (1/8) Σ_{u∈row(A)} (1+z)^(m−|u|) (1−z)^|u|.

**Proof:** use the character indicator
    1_{Aσ=0}=(1/8)Σ_{t∈F₂³}(-1)^(t·Aσ)
and exchange finite sums. Each syndrome bit contributes (1+z) or (1−z) depending on its dual parity. This includes the FULL global normalization. It holds mathematically for all positive real z and can be evaluated EXACTLY for rational z of finite bit length.

At level 1:

    m1=8L²+20L+10
    dual weights W1=
       [0, 8L+2, 5, 8L+5, 5, 8L+5, 10, 8L+8].

At level 2, an old Z-check with cycle-boundary star expands under R_Z to
    v_cycle=8L²+8L+2
new Z-check vertices; an old Z-check with path-boundary star expands to
    v_path=4L²+6L+2.

The old A relation consists of 8L+2 cycle-type Z checks. Each B_z consists of one cycle-type and four path-type checks; A∩B_z is one cycle-type check; B_z0∩B_z1 is empty. Therefore its lift under R_Z has dual weights

    W2=[
      0, (8L+2)v_cycle, v_cycle+4v_path,
      (8L+1)v_cycle+4v_path, v_cycle+4v_path,
      (8L+1)v_cycle+4v_path, 2v_cycle+8v_path,
      8L v_cycle+8v_path
    ].

The number of level-2 Z checks (X-error syndrome bits) is

    m2 = N_cycle v_cycle + N_path v_path
       = 64L⁴+192L³+208L²+104L+20.

Plug W2 and m2 into the eight-term expression above. NO exponential-size level-2 matrix or full syndrome enumeration is needed to evaluate this particular sector's partition function. The three lifted relations are complete by the kernel transfer theorem. A three-parity-state exact trellis/transfer sampler needs at most 8 states per position, therefore uses polynomial arithmetic operations in m2 and the rational fugacity encoding length. Unlike a general unconstrained Gibbs sampler, this sector is not subject to the previously observed 29/39 Z-error cut-width obstruction.

The other sector at level 2 has 32L²+48L+10 independent relations: nothing here makes it polynomial-time samplable. Nor does this imply an efficient sampler across infinitely many R_X/R_Z repetitions.

## 5. Reproducible verification

From the repository root, after parent PR #215 is checked out:

    python3 evidence/compiled-strongest/tools/bdl_symbolic_kernel.py

The script:
- builds level-1 matrices at L=1,2,3,4 and validates all three EXPLICIT cocycles against every qubit;
- verifies complete first-stage rank and the cycle/path plus degree inventories exactly;
- checks the all-L symbolic formulas on those four independently enumerated subdivision scales;
- builds full level-2 matrices at L=1,2, verifies dimensions H⁰ and H², and checks the lifted three relations against every qubit;
- checks all 8 dual codeword weights against the materialized relations;
- compares the eight-term normalised partition formula against an INDEPENDENT exact forward parity-transfer recurrence, at level 1 for L=1,2 and level 2 for L=1, at rational z=1/3 and 3/4 as applicable.

The arbitrary-L proof is the structural kernel argument, explicit cocycles, local cell-count identities, Euler and character orthogonality. Four finite regressions alone would not prove a general polynomial identity.

## 6. Strict scope and next obstruction

- This solves an exact finite Gibbs-syndrome sampling subproblem for the X-error sector through two source-cell replacements, not the complete quantum thermal state preparation task.
- The level-2 Z-error sector still has a growing metacheck kernel; its natural width and improved heuristic widths were measured in PR #215. The new theorem isolates that stage as the next structural target.
- The paper's explicit ell=8 embedding and random-embedding lifetime proof are different branches. Source-equivalent geometry/physical parameter validation, authentic RG decoder, reference-preserving encoded preparation, lifetime-to-hardware correspondence and general M0–M6 warm start remain OPEN.
- The precise source-matched connectedness, cochain restriction and H¹ preservation premises are essential. A disconnected X-local star, a different perturbation of Tanner incidence, or a nonstandard gluing would require a new proof.
- No Lean kernel certificate is claimed for this new theorem, only a complete mathematical argument and executable exact finite-model tests. No weakening of X3; canonical manuscript, publishing, commissioning and founding choice unchanged.

Review acceptance: independently verify the local boundary inventories and equality of the symbolic doubled-star cell counts to the paper's full source prescription before promotion; separate the abstract algebraic proof from physical claim.
