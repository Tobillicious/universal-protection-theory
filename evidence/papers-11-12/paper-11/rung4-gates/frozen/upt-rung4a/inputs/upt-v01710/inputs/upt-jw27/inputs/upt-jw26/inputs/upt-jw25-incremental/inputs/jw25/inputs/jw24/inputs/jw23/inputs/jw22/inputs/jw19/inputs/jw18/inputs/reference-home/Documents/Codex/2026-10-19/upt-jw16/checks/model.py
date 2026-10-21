"""JW1.6 integration. Decisions and bounds use exact rational arithmetic.

The requested full CERT15 includes plaintext leakage and 2^-100 encryption
failure. Its budget is evaluated, not assumed. Earlier-account frontiers are
reported separately and never labelled an admissible full CERT15 region.
"""
from fractions import Fraction as F
from math import ceil, comb, factorial
from functools import lru_cache

ISLANDS, T = 10**20, 10**100
MT = ISLANDS*T
N, BASE_H, POP, BERTHS, BASE_ADM, POOL = 288, 228, 1032, 88, 428, 400
W, BETA, SIGMA, DIV, COST = F(1,127), F(19,20), F(1,100), F(1,100), F(1,1000)
VALUE, REWARD = F(1,2), F(26,25)
PC = {'P':F(24,25), 'D':F(4,375)}
BAD = (1,2,3,3)
ZLAW = {0:{0:F(29,30),1:F(1,30)},1:{0:F(1,2),1:F(1,2)}}
STATES = tuple((s,z) for s in range(4) for z in range(2))
MEAN = F(6,10**5)
LIFE = F(30)
ONSET = MEAN/LIFE
EDITION_MEAN = MEAN+2*ONSET
PHYS = 2*F(10,27)**312
ETA_BASE, LIMIT, DESIGN_LIMIT, EXIT_LIMIT = F(1,10**7), F(1,10**6), F(1,5*10**6), F(1,10**10)
OLD_REGION_CAPS = {F(9,10):F(631,100),F(89,100):F(148,25),F(88,100):F(26,5),F(87,100):F(14,5),F(86,100):F(0)}
RS = tuple(OLD_REGION_CAPS)
FLOW, EC, JOB_COMPUTE, MPC_TOTAL_COMPUTE = F(24,5), F(1,127), F(1,10000), F(3648)
# Re-express JW1.5's field/copy energy ceilings as compute ceilings at the
# selected care conversion. This preserves their numerical baseline charges;
# it does not silently divide those inherited bills by another factor of 127.
FIELD_COMPUTE = F(127,10**9)
COPY_COMPUTE = F(127,10**5)
K, J, SPREAD_CAP, OFFLINE, CORRUPT = 663, 332, 5, 62, 24
ESCROW_UNIT, INFRA_STOCK = F(2710,729), F(2**20)
CRYPTO_PER_DATE = F(1,2**100)
HOLDERS = 3

def subset(n,p,k):
    if k<=0:return F(1)
    if k>n:return F(0)
    return min(F(1),F(comb(n,k))*F(p)**k)

def poisson(mu,k):return F(mu)**k/factorial(k)

def exp_series_upper(x,terms=18):
    x=F(x)
    assert 0<=x<terms+2
    return sum(x**i/factorial(i) for i in range(terms+1))+x**(terms+1)/factorial(terms+1)/(1-x/F(terms+2))

def exp_upper(x):
    assert x>=0
    return F(2129,2000)**ceil(16*x)

def pgf_tail(mu,k):return exp_upper(F(k)-mu)*(F(mu)/k)**k

def certificate_inventory(h):
    return {'care_history':POP,'provider_tickets':N,'host_flow':h,
            'arrival_admission':356,'relocation':POP,'aggregate_ledger':1,
            'refresh_recovery_batch':1,'command_gates':POP}

def qday(h):return max(4096,sum(certificate_inventory(h).values()))

def energy(extra,ec=EC,care_conversion='unified',mpc_scaling='global'):
    h=BASE_H+extra
    care_ec=ec if care_conversion=='unified' else W
    mpc=MPC_TOTAL_COMPUTE if mpc_scaling=='global' else 16*h
    return {'provider_inflow':N*F(94,25),'interconnect':F(16),
            'cohort_care':(516+extra)*care_ec,'reserved_berths':BERTHS*care_ec,
            'stock_command_limiters':POP*F(1,1000),'privileges':N*(SIGMA+DIV),'admin':F(1),
            'committee':qday(h)*K*JOB_COMPUTE*ec,'mpc_refresh_recovery':mpc*ec}

