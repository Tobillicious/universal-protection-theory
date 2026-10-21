# Two proved algebraic/scheduling components for the proposed k3 plant

These do not prove the whole service or a rung-4 certificate.

## Local source-read matching

There are H = 242 hosts, at most71 unavailable, leaving171. Each record's73 potential local
holders form a cyclic interval beginning at 73r mod242 for rank r. Since gcd(73,242)=1 and
there are1032 ranks, a home contributes at mostceil(1032/242)=5 records at any start position.
At most three lost homes contribute requests at a source island, so at most15 requests share a start.

Give every live host capacity19 reads. For any subset of requests, decompose the union of their
holder intervals into connected components on the cycle.

A proper component of length l >=73 has at most l-72 possible starts, hence at most15(l-72)
requests. It has at least l-71 live hosts. For every73<=l<242,

    15(l-72) <= 19(l-71).

If the union covers the whole cycle, the number of requests is at most3×1032=3096, while live
capacity is at least19×171=3249. Thus every request subset satisfies capacitated Hall, establishing
a complete assignment with at most19 reads per live host, for every permitted host-erasure mask.
No sample of masks is substituted for that proof.

This proves existence for the stated unit-read subproblem. It does not price a full adaptive
implementation, partial attempts, retries or the concurrent reseed calendar.

## Four-of-seven fresh key sharing

For one limb over the inherited irreducible GF(2^16), use s+aX+bX^2+cX^3 at seven distinct nonzero
points. For any three observations and each proposed secret s, the coefficient matrix has determinant

    (x1 x2 x3) product_{i<j}(xi+xj),

which is nonzero. Independent uniform a,b,c therefore make those observations independent of s.
Four observations recover the polynomial and hence s by Lagrange interpolation.

The checker verifies35 nonzero three-observation determinants and420 reconstruction cases.
The same argument applies independently to all32 limbs of a512-bit key. The generation-wide cap of
three exposed shares, fresh coefficients, secure erasure and the trusted release interface remain
separate obligations; the algebra does not establish them.
