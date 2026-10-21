"""Exact encoder-only k/cost curves and incremental-update ceilings."""
from pathlib import Path
from fractions import Fraction as F
from math import ceil
from functools import lru_cache
import importlib.util,json,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('jw25_prefix',ROOT/'inputs/jw25/checks/calculate.py')
p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p)
M,N,S,H=1032,400,172,242
WORDS=2**27;PAGE=2048;FC=F(127,10**9);EC=F(1,127)
COPY=F(127,80000);RATE=F(4,3);PERIOD=F(3,4)
BASE=p.BASE;BG_CPU=8;BG_WIRE=2048;POOL_BG=2**21
ACTIVE=F(1,8) # optimistic lag1/4 less final durable1/8


def layout(k):
    d=N-k
    lanes=PAGE*ceil(F(M*WORDS,d*PAGE))
    return d,lanes,F(lanes,WORDS),F(d*lanes,WORDS)


def full(k):
    d,lanes,chunk,primary=layout(k)
    ops=(2*k-1)*(d-1)*lanes
    io=2*(primary+(k-1)*chunk+70*k*chunk)
    cpu=ops*FC+io*COPY
    energy=RATE*(ops*FC*EC+io*(COPY*EC+F(2,10**5)))
    activity=BASE['interconnect_used']+energy
    daily=BASE['compute_host']+RATE*cpu/S
    burst=cpu/(S*ACTIVE)
    pool_payload=N*(primary+(k-1)*chunk)
    held=71*ceil(F(k*chunk,H))
    memory=BASE['memory_host']+2*held*(1+F(128,10**5))+16+2*(primary-M)
    return {'k':k,'dimension':d,'nominal_storage_overhead':F(N,d),
        'field_ops_per_island_checkpoint':ops,'padded_primary_units':primary,
        'parity_units_per_island':k*chunk,'memory_upper':memory,
        'encoder_plus_copy_daily_compute_per_host_mean':RATE*cpu/S,
        'total_daily_compute_per_host_mean':daily,
        'daily_CPU_cap_increase_over128_at_least':max(F(0),daily-128),
        'interconnect_energy_activity':activity,
        'interconnect_allocation_increase_over16':max(F(0),activity-16),
        'background_CPU_rate_for_one_eighth_optimistic_window_mean':burst,
        'background_CPU_rate_increase_over8_at_least':max(F(0),burst-8),
        'pool_background_wire_rate_for_same_window':pool_payload/ACTIVE,
        'extra_pool_wire_rate_to_keep_old_foreground_share':max(F(0),pool_payload/ACTIVE-POOL_BG),
        'extra_flow_if_allocation_is_raised':max(F(0),BASE['spent']+max(F(0),activity-16)-BASE['flow'])}


def mirrors(k):
    # Primary plus k different foreign images: k+1 distinct island holders.
    # Copy/queue shares scale together, preserving foreground152 CPU,
    # foreground63488 wire and foreground pool7*2^21. Keys and repair omitted.
    held=71*ceil(F(M,H));primary=ceil(F(M,S))
    bg_wire=RATE*(held+70*primary+primary)
    bg_cpu=bg_wire*COPY
    io=2*M*71*RATE*k
    activity=BASE['interconnect_used']+io*(COPY*EC+F(2,10**5))
    memory=BASE['memory_host']+2*k*held*(1+F(128,10**5))+16
    return {'k':k,'island_images_per_state':k+1,'field_parity_operations':0,
        'memory_required':memory,'extra_memory_over4096':max(F(0),memory-4096),
        'interconnect_activity':activity,'extra_interconnect_over16':max(F(0),activity-16),
        'extra_daily_inflow_before_keys_and_repair':max(F(0),BASE['spent']+max(F(0),activity-16)-BASE['flow']),
        'total_daily_CPU_mean_or_balanced_target':BASE['compute_host']+k*bg_cpu,
        'extra_daily_CPU_cap_over128':max(F(0),BASE['compute_host']+k*bg_cpu-128),
        'conservative_host_burst_target':152+8*k,'extra_host_burst_over160':8*(k-1),
        'conservative_host_wire_target':63488+2048*k,'extra_host_wire_over65536':2048*(k-1),
        'conservative_pool_wire_target':7*2**21+k*2**21,'extra_pool_wire_over2pow24':(k-1)*2**21,
        'host_daily_wire_target':BASE['network_host']+k*bg_wire,
        'extra_host_daily_wire_over16384':max(F(0),BASE['network_host']+k*bg_wire-16384),
        'keys_recovery_reseeding_and_all21_accounts_priced':False,
        'snapshot_capacity_scaling_not_physical_protocol_proof':True}


