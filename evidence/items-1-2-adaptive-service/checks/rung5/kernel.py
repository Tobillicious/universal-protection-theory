"""Independent physical-input-only rung-5 protection ledger, exact rational enclosures.

The API contains physical/service laws, dimensions and accounting constants. It has no valuation,
belief, utility, incentive test or command-policy argument. Joint laws are explicit contracts; a
single-role marginal is not substituted for a pool moment bound. All ten legacy grid labels remain.
"""
from fractions import Fraction as F
from functools import lru_cache
from math import comb,ceil
from .intervals import I,power,exp_interval,probability_product
ISLANDS,DATES,POOL=10**20,10**100,400
MT=ISLANDS*DATES;PD=MT//POOL
PROVIDERS,POP,HOSTS,W=288,1032,242,42800
COMMON=F(1,10**7);P_SITE=F(1,500);P_ROLE=F(1,500)
CHI=F(875,247);QUOTA=F(1,2)
MU={F(9,10):F(631,100),F(89,100):F(148,25),F(22,25):F(26,5),F(87,100):F(14,5),F(43,50):F(0)}
READINGS=('slack','tremble')
CHANNEL_Z=tuple(1+F(k,100) for k in range(1,201))+tuple(F(k) for k in range(4,21))
DOWN_Z=tuple(1+F(k,100) for k in range(1,61))
NAMES=('common_plus_premise','committee_good_editions','care_mpc_unavailability','quorum_abuse_original',
 'quorum_liveness','edition_accumulated_corruption','crypto_legacy_448','crypto_protocol_512',
 'arrivals_max_alternatives','arrival_history_exit','ordinary_holding_channel','ordinary_rescue_channel',
 'physical_geometry','coordinated_load_channels','domain_fault_vacancy_exit','background_episode_overflow',
 'dormant_broadcast_reservoir_overflow','recruitment_family_R25','confidentiality_ModeC',
 'integrity_attestation_freshness','care_slots_and_spreading')

def subset(n,k,p):
    assert 0<=p<=1
    if k<=0:return F(1)
    if k>n:return F(0)
    return min(F(1),comb(n,k)*p**k)

def old_service(r,reading):
    if reading=='slack':return F(16,15)*r
    assert reading=='tremble'
    e=(F(9,10)-r)/F(89,100)
    return (1-e)*F(24,25)+e*F(4,375)

@lru_cache(None)
def arrivals():
    exponent=F((78*POOL)**2,2)/(POOL*228*10+F(228*78*POOL,3))
    pooled=F(ISLANDS,POOL)*F(10,27)**(exponent.numerator//exponent.denominator)
    def pgf(k):return F(2129,2000)**ceil(16*(F(k)-10))*F(10,k)**k
    return max(pooled,ISLANDS*(pgf(89)+pgf(229)))

@lru_cache(None)
def committee(certificates):
    n=HOSTS*7;received=n-78*7
    thresholds=((received+1)//2,received-(received+1)//2+1)
    lo=hi=F(0)
    for k in thresholds:
        p=F(1,10);z=F(k)*(1-p)/(p*(n-k))
        l,h=probability_product(power(1-p+p*z,n),power(1/z,k));lo+=l;hi+=h
    return certificates*MT*lo,certificates*MT*hi

@lru_cache(None)
def down_tail(k,mu):
    if k<=0:return F(1),F(1)
    candidates=[]
    for z in DOWN_Z:
        candidates.append(probability_product(power(1+F(1,16)*(z-1),PROVIDERS*POOL),
          exp_interval(POOL*mu*(z-1)),power(1/z,k)))
    return min(l for l,h in candidates),min(h for l,h in candidates)

@lru_cache(None)
def channels(pc,dcut,withdrawn=W):
    assert 0<=pc<=1 and 0<=withdrawn<=PROVIDERS*POOL
    n=PROVIDERS*POOL;down=min(dcut,n-withdrawn);up=n-withdrawn-down
    pu,pd=F(29,30)*pc,F(1,2)*pc
    needed=ceil(CHI*QUOTA*(POOL+POP*POOL)/16)
    holding=[];rescue=[]
    for z in CHANNEL_Z:
        holding.append(probability_product(power(1-pu+pu/z,up),power(1-pd+pd/z,down),power(z,max(0,needed-1))))
        rescue.append(probability_product(power(1-pu+pu/z**2,up),power(1-pd+pd/z**2,down),power(z,n)))
    return {'holding':(min(x[0] for x in holding),min(x[1] for x in holding)),
      'rescue':(min(x[0] for x in rescue),min(x[1] for x in rescue)),
      'up':up,'down':down,'needed':needed}

def ledger(k,pc,mu,dcut,withdrawn=W,site_p=P_SITE):
    assert k in (2,3) and 0<=site_p<=1
    passive,threshold,quorum,cert=(80,79,71,4224) if k==2 else (90,80,72,4288)
    ch=channels(pc,dcut,withdrawn);comm=committee(cert)
    vacancy=down_tail(dcut+1,mu)
    physical=MT*subset(HOSTS+passive,threshold,site_p)
    base={
      'common_plus_premise':COMMON,'care_mpc_unavailability':physical,
      'quorum_abuse_original':F(0),'quorum_liveness':MT*(subset(HOSTS,HOSTS-48,F(1,10))+subset(HOSTS,quorum,site_p)),
      'edition_accumulated_corruption':F(0),'crypto_legacy_448':F(MT,2**448),
      'crypto_protocol_512':F(2**28*MT,2**512),'arrivals_max_alternatives':arrivals(),
      'arrival_history_exit':arrivals()/F(1,10**8),'physical_geometry':MT*2*F(10,27)**312,
      'background_episode_overflow':physical,'dormant_broadcast_reservoir_overflow':F(0),
      'recruitment_family_R25':F(0),'confidentiality_ModeC':F(2*MT*2**31,2**459),
      'integrity_attestation_freshness':F(2*MT*2**31,2**459),
      'care_slots_and_spreading':MT*subset(HOSTS,HOSTS-132,site_p)}
    low=dict(base);high=dict(base)
    for out,i in ((low,0),(high,1)):
        out['committee_good_editions']=comm[i]
        out['ordinary_holding_channel']=MT*ch['holding'][i]
        out['ordinary_rescue_channel']=MT*ch['rescue'][i]
        out['coordinated_load_channels']=MT*(ch['holding'][i]+ch['rescue'][i])
        out['domain_fault_vacancy_exit']=PD*vacancy[i]
    low={n:low[n] for n in NAMES};high={n:high[n] for n in NAMES}
    reserve=(COMMON+comm[0],COMMON+comm[1])
    return {'lower':low,'upper':high,'reserve':reserve,
      'total':(sum(low.values())+reserve[0],sum(high.values())+reserve[1])}
