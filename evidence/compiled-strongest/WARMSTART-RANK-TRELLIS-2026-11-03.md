# Rung 1 — minimal parity states and a bounded-coin warm start

3 November 2026. Separate research increment on PR 213. Mathematical proofs
below are prose; the implementation and exact finite checks are Python.
No new Lean/kernel verification or full physical-UPT completion is claimed.

The outstanding application is the actual BDL family's rank-width bound,
source-matched decoder and physical preparation/holding certificate. This
increment reduces the complexity obligation of the trellis route and supplies
bounded sampling randomness. It does not change the original UPT target, error
allocation, arbitrary references, full history or complete pathwise work bill.
The retained G.21 full-history polymer route remains an existing alternative.

## 1. Exact states from an intersection of linear spaces

Let A be any binary parity presentation on m ordered syndrome bits; redundant
rows and zero rows are allowed. At cut i split its columns into A_L and A_R.
Put U_i=im(A_L), V_i=im(A_R), and S_i=U_i intersect V_i.

A prefix p extends to a valid full syndrome exactly when A_L p belongs to S_i:
an extension q must solve A_R q=A_L p, and this equation is also sufficient.
The partial parity v=A_L p is therefore a sufficient state. Every v in S_i
is both reachable and completable. After choosing bit b at position i its
unique next partial parity is v+b a_i, where a_i is column i. Keep that
edge exactly when the next parity belongs to S_(i+1).

The endpoints are S_0=S_m={0}. Starting from zero, every complete path has
A sigma=0. Conversely a valid syndrome follows its own sequence of partial
parities. Paths and valid syndromes correspond one to one; all coordinates
and constraints are retained.

Since U_i+V_i=im(A),

    kappa_i = dim(S_i)
            = rank(A_L)+rank(A_R)-rank(A).

Gaussian elimination with origin labels computes an intersection basis in
polynomial time, without enumerating U_i or V_i. The implementation checks
the intersection's dimension against the independent rank expression before
enumerating its 2^kappa_i states.

These are the conventional minimal-trellis states, not a new general coding
theorem. The state-space framework is classical: G. D. Forney, MIT 6.451,
Chapter 10, Section 10.2:
https://ocw.mit.edu/courses/6-451-principles-of-digital-communication-ii-spring-2005/1b67ae9f5c124c3bd56c8649afa5af47_chap10.pdf .
The explicit syndrome-state construction and sampling application are supplied here.

## 2. Minimality, presentation independence and the direct source-map formula

Prefixes with equal partial parity admit exactly the same suffixes. Prefixes
with distinct partial parities admit disjoint nonempty suffix sets: a suffix
cannot have A_R q equal to two different vectors. Any exact ordinary trellis
must distinguish those sets. Otherwise a prefix reaching the shared state can
be joined to an invalid suffix. Thus 2^kappa_i is the minimal state count for
this fixed coordinate order.

This characterisation uses only the supported code C=ker(A). Changing the
metacheck basis, adding dependent rows, or adding zero rows does not change
kappa_i. It can change the literal live-row count w_i dramatically.
An intersection vector is zero on every row not crossing the cut, so
kappa_i<=w_i for every supplied presentation.

For C=im(H), the same dimensions can be obtained directly from the authentic
error-to-syndrome map H:

    kappa_i = rank(H restricted to prefix rows)
            + rank(H restricted to suffix rows) - rank(H).

Indeed dim(C)=rank(H), while the subcode supported only in the prefix has
dimension rank(H)-rank(H_suffix); exchange prefix/suffix for the other
shortened subcode. Quotienting out both gives the displayed expression.
generator_rank_profile implements this polynomial preflight without needing
to extract a metacheck basis. Its row_rank field is rank(H); for
parity_rank_profile that field is rank(A). Only the cut dimensions coincide.

An explicit nontrivial separation uses r independent equality pairs and even r.
Mix their parity rows by the invertible binary matrix I+J, where J is all ones.
In interleaved coordinate order the literal frontier reaches r rows, whereas
kappa is at most one. There are 2^r valid syndromes. For r=32 the old raw
frontier enumeration has a 2^32 layer; this implementation uses at most two
states per cut and 97 states in total. Both represent exactly

    Z=(1+z^2)^32.

This is an algebraic example, not a BDL level or a family-wide width proof.

## 3. Exact law and runtime

Set B_m(0)=1. For v in S_i use the recurrence

    B_i(v) = B_(i+1)(v) + z B_(i+1)(v+a_i),

with an absent edge contributing zero. Induction identifies B_i(v) with
the total weight of valid suffixes and B_0(0) with the full partition Z.
Selecting an edge with probability z^b B_(i+1)(v+b a_i)/B_i(v) telescopes to
z^|sigma|/Z. No approximation or mixing result is used.

For kappa=max_i kappa_i the deterministic arithmetic and storage are
O(poly(m,r) 2^kappa). For rational z=a/b of polynomial bit length, every
message has polynomial bit length: after multiplying by b^(remaining bits),
it is a sum of at most 2^m integer monomials of degree at most m.
Thus kappa=O(log m) is sufficient for polynomial bit complexity.

This replaces the literal live-row sufficient condition by an intrinsic,
potentially much weaker condition for this algorithm. It does not prove that
the actual 3D family has logarithmic kappa or find a good order automatically.
A preallocation cap raises explicitly; it never truncates states silently.

