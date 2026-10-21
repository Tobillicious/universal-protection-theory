"""Task1: a conditional single-island construction; exact arithmetic throughout."""
from pathlib import Path
from fractions import Fraction as F
from math import ceil
from collections import deque
import json,sys
sys.dont_write_bytecode=True
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'inputs/jw23/checks'))
import jw23 as old
m=old.source
EC=F(1,127);FC=F(127,10**9);COPY=F(127,100000)*F(5,4)
POOL,MINDS,H,SERVING=400,1032,242,172
PERIOD=F(3,4);CP_LAG=F(1,4);RATE=1/PERIOD
GRACE=F(1,400);FG_CPU=152;FG_WIRE=63488;POOL_FG=7*2**21
POLY=0x1100b


def rem(a,b):
    while a and a.bit_length()>=b.bit_length():a^=b<<(a.bit_length()-b.bit_length())
    return a


def gf(a,b):
    out=0
    for _ in range(16):
        if b&1:out^=a
        b>>=1;a<<=1
        if a&65536:a^=POLY
    return out


def inv(a):
    assert a
    result,base,n=1,a,65534
    while n:
        if n&1:result=gf(result,base)
        base=gf(base,base);n//=2
    return result


def coding_checks():
    # Any reducible degree16 binary polynomial has a factor of degree<=8.
    divisors=[p for degree in range(1,9) for p in range(1<<degree,1<<(degree+1))]
    assert all(rem(POLY,p)!=0 for p in divisors)
    pairs=[(1,2),(1,3),(2,3),(399,400),(1,400)]
    for s in [0,1,0xffff,0x1234]:
        for a in [0,1,0xffff,0x6789]:
            for x,y in pairs:
                vx,vy=s^gf(a,x),s^gf(a,y)
                aa=gf(vx^vy,inv(x^y));ss=vx^gf(aa,x)
                assert aa==a and ss==s
    # One observed share is a permutation of all possible coefficients.
    views={0x1234^gf(a,3) for a in range(65536)}
    assert len(views)==65536
    # [2,1] systematic repetition: every one-erasure pattern reconstructs.
    state=bytes(range(256));encoded=[state,state]
    for lost in [0,1]:assert encoded[1-lost]==state
    return {'field_polynomial':POLY,'proper_factor_candidates_tested':len(divisors),
            'full_one_share_coefficient_bijection_size':len(views),
            'two_share_reconstruction_cases':len(pairs)*16,
            'ciphertext_code':'[2,1,2] systematic repetition',
            'one_erasure_patterns_reconstructed':2,'two_erasure_recoverability':False}


def canonical_batch(rows):
    # The attested validator must also check each supplied authority proof. This
    # finite parser checks the structural claims; it does not implement proofs.
    return (len(rows)<=344 and all(len(row)==4 and 0<=row[0]<412800 and
            row[1]>=0 and 0<=row[2]<400 and row[3]>0 for row in rows) and
            all(a[0]<b[0] for a,b in zip(rows,rows[1:])))


def read_assignment(lost,pop=1035):
    """Snapshot cyclic-interval matching; no prediction of future outages."""
    cap=ceil(F(pop,172));q=deque();out={};counts={};max_delay=0
    for tick in range(2*242):
        host=tick%242
        for record in range(host,pop,242):q.append((record,tick))
        if host in lost:continue
        for _ in range(min(cap,len(q))):
            record,start=q.popleft();max_delay=max(max_delay,tick-start)
            if tick>=242:
                assert record not in out
                out[record]=host;counts[host]=counts.get(host,0)+1
    assert len(out)==pop and max(counts.values())<=cap and max_delay<=70
    assert all((host-record%242)%242<=70 for record,host in out.items())
    return max(counts.values())


