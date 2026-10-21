"""JW1.8 quota parameterization; primary calculations are rational.

Numerical IC+risk rows assume an enduring post-exit quota and the information
envelope. They do not supply either premise, nor legitimate service capacity
under the same small quota.
"""
import importlib.util
from pathlib import Path
from fractions import Fraction as F
from functools import lru_cache
from math import ceil,comb,factorial
import sys
from rational_bounds import power,exp_majorant,upper,lower
import occupancy

ROOT=Path(__file__).resolve().parents[1]
REF=ROOT/'inputs/reference-home/Documents/Codex/2026-10-19'
sys.path.insert(0,str(REF/'upt-jw17/checks'))
spec=importlib.util.spec_from_file_location('jw17_reference',REF/'upt-jw17/checks/model.py')
old=importlib.util.module_from_spec(spec);spec.loader.exec_module(old)
base=old.old
CHI=F(875,247)
QUOTAS=(F(1,2),F(1),F(147,100),F(2),F(494,25))
MT,POOL_DATES,POOL,N,POP=old.MT,old.POOL_DATES,old.POOL,old.PROVIDERS,base.POP
BETA=old.BETA
LIMIT=F(1,10**6)
ETA_COMMON=base.ETA_BASE
DESIGN=base.DESIGN_LIMIT
R_BIND=25
BACKGROUND_EDGE=24*POOL


def leak(s=F(0),roster=old.SERVING_MIN):
    return 3*base.EDITION_MEAN/(roster*(1-30*s))+2*F(1,2**100)


def gamma(q,s=F(0),enduring=True):
    if enduring:return leak(s)*(old.REWARD+q)/(1-BETA)**2
    return leak(s)*base.SPAN/(1-BETA)


@lru_cache(None)
def physical(e,d,r,q,s=F(0),A=1):
    hu,ru=base.factors(r);rd=2-F(64,135)*r
    attack=CHI*q
    step=ceil((16+attack)/8)
    mark=2**step
    batch=lambda z:(1-F(1,A)+z/A)**A
    # Conditional recruitment depends on the current population, not on its
    # unconditional mean. New offspring enter at the next dated capability gate.
    fresh=exp_majorant(POOL*base.ONSET*(mark-1)+s*e*(batch(mark)-1))
    h=power(hu,max(0,N-1-d))*fresh
    ph=h.shift(ceil((POOL*attack+(16+attack)*e)/8))
    alpha=h.shift(ceil((POOL*attack+(16+attack)*(e+1))/8))
    rescue_fresh=exp_majorant(POOL*base.ONSET*2+s*e*(batch(3)-1))
    pr=power(ru,max(0,N-1-d-e))*power(3,e)*power(rd,d)*2*rescue_fresh
    return ph.fractions(),pr.fractions(),alpha.fractions()


def cell(e,d,r,q,reading='slack',s=F(0),enduring=True,A=1):
    (hl,hu),(rl,ru),(al,au)=physical(e,d,r,q,s,A)
    pc,cost,_=base.scenario(r,reading)
    def gaps(ph,pr,alpha):
        b=ph+pr;rho=b+base.PHYS+2*base.ARRIVAL_HAZARD_LIMIT
        pd=old.VALUE*base.DIV*F(1,2)*(pc-base.PC['D'])*(1-rho-b)-cost-b*base.SPAN-gamma(q,s,enduring)
        # q bounds the gain here ONLY under the enduring-quota interpretation.
        gain=q/(1-BETA) if enduring else base.G_POOL
        ex=old.VALUE*base.DIV*F(1,2)*pc*(1-rho-b)-cost-alpha*gain-(alpha+b)*base.SPAN-gamma(q,s,enduring)
        return pd,ex
    return {'lower':gaps(hu,ru,au),'upper':gaps(hl,rl,al),'ph':hu,'pr':ru,'alpha':au,
            'hazard':hu+F(3,2)*ru+base.PHYS+30*base.ARRIVAL_HAZARD_LIMIT}


def edge(d,r,q,reading='slack',s=F(0),protection=False,A=1):
    def fits(e):
        c=cell(e,d,r,q,reading,s,A=A)
        return min(c['lower'])>0 and (not protection or MT*(c['ph']+c['pr']+base.PHYS)<=old.TAIL_SHARE)
    if not fits(0):return -1
    lo,hi=0,N
    while lo<hi:
        mid=(lo+hi+1)//2
        if fits(mid):lo=mid
        else:hi=mid-1
    return lo


