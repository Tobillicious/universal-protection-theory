"""JW2.7 continuation. Ordered tasks3–7, exact arithmetic throughout."""
from pathlib import Path
from fractions import Fraction as F
from math import comb,ceil
from functools import lru_cache
import hashlib,json,sys
sys.dont_write_bytecode=True
import calculate as c
j=c.j
ROOT=Path(__file__).resolve().parents[1]
WORLD=10**20
PHI=F(23,5000)
STAGES=(3,8,16,32,56,100,200,400)
STAGE_EVENTS=10**12
STAGE_BUDGET=F(1,10**8*len(STAGES))
COSMIC_POOL_EVENTS=10**120//400


@lru_cache(None)
def hypergeom_weights(n,phi):
    """Exact random-pool law for a fixed disabled global set, no binomial shortcut."""
    disabled=phi*WORLD;assert disabled.denominator==1
    disabled=int(disabled);other=WORLD-disabled
    a=comb(other,n);weights=[a]
    for i in range(n):
        numerator=a*(disabled-i)*(n-i)
        denominator=(i+1)*(other-n+i+1)
        assert numerator%denominator==0
        a=numerator//denominator;weights.append(a)
    denominator=comb(WORLD,n)
    assert sum(weights)==denominator
    return tuple(weights),denominator


def hypergeom_tail(n,k,phi):
    weights,den=hypergeom_weights(n,phi)
    return F(sum(weights[k+1:]),den)


def target_k(n,phi,events,budget):
    weights,den=hypergeom_weights(n,phi)
    remaining=den
    for k,a in enumerate(weights):
        remaining-=a
        if events*remaining*budget.denominator<=budget.numerator*den:
            return k,F(remaining,den)
    raise AssertionError('no k')


def cost_screen(k):
    """Known marginal mirror/key costs, plus existing encoder-only alternative.

    Prices are inherited targets. No new capital price or full high-k plant
    is invented. Reseed, journals and timing must still be jointly repriced.
    """
    q=c.baseline()[1];x=ceil(F(1032*k,400-k))
    keywork=F(k+1,20000)+32*(2*k+1)*2*k*j.FC
    extra_memory=2*303*(k-2)*(1+F(128,10**5))+2*303*2*(k-2)*F(130,10**5)
    extra_io=2*(k-2)*1032*72*j.RATE
    extra_activity=extra_io*(j.COPY*j.EC+F(2,10**5))
    response_fixed=q['provider_deadline']-F(9*288*400+2*1032*2+65,j.POOL_FG)
    pool_lower=F(9*288*400+2*1032*k+65)/(F(19,20)-response_fixed)
    inc=j.inc;saved=inc.RATE
    try:
        inc.RATE=j.RATE
        d,lanes,_,_=inc.layout(k)
        blocks=ceil(F(d*lanes,10000*inc.PAGE))
        incremental=inc.incremental(k,blocks,'online')
    finally:inc.RATE=saved
    return {'k':k,'exiles_per_survivor':x,'post_outage_population':1032+x,
        'eight_slot_screen':1032+x<=172*8,'pool_quorum_safety_min':(400+k)//2+1,
        'pool_quorum_live_max':400-k,'key_shareholders':2*k+1,'key_threshold':k+1,
        'mirror_memory_added_to_JW26_before_population_and_control':extra_memory,
        'mirror_memory_lower_projection':q['memory_required']+extra_memory,
        'additional_mirror_interconnect_activity':extra_activity,
        'interconnect_activity_lower_projection':q['interconnect_activity']+extra_activity,
        'fresh_key_sharing_compute_per_state_checkpoint':keywork,
        'old_key_sharing_compute_per_state_checkpoint':q['key_compute_per_checkpoint_per_state'],
        'same_pool_foreground_provider_projection':q['provider_deadline']+F(2*1032*(k-2),j.POOL_FG),
        'pool_foreground_rate_lower_for_provider_only':pool_lower,
        'incremental_0p01percent_encoder_projection':incremental,
        'incremental_requires_changed_key_and_ciphertext_update_contract':True,
        'old_fresh_DEK_full_ciphertext_compatible_with_sparse_updates':False,
        'capital_price_and_full_joint_plant_supplied':False,
        'omissions':['population and primary memory/copy increase','repair and source scheduling',
                     'share availability/confidentiality under new exposure cap','authority and deadline service',
                     'higher capacity capital/idle prices','all21 joint recomputation']}