def resource(k=1,batch=False):
    x=ceil(F(MINDS*k,POOL-k));pop=MINDS+x
    serving=SERVING;primary=ceil(F(pop,serving));copies=3*primary
    jobs=4224*1694;perhost=ceil(F(jobs,serving))
    snapshot=8*241+pop
    move=(2*copies+4)*COPY+F(3*pop,serving)*F(1,10000)
    gateops=ceil(F(4*2**31,serving));gatecpu=gateops*F(1,2**24);gatewire=gateops*F(1,65536)
    cw=(7*4224*80+ceil(F(4224*79,242))*1694)*F(1,10000)
    cpu=10+ceil(F(3648,serving))+perhost*F(1,10000)+snapshot*COPY+move+gatecpu
    wire=ceil(F(79,serving))+snapshot+8+ceil(F(pop,serving))+3+F(2048*(4096+pop),4096)+cw+2*copies+4+64+gatewire
    # One received full-state restore and32 limb reconstructions/primary host.
    restore_count=ceil(F(x,serving))
    route_cpu=16*(4*pop+2*242)*FC
    batch_cpu=x*(16*FC+8*F(1,2**24)) if batch else F(0)
    restore=(primary+restore_count)*COPY+restore_count*160*FC+route_cpu+batch_cpu
    #64 wire units cover one complete pool recovery's control headers for any
    #k<=100; they are not multiplied away or hidden in the state payload.
    transfer=F(2*MINDS*k+64,POOL_FG)+F(1,POOL_FG)
    care=F(1,20)+F(1,100)+(cpu+restore)/FG_CPU+(wire+64+primary+restore_count)/FG_WIRE+F(1,8)+F(1,20)+F(1,20)+F(228,4096)+F(49,256)+GRACE+transfer
    response=m.resources(242)['response_deadline']-F(9*288*400,2**24)+F(9*288*400,POOL_FG)+GRACE+transfer
    phase=F(1,20)+(perhost*F(1,10000)+gatecpu+route_cpu)/FG_CPU+(cw+gatewire+128)/FG_WIRE
    # Each mirror image has71 cyclic physical holders; records per holder bound.
    held=ceil(F(pop,242))*71
    forward_roles=ceil(F(pop,serving))
    bg_wire=RATE*(held+70*forward_roles+primary)
    key_per_checkpoint=32*3*2*FC
    entropy_per_checkpoint=F(1,10000)
    bg_cpu=bg_wire*COPY+primary*RATE*(key_per_checkpoint+entropy_per_checkpoint)
    bg_receive_cpu=RATE*(held+primary)*COPY+primary*RATE*(key_per_checkpoint+entropy_per_checkpoint)
    bg_forward_cpu=RATE*70*forward_roles*COPY
    memory=m.resources(242)['memory_host']+2*held*(1+F(128,10**5))+16
    data_wire=2*pop*71*RATE
    # Both endpoints of data copying plus conservative network charging.
    extra_activity=(data_wire+2*MINDS*k)*(F(5,4)*F(1,10**5)+2*F(1,10**5))+route_cpu*EC
    activity=m.resources(242)['interconnect_used']+extra_activity
    interconnect=max(F(16),activity)
    energy=m.resources(242)['spent']+(interconnect-16)+F(5*x,4*127)+pop*RATE*(key_per_checkpoint+entropy_per_checkpoint)*EC+batch_cpu*EC
    margin=243*F(24,5)-energy
    auth=1496509296+128*4*71*pop*RATE+8*400*32+8*242*x*32+242**2*x+(8*x if batch else 0)
    # Retain all original certificates;32 pool votes+32 roots;two export and
    # two mirror durability roots/date are prepaid even at period5/8 (<2/day).
    cert=4130+64+4+(3 if batch else 3*x)
    pool_header_wire=F(8*400*400*32,65536)+F(4*400*pop,65536)*RATE
    assert pool_header_wire<=4096
    assert F(8*400*400+16*MINDS*100,65536)<=64
    pool_bg_wire=2*400*pop*RATE+4096
    prefetch=F(1,20)+(route_cpu+primary*COPY)/FG_CPU+F(primary,FG_WIRE)
    pre_fabric=F(1,20)+F(1,10)+F(24,144)+F(9,64)
    checks={'care_deadline':care<=F(19,20),'provider_deadline':response<=F(19,20),
        'committee_phase':phase<=F(1,8),'slots':pop<=8*serving,
        'host_daily_compute':cpu+bg_cpu+restore<=128,'host_daily_wire':wire+bg_wire+64+primary+restore_count<=16384,
        'background_CPU_reserve8':bg_cpu<=8,'background_receive_CPU_reserve4':bg_receive_cpu<=4,
        'background_forward_CPU_reserve4':bg_forward_cpu<=4,
        'background_wire_reserve2048':bg_wire<=2048,'memory':memory<=4096,
        'service_auth_reserve':auth<=7*2**28,'certificates':cert<=4224,
        'energy_after78_total_losses':margin>=0,'pool_background_rate':pool_bg_wire<=2**21,
        'ciphertext_prefetch_precedes_provider_fabric':prefetch<=pre_fabric}
    return {'disabled':k,'exiles_at_largest_destination':x,'minds_at_largest_destination':pop,
        'held_mirror_records_per_physical_host_upper':held,'primary_records_per_serving_host':primary,
        'foreground_CPU':cpu,'foreground_wire':wire,'restore_CPU_per_receiving_host':restore,
        'care_deadline':care,'provider_deadline':response,'committee_phase':phase,
        'background_wire_per_host':bg_wire,'background_CPU_per_host':bg_cpu,
        'background_receive_CPU':bg_receive_cpu,'background_forward_CPU':bg_forward_cpu,
        'memory_per_host_upper':memory,'new_interconnect_activity':activity,
        'old_interconnect_allocation':F(16),'new_interconnect_allocation':interconnect,
        'allocation_increase':interconnect-16,'total_energy':energy,'energy_margin':margin,
        'authentication_inventory':auth,'certificate_inventory':cert,
        'pool_background_wire':pool_bg_wire,'checks':checks,'all_resource_checks':all(checks.values())}


