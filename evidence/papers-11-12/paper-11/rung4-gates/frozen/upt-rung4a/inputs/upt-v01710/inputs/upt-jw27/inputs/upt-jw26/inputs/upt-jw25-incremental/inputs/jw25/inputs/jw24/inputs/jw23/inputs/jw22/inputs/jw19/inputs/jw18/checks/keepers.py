"""Keeper capacity trade-offs under explicit physical-mark conditions.

Mean capacity is not a tail guarantee. Conditional holding/rescue tables use
the actual up/down P kernel and a rational Chernoff grid. Good host service,
network admission and paid care are separate requirements from L_p,L_n.
"""
from fractions import Fraction as F
from functools import lru_cache
from math import ceil
import model as m
from rational_bounds import power,upper

ZS=tuple([1+F(k,200) for k in range(1,401)]+[F(k) for k in range(4,21)])


def probability_upper(bound):
    # A probability is at most1. Cap loose positive-exponent moments before
    # converting them into million-bit Fractions for impossible candidates.
    if bound.exponent>=0:return F(1)
    return min(F(1),upper(bound))


def mean_line(Ln,q,scale=1,cap=F(72,5),legacy_h0=False):
    load=(70 if legacy_h0 else m.CHI*q)*scale
    numerator=load+(m.POP*scale-Ln)*m.CHI*q
    need=ceil(numerator/(cap+m.CHI*q))
    return need if need<=m.base.N*scale else None


@lru_cache(None)
def local_down_cut(mu=F(631,100)):
    def tail(k):
        vals=[]
        for z in tuple(1+F(k,10) for k in range(1,101))+(F(12),F(16),F(20),F(30),F(40),F(60),F(100)):
            vals.append(upper(power(1+F(1,16)*(z-1),288)*m.old.exp_majorant(mu*(z-1))*power(1/z,k)))
        return min(vals)
    return next((d for d in range(288) if m.MT*tail(d+1)<=m.old.TAIL_SHARE),288)


def channels(Lp,Ln,q,scale=1,d=0,r=F(9,10)):
    np=m.base.N*scale
    total=m.POP*scale
    if not 0<=Lp<=np or not 0<=Ln<=total-np:raise ValueError('keeper counts')
    down=min(d,Lp)
    up=Lp-down
    pc=m.base.scenario(r,'slack')[0]
    pu=F(29,30)*pc
    pd=F(1,2)*pc
    attackers=total-Lp-Ln
    load=m.CHI*q*(scale+attackers)   # background chi*q per island, all attackers
    needed=ceil(load/16)
    badproviders=np-Lp
    bh=[];br=[]
    for z in ZS:
        hold=power(1-pu+pu/z,up)*power(1-pd+pd/z,down)*power(z,max(0,needed-1))
        # Each attacking provider may withhold both jobs and add one request.
        ru=F(1,30)*z+F(29,30)*(1-pc+pc/z**2)
        rd=F(1,2)*z+F(1,2)*(1-pc+pc/z**2)
        rescue=power(ru,up)*power(rd,down)*power(z,badproviders)
        bh.append(probability_upper(hold));br.append(probability_upper(rescue))
    return {'holding':min(F(1),min(bh)),'rescue':min(F(1),min(br)),
            'load':load,'loyal_previous_down':down,'attacking_providers':badproviders,
            'mean_holding':16*(up*pu+down*pd),
            'mean_rescue_net':2*(up*pu+down*pd)-F(up,30)-F(down,2)-badproviders}


def least(Ln,q,scale=1,d=0,r=F(9,10)):
    trials=m.MT//scale
    def fits(Lp):
        required=m.CHI*q*(scale+m.POP*scale-Lp-Ln)
        if required>16*Lp:return False
        if m.base.N*scale-Lp>2*Lp:return False
        x=channels(Lp,Ln,q,scale,d,r)
        return trials*(x['holding']+x['rescue']+m.base.PHYS)<=m.old.TAIL_SHARE
    if not fits(m.base.N*scale):return None
    lo,hi=0,m.base.N*scale
    while lo<hi:
        mid=(lo+hi)//2
        if fits(mid):hi=mid
        else:lo=mid+1
    return {'Lp':lo,'Ln':Ln,'channels':channels(lo,Ln,q,scale,d,r),
            'previous':None if lo==0 else channels(lo-1,Ln,q,scale,d,r),
            'trials':trials,'q':q,'scale':scale,'d':d}


def audit():
    resource=m.old.operating_resources()
    host_min=next(s for s in range(1,239)
                  if s*8>=m.base.POP and ceil(F(m.base.K,s))<=5)
    return {'provider_joint_energy_command':F(18),
            'provider_joint_compute':20,'provider_joint_wire':8,
            'same_provider_with_max_personal_privileges':F(18)+m.base.SIGMA+m.base.DIV,
            'net_host_flow_command_if_all_transfers_count':m.base.FLOW,
            'care_all_minds_island':F(m.base.POP,127),
            'care_one_mind':F(1,127),
            'committee_job_compute':m.base.JOB_COMPUTE,
            'committee_job_energy':m.base.JOB_COMPUTE*m.base.EC,
            'total_committee_energy':m.base.ENERGY['committee'],
            'total_MPC_energy':m.base.ENERGY['mpc_refresh_recovery'],
            'MOVE_energy':resource['move_energy_island'],
            'fabric_energy':resource['fabric_energy_island'],
            'admission_commissioning_per_mind':m.base.EC*m.base.ESCROW_UNIT,
            'minimum_live_hosts_slots_and_spreading':host_min,
            'minimum_loyal_host_roles_after62plus24':host_min+86,
            'hosts_to_retain_roster152_after62plus24':238,
            'exact_inherited_deadline':resource['response_deadline'],
            'literal_0_811_excess':resource['response_deadline']-F(811,1000),
            'strict_deadline_compute_rate_option':129,
            'strict_deadline_option_bound':resource['response_deadline']-F(20,128)+F(20,129),
            'exact_joint_command_identity_assignment_supplied':False}
