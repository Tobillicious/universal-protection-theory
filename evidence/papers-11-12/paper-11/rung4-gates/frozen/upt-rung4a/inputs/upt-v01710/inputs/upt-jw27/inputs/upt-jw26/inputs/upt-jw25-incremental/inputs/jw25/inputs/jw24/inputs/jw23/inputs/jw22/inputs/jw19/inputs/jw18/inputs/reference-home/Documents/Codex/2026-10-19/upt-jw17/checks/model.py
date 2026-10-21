"""JW1.7 mathematical model. All decisions use rational inequalities.

The parameter zeta is an UNPROVIDED all-history induced-exit warrant. The model
reports its conditional geometry and also the result of using only zeta<=1.
It never substitutes the former for a proof of that warrant.
"""
import importlib.util
from functools import lru_cache
from fractions import Fraction as F
from math import ceil, comb, factorial
from pathlib import Path
from rational_bounds import Bound, power, exp_majorant, upper, lower

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('jw16_reference', ROOT/'inputs/jw16/checks/model.py')
old = importlib.util.module_from_spec(spec)
spec.loader.exec_module(old)

ISLANDS, DATES, POOL = old.ISLANDS, old.T, old.POOL
POOL_DATES, MT = ISLANDS // POOL * DATES, old.MT
PROVIDERS = POOL * old.N
BETA, REWARD, VALUE = old.BETA, old.REWARD, old.VALUE
QUOTA = F(494, 25)
QUOTA_VALUE = QUOTA / (1-BETA)
WEALTH_SPAN = old.SPAN             # retained, conservative physical-pivot span
FLOW_SPAN = REWARD / (1-BETA)
SECRET_BREAK = F(1, 2**100)
CIPHER_BREAK = F(1, 2**100)
SERVING_MIN = old.H-old.OFFLINE-old.CORRUPT
PLACEMENT_ROSTER = SERVING_MIN    # availability-aware MOVE, not an island/host division
P_LEAK = F(3, PLACEMENT_ROSTER)*old.EDITION_MEAN + SECRET_BREAK + CIPHER_BREAK
AUTHOR_P_LEAK = F(3, old.H)*old.EDITION_MEAN + SECRET_BREAK
ZETA_EXAMPLE = F(1, 10**6)         # sensitivity value, not a derived premise
ROOT_INTENSITY = POOL*old.ONSET
LAPSE = F(1, 1000)                # declared conservative intent-record lapse premise
AUDIENCE, ADOPTION = 20, F(1,20)
BROADCAST_MEAN = F(7,10)
TAIL_SHARE = F(1,10**10)
VACANCY_CAPS = old.OLD_REGION_CAPS
READINGS = ('slack','tremble')
RESPONSES = old.RS


def gamma(zeta, p=P_LEAK):
    return p*(REWARD/(1-BETA)**2 + QUOTA_VALUE*F(zeta)/(1-BETA))


def gamma_quota_only(p=P_LEAK):
    # Replacing the ENTIRE reward stream by seizable command flow gives this
    # optimistic quota-only comparison; adding ordinary reward can only increase it.
    return p*QUOTA/(1-BETA)**2