def calculate():
    coding=coding_checks();r=resource()
    assert r['all_resource_checks'],r['checks']
    masks=[set((offset+j)%242 for j in range(70)) for offset in range(242)]
    masks += [set((offset+37*j)%242 for j in range(70)) for offset in range(16)]
    masks.append(set())
    assert all(read_assignment(mask)<=7 for mask in masks)
    prior=old.account_data()['source'];rows={}
    for name,row in prior['rows'].items():
        acc=row['accounts'].copy()
        # Retain every old term; add rather than erase the physical quorum tail.
        acc['quorum_liveness']+=10**120*old.bin_tail(242,F(1,500),71)
        assert len(acc)==21
        rows[name]={'accounts':acc,'sum':sum(acc.values()),'with_reserve':sum(acc.values())+prior['eta_cert']}
    worst=max(rows,key=lambda name:rows[name]['with_reserve'])
    assert rows[worst]['with_reserve']<=F(1,10**6)
    # Conservative checkpoint service calculation under the stated calendar.
    checkpoint=(COPY/4+F(1,2**21)+F(1,20)+70*COPY/4+F(1,2048)+
                71*COPY/4+F(1,4096)+F(1,8))
    assert checkpoint<=CP_LAG
    assert PERIOD+CP_LAG==1
    task1={'largest_k_for_this_code_and_contract':1,'unmodified_JW23_contracts_k':0,
        'global_optimum_across_all_codes_claimed':False,
        'material_key_bits':512,'effective_security_required':459,'key_threshold':2,
        'key_islands':3,'key_field':'GF(2^16),32 independent limbs',
        'fresh_key_and_polynomial_period':PERIOD,'ciphertext_checkpoint_export_bound':CP_LAG,
        'checkpoint_service_bound_under_calendar':checkpoint,
        'checkpoint_age_at_cut_required':F(1),'C3_conservative_loss_bound':F(39,20),
        'local_replica_count':71,'local_compute_loss_allowance':70,
        'ordinary_host_whole_key_allowed':False,'whole_key_only_in_attested_execution':True,
        'physical_realization_or_measured_latency_supplied':False,
        'stronger_joint_contracts_required':['freshness under overlapping failures',
            'pool-wide unique execution authority','pool journal completion within1/8',
            'calendar and NIC priority bounds','retained-generation share exposure at most1',
            'the existing common floor jointly covers the extended realization'],
        'coding_checks':coding,'resource_point':r,'all_21_rows':rows,'maximizing_row':worst,
        'snapshot_read_assignment_masks_tested':len(masks),
        'max_complete_image_reads_per_serving_source':7,
        'future_fault_handling_in_joint_read_contract_not_proved_by_snapshot_matching':True,
        'account_sum':rows[worst]['sum'],'sum_with_reserve':rows[worst]['with_reserve'],
        'headroom':F(1,10**6)-rows[worst]['with_reserve'],
        'same_cpu_memory_stock_and_collectors':True,
        'operating_allocation_change_required':r['allocation_increase'],
        'two_island_state_loss_counterexample':True}
    # Task2: three canonical batches replace three certificates per exile.
    # Separate limits are projections; they do not override the ciphertext code.
    slot_limit=max(k for k in range(400) if MINDS+ceil(F(MINDS*k,400-k))<=8*172)
    unbatched=max(k for k in range(400) if 4198+3*ceil(F(MINDS*k,400-k))<=4224)
    batch_per_entry_cpu=16*FC+8*F(1,2**24)
    task2={'canonical_batches_per_destination':3,'fixed_remote_control_certificates':68,
        'inventory_with_batches':4201,'original_only_certificate_k':11,
        'unbatched_k_after_remote_control_is_priced':unbatched,
        'certificate_only_k_with_bounded_batches':slot_limit,'slot_only_k':slot_limit,
        'batch_capacity_entries':344,'batch_fields_per_entry':32,
        'batch_CPU_per_entry_upper':batch_per_entry_cpu,
        'batch_CPU_max_at_slot_bound':344*batch_per_entry_cpu,
        'batch_wire_max_state_units':F(344*32*32,256*2**20),
        'batch_memory_per_host_at_slot_bound':F(344*32,10**5),
        'batch_auth_units_at_slot_bound':8*344,
        'constant_committee_work_requires_attested_validator':True,
        'ordinary_linear_validation_work_limit_k':unbatched,
        'batched_k1_resource_point':resource(1,True),
        'certificate_bound_within_slot_region_removed':True,
        'whole_construction_k_after_batching':1}
    good=[(j,1,j%400,1) for j in range(344)]
    assert canonical_batch(good) and not canonical_batch(good+[good[-1]])
    assert not canonical_batch(good[::-1]) and not canonical_batch([(1,1,0,1),(1,2,1,1)])
    # Task3: exact conservative serialization bound, with no serial audit.
    projection={k:resource(k,True) for k in range(101)}
    timing_k=max(k for k,v in projection.items() if v['care_deadline']<=F(19,20) and v['provider_deadline']<=F(19,20))
    task3={'timing_only_k_with_fixed_service_shares':timing_k,
        'at':{key:projection[timing_k][key] for key in ['care_deadline','provider_deadline']},
        'next':{key:projection[timing_k+1][key] for key in ['care_deadline','provider_deadline']},
        'grace':GRACE,'pool_background_wire_rate':2**21,'pool_foreground_wire_rate':POOL_FG,
        'host_background_CPU':8,'host_foreground_CPU':152,
        'host_background_wire':2048,'host_foreground_wire':63488,
        'serial_audit_phases':0,'guaranteed_joint_k':1,
        'projection_above1_requires_a_different_code_and_key_threshold':True}
    task4={'affordable_code':'systematic[2,1,2] repetition',
        'parity_field_operations':0,'ciphertext_copies_per_codeword':2,
        'new_remote_images_per_checkpoint_per_mind':1,
        'physical_mirror_copies_per_image':71,'checkpoint_period':PERIOD,
        'background_CPU_at_k1':r['background_CPU_per_host'],
        'background_wire_at_k1':r['background_wire_per_host'],
        'full_400over256_fast_encoder_supplied':False,
        'largest_guaranteed_k_for_this_encoder':1}
    task5={'compute_hosts':242,'local_quorum':172,'max_compute_losses':70,
        'max_total_site_losses':78,'journal_completion_contract':F(1,8),
        'first_quorum_loss_count':71,'physical_quorum_horizon_tail':10**120*old.bin_tail(242,F(1,500),71),
        'old_quorum_account_retained_additionally':True,
        'claimed_local_J_LIVE_at78_compute_losses':False}
    return {'task1':task1,'task2':task2,'task3':task3,'task4':task4,'task5':task5,
        'later_tasks_executed':[2,3,4,5],
        'optional_task6_executed':False,
        'scope':'Conditional modest-k construction; no global optimum or hardware realization.'}


if __name__=='__main__':print(json.dumps(old.encode(calculate()),sort_keys=True,indent=2))
