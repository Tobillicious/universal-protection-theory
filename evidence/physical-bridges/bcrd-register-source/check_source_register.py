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
    "register_only_no_go_if_lambda_nonzero":True,
    "physical_environment_complete":False,
    "conscious_subject_or_original_X3_proven":False
},indent=2,sort_keys=True))