def operating_resources():
    row = old.resource_rows(old.EXTRA)
    # Uniform host permutation of three cyclicly offset, balanced placements.
    primary = ceil(F(old.POP, SERVING_MIN))
    holders = 3*primary
    move_wire_host = 2*holders + 4
    move_compute_host = move_wire_host*old.COPY_COMPUTE + F(3*old.POP, SERVING_MIN)*old.JOB_COMPUTE
    move_compute_total = (6*old.POP+4*SERVING_MIN)*old.COPY_COMPUTE + 3*old.POP*old.JOB_COMPUTE
    # Fabric is direct provider-to-island. It does not transit care-host ports.
    endpoint_work = {'energy':18,'compute':20,'memory':16,'network':8}
    endpoint_budgets = {'energy':20,'compute':20,'memory':16,'network':8}
    total_wire_pool = 8*PROVIDERS
    port_rate, switch_rate = 2**24, 2**24
    endpoint_rate, compute_burst_rate = 32, 128
    # A single destination can receive every provider's contribution. The same
    # full-pool load is charged in the serial critical path, not divided by 400.
    fabric_delay = F(total_wire_pool, min(port_rate,switch_rate))
    phases = {'detection':F(1,20),'dispatch_limiter':F(1,10),
              'joint_provider_compute':F(20,compute_burst_rate),
              'joint_endpoint_wire':F(8,endpoint_rate),
              'pool_switch_and_destination_wire':fabric_delay,
              'round_trip_propagation':F(1,20),
              'verification':F(1,10),'commit':F(1,20)}
    deadline = sum(phases.values())
    fabric_energy_island = 1+F(2*total_wire_pool, POOL)*F(1,10**5) + 2*old.N*F(1,10**5)
    move_energy = move_compute_total*old.EC
    reserve_use = row['backup_energy'] + move_energy + fabric_energy_island
    capital = dict(old.infrastructure(old.EXTRA))
    capital['new_provider_fabric'] = old.N*32
    capital['other_buffers_keys_cash'] -= capital['new_provider_fabric']
    cpu = row['compute_host']+move_compute_host
    wire = row['network_host']+move_wire_host
    memory = row['memory_host']+2*holders
    care_deadline = row['deadline']+move_compute_host/128+F(move_wire_host,16384)
    # Two aggregate batch warrants avoid one unbudgeted certificate per packet.
    inventory = dict(row['certificate_inventory'],move_batch=1,pool_response_batch=1)
    authentication = row['authentication_attempts']+2*total_wire_pool//POOL+6*old.POP
    inequalities = dict(row['resource_inequalities'])
    inequalities.update(
        compute=cpu<=128,memory=memory<=4096,network=wire<=16384,
        care_deadline=care_deadline<1,pooled_response_deadline=deadline<=F(19,20),
        provider_vector=all(endpoint_work[k]<=endpoint_budgets[k] for k in endpoint_work),
        copying_move_fabric_reserve=reserve_use<=16,
        fabric_capital=min(capital.values())>=0,
        certificates=sum(inventory.values())<=old.QDAY,
        authentication_attempts=authentication<=2**28)
    return {'base':row,'primary_slots_host':primary,'plaintext_holders_host_bound':holders,
            'move_wire_host':move_wire_host,'move_compute_host':move_compute_host,
            'move_energy_island':move_energy,'fabric_energy_island':fabric_energy_island,
            'reserve_16_used':reserve_use,'reserve_16_remaining':16-reserve_use,
            'compute_host':cpu,'memory_host':memory,'network_host':wire,
            'care_deadline':care_deadline,'response_deadline':deadline,'response_phases':phases,
            'endpoint_volume_vector':endpoint_work,'endpoint_volume_budgets':endpoint_budgets,
            'endpoint_serial_rate':endpoint_rate,'provider_compute_burst_rate':compute_burst_rate,
            'island_port_rate':port_rate,'nonblocking_switch_rate':switch_rate,
            'all_to_one_wire':total_wire_pool,'capital_inventory':capital,
            'certificate_inventory':inventory,'authentication_attempts':authentication,
            'inequalities':inequalities}


def fresh_holding_factor():
    # Predictable Poisson domination at EVERY history, not merely a mean.
    # An additional onset raises the rounded binary load exponent by at most 11.
    return exp_majorant(ROOT_INTENSITY*(2**11-1))


@lru_cache(None)
def physical(e,d,r,pooled_rescue=True):
    hu,ru = old.factors(r)
    rd = 2-F(64,135)*r
    remaining = max(0,PROVIDERS-1-d)
    k = ceil(F(70*POOL+86*e,8))
    ph = (power(hu,remaining)*fresh_holding_factor()).shift(k)
    al = (power(hu,remaining)*fresh_holding_factor()).shift(ceil(F(70*POOL+86*(e+1),8)))
    if pooled_rescue:
        pr = power(ru,max(0,PROVIDERS-1-d-e))*power(3,e)*power(rd,d)*2
    else:
        # Concentrated hostile providers remove local rescue; credits never exceed 288.
        dl=min(d,old.N-1)
        pr=power(ru,max(0,old.N-1-dl-e))*power(3,min(e,old.N))*power(rd,dl)*2
    return ph.fractions(),pr.fractions(),al.fractions()


