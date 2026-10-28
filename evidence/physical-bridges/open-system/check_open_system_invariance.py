#!/usr/bin/env python3
"""OSB: exact six-dimensional GKSL support-invariance and hostile controls.
Inherited exploratory H1/H2; independently invented environmental jumps.
Pure standard library exact Gaussian rational arithmetic. NOT actual BCRD.
"""
from fractions import Fraction as F
from itertools import product
import json

N=6; PLUS=(0,2,5); MINUS=(1,3,4)
ZERO=(F(0),F(0)); ONE=(F(1),F(0))
def g(a=0,b=0): return (F(a),F(b))
def add(a,b): return (a[0]+b[0],a[1]+b[1])
def mul(a,b): return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def conj(a):return (a[0],-a[1])
def scale(a,x):return (a[0]*F(x),a[1]*F(x))
def zero():return [[ZERO for _ in range(N)] for _ in range(N)]
def diag(ds):
    m=zero()
    for i,x in enumerate(ds):m[i][i]=g(x)
    return m
def plus(A,B):return [[add(A[i][j],B[i][j]) for j in range(N)] for i in range(N)]
def scalar(A,x):return [[scale(v,x) for v in row] for row in A]
def minus(A,B):return plus(A,scalar(B,-1))
def sum_g(xs):
    value=ZERO
    for x in xs:value=add(value,x)
    return value
def mm(A,B):return [[sum_g(mul(A[i][k],B[k][j]) for k in range(N)) for j in range(N)] for i in range(N)]
def dagger(A):return [[conj(A[j][i]) for j in range(N)] for i in range(N)]
def triple(A,B,C):return mm(mm(A,B),C)
def block(A,rows,cols):return [[A[i][j] for j in cols] for i in rows]
def allzero(rows):return all(v==ZERO for row in rows for v in row)
def ket(i):
    a=zero();a[i][i]=ONE;return a
def effective(H,Ls):
    K=[[mul(g(0,-1),v) for v in row] for row in H]
    D=zero()
    for L in Ls:D=plus(D,mm(dagger(L),L))
    return minus(K,scalar(D,F(1,2)))
def lindblad(H,Ls,rho):
    K=effective(H,Ls)
    d=plus(mm(K,rho),mm(rho,dagger(K)))
    for L in Ls:d=plus(d,triple(L,rho,dagger(L)))
    return d
def criterion(H,Ls):
    return (all(allzero(block(L,MINUS,PLUS)) for L in Ls),
            allzero(block(effective(H,Ls),MINUS,PLUS)))

H1=zero(); H2=zero()
for i,j,a in ((0,2,1),(1,3,2)):H1[i][j]=H1[j][i]=g(a)
for i,j in ((2,5),(3,4)):H2[i][j]=H2[j][i]=ONE
L_d=diag([1,0,-1,0,0,1])
L_x=zero();L_x[3][2]=ONE
L_b=zero();L_b[2][2]=L_b[2][3]=ONE
H_c=zero();H_c[3][2]=g(0,F(1,2));H_c[2][3]=g(0,F(-1,2))

def run():
    assert allzero(block(H1,MINUS,PLUS)) and allzero(block(H2,MINUS,PLUS))
    assert not allzero(block(minus(mm(H1,H2),mm(H2,H1)),PLUS,PLUS))
    cases={
        "no_bath":([],True),
        "internal_dephasing":([L_d],True),
        "cross_sector_bath_jump":([L_x],False),
        "no_jump_backaction":([L_b],False)
    }
    final={}
    checked=0
    for a,b in product((-2,-1,0,1,2),repeat=2):
        H=plus(scalar(H1,a),scalar(H2,b))
        for key,(Ls,expected) in cases.items():
            jump,drift=criterion(H,Ls)
            assert (jump and drift)==expected
            if expected:
                for i in PLUS:
                    d=lindblad(H,Ls,ket(i))
                    assert allzero(block(d,MINUS,PLUS))
                    assert allzero(block(d,PLUS,MINUS))
                    assert allzero(block(d,MINUS,MINUS))
            final[key]={"jump_closed":jump,"effective_drift_closed":drift}
            checked+=1
    assert checked==100
    assert criterion(zero(),[L_b])==(True,False)
    assert effective(zero(),[L_b])[3][2]==g(F(-1,2))
    db=lindblad(zero(),[L_b],ket(2))
    assert db[3][2]==db[2][3]==g(F(-1,2))
    assert db[3][3]==ZERO  # population derivative misses backaction
    dx=lindblad(zero(),[L_x],ket(2))
    assert dx[3][3]==ONE and dx[2][2]==g(-1)
    assert H_c==dagger(H_c)
    assert not allzero(block(H_c,MINUS,PLUS))
    assert criterion(H_c,[L_b])==(True,True)
    for i in PLUS:
        d=lindblad(H_c,[L_b],ket(i))
        assert allzero(block(d,MINUS,PLUS))
        assert allzero(block(d,MINUS,MINUS))
    rho=zero()
    for i,j in product((0,2),repeat=2):rho[i][j]=g(F(1,2))
    dd=lindblad(zero(),[L_d],rho)
    assert dd[0][2]==dd[2][0]==g(-1)
    assert dd[0][0]==dd[2][2]==ZERO
    assert allzero(block(dd,MINUS,PLUS))
    return {
      "status":"PASS exact finite GKSL source-invariance model only",
      "source_coefficient_pairs":25,"coefficient_jump_family_checks":checked,
      "cases":final,
      "outbound_jump_population_derivative":"1 at B1 for initial B0",
      "backaction_QK_P":"-1/2 despite QL_P=0",
      "Hamiltonian_compensation_control":True,
      "within_sector_dephasing_coherence_derivative":"-1 at A0/B0",
      "physically_complete_BCRD_bath_derived":False,
      "original_X3_subject_continuation_proven":False
    }
if __name__=="__main__":print(json.dumps(run(),indent=2,sort_keys=True))
