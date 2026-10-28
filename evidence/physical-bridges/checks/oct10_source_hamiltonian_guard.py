#!/usr/bin/env python3
"""10 October continuity question, September BCRD inherited six-dimensional source.

Exact finite checks using Gaussian integers for the specified pi/2
pulse and fractions for the source full-rank state. NO physics/subject
semantics accepted by running this model. No third-party dependencies.
"""
from fractions import Fraction as F
from itertools import product

N = 6
BASIS = ("A0", "A1", "B0", "B1", "C0", "C1")
# H1=X_AB tensor diag(1,2), H2=X_BC tensor sigma_x.
H1 = [[0] * N for _ in range(N)]
H2 = [[0] * N for _ in range(N)]
for a,b,amp in ((0,2,1),(1,3,2)):
    H1[a][b] = H1[b][a] = amp
for a,b in ((2,5),(3,4)):
    H2[a][b] = H2[b][a] = 1
C = (1,-1,1,-1,-1,1)
RZ = (1,-1,1,-1,1,-1)
PB = (0,0,1,1,0,0)
permutation = (0,1,5,4,3,2)
rho = (F(1,4), F(1,10), F(1,6), F(1,7), F(9,35), F(1,12))

def diagonal_commutes(H, p):
    return all(H[i][j]*(p[j]-p[i])==0
               for i in range(N) for j in range(N))

def commute(H, K):
    return all(sum(H[i][k]*K[k][j] - K[i][k]*H[k][j]
                   for k in range(N))==0
               for i in range(N) for j in range(N))

def matrices_equal(A,B):
    return all(A[i][j] == B[i][j] for i in range(N)
               for j in range(N))

def dag(A):
    return [[A[j][i].conjugate() for j in range(N)] for i in range(N)]

def mul(A,B):
    return [[sum(A[i][k]*B[k][j] for k in range(N))
             for j in range(N)] for i in range(N)]


# Exact nonzero 34x34 minor certificate of the 72x36 joint
# commutator map X -> ([H1,X],[H2,X]), in row-major matrix coordinates.
# Since I and C are independent kernel vectors, nullity >=2.
# This minor gives rank>=34, so rank=34 and kernel=span{I,C}.
CERT_ROWS = (2,3,0,1,16,17,8,9,6,7,22,23,41,15,53,13,4,5,
             20,46,18,58,10,11,26,27,24,25,59,32,33,30,31,52)
CERT_COLS = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
             18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34)

def commutator_rows():
    rows=[]
    for H in (H1,H2):
        for i in range(N):
            for j in range(N):
                row=[0]*(N*N)
                for k in range(N):
                    row[k*N+j] += H[i][k]
                    row[i*N+k] -= H[k][j]
                rows.append(row)
    return rows

def rational_determinant(M):
    n=len(M)
    A=[[F(v) for v in row] for row in M]
    det=F(1)
    for k in range(n):
        pivot=next((i for i in range(k,n) if A[i][k]), None)
        if pivot is None:
            return F(0)
        if pivot!=k:
            A[k],A[pivot]=A[pivot],A[k]
            det=-det
        v=A[k][k]
        det*=v
        for i in range(k+1,n):
            m=A[i][k]/v
            if m:
                A[i]=[u-m*w for u,w in zip(A[i],A[k])]
    return det

def run():
    assert all(permutation[permutation[i]]==i for i in range(N))
    assert all(C[permutation[i]]==C[i] for i in range(N))
    assert all(H1[i][j] == 0 or C[i] == C[j]
               for i in range(N) for j in range(N))
    assert all(H2[i][j] == 0 or C[i] == C[j]
               for i in range(N) for j in range(N))

    # U = exp(-i*pi*H2/2) = I on A, -i*H2 on B/C.
    # Coefficients are Gaussian integers 0,1,-i.
    U = [[(1 if i==j and i<2 else 0) - 1j*H2[i][j]
          for j in range(N)] for i in range(N)]
    UdagU = mul(dag(U),U)
    identity = [[int(i==j) for j in range(N)] for i in range(N)]
    assert matrices_equal(UdagU, identity)
    # This matrix has exactly one nonzero entry of modulus 1 per
    # column: 1 on each A state and -i times swap on B/C states.
    assert all(sum(abs(U[i][j])**2 for i in range(N))==1
               for j in range(N))
    assert U[5][2]==-1j
    assert PB[2]==1 and PB[5]==0 and C[2]==C[5]==1
    assert diagonal_commutes(H2,C)
    assert diagonal_commutes(H1,C)
    assert not diagonal_commutes(H2,PB)

    # All and only the two full parity-sector projectors are
    # invariant under both inherited source Hamiltonians.
    invariant=[]
    for p in product((0,1), repeat=N):
        closed = diagonal_commutes(H1,p) and diagonal_commutes(H2,p)
        sector_constant = (p[0]==p[2]==p[5] and p[1]==p[3]==p[4])
        assert closed == sector_constant, (p,closed,sector_constant)
        if closed: invariant.append(p)
    assert len(invariant)==4

    # Full non-diagonal commutant, not just 0/1 basis projectors.
    rows=commutator_rows()
    minor=[[rows[i][j] for j in CERT_COLS] for i in CERT_ROWS]
    assert len(minor)==34 and all(len(row)==34 for row in minor)
    assert rational_determinant(minor)==F(82944)
    assert any(C[i]!=C[j] for i in range(N) for j in range(N))
    # I and diagonal C commute with H1,H2, so kernel dimension >=2.
    # Nonzero 34x34 minor gives rank >=34, hence nullity <=2.
    # Therefore kernel EXACTLY span_C{I,C}, all possible projectors
    # included, and their eigenvalues on +/- parity are 0 or 1.

    assert sum(rho)==1
    before = sum(rho[i]*RZ[i] for i in range(N))
    after = sum(rho[i]*RZ[permutation[i]] for i in range(N))
    assert before == F(73,210)
    assert after == -F(1,21)
    assert before-after == F(83,210)

    print("PASS 10OCT: inherited six-dimensional H1/H2 exact integer couplings")
    print("PASS 10OCT: exact Gaussian-integer H2(pi/2) pulse is unitary")
    print("PASS 10OCT: B0 -> C1, B-site occupancy 1 -> 0 with conserved C=+1")
    print("PASS 10OCT: exact commutator rank 34 via 34x34 minor determinant 82944")
    print("PASS 10OCT: full commutant span_C{I,C}: only 4 invariant orthogonal projectors")
    print("PASS 10OCT: only 4 of 64 binary diagonal source projectors invariant")
    print("PASS 10OCT: source boundary Rz detects pulse difference 83/210")
    print("STATUS: does not identify a continuing subject or establish X3")

if __name__ == "__main__":
    run()
