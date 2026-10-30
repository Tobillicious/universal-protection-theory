#!/usr/bin/env python3
"""TRF-1..5: sharp environmental truncation and actual 10D source-future error.
Exact rational arithmetic from adjacent source reconstruction. Non-canonical.
No empirical BCRD, mind semantics, actual consent or original X3 inference.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
from itertools import product
import io,runpy,json,math
with redirect_stdout(io.StringIO()):
    m=runpy.run_path(str(Path(__file__).parent/'check_source_register.py'))
mm,add,sub,scale=(m[x] for x in ('mm','add','sub','scale'))
zeros,ident,trans=(m[x] for x in ('zeros','ident','transpose'))
A,G,D,V=(m[x] for x in ('A','G','D','V'))
B=add(D,V)
I5=ident(5)

# Environmental Schmidt-aligned projection: exact SHARP 2*(1-p) bound.
weights=(F(1,4),)*4
for k in (1,2,3,4):
    p=sum(weights[:k],F(0))
    post=[weights[i]/p if i<k else F(0) for i in range(4)]
    assert sum((abs(weights[i]-post[i]) for i in range(4)),F(0))==2*(1-p)

# Entropy decrease ≠ discarded tail entropy lower bound.
assert 2-math.log2(3) < F(1,2)

# The inherited K12 source coupling is physical-Gram-self-adjoint.
assert mm(trans(A),G)==mm(G,A)
assert mm(trans(B),G)==mm(G,B)
AA=mm(A,A)
assert add(AA,scale(A,F(1,2)))==scale(I5,F(3,16))
# e1: exact source singlet-kernel basis column with positive A variance.
v=[[F(int(i==1))] for i in range(5)]
norm=mm(trans(v),mm(G,v))[0][0]
mean=mm(trans(v),mm(G,mm(A,v)))[0][0]/norm
expect2=mm(trans(v),mm(G,mm(AA,v)))[0][0]/norm
variance=expect2-mean*mean
assert norm==8 and mean==0 and expect2==variance==F(3,16)
# In a nonorthogonal basis the physical density is v v^T G/(v^T G v).
rho=scale(mm(v,mm(trans(v),G)),1/norm)
assert mm(rho,rho)==rho and sum(rho[i][i] for i in range(5))==1
# The exact matter reduced-density Taylor discrepancy, full H vs B-only:
# delta2 = A rho A - {A^2,rho}/2.
delta2=sub(mm(A,mm(rho,A)),scale(add(mm(AA,rho),mm(rho,AA)),F(1,2)))
assert sum(delta2[i][i] for i in range(5))==0
expect_delta=sum(mm(rho,delta2)[i][i] for i in range(5))
assert expect_delta==-variance==-F(3,16)

# Independent second-derivative reconstruction from full original H.
H=m['H']
initial=[[F(0)] for _ in range(10)]
for i in range(5): initial[i]=v[i][:]
Hv=mm(H,initial);H2v=mm(H,Hv)
assert Hv[:5]==mm(B,v)
assert Hv[5:]==mm(A,v)
assert H2v[:5]==add(mm(B,mm(B,v)),mm(AA,v))

controls={}
for lam in (F(0),F(1),F(-1),F(2),F(1,3)):
    future=lam*lam*variance
    assert (future==0)==(lam==0)
    controls[str(lam)]={'initial_trace_error':'0',
                       'future_test_probability_gap_t2_coefficient':str(future),
                       'down_occupation_t2_coefficient':str(lam*lam*expect2)}

# Analytic norm corollary: from eigenvalues -3/4 and 1/4,
# ||A||_physical=3/4. Duhamel implies
# T(rho_full_matter(t),rho_B(t)) <= min(1,3|lam*t|/4).
print(json.dumps({
 'status':'PASS exact six-spin truncation/future error audit',
 'source_schmidt_sharpness_tests':4,
 'sharp_general_reduced_trace_norm_bound':'2*(1-p) (analytic proof)',
 'entropy_lower_bound_refuted':'2-log2(3)<1/2',
 'source_e1_variance_A':str(variance),
 'source_reduced_density_delta2_test_expectation':str(expect_delta),
 'future_gap_lambda_controls':controls,
 'analytic_time_trace_distance_upper_bound':'min(1,3|lambda*t|/4)',
 'initial_reduced_error_is_zero':True,
 'nonzero_future_gap_for_original_lambda1':True,
 'actual_subject_identity_or_universal_X3_proved':False
},indent=2,sort_keys=True))
