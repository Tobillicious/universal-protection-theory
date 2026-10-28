#!/usr/bin/env python3
"""AOR-1--6: exact finite 10D source + 2D pointer audits.
Apparatus couplings explicitly postulated, NOT derived from BCRD physics.
No empirical mind, physical protection, consent or X3 inference.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
from itertools import product
import runpy,io,json
with redirect_stdout(io.StringIO()):
    s=runpy.run_path(str(Path(__file__).parent/'check_nondisturbing_readout.py'))
cr=s['s']
Z,ONE,IM,NIM=(s[k] for k in ('Z','ONE','IM','NIM'))
g,ga,gm,gc,gz,gmm,gd,gsc,gtrace=(s[k] for k in ('g','ga','gm','gc','gz','gmm','gd','gsc','gtrace'))
HH=s['HH']; GG=s['GG']; m=cr['m']
tog=cr.get('asg',cr.get('to_g'))
Pup=tog(m.get('P',m.get('PUP'))); Psing=s['Psing']
ident=m['ident'];N=10
def add(a,b):
    return [[ga(a[i][j],b[i][j]) for j in range(len(a[0]))] for i in range(len(a))]
def negative(a):return [[(-x[0],-x[1]) for x in row] for row in a]
def sub(a,b):return add(a,negative(b))
def comm(a,b):return sub(gmm(a,b),gmm(b,a))
def trace(a):return gtrace(a)
def ptr(reg):
    T=gz(N,N)
    for i,j in product(range(N),repeat=2):
        T[i][j]=ga(reg[2*i][2*j],reg[2*i+1][2*j+1])
    return T
def direct_product(a,b):
    size,k=len(a),len(b);out=gz(size*k,size*k)
    for i,j,u,v in product(range(size),range(size),range(k),range(k)):
        out[i*k+u][j*k+v]=gm(a[i][j],b[u][v])
    return out
X=[[Z,ONE],[ONE,Z]]
IA=[[ONE,Z],[Z,ONE]]
ZA=[[ONE,Z],[Z,g(-1)]]
I10=tog(ident(10));Qup=sub(I10,Pup)
UP=add(direct_product(Pup,X),direct_product(Qup,IA))
assert gmm(UP,UP)==direct_product(I10,IA)
assert gmm(direct_product(GG,IA),UP)==gmm(gd(UP),direct_product(GG,IA))
HS=direct_product(HH,IA)
assert comm(HS,UP)!=gz(20,20)
def input_state(z):
    v=gz(N,1);v[0][0]=ONE;v[6][0]=z
    assert gmm(gd(v),gmm(GG,v))[0][0]==g(16)
    return v
def density_of(v):return gsc(gmm(gmm(v,gd(v)),GG),g(F(1,16)))
def measure_source(rho):
    return add(gmm(gmm(Pup,rho),Pup),gmm(gmm(Qup,rho),Qup))
states={key:density_of(input_state(phase)) for key,phase in
    [('plus_1',ONE),('minus_1',g(-1)),('plus_i',IM),('minus_i',NIM)]}
reduced=[measure_source(rho) for rho in states.values()]
assert all(x==reduced[0] for x in reduced)
for key,rho in states.items():
    assert trace(gmm(Pup,rho))==g(F(1,2))
    assert trace(gmm(Qup,rho))==g(F(1,2))
    assert measure_source(rho)!=rho
D0=[[ONE,Z],[Z,Z]]
for key,rho in states.items():
    out=gmm(gmm(UP,direct_product(rho,D0)),UP)
    assert ptr(out)==measure_source(rho)==reduced[0]
changes={}
for key,rho in states.items():
    delta=trace(gmm(HH,sub(measure_source(rho),rho)))
    assert delta[1]==0
    changes[key]=str(delta[0])
assert changes=={'plus_1':'3/8','minus_1':'-3/8','plus_i':'0','minus_i':'0'}
D=lambda r:s['derivH'](HH,r)
future_before={key:trace(gmm(Psing,s['marginal'](D(r)))) for key,r in states.items()}
future_after={key:trace(gmm(Psing,s['marginal'](D(measure_source(r))))) for key,r in states.items()}
assert future_before=={'plus_1':Z,'minus_1':Z,'plus_i':g(F(-3,8)),'minus_i':g(F(3,8))}
assert all(x==Z for x in future_after.values())
# Positive *proposed* energy-phase meter: H_int=H⊗Z.
Hint=direct_product(HH,ZA)
assert comm(HS,Hint)==gz(20,20)
G20=direct_product(GG,IA)
assert gmm(gd(Hint),G20)==gmm(G20,Hint)
assert comm(HH,states['plus_1'])!=gz(10,10)
assert comm(HH,states['plus_i'])!=gz(10,10)
# Pointer initially |+x>, U(theta)=exp(-i theta H⊗Z).
# Analytically d <sigma_y>/dtheta at theta=0 = 2 Tr(H rho).
energy={key:trace(gmm(HH,r)) for key,r in states.items()}
assert energy['plus_1'][0]-energy['plus_i'][0]==F(-3,8)
assert 2*(energy['plus_1'][0]-energy['plus_i'][0])==F(-3,4)
# Unobserved pointer dephases energy coherences in a generic state.
for key,rho in states.items():
    assert comm(HH,comm(HH,rho))!=gz(10,10)
    assert trace(gmm(HH,comm(HH,comm(HH,rho))))==Z
print(json.dumps({
 'status':'PASS exact declared BCRD source plus hypothetical two-state apparatus',
 'apparatus_size':2,'total_dimension':20,
 'register_measurement_unitary_G_preserving':True,
 'register_pointer_outcome_up_probability_all_four':'1/2',
 'postmeasurement_source_states_all_equal':True,
 'source_pair23_future_slope_after_unread_pointer':'0 all four phases',
 'source_energy_change_after_register_measurement':changes,
 'register_pointer_unitary_commutes_with_source_energy':False,
 'energy_sensitive_HtensorZ_coupling_commutes_with_source_H':True,
 'energy_pointer_slope_gap_plus_1_vs_plus_i':'-3/4',
 'unread_energy_pointer_disturbs_generic_nonstationary_states':True,
 'source_apparatus_coupling_physically_derived_from_BCRD':False,
 'actual_original_particular_identity_or_X3_proven':False
},indent=2,sort_keys=True))
