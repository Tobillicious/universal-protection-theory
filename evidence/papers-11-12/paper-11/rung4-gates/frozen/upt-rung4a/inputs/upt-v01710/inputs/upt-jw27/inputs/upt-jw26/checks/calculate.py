"""JW2.6: conditional two-island construction; all decisions exact."""
from pathlib import Path
from fractions import Fraction as F
from math import ceil,comb
from collections import deque
import importlib.util,json,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('jw25_incremental',ROOT/'inputs/upt-jw25-incremental/checks/calculate.py')
inc=importlib.util.module_from_spec(spec);spec.loader.exec_module(inc)
prior=inc.p.prior;old=prior.old;m=old.source;b=m.b
EC=F(1,127);FC=F(127,10**9);COPY=F(127,80000)
N,M,H,S,K=400,1032,242,172,2
PASSIVE=80;PERIOD=F(3,4);CLOCK=F(1,1024);LAG=F(1,4)
NOMINAL_PERIOD=PERIOD-2*CLOCK
CP_EVENTS=ceil(M*(1+2*CLOCK)/NOMINAL_PERIOD)+1
RATE=F(CP_EVENTS,M)
FG_CPU=152;BG_CPU=14;FG_WIRE=63488;BG_WIRE=3072
POOL_BG=2**22;POOL_FG=7*2**21;GRACE=F(1,400)
MEM_CAP=4512;INTER=F(93,4);IDLE=F(1)
RESEED_ENDPOINT_QUOTA=30720
RESEED_LIMIT=64
STOCK_ADD=242*512+1024+1728
STOCK=1070720+STOCK_ADD
BASE=m.resources(242)


def holder_counts(groups):
    counts=[0]*H
    for _ in range(groups):
        for record in range(M):
            for j in range(71):counts[(71*record+j)%H]+=1
    return counts


def read_assignment(lost):
    groups=[[] for _ in range(H)]
    for r in range(2*M):groups[(71*(r%M))%H].append(r)
    q=deque();out={};counts={};delay=0
    for tick in range(2*H):
        host=tick%H
        for record in groups[host]:q.append((record,tick))
        if host in lost:continue
        for _ in range(min(12,len(q))):
            r,start=q.popleft();delay=max(delay,tick-start)
            if tick>=H:
                assert r not in out
                out[r]=host;counts[host]=counts.get(host,0)+1
    assert len(out)==2*M and max(counts.values())<=12 and delay<=70
    assert all((host-71*(record%M))%H<=70 for record,host in out.items())
    return max(counts.values())


def algebra():
    from itertools import combinations
    state_holders={0,1,2};key_holders={0,1,2,3,4}
    pairs=0
    for lost in combinations(range(N),2):
        assert state_holders-set(lost)
        assert len(key_holders-set(lost))>=3
        pairs+=1
    gf,inv=prior.gf,prior.inv
    triples=list(combinations(range(1,6),3));tests=0
    for secret in [0,1,65535,0x1234]:
        for aa,bb in [(0,0),(1,2),(65535,0x6789)]:
            values={x:secret^gf(aa,x)^gf(bb,gf(x,x)) for x in range(1,6)}
            for xs in triples:
                got=0
                for x in xs:
                    weight=1
                    for y in xs:
                        if x!=y:weight=gf(weight,gf(y,inv(x^y)))
                    got^=gf(weight,values[x])
                assert got==secret;tests+=1
    # For any fixed secret, two observed values uniquely fix the two random
    # coefficients: determinant xy(x+y) !=0. Thus they reveal no secret.
    for x,y in combinations(range(1,6),2):
        assert gf(x,gf(y,y))^gf(y,gf(x,x))
    state_counts=holder_counts(2);key_counts=holder_counts(5)
    assert max(state_counts)==606 and max(key_counts)==1515
    masks=[set((j+i)%H for i in range(70)) for j in range(H)]
    masks += [set((j+37*i)%H for i in range(70)) for j in range(16)]
    masks.append(set())
    assert all(read_assignment(mask)<=12 for mask in masks)
    # Staggered holder calendar: any242 consecutive rank ticks across the
    #1032-rank wrap gives at most72 arrivals/home group,144 for two groups.
    max_arrivals=0
    for host in range(H):
        flags=[int((host-71*r)%H<71) for r in range(M)]
        ext=flags+flags[:H];window=sum(ext[:H])
        max_arrivals=max(max_arrivals,window)
        for start in range(1,M):
            window+=ext[start+H-1]-ext[start-1]
            max_arrivals=max(max_arrivals,window)
    assert max_arrivals<=72
    p=F(1,500);tail=F(comb(H,71))*p**71
    assert tail<=1
    assert all(tail*F(comb(H-j,71-j),comb(H,71))<=p**j for j in range(72))
    return {'two_island_erasure_supports_per_home':pairs,'all400_homes_by_cyclic_symmetry':True,
        'three_share_reconstructions':tests,'two_share_secrecy_determinants':10,
        'ciphertext_code':'systematic[3,1,3] repetition; fixed home and two foreign islands',
        'key_scheme':'3-of-5 Shamir;32 GF(2^16) limbs;fresh512-bit key and two512-bit coefficients',
        'local_replication':71,'mirror_records_per_physical_host':606,
        'key_share_records_per_physical_host':1515,'source_matching_masks':len(masks),
        'source_reads_per_live_host_max':12,'pool_quorum':202,'pool_quorum_honest_intersection_lower':2,
        'max_holder_arrivals_per_home_over242_rank_ticks':max_arrivals,
        'sharp_subset_tail_counterexample_probability':tail,
        'subset_moment_orders_checked':72}


