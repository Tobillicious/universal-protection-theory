#!/usr/bin/env python3
"""QND-1..5: exact source observables and full register-diagonal commutant.
Author-side exact rational proof test; not an instrument installation or X3.
"""
from fractions import Fraction as F
from contextlib import redirect_stdout
from pathlib import Path
from itertools import product
import io,runpy,json
ROOT=Path(__file__).resolve().parent
with redirect_stdout(io.StringIO()):
    m=runpy.run_path(str(ROOT/'check_source_register.py'))
mm,add,sub,scale,zeros,ident,trans=(m[k] for k in ('mm','add','sub','scale','zeros','ident','transpose'))
A,D,V,H,G=(m[k] for k in ('A','D','V','H','G'))
B=add(D,V)
Ai=add(scale(A,F(16,3)),scale(ident(5),F(8,3)))
assert mm(A,Ai)==ident(5) and mm(Ai,A)==ident(5)

def comm(X,Y):return sub(mm(X,Y),mm(Y,X))
def nozero(X):return any(v for row in X for v in row)
def lift(X):
    T=zeros(10)
    for i,j in product(range(5),repeat=2):
        T[i][j]=X[i][j];T[i+5][j+5]=X[i][j]
    return T

def matrix_rank(rows):
    r=0
    R=[x[:] for x in rows]
    for j in range(len(R[0])):
        pivot=next((i for i in range(r,len(R)) if R[i][j]!=0),None)
        if pivot is None:continue
        R[r],R[pivot]=R[pivot],R[r]
        v=R[r][j]
        R[r]=[x/v for x in R[r]]
        for i in range(r+1,len(R)):
            if R[i][j]:
                c=R[i][j]
                R[i]=[R[i][k]-c*R[r][k] for k in range(len(R[0]))]
        r+=1
        if r==len(R):break
    return r

Pup=m['PUP'] if 'PUP' in m else m['P']
Sing12=lift(m['sing12']);Sing23=lift(m['sing23'])
Swap45=lift(m['Swap45'] if 'Swap45' in m else m['U'])
effects={'UP':Pup,'pair12_singlet':Sing12,'pair23_singlet':Sing23,'post_outcome_Swap45':Swap45}
counts={name:sum(bool(v) for row in comm(X,H) for v in row) for name,X in effects.items()}
assert all(v>0 for v in counts.values())
assert not nozero(comm(H,H))
assert mm(Swap45,Swap45)==ident(10)
C=[list(v for row in comm(X,H) for v in row) for X in effects.values()]
assert matrix_rank([[C[j][i] for j in range(4)] for i in range(100)])==4

# ANY O=diag(C,E) commuting with H must be scalar.
# [C,B]=0, [E,D]=0, CA=AE, E=A^-1 C A.
# The first two constraints define a 50 x 25 exact linear matrix.
columns=[]
for i,j in product(range(5),repeat=2):
    Cij=zeros(5);Cij[i][j]=F(1)
    Eij=mm(mm(Ai,Cij),A)
    constrained=comm(Cij,B)+comm(Eij,D)
    columns.append([v for row in constrained for v in row])
rows=[[columns[j][i] for j in range(25)] for i in range(50)]
constraint_rank=matrix_rank(rows)
assert constraint_rank==24
minor_rows=(0,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,21,25,26,27,28)
def determinant(M):
    W=[row[:] for row in M];d=F(1);n=len(W)
    for k in range(n):
        i=next((i for i in range(k,n) if W[i][k]),None)
        if i is None:return F(0)
        if i!=k:W[k],W[i]=W[i],W[k];d=-d
        p=W[k][k];d*=p
        for i in range(k+1,n):
            f=W[i][k]/p
            if f:W[i]=[W[i][j]-f*W[k][j] for j in range(n)]
    return d
minor_det=determinant([[rows[i][j] for j in range(24)] for i in minor_rows])
assert minor_det==F(-3519,65536)
assert not nozero(comm(ident(5),B))
assert not nozero(comm(mm(mm(Ai,ident(5)),A),D))

# H itself is conserved and physically self-adjoint, but not
# register-block-diagonal nor an installed supplied readout.
G10=zeros(10)
for i,j in product(range(5),repeat=2):
    G10[i][j]=G[i][j];G10[i+5][j+5]=G[i][j]
assert mm(G10,H)==mm(trans(H),G10)
assert nozero([row[5:] for row in H[:5]])

# No collection of stationary effects identifies all dynamical phases:
# rho_tau=U(tau)rho Udag has exactly the same expectation for each
# commuting effect, while a source pair23 outcome changes at first order.
with redirect_stdout(io.StringIO()):
    cr=runpy.run_path(str(ROOT/'check_causal_record.py'))
probe=cr['p'] if 'p' in cr else cr['density'](1)
d_rho=(cr['derivative'](cr['HH'],probe) if 'derivH' not in cr
       else cr['derivH'](cr['HH'],probe))
probe_slope=cr['expectation'](cr['Psing'],cr['marginal'](d_rho))
assert probe_slope==(F(-3,8),F(0))

# Decoupled lambda=0 control restores register-UP conservation.
H0=zeros(10)
for i,j in product(range(5),repeat=2):
    H0[i][j]=B[i][j];H0[i+5][j+5]=D[i][j]
assert not nozero(comm(Pup,H0))

print(json.dumps({
 'status':'PASS exact declared-source nondemolition audit',
 'supplied_effect_commutator_nonzero_counts':counts,
 'independent_supplied_effect_commutator_rank':4,
 'arbitrary_register_block_diagonal_commutant_constraint_rank':constraint_rank,
 'arbitrary_register_block_diagonal_commutant_dimension':1,
 'exact_24x24_minor_determinant':str(minor_det),
 'only_block_diagonal_stationary_observables':'scalar identity',
 'source_H_itself_is_conserved_and_cross_register':True,
 'source_pair23_singlet_initial_slope':str(probe_slope[0]),
 'stationary_effects_see_same_source_under_time_shift':'analytic theorem',
 'register_UP_commutes_with_decoupled_lambda0_control':True,
 'single_system_nondestructive_readout_instrument_constructed':False,
 'real_BCRD_ambient_generator_inventory_derived':False,
 'mind_identity_or_maximal_X3_proved':False
},indent=2,sort_keys=True))