def energy_left(extra,ec=EC,care_conversion='unified',mpc_scaling='global'):
    return (BASE_H+extra)*FLOW-sum(energy(extra,ec,care_conversion,mpc_scaling).values())

def size_hosts(ec=EC,care_conversion='unified',mpc_scaling='global',limit=2000):
    return next((x for x in range(limit+1) if energy_left(x,ec,care_conversion,mpc_scaling)>=0),None)

EXTRA=size_hosts()
H, ADM = BASE_H+EXTRA, BASE_ADM-EXTRA
QDAY=qday(H)
JOBS=QDAY*K
INCOME=H*FLOW
ENERGY=energy(EXTRA)
ENERGY_LEFT=energy_left(EXTRA)
G_OWN=(H*8+ADM*F(2,127))/(1-BETA)+N*16+ADM*W*ESCROW_UNIT+INFRA_STOCK
G_POOL=POOL*G_OWN
SPAN=REWARD/(1-BETA)+G_POOL

def infrastructure(extra):
    h,adm=BASE_H+extra,BASE_ADM-extra
    fixed={'base_collectors':h*1024,'admission_collectors':adm*512,
           'care_mpc_plant':h*1024,'interconnect_plant':h*512,'command_gates':POP*16}
    return dict(fixed,other_buffers_keys_cash=INFRA_STOCK-sum(fixed.values()))

@lru_cache(None)
def committee_error(q=QDAY,cap=SPREAD_CAP):
    """Error intersected with the good edition c<=24. The c>=25 event is
    charged ONCE separately, not omitted and not charged per certificate.
    Honest-job subset-error domination at eps=.1 is an explicit conditional law.
    """
    err=F(0)
    for c in range(CORRUPT+1):
        remaining=J-cap*c
        honest=max(0,K-cap*c)
        err+=poisson(EDITION_MEAN,c)*(F(1) if remaining<=0 else
             min(F(1),2*comb(honest,remaining)*F(1,10)**remaining))
    return q*MT*err