def quantities():
    x=ceil(F(M*K,N-K));pop=M+x;primary=ceil(F(pop,S));held=606;keyheld=1515
    key_work=32*5*4*FC+F(3,2)*F(1,10000)
    snapshot=8*241+pop;copies=3*primary
    perhost=ceil(F(4224*1694,S));gateops=ceil(F(4*2**31,S))
    gatecpu=gateops*F(1,2**24);gatewire=gateops*F(1,65536)
    cw=(7*4224*80+ceil(F(4224*79,H))*1694)*F(1,10000)
    move=(2*copies+4)*COPY+F(3*pop,S)*F(1,10000)
    cpu=10+ceil(F(3648,S))+perhost*F(1,10000)+snapshot*COPY+move+gatecpu
    wire=ceil(F(PASSIVE,S))+snapshot+8+primary+3+F(2048*(4096+pop),4096)+cw+2*copies+4+64+gatewire
    route=16*(4*2*M+2*H)*FC
    batch_entries=x+ceil(F(RESEED_ENDPOINT_QUOTA,2*H))
    batch=batch_entries*(16*FC+8*F(1,2**24))
    restore_count=ceil(F(x,S))
    recovery_images=12+(72+6)*restore_count
    restore=recovery_images*COPY+restore_count*160*FC+route+batch
    transfer=F(2*M*K+65,POOL_FG)
    care=F(1,20)+F(1,100)+(cpu+restore)/FG_CPU+(wire+64+recovery_images)/FG_WIRE+F(1,8)+F(1,20)+F(1,20)+F(228,4096)+F(49,256)+GRACE+transfer
    response=BASE['response_deadline']-F(9*288*400,2**24)+F(9*288*400,POOL_FG)+GRACE+transfer
    phase=F(1,20)+(perhost*F(1,10000)+gatecpu+route)/FG_CPU+(cw+gatewire+128)/FG_WIRE
    # Relays are assigned by r mod172 for a staggered calendar; they need
    # not be final holders. Pay one remote relay plus71 final local copies.
    source_events=CP_EVENTS+2*x
    host_source_events=ceil(6*(1+2*CLOCK)/NOMINAL_PERIOD)+2
    bg_wire=RATE*(held+71*2*primary)+2*host_source_events
    bg_cpu=bg_wire*COPY+host_source_events*key_work
    # Additional migrant primary versions were missing from the frozen JW24
    # memory expression. Add both primary generations and extra field/key words.
    memory=(BASE['memory_host']+2*x+2*x*F(1,10**5)+
        2*held*(1+128*F(1,10**5))+2*keyheld*130*F(1,10**5)+16+batch_entries*32*F(1,10**5)+
        2*309*128*F(1,10**5))
    # Background checkpoint queue: two states/four source images,142 fanouts,
    #144 mirror receives; six recovery records may join the receive calendar.
    # Both states' fresh entropy/sharing work is included. Reseeding is
    # lower priority and blocks at most one state-sized packet/CPU copy.
    recv=F(BG_CPU,2);forward=F(BG_CPU,2)
    checkpoint=((4*COPY+2*key_work)/recv+F(3264,POOL_BG)+F(1,20)+142*COPY/forward+
        F(1,BG_WIRE)+150*COPY/recv+F(1,4096)+F(1,8)+COPY/recv+F(1,BG_WIRE)+2*CLOCK)
    normal_pool_rate=4*400*pop*RATE+4096
    residual_pool_rate=POOL_BG-normal_pool_rate
    assert residual_pool_rate>0
    # Local71-holder copies use foreground host shares. Inter-island reads
    # use only the residual pool rate after ordinary CP reservations.
    prefetch=(F(1,20)+F(1,8)+(route+recovery_images*COPY)/FG_CPU+
        F(recovery_images+1,FG_WIRE)+F(2*2*M+64+3264,residual_pool_rate)+
        F(1,4096)+F(1,20)+F(1,20))
    pre_fabric=F(1,20)+F(1,10)+F(24,144)+F(9,64)
    # All lost copies plus temporary recovery durability and return are paid.
    repair_data_endpoints=2*(2*M*72+2*M*H+4*M*72)
    # Fresh share records are rewritten every CP, including on returned
    # islands. Normal sharing work already pays this; no archive is rebuilt.
    repair_wire=repair_data_endpoints*(1+F(1,65536))+128
    repair_days=ceil(repair_wire/RESEED_ENDPOINT_QUOTA)+2
    header=F(2*7*M*72,65536)*RATE
    key_payload=2*5*M*72*RATE*F(1,4194304)
    normal_image_io=2*2*M*72*RATE+4*x
    # Reuse the old primary snapshot budget for fresh71-holder primary images.
    # Even counting both endpoints,72 copies at the new calendar use fewer
    # records than the old242*pop primary snapshot allocation.
    primary_copy_endpoints=2*72*source_events
    primary_copy_budget=H*pop
    primary_snapshot_wire=host_source_events*72+309*RATE
    primary_lag=(F(222)*COPY/FG_CPU+F(223,FG_WIRE)+F(1,4096)+F(1,8)+2*CLOCK)
    # Recompute inherited primary backup/MOVE activity at pop1038 and172
    # serving hosts. Copying the old1032/164 activity would omit this delta.
    backup=(H*pop+2*pop+400*H)*COPY
    move_total=(6*pop+4*S)*COPY+3*pop*F(1,10000)
    fabric_energy=1+2*9*288*F(1,10**5)+2*288*F(1,10**5)
    base_activity=(backup+move_total)*EC+fabric_energy+2*(F(4*2**31,2**16)+4224*1694*80*F(1,10000))*F(1,10**5)
    # Price a full local repair quota, not a pool average. Per-island energy
    # throttling is essential at a returned island with an entire store missing.
    activity=base_activity+(normal_image_io+header+key_payload+RESEED_ENDPOINT_QUOTA)*(COPY*EC+F(2,10**5))
    # Four compute/date pays source assignment, reconstructions, mapping and
    # issuance; key sharing/entropy is charged separately. Gate work was prepaid.
    control=F(4)
    spent=BASE['spent']+(INTER-16)+IDLE+F(1,127)+F(5*x,4*127)+source_events*key_work*EC+control*EC
    flow=(H+PASSIVE-78)*F(24,5)
    #4 auth units/field,128 fields/record,7 records (2 images+5 shares).
    repair_auth_quota=2**24
    urgent_endpoint_bound=2*M+2*72*x+128
    urgent_auth_bound=4*(128*(2*M+2*72*x)+130*2*M)
    returned_data_endpoints=2*(M*H+2*M*72)
    repair_auth_days=ceil(F(4*128*returned_data_endpoints,repair_auth_quota))+2
    auth=(1496509296+4*(2*128+5*130)*72*M*RATE+8*400*32+8*242*x*32+
        H**2*x+8*batch_entries+repair_auth_quota+primary_copy_endpoints)
    # Original4130 +1 passive +64 journal +16 CP/key roots +3 exile batches
    # +4 reseed/return roots, all under the fully prepaid4224 work ceiling.
    cert=4130+1+64+16+3+4
    pool_bg=4*400*pop*RATE+4096+repair_wire
    reseed_host_wire=F(768)
    daily_cpu=cpu+restore+bg_cpu+reseed_host_wire*COPY+F(4,S)
    daily_wire=wire+64+recovery_images+bg_wire+reseed_host_wire
    mpc=(2*24*H*H*(4096+pop)+2*H*H*(4096+pop)+H*24*(4096+pop))*FC
    checks={'care_deadline':care<=F(19,20),'provider_deadline':response<=F(19,20),
        'committee_phase':phase<=F(1,8),'state_age':PERIOD+checkpoint<=1,
        'checkpoint_lag':checkpoint<=LAG,'sealed_prefetch_before_provider_fabric':prefetch<=pre_fabric,
        'sealed_prefetch_before_half_date':prefetch<=F(1,2),'slots':pop<=8*S,
        'clock_padded_pin_release':prefetch<=F(63,128),
        'primary_checkpoint_reuses_paid_copy_volume':primary_copy_endpoints*(1+F(1,65536))<=primary_copy_budget,
        'primary_checkpoint_reuses_paid_host_service':primary_snapshot_wire<=snapshot,
        'primary_checkpoint_freshness':primary_lag<=checkpoint,
        'memory':memory<=MEM_CAP,'daily_compute':daily_cpu<=128,'daily_wire':daily_wire<=16384,
        'background_CPU':bg_cpu+reseed_host_wire*COPY+F(4,S)<=BG_CPU,
        'background_wire':bg_wire+reseed_host_wire<=BG_WIRE,
        'pool_background_wire':pool_bg<=POOL_BG,'interconnect':activity<=INTER,
        'energy':spent<=flow,'authentication_reserve':auth<=7*2**28,'certificates':cert<=4224,
        'canonical_batch_capacity':batch_entries<=344,
        'MPC_prepaid_cap':mpc<=3648,'reseed_progress_bound':repair_days<=RESEED_LIMIT,
        'reseed_auth_progress_bound':repair_auth_days<=RESEED_LIMIT,
        'urgent_endpoint_budget':urgent_endpoint_bound<=RESEED_ENDPOINT_QUOTA,
        'urgent_auth_budget':urgent_auth_bound<=repair_auth_quota,
        'control_compute_budget':S*route+pop*160*FC+batch+F(1,100)<control}
    return {'exiles_per_destination':x,'post_outage_population':pop,'primary_per_serving_host':primary,
        'foreground_CPU':cpu,'foreground_wire':wire,'recovery_CPU_per_host':restore,
        'care_deadline':care,'provider_deadline':response,'committee_phase':phase,
        'checkpoint_bound':checkpoint,'sealed_prefetch_bound':prefetch,
        'background_CPU':bg_cpu,'background_wire':bg_wire,'daily_CPU':daily_cpu,'daily_wire':daily_wire,
        'memory_required':memory,'key_compute_per_checkpoint_per_state':key_work,
        'nominal_checkpoint_period':NOMINAL_PERIOD,'checkpoint_events_per_home_date_upper':CP_EVENTS,
        'checkpoint_source_events_per_care_island_upper':source_events,
        'primary_checkpoint_copy_endpoints':primary_copy_endpoints,'paid_primary_copy_budget':primary_copy_budget,
        'primary_checkpoint_auth_invocations_paid':primary_copy_endpoints,
        'primary_checkpoint_wire_per_host':primary_snapshot_wire,'primary_checkpoint_lag':primary_lag,
        'urgent_recovery_endpoint_bound':urgent_endpoint_bound,'urgent_recovery_auth_bound':urgent_auth_bound,
        'daily_repair_auth_quota':repair_auth_quota,'repair_auth_completion_dates':repair_auth_days,
        'post_outage_inherited_copy_activity':base_activity,
        'inherited_copy_activity_increase':base_activity-BASE['interconnect_used'],
        'interconnect_activity':activity,'interconnect_allocation':INTER,
        'energy_use':spent,'energy_flow':flow,'energy_margin':flow-spent,
        'authentication_inventory':auth,'certificate_inventory':cert,'MPC_refresh_compute':mpc,
        'canonical_batch_entries_max':batch_entries,
        'pool_background_wire_with_full_global_reseed_batch':pool_bg,
        'global_repair_endpoint_units':repair_wire,'per_island_daily_reseed_endpoint_quota':RESEED_ENDPOINT_QUOTA,
        'reseed_completion_dates_after_stable_return':repair_days,
        'checks':checks,'all_checks':all(checks.values())}


