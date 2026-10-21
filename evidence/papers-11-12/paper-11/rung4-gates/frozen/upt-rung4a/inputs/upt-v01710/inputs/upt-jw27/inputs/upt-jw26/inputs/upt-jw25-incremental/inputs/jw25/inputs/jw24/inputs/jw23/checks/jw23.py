"""JW2.3: local arithmetic and countermodels. No network or mutable predecessor.

All decisions use Fractions or outward rational enclosures. The predecessor
is a copied calculation model, not an oracle for missing engineering contracts.
"""
from pathlib import Path
from fractions import Fraction as F
from math import comb, ceil
from functools import lru_cache
from decimal import Decimal, localcontext, ROUND_FLOOR
import sys

sys.dont_write_bytecode = True
if hasattr(sys, 'set_int_max_str_digits'):
    sys.set_int_max_str_digits(0)
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'inputs/jw22/checks'))
import flow as source
from rational_bounds import power, upper

MT, PD = 10**120, 10**120 // 400
P, LIMIT, DEADLINE = F(1, 500), F(1, 10**6), F(19, 20)
POOL, MINDS, HOSTS, SITES, Q, CERTS = 400, 1032, 242, 321, 172, 4224
L, DRIFT, GRACE = F(3, 16), F(1, 1024), F(1, 100)


def dec(x, places=24):
    """Display only: floor, including negative margins. Never a decision input."""
    x = F(x)
    scale = 10**places
    n = x.numerator * scale // x.denominator
    sign = '-' if n < 0 else ''
    n = abs(n)
    return f'{sign}{n // scale}.{n % scale:0{places}d}'


def sci(x, digits=18):
    with localcontext() as ctx:
        ctx.prec = digits
        ctx.rounding = ROUND_FLOOR
        return str(Decimal(F(x).numerator) / Decimal(F(x).denominator))


def encode(x):
    if isinstance(x, F):
        return {'exact': str(x), 'decimal_floor': sci(x)}
    if isinstance(x, dict):
        return {str(k): encode(v) for k, v in x.items()}
    if isinstance(x, (list, tuple)):
        return [encode(v) for v in x]
    return x


@lru_cache(None)
def bin_tail(n, p, first):
    """Exact independent Bernoulli tail. Not inferred from subset moments."""
    if first <= 0:
        return F(1)
    if first > n:
        return F(0)
    if p == 0:
        return F(0)
    if p == 1:
        return F(1)
    term = F(comb(n, first)) * p**first * (1-p)**(n-first)
    result = term
    for j in range(first, n):
        term *= F(n-j, j+1) * p / (1-p)
        result += term
    return result


def kmax(spare, cost=F(1)):
    return max(k for k in range(POOL+1)
               if (POOL-k)*spare >= MINDS*k*cost)


def independent_energy():
    # Rebuild the JW2.2 ledger without calling its energy routine.
    return {
        'provider_inflow': 288*F(94,25), 'interconnect': F(16),
        'cohort_care': F(530,127), 'reserved_berths': F(88,127),
        'stock_command_limiters': F(1032,1000), 'privileges': 288*F(2,100),
        'admin': F(1), 'committee': F(4224*1694,10000*127),
        'mpc_refresh_recovery': F(3648,127),
        'confidential_live_overhead': F(1032,4*127),
        'security_gate_compute': F(512,127),
        'provider_proof_compute': F(288*4,127),
        'security_plant_fixed': F(1), 'passive_collector_control': F(79,127)}