def incremental(k,blocks,mode):
    d,lanes,chunk,primary=layout(k)
    assert mode in ['batch','online']
    r=blocks*PAGE
    delta=F(r,WORDS)
    # Batch can coalesce each parity page before one local fanout. Online
    # charges a fanout per applied update, including repeated page updates.
    parity_update=min(chunk,delta) if mode=='batch' else delta
    io=2*(delta+(k-1)*parity_update+70*k*parity_update)
    ops=2*k*r #1 delta XOR +(k-1) multiplies +k parity XORs
    cpu=ops*FC+io*COPY
    activity=BASE['interconnect_used']+RATE*(ops*FC*EC+io*(COPY*EC+F(2,10**5)))
    t=ACTIVE if mode=='batch' else PERIOD
    payload=N*(delta+(k-1)*parity_update)
    checks={'interconnect16':activity<=16,'background_CPU8_aggregate':cpu<=S*BG_CPU*t,
        'pool_background_wire2pow21':payload<=POOL_BG*t,
        'host_background_wire2048_aggregate':io<=S*BG_WIRE*t,
        'daily_CPU128_mean':BASE['compute_host']+RATE*cpu/S<=128}
    return {'k':k,'mode':mode,'charged_4KiB_block_updates':blocks,
        'charged_dirty_fraction':F(r,d*lanes),'per_state_equivalent_changed_KiB':F(r,d*lanes)*256*1024,
        'field_ops_per_checkpoint':ops,'interconnect_activity':activity,
        'total_daily_CPU_mean':BASE['compute_host']+RATE*cpu/S,
        'background_CPU_rate_mean':cpu/(S*t),'pool_payload_per_checkpoint':payload,
        'parity_update_endpoint_units':io,'checks':checks,'aggregate_bounds_pass':all(checks.values()),
        'metadata_keys_privacy_and_recovery_priced':False,
        'final_online_backlog_bound_supplied':False}


def frontier(k,mode):
    d,lanes,_,_=layout(k);lo=0;hi=d*lanes//PAGE
    while lo<hi:
        mid=(lo+hi+1)//2
        if incremental(k,mid,mode)['aggregate_bounds_pass']:lo=mid
        else:hi=mid-1
    at=incremental(k,lo,mode);nxt=incremental(k,lo+1,mode)
    assert at['aggregate_bounds_pass'] and not nxt['aggregate_bounds_pass']
    at['next_block_failures']=[name for name,passed in nxt['checks'].items() if not passed]
    return at


@lru_cache(None)
def inv(a):return p.prior.inv(a)
gf=p.prior.gf


def matrix(k,d=None):
    if d is None:d=400-k
    xs=list(range(k));ys=list(range(k,k+d));x0=xs[0];y0=ys[0]
    # Nonzero row/column scaling of a Cauchy matrix: first row and column1.
    return [[gf(gf(x^y0,x0^y),inv(gf(x0^y0,x^y))) for y in ys] for x in xs]


def encode(a,data):
    out=[];ops=0
    for row in a:
        terms=[]
        for coefficient,value in zip(row,data):
            terms.append(value if coefficient==1 else gf(coefficient,value))
            ops+=coefficient!=1
        acc=terms[0]
        for value in terms[1:]:acc^=value;ops+=1
        out.append(acc)
    return out,ops