def tasks345():
    targets=[]
    for speed in (F(1),F(1,2),F(1,4),F(1,8)):
        k,p=target_k(400,PHI*speed,COSMIC_POOL_EVENTS,F(1,10**8))
        targets.append({'repair_window_ratio':speed,'assumed_disabled_fraction':PHI*speed,
                        'minimal_k_for_illustrative_coalition_account':k,
                        'horizon_union':COSMIC_POOL_EVENTS*p,
                        'next_smaller_fails':COSMIC_POOL_EVENTS*hypergeom_tail(400,k-1,PHI*speed)>F(1,10**8),
                        'cost_screen':cost_screen(k)})
    reference_union=targets[0]['horizon_union']
    stage_target=reference_union/(2*len(STAGES))
    strict_targets=[]
    for speed in (F(1),F(1,2),F(1,4),F(1,8)):
        k,p=target_k(400,PHI*speed,COSMIC_POOL_EVENTS,reference_union/2)
        strict_targets.append({'repair_window_ratio':speed,'k':k,
            'union':COSMIC_POOL_EVENTS*p,'strict_reference_target':reference_union/2,
            'cost_screen':cost_screen(k)})
    stages=[]
    for n in STAGES:
        variants=[]
        for speed in (F(1),F(1,2),F(1,4),F(1,8)):
            k,p=target_k(n,PHI*speed,STAGE_EVENTS,stage_target)
            slots=n//4
            variants.append({'window_ratio':speed,'k_required':k,
                'stage_exposure_pool_dates':STAGE_EVENTS,'stage_risk_budget':STAGE_BUDGET,
                'strict_reference_stage_union_target':stage_target,
                'stage_union':STAGE_EVENTS*p,'slot_only_max_k':slots,
                'slots_fit':k<=slots,'quorum_possible':3*k<n,
                'key_locations_fit':2*k+1<=n,
                'post_outage_exiles':ceil(F(1032*k,n-k)) if k<n else None,
                'full_plant_fits':False})
        current=hypergeom_tail(n,2,PHI)
        stages.append({'islands':n,'variants':variants,
            'current_k2_illustrative_union_at1e12_pool_dates':STAGE_EVENTS*current,
            'max_pool_dates_at_k2_to_beat_reference':stage_target/current if current else None,
            'max_pool_dates_at_k2_for_this_stage_budget':STAGE_BUDGET/current if current else None})
    seeds=[]
    for speed in (F(1),F(1,2),F(1,4),F(1,8)):
        for n in range(3,401):
            k=n//4
            if STAGE_EVENTS*hypergeom_tail(n,k,PHI*speed)<=stage_target:
                seeds.append({'window_ratio':speed,'smallest_slot_screen_seed':n,'k':k,
                              'full_construction_proved':False});break
    return {'task3':{'status':'target undetermined; illustrative exact target/cost screens completed',
        'actual_twilight_target_supplied':False,'illustrative_reference':{
            'global_disabled_fraction':PHI,'global_islands':WORLD,'full_pool_dates':COSMIC_POOL_EVENTS,
            'coalition_account_budget':F(1,10**8),'this_is_the_supplied_twilight_reference':False},
        'window_scaling_is_additional_capability_premise':True,'illustrative_targets':targets,
        'surrogate_coalition_reference_union':reference_union,
        'strict_surrogate_reference_targets':strict_targets,
        'fully_priced_target_plant_found':False},
        'task4':{'status':'conditional exposure schedule computed; founding construction not established',
            'stage_rows':stages,'sum_stage_budgets':STAGE_BUDGET*len(STAGES),
            'smallest_seeds_for_slot_screen_in_this_scenario':seeds,
            'aggregate_scenario_union_upper':stage_target*len(STAGES),
            'coalition_reference_union':reference_union,
            'aggregate_founder_coalition_bound_strictly_below_reference':True,
            'this_compares_only_coalition_risk_not_all_resource_margins':True,
            'required_growth_rule':'E_i*H(n_i,k_i,phi_i)<=reference_union/(2*number_of_stages); retain old counted losses until restored',
            'repair_speed_rule':'phi_i<=lambda_island*(D_i+R_i) requires a bounded coordinated-start capability law',
            'commission_before_exposure':'do not enter a long-exposure stage until its k and repair services are commissioned',
            'capital_and_small_pool_service_supplied':False,
            'pre_activation_universal_protection_claimed':False},
        'task5':{'rung4_established':False,'first_uncovered_phase':'founding',
            'smallest_closing_change_identified':False,
            'gap':['numeric twilight margin and common comparison metric',
                   'actual phase exposure and budget partition',
                   'bounded coordinated outage/repair temporal law',
                   'priced high-k founding and maturity constructions',
                   'privacy and service realization within the declared common warranty'],
            'equality_MN2_counterexample_retained':True,
            'minimum_safe_conclusion':'JW2.6 remains a conditional full-pool k2 point; no all-phase strict margin theorem follows'}}


