#!/usr/bin/env python3
"""Exact six-spin singlet/register source reconstruction; author-side only.
Independent of BCRD author's implementation, not a scientific acceptance.
No evidence that register-UP is a real living particular or protected X3 sector.
"""
from itertools import product
from fractions import Fraction as F
import json

def zeros(n,m=None):
    return [[F(0) for _ in range(n if m is None else m)] for _ in range(n)]
def ident(n):
    a=zeros(n)
    for i in range(n):a[i][i]=F(1)
    return a
def mm(A,B):
    n,k,m=len(A),len(B),len(B[0])
    return [[sum((A[i][t]*B[t][j] for t in range(k)),F(0))
             for j in range(m)] for i in range(n)]
def add(A,B):
    return [[A[i][j]+B[i][j] for j in range(len(A[0]))] for i in range(len(A))]
def sub(A,B):
    return [[A[i][j]-B[i][j] for j in range(len(A[0]))] for i in range(len(A))]
def scale(A,v):
    return [[v*x for x in row] for row in A]
def transpose(A):return [list(r) for r in zip(*A)]
def nullspace(A):
    M=[r[:] for r in A];m=len(M);n=len(M[0]);pivot=[];k=0
    for col in range(n):
        row=next((r for r in range(k,m) if M[r][col]),None)
        if row is None:continue
        M[k],M[row]=M[row],M[k]
        val=M[k][col]
        M[k]=[x/val for x in M[k]]
        for r in range(m):
            if r!=k and M[r][col]:
                fac=M[r][col]
                M[r]=[M[r][c]-fac*M[k][c] for c in range(n)]
        pivot.append(col);k+=1
        if k==m:break
    free=[c for c in range(n) if c not in pivot]
    cols=[]
    for f in free:
        v=[F(0)]*n;v[f]=F(1)
        for i,c in enumerate(pivot):v[c]=-M[i][f]
        cols.append(v)
    return cols,free

zero_m=[b for b in range(64) if b.bit_count()==3]
higher=[b for b in range(64) if b.bit_count()==4]
index4={b:i for i,b in enumerate(higher)}
Splus=zeros(len(higher),len(zero_m))
for j,b in enumerate(zero_m):
    for site in range(6):
        if not ((b>>site)&1):Splus[index4[b|(1<<site)]][j]+=1
basis,free=nullspace(Splus)
assert len(basis)==5 and len(free)==5
B=transpose(basis)
G=mm(transpose(B),B)
def pair_swap(a,b):
    out=zeros(20);mask=(1<<a)|(1<<b)
    index={bits:i for i,bits in enumerate(zero_m)}
    for j,bits in enumerate(zero_m):
        alt=bits^mask if ((bits>>a)&1)!=((bits>>b)&1) else bits
        out[index[alt]][j]=F(1)
    return out
def restrict(M):
    Y=mm(M,B)
    X=[Y[j][:] for j in free]
    assert mm(B,X)==Y
    return X
I5=ident(5)
def K(i,j):
    S=restrict(pair_swap(i,j))
    return scale(sub(S,scale(I5,F(1,2))),F(1,2))
A=K(0,1)
D=add(K(0,1),K(1,2))
V=add(add(K(2,3),K(3,4)),K(4,5))
U=restrict(pair_swap(3,4))
assert mm(A,A)==sub(scale(I5,F(3,16)),scale(A,F(1,2)))
assert mm(A,add(scale(A,F(16,3)),scale(I5,F(8,3))))==I5
assert mm(transpose(U),mm(G,U))==G and mm(U,U)==I5
assert mm(U,K(0,1))==mm(K(0,1),U)
assert mm(U,K(1,2))==mm(K(1,2),U)

H=zeros(10)
for i in range(5):
    for j in range(5):
        H[i][j]=D[i][j]+V[i][j]
        H[5+i][5+j]=D[i][j]
        H[i][5+j]=H[5+i][j]=A[i][j]
P=ident(10)
for i in range(5,10):P[i][i]=0
Q=sub(ident(10),P)
def QXP(X):
    Y=mm(Q,mm(X,P))
    return [r[:5] for r in Y[5:]]