def lower_energy_variant():
    global INTER,RESEED_ENDPOINT_QUOTA,RESEED_LIMIT
    saved=(INTER,RESEED_ENDPOINT_QUOTA,RESEED_LIMIT)
    try:
        INTER=F(45,2);RESEED_ENDPOINT_QUOTA=7808;RESEED_LIMIT=245
        q=quantities();assert q['all_checks'],q['checks']
        return q
    finally:INTER,RESEED_ENDPOINT_QUOTA,RESEED_LIMIT=saved


def grid_audit():
    global BG_CPU,BG_WIRE,POOL_BG,MEM_CAP,INTER,PASSIVE
    normal=quantities();saved=(BG_CPU,BG_WIRE,POOL_BG,MEM_CAP,INTER,PASSIVE)
    trials={}
    try:
        BG_CPU=13
        q=quantities();trials['burst165']={'failing_checks':[k for k,v in q['checks'].items() if not v]}
    finally:BG_CPU=saved[0]
    for name,var,value in [('host_wire65536','BG_WIRE',2048),('pool_background2pow21','POOL_BG',2**21),
        ('memory4504','MEM_CAP',4504),('interconnect23','INTER',F(23)),('passive79','PASSIVE',79)]:
        old_value=globals()[var]
        try:
            globals()[var]=value
            if name=='pool_background2pow21':
                assert value<4*400*(M+6)*RATE+4096
                trials[name]={'failing_checks':['ordinary_checkpoints_exceed_entire_background_rate']}
            else:
                q=quantities()
                trials[name]={'failing_checks':[k for k,v in q['checks'].items() if not v]}
        finally:globals()[var]=old_value
    assert all(t['failing_checks'] for t in trials.values())
    return {'one_coordinate_down_tests':trials,'minimal_only_with_fixed_foreground_shares_and_declared_grids':True,
        'joint_global_optimum_proved':False,'lower_energy_variant_changes_reseed_time':True}


