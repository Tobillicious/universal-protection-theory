#!/usr/bin/env python3
"""Exact Gaussian-rational 6x6 matrices: reversible coherent source echo.
Inherited H1/H2 exploratory source; independently postulated V and controller K.
NOT protection from arbitrary or irreversible attacks. No subject semantics.
"""
from fractions import Fraction as F
import json

N=6
BASIS=('A0','A1','B0','B1','C0','C1')
def z(r=0,i=0): return F(r),F(i)
ZERO=z()
ONE=z(1)
MINUS_I=z(0,-1)
def add(x,y):return x[0]+y[0],x[1]+y[1]
def times(x,y):return x[0]*y[0]-x[1]*y[1],x[0]*y[1]+x[1]*y[0]
def scale(x,a):return x[0]*F(a),x[1]*F(a)
def matrix():return [[ZERO for _ in range(N)] for _ in range(N)]
def diag(values):
    m=matrix()
    for i,v in enumerate(values):m[i][i]=z(v)
    return m
I=diag([1]*N)
K=diag([1,-1,1,-1,-1,1])
def sum_g(*items):
    accum=ZERO
    for x,y in items:accum=add(accum,times(x,y))
    return accum
def multiply(A,B):
    return [[sum_g(*((A[i][k],B[k][j]) for k in range(N)))
             for j in range(N)] for i in range(N)]
def product(*matrices):
    out=I
    for m in matrices:out=multiply(out,m)
    return out
def commutes(A,B):return multiply(A,B)==multiply(B,A)
def anticommutes(A,B):
    x=multiply(A,B);y=multiply(B,A)
    return all(add(x[i][j],y[i][j])==ZERO for i in range(N) for j in range(N))
def dagger(A):return [[(A[j][i][0],-A[j][i][1]) for j in range(N)] for i in range(N)]
def is_unitary(A):return product(dagger(A),A)==I

H1=matrix()
H2=matrix()
V=matrix()
for i,j,weight in ((0,2,1),(1,3,2)):
    H1[i][j]=H1[j][i]=z(weight)
for i,j in ((2,5),(3,4)):
    H2[i][j]=H2[j][i]=ONE
for i,j in ((0,1),(2,3),(4,5)):
    V[i][j]=V[j][i]=ONE

# Exact U2 = exp(-i*pi/2 H2): A fixed; B/C exchanged at phase -i.
U2=matrix()
for i in (0,1):U2[i][i]=ONE
for i,j in ((2,5),(3,4)):U2[i][j]=U2[j][i]=MINUS_I

# Exact U1 = exp(-i*pi/2 H1): A0/B0 exchanged with phase -i;
# A1/B1 acquire -1 due to their DOUBLE coupling; C fixed.
U1=matrix()
U1[0][2]=U1[2][0]=MINUS_I
for i in (1,3):U1[i][i]=z(-1)
for i in (4,5):U1[i][i]=ONE

# Exact unitary partial parity-odd disturbance Uv=3/5 I -4i/5 V.
Uv=[[add(scale(I[i][j],F(3,5)),times(z(0,F(-4,5)),V[i][j]))
     for j in range(N)] for i in range(N)]

def run():
    assert commutes(K,H1) and commutes(K,H2)
    assert anticommutes(K,V)
    assert commutes(H2,V) and not commutes(H1,V)
    assert all(is_unitary(m) for m in (U1,U2,Uv,K))
    assert product(K,Uv,K)==dagger(Uv)
    assert commutes(U2,Uv) and not commutes(U1,Uv)
    source2=product(U2,U2)
    assert product(K,U2,Uv,K,U2,Uv)==source2
    assert product(U2,Uv,U2,Uv)!=source2
    source1=product(U1,U1)
    assert product(K,U1,Uv,K,U1,Uv)!=source1
    # Parity-even perturbation survives kicks.
    Ueven=[[add(scale(I[i][j],F(3,5)),times(z(0,F(-4,5)),K[i][j]))
           for j in range(N)] for i in range(N)]
    assert is_unitary(Ueven)
    assert product(K,U2,Ueven,K,U2,Ueven)!=source2
    # Attacker only perturbs one half: no identical second interval.
    assert product(K,U2,K,U2,Uv)!=source2
    HV=multiply(H1,V)
    VH=multiply(V,H1)
    nonzero=sum(HV[i][j]!=VH[i][j] for i in range(N) for j in range(N))
    assert nonzero==4
    return {
        'status':'PASS exact Gaussian-rational six-state source echo audit',
        'source_H2_echo_exact_for_all_coherent_inputs':True,
        'source_H1_echo_counterexample':True,
        'H1_V_nonzero_commutator_entries':nonzero,
        'parity_even_disturbance_counterexample':True,
        'nonrepeated_attack_counterexample':True,
        'no_parity_kick_counterexample':True,
        'unrestricted_irreversible_harm_prevention':False,
        'physical_subject_identity_or_full_BCRD':False
    }
if __name__=='__main__':print(json.dumps(run(),indent=2,sort_keys=True))
