"""JW2.5 task-1 prefix: exact scalar-price bounds, not a physical no-go."""
from pathlib import Path
from fractions import Fraction as F
from math import ceil
from itertools import combinations
from functools import lru_cache
import json,sys,importlib.util
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('jw24_calculate',ROOT/'inputs/jw24/checks/calculate.py')
prior=importlib.util.module_from_spec(spec)
spec.loader.exec_module(prior)

M,N,H,S=1032,400,242,172
WORDS=2**27 # 256 MiB / two bytes per GF(2^16) symbol
RATE=F(4,3)
FC=F(127,10**9); EC=F(1,127); COPY=F(127,80000)
LAG=F(1,4); DURABLE=F(1,8); BG=8
BASE=prior.m.resources(242)


def floor_row(k):
    d=N-k
    # Optimistic real-valued stripe count, ignoring all padding, IO and all
    # parity outputs except one. A binary fan-in scalar linear circuit for a
    # parity depending on d inputs needs at least d-1 gates per symbol lane.
    ops=M*F(WORDS,d)*(d-1)*RATE
    charge=ops*FC*EC
    allocation=BASE['interconnect_used']+charge
    return {'k':k,'dimension':d,'nominal_storage_overhead':F(N,d),
            'field_operations_per_island_date_lower':ops,
            'encoder_energy_charge_lower':charge,
            'interconnect_allocation_lower':allocation,
            'interconnect_cap_passes_even_optimistically':allocation<=16,
            'extra_flow_needed_even_after_unused_interconnect_lower':
                max(F(0),BASE['spent']+max(F(0),allocation-16)-BASE['flow']),
            'single_checkpoint_time_if_all172_hosts_give_full160_CPU_lower':
                (ops/RATE)*FC/(172*160)}


def two_parity_metrics():
    d=398
    lanes=ceil(F(M*WORDS,d))
    # P=sum x_i, Q=sum a_i*x_i, a_i=1..398. The a_0=1 multiply
    # is omitted: 2(d-1) additions and d-1 multiplications per lane.
    operations=3*(d-1)*lanes
    daily_ops=operations*RATE
    chunk=F(lanes,WORDS)
    primary=d*chunk
    parity=2*chunk
    # 400 cyclic stripes: each island contributes d chunks, coordinates one
    # stripe, and holds two parity chunks. Gather every source once, send Q,
    # then fan out the two stored parities to70 additional local holders.
    io=RATE*(2*primary+2*chunk+2*70*parity)
    io_charge=io*(COPY*EC+F(2,10**5))
    encoder_charge=daily_ops*FC*EC
    activity=BASE['interconnect_used']+io_charge+encoder_charge
    minimum_alloc=max(F(16),activity)
    # Necessary ceilings, not sufficient performance contracts. They omit
    # keys, routing, recovery, headers, queueing and extra latency.
    ceilings={
        'interconnect16':(16-BASE['interconnect_used']-io_charge)/(daily_ops*EC),
        'daily128_after_old_host_work':
            (S*(128-BASE['compute_host'])-io*COPY)/daily_ops,
        'background8_daily':(S*BG-io*COPY)/daily_ops,
        'checkpoint_with_background8_and_free_IO_before_durable_phase':
            S*BG*(LAG-DURABLE)/operations,
        'checkpoint_even_with_all160_CPU_and_free_IO_before_durable_phase':
            S*160*(LAG-DURABLE)/operations}
    ceiling=min(ceilings.values())
    # Whole-unit packing is conservative. The old primary snapshot memory
    # already contains two generations. Add only parity, not a second full
    # codeword, and reserve16 units for streaming buffers/metadata.
    held=71*ceil(parity/H)
    memory=BASE['memory_host']+2*held*(1+F(128,10**5))+16+2*(primary-M)
    return {'code':'systematic [400,398,3] two-parity MDS over GF(2^16)',
        'supported_island_erasures':2,'symbol_lanes_per_cyclic_stripe':lanes,
        'operations_per_island_checkpoint':operations,'operations_per_island_date':daily_ops,
        'padded_primary_state_units':primary,'parity_state_units_per_island':parity,
        'data_IO_endpoint_units_per_date':io,'data_IO_interconnect_charge':io_charge,
        'encoder_energy_charge':encoder_charge,'interconnect_activity':activity,
        'interconnect16_passes':activity<=16,
        'energy_if_interconnect_allocation_is_raised':BASE['spent']+minimum_alloc-16,
        'additional_flow_required_after_allocation_raise':max(F(0),BASE['spent']+minimum_alloc-16-BASE['flow']),
        'mean_extra_daily_CPU_per_surviving_host':(daily_ops*FC+io*COPY)/S,
        'old_plus_mean_daily_CPU':BASE['compute_host']+(daily_ops*FC+io*COPY)/S,
        'daily128_passes_even_on_mean':BASE['compute_host']+(daily_ops*FC+io*COPY)/S<=128,
        'checkpoint_encode_time_with_reserved8_CPU_free_IO':operations*FC/(S*BG),
        'checkpoint_encode_time_with_all160_CPU_free_IO':operations*FC/(S*160),
        'two_generation_parity_memory_upper':memory,'memory4096_passes':memory<=4096,
        'bulk_GF_price_necessary_ceilings':ceilings,
        'most_restrictive_optimistic_bulk_GF_price_ceiling':ceiling,
        'inherited_to_necessary_price_ratio':FC/ceiling,
        'sufficient_plant_change_demonstrated':False,
        'recovery_decoder_cost_or_timing_supplied':False}