def algebra():
    cases=[]
    for k in [2,3,5,10,22,50,92,100]:
        d=400-k;a=matrix(k);old=[(29*j+17)&65535 for j in range(d)]
        previous,ops=encode(a,old)
        assert ops==(2*k-1)*(d-1)
        assert all(row[0]==1 for row in a) and all(x==1 for x in a[0])
        assert all(a[i][j]!=1 for i in range(1,k) for j in range(1,d))
        new=old.copy();columns=[0,1,d//2,d-1]
        for z,j in enumerate(columns):new[j]^=z+1
        incremental_parity=previous.copy();update_ops=0
        for j in columns:
            delta=old[j]^new[j];update_ops+=1
            for i in range(k):
                incremental_parity[i]^=delta if a[i][j]==1 else gf(a[i][j],delta)
                update_ops+=1+(a[i][j]!=1)
        actual,_=encode(a,new)
        assert incremental_parity==actual
        assert update_ops<=2*k*len(columns)
        cases.append({'k':k,'d':d,'full_ops_per_lane':ops,'incremental_changed_symbols':len(columns),
            'incremental_ops':update_ops,'parities_equal_full_reencode':True})
    # Exhaustive1x1 and2x2 minors for a small normalized Cauchy example.
    a=matrix(3,5);minors=0
    from itertools import combinations
    for rows in combinations(range(3),2):
        for cols in combinations(range(5),2):
            i,j=rows;u,v=cols
            assert gf(a[i][u],a[j][v])^gf(a[i][v],a[j][u])
            minors+=1
    return {'full400_symbol_examples':cases,'small_two_by_two_minors':minors,
        'MDS_general_case_uses_Cauchy_determinant_proof':True,
        'production_ciphertext_page_engine_or_benchmark_supplied':False}


def calculate():
    assert mirrors(1)['memory_required']==p.prior.resource(1,True)['memory_per_host_upper']
    assert mirrors(2)['memory_required']>4096 and mirrors(2)['interconnect_activity']>16
    assert mirrors(2)['conservative_host_burst_target']==168
    rows={k:full(k) for k in range(1,101)}
    for k in range(1,100):
        rows[k]['next_k_extra_interconnect']=rows[k+1]['interconnect_energy_activity']-rows[k]['interconnect_energy_activity']
        rows[k]['next_k_extra_daily_CPU_mean']=rows[k+1]['total_daily_compute_per_host_mean']-rows[k]['total_daily_compute_per_host_mean']
    bounds={k:{mode:frontier(k,mode) for mode in ['batch','online']} for k in range(2,101)}
    examples={}
    for k in [2,22,92,100]:
        d,lanes,_,_=layout(k)
        examples[k]={str(rho):{mode:incremental(k,ceil(rho*d*lanes/PAGE),mode) for mode in ['batch','online']}
                     for rho in [F(1,100),F(1,1000),F(1,10000)]}
    return {'scope':'encoder-only arithmetic and necessary aggregate capacity projections; no new joint k',
        'rate_per_date':RATE,'state_bytes':256*2**20,'charged_page_bytes':4096,
        'scalar_GF_compute_charge':FC,'full_code_family':'row/column normalized systematic Cauchy [400,400-k]',
        'full_encode_ops_formula':'(2*k-1)*(d-1)*ceil_page(1032*2^27/d)',
        'delta_ops_upper_per_changed_word': '2*k, including old XOR new',
        'capacity_prices_are_not_global_optima':True,'incremental_full_guarantee_established':False,
        'full_encode_by_k':rows,'replication_curve':{k:mirrors(k) for k in range(1,101)},
        'incremental_dirty_frontiers':bounds,'incremental_examples':examples,
        'algebra_checks':algebra(),
        'k1_attack_scope':'one whole-island erasure per pool/window, including a malicious erasure; two targeted image-island erasures defeat the mirror',
        'global_coalition_fraction_proved':False,
        'unpriced_requirements':['first/full rebuild and reseeding',
            'keys, retained-generation mobile exposure and secure retirement',
            'authenticated roots, delta logs, replay deduplication and packet metadata',
            'C-SEQ metadata/access-pattern concealment',
            'worst-host scheduling and bounded final online backlog',
            'repair/decoding and end-to-end failover',
            'all21 accounts for a new construction']}


if __name__=='__main__':print(json.dumps(p.prior.old.encode(calculate()),sort_keys=True,indent=2))
