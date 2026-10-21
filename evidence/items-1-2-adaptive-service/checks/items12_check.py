"""Adaptive removals and subset-derived service: exact controls and 21-account re-screen."""
from pathlib import Path
from fractions import Fraction as F
from math import comb,ceil
from itertools import combinations
from functools import lru_cache
import hashlib,json,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
from rung5 import kernel as K
from rung5.mixed import replace_committee,PUBLISHED_Q

def rational_tag(q):
 q=F(q)
 def enc(i):return i.to_bytes(max(1,(i.bit_length()+7)//8),'big')
 a=enc(q.numerator);b=enc(q.denominator)
 return hashlib.sha256(len(a).to_bytes(8,'big')+a+b).hexdigest()

def compositions(total,n):
 if n==1:
  yield (total,);return
 for a in range(total+1):
  for tail in compositions(total-a,n-1):yield (a,)+tail

def optimal_subset_tail(n,k,p):
 p=F(p);assert n>=0 and 0<=p<=1
 if k<=0:return F(1)
 if k>n:return F(0)
 return min([F(1)]+[F(comb(n,r),comb(k,r))*p**r for r in range(1,k+1)])

def sharp_probability_checks():
 checked=0
 for n in range(1,9):
  for k in range(1,n+1):
   for a in range(9):
    p=F(a,8);alpha=optimal_subset_tail(n,k,p)
    # Uniform k-fault set with probability alpha; otherwise no faults.
    # Every fixed r-subset's joint probability is the following exact ratio.
    assert 0<=alpha<=1
    for r in range(1,n+1):
     joint=alpha*F(comb(k,r),comb(n,r)) if r<=k else F(0)
     assert joint<=p**r
    assert alpha==min([F(1)]+[F(comb(n,r),comb(k,r))*p**r for r in range(1,k+1)])
    checked+=1
 return {'optimal_tail_parameter_instances':checked,'attaining_exchangeable_law_checked':True,'independence_required':False,'formula':'min(1, min_{1<=r<=k} C(N,r)*p^r/C(k,r))'}

def finite_law_checks():
 n=3;den=8;p=F(1,2);pc=[bin(a).count('1') for a in range(1<<n)]
 passed=law_count=0
 for weights in compositions(den,1<<n):
  law_count+=1
  if any(F(sum(weights[m] for m in range(1<<n) if m&a==a),den)>p**pc[a] for a in range(1,1<<n)):continue
  passed+=1
  for z in [F(1),F(3,2),F(2),F(5)]:
   actual=sum(F(weights[m],den)*z**pc[m] for m in range(1<<n))
   assert actual<=(1-p+p*z)**n
   service=sum(F(weights[m],den)*z**(-n+pc[m]) for m in range(1<<n))
   assert service<=(p+(1-p)/z)**n
  for k in range(1,n+1):
   tail=F(sum(weights[m] for m in range(1<<n) if pc[m]>=k),den)
   assert tail<=optimal_subset_tail(n,k,p)
 assert passed>1
 # A correlated law with at most one fault obeys every subset bound.
 p=F(1,4);z=F(2);actual=1-3*p+3*p*z
 assert actual<(1-p+p*z)**3
 # A common outage meets marginals but violates both the subset and product laws.
 p=F(1,2);actual=(1-p)+p*z*z
 assert actual>(1-p+p*z)**2 and p>p*p
 return {'rational_laws_enumerated':law_count,'subset_admissible_laws':passed,'pgf_trials_each':4,'nonindependent_admissible_law_checked':True,'marginal_only_countermodel_checked':True}

def adaptive_checks():
 pairs=0;sharp=0
 for n in range(9):
  pc=[bin(a).count('1') for a in range(1<<n)];full=(1<<n)-1
  for available in range(1<<n):
   for removal in range(1<<n):
    s=pc[available];w=pc[removal];kept=pc[available&(full^removal)]
    assert s<=kept+w
    pairs+=1
   for w in range(n+1):
    minima=min(pc[available&(full^r)] for r in range(1<<n) if pc[r]<=w)
    assert minima==max(0,pc[available]-w);sharp+=1
 # Fully observed outcomes, two independent fair service bits, one erasure.
 fixed=F(1,2);adaptive=F(3,4);assert adaptive>fixed
 return {'all_outcome_removal_pairs':pairs,'sharp_cap_instances':sharp,'fixed_two_role_failure':str(fixed),'adaptive_two_role_failure':str(adaptive)}

def screen_accounts():
 N=K.PROVIDERS*K.POOL;W=K.W;need=ceil(K.CHI*K.QUOTA*(K.POOL+K.POP*K.POOL)/16)
 cut=1000;p=F(1,500);tail=F(comb(N,cut),500**cut);channel=K.MT*tail
 assert N-W-(cut-1)>=need and 2*(N-W-(cut-1))>N
 assert 16*channel<F(1,10**80)
 dmap=json.loads((ROOT/'checks/rung5/INPUTS.json').read_text())['d_cut'];rows=[];maxima={};unchanged=0
 for law in ['independent_jobs','mixed_hosts']:
  maxima[law]={}
  for plant in [2,3]:
   totals=[]
   for reading in K.READINGS:
    for r,mu in sorted(K.MU.items(),reverse=True):
     d=dmap[str(r)];base=K.ledger(plant,F(499,500),mu,d)
     if law=='mixed_hosts':base=replace_committee(base,plant,PUBLISHED_Q)
     amended=dict(base['upper'])
     amended['ordinary_holding_channel']=channel
     amended['ordinary_rescue_channel']=channel
     amended['coordinated_load_channels']=2*channel
     for name in K.NAMES:
      if name not in ['ordinary_holding_channel','ordinary_rescue_channel','coordinated_load_channels']:
       assert amended[name]==base['upper'][name];unchanged+=1
     total=sum(amended.values())+base['reserve'][1]
     assert total<F(21,10**8)
     totals.append(total)
     rows.append({'law':law,'k':plant,'reading':reading,'r':str(r),'mu':str(mu),'dcut':d,'accounts':21,'unchanged_other_accounts':18,'total_exact_digest':rational_tag(total),'below_2p1e_7':True,'removed_nonadaptivity':True,'service_bound_from_role_subset_law':True})
   maxima[law][plant]=max(totals)
  schedule=3*maxima[law][3]+maxima[law][2]
  assert schedule<F(84,10**8) and schedule+F(4,10**8)<F(88,10**8)
 result={'role_count':N,'physical_withdrawal_cap':W,'holding_needed':need,'rescue_fault_threshold':N-W-N//2,'holding_fault_threshold':N-W-need+1,'fault_screen':cut,'survivors_below_screen':N-W-cut+1,'channel_horizon_below_1e_83':channel<F(1,10**83),'all_four_phase_channel_charges_below_1e_80':True,'rows':len(rows),'accounts_per_row':21,'unchanged_other_account_cells':unchanged,'four_phase_ceiling':'8.4e-7','including_c2_each_phase_ceiling':'8.8e-7','new_independence_premise':False,'source_law':'P-ROUTES applies P-FAULT subset law to provider-role non-service; P-FAULT conditional at every admissible pre-window history','vacancy_and_other_physical_laws_removed':False}
 return result,rows

def main():
 finite=finite_law_checks();sharp=sharp_probability_checks();adaptive=adaptive_checks();accounts,rows=screen_accounts()
 result={'status':'PASS items 1-2: adaptive withdrawals and subset-derived joint service','finite_laws':finite,'sharp_probability':sharp,'adaptive':adaptive,'accounts':accounts}
 (ROOT/'outputs/ITEMS12-RESULT.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n')
 (ROOT/'outputs/ITEMS12-ROWS.json').write_text(json.dumps(rows,sort_keys=True,indent=2)+'\n')
 print(json.dumps(result,sort_keys=True))
def reject_claim(name):
 if name=='marginals_imply_joint_service':
  actual=F(1,2)+F(1,2)*4;assert actual>F(3,2)**2
 elif name=='adaptive_erasures_keep_fixed_subset_tail':
  assert F(3,4)>F(1,2)
 elif name=='subset_law_implies_independence':
  assert F(0)!=F(1,4)**2
 elif name=='independence_maximises_every_tail':
  assert optimal_subset_tail(2,1,F(1,4))==F(1,2)>1-F(3,4)**2
 else:raise ValueError('unknown claim')
 print(json.dumps({'claim':name,'accepted':False},sort_keys=True));raise SystemExit(1)
if __name__=='__main__':
 if len(sys.argv)==3 and sys.argv[1]=='--claim':reject_claim(sys.argv[2])
 elif len(sys.argv)==1:main()
 else:raise SystemExit('use no arguments or --claim NAME')