assert QXP(H)==A
assert any(v for row in A for v in row)
# For each fixed two-outcome measurement family and any of the source's
# three update prescriptions J0/J1/Jhalf:
# all Kraus actions are register-block diagonal; sum L†L=gamma I.
# Thus Q L P=0, and Q K_eff P = -i Q H P = -i A for rate gamma.
# The nonorthogonal singlet basis is handled via physical Gram G.
sing12=sub(scale(I5,F(1,4)),A)
trip12=sub(I5,sing12)
K23=K(1,2)
sing23=sub(scale(I5,F(1,4)),K23)
trip23=sub(I5,sing23)
for projector in (sing12,trip12,sing23,trip23):
    assert mm(projector,projector)==projector
    assert mm(U,projector)==mm(projector,U)
assert add(sing12,trip12)==I5
assert add(sing23,trip23)==I5
assert all(QXP(scale(ident(10),F(rate,2)))==zeros(5)
           for rate in (1,2,3,7))

# SRN-5--7: necessary physical-carrier / memory consequences.
# Independently supplied H_lambda remains a DECLARED 10D source; a closed
# mathematical carrier is not an identified conscious particular.
M=add(D,V)
Ainv=add(scale(A,F(16,3)),scale(I5,F(8,3)))
assert mm(A,Ainv)==I5 and mm(Ainv,A)==I5
Eup=zeros(10,5)
Edn=zeros(10,5)
for i in range(5):
    Eup[i][i]=F(1)
    Edn[5+i][i]=F(1)
memory_tests=0
for lam in (F(0),F(1),F(-1),F(2),F(1,3)):
    HL=zeros(10)
    for i in range(5):
        for j in range(5):
            HL[i][j]=M[i][j]
            HL[5+i][5+j]=D[i][j]
            HL[i][5+j]=HL[5+i][j]=lam*A[i][j]
    if lam==1: assert HL==H  # exact inherited model
    assert mm(HL,Eup)==add(mm(Eup,M),mm(Edn,scale(A,lam)))
    if lam:
        # Every DOWN basis direction lies in span(UP,HL UP), so the
        # smallest HL-invariant subspace containing ALL UP is full 10D.
        witness=scale(Ainv,1/lam)
        assert sub(mm(HL,mm(Eup,witness)),mm(Eup,mm(M,witness)))==Edn
    else:
        assert mm(HL,Eup)==mm(Eup,M)  # decoupled positive control
    # UP(HL^2)(UP) = M^2 + lam^2 A^2, which differs from a
    # time-homogeneous 5D autonomous UP-only amplitude generator.
    upper_second=mm(HL,mm(HL,Eup))[:5]
    memory_K0=scale(mm(A,A),lam*lam)
    assert sub(upper_second,mm(M,M))==memory_K0
    assert (memory_K0==zeros(5)) == (lam==0)
    memory_tests+=1
# Two full physical vectors (x,y) and (x,-y) have the same UP
# component and the same physical norm, but different UP derivatives.
x0=[[F(1)] if i==0 else [F(0)] for i in range(5)]
assert mm(A,x0)!=zeros(5,1)
assert mm(transpose(x0),mm(G,x0))[0][0]>0
assert mm(A,scale(x0,2))!=zeros(5,1)
# Thus instantaneous UP amplitude alone is not a complete predictive
# record when initial DOWN data may vary; no identity inference follows.

print(json.dumps({
    "status":"PASS exact author-side reconstruction, not scientific acceptance",
    "zero_magnetization_dimension":len(zero_m),
    "four_up_dimension":len(higher),
    "singlet_kernel_dimension":len(basis),
    "source_register_coupling_block_rank":5,
    "K12_quadratic_and_inverse_exact":True,
    "Gram_nonorthogonal":any(G[i][j] for i in range(5) for j in range(5) if i!=j),
    "Swap45_physical_unitary_and_commutes_with_frozen_pair_outcomes":True,
    "finite_rate_measurement_K_eff_has_nonzero_QKP":True,
    "source_carrier_memory_lambda_controls_checked":memory_tests,
    "span_all_UP_plus_H_UP_is_full_10D_if_lambda_nonzero":True,
    "UP_only_time_homogeneous_amplitude_generator_fails_second_derivative":True,
    "instantaneous_UP_amplitude_not_predictively_sufficient_for_arbitrary_DOWN_initial_data":True,
    "register_only_no_go_if_lambda_nonzero":True,
    "physical_environment_complete":False,
    "conscious_subject_or_original_X3_proven":False
},indent=2,sort_keys=True))