def cell(e,d,r,reading='slack',zeta=ZETA_EXAMPLE,pooled_rescue=True):
    (hl,hu),(rl,ru),(al,au)=physical(e,d,r,pooled_rescue)
    pc,cost,_=old.scenario(r,reading)
    debit=gamma(zeta)
    # Both directions of the gap enclosure are needed: inclusion uses lower
    # gaps, exclusion uses upper gaps. No borderline float is rounded to a sign.
    def gaps(ph,pr,alpha):
        b=ph+pr
        rho=b+old.PHYS+2*old.ARRIVAL_HAZARD_LIMIT
        pd=VALUE*old.DIV*F(1,2)*(pc-old.PC['D'])*(1-rho-b)-cost-b*WEALTH_SPAN-debit
        ex=VALUE*old.DIV*F(1,2)*pc*(1-rho-b)-cost-alpha*QUOTA_VALUE-(alpha+b)*WEALTH_SPAN-debit
        return pd,ex
    lo=gaps(hu,ru,au)
    hi=gaps(hl,rl,al)
    return {'gap_lower':lo,'gap_upper':hi,'ph_upper':hu,'pr_upper':ru,
            'alpha_upper':au,'hazard_upper':hu+F(3,2)*ru+old.PHYS+30*old.ARRIVAL_HAZARD_LIMIT}


def inside(e,d,r,reading='slack',zeta=ZETA_EXAMPLE,pooled_rescue=True):
    return min(cell(e,d,r,reading,zeta,pooled_rescue)['gap_lower'])>0


def e_edge(d,r,reading='slack',zeta=ZETA_EXAMPLE,pooled_rescue=True):
    if not inside(0,d,r,reading,zeta,pooled_rescue):
        return -1
    lo,hi=0,PROVIDERS
    while lo<hi:
        mid=(lo+hi+1)//2
        if inside(mid,d,r,reading,zeta,pooled_rescue):lo=mid
        else:hi=mid-1
    # Actual first excluded integer is established using the opposite enclosure.
    assert min(cell(lo+1,d,r,reading,zeta,pooled_rescue)['gap_upper'])<=0
    return lo


D_ZS = tuple(1+F(k,100) for k in range(1,61))


@lru_cache(None)
def down_tail(k,mu):
    # D <= Bin(pool*288,1/16)+Pois(pool*mu); union count may only be smaller.
    if k<=0:return F(1)
    candidates=[]
    for z in D_ZS:
        b=power(1+F(1,16)*(z-1),PROVIDERS)
        b=b*exp_majorant(POOL*mu*(z-1))*power(1/z,k)
        candidates.append(upper(b))
    return min(F(1),min(candidates))


@lru_cache(None)
def down_cut(mu):
    lo,hi=0,PROVIDERS
    while lo<hi:
        mid=(lo+hi)//2
        if POOL_DATES*down_tail(mid+1,mu)<=TAIL_SHARE:hi=mid
        else:lo=mid+1
    assert POOL_DATES*down_tail(lo+1,mu)<=TAIL_SHARE
    assert lo==0 or POOL_DATES*down_tail(lo,mu)>TAIL_SHARE
    return lo


def poisson_upper(mu,k):
    return min(F(1),F(mu)**k/factorial(k))


BACKGROUND_EDGE = next(k for k in range(1000)
                       if POOL_DATES*poisson_upper(POOL*old.MEAN,k+1)<=TAIL_SHARE)


def batch_pgf(z,A=AUDIENCE,q=ADOPTION):
    return (1-q+q*z)**A


B_ZS=tuple(1+F(k,1000) for k in range(1,501))