def capacities():
    ledger = independent_energy()
    use = sum(ledger.values())
    f = next(f for f in range(SITES) if MT*bin_tail(SITES,P,f+1) <= F(1,10**8))
    slots = 8*(HOSTS-f)-MINDS
    e = (SITES-f)*F(24,5)-use
    table = {}
    for name, serving in [('rung2_inherited',152),('jw22_F78',164),
                          ('author_F74',168),('journal_Q172',172)]:
        supply = 8*serving
        table[name] = {'serving':serving,'supply':supply,
                       'spare':supply-MINDS,'slot_only_k':kmax(supply-MINDS)}
    inventory = sum(source.resources(HOSTS)['certificate_inventory'].values())
    certificate_k = max(k for k in range(POOL)
                        if inventory+3*ceil(F(MINDS*k,POOL-k)) <= CERTS)
    serial = {}
    for k in [1,11,12,60,85,92,100]:
        exiles = MINDS*k
        destination_max = ceil(F(exiles,POOL-k))
        # Lower cost and an explicit hypothetical normalized transfer charge.
        # Neither supplies a missing remote replica, route or release service.
        wire = 2*exiles
        serial[str(k)] = {
            'exiles':exiles,'largest_destination_exile_load':destination_max,
            'certificate_inventory_with_3_per_exile':inventory+3*destination_max,
            'certificate_ceiling':CERTS,
            'care_only_exile_energy_per_destination':F(destination_max,127),
            'confidential_live_energy_per_destination':F(5*destination_max,4*127),
            'pool_transfer_wire':wire,'pool_transfer_time_at_2p24':F(wire,2**24),
            'care_serial_with_grace_and_transfer':source.resources(HOSTS)['care_deadline']+GRACE+F(wire,2**24),
            'provider_serial_with_grace_and_transfer':source.resources(HOSTS)['response_deadline']+GRACE+F(wire,2**24)}
    return {'independent_ledger':ledger,'use':use,'energy_margin_F78':243*F(24,5)-use,
            'least_F_at_1e8':f,'previous_F_horizon':MT*bin_tail(SITES,P,f),
            'F_horizon':MT*bin_tail(SITES,P,f+1),'slot_spare':slots,
            'slot_k':kmax(slots),'care_only_energy_spare':e,
            'care_only_energy_k':kmax(e,F(1,127)),
            'slot_models':table,'original_certificate_inventory':inventory,
            'certificate_only_k_without_batch_redesign':certificate_k,
            'conditional_transfer_examples':serial,
            'all_requirements_guaranteed_k_in_supplied_model':0,
            'physical_measured_capacity_claim':False}


def mgf_host(q, z):
    # Each host has an independent whole-host shock q. Otherwise seven
    # conditionally independent .1 job errors. Erasure selection may be adaptive.
    return q*z**7+(1-q)*(F(9,10)+z/10)**7


def committee_mixed(q):
    bounds = []
    for threshold in [574,575]:
        lo,hi = F(1),F(16)
        for _ in range(42):
            z = (lo+hi)/2
            g = mgf_host(q,z)
            gp = q*7*z**6+(1-q)*F(7,10)*(F(9,10)+z/10)**6
            if HOSTS*z*gp < threshold*g:
                lo = z
            else:
                hi = z
        z = (lo+hi)/2
        bounds.append(upper(power(mgf_host(q,z),HOSTS)*power(1/z,threshold)))
    return CERTS*MT*sum(bounds)


def grid_bracket(predicate, scale, hi):
    lo = 0
    assert predicate(F(lo,scale)) and not predicate(F(hi,scale))
    while lo+1 < hi:
        mid = (lo+hi)//2
        if predicate(F(mid,scale)):
            lo = mid
        else:
            hi = mid
    return F(lo,scale),F(hi,scale)