def accounts():
    # Recompute original ten response/effort rows with new site count/wealth.
    # Only this process's copied modules are changed; originals stay untouched.
    oldspares,oldstock=m.SPARES,m.STOCK_EXTRA
    try:
        m.SPARES=PASSIVE;m.STOCK_EXTRA=oldstock+STOCK_ADD
        result=m.full(H,W=42800)
    finally:m.SPARES=oldspares;m.STOCK_EXTRA=oldstock
    assert result is not None and len(result['rows'])==10
    # A subset-moment law permits this union bound. Exact independent binomial
    # tails are not inferred from it. Keep the legacy quorum term as well.
    quorum=10**120*F(comb(H,71))*F(1,500)**71
    rows={}
    for name,row in result['rows'].items():
        a=row['accounts'].copy();a['quorum_liveness']+=quorum
        assert len(a)==21
        rows[name]={'accounts':a,'sum':sum(a.values()),'with_reserve':sum(a.values())+result['eta_cert'],
            'IC_gap_lower':row['IC_gap_lower'],'IC_extraction_gap_lower':row['IC_extraction_gap_lower'],
            'wealth_span':row['wealth_span']}
    worst=max(rows,key=lambda name:rows[name]['with_reserve'])
    assert rows[worst]['with_reserve']<=F(1,10**6)
    assert all(min(row['IC_gap_lower'],row['IC_extraction_gap_lower'])>0 for row in rows.values())
    return {'rows':rows,'worst_row':worst,'physical_quorum_tail_union':quorum,
        'new_total_sites':H+PASSIVE,'legacy_quorum_term_retained':True,
        'sum':rows[worst]['sum'],'with_certificate_reserve':rows[worst]['with_reserve'],
        'headroom':F(1,10**6)-rows[worst]['with_reserve'],
        'independent_binomial_tail_assumed':False}