Exact rational-coin sampling has expected polynomial random-bit cost, not
a deterministic random-bit bound. The next construction supplies the latter.

## 4. A deterministic coin budget with constant domination

At each reachable prefix let q be the exact probability of bit one and
p=min(q,1-q). Round p DOWN to a multiple of d=2^-b and assign the missing
probability to the more likely branch. The rare branch is never inflated.
The common branch has exact probability at least 1/2, so its multiplicative
inflation is at most 1+2d. The absolute branch error is at most d.

Multiplying the actual conditional kernels along a complete path gives

    mu(sigma) <= (1+2d)^m pi(sigma).

This uses dependent conditional kernels; independence of bits is not assumed.
Coupling the two processes until their first differing bit also gives
TV(mu,pi)<=m d.

For m>=1 choose b=ceil(log_2(8m)). Then d<=1/(8m). Since
binomial(m,j)<=m^j, summing the binomial expansion bounds
(1+1/(4m))^m by sum_(j>=0) (1/4)^j=4/3. Consequently

    mu <= (4/3) pi,        TV(mu,pi) <= 1/8.

For m=0 the law is the unique empty word. sample_dyadic consumes exactly
m b unbiased bits and returns every b-bit coin word alongside the sample.
replay_dyadic reconstructs the output from that retained transcript.
Sampler arithmetic, all coin words, workspace, routing, reset, controller and
physical gate charges still belong in the existing complete invoice.

## 5. A real thermal fugacity needs only a rational enclosure

The computational proposal uses rational z_0. Let the actual positive real
thermal fugacity z be certified to lie in rational [z_low,z_high]. Over the
same valid syndrome support,

    pi_(z_0)(sigma) / pi_z(sigma)
        <= max(z_0/z, z/z_0)^m.

Proof: the unnormalised tilt is (z_0/z)^|sigma|, with exponent between zero
and m; bounding both its numerator and its normalisation gives this ratio.
Therefore the bounded-coin output obeys

    mu <= (4/3) max(1,z_0/z_low,z_high/z_0)^m pi_z.

fugacity_interval_factor computes a fully rational certificate. In particular,
an enclosure within relative 1/(4m) of z_0 gives factor at most 16/9:
Bernoulli's inequality bounds (1-1/(4m))^m below by 3/4.
Thus exact representability of the physical temperature is unnecessary for
this warm-start bound. A verified exponential enclosure or physical calibration
must still establish the interval. No arbitrary real-number oracle is assumed.

## 6. Stable-event conditioning with bounded work and retained failures

More generally, if mu<=F pi, pi(A)>=a and L=1-F(1-a)>0, then

    mu(A)>=L,       mu(.|A)<= (F/L) pi.

This follows by applying the upper domination to A's complement. Independent
attempts fail T times with probability at most (1-L)^T.
For F=4/3 and the PR 213 stable-mass input a=3/4, success per attempt is
at least 2/3, the successful law is at most 2 pi, and cap failure is at most
3^-T. For the real-fugacity envelope F<=16/9, the corresponding bounds are
5/9, 16/5 and (4/9)^T.

sample_conditional_dyadic keeps every failed attempt's coin transcript and
returns an explicit failure at its deterministic cap. That failure must be
allocated inside the original stage budget; no free extra allowance is added.
This supplies an implementable conditional wrapper, not the source-matched
BDL decoder or its runtime certificate.

The BDL application remains the proved random-embedding family's low-temperature
setting. Its published RG-zero/stability event must be implemented authentically.
No lifetime theorem is transferred to the separate explicit-embedding construction.

## 7. Verification and remaining application

test_rank_syndrome_trellis.py checks the complete exact output laws and minimal
state counts for all 689 binary parity maps with 0<=m,r<=3, at three fugacities
and both forward/reverse orders. An independent count of distinct future
languages supplies the state-count comparison. A separate exhaustive test
checks 689 error maps against the direct H formula. Other checks cover changed
row bases, redundant checks, original-sampler agreement, the 32-pair separation,
complete finite random-source laws, dyadic domination/TV, real-fugacity envelopes,
capped conditioning with failed transcripts, and PR 213's actual level-zero
five-qubit seed sectors.

These are exact finite verification receipts, not kernel proofs or actual
3D all-level certificates. The new code has no third-party dependencies.

Run from the repository root:

    python3 evidence/compiled-strongest/tools/finite_syndrome_trellis.py
    python3 evidence/compiled-strongest/tools/test_rank_syndrome_trellis.py

Local verification: Python 3.11.15; the eight inherited sampler tests and
thirteen new tests pass. The targeted rank-trellis workflow replays both suites.

What this increment supplies for the unchanged target:

- an exact smaller sampler and a presentation-independent complexity test;
- a fixed coin budget, constant one-sided warm-start factor and retained history;
- a rational-enclosure bridge to a real thermal target;
- a capped conditioning wrapper with a quantitative failure charge.

Still to discharge for this route: actual higher-level H_X/H_Z extraction;
a uniform logarithmic rank-width ordering or another polynomial factorisation;
the authentic efficient decoder and event-mass application; actual quantum
branch implementation with arbitrary references; noisy endpoint/holding
correspondence, funding and the full physical invoice. Existing G.21 and
TV/Duhamel/endpoint supports retain their original scopes and are not requested
again by this increment.
