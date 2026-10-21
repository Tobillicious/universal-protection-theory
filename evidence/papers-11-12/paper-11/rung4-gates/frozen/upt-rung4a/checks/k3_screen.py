"""Exploratory k3 ledger. Passing arithmetic is not a completed service construction."""
from fractions import Fraction as F
from math import ceil,comb,gcd
from functools import lru_cache
import json,sys
sys.dont_write_bytecode=True
from common import ROOT,encode,baseline

@lru_cache(None)
def calculate():
    c,j,(old_accounts,oldq)=baseline()
    N,M,H,S,K,R,C,P=400,1032,242,171,3,73,74,90
    CERT=4288;FGC=304;BGC=64;FGW=126976;BGW=32768
    POOLFG=7*2**22;POOLBG=2**24
    QUOTA=400000;AUTHQ=2**25;SERVICE=2130000000;BATCHCAP=1024
    MEM=6144;INTER=F(45);IDLE=F(11);CONTROL=F(8)
    DELTA_STOCK=H*2048+(P-80)*1024+8192
    STOCK=j.STOCK+DELTA_STOCK
    FC,COPY,EC=j.FC,j.COPY,j.EC
    x=ceil(F(M*K,N-K));pop=M+x;primary=ceil(F(pop,S))
    assert x==8 and primary==7 and gcd(R,H)==1
    counts=[0]*H
    for rank in range(M):
        for u in range(R):counts[(R*rank+u)%H]+=1
    held=K*max(counts);keyheld=(2*K+1)*max(counts)
    arrivals=0
    for host in range(H):
        flags=[int((host-R*r)%H<R) for r in range(M)]
        ext=flags+flags[:H];w=sum(ext[:H]);arrivals=max(arrivals,w)
        for r in range(1,M):
            w+=ext[r+H-1]-ext[r-1];arrivals=max(arrivals,w)
    # Hall bound: proper union components of length l contain at most
    # K*ceil(M/H)*(l-R+1) demands and at least l-71 survivors.
    readcap=ceil(F(K*M,S))
    maxstart=K*ceil(F(M,H))
    hallproper=all(maxstart*(length-R+1)<=readcap*(length-71)
                   for length in range(R,H))
    assert hallproper and readcap*S>=K*M and readcap==19
    key_work=32*(2*K+1)*(2*K)*FC+F(K+1,20000)
    jobs=CERT*1694;perhost=ceil(F(jobs,S));gateops=ceil(F(4*2**31,S))
    gatecpu=F(gateops,2**24);gatewire=F(gateops,65536)
    cw=(7*CERT*80+ceil(F(CERT*79,H))*1694)*F(1,10000)
    snapshot=8*(H-1)+pop;copies=3*primary
    move=(2*copies+4)*COPY+F(3*pop,S)*F(1,10000)
    cpu=10+ceil(F(3648,S))+perhost*F(1,10000)+snapshot*COPY+move+gatecpu
    wire=ceil(F(P,S))+snapshot+8+primary+3+F(2048*(4096+pop),4096)+cw+2*copies+4+64+gatewire
    route=16*(4*K*M+2*H)*FC
    batch_entries=x+ceil(F(QUOTA,2*H))
    batch=batch_entries*(16*FC+8*F(1,2**24))
    restore_count=ceil(F(x,S))
    recovery=readcap+(C+x)*restore_count
    restore=recovery*COPY+restore_count*160*FC+route+batch
    transfer=F(2*M*K+65,POOLFG)
    care=F(1,20)+F(1,100)+(cpu+restore)/FGC+(wire+64+recovery)/FGW+F(1,8)+F(1,20)+F(1,20)+F(228,4096)+F(49,256)+j.GRACE+transfer
    response=j.BASE['response_deadline']-F(9*288*400,2**24)+F(9*288*400,POOLFG)+j.GRACE+transfer
    phase=F(1,20)+(perhost*F(1,10000)+gatecpu+route)/FGC+(cw+gatewire+128)/FGW
    events=j.CP_EVENTS+2*x
    source_host=ceil(primary*(1+2*j.CLOCK)/j.NOMINAL_PERIOD)+2
    bgwire=j.RATE*(held+R*K*primary)+2*source_host
    bgcpu=bgwire*COPY+source_host*key_work
    primaryheld=max(counts)+6
    memory=(j.BASE['memory_host']+(CERT-4224)*1694*F(1,10**5)
       +2*x+2*x*F(1,10**5)+2*held*(1+128*F(1,10**5))
       +2*keyheld*130*F(1,10**5)+16+batch_entries*32*F(1,10**5)
       +2*primaryheld*128*F(1,10**5))
    recv=F(BGC,2);forward=F(BGC,2)
    cp=((2*K*COPY+2*key_work)/recv+F(8192,POOLBG)+F(1,20)
        +K*R*COPY/forward+F(1,BGW)+(K*arrivals+x)*COPY/recv
        +F(1,4096)+F(1,8)+COPY/recv+F(1,BGW)+2*j.CLOCK)
    normalpool=2*K*400*pop*j.RATE+4096
    residual=POOLBG-normalpool
    assert residual>0
    prefetch=(F(1,20)+F(1,8)+(route+recovery*COPY)/FGC
      +F(recovery+1,FGW)+F(2*K*M+64+8192,residual)+F(1,4096)+F(1,20)+F(1,20))
    # Conservatively rebuild two retained generations. This is a work inventory,
    # not a proven globally concurrent calendar under partial failures.
    repair=2*2*(K*M*C+K*M*H+K*K*M*C)
    repairwire=repair*(1+F(1,65536))+128
    bytedays=ceil(repairwire/QUOTA)+2
    returned=2*2*(M*H+K*M*C)
    authdays=ceil(F(4*128*returned,AUTHQ))+2
    header=2*(K+2*K+1)*M*C*j.RATE/F(65536)
    keypayload=2*(2*K+1)*M*C*j.RATE/F(4194304)
    io=2*K*M*C*j.RATE+4*x
    primaryendpoints=2*C*events;primarybudget=H*pop
    primarywire=source_host*C+primaryheld*j.RATE
    primarylag=512*COPY/FGC+F(513,FGW)+F(1,4096)+F(1,8)+2*j.CLOCK
    backup=(H*pop+2*pop+400*H)*COPY
    movetotal=(6*pop+4*S)*COPY+3*pop*F(1,10000)
    fabric=1+2*9*288*F(1,10**5)+2*288*F(1,10**5)
    activity0=(backup+movetotal)*EC+fabric+2*(F(4*2**31,2**16)+CERT*1694*80*F(1,10000))*F(1,10**5)
    activity=activity0+(io+header+keypayload+QUOTA)*(COPY*EC+F(2,10**5))
    spent=(j.BASE['spent']+(INTER-16)+IDLE+F(P-79,127)+F(5*x,4*127)
        +events*key_work*EC+CONTROL*EC+(CERT-4224)*1694*F(1,10000)*EC)
    flow=(H+P-79)*F(24,5)
    auth=(1496509296+2*(CERT-4224)*1694*79
        +4*(K*128+(2*K+1)*130)*C*M*j.RATE
        +8*400*32+8*H*x*32+H**2*x+8*batch_entries+AUTHQ+primaryendpoints
        +2*(P-80)*16)
    certs=4130+(P-79)+64+16+3+4
    hostrepair=16384
    dailycpu=cpu+restore+bgcpu+hostrepair*COPY+F(CONTROL,S)
    dailywire=wire+64+recovery+bgwire+hostrepair
    mpc=(2*24*H*H*(4096+pop)+2*H*H*(4096+pop)+H*24*(4096+pop))*FC
    checks={
      'care':care<=F(19,20),'provider':response<=F(19,20),'phase':phase<=F(1,8),
      'checkpoint':cp<=F(1,4),'state_age':j.PERIOD+cp<=1,
      'prefetch':prefetch<=F(63,128),'prefetch_before_provider':prefetch<=F(1,20)+F(1,10)+F(24,144)+F(9,64),
      'primary_lag':primarylag<=cp,'slots':pop<=8*S,'memory':memory<=MEM,
      'daily_cpu':dailycpu<=256,'daily_wire':dailywire<=262144,
      'background_cpu':bgcpu+hostrepair*COPY+F(CONTROL,S)<=BGC,
      'background_wire':bgwire+hostrepair<=BGW,
      'pool_background':normalpool+repairwire<=POOLBG,
      'interconnect':activity<=INTER,'energy':spent<=flow,
      'authentication':auth<=SERVICE<2**31,'certificates':certs<=CERT,
      'canonical_batch':batch_entries<=BATCHCAP,'MPC':mpc<=3648,
      'repair_byte_screen32':bytedays<=32,'repair_auth_screen32':authdays<=32,
      'primary_copy_volume':primaryendpoints*(1+F(1,65536))<=primarybudget,
      'primary_host_service':primarywire<=snapshot,
      'control_compute':S*route+pop*160*FC+batch+F(1,100)<CONTROL,
      'Hall_proper_components':hallproper,'Hall_full_circle':readcap*S>=K*M,
      'pool_quorum_safety':2*202-N>K,'local_quorum_safety':2*S-H>71}
    # Conditional all21 numerical ledger screen: retain the inherited predicates
    # only where the larger plant is assumed to implement the same interface.
    m=j.m
    saved=(m.SPARES,m.STOCK_EXTRA,m.CERT_LIMIT)
    try:
        m.SPARES=P;m.STOCK_EXTRA=saved[1]+j.STOCK_ADD+DELTA_STOCK;m.CERT_LIMIT=CERT
        m.committee.cache_clear()
        full=m.full(H,W=42800)
        assert full and len(full['rows'])==10
        p0=F(1,500);av=10**120*F(comb(H+P,80))*p0**80
        quorum=10**120*F(comb(H,72))*p0**72
        rows={}
        for name,row in full['rows'].items():
            a=row['accounts'].copy()
            a['care_mpc_unavailability']=av;a['background_episode_overflow']=av
            a['quorum_liveness']+=quorum
            rows[name]={'accounts':a,'with_reserve':sum(a.values())+full['eta_cert'],
              'IC_gap_lower':row['IC_gap_lower'],'IC_extraction_gap_lower':row['IC_extraction_gap_lower']}
        worst=max(rows,key=lambda k:rows[k]['with_reserve'])
        total=rows[worst]['with_reserve']
    finally:
        m.SPARES,m.STOCK_EXTRA,m.CERT_LIMIT=saved;m.committee.cache_clear()
    checks['all21_budget']=total<=F(1,10**6)
    checks['all10_IC']=all(min(r['IC_gap_lower'],r['IC_extraction_gap_lower'])>0 for r in rows.values())
    ref=old_accounts['with_certificate_reserve']
    def physical(p,n,r):
        return 10**120*(2*F(comb(n,80))*p**80+F(comb(H,r))*p**r+F(comb(H,110))*p**110)
    nonphysical=total-physical(F(1,500),H+P,72)
    lo,hi=0,10**13;scale=10**15
    while hi-lo>1:
        mid=(lo+hi)//2;p=F(mid,scale)
        if nonphysical+physical(p,H+P,72)<=F(1,10**6):lo=mid
        else:hi=mid
    margins={
      'energy':(flow-spent)/flow,'memory':(MEM-memory)/MEM,
      'interconnect':(INTER-activity)/INTER,'care':(F(19,20)-care)/F(19,20),
      'provider':(F(19,20)-response)/F(19,20),
      'checkpoint':(F(1,4)-cp)/F(1,4),
      'k_integer_headroom_against_two':1,'failure_bound':total}
    refm={
      'energy':oldq['energy_margin']/oldq['energy_flow'],
      'memory':(4512-oldq['memory_required'])/4512,
      'interconnect':(oldq['interconnect_allocation']-oldq['interconnect_activity'])/oldq['interconnect_allocation'],
      'care':(F(19,20)-oldq['care_deadline'])/F(19,20),
      'provider':(F(19,20)-oldq['provider_deadline'])/F(19,20),
      'checkpoint':(F(1,4)-oldq['checkpoint_bound'])/F(1,4),
      'k_integer_headroom_against_two':0,'failure_bound':ref}
    strict={key:margins[key]>refm[key] for key in margins if key!='failure_bound'}
    strict['smaller_failure_bound']=total<ref
    strict['larger_full_budget_fault_boundary']=F(lo,scale)>F(2216911380884,10**15)
    return {'status':'UNVERIFIED GENERALIZATION: static arithmetic and inherited-account screen only',
      'conditional_k3_witness_established':False,'rung4_established':False,
      'all_static_checks':all(checks.values()),'checks':checks,
      'plant':{'N':N,'M':M,'H':H,'guaranteed_live_hosts':S,'whole_island_tolerance':K,'local_replica_count':R,
       'passive_sites':P,'total_site_loss_cap':79,'memory_cap':MEM,'foreground_cpu':FGC,'background_cpu':BGC,
       'foreground_wire':FGW,'background_wire':BGW,'pool_foreground':POOLFG,'pool_background':POOLBG,
       'interconnect':INTER,'daily_host_cpu_cap':256,'daily_host_wire_cap':262144,
       'key_scheme':'fresh512-bit DEK;4-of7 degree3 Shamir;three fresh512-bit coefficients',
       'pool_journal_quorum':202,'local_journal_quorum':S,'certificate_work_cap':CERT,
       'protected_auth_cap':SERVICE,'attempt_cap_per_gate':2**31,'effective_bits':459,'canonical_batch_cap':BATCHCAP},
      'prices':{'incremental_stock':DELTA_STOCK,'total_stock_per_island':STOCK,
        'incremental_idle_per_island_date':10,'new_idle_total':IDLE,
        'per_host_upgrade_stock_target':2048,'per_new_passive_stock_target':1024,'fabric_upgrade_stock_target':8192,
        'all_prices_are_unmeasured_joint_targets':True},
      'quantities':{'exiles':x,'population':pop,'memory':memory,'energy_flow':flow,'energy_use':spent,
       'energy_margin':flow-spent,'interconnect_activity':activity,'care':care,'provider':response,
       'checkpoint':cp,'prefetch':prefetch,'primary_lag':primarylag,
       'authentication_inventory':auth,'certificates':certs,'canonical_batch':batch_entries,
       'daily_cpu':dailycpu,'daily_wire':dailywire,'background_cpu':bgcpu,'background_wire':bgwire,
       'repair_endpoint_work':repairwire,'repair_byte_work_dates':bytedays,'repair_auth_work_dates':authdays,
       'per_island_reseed_endpoint_quota':QUOTA,'repair_auth_daily_quota':AUTHQ,
       'per_host_reseed_endpoint_service_target':hostrepair,'source_read_cap':readcap,
       'per_home_max_holder_records':max(counts),'max_holder_arrivals':arrivals,
       'holders_image_records':held,'holders_share_records':keyheld},
      'all21_screen':{'rows':rows,'worst':worst,'with_reserve':total,
        'new_p_boundary_safe':F(lo,scale),'new_p_boundary_next_fails':F(hi,scale),
        'unchanged_account_predicates_require_generalized_service_proof':True},
      'benchmark_comparison':{'preliminary_pre_margins':margins,'TW1_margins':refm,'strict_comparisons':strict,
        'all_selected_static_comparisons_strict':all(strict.values()),
        'four_phase_union_screen':3*total+ref,'four_phase_union_fits':3*total+ref<=F(1,10**6)},
      'unproved_obligations':['Concurrent32-date repair calendar and adaptive partial-read budget',
       'Degree3 key/authority exposure composition and epoch transitions',
       'Primary snapshot reuse at the generalized replica calendar',
       'All21 retained predicate applicability, certificate inventory and new slot/journal contracts',
       'Commissioning, capital supply and preactivation care',
       'Paid k3-to-k2 twilight transition without a third retained generation',
       'External physical capacity/threat trajectory and trusted-machine realization']}

if __name__=='__main__':
    assert not sys.argv[1:]
    print(json.dumps(encode(calculate()),sort_keys=True,indent=2))