@lru_cache(None)
def inverse(a):return prior.inv(a)


def encode(data):
    p=q=0
    for i,x in enumerate(data):
        p^=x;q^=prior.gf(i+1,x)
    return p,q


def kernel_three():
    data=[0]*398
    a,b,c=1,2,3
    data[:3]=[b^c,a^c,a^b]
    return data


def algebra_checks():
    # Independently check the inherited field modulus by exhaustive possible
    # proper factors of degree<=8, sufficient for a degree16 polynomial.
    factors=[p for deg in range(1,9) for p in range(1<<deg,1<<(deg+1))]
    assert all(prior.rem(prior.POLY,p) for p in factors)
    d=398;data=[(137*i+11)&65535 for i in range(d)]
    p,q=encode(data);weighted=[prior.gf(i+1,x) for i,x in enumerate(data)];cases=0
    # Every two-erasure support, including data/parity and parity/parity.
    # Sum only surviving data. The determinant proof in MATHEMATICS.md covers
    # every possible message; these tests exercise every erased support.
    for i,j in combinations(range(400),2):
        kp=kq=0
        for z,(v,w) in enumerate(zip(data,weighted)):
            if z!=i and z!=j:kp^=v;kq^=w
        if j<d:
            a,b=i+1,j+1
            s=p^kp;t=q^kq
            y=prior.gf(t^prior.gf(a,s),inverse(a^b));x=s^y
            assert (x,y)==(data[i],data[j])
        elif i<d:
            if j==d: # P is absent, Q alone determines the missing symbol.
                t=q^kq;x=prior.gf(t,inverse(i+1))
            else:x=p^kp
            assert x==data[i]
        else:assert (p,q)==encode(data)
        cases+=1
    kernel=kernel_three()
    assert any(kernel) and encode(kernel)==(0,0)
    assert cases==79800
    return {'field_polynomial':prior.POLY,'proper_factor_candidates':len(factors),
            'two_erasure_supports_checked':cases,'determinants_all_nonzero':True,
            'all_messages_covered_by_algebraic_argument':True,
            'three_data_erasure_ambiguity_constructed':True,
            'production_full_256MiB_encoder_benchmark_supplied':False}


def calculate():
    rows=[floor_row(k) for k in range(2,101)]
    assert all(not r['interconnect_cap_passes_even_optimistically'] for r in rows)
    dual=two_parity_metrics()
    assert dual['memory4096_passes']
    assert not dual['interconnect16_passes'] and not dual['daily128_passes_even_on_mean']
    carried=prior.resource(1,True)
    frozen=json.loads((ROOT/'inputs/jw24/RESULTS.json').read_text())
    assert prior.old.encode(carried)==frozen['task2']['batched_k1_resource_point']
    assert carried['all_resource_checks']
    return {'status':'PARTIAL: task1 arithmetic and cost bounds banked; affordable spread encoder unresolved',
        'tasks_executed_in_order':[1],'task1_complete':False,'tasks2_to4_executed':False,
        'largest_replayed_conditional_joint_k':1,'new_k_above1_demonstrated':False,
        'global_optimum_over_all_encoders_claimed':False,
        'inherited_state_bytes_bound':256*2**20,'inherited_scalar_GF_charge':FC,
        'scalar_price_scope':'coordinate-wise scalar linear MDS circuits, binary fan-in, worst-case fresh full states',
        'not_a_lower_bound_on_physical_cost_or_unpriced_SIMD_XOR':True,
        'scalar_MDS_priced_floor_k2_through100':rows,
        'two_parity_construction':dual,'algebra_checks':algebra_checks(),
        'replayed_JW24_batched_k1_resource_point':carried,
        'JW24_21_accounts_carried_not_recomputed_for_a_new_code':True,
        'gaps':['justified faster bulk operation price or another fully priced code',
                'matching key sharing/refresh (task2)',
                'MDS repair traffic, decoder and end-to-end schedule (task3)',
                'joint new-code realization and all21 accounts (task4)'],
        'smallest_sufficient_plant_change_found':False}


if __name__=='__main__':
    print(json.dumps(prior.old.encode(calculate()),sort_keys=True,indent=2))
