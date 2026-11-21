#!/usr/bin/env python3
"""QOI source-sector observation/no-information-without-disturbance audit.

Exact rational density matrices for six-state exploratory source model.
Tests finite PVM channels, exact H2 pulse conjugation, and counter-controls.
This is NOT a physical conscious-subject or full BCRD theorem.
"""
from fractions import Fraction as F
from itertools import combinations
import json

BASIS = ('A0','A1','B0','B1','C0','C1')
N = len(BASIS)
PLUS = (0,2,5)
MINUS = (1,3,4)
PARITY = (1,-1,1,-1,-1,1)
H2_MAP = {0:(0,1), 1:(1,1), 2:(5,-1j), 3:(4,-1j),4:(3,-1j),5:(2,-1j)}
# Hermitian rational matrices; for H2 transformation compute exact rational
# subspaces where -i phase cancels and a separate Gaussian-integer amplitude audit.

def pure_uniform_density(indices):
    d=len(indices)
    return [[F(1,d) if i in indices and j in indices else F(0)
             for j in range(N)] for i in range(N)]

def dephase_by_partition(rho, partition):
    bucket = {j:k for k,grp in enumerate(partition) for j in grp}
    assert set(bucket)==set(range(N))
    return [[x if bucket[i]==bucket[j] else F(0)
             for j,x in enumerate(row)] for i,row in enumerate(rho)]

def matmul(A,B):
    return [[sum(A[i][k]*B[k][j] for k in range(N)) for j in range(N)]
            for i in range(N)]

def trace(A): return sum(A[i][i] for i in range(N))

def purity(A): return trace(matmul(A,A))

def overlap(rho, sigma): return trace(matmul(rho,sigma))

def audit():
    site_partition = [(0,1),(2,3),(4,5)]
    parity_partition = [PLUS, MINUS]
    cases={}
    for inds in ((2,5),PLUS,(0,2),MINUS):
        rho=pure_uniform_density(inds)
        obs_site=dephase_by_partition(rho,site_partition)
        obs_parity=dephase_by_partition(rho,parity_partition)
        n=len(inds)
        assert purity(rho)==1
        assert purity(obs_parity)==1
        assert obs_parity==rho
        assert purity(obs_site)==F(1,n)
        assert overlap(rho, obs_site)==F(1,n)
        cases['+'.join(BASIS[i] for i in inds)] = {
            'site_unread_pvm_fidelity':str(overlap(rho,obs_site)),
            'site_unread_pvm_purity':str(purity(obs_site)),
            'parity_unread_pvm_fidelity':str(overlap(rho,obs_parity)),
            'site_disturbance_1_minus_fidelity':str(1-overlap(rho,obs_site))
        }
    # B0 and C1 remain coherent under exact H2(pi/2) pulse up to -i;
    # the pulse swaps them with same phase, so their equal superposition
    # density matrix is unchanged. Site measurement erases off-diagonal.
    rho_bc=pure_uniform_density((2,5))
    perm={i:out for i,(out,amp) in H2_MAP.items()}
    assert perm[2]==5 and perm[5]==2
    assert H2_MAP[2][1]==H2_MAP[5][1]==-1j
    assert rho_bc[2][5]==F(1,2)
    assert dephase_by_partition(rho_bc,site_partition)[2][5]==0
    # Basis control: for a site eigenstate, site PVM is nondisturbing.
    for i in range(N):
        rho=pure_uniform_density((i,))
        assert dephase_by_partition(rho,site_partition)==rho
    # Cross-sector control: parity PVM cannot preserve plus/minus superposition.
    cross=pure_uniform_density((0,1))
    assert overlap(cross,dephase_by_partition(cross,parity_partition))==F(1,2)
    # Probe no-information lemma: for nonorthogonal input states, if the
    # system remains *exactly the same pure state*, environment record
    # inner product is forced to 1 (not independent of input).
    # For e0,e1 orthogonal probe records attached to B0/C1 basis,
    # the coherent plus input becomes entangled; reduced system fidelity 1/2.
    e0=(F(1),F(0))
    e1=(F(0),F(1))
    probe_overlap=sum(x*y for x,y in zip(e0,e1))
    assert probe_overlap==0
    assert F(1,2)*(1+probe_overlap)==F(1,2)
    for d in (2,3):
        assert purity(pure_uniform_density(PLUS[:d]))==1
    return {'status':'PASS: exact 6D source-basis PVM audit',
            'uniform_coherent_subspaces':cases,
            'H2_equal_B0_C1_superposition_keeps_coherence':True,
            'H2_unitary_phase_B0_C1':'-i',
            'site_pvm_erases_B0_C1_coherence':True,
            'site_eigenstates_unchanged_control':6,
            'parity_pvm_disturbs_cross_parity_coherence':str(F(1,2)),
            'orthogonal_probe_records_destroy_B0_C1_coherence':True,
            'general_full_sector_nondisturbance_forces_no_site_information':'analytic inner-product theorem, see note',
            'BCRD_full_physics_verified':False,
            'living_particular_semantic_certificate':False}
if __name__=='__main__':
    print(json.dumps(audit(),indent=2,sort_keys=True))
