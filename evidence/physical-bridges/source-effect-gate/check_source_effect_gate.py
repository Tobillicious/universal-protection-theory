#!/usr/bin/env python3
"""SEG-1..5 exact conditional 6x2 source/actuator boundary.
Exploratory source only: no actual BCRD, consent, consciousness or protection theorem.
"""
from itertools import product
import json

N=6
POS=(0,2,5)
NEG=(1,3,4)
def identity(n):
    return [[1+0j if i==j else 0j for j in range(n)] for i in range(n)]
def mul(a,b):
    assert len(a[0])==len(b)
    return [[sum(a[i][k]*b[k][j] for k in range(len(b)))
             for j in range(len(b[0]))] for i in range(len(a))]
def dag(a):
    return [[a[j][i].conjugate() for j in range(len(a))]
            for i in range(len(a[0]))]
def kron(a,b):
    return [[a[i//len(b)][j//len(b[0])]*b[i%len(b)][j%len(b[0])]
             for j in range(len(a[0])*len(b[0]))]
            for i in range(len(a)*len(b))]
def perm(spec):
    out=[[0j for _ in spec] for _ in spec]
    for j,(dest,phase) in enumerate(spec):out[dest][j]=phase
    return out
# Exact pi/2 pulses of inherited H1 and H2; 0=A0,1=A1,2=B0,3=B1,4=C0,5=C1.
U1=perm(((2,-1j),(1,-1),(0,-1j),(3,-1),(4,1),(5,1)))
U2=perm(((0,1),(1,1),(5,-1j),(4,-1j),(3,-1j),(2,-1j)))
# Extra hypothetical *unmediated* parity-flipping source operation, not source H1/H2.
V=perm(((1,1),(0,1),(3,1),(2,1),(5,1),(4,1)))
I6=identity(6)
I2=identity(2)
X2=[[0j,1+0j],[1+0j,0j]]
def parity_closed(u):
    return all(u[i][j]==0 for i in POS for j in NEG) and all(
        u[i][j]==0 for i in NEG for j in POS)
def enabled(auth,safe,service,spoof,forced):
    # z=spoof and f=forced causal participation are not authorization.
    return bool(auth and safe and service)
def word(seq):
    u=I6
    for x in seq:u=mul(U1 if x==1 else U2,u)
    return u
def dispatch(u,auth,safe,service,spoof,forced):
    g=enabled(auth,safe,service,spoof,forced)
    return kron(u,X2 if g else I2)
def run():
    assert mul(dag(U1),U1)==I6 and mul(dag(U2),U2)==I6
    assert mul(dag(V),V)==I6
    assert parity_closed(U1) and parity_closed(U2) and not parity_closed(V)
    assert mul(U1,U2)!=mul(U2,U1)
    assert U1[2][0]==-1j and U2[5][2]==-1j
    checked=0
    for length in range(6):
        for seq in product((1,2),repeat=length):
            u=word(seq)
            assert mul(dag(u),u)==I6 and parity_closed(u)
            for a,s,r,z,f in product((False,True),repeat=5):
                g=enabled(a,s,r,z,f)
                total=dispatch(u,a,s,r,z,f)
                assert total==kron(u,X2 if g else I2)
                assert mul(dag(total),total)==identity(12)
                assert g == (a and s and r)
                for old in range(N):
                    for new in range(N):
                        assert total[2*new+(1 if g else 0)][2*old]==u[new][old]
                        assert total[2*new+(0 if g else 1)][2*old]==0
                checked+=1
    assert checked==2016
    allowed=dispatch(U2,True,True,True,False,False)
    denied=dispatch(U2,True,True,False,False,False)
    assert allowed!=denied and allowed[11][4]==-1j and denied[10][4]==-1j
    assert not enabled(False,True,True,True,True)  # spoof & forced reaction
    assert not enabled(True,False,True,False,False) # consent not enough
    # If authentic a=0 but attack changes *trusted* gate input to a'=1,
    # the physical effect toggles without consent; authentication is a premise.
    true_auth=False
    forged_gate_auth=True
    assert not true_auth and enabled(forged_gate_auth,True,True,False,False)
    # A source bypass changes a parity-protected process even when g=0.
    for u in (I6,U1,U2,mul(U1,U2)):
        bypass=mul(V,u)
        assert not parity_closed(bypass) and kron(bypass,I2)!=kron(u,I2)
    # Parity preservation alone does not retain a particular physical state.
    assert parity_closed(mul(U1,U2)) and mul(U1,U2)!=I6
    return {
       'status':'PASS: finite source/effect toy; NOT real physical BCRD validation',
       'source_sequences_tested':63,
       'authorization_and_attack_inputs_per_word':32,
       'exact_unitary_operator_cases':checked,
       'joint_H1_H2_noncommuting_and_nontrivial':True,
       'source_transparency':True,
       'independent_safe_authorized_service':True,
       'spoof_coerced_causal_participation_rejected':True,
       'consent_without_separate_safety_rejected':True,
       'compromised_trusted_auth_counterexample':True,
       'unmediated_source_bypass_counterexample':True,
       'physical_mediation_derived':False,
       'continuing_particular_or_original_X3_proven':False,
    }
if __name__=='__main__':
    print(json.dumps(run(),indent=2,sort_keys=True))
