# Rung 1 — symbolic first-replacement metachecks and full thermal sampling

3 November 2026. A separate mathematical/implementation increment on PR 215.
Remaining: extend the construction through the alternating hierarchy, connect
the authentic RG decoder and establish the quantum/noisy preparation and full
physical invoice. No family-wide initialization or physical-UPT completion
verdict follows from the first replacement alone.

The fixed target, full history, arbitrary references, original outcome order
and original stage budget are unchanged. The result supplies a component for
that target. It leaves the retained G.21 polymer and endpoint routes intact.

## 1. Source and exact scope

The input is PR 215's actual implementation of R_X on the named five-qubit
Tanner seed, pinned at 8978b21f149e0521f79223a9a82eef5d34fc0928:

- tools/bdl_replacement_chain.py;
- tools/bdl_frontier_audit.py.

The source construction is BDL, arXiv:2605.10943v1, Section 3.2.2, equations
59–73: https://arxiv.org/html/2605.10943v1#S3.SS2.SSS2 .
The following theorem is proved here for the implemented cellular model,
for every positive integer L, with ell=2L+1. It does not independently
authenticate every geometric gluing/embedding choice at the paper's large
sufficient scale. The random-embedding and explicit-embedding lifetime
statements remain distinct.

The old seed has two X vertices x0,x1, five qubits q0,...,q4 and two Z
vertices z0,z1. Its central qubit q2 touches both Z vertices. The other
qubits have one Z arm: q0,q3 at z0 and q1,q4 at z1.

## 2. Solve the complete metacheck equations for every L

An X-error syndrome is indexed by the replacement's C² coordinates:
bulk/seam faces xf, q-cell graph edges qe, and doubled Z vertices zv.
A metacheck is a binary coefficient assignment whose sum around every
fine qubit is zero; equivalently it is in ker((delta¹)^T).

There are exactly three freely chosen coefficients, called a,b0,b1.

**First solve the q-cell vertex equations.** On a noncentral q-cell the
two subdivided arms and their Z-end vertical edge form a path between
the two copies of q. Its end vertices have no zv term. Their equations
force the first horizontal coefficients to zero, and successive degree-two
vertex equations propagate zero along both arms. At the Z endpoints
the vertical coefficient equals the respective zv coefficient.
The same vertical edge meets both copies, so the two zv coefficients of
each old Z vertex agree. Denote their common values by b0,b1.

For the central q2-cell, the sum of its two horizontal coefficients at
each q-copy is zero. Thus both arms in copy t share one coefficient a_t;
the subdivided interior equations propagate it along the arms.
At a z_j endpoint the vertical coefficient is a_t+b_j.
The vertical edge is shared by the two copies and b_j already agrees,
so a_0=a_1=a. Its two vertical coefficients are a+b0 and a+b1.
These statements hold for every path length L, by propagation along the
subdivided path, not by extrapolation from a few observed lengths.

**Then solve the x-cell edge equations.** Each bulk sheet is the subdivided
two-square seed star. An outer x-to-q boundary edge has one incident bulk
face and no q-edge restriction term, forcing that face's coefficient to
zero. Across every shared interior edge the adjacent bulk coefficients
agree. The dual adjacency of the two-square sheet is connected, so all
bulk coefficients vanish. This works in each copy.

At a q-to-z boundary edge, the two remaining terms are its seam face
and the corresponding qe restriction. Their coefficients must agree.
Hence a seam on a central q2 arm has coefficient a; every other seam has
coefficient zero. The vertical seam-edge equations impose no further
restriction: at q2 the two a terms cancel, and at z_j the surviving seam a
cancels b_j+(a+b_j). The other endpoints carry only zero coefficients.

**Conversely**, assign the just-described coefficients for any a,b0,b1.
Each q-vertex and x-edge equation vanishes by the same cancellations.
Thus every such assignment is a metacheck, and the preceding forced
propagation shows that every metacheck is of this form. The three choices
are independent: zv at z0 reads b0, zv at z1 reads b1, and a central seam
reads a. Therefore the full metacheck space has dimension exactly three.

For the other syndrome sector, delta⁰ is injective. A kernel assignment
is constant on each connected x-cell, because every xe difference is zero.
The private q0 and q4 restrictions respectively force the x0 and x1 constants
to vanish. Hence Z-error syndromes have no metacheck constraint.

## 3. The five blocks and all original coordinates

Use a,b0,b1 as the row basis. The nonzero columns of the parity map are
the binary masks 1,2,3,4,5, with multiplicities

    mask 1: 8L;   mask 2: 4;   mask 3: 1;
    mask 4: 4;    mask 5: 1.

Mask 1 consists of the 4L central seam faces and 4L central horizontal
q-edges. Mask 2 consists of the two noncentral z0 vertical q-edges and
the two zv copies of z0; mask 3 is the central z0 vertical edge.
Masks 4,5 are the corresponding z1 sets.

