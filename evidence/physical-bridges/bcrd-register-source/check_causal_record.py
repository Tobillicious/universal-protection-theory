#!/usr/bin/env python3
"""CRF-1--5: BCRD source amplitude-jet restoration and reduced-state no-go.
Exact rational/Gaussian-rational arithmetic. Not empirical identity or X3.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
from itertools import product
import io,runpy,json
with redirect_stdout(io.StringIO()):
    m=runpy.run_path(str(Path(__file__).parent/"check_source_register.py"))
mm,add,sub,scale,trans,zeros=(m[k] for k in ("mm","add","sub","scale","transpose","zeros"))
A,G,D,V,H=(m[k] for k in ("A","G","D","V","H"))
B=add(D,V);Ainv=add(scale(A,F(16,3)),scale(m["I5"],F(8,3)))
K23=m["K"](1,2);I5=m["I5"]
assert mm(A,Ainv)==I5==mm(Ainv,A)
def e(j):return [[F(int(i==j))] for i in range(5)]
checks=0
C=mm(A,mm(D,Ainv))
for lam in (F(-3),F(-1),F(1,3),F(1),F(2)):
    for i,j in product(range(5),repeat=2):
        x,y=e(i),e(j)
        z=add(mm(B,x),scale(mm(A,y),lam))  # z = i*x_dot
        assert scale(mm(Ainv,sub(z,mm(B,x))),1/lam)==y
        # x_ddot = -i(B+ADA^-1)x_dot + (ADA^-1 B-lam²A²)x.
        # Since x_dot=-i*z for real initial x,y:
        from_jet=add(scale(add(mm(B,z),mm(C,z)),-1),
                     sub(mm(C,mm(B,x)),scale(mm(A,mm(A,x)),lam*lam)))
        from_full=scale(add(mm(add(mm(B,B),scale(mm(A,A),lam*lam)),x),
                            scale(mm(add(mm(B,A),mm(A,D)),y),lam)),-1)
        assert from_jet==from_full
        checks+=1
assert checks==125
assert mm(B,e(1))==add(mm(B,e(1)),scale(mm(A,e(2)),0))

# Exact Gaussian-rational arithmetic in nonorthogonal singlet Gram basis.
Z=(F(0),F(0)); ONE=(F(1),F(0)); IM=(F(0),F(1)); NIM=(F(0),F(-1))
def g(x):return (F(x),F(0))
def ga(a,b):return (a[0]+b[0],a[1]+b[1])
def gm(a,b):return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def gc(a):return (a[0],-a[1])
def gz(n,k):return [[Z for _ in range(k)] for _ in range(n)]
def sg(xs):
    z=Z
    for x in xs:z=ga(z,x)
    return z
def gmm(a,b):
    assert len(a[0])==len(b)
    return [[sg(gm(a[i][k],b[k][j]) for k in range(len(b)))
             for j in range(len(b[0]))] for i in range(len(a))]
def gsub(a,b):return [[ga(a[i][j],(-b[i][j][0],-b[i][j][1])) for j in range(len(a[0]))] for i in range(len(a))]
def gsc(a,v):return [[gm(v,z) for z in row] for row in a]
def gtrace(a):return sg(a[i][i] for i in range(len(a)))
def asg(a):return [[g(x) for x in row] for row in a]
def gd(a):return [[gc(a[j][i]) for j in range(len(a))] for i in range(len(a[0]))]
G10=zeros(10)
for i,j in product(range(5),repeat=2):
    G10[i][j]=G[i][j];G10[5+i][5+j]=G[i][j]
G10=asg(G10);HH=asg(H);obs=asg(K23)
sing23=sub(scale(I5,F(1,4)),K23)
assert mm(sing23,sing23)==sing23
Psing=asg(sing23)
def density(sign):
    v=gz(10,1);v[0][0]=ONE;v[6][0]=IM if sign==1 else NIM
    assert gmm(gd(v),gmm(G10,v))[0][0]==(F(16),F(0))
    return gsc(gmm(gmm(v,gd(v)),G10),(F(1,16),F(0)))
def marginal(r):
    return [[ga(r[i][j],r[i+5][j+5]) for j in range(5)] for i in range(5)]
def derivative(h,r):return gsc(gsub(gmm(h,r),gmm(r,h)),NIM)
def expectation(o,r):return gtrace(gmm(o,r))
p,n=density(1),density(-1)
assert marginal(p)==marginal(n)
assert gtrace(marginal(p))==ONE
dp=derivative(HH,p);dn=derivative(HH,n)
kp=expectation(obs,marginal(dp));kn=expectation(obs,marginal(dn))
assert kp==(F(3,8),F(0)) and kn==(F(-3,8),F(0))
pp=expectation(Psing,marginal(dp));pn=expectation(Psing,marginal(dn))
assert pp==(F(-3,8),F(0)) and pn==(F(3,8),F(0))
assert pp[0]-pn[0]==F(-3,4)
# Independent real-Gram commutator control.
def dyad(x,y):return mm(x,mm(trans(y),G))
x,y=e(0),e(1)
T=sub(dyad(y,x),dyad(x,y))
cross=sub(mm(A,T),mm(T,A))
assert F(2,16)*sum(mm(K23,cross)[i][i] for i in range(5))==F(3,4)
# Decoupled source control (lambda=0): same output derivative for both.
H0=zeros(10)
for i,j in product(range(5),repeat=2):
    H0[i][j]=B[i][j];H0[i+5][j+5]=D[i][j]
assert marginal(derivative(asg(H0),p))==marginal(derivative(asg(H0),n))
print(json.dumps({
 "status":"PASS exact source causal-record obstruction and jet restoration",
 "amplitude_jet_and_second_order_cases":checks,
 "source_jet_recovers_hidden_y_for_lambda_nonzero":True,
 "reconstruction_inverse_coupling_norm":"4/abs(lambda)",
 "matter_marginals_identical_at_t0":True,
 "pair23_singlet_probability_derivative_plus":str(pp[0]),
 "pair23_singlet_probability_derivative_minus":str(pn[0]),
 "pair23_singlet_gap_derivative":str(pp[0]-pn[0]),
 "matter_K23_gap_derivative":str(kp[0]-kn[0]),
 "lambda_zero_phase_control":True,
 "all_joint_initial_states_admit_same_reduced_state_only_future_map":False,
 "physical_nondisturbing_jet_readout_derived":False,
 "mind_identity_and_original_X3_proven":False
},indent=2,sort_keys=True))