@lru_cache(None)
def account_data():
    full = source.full(HOSTS,W=42800)
    rows = full['rows']
    numeric = {}
    for name,row in rows.items():
        a = row['accounts'].copy()
        a['care_mpc_unavailability'] = MT*bin_tail(SITES,P,75)
        a['background_episode_overflow'] = MT*bin_tail(SITES,P,75)
        a['quorum_liveness'] = MT*bin_tail(HOSTS,P,HOSTS-Q+1)
        assert len(a) == 21
        numeric[name] = {'accounts':a,'sum':sum(a.values()),
                         'with_reserve':sum(a.values())+full['eta_cert'],
                         'r':row['r'],'reading':row['reading'],
                         'IC_gap_lower':row['IC_gap_lower'],
                         'IC_extraction_gap_lower':row['IC_extraction_gap_lower']}
    worst = max(numeric,key=lambda name:numeric[name]['sum'])
    a = numeric[worst]['accounts']
    # This is an admissible completion of the supplied local-replica contracts,
    # not an asserted measured probability. The attacker disables that island.
    uncovered = a.copy()
    uncovered['care_mpc_unavailability'] = F(1)
    # No extra account or reassigned 1e-7 allowance conceals this deterministic loss.
    return {'source':full,'numeric_split_rows':numeric,'numeric_split_worst':worst,
            'numeric_split_sum':numeric[worst]['sum'],
            'numeric_split_with_reserve':numeric[worst]['with_reserve'],
            'numeric_split_headroom':LIMIT-numeric[worst]['with_reserve'],
            'counterexample_21_accounts':uncovered,
            'counterexample_21_sum':sum(uncovered.values()),
            'counterexample_with_reserve':sum(uncovered.values())+full['eta_cert'],
            'counterexample_account_excess':sum(uncovered.values())+full['eta_cert']-LIMIT,
            'counterexample_actual_loss_probability':F(1),
            'counterexample_actual_loss_excess':F(1)-LIMIT,
            'additional_unsupported_interfaces':['remote ciphertext availability',
                'remote key release','pool-wide unique authority','pool recovery latency',
                'J-LIVE under 71..78 compute losses','capture-resistant time and retirement']}


def correlation():
    a = account_data()
    src_comm = source.committee(HOSTS)['horizon_union']
    # Committee appears in the 21 terms and the retained separate reserve.
    fixed = a['numeric_split_with_reserve']-2*src_comm
    lo,hi = grid_bracket(lambda q: fixed+2*committee_mixed(q)<=LIMIT,10**9,10**7)
    whole_only = CERTS*MT*(bin_tail(HOSTS,F(1,10),82)+bin_tail(HOSTS,F(1,10),83))
    # A lower bound, not merely a failed upper bound, refutes the .1 host law.
    lower = CERTS*MT*F(comb(HOSTS,82))*F(1,10)**82*F(9,10)**160
    whole_lo,whole_hi=grid_bracket(
        lambda q:fixed+2*CERTS*MT*(bin_tail(HOSTS,q,82)+bin_tail(HOSTS,q,83))<=LIMIT,
        10**9,10**7)
    whole_1e3=CERTS*MT*(bin_tail(HOSTS,F(1,1000),82)+bin_tail(HOSTS,F(1,1000),83))
    # Concrete false-accept subevent:37 host shocks plus315 errors among the
    # remaining1435 jobs gives exactly574 false votes, even with no erasures.
    event=(F(comb(242,37))*F(1,1000)**37*F(999,1000)**205 *
           F(comb(1435,315))*F(1,10)**315*F(9,10)**1120)
    event_union=CERTS*MT*event
    return {'model':'independent host shock q; else seven independent .1 errors; conditional at each admissible history',
            'q_1e3_account':committee_mixed(F(1,1000)),
            'q_1e3_total_with_double_committee':fixed+2*committee_mixed(F(1,1000)),
            'sufficient_moment_grid_lower_q':lo,'next_grid_q_not_enclosed':hi,
            'lower_q_total':fixed+2*committee_mixed(lo),
            'next_q_total':fixed+2*committee_mixed(hi),
            'all_seven_together_q_point1_exact_union':whole_only,
            'all_seven_together_q_point1_union_lower':lower,
            'whole_host_only_q_1e3_exact_account':whole_1e3,
            'whole_host_only_q_1e3_total':fixed+2*whole_1e3,
            'whole_host_only_independent_host_grid_bracket':[whole_lo,whole_hi],
            'mixed_q_1e3_concrete_false_accept_event':event,
            'mixed_q_1e3_event_expected_horizon_count':event_union,
            'mixed_q_1e3_independent_trial_failure_lower':event_union/(1+event_union),
            'mixed_q_1e3_per_job_marginal':F(1009,10000),
            'mixed_q_1e3_pairwise_correlation_within_host':F(9,1009),
            'literal_subset_law_whole_host_only_q_ceiling':F(1,10**7),
            'mixed_model_preserves_literal_point1_subset_law':False,
            'unconditional_correlation_only_bound_suffices':False}