def offspring_factor(mean,z):
    x=F(mean)*(batch_pgf(z)-1)
    if x>=1:return None
    return 1/((1-x)*z)


def broadcast_tail(mean,R):
    pairs=[(offspring_factor(mean,z),z) for z in B_ZS]
    pairs=[(f,z) for f,z in pairs if f is not None and f<1]
    if not pairs:return F(1),None,None
    f,z=min(pairs)
    return upper(power(f,R-1)),z,f


def broadcast_bracket(R,bits=28):
    lo,hi=F(0),F(1)
    for _ in range(bits):
        mid=(lo+hi)/2
        tail,_,_=broadcast_tail(mid,R)
        if MT*old.ONSET*tail<=F(1,10**9):lo=mid
        else:hi=mid
    return lo,hi


def reservoir_tail(k,mean=BROADCAST_MEAN,ell=LAPSE):
    """A concrete ADDITIONAL joint timing model for aggregation, not a
    consequence of a per-lineage total-progeny mean or of lambda alone.

    Each intent record lapses with probability ell/date. Each record produces
    compound-Poisson broadcasts at rate ell*mean/date, independently or under
    the conditional pgf domination. Root immigration has predictable intensity
    <=ROOT_INTENSITY. h(z) is the one-date record pgf. Convexity gives contraction
    a=(h(z)-1)/(z-1)<1 and stationary H(z)<=exp(lambda*(z-1)/(1-a)).
    """
    candidates=[]
    for z in B_ZS[::5]:
        x=ell*mean*(batch_pgf(z)-1)
        if x>=1:continue
        hz=(ell+(1-ell)*z)/(1-x)
        if hz>=z:continue
        exponent=ROOT_INTENSITY*(z-1)**2/(z-hz)
        b=exp_majorant(exponent)*power(1/z,k)
        candidates.append((upper(b),z,hz,exponent))
    return min(candidates) if candidates else (F(1),None,None,None)


def pooled_channels(r,mu):
    # Ordinary independent spontaneous episodes only. Coordinated intent is
    # separately bounded through the reservoir domain and its overflow event.
    fh=1-F(3,4)*r
    fr=F(9,8)-F(8,9)*r
    bh=power(fh,PROVIDERS)*exp_majorant(POOL*old.MEAN*2047+POOL*mu*(1/fh-1))
    bh=bh.shift(ceil(F(70*POOL,8)))
    br=power(fr,PROVIDERS)*exp_majorant(POOL*old.MEAN*(3/fr-1)+POOL*mu*(1/fr-1))
    return {'ordinary_holding_channel':POOL_DATES*upper(bh),
            'ordinary_rescue_channel':POOL_DATES*upper(br),
            'physical_geometry':MT*old.PHYS}


def row(r,reading):
    mu=VACANCY_CAPS[r]
    dc=down_cut(mu)
    edge=e_edge(dc,r,reading)
    bmax=edge-BACKGROUND_EDGE
    R=edge+1
    btail,z,fac=broadcast_tail(BROADCAST_MEAN,R)
    rt,rz,rh,re=reservoir_tail(bmax+1)
    # Deliberately retain every old account class except the two disclosure
    # events which the new author decision removes from Mode I's target.
    accounts=dict(old.static_accounts())
    accounts.update(pooled_channels(r,mu))
    boundary=cell(edge,dc,r,reading)
    # Use the WORST permitted coordinated load throughout the rectangle. The
    # ordinary closed-form channels are retained additionally, conservatively.
    accounts['coordinated_load_channels']=MT*(boundary['ph_upper']+boundary['pr_upper'])
    accounts['domain_fault_vacancy_exit']=POOL_DATES*down_tail(dc+1,mu)
    accounts['background_episode_overflow']=POOL_DATES*poisson_upper(POOL*old.MEAN,BACKGROUND_EDGE+1)
    accounts['dormant_broadcast_reservoir_overflow']=POOL_DATES*rt
    accounts['broadcast_single_family_overflow']=MT*old.ONSET*btail
    # The maximal IC rectangle has pivotal probabilities ~1e-12; a permanent
    # worst-case coordinated load at that edge cannot meet a cosmic risk budget.
    return {'r':r,'reading':reading,'mu':mu,'d_cut':dc,'e_edge_at_d_cut':edge,
            'background_edge':BACKGROUND_EDGE,'B_max_IC_geometry':bmax,'R_bind_IC_geometry':R,
            'boundary':boundary,'next_ender':cell(edge+1,dc,r,reading),
            'local_rescue_edge_at_d40':e_edge(40,r,reading,pooled_rescue=False),
            'broadcast_mean':BROADCAST_MEAN,'broadcast_tail_upper':btail,'broadcast_z':z,
            'broadcast_factor':fac,'reservoir_z':rz,'reservoir_h_upper':rh,'reservoir_exponent':re,
            'accounts_at_IC_edge':accounts,'sum_at_IC_edge':sum(accounts.values())}


