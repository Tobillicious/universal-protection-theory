#!/usr/bin/env python3
"""NDR-1..5: exact source no-information-without-disturbance obstruction.
Declared six-spin 10D source; exact Gaussian-rational Gram algebra.
No quantum readout hardware, subject identity, or physical X3 established.
"""
from fractions import Fraction as F
from pathlib import Path
from contextlib import redirect_stdout
import json,io,runpy
with redirect_stdout(io.StringIO()):
    s=runpy.run_path(str(Path(__file__).parent/'check_causal_record.py'))
Z,ONE,IM,NIM=(s[k] for k in ('Z','ONE','IM','NIM'))
g,ga,gm,gc,gz,gmm,gd,gsc,gtrace=(s[k] for k in ('g','ga','gm','gc','gz','gmm','gd','gsc','gtrace'))
HH,GG,Psing=(s[k] for k in ('HH','GG','Psing'))
marginal,derivH,expectation=(s[k] for k in ('marginal','derivH','expectation'))
H0=s['H0']
def ket(phase):
    v=gz(10,1)
    v[0][0]=ONE;v[6][0]=phase
    norm=gmm(gd(v),gmm(GG,v))[0][0]
    assert norm==(F(16),F(0))
    return v
def gram_overlap(x,y):
    raw=gmm(gd(x),gmm(GG,y))[0][0]
    return gm(raw,g(F(1,16)))
def density(x):
    return gsc(gmm(gmm(x,gd(x)),GG),g(F(1,16)))
s1,si,sminus_i,sminus_1=(ket(q) for q in (ONE,IM,NIM,g(-1)))
r1,ri,rmi,rm1=(density(q) for q in (s1,si,sminus_i,sminus_1))
assert marginal(r1)==marginal(ri)==marginal(rmi)==marginal(rm1)
assert gram_overlap(s1,si)==(F(1,2),F(1,2))
assert gram_overlap(si,sminus_i)==Z
assert gram_overlap(s1,sminus_1)==Z
assert gm(gram_overlap(s1,si),gc(gram_overlap(s1,si)))==(F(1,2),F(0))
def slope(source,rho):
    return expectation(Psing,marginal(derivH(source,rho)))
slopes={k:slope(HH,r) for k,r in [('1',r1),('i',ri),('-i',rmi),('-1',rm1)]}
assert slopes=={
  '1':Z,'i':(F(-3,8),F(0)),'-i':(F(3,8),F(0)),'-1':Z}
assert slope(H0,r1)==slope(H0,ri)==slope(H0,rmi)==slope(H0,rm1)
# Orthogonal +/-i states admit an ideal global projective reading
# that preserves each promised input at measurement time.
assert gmm(ri,ri)==ri and gmm(rmi,rmi)==rmi
assert gmm(ri,rmi)==gz(10,10)
assert gmm(ri,si)==si and gmm(ri,sminus_i)==gz(10,1)
assert gmm(rmi,sminus_i)==sminus_i and gmm(rmi,si)==gz(10,1)
assert gmm(HH,ri)!=gmm(ri,HH) # Not QND during source evolution
# For nonorthogonal psi1/psii, source-preserving isometry plus pointer
# requires c=c*alpha; c!=0 forces alpha=1 (same apparatus record).
c=gram_overlap(s1,si)
assert c!=Z and gm(c,ONE)==c
for candidate in (Z,IM,NIM,g(-1),g(F(1,2)),ONE):
    assert (gm(c,candidate)==c)==(candidate==ONE)
# Orthogonal pair permits distinct pointers; previous CRF +/-i
# was NOT a universal non-disturbing-readout no-go.
assert gram_overlap(si,sminus_i)==Z
assert all(gm(Z,candidate)==Z for candidate in (Z,ONE,IM,NIM))
print(json.dumps({
 'status':'PASS exact source nonorthogonality and nondisturbance audit',
 'nonorthogonal_source_overlap':'(1+i)/2',
 'source_overlap_squared':'1/2',
 'nonorthogonal_pair_has_same_matter_marginal':True,
 'nonorthogonal_pair_future_pair23_singlet_slope_gap':'3/8',
 'orthogonal_plusminus_i_pair_exception':True,
 'restricted_global_projector_can_read_promised_orthogonal_pair_without_initial_disturbance':True,
 'that_projector_commutes_with_lawful_H':False,
 'orthogonal_pair_future_slope_gap':'3/4',
 'decoupled_lambda_zero_control':True,
 'perfect_single_run_nondisturbing_distinguishing_pointer_possible_for_nonorthogonal_pair':False,
 'source_instruments_select_real_readout_hardware':False,
 'physical_conscious_continuation_or_X3_proven':False
},sort_keys=True,indent=2))