def calculate():
    q=quantities()
    assert q['all_checks'],q['checks']
    a=accounts()
    capital=BASE['capital'].copy();capital['passive_collectors']+=1024
    capital['JW26_host_upgrade_bundles']=242*512;capital['JW26_pool_fabric_upgrade']=1728
    assert sum(capital.values())==STOCK and capital['other_buffers_keys_cash']==4096
    return {'task1':{'conditional_k':2,'largest_k_for_this_repetition_code':2,
        'physical_realization_supplied':False,'globally_smallest_plant_change_proved':False,
        'plant':{'compute_hosts':H,'passive_sites':PASSIVE,'daily_CPU':128,'memory':MEM_CAP,
            'host_burst_CPU':FG_CPU+BG_CPU,'host_burst_wire':FG_WIRE+BG_WIRE,
            'host_daily_wire':16384,'pool_wire':POOL_BG+POOL_FG,'interconnect':INTER,
            'stock':STOCK,'stock_increase':STOCK_ADD,'new_idle_energy_allowance':IDLE,
            'capital_ledger':capital,
            'new_price_targets':{'host_upgrade_bundle_capital_each':512,
                'extra_passive_capital':1024,'extra_pool_fabric_capital':1728}},
        'resources':q,'all21_accounts':a,'algebra':algebra(),'grid_audit':grid_audit(),
        'lower_energy_variant':lower_energy_variant(),
        'scope':'Conditional construction under CONTRACT.md; priced capacities, not measured implementation.',
        'strict_global_minimum_open':True},'task2_executed':False}


if __name__=='__main__':print(json.dumps(old.encode(calculate()),sort_keys=True,indent=2))