def protected_row(r,reading):
    """Recompute the largest operational ender cap, including the physical
    channel at that SAME load. The IC edge alone is insufficient at horizon T.
    """
    rr=row(r,reading)
    def fits(e):
        c=cell(e,rr['d_cut'],r,reading)
        return min(c['gap_lower'])>0 and MT*(c['ph_upper']+c['pr_upper']+old.PHYS)<=TAIL_SHARE
    lo,hi=0,rr['e_edge_at_d_cut']
    while lo<hi:
        mid=(lo+hi+1)//2
        if fits(mid):lo=mid
        else:hi=mid-1
    active=lo
    assert fits(active) and not fits(active+1)
    B=active-BACKGROUND_EDGE
    boundary=cell(active,rr['d_cut'],r,reading)
    rt,rz,rh,re=reservoir_tail(B+1)
    # Every family starts from one record; its total progeny exceeding the
    # reservoir cap can defeat this domain. Other families are NOT ignored:
    # their aggregate occupancy has the separate reservoir-pgf account.
    R=B+1
    bt,bz,bf=broadcast_tail(BROADCAST_MEAN,R)
    accounts=dict(rr['accounts_at_IC_edge'])
    accounts['coordinated_load_channels']=MT*(boundary['ph_upper']+boundary['pr_upper'])
    accounts['dormant_broadcast_reservoir_overflow']=POOL_DATES*rt
    accounts['broadcast_single_family_overflow']=MT*old.ONSET*bt
    rr.update(B_max=B,active_total_bound=active,R_bind=R,
              protected_boundary=boundary,accounts=accounts,raw_sum=sum(accounts.values()),
              probability_upper=min(F(1),sum(accounts.values())),
              reservoir_z=rz,reservoir_h_upper=rh,reservoir_exponent=re,
              broadcast_z=bz,broadcast_factor=bf,broadcast_tail_upper=bt)
    return rr


def founding_gaps(n,r,reading,zeta=ZETA_EXAMPLE):
    hu,ru=old.factors(r)
    ph=upper((power(hu,n-1)*fresh_holding_factor()).shift(ceil(F(70*POOL,8))))
    alpha=upper((power(hu,n-1)*fresh_holding_factor()).shift(ceil(F(70*POOL+86,8))))
    pr=upper(power(ru,n-1)*2)
    pc,cost,_=old.scenario(r,reading)
    b=ph+pr
    pd=VALUE*old.DIV*F(1,2)*(pc-old.PC['D'])*(1-2*b-old.PHYS)-cost-b*WEALTH_SPAN-gamma(zeta)
    ex=VALUE*old.DIV*F(1,2)*pc*(1-2*b-old.PHYS)-cost-alpha*QUOTA_VALUE-(alpha+b)*WEALTH_SPAN-gamma(zeta)
    return pd,ex


def founders(r,reading):
    lo,hi=2,PROVIDERS
    while lo<hi:
        mid=(lo+hi)//2
        if min(founding_gaps(mid,r,reading))>0:hi=mid
        else:lo=mid+1
    assert min(founding_gaps(lo,r,reading))>0
    assert min(founding_gaps(lo-1,r,reading))<=0
    return lo
