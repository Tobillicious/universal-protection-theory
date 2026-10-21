"""JW1.9 calculations. Exact rational decisions; decimal display is separate."""
from pathlib import Path
from fractions import Fraction as F
from functools import lru_cache
from math import ceil,comb
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'inputs/jw18/checks'))
import model as prior
import keepers
from rational_bounds import power,upper,exp_majorant
b=prior.base
MT,POOL,PD=prior.MT,prior.POOL,prior.POOL_DATES
SHARE=prior.old.TAIL_SHARE
DEADLINE=F(811,1000)
# All moments in this declared finite grid are rational. It is a sufficient rule.
ZS=tuple(1+F(k,100) for k in range(1,201))+tuple(F(k) for k in range(4,21))
YS=tuple(F(k) for k in range(2,100))+tuple(F(k) for k in range(100,1001,10))


def quant_up(x):
    x=F(x)*(1<<320)
    return F(-(-x.numerator//x.denominator),1<<320)


def exp_up(x,n=48):
    """Outward dyadic Taylor upper bound with positive geometric remainder."""
    x=quant_up(x)
    assert 0<=x<=1
    term=total=F(1)
    for j in range(1,n+1):
        term=quant_up(term*x/j);total+=term
    return quant_up(total+term*x/(n+1)/(1-x/F(n+2)))


def family_moment(s,A,y):
    """Whole-family PGF supersolution and person-time derivative.

    T total progeny, W total lifetime; L=29+NB(1,1/2).
    X=z M_L(s(g(X)-1)). Choose z=y/M_upper, so X<=y.
    dX/dt <= z M'_upper/(1-z*s*g'(y)*M'_upper).
    All inequalities point upwards. No independent-Poisson tail is assumed.
    """
    g=(1-F(1,A)+y/A)**A
    gp=(1-F(1,A)+y/A)**(A-1)
    a=s*(g-1)
    if not 0<=a<=F(1,32):return None
    ea=exp_up(a)
    M=quant_up(exp_up(29*a)/(2-ea))
    z=y/M
    D=quant_up(29+ea/(2-ea))  # M'/M, bounded upwards
    contraction=s*y*D*gp
    if z<=1 or contraction>=1:return None
    wz=quant_up(y*D/(1-contraction))
    return z,wz,y,contraction


def family_accounts(s,A,y,threshold=63,edition=True):
    x=family_moment(s,A,y)
    if x is None:return None
    z,wz,ty,contraction=x
    # A family active over an edition is retained for W+2, all T members.
    # Dropping the negative Levy normalizer only increases this moment.
    rate=b.ONSET*(wz+(2*ty if edition else 0))
    if rate>1:return None
    family=exp_up(rate)
    physical=power(1-F(1,1000)+F(1,1000)*z,b.H)
    # Conditional subset/PGF physical-fault warrant must hold given families.
    bound=upper(physical*power(1/z,threshold)*family)
    return {'tail':min(F(1),bound),'account':MT*min(F(1),bound),
            'z':z,'y':y,'Wz_upper':wz,'contraction_upper':contraction,
            'threshold':threshold,'edition':edition}


@lru_cache(None)
def best_family(s,A,threshold=63,edition=True):
    candidates=[r for y in YS if (r:=family_accounts(s,A,y,threshold,edition)) is not None]
    return min(candidates,key=lambda x:x['account']) if candidates else None


def family_bracket(A,threshold=63,bits=32):
    # Search on a relative dyadic grid, with a proved fixed-grid upper enclosure.
    def fits(s):
        x=best_family(s,A,threshold)
        return x is not None and 2*x['account']<=F(7,10**7)
    lo=F(1,31)
    while not fits(lo):lo/=10
    hi=min(F(1,31),lo*10)
    if hi==lo:return {'lower_s':lo,'upper_s':hi,'search_ceiling':True}
    for _ in range(bits):
        mid=(lo+hi)/2
        if fits(mid):lo=mid
        else:hi=mid
    return {'lower_s':lo,'upper_s':hi,'lower':best_family(lo,A,threshold),
            'upper':best_family(hi,A,threshold),'search_ceiling':False,
            'criterion':'2 * edition-window joint physical-outage + whole-family moment <= 7e-7; y grid 2..99 by 1 and100..1000 by 10; sufficient bound only'}


@lru_cache(None)
def capacity_channels(q,r,W,reading='slack',requests='all',scale=400):
    n=b.N*scale
    if not 0<=W<=n:raise ValueError('withdrawal')
    d=prior.old.down_cut(prior.old.VACANCY_CAPS[r]) if scale==400 else keepers.local_down_cut(prior.old.VACANCY_CAPS[r])
    down=min(d,n-W);up=n-W-down
    pc=b.scenario(r,reading)[0]
    pu,pd=F(29,30)*pc,F(1,2)*pc
    load=prior.CHI*q*(scale+b.POP*scale)
    needed=ceil(load/16)
    bh=[];br=[]
    for z in ZS:
        hold=power(1-pu+pu/z,up)*power(1-pd+pd/z,down)*power(z,max(0,needed-1))
        bh.append(min(F(1),upper(hold)) if hold.exponent<0 else F(1))
        if requests=='all':
            # Every provider may demand one rescue, even while committed jobs run.
            rescue=power(1-pu+pu/z**2,up)*power(1-pd+pd/z**2,down)*power(z,n)
        elif requests=='physical':
            # Diagnostic: receiver admits requests only for actual down/withdrawn roles.
            ru=F(1,30)*z+F(29,30)*(1-pc+pc/z**2)
            rd=F(1,2)*z+F(1,2)*(1-pc+pc/z**2)
            rescue=power(ru,up)*power(rd,down)*power(z,W)
        else:raise ValueError(requests)
        br.append(min(F(1),upper(rescue)) if rescue.exponent<0 else F(1))
    h,rs=min(bh),min(br)
    trials=MT//scale
    return {'holding':h,'rescue':rs,'joint_account':trials*(h+rs+b.PHYS),
            'holding_account':trials*h,'rescue_account':trials*rs,
            'd_cut':d,'previous_down_on_remaining':down,'up':up,'withdrawn':W,
            'load':load,'needed_successes':needed,'pc':pc,'requests':requests,
            'mean_holding':16*(up*pu+down*pd),
            'trial_count':trials,'mean_rescue_surplus':2*(up*pu+down*pd)-n if requests=='all' else 2*(up*pu+down*pd)-F(up,30)-F(down,2)-W}


def w_max(q,r,reading='slack',requests='all',scale=400,holding_only=False):
    def fits(w):
        x=capacity_channels(q,r,w,reading,requests,scale)
        return x['holding_account' if holding_only else 'joint_account']<=SHARE
    n=b.N*scale
    if not fits(0):return None
    lo,hi=0,n
    while lo<hi:
        mid=(lo+hi+1)//2
        if fits(mid):lo=mid
        else:hi=mid-1
    return {'W':lo,'W_per_island':F(lo,scale),'at':capacity_channels(q,r,lo,reading,requests,scale),
            'next':None if lo==n else capacity_channels(q,r,lo+1,reading,requests,scale),
            'deadline_fits':prior.old.operating_resources()['response_deadline']<=DEADLINE,
            'literal_deadline_W_max':None}


def clean_advantage(r,reading='slack'):
    pc,cost,_=b.scenario(r,reading)
    return prior.old.VALUE*b.DIV*F(1,2)*(pc-b.PC['D'])-cost


def disclosure_qmax(s,r,reading='slack',conditional_mean=None,roster=152):
    # This first is only a necessary clean limit; the full row pays physical risks.
    pl=3*b.EDITION_MEAN/(roster*(1-30*s))+2*F(1,2**100) if conditional_mean is None else min(F(1),3*conditional_mean/roster+2*F(1,2**100))
    return clean_advantage(r,reading)*(1-prior.BETA)**2/pl-prior.old.REWARD


def disclosure_smax(q,r,reading='slack',roster=152):
    a=3*b.EDITION_MEAN/roster
    c=2*F(1,2**100)
    margin=clean_advantage(r,reading)*(1-prior.BETA)**2/(prior.old.REWARD+q)
    return max(F(0),(1-a/(margin-c))/30) if margin>c else F(0)


def forgery(bits=436,attempts=238):return F(MT*attempts,2**bits)


def full_diagnostic(q,s,A):
    occ=best_family(s,A)
    if occ is None:return None
    rows={}
    for reading in prior.old.READINGS:
        for r in prior.old.RESPONSES:
            x=capacity_channels(q,r,0,reading)
            # Paid conservative uniform service-risk debit, preserving the old span.
            ph,pr=x['holding'],x['rescue'];rho=ph+pr+b.PHYS+2*b.ARRIVAL_HAZARD_LIMIT
            pc,cost,_=b.scenario(r,reading)
            gamma=prior.gamma(q,s)
            gap=prior.old.VALUE*b.DIV*F(1,2)*(pc-b.PC['D'])*(1-rho-ph-pr)-cost-(ph+pr)*b.SPAN-gamma
            if gap<=0:continue
            acc=b.static_accounts().copy()
            # No 25-corrupt event is caused by a mere halt. Attestation failure
            # is charged separately and makes arbitrary corruption a bad event.
            acc['quorum_abuse_original']=F(0)
            acc['edition_accumulated_corruption']=F(0)
            # Host-local job errors retained, conditional on timely care failover
            # and committee reassignment to a paid serving roster.
            acc['committee_good_editions']=b.QDAY*MT*min(F(1),2*comb(b.K,b.J)*F(1,10)**b.J)
            acc['care_mpc_unavailability']=occ['account']
            acc.update(ordinary_holding_channel=MT*ph,
                       ordinary_rescue_channel=MT*pr,physical_geometry=MT*b.PHYS,
                       coordinated_load_channels=MT*(ph+pr),
                       domain_fault_vacancy_exit=PD*prior.old.down_tail(x['d_cut']+1,prior.old.VACANCY_CAPS[r]),
                       background_episode_overflow=occ['account'],
                       dormant_broadcast_reservoir_overflow=F(0),recruitment_family_R25=F(0),
                       attestation_forgery_436=forgery(),
                       care_slot_106=best_family(s,A,106)['account'])
            rows[reading+':'+str(r)]={'r':r,'reading':reading,'IC_gap_lower':gap,'gamma':gamma,
                                      'accounts':acc,'sum':sum(acc.values()),'capacity':x}
    if not rows:return {'rows':{},'conditional_numerical_region':False,'literal_region_empty':True}
    worst=max(rows,key=lambda k:rows[k]['sum'])
    eta=b.ETA_BASE+rows[worst]['accounts']['committee_good_editions']
    return {'q':q,'s':s,'A':A,'rows':rows,'worst':worst,'sum':rows[worst]['sum'],
            'eta_cert':eta,'ceiling':F(1,10**6)-eta,
            'conditional_numerical_region':rows[worst]['sum']+eta<=F(1,10**6),
            'literal_region_empty':True,'reasons':['Inherited serial deadline exceeds literal 0.811.','Retained-reader conditional information envelope is not supplied.','Attestation overhead and its attempt count need a paid implementation.','Committee/failover timing under adversarial halts is an additional condition.']}