There are 8L²+12L zero columns in this sector. Altogether this gives
8L²+20L+10 X-error syndrome coordinates, matching the C² cell count.
The free Z-error sector has 8L²+12L+4 coordinates.
seed_first_metacheck_column reads this classification directly from the
actual source label; it does not fit a column pattern from measurements.

Let p_j be the parity of block j. The three equations reduce exactly to

    p_1 = p_3 xor p_5,    p_2 = p_3,    p_4 = p_5.

Thus the four quotient patterns are (u xor v,u,u,v,v).
This is a temporary sampling state, not a replacement protected record:
the sampler returns every within-block bit, every free bit, and a map
back to the original source-coordinate ordering.

## 4. Exact normalized law without a large frontier

For fugacity z>0 define the even/odd block weights

    E_k = [(1+z)^k+(1-z)^k]/2,
    O_k = [(1+z)^k-(1-z)^k]/2.

Expanding the binomial theorem separates the even/odd Hamming weights.
The recurrence E_(k+1)=E_k+z O_k and O_(k+1)=O_k+z E_k computes the
same values with E_0=1,O_0=0.

The full joint partition function of both syndrome sectors is

    Z = (1+z)^(16L²+24L+4)
        [ E_(8L)(E_4²+z² O_4²) + 2z O_(8L) E_4 O_4 ].

The four terms inside the bracket are exactly the four quotient-pattern
weights. Sample u and then v from their normalized weights. A block of
remaining length k and required parity p chooses its next bit with

    Pr(bit=1) = z W_(k-1)(p xor 1) / W_k(p),
    W_k(0)=E_k, W_k(1)=O_k.

The factors telescope to z^(block weight)/W_length(p).
Free bits use probability z/(1+z). Multiplication cancels all block and
macro normalizers, giving exactly z^(total syndrome weight)/Z on every
valid source syndrome, and zero elsewhere.

Both sectors are included in this formula. It uses the independent CSS
error sectors of this ideal additive stabilizer Hamiltonian, not an
assumption of independent physical noise at preparation or holding.

Arithmetic preprocessing is O(L), with a constant four macro weights;
one sample uses O(M) rational operations for
M=16L²+32L+14 original syndrome bits. Rational bit lengths and operation
costs are polynomial in M and the rational fugacity input length.
The explicit output already requires Omega(M) work. This is a uniform
polynomial first-replacement sampler, independent of a trellis-width
assumption. It is not yet an alternating-family sampler.

## 5. Fixed coins, complete transcript and the original bill

Exact rational reference mode has an unbounded random-bit tail.
For pathwise sampling, apply PR 214's less-likely-branch rounding at all
D=M+2 binary decisions, including both macro choices. Choose
b=ceil(log_2(8D)), and round the rarer branch down to the 2^-b grid.

Each common branch is inflated by at most 1+2^(1-b), and the rare branch
is never inflated. Consequently

    mu <= (1+2^(1-b))^D pi <= (4/3) pi.

The total variation bound is at most D 2^-b<=1/8. Coin use is exactly Db
bits. The implementation returns every coin word and replays the full
configuration from them. This is one global factor for the joint sampler,
not a multiplication of untracked block errors.

All arithmetic, output bits, coins, source relabelling, controller activity,
routing, storage and reset remain in the complete physical invoice.
This supplies operation/record bounds; it does not supply measured joules
or the missing quantum/endpoint certificate. PR 214's real-fugacity enclosure
and capped stable-conditioning inequalities can be applied to this verified
path law once their corresponding inputs are established.

## 6. Verification and remaining hierarchy work

The exact test suite checks:

- complete small-instance output laws, normalizers and one-sided dyadic bounds;
- all finite coin sources for a nondegenerate five-block instance;
- the full three-dimensional metacheck row space against independent GF(2)
  elimination of PR 215's literal source matrices at L=1,...,8;
- no metachecks in the opposite sector at those same L values;
- the full source-coordinate Fourier partition sum against the four-term
  formula, and actual error-image membership of sampled source words;
- symbolic counts at a very large L without allocating a matrix or claiming
  to have run a physical-scale sample.

The cell-equation proof supplies the arbitrary-L statement; the finite checks
verify its implementation and tested instances. The proofs are prose and the
checks are Python, with no new Lean kernel certificate.

Run:

    python3 evidence/compiled-strongest/tools/test_bdl_first_replacement_thermal.py

Next: derive the analogous effective parity/conditional-weight transformation
for R_Z and for later non-seed stars. The rank-90/rank-234 second-level
examples in PR 215 are not reduced to these three seed metachecks.
Their constraints cannot be dropped or replaced by independent first-level
blocks. The authentic stable decoder, arbitrary-reference quantum branch,
noisy handoff/holding correspondence, original risk allocations, sustainable
funding and physical commissioning remain the same construction tasks.