def d_edge(e,r,q,reading='slack',s=F(0),A=1):
    if min(cell(e,0,r,q,reading,s,A=A)['lower'])<=0:return -1
    lo,hi=0,N-1
    while lo<hi:
        mid=(lo+hi+1)//2
        if min(cell(e,mid,r,q,reading,s,A=A)['lower'])>0:lo=mid
        else:hi=mid-1
    return lo


@lru_cache(None)
def static_accounts(s=F(0),A=1):
    law=occupancy.law(s,A)
    acc=base.static_accounts().copy()
    acc['quorum_abuse_original']=MT*law['current'][25][1]
    acc['edition_accumulated_corruption']=MT*law['edition'][25][1]
    committee=F(0)
    for c in range(25):
        remaining=base.J-base.SPREAD_CAP*c
        honest=base.K-base.SPREAD_CAP*c
        err=min(F(1),2*comb(honest,remaining)*F(1,10)**remaining)
        committee+=law['edition'][c][1]*err
    acc['committee_good_editions']=base.QDAY*MT*committee
    return acc


@lru_cache(None)
def row(q,r,reading='slack',s=F(0),A=1):
    dc=old.down_cut(old.VACANCY_CAPS[r])
    ic=edge(dc,r,q,reading,s,A=A)
    if ic<0:return None
    phys=edge(dc,r,q,reading,s,True,A)
    if phys<BACKGROUND_EDGE:return None
    B=BACKGROUND_EDGE
    corner=cell(B,dc,r,q,reading,s,A=A)
    acc=static_accounts(s,A).copy()
    # There is NO extra 1000-date dormant store outside the counted episodes.
    # Local active+dormant corruption records <=24; all may activate together.
    # The old .7/1000-date intent model needs an additional mapping to corruption
    # and cannot simply be retained after the 25-host seam is integrated.
    reservoir_account=MT*occupancy.law(s,A)['current'][25][1]
    acc.update(ordinary_holding_channel=MT*corner['ph'],
               ordinary_rescue_channel=MT*corner['pr'],
               physical_geometry=MT*base.PHYS,
               coordinated_load_channels=MT*(corner['ph']+corner['pr']),
               domain_fault_vacancy_exit=POOL_DATES*old.down_tail(dc+1,old.VACANCY_CAPS[r]),
               background_episode_overflow=acc['edition_accumulated_corruption'],
               dormant_broadcast_reservoir_overflow=reservoir_account,
               recruitment_family_R25=MT*base.ONSET*occupancy.law(s,A)['family_tail'][1])
    # Ordinary channels use the same uniform corner as coordinated loading.
    # Double charging is conservative. Background>24*400 implies at least one
    # local bad edition; the corresponding union bound is charged again here.
    return {'q':q,'r':r,'reading':reading,'s':s,'A':A,'mu':old.VACANCY_CAPS[r],
            'd_cut':dc,'IC_edge':ic,'physical_edge_only':phys,'operational_edge':B,
            'B_max':B,'B_max_per_island':24,'additional_dormant_given24_active':0,
            'R_bind':25,'holding_R':B+1,'corner':corner,'accounts':acc,
            'sum':sum(acc.values()),'gamma':gamma(q,s)}


def rows(q,s=F(0),A=1):
    out={}
    for reading in old.READINGS:
        for r in old.RESPONSES:
            rr=row(q,r,reading,s,A)
            if rr is not None:out[reading+':'+str(r)]=rr
    return out


def full(q,s=F(0),A=1,extra_reserve=True):
    rr=rows(q,s,A)
    if not rr:return None
    worst=max(rr,key=lambda k:rr[k]['sum'])
    eta=ETA_COMMON+static_accounts(s,A)['committee_good_editions']
    ceiling=LIMIT-eta if extra_reserve else LIMIT
    return {'rows':rr,'worst':worst,'sum':rr[worst]['sum'],'eta_cert':eta,'ceiling':ceiling,
            'fits':rr[worst]['sum']<=ceiling}


def quota_bracket(scale=10**6):
    # Largest point on this declared rational grid, not an attained supremum
    # of the strict, continuous incentive inequalities.
    lo,hi=0,20*scale
    while lo<hi:
        mid=(lo+hi+1)//2
        q=F(mid,scale)
        if min(cell(0,0,F(9,10),q)['lower'])>0:lo=mid
        else:hi=mid-1
    return F(lo,scale),F(lo+1,scale)
