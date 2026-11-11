#!/usr/bin/env python3
"""Exact 6D source parity projection and finite-monitoring controls.
Additional V,W,ideal projected law and monitoring are independent toy inputs;
not physical BCRD, mind identity, consent or universal protection.
"""
from fractions import Fraction as F
import json
N=6
PLUS=(0,2,5)
MINUS=(1,3,4)
def zero():return [[F(0) for _ in range(N)] for _ in range(N)]
def eye():
    X=zero()
    for i in range(N):X[i][i]=F(1)
    return X
I=eye()
def diag(indices):
    X=zero()
    for i in indices:X[i][i]=F(1)
    return X
P=diag(PLUS)
Q=diag(MINUS)
C=zero()
for i in range(N):C[i][i]=F(1) if i in PLUS else F(-1)
H1=zero();H2=zero();V=zero();W=zero()
for a,b,v in ((0,2,1),(1,3,2)):
    H1[a][b]=H1[b][a]=F(v)
for a,b in ((2,5),(3,4)):
    H2[a][b]=H2[b][a]=F(1)
# Extra hypothetical parity-odd effect, not a source-derived attack.
for a,b in ((0,1),(2,3),(4,5)):
    V[a][b]=V[b][a]=F(1)
# Extra hypothetical within-plus effect: bypasses parity protection.
W[2][5]=W[5][2]=F(1)
def mul(A,B):
    return [[sum((A[i][k]*B[k][j] for k in range(N)),F(0))
             for j in range(N)] for i in range(N)]
def chain(*matrices):
    out=I
    for m in matrices:out=mul(out,m)
    return out
def add(A,B):return [[A[i][j]+B[i][j] for j in range(N)] for i in range(N)]
def sub(A,B):return [[A[i][j]-B[i][j] for j in range(N)] for i in range(N)]
def scl(A,a):return [[x*a for x in row] for row in A]
def zerop(A):return all(x==0 for row in A for x in row)
def comm(A,B):return sub(mul(A,B),mul(B,A))
def anticomm(A,B):return add(mul(A,B),mul(B,A))
def run():
    assert add(P,Q)==I and chain(P,Q)==zero()
    assert zerop(comm(C,H1)) and zerop(comm(C,H2))
    assert zerop(chain(Q,H1,P)) and zerop(chain(Q,H2,P))
    assert zerop(chain(P,H1,Q)) and zerop(chain(P,H2,Q))
    assert zerop(anticomm(C,V))
    assert zerop(chain(P,V,P)) and zerop(chain(Q,V,Q))
    assert not zerop(chain(Q,V,P))
    assert zerop(comm(C,W)) and not zerop(chain(P,W,P))
    assert chain(P,H1,P)[0][2]==1
    assert chain(P,H2,P)[2][5]==1
    assert not zerop(comm(H1,H2))
    grid=(-2,-1,0,1,2)
    checked=0
    for alpha in grid:
        for beta in grid:
            for g in grid:
                H=add(scl(H1,F(alpha)),scl(H2,F(beta)))
                assert chain(P,add(H,scl(V,F(g))),P)==chain(P,H,P)
                assert chain(P,add(H,scl(W,F(g))),P)==add(chain(P,H,P),scl(chain(P,W,P),F(g)))
                checked+=1
    assert checked==125
    # Finite block-diagonal energy penalty cannot cancel the nonzero
    # first-order B0 -> B1 matrix element due to V.
    D=zero()
    for i in range(N):D[i][i]=F(17 if i in MINUS else -3)
    assert chain(Q,add(add(H1,H2),add(V,D)),P)[3][2]==1
    assert chain(Q,add(add(H1,H2),D),P)[3][2]==0
    assert chain(V,V)==I
    trials={}
    for n in (1,2,4,8,16,32,64):
        a=F(1,2*n)
        c=(1-a*a)/(1+a*a)
        s=2*a/(1+a*a)
        assert c*c+s*s==1
        one=s*s
        ever=1-c**(2*n)
        assert F(0)<ever<=n*one<=F(1,n)
        trials[str(n)]={
            'checkpoint_rejection':str(one),
            'ever_rejected':str(ever) if n<=8 else 'strictly positive; rational exact check passed',
            'union_bound':str(F(1,n))
        }
    assert trials['1']['checkpoint_rejection']=='16/25'
    # Two histories with the same observation can require opposing decisions.
    common='B0 plus-parity source-operation'
    legal=(common,True)
    coerced=(common,False)
    assert legal[0]==coerced[0] and legal[1]!=coerced[1]
    return {
      'status':'PASS exact 6D projected-source audit',
      'source_H1_H2_both_nontrivial_in_plus':True,
      'parity_odd_V_projected_out':True,
      'parity_even_W_bypasses_constraint':True,
      'coefficient_combinations_checked':checked,
      'finite_energy_penalty_cross_sector_leakage':'nonzero first-order B0->B1',
      'finite_checkpoint_cases':trials,
      'authorization_identical_observation_no_go':True,
      'physically_installed_pre_effect_guard':False,
      'living_particular_and_universal_X3_proven':False
    }
if __name__=='__main__':
    print(json.dumps(run(),indent=2,sort_keys=True))