def upper_bin_chernoff(up,down,pu,pd,threshold,upper_tail=False):
    lo,hi = F(1),F(64)
    for _ in range(48):
        z = (lo+hi)/2
        if upper_tail:
            mean_tilt = up*pu*z/(1-pu+pu*z)+down*pd*z/(1-pd+pd*z)
            if mean_tilt < threshold:lo=z
            else:hi=z
        else:
            mean_tilt = up*pu/(z*(1-pu)+pu)+down*pd/(z*(1-pd)+pd)
            if mean_tilt > threshold:lo=z
            else:hi=z
    z=(lo+hi)/2
    if upper_tail:
        return min(F(1),upper(power(1-pu+pu*z,up)*power(1-pd+pd*z,down)*power(1/z,threshold)))
    return min(F(1),upper(power(1-pu+pu/z,up)*power(1-pd+pd/z,down)*power(z,threshold)))


def withdrawal():
    n,w,r=115200,42800,F(43,50)
    x=source.prior.capacity_channels(F(1,2),r,w,'slack')
    d=x['d_cut'];up0=n-d;pc=x['pc'];pu,pd=F(29,30)*pc,pc/2
    mean0=up0*pu+d*pd
    # If X<W, the targeted subtraction is truncated; bound that correction.
    correction=2*w*upper_bin_chernoff(up0,d,pu,pd,w-1)
    adaptive_linear=2*(mean0-w)-n
    # Surviving rescues suffice iff X-W>=n/2 (when X>=W).
    adaptive_success_upper=upper_bin_chernoff(up0,d,pu,pd,w+n//2,True)
    lo,hi=0,w
    target=F(1,10**10)
    while lo+1<hi:
        mid=(lo+hi)//2
        risk=PD*upper_bin_chernoff(up0,d,pu,pd,mid+n//2-1)
        if risk<=target:lo=mid
        else:hi=mid
    return {'r':r,'d_cut':d,'fixed_W':w,'mean_before_withdrawal':mean0,
            'fixed_mean_surplus':x['mean_rescue_surplus'],
            'adaptive_mean_surplus_lower':adaptive_linear,
            'adaptive_mean_surplus_upper':adaptive_linear+correction,
            'adaptive_truncation_correction_upper':correction,
            'adaptive_rescue_success_probability_upper':adaptive_success_upper,
            'adaptive_rescue_failure_probability_lower':1-adaptive_success_upper,
            'adaptive_sufficient_W_at_rescue_only_1e10_pool_horizon':lo,
            'next_W_not_enclosed_at_that_budget':hi,
            'other_rows_holding_and_IC_not_claimed_for_adaptive_cap':True}


def hypergeom(n, first, compromised=92):
    return sum((F(comb(compromised,j)*comb(400-compromised,n-j),comb(400,n))
                for j in range(first,min(n,compromised)+1)
                if 0<=n-j<=400-compromised),F(0))


def isolation():
    table={}
    for n in [32,64,128,184,185,201]:
        v=hypergeom(n,n//2+1)
        table[str(n)]={'strict_majority':v,'tie_or_majority':hypergeom(n,(n+1)//2),
                       'one_audit_per_pool_date_horizon_union':PD*v}
    # Extra audit work: an explicit lower/volume price, with stated route assumptions.
    votes=201*92
    work=F(votes,10000)
    wire=2*votes  # one normalized vote word each way; no state transfer hidden here
    return {'committee_probabilities':table,'chosen_size':201,
            'with_at_most92_bad_votes_adversarial_majority_probability':F(0),
            'minimal_odd_size_against92':185,
            'audit_work_for92_isolations_pool':work,'audit_energy_pool':work/127,
            'audit_wire_pool':wire,'audit_fabric_time_at_2p24':F(wire,2**24),
            'audit_signer_jobs_per_island_ceiling':ceil(F(votes,400)),
            'grace':GRACE,
            'care_with_grace':source.resources(HOSTS)['care_deadline']+GRACE,
            'response_with_grace':source.resources(HOSTS)['response_deadline']+GRACE,
            'maximum_grace_before_other_new_work':DEADLINE-source.resources(HOSTS)['response_deadline'],
            'separate_serial_1over8_audit_response':source.resources(HOSTS)['response_deadline']+GRACE+F(1,8),
            'audit_bad_voter_cap_follows_from_disabled_island_cap':False,
            'punitive_action_before_all_resident_minds_moved':False}


def price_thresholds():
    r=source.resources(HOSTS);c=source.committee(HOSTS)
    jobs=CERTS*c['jobs'];s=164;jhost=ceil(F(jobs,s))
    cc=ceil(F(CERTS*79,242))
    wire_coeff=7*CERTS*80+cc*1694
    cpu_coeff=jhost+F(3*1032,s)
    phase_coeff=F(jhost,160)+F(wire_coeff,65536)
    care_coeff=cpu_coeff/160+F(wire_coeff,65536)
    cost=F(1,10000)
    thresholds={
        'energy':cost+r['energy_margin']/F(jobs,127),
        'host_compute':cost+(128-r['compute_host'])/cpu_coeff,
        'care_deadline':cost+(DEADLINE-r['care_deadline'])/care_coeff,
        'committee_1over8_phase':cost+(F(1,8)-r['committee_phase_bound'])/phase_coeff,
        'daily_network':cost+(16384-r['network_host'])/wire_coeff,
        'host_memory':cost+(4096-r['memory_host'])/jhost,
        'interconnect_reserve':cost+(16-r['interconnect_used'])/(F(3*1032,127)+F(2*jobs*80,10**5))}
    acc=account_data();full=acc['source'];old=full['sum']+full['eta_cert']
    av=full['rows'][full['worst']]['accounts']['care_mpc_unavailability']
    nonfault=old-2*av
    old_lo,old_hi=grid_bracket(lambda p:nonfault+2*MT*source.b.subset(321,p,79)<=LIMIT,10**12,10**10)
    iid_lo,iid_hi=grid_bracket(lambda p:nonfault+2*MT*bin_tail(321,p,79)<=LIMIT,10**12,10**10)
    def new_fits(p):
        src=full['rows'][full['worst']]['accounts']
        fixed=sum(v for k,v in src.items() if k not in ['care_mpc_unavailability','background_episode_overflow','quorum_liveness'])+full['eta_cert']
        return fixed+2*MT*bin_tail(321,p,75)+MT*bin_tail(242,p,71)<=LIMIT
    split_lo,split_hi=grid_bracket(new_fits,10**12,10**10)
    return {'net_flow_per_surviving_site_minimum':sum(independent_energy().values())/243,
            'job_compute_individual_thresholds':thresholds,
            'binding_job_threshold_name':min(thresholds,key=thresholds.get),
            'binding_job_compute_threshold':min(thresholds.values()),
            'old_F78_subset_fault_rate_bracket':[old_lo,old_hi],
            'old_F78_independent_fault_rate_bracket':[iid_lo,iid_hi],
            'split_F74_Q172_independent_fault_rate_bracket':[split_lo,split_hi],
            'fault_brackets_are_accounting_rules_not_measured_laws':True}


def economics():
    full=account_data()['source'];b=source.b
    gp=max(row['wealth_span'] for row in full['rows'].values())-F(26,25)/(1-F(19,20))
    rows={}
    for name,row in full['rows'].items():
        r,reading=row['r'],row['reading'];pc,cost,_=b.scenario(r,reading)
        v=b.role_values(pc=pc,cost=cost)
        cap=source.prior.capacity_channels(F(1,2),r,42800,reading)
        vstar=cost/(F(1,100)*F(1,2)*(pc-b.PC['D']))
        rows[name]={'nominal_role_value_initial':v[(0,0)],
                    'nominal_role_value_privileges_excluded_up':v[(3,0)],
                    'nominal_role_value_privileges_excluded_down':v[(3,1)],
                    'same_physical_up_excluded_ratio':v[(3,0)]/v[(0,0)],
                    'nominal_qualification_value_gap_up':v[(0,0)]-v[(3,0)],
                    'clean_dividend_valuation_threshold':vstar,
                    'holding_channel_upper_everyone_attacks':cap['holding'],
                    'expected_physical_pool_gain_upper':cap['holding']*gp,
                    'expected_discretionary_gain_upper':cap['holding']*10,
                    'belief_break_even_using_nominal_gap_and_pool':(v[(0,0)]-v[(3,0)])/(gp+v[(0,0)]-v[(3,0)])}
    alpha_old=3*2**20*F(13,40)**287
    return {'rows':rows,'physical_pool_reachable_inventory_upper':gp,
            'enduring_discretionary_gain_upper':F(10),
            'old_local_futility_majorant_JW12_JW16':alpha_old,
            'old_local_role_value_quoted_by_author':F(13593141,80000000),
            'old_privilege_only_chain_ratio':F(171,181),
            'max_clean_valuation_threshold':max(x['clean_dividend_valuation_threshold'] for x in rows.values()),
            'claim_27point9_percent_population_mass_recomputed':False,
            'common_bad_world_prior_ceiling_at_rhoL_point15':F(1,10**7)/F(17,20),
            'all_beliefs_strict_dominance_from_nonzero_common_floor':False,
            'nominal_values_include_no_operating_exit_hazard':True}


def drs():
    minds=400*1032;state=256*2**20;sharebytes=32
    encoded=F(400,256)*state*minds
    keys=sharebytes*400*minds
    # Normalized JW2.2 state-copy cost; no byte-to-wire conversion is asserted.
    writes=F(400,256)*minds
    # Straight Horner sharing of 16 GF(2^16) elements, k=256.
    field_ops=16*400*255*minds
    # A multiply and add are two operations at the inherited field-op price.
    key_ops=2*field_ops
    key_compute=key_ops*F(127,10**9)
    # One explicit (deliberately straightforward) systematic parity encoder:
    #144 parity chunks,256 input chunks,GF(2^16),256MiB state.
    words_per_chunk=state//(256*2)
    parity_ops=2*144*256*words_per_chunk*minds
    parity_compute=parity_ops*F(127,10**9)
    return {'pool_minds':minds,'field_nonzero_points_GF2p8':255,
            'field_nonzero_points_GF2p16':65535,'share_bytes_per_key':sharebytes,
            'encoded_state_bytes_pool':encoded,'encoded_state_TiB_pool':encoded/2**40,
            'encoded_state_bytes_per_island':encoded/400,
            'key_share_bytes_pool':keys,'key_share_bytes_per_island':F(keys,400),
            'intact_islands_after92':308,'reconstruction_threshold':256,
            'availability_headroom_islands':52,'secrecy_threshold':255,
            'normalized_state_writes_pool':writes,
            'normalized_state_copy_energy_pool':writes*F(5,4)*F(1,10**5),
            'dealer_field_multiply_add_steps_pool':field_ops,
            'dealer_compute_pool_at_inherited_field_price':field_ops*F(127,10**9),
            'dealer_compute_per_island':F(field_ops,400)*F(127,10**9),
            'dealer_energy_per_island':F(field_ops,400*10**9),
            'key_dealer_separate_multiply_and_add_ops_pool':key_ops,
            'key_dealer_compute_per_island_two_ops_per_step':key_compute/400,
            'key_dealer_energy_per_island_two_ops_per_step':key_compute/(400*127),
            'key_dealer_energy_512_bit_per_island_two_ops_per_step':2*key_compute/(400*127),
            'systematic_parity_encoder_example_field_ops_pool':parity_ops,
            'systematic_parity_encoder_example_compute_per_island':parity_compute/400,
            'systematic_parity_encoder_example_energy_per_island':parity_compute/(400*127),
            'example_encoder_exceeds_global3648_compute':parity_compute/400>3648,
            'faster_encoder_cost_lower_bound_claimed':False,
            'pool_512_bit_key_share_bytes':2*keys,
            'online_256_bit_experiment_union_if_key_guess_is_admitted':F(MT*2**31,2**256),
            'mobile_capture_share_accumulation_without_refresh_is_prevented':False,
            'full_threshold_crypto_price_supplied':False,
            'Horner_steps_are_atomic_field_operation_price':False,
            'whole_key_outside_attested_execution_allowed':False}


def safety_witnesses():
    # Quorum intersection is universal by the elementary cardinality inequality.
    intersection=2*172-242
    short={loss:242-loss>=172 for loss in range(79)}
    # A pre-cut grant signed at t0 remains usable until expiry; waiting is required.
    pending_issue=F(1,32);expiry=pending_issue+L
    early_activation=L+2*DRIFT
    old_at_early=early_activation<expiry
    clock_pause_real_reboot=F(1)
    paused_clock=F(1,16)
    rollback_retired_before=True
    rollback_retired_after=False
    # Full-island ciphertext placement is allowed by the supplied local snapshots.
    copies={'home-island/host'+str(i) for i in range(242)}
    survivors={c for c in copies if not c.startswith('home-island/')}
    # Separate local journals can both assign the same identity/epoch without a
    # global authority. Distinct island quorums have empty global intersection.
    islandA={(0,i) for i in range(172)};islandB={(1,i) for i in range(172)}
    hardware = capture_model()
    return {'journal_quorum':172,'minimum_two_quorum_intersection':intersection,
            'largest_unavailable_compute_roles_for_quorum':70,
            'J_LIVE_at78_compute_losses_with_quorum172_possible':short[78],
            'J_LIVE_71_to78_compute_loss_counterexamples':list(range(71,79)),
            'JW22_completion_bound_proved_by_quorum_intersection':False,
            'required_completion_bound':F(1,8),
            'lease_period':L,'clock_absolute_error':DRIFT,
            'maximum_charged_expiry_wait':L+4*DRIFT,
            'renewal_spacing_plus_completion_plus_2drift':F(1,32)+F(1,8)+2*DRIFT,
            'pending_old_grant_expiry':expiry,'unsafe_early_activation':early_activation,
            'pending_old_grant_still_executes_at_early_activation':old_at_early,
            'paused_clock_reboot_after_real_expiry_executes_if_time_not_trusted':clock_pause_real_reboot>L and paused_clock<L,
            'rollback_restores_authority_if_retirement_not_monotone':rollback_retired_before and not rollback_retired_after,
            'attested_keys_extractable_under_good_capture_contract':False,
            'remote_ciphertexts_after_allowed_one_island_loss':len(survivors),
            'same_epoch_can_run_in_two_local_journals_without_global_assignment':len(islandA)==172 and len(islandB)==172 and not islandA&islandB,
            'copy_loss_event_probability_in_allowed_countermodel':F(1),
            'checkpoint_interval_required':F(1),
            'C3_loss_bound_if_actual_recovery_meets_deadline':1+DEADLINE,
            'C3_Delta1point95_established_for_missing_replica_recovery':False,
            'C4_restores_without_any_surviving_pattern':False,
            'conditional_capture_state_machine':hardware}


def capture_model():
    """A specified trusted machine, not an implementation of tamper resistance.

    Its durable authority state is deliberately outside the rollback snapshot.
    Real, bounded-error time is a physical input; an off machine is not exempt.
    """
    class TrustedMachine:
        def __init__(self,offset):
            self.offset=offset;self.expiry=L;self.retired=False;self.real=F(0)
            self.powered=True;self.epoch=7
        def snapshot_untrusted(self):
            return {'expiry':self.expiry,'retired':self.retired,'epoch':self.epoch,'time':self.real}
        def execute(self,t):
            assert t>=self.real
            self.real=t
            if t+self.offset>=self.expiry:self.retired=True
            return self.powered and not self.retired
        def reboot_rollback(self,t,snapshot):
            # Snapshot cannot write trusted time, expiry, epoch, or retirement.
            self.powered=True
            return self.execute(t)
    tests=0
    for offset in [-DRIFT,DRIFT]:
        h=TrustedMachine(offset);snapshot=h.snapshot_untrusted()
        assert h.execute(F(1,32))
        h.powered=False
        assert not h.execute(F(1,16))
        assert not h.reboot_rollback(F(1),snapshot)
        assert not h.reboot_rollback(F(2),snapshot)
        assert h.retired and h.epoch==7
        tests+=5
    cases=[]
    for old_offset in [-DRIFT,DRIFT]:
        for new_offset in [-DRIFT,DRIFT]:
            # Include a final pending promise before source fencing.
            promised=F(1,32)+old_offset+L
            new_real=promised+2*DRIFT-new_offset
            old_running=new_real+old_offset<promised
            assert not old_running
            cases.append({'old_offset':old_offset,'new_offset':new_offset,
                          'maximum_promised_expiry':promised,'new_activation':new_real,
                          'old_can_execute_at_new_activation':old_running})
    signers=set(range(172));signature_tokens={(i,7,'ownerA') for i in signers}
    def genuine_certificate(ids,epoch,owner):
        return (len(set(ids))>=172 and all(0<=i<242 and (i,epoch,owner) in signature_tokens for i in ids))
    assert genuine_certificate(signers,7,'ownerA')
    assert not genuine_certificate(range(171),7,'ownerA')
    assert not genuine_certificate(signers,8,'ownerB')
    assert not genuine_certificate(range(70,242),7,'ownerA')
    return {'specified_capture_checks':tests,'clock_extreme_no_fork_cases':cases,
            'valid_172_certificate_accepted':True,'171_certificate_accepted':False,
            'invented_epoch_or_stolen_name_certificate_accepted':False,
            'model_assumes_physical_inputs_and_unextractable_signature_tokens':True}


def calculate():
    cap=capacities();a=account_data();safety=safety_witnesses()
    # Internal arithmetic consistency is separate from the failed theorem claims.
    assert cap['use']==source.resources(HOSTS)['spent']
    assert cap['energy_margin_F78']==F(297444,79375)
    assert (cap['least_F_at_1e8'],cap['slot_spare'],cap['slot_k'],cap['care_only_energy_k'])==(74,312,92,295)
    assert cap['certificate_only_k_without_batch_redesign']==11
    assert not safety['J_LIVE_at78_compute_losses_with_quorum172_possible']
    assert a['numeric_split_with_reserve']<LIMIT
    assert a['counterexample_actual_loss_probability']>LIMIT
    return {'capacities':cap,'accounts':a,'safety':safety,
            'host_error_correlation':correlation(),'withdrawal':withdrawal(),
            'isolation':isolation(),'price_thresholds':price_thresholds(),
            'economics':economics(),'optional_DRS':drs()}