def keyed_cycles(rank,strict=True):
    """Deterministic SHAKE fixture for finite combinatorial tests, NOT459-bit proof.

    Specification: a512-bit keyed stream with the inherited459-effective-bit
    conditional secrecy contract. Test fixture uses a fixed disclosed seed.
    """
    seed=b'JW27 disclosed test seed; not a secret deployment key'+rank.to_bytes(2,'big')
    stream=hashlib.shake_256(seed).digest(64*400*2)
    pos=0;cycles=[]
    for parity in ((0,1) if strict else (None,)):
        a=list(range(parity,400,2)) if parity is not None else list(range(400))
        for m in range(len(a),1,-1):
            for attempt in range(64):
                x=int.from_bytes(stream[pos:pos+2],'big');pos+=2
                if x<(65536//m)*m:break
            else:raise AssertionError('fixture sampling cap')
            ix=x%m;a[m-1],a[ix]=a[ix],a[m-1]
        cycles.append(a)
    return cycles


def scatter_check():
    counts=[0]*400;keycounts=[0]*400;checks=0
    # Per-rank permutations imply each island receives exactly2 foreign images
    # and5 key shares at that rank, regardless of the secret cycle realization.
    samples=[]
    for r in range(1032):
        incoming=[[] for _ in range(400)]
        kin=[0]*400
        for cycle in keyed_cycles(r):
            size=len(cycle)
            for t,h in enumerate(cycle):
                mirrors=[cycle[(t+i)%size] for i in (1,2)]
                shares=[cycle[(t+i)%size] for i in range(5)]
                assert len({h,*mirrors})==3 and len(set(shares))==5
                assert all((z-h)%400 not in (1,399) for z in mirrors)
                for dest in mirrors:incoming[dest].append(h)
                for dest in shares:kin[dest]+=1
                checks+=1
        assert all(len(v)==2 for v in incoming) and all(v==5 for v in kin)
        if r<16:samples.append(incoming)
        for h in range(400):counts[h]+=len(incoming[h]);keycounts[h]+=kin[h]
    assert min(counts)==max(counts)==2064 and min(keycounts)==max(keycounts)==5160
    # At most two selected records at any rank on any source island, so its
    # demand is a subproblem of JW2.6's complete two-records/rank matcher.
    masks=[set((start+i)%242 for i in range(70)) for start in range(242)]
    masks += [set((37*i+j)%242 for i in range(70)) for j in range(16)]+[set()]
    assert all(j.read_assignment(mask)<=12 for mask in masks)
    # Check actual scattered source calendars on several lost-island supports.
    for a,b in [(0,1),(0,2),(0,200),(123,321),(398,399)]:
        exported=[0]*400
        for incoming in samples:
            for dest,origins in enumerate(incoming):
                assert sum(h in (a,b) for h in origins)<=2
                exported[dest]+=sum(h in (a,b) for h in origins)
        survivors=[h for h in range(400) if h not in (a,b)]
        loads=[0]*400
        for i in range(2064):loads[survivors[i%398]]+=1
        assert max(loads)<=6
    holders=j.holder_counts(2);keys=j.holder_counts(5)
    return {'identities_checked':checks,'strict_no_numeric_neighbor_mirrors':True,
        'records_per_island':2064,'key_shares_per_island':5160,
        'maximum_local_image_records_per_host':max(holders),
        'maximum_local_key_records_per_host':max(keys),
        'local_erasure_masks_checked':len(masks),'source_reads_per_live_host':12,
        'dispatch_exiles_per_survivor':6,'all_masks_Hall_argument':'demand is a subset of the original two-records-per-rank problem',
        'calendar_argument':'same rank phases and at most two image/five key arrivals per rank; original burst bound dominates',
        'SHAKE_fixture_is_459bit_security_realization':False}


def task6():
    q=c.baseline()[1]
    proof=scatter_check()
    # Cache the four foreign successors directly; home is implicit. Indexing
    # by public(home,rank) avoids reading sigma at a secret-dependent index.
    # Two immutable copies;16 sixteen-bit labels per256-bit priced field.
    table_fields=4*400*1032//16
    table_memory=2*table_fields*F(1,10**5)
    share_memory=2*130*F(1,10**5)
    cache_memory=table_memory+share_memory+F(128,10**5)
    share_transfers=5*72+3
    share_auth=ceil(4*130*share_transfers*j.RATE)
    # Beyond normal CPs reserve60k authorized lookups/island/date:30,720
    # full-image repair endpoints,20k urgent endpoints/control and9280 margin.
    # Token admission precedes cache access; failed partial attempts consume it.
    extra_lookup_cap=60000
    lookups=2*7*72*1032*j.RATE+extra_lookup_cap
    lookup_compute=lookups*16*j.FC
    assert lookup_compute<4
    refresh_compute=(F(1,10000)+640*j.FC+160*j.FC)*j.RATE
    refresh_wire=2*share_transfers*F(130,8388608)*j.RATE
    extra_interconnect=refresh_wire*(j.COPY*j.EC+F(2,10**5))
    new_energy=q['energy_margin']-(4+refresh_compute)*j.EC
    # Conservative added lookup work per host on a checkpoint/recovery path.
    lag_add=(4+142+150+1)*16*j.FC/7
    care_add=F(20000)*16*j.FC/j.FG_CPU
    # Static table cache is restored only at returned hosts, not rewritten each CP.
    table_payload=F(table_fields,8388608)
    repair_wire_add=2*2*2*242*table_payload+128
    repair_auth_add=2*242*4*table_fields
    cache_validation_total=2*242*table_fields*8*j.FC
    spare_control=4-lookup_compute-refresh_compute
    cache_validation_rate=F(1)
    assert spare_control>=cache_validation_rate
    cache_compute_days=ceil(cache_validation_total/cache_validation_rate)+2
    auth_days=ceil(F(407912448+repair_auth_add,2**24))+2
    repair_days=ceil((q['global_repair_endpoint_units']+repair_wire_add)/30720)+2
    # A bounded uniform sampler is only the idealized setup contract. The real
    # keyed stream must satisfy C-SEQ; SHAKE's test fixture does not prove it.
    draws=1032*2*199;trials=64
    sampler_fail=F(draws)*F(199,65536)**trials
    horizon_sampler=10**120*sampler_fail
    init_blocks=ceil(F(draws*trials,32))
    init_compute=F(init_blocks,10000)+draws*trials*16*j.FC+F(1,20000)+4*400*1032*16*j.FC
    init_endpoint_wire=4*400*242*table_payload+2*share_transfers*F(130,8388608)
    init_energy=init_compute*j.EC+init_endpoint_wire*(j.COPY*j.EC+F(2,10**5))
    # Existing128-field records already bind identity, placement and generation.
    # Reuse that declared schema; do not silently add a field to every transfer.
    auth=q['authentication_inventory']+share_auth+8*400*32
    memory=q['memory_required']+cache_memory
    setup_memory=memory+F(2*400*1032,16)*F(1,10**5)
    activity=q['interconnect_activity']+extra_interconnect
    daily_cpu=q['daily_CPU']+(4+refresh_compute)/172+2*j.COPY
    daily_wire=q['daily_wire']+2
    background_cpu=q['background_CPU']+768*j.COPY+F(4,172)+(4+refresh_compute)/172+2*j.COPY
    background_wire=q['background_wire']+768+2
    pool_background=q['pool_background_wire_with_full_global_reseed_batch']+repair_wire_add+800
    checks={'memory':memory<=4512,'setup_memory':setup_memory<=4512,'auth':auth<=7*2**28,'energy':new_energy>0,
        'interconnect':activity<=j.INTER,'certificates':q['certificate_inventory']+1<=4224,
        'checkpoint_lag':q['checkpoint_bound']+lag_add<=F(1,4),
        'care':q['care_deadline']+care_add<=F(19,20),
        'provider':q['provider_deadline']+care_add<=F(19,20),
        'reseed':repair_days<=64,'returned_auth':auth_days<=64,
        'returned_cache_compute':cache_compute_days<=64,
        'daily_CPU':daily_cpu<=128,'daily_wire':daily_wire<=16384,
        'background_CPU':background_cpu<=14,'background_wire':background_wire<=3072,
        'pool_background':pool_background<=2**22,
        'additional_lookup_compute_within4':lookup_compute<=4,
        'sampler_horizon_charge_below1e_26':horizon_sampler<F(1,10**26)}
    assert all(checks.values()),checks
    return {'status':'conditional balanced scattered construction and key/cache price targets; routing secrecy realization remains open',
        'placement':'one independently keyed uniform200-cycle per parity/rank; mirrors are next two cycle members; shares next five including home',
        'strict_nonadjacent_definition':'exclude numeric h-1,h+1 modulo400; no geographic distance claim',
        'full400_uniform_option':'one keyed400-cycle per rank; same load bounds, but numeric-neighbor coincidence is allowed',
        'proof_checks':proof,
        'blind_home_plus_two_loss_strict_variant':F(1,comb(199,2)),
        'blind_home_plus_two_loss_full400_variant':F(1,comb(399,2)),
        'blindness_is_conditional_on_no_placement_or_traffic_leakage':True,
        'placement_key_bits':512,'placement_key_threshold':[3,5],
        'stable_key_fresh_degree2_coefficients_each_epoch':True,
        'share_observation_cap_per_generation_including_staging':2,
        'whole_key_only_in_authorized_attested_setup_refresh_service':True,
        'cache_fields_per_host_one_copy':table_fields,'memory_added':cache_memory,
        'cache_lookup_index':'public logical(home,rank); four destination values read at fixed offsets',
        'memory_total':memory,'setup_memory_upper':setup_memory,'additional_share_auth_per_date':share_auth,
        'authentication_total':auth,'lookup_compute_reserved_per_island_date':4,
        'lookup_compute_required':lookup_compute,'key_refresh_compute_per_pool_date':refresh_compute,
        'extra_authorized_lookup_cap_per_island_date':extra_lookup_cap,
        'extra_lookup_partitions':{'repair':30720,'urgent_and_control':20000,'additional_margin':9280},
        'lookup_token_admission_precedes_cache_access':True,
        'additional_interconnect_activity':extra_interconnect,'interconnect_total':activity,
        'energy_margin_after_key_and_lookup':new_energy,
        'care_projected':q['care_deadline']+care_add,'provider_projected':q['provider_deadline']+care_add,
        'checkpoint_projected':q['checkpoint_bound']+lag_add,
        'reseed_dates_with_cache_restore':repair_days,'return_auth_dates_with_cache_restore':auth_days,
        'cache_validation_compute_total_per_returned_island':cache_validation_total,
        'cache_validation_reserved_compute_per_island_date':cache_validation_rate,
        'cache_validation_completion_dates':cache_compute_days,
        'daily_CPU_total':daily_cpu,'daily_wire_total':daily_wire,
        'background_CPU_total':background_cpu,'background_wire_total':background_wire,
        'pool_background_wire_total':pool_background,
        'extra_capital_within_existing_memory_capacity_target':0,
        'setup_PRF512_block_compute_price_target':F(1,10000),
        'setup_bounded_compute_per_pool':init_compute,'setup_max512bit_blocks':init_blocks,
        'setup_one_time_energy_per_pool':init_energy,
        'setup_energy_funding_is_additional_commissioning_obligation':True,
        'ideal_sampler_abort_per_setup':sampler_fail,'horizon_sampler_abort_charge':horizon_sampler,
        'sampler_charge_account':'crypto_protocol_512; no new free allowance',
        'checks':checks,'all_capacity_screens_pass':all(checks.values()),
        'all21_total_if_extended_joint_security_contract_holds':c.baseline()[0]['with_certificate_reserve']+horizon_sampler,
        'required_interfaces':['existing128-field placement/generation binding supports immutable table commitments',
            'cache lookup within16 field-operation equivalents per endpoint',
            'additional4 compute fits remaining host shares with checkpoint priority',
            '60k additional lookup tokens include partial/retried reseed attempts; urgent tokens have priority',
            'immutable cache validation within8 field-operation equivalents per field',
            'sealed caches and keyed stream meet459-effective-bit uniform conditional secrecy',
            'traffic/recipient privacy prevents adaptive placement discovery',
            'refresh erasure prevents mixing observations across generations'],
        'measured_PRF_or_anonymous_routing_realization_supplied':False,
        'live_migration_from_running_adjacent_layout_priced':False,
        'unconditional_secret_placement_guarantee':False}


def tail_numerator(n,k):
    if k<=0:return 10**n
    if k>n:return 0
    term=1;total=1
    for e in range(n,k,-1):
        num=term*e*9;den=n-e+1
        assert num%den==0
        term=num//den;total+=term
    return total


@lru_cache(None)
def shock_weights():
    out=[]
    for a in range(243):
        n=7*(242-a)
        t=tail_numerator(n,574-7*a)+tail_numerator(n,575-7*a)
        out.append(comb(242,a)*t*10**(7*a))
    return tuple(out)


def exact_committee(q):
    """Exact total-error count tail; still a union upper bound for the protocol."""
    r,s=q.numerator,q.denominator;t=s-r
    weights=shock_weights();v=weights[-1];tpow=1
    for a in range(241,-1,-1):
        tpow*=t;v=v*r+weights[a]*tpow
    return F(4224*10**120*v,s**242*10**1694)


def legacy_quorum(q):
    # If the same shock reaches a one-job-per-host legacy predicate, the hosts
    # remain independent, but each marginal is .1+.9q rather than .1.
    return 10**120*c.subset(242,194,F(1,10)+F(9,10)*q)


def task7():
    a,_=c.baseline()
    oldcommittee=j.m.committee(242)['horizon_union']
    fixed=a['with_certificate_reserve']-2*oldcommittee
    assert a['rows'][a['worst_row']]['accounts']['quorum_liveness']-a['physical_quorum_tail_union']==legacy_quorum(F(0))
    target=F(21,10**8)
    def adjustment(q):return legacy_quorum(q)-legacy_quorum(F(0))
    def total(q):return fixed+2*exact_committee(q)+adjustment(q)
    scale=10**12;lo,hi=0,10**9
    assert total(F(lo,scale))<target<total(F(hi,scale))
    while hi-lo>1:
        mid=(lo+hi)//2
        if total(F(mid,scale))<=target:lo=mid
        else:hi=mid
    qlo,qhi=F(lo,scale),F(hi,scale)
    # Retain the historical rational Chernoff calculation for direct comparison.
    mlo,mhi=0,10**6
    while mhi-mlo>1:
        mid=(mlo+mhi)//2
        if fixed+2*j.old.committee_mixed(F(mid,10**9))+adjustment(F(mid,10**9))<=target:mlo=mid
        else:mhi=mid
    points={str(q):{'committee_account':exact_committee(q),'total_with_double_committee':total(q),
                    'moment_upper_account':j.old.committee_mixed(q)}
            for q in [F(0),qlo,qhi,F(16,10**5),F(1,1000)]}
    assert total(qlo)<=target<total(qhi)
    assert exact_committee(F(0))<=oldcommittee
    assert all(v['committee_account']<=v['moment_upper_account'] for v in points.values())
    rows={}
    for name,row in a['rows'].items():
        acc=row['accounts'].copy();acc['committee_good_editions']=exact_committee(qlo)
        acc['quorum_liveness']+=adjustment(qlo)
        reserve=a['with_certificate_reserve']-a['sum']-oldcommittee+exact_committee(qlo)
        rows[name]={'accounts':acc,'reserve':reserve,'with_reserve':sum(acc.values())+reserve}
    worst=max(rows,key=lambda name:rows[name]['with_reserve'])
    assert rows[worst]['with_reserve']==total(qlo)
    # Algebraic independent check at small host count by direct convolution.
    fixtures=[]
    for q in [F(0),F(1,1000),F(1,10)]:
        coeff=[(1-q)*F(comb(7,e)*9**(7-e),10**7)+(q if e==7 else 0) for e in range(8)]
        poly=[F(1)]
        for _ in range(3):
            out=[F(0)]*(len(poly)+7)
            for a0,x in enumerate(poly):
                for b0,y in enumerate(coeff):out[a0+b0]+=x*y
            poly=out
        direct=sum(poly[9:])
        mixed=sum(F(comb(3,a0))*q**a0*(1-q)**(3-a0)*F(tail_numerator(7*(3-a0),9-7*a0),10**(7*(3-a0))) for a0 in range(4))
        assert direct==mixed and sum(poly)==1;fixtures.append({'q':q,'tail9':direct})
    return {'status':'largest grid-certified q for the exact total-error-tail committee ledger',
        'model':'242 independent host shocks; a shocked host makes all7 jobs wrong; otherwise seven independent .1 job errors, conditional at each admissible history',
        'target_total':target,'safe_q':qlo,'next_grid_q_exceeds_budget':qhi,'grid_width':qhi-qlo,
        'safe_total':total(qlo),'next_total':total(qhi),
        'historical_moment_bound_safe_q':F(mlo,10**9),'historical_moment_bound_next_q':F(mhi,10**9),
        'historical_moment_bound_safe_total':fixed+2*j.old.committee_mixed(F(mlo,10**9))+adjustment(F(mlo,10**9)),
        'points':points,'all10_rows_at_safe_q':rows,'worst_row':worst,
        'within_host_job_marginal_at_safe_q':F(1,10)+F(9,10)*qlo,
        'literal_point1_job_subset_law_retained':False,
        'committee_entry_and_certificate_reserve_both_replaced':True,
        'legacy_single_host_predicate_also_recomputed':True,
        'legacy_quorum_at_safe_q':legacy_quorum(qlo),
        'other19_accounts_and_noncommittee_reserve_retained':True,
        'small_host_direct_convolution_checks':fixtures,
        'shock_weights_sha256':hashlib.sha256(json.dumps([str(w) for w in shock_weights()]).encode()).hexdigest(),
        'actual_protocol_failure_probability_equal_to_this_union_bound':False,
        'physical_halt_or_all_other_host_computation_shocks_modeled':False,
        'largest_over_all_protocols_claimed':False}


def calculate():
    result=tasks345()  # explicitly preserve requested order
    result['task6']=task6()
    result['task7']=task7()
    result['executed_task_order']=[3,4,5,6,7]
    result['rung4_established']=False
    return result


if __name__=='__main__':print(json.dumps(j.old.encode(calculate()),sort_keys=True,indent=2))