ETA_COMMITTEE=committee_error()
CARE_BAD=MT*subset(H,F(1,1000),62)
QUORUM_ABUSE_BAD=MT*poisson(MEAN,25)
# Preserve original tolerated unavailable fraction: 228-179=49; new threshold H-48.
QUORUM_DOWN_THRESHOLD=H-48
QUORUM_LIVE_BAD=MT*subset(H,F(1,10),QUORUM_DOWN_THRESHOLD)
CORRUPT_BAD=MT*poisson(EDITION_MEAN,25)
CRYPTO_LEGACY_BAD=F(MT,2**448)
CRYPTO_PROTOCOL_BAD=F(2**28*MT,2**512)
POOL_X=F((78*POOL)**2,2)/(POOL*228*10+F(228*78*POOL,3))
POOL_BAD=F(ISLANDS,POOL)*F(10,27)**(POOL_X.numerator//POOL_X.denominator)
PGF_BAD=ISLANDS*(pgf_tail(F(10),89)+pgf_tail(F(10),229))
ARRIVAL_BAD=max(POOL_BAD,PGF_BAD)
ARRIVAL_HAZARD_LIMIT=F(1,10**8)
ARRIVAL_HISTORY_EXIT=ARRIVAL_BAD/ARRIVAL_HAZARD_LIMIT

def leak(h=H,crypto=CRYPTO_PER_DATE):
    p_host=HOLDERS*EDITION_MEAN/h
    per_keeper=p_host+crypto
    return {'p_host_three_holders':p_host,'crypto':crypto,'per_keeper_date':per_keeper,
            'gamma_flow':per_keeper*REWARD/(1-BETA)**2,
            'gamma_full_span':per_keeper*SPAN/(1-BETA),
            'cert15_plaintext_union':MT*POP*p_host,
            'cert15_crypto_union':MT*POP*crypto,
            'crypto_one_attempt_per_island_date':MT*crypto}

LEAK=leak()
GAMMA=LEAK['gamma_flow']

def static_accounts():
    return {'common_plus_premise':ETA_BASE,'committee_good_editions':ETA_COMMITTEE,
            'care_mpc_unavailability':CARE_BAD,'quorum_abuse_original':QUORUM_ABUSE_BAD,
            'quorum_liveness':QUORUM_LIVE_BAD,'edition_accumulated_corruption':CORRUPT_BAD,
            'crypto_legacy_448':CRYPTO_LEGACY_BAD,'crypto_protocol_512':CRYPTO_PROTOCOL_BAD,
            'arrivals_max_alternatives':ARRIVAL_BAD,'arrival_history_exit':ARRIVAL_HISTORY_EXIT}

FIXED=sum(static_accounts().values())

def channels(r,mu):
    fh,fr=1-F(3,4)*r,F(9,8)-F(8,9)*r
    bh=512*fh**N*exp_upper(MEAN*2047+mu*(1/fh-1))
    br=fr**N*exp_upper(MEAN*(3/fr-1)+mu*(1/fr-1))
    return MT*(bh+br+PHYS)

@lru_cache(None)
def factors(r):
    pc=F(16,15)*r
    return F(1,30)+F(29,30)*(1-F(3,4)*pc),F(1,10)+F(29,30)*(1-F(8,9)*pc)

@lru_cache(None)
def powers(r):
    hu,ru=factors(r)
    rd=2-F(64,135)*r
    return [hu**i for i in range(N+1)],[ru**i for i in range(N+1)],[rd**i for i in range(N+1)]

def cell(e,d,r,sh=0,gamma=GAMMA,span=SPAN,gpool=G_POOL,reading='slack'):
    hp,rp,dp=powers(r)
    hsh=F(1,30)+F(29,30)*(1-F(3,4)*PC['D'])
    ph=2**ceil(F(70+86*e,8))*3*hp[max(0,N-1-d-sh)]*hsh**sh
    pr=rp[max(0,N-1-d-e-sh)]*3**e*dp[d]*F(16,15)**sh*2
    pv=ph+pr
    rho=pv+PHYS+2*ARRIVAL_HAZARD_LIMIT
    own_pc,own_cost,eps=scenario(r,reading)
    delta=F(1,2)*(own_pc-PC['D'])
    gap=VALUE*DIV*delta*(1-rho-pv)-own_cost-pv*span-gamma
    alpha=2**ceil(F(70+86*(e+1),8))*3*hp[max(0,N-1-d)]
    xgap=VALUE*DIV*F(1,2)*own_pc*(1-rho-pv)-own_cost-alpha*gpool-(alpha+pv)*span-gamma
    hazard=ph+F(3,2)*pr+PHYS+30*ARRIVAL_HAZARD_LIMIT
    return gap,xgap,hazard,pv,alpha

@lru_cache(None)
def domain(r,gamma=GAMMA,span=SPAN,gpool=G_POOL,reading='slack'):
    out={}
    for e in range(60):
        def fits(d):return min(cell(e,d,r,gamma=gamma,span=span,gpool=gpool,reading=reading)[:2])>0
        if not fits(0):break
        lo,hi=0,N-1
        while lo<hi:
            mid=(lo+hi+1)//2
            if fits(mid):lo=mid
            else:hi=mid-1
        out[e]=lo
    return out

def sized_domain(extra,r,reading='slack',ec=EC):
    h,adm=BASE_H+extra,BASE_ADM-extra
    own=(h*8+adm*2*ec)/(1-BETA)+N*16+adm*ec*ESCROW_UNIT+INFRA_STOCK
    gpool=POOL*own
    span=REWARD/(1-BETA)+gpool
    gamma=(HOLDERS*EDITION_MEAN/h+CRYPTO_PER_DATE)*REWARD/(1-BETA)**2
    return domain(r,gamma,span,gpool,reading)

@lru_cache(None)
def exit_polynomial(items):
    if not items:return (F(1),)
    coef=[F(0)]*(max(d+2 for e,d in items)+1)
    for e,d in items:
        pe=poisson(MEAN,e);k=d+1
        for j in range(k+1):coef[j]+=pe*subset(N,F(1,16),k-j)/factorial(j)
        coef[k+1]+=pe/F(factorial(k+1))
    coef[0]+=poisson(MEAN,max(e for e,d in items)+1)
    return tuple(c*MT for c in coef)

def exit_bound(dm,mu):
    v=F(0)
    for c in reversed(exit_polynomial(tuple(dm.items()))):v=v*mu+c
    return v

def accounts(r,mu,dm,include_leaks=True):
    out=dict(static_accounts(),channels=channels(r,mu),domain_exit=exit_bound(dm,mu))
    if include_leaks:
        out.update(plaintext_leak_events=LEAK['cert15_plaintext_union'],
                   computational_encryption_breaks=LEAK['cert15_crypto_union'])
    return out

def total(r,mu,dm,include_leaks=True):return sum(accounts(r,mu,dm,include_leaks).values())

def frontier(r,dm,include_leaks=True):
    def fits(k):
        mu=F(k,100)
        return mu<=OLD_REGION_CAPS[r] and exit_bound(dm,mu)<=EXIT_LIMIT and total(r,mu,dm,include_leaks)<=DESIGN_LIMIT
    if not dm or not fits(0):return None
    lo,hi=0,1200
    assert not fits(hi)
    while lo<hi:
        mid=(lo+hi+1)//2
        if fits(mid):lo=mid
        else:hi=mid-1
    return F(lo,100)

def solve(a,b):
    rows=[[F(x) for x in ar]+[F(y)] for ar,y in zip(a,b)];n=len(b)
    for j in range(n):
        i=next(i for i in range(j,n) if rows[i][j])
        rows[j],rows[i]=rows[i],rows[j]
        scale=rows[j][j];rows[j]=[v/scale for v in rows[j]]
        for i in range(n):
            if i!=j:
                scale=rows[i][j];rows[i]=[v-scale*u for v,u in zip(rows[i],rows[j])]
    return [row[-1] for row in rows]

def scenario(r,reading):
    if reading=='slack':return F(16,15)*r,COST,F(0)
    if reading=='tremble':
        eps=(F(9,10)-r)/F(89,100)
        return (1-eps)*PC['P']+eps*PC['D'],(1-eps)*COST,eps
    raise ValueError(reading)

def role(s,z,act,q,pc=PC['P'],cost=COST):
    success=pc if act=='P' else PC['D']
    p=ZLAW[z][0]*success
    reward=VALUE*(SIGMA if s<3 else 0)+VALUE*DIV*p*(1-q)-(cost if act=='P' else 0)
    law={}
    for zp,pz in ZLAW[z].items():
        for x,px in (((1,success),(0,1-success)) if zp==0 else ((0,F(1)),)):
            key=(0 if x else BAD[s],zp)
            law[key]=law.get(key,F(0))+pz*px*(1-q)
    return reward,law

def role_values(q=F(0),policy=None,outside=F(0),pc=PC['P'],cost=COST):
    policy=policy or {st:'P' for st in STATES};aa,bb=[],[]
    for i,(s,z) in enumerate(STATES):
        act=policy[s,z]
        if act=='E':
            aa.append([F(i==j) for j in range(8)]);bb.append(outside/(1-BETA))
        else:
            rew,law=role(s,z,act,q,pc,cost)
            aa.append([F(i==j)-BETA*law.get(st,0) for j,st in enumerate(STATES)]);bb.append(rew)
    return dict(zip(STATES,solve(aa,bb)))

def options(st,values,q,outside,pc,cost):
    out={'E':outside/(1-BETA)}
    for act in PC:
        rew,law=role(*st,act,q,pc,cost)
        out[act]=rew+BETA*sum(p*values[nxt] for nxt,p in law.items())
    return out

def stopping(outside,q,pc,cost):
    policy={st:'E' for st in STATES}
    for _ in range(100):
        v=role_values(q,policy,outside,pc,cost)
        qs={st:options(st,v,q,outside,pc,cost) for st in STATES}
        new={st:max(qs[st],key=qs[st].get) for st in STATES}
        if new==policy:return v,policy,qs
        policy=new
    raise ArithmeticError('policy iteration exhausted')

def founding_gaps(n,r,reading,gamma=GAMMA):
    hu,ru=factors(r)
    pc,cost,eps=scenario(r,reading)
    pv=512*3*hu**(n-1)+2*ru**(n-1)
    alpha=2**ceil(F(70+86,8))*3*hu**(n-1)
    rho=pv+PHYS
    pd=VALUE*DIV*F(1,2)*(pc-PC['D'])*(1-rho-pv)-cost-pv*SPAN-gamma
    ex=VALUE*DIV*F(1,2)*pc*(1-rho-pv)-cost-alpha*G_POOL-(alpha+pv)*SPAN-gamma
    return pd,ex

def resource_rows(extra,ec=EC):
    h,adm=BASE_H+extra,BASE_ADM-extra
    live=h-OFFLINE-CORRUPT
    q=qday(h);jobs=q*K
    per_host_jobs=ceil(F(jobs,live))
    per_cert_cap=ceil(F(K,live))
    snapshot_wire=8*(h-1)+POP
    placement_wire=8+ceil(F(POP,live))+2+1
    # A global 3648-compute task budget is balanced; ceil reserves indivisible units.
    mpc_host=ceil(MPC_TOTAL_COMPUTE/live)
    key_fields=POP
    metadata_fields=4096-key_fields
    refresh_ops=2*24*h*h*4096+h*h*4096+h*24*4096
    refresh_words=h*h*4096
    # Field operations and authenticated word handling are measured compute costs,
    # both converted to energy with the SAME e_c as other computation.
    renewal_compute=(refresh_ops+refresh_words)*FIELD_COMPUTE
    backup_compute=(h*POP+2*POP+400*228)*COPY_COMPUTE
    cpu=F(8)+mpc_host+per_host_jobs*JOB_COMPUTE+snapshot_wire*COPY_COMPUTE
    wire=snapshot_wire+placement_wire+2048+2*per_host_jobs*JOB_COMPUTE
    memory=8+2*POP+1024+4096*F(1,10**5)+per_host_jobs*JOB_COMPUTE
    authentication_attempts=h*h*4096+2*jobs+2*h*POP+2**20
    deadline=F(1,20)+F(1,100)+cpu/128+wire/16384+F(1,10)+F(1,20)+F(1,20)+F(228,4096)
    slot_ok=live*8>=POP
    ledger=energy(extra,ec)
    return {'extra_hosts':extra,'hosts':h,'controlled_admissions':adm,'cohort':516+extra,
            'population':N+h+BERTHS+adm,'live_hosts':live,'care_slots':8*live,
            'quorum_size':h-CORRUPT-OFFLINE,'quorum_unavailable_threshold':h-48,
            'quorum_intersection_full_roster':2*(h-CORRUPT-OFFLINE)-h,
            'quorum_intersection_after_62_offline':2*(h-CORRUPT-OFFLINE)-(h-OFFLINE),
            'Qday':q,'certificate_inventory':certificate_inventory(h),'committee_jobs':jobs,
            'jobs_per_host':per_host_jobs,'max_jobs_per_certificate_host':per_cert_cap,
            'global_mpc_compute_cap':MPC_TOTAL_COMPUTE,'mpc_host_reserved':mpc_host,
            'compute_host':cpu,'memory_host':memory,'network_host':wire,'deadline':deadline,
            'authentication_attempts':authentication_attempts,'authentication_attempt_cap':2**28,
            'renewal_compute':renewal_compute,'renewal_energy':renewal_compute*ec,
            'backup_compute':backup_compute,'backup_energy':backup_compute*ec,
            'admission_care_external_flow':adm*ec,'admission_escrow_external_stock':adm*ec*ESCROW_UNIT,
            'key_fields':key_fields,'metadata_fields':metadata_fields,
            'key_bits_per_history':256,'key_storage_units_host':key_fields*F(1,10**5),
            'ledger':ledger,'income':h*FLOW,'energy_left':h*FLOW-sum(ledger.values()),
            'a7_slots':slot_ok,'resource_inequalities':{
                'population':adm>=0 and N+h+BERTHS+adm==POP,
                'slots':slot_ok,'compute':cpu<=128,'memory':memory<=4096,
                'network':wire<=16384,'deadline':deadline<1,
                'committee_placement':per_cert_cap<=SPREAD_CAP,
                'renewal_within_service_cap':renewal_compute<=MPC_TOTAL_COMPUTE,
                'backup_within_interconnect':backup_compute*ec<=16,
                'authentication_attempt_cap':authentication_attempts<=2**28,
                'quorum_intersection':2*(h-CORRUPT-OFFLINE)-h>CORRUPT,
                'stock_inventory':min(infrastructure(extra).values())>=0,
                'energy':h*FLOW>=sum(ledger.values())}}
