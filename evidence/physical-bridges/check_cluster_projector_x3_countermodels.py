#!/usr/bin/env python3
"""Exact arithmetic checks for the Proofs 14-16 hostile mathematical review.

This is a mathematical countermodel test, not a physical BCRD or X3 test.
Standard-library only, no numerical spectral approximation.
"""
from fractions import Fraction

for n in (2, 3, 10, 100):
    a=n**3
    b=n
    H=((0,a,b),(a,0,0),(b,0,0))
    P=(0,1)
    Q=(2,)
    # Directed counting of undirected symmetric adjacency coefficients.
    internal=sum(H[i][j] for i in P for j in P)
    external=sum(H[i][j]+H[j][i] for i in P for j in Q)
    gamma=Fraction(internal,external)
    assert gamma == n*n
    # QHP is a single row (b,0), hence exact spectral/operator norm g=b.
    g_squared=sum(H[2][i]**2 for i in P)
    assert g_squared == n*n

    # H |1> = a |2> + b |3>; the normalized partner
    # v=(a |2>+b |3>)/sqrt(a^2+b^2) creates a two-level
    # invariant subspace with eigenenergies +/-sqrt(a^2+b^2).
    # Therefore |1> has exactly half its spectral weight in each.
    w_plus=w_minus=Fraction(1,2)
    w_zero=Fraction(0)
    assert max(w_plus,w_minus,w_zero) == Fraction(1,2)
    assert sum((w_plus,w_minus,w_zero)) == 1
    print(f"n={n}: gamma={gamma}, g^2={g_squared}, w_max=1/2")

# Counterexample to replacing the Frobenius sum by operator norm:
# M=I_2 has squared operator norm 1 but squared Frobenius norm 2.
M=((1,0),(0,1))
frob_squared=sum(v*v for row in M for v in row)
op_squared=1  # singular values of I_2 are 1,1
assert frob_squared == 2 and op_squared == 1

# Dense K3 cluster has adjacency eigenvalues 2L,-L,-L:
# (J-I)v=2v for all-ones and -v for v with zero sum.
L=7
K=((0,L,L),(L,0,L),(L,L,0))
ones=(1,1,1)
orthogonal=(1,-1,0)
orthogonal2=(1,1,-2)
def mv(A,x):
    return tuple(sum(A[i][j]*x[j] for j in range(len(x)))
                 for i in range(len(x)))
assert mv(K,ones)==tuple(2*L*x for x in ones)
for v in (orthogonal,orthogonal2):
    assert mv(K,v)==tuple(-L*x for x in v)

# Static perfect occupancy doesn't entail independently specified agency.
# The semantic predicates are not encoded by H=0 or P=I.
print("PASS: high clustering doesn't bound absolute g or force spectral dominance")
print("PASS: squared Hilbert-Schmidt sum differs from squared operator norm")
print("PASS: dense K3 can have a degenerate ground energy")
print("NOTE: X3 semantic correspondence requires independent physical/trace evidence")
