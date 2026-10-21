"""JW2.7 ordered prefix: current margins, missing phase inputs, repair sensitivity.

All decisions use exact Fractions. Temporal scaling is an explicitly NEW model,
never inferred from the inherited date-union fault premise.
"""
from pathlib import Path
from fractions import Fraction as F
from math import ceil, comb
from functools import lru_cache
import importlib.util
import json
import sys

sys.dont_write_bytecode = True
if hasattr(sys, 'set_int_max_str_digits'):
    sys.set_int_max_str_digits(0)
ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('jw26_frozen', ROOT / 'inputs/upt-jw26/checks/calculate.py')
j = importlib.util.module_from_spec(spec)
spec.loader.exec_module(j)
P0 = F(1, 500)
EVENTS = 10**120
ETA = F(1, 10**6)
GRID = 10**15


@lru_cache(None)
def baseline():
    a = j.accounts()
    q = j.quantities()
    assert q['all_checks']
    return a, q


def subset(n, k, p):
    assert 0 <= p <= 1
    return min(F(1), F(comb(n, k)) * p**k)


def physical(p, windows=1):
    """Only the four p-dependent entries in JW2.6, with their multiplicities.

    An indexed complete cover of windows with this subset law is required if
    windows>1. Neither independence of windows nor a new date law is inferred.
    """
    assert windows >= 1
    return EVENTS * windows * (2 * subset(322, 79, p) +
                               subset(242, 71, p) + subset(242, 110, p))


def risk_at(p, windows=1):
    a, _ = baseline()
    return a['with_certificate_reserve'] - physical(P0) + physical(p, windows)


def boundary(windows=1, target=ETA):
    """Adjacent grid values certify the boundary to absolute width 1e-15."""
    assert risk_at(F(0), windows) < target < risk_at(F(1), windows)
    lo, hi = 0, GRID
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if risk_at(F(mid, GRID), windows) <= target:
            lo = mid
        else:
            hi = mid
    low, high = F(lo, GRID), F(hi, GRID)
    assert risk_at(low, windows) <= target < risk_at(high, windows)
    return {'lower_safe': low, 'upper_fails': high, 'width': high-low,
            'absolute_headroom_over_p0': low-P0,
            'relative_headroom_over_p0': (low-P0)/P0,
            'budget': target, 'windows_per_date': windows}


def margins():
    a, q = baseline()
    raw = {
        'energy': (q['energy_use'], q['energy_flow']),
        'memory': (q['memory_required'], F(j.MEM_CAP)),
        'interconnect': (q['interconnect_activity'], j.INTER),
        'care_time': (q['care_deadline'], F(19,20)),
        'provider_time': (q['provider_deadline'], F(19,20)),
        'checkpoint_lag': (q['checkpoint_bound'], F(1,4)),
        'authentication': (F(q['authentication_inventory']), F(7*2**28)),
        'certificates': (F(q['certificate_inventory']), F(4224)),
        'daily_CPU': (q['daily_CPU'], F(128)),
        'daily_host_wire': (q['daily_wire'], F(16384)),
        'state_age': (j.PERIOD+q['checkpoint_bound'], F(1)),
        'all21_with_reserve': (a['with_certificate_reserve'], ETA),
    }
    out = {k: {'use': v, 'limit': cap, 'absolute_headroom': cap-v,
               'normalized_headroom': (cap-v)/cap} for k, (v,cap) in raw.items()}
    assert all(x['absolute_headroom'] > 0 for x in out.values())
    out['smallest_normalized_resource_headroom'] = min(
        (k for k in raw if k!='all21_with_reserve'),
        key=lambda k: out[k]['normalized_headroom'])
    out['k'] = {'tolerance': 2, 'declared_unavailable_cap': 2,
                'integer_headroom_above_declared_cap': 0,
                'third_relevant_loss_can_destroy_all_copies': True}
    out['fault_rate_boundary'] = boundary()
    out['fault_rate_boundary_at_2p1e_7_total'] = boundary(target=F(21,10**8))
    return out


def founding_screen():
    """Necessary screens, NOT a smaller-pool construction or growth schedule."""
    out = []
    for n in (3, 5, 7, 8, 56, 346, 400):
        k = 2
        exiles = ceil(F(1032*k, n-k))
        # Honest intersection q+q-n>k, availability q<=n-k.
        qmin = (n+k)//2+1
        qlive = n-k
        out.append({'islands': n, 'k': k, 'post_outage_exiles_per_survivor': exiles,
                    'post_outage_population': 1032+exiles,
                    'five_distinct_key_islands_possible': n>=5,
                    'quorum_safety_min': qmin, 'quorum_liveness_max': qlive,
                    'quorum_interval_nonempty': qmin<=qlive,
                    'eight_slots_on_172_hosts_fit': 1032+exiles<=8*172,
                    'JW26_six_exile_envelope_fits': exiles<=6,
                    'full_smaller_pool_construction_supplied': False})
    assert all(not x['JW26_six_exile_envelope_fits'] for x in out if x['islands']<346)
    assert next(x for x in out if x['islands']==346)['JW26_six_exile_envelope_fits']
    return {'screens': out, 'minimum_islands_for_same_six_exile_bound': 346,
            'minimum_islands_for_eight_slot_screen_only': 8,
            'minimum_islands_for_quorum_screen_only': 7,
            'all_screens_are_necessary_not_sufficient': True}


def phase_audit():
    a, _ = baseline()
    # A constant full-pool design is a comparison, not a founding schedule.
    phases = [
        {'phase':'founding', 'interval':'[0,t_F)',
         'current_point_applicability':'only fully commissioned400-island pools; seed not instantiated',
         'binding_constraint':'small-pool authority/post-outage plant unbuilt; necessary screens below'},
        {'phase':'growth', 'interval':'[t_F,t_M)',
         'current_point_applicability':'commission complete pools before care; expansion/transfer costs absent',
         'binding_constraint':'unknown during commissioning; energy for a commissioned full pool'},
        {'phase':'maturity', 'interval':'[t_M,t_T)',
         'current_point_applicability':'JW2.6 conditional full-pool point',
         'binding_constraint':'energy by normalized resource headroom; k exactly at assumed cap'},
        {'phase':'twilight', 'interval':'[t_T,T_end]',
         'current_point_applicability':'no priced fading-capacity/population/threat trajectory supplied',
         'binding_constraint':'undetermined; MN2 alone supplies no strict numerical margin'},
    ]
    for p in phases:
        p.update({'endpoints_supplied':False, 'island_date_exposure':None,
                  'assigned_nonfloor_budget':None, 'actual_phase_margin':None,
                  'inherited_k':2, 'inherited_p':P0})
    assert a['with_certificate_reserve'] - physical(P0) > 2*F(1,10**7)
    return {'status':'PARTIAL: current point audited; requested four-phase numerical ranking underdetermined',
            'phase_definitions':phases, 'current_full_pool_margins':margins(),
            'founding_necessary_screens':founding_screen(),
            'nonfloor_and_nonreserve_budget':ETA-2*F(1,10**7),
            'current_nonfloor_and_nonreserve_use':a['with_certificate_reserve']-2*F(1,10**7),
            'uniform_budget_bookkeeping_only': {
                'common_floor_per_island_date':F(1,10**7)/EVENTS,
                'certificate_reserve_per_island_date':F(1,10**7)/EVENTS,
                'residual_budget_per_island_date':(ETA-2*F(1,10**7))/EVENTS,
                'phase_formula':'multiply by E_phase only after an exhaustive exposure partition and uniform conditional per-event bounds are justified',
                'correlated_common_failure_hazard_made_uniform':False,
            },
            'missing_inputs':['phase endpoints and population/pool trajectories',
                'numeric twilight threat/capacity/reference margin',
                'per-phase complete-window fault law and outage duration',
                'phase risk shares and exposure cover for all21 accounts',
                'founding/expansion capital and commissioned-service contracts'],
            'narrowest_phase_identifiable':False,
            'first_uncovered_phase':'founding',
            'homogeneous_full_pool_comparison':'identical pre-twilight margins; strict separation does not follow',
            'rung4_established':False}


def window_sensitivity():
    """Additional complete-window law p_w=p_ref*(w+d)/(1+d).

    w,d normalized by an explicitly chosen reference window. An additional
    start-intensity/subset law lambda<=p_ref/(1+d), bounded residence d, and
    an exhaustive cover are required. An observed upper bound at w=1 alone
    cannot be inverted to bound lambda. This is not P-FAULT itself.
    """
    rows = []
    for w in (F(1), F(1,2), F(1,4), F(1,8)):
        count = ceil(1/w)
        pb = boundary(windows=count)
        for d in (F(0), F(1,16), F(1,4), F(1)):
            scale = (w+d)/(1+d)
            pw = P0*scale
            rows.append({'window_ratio':w, 'outage_duration_ratio':d,
                         'windows_per_date_upper':count, 'scaled_window_p':pw,
                         'per_window_79_site_bound':subset(322,79,pw),
                         'per_window_71_compute_bound':subset(242,71,pw),
                         'physical_account_total':physical(pw,count),
                         'all21_plus_reserve_under_new_law':risk_at(pw,count),
                         'reference_p_boundary_lower':pb['lower_safe']/scale,
                         'reference_p_boundary_upper':pb['upper_fails']/scale,
                         'scaled_window_p_boundary_lower':pb['lower_safe'],
                         'scale':scale})
    assert physical(P0/2,2) < physical(P0)
    return {'new_law_not_inherited':True, 'rows':rows,
            'zero_duration_halving_per_window_reduction_79':2**79,
            'zero_duration_halving_per_window_reduction_71':2**71,
            'zero_duration_halving_after_double_window_count_79':2**78,
            'zero_duration_halving_after_double_window_count_71':2**70,
            'single_window_counterexample':{
                'law':'at the audited pre-window history, a fresh independent per-site fault of probability .002 occurs in the intersection of both nested windows',
                'satisfies_conditional_subset_bound_at_compared_pre_window_history':True,
                'known_failures_reused_as_fresh_trials_at_later_histories':False,
                'short_window_unavailability':P0,
                'halved_window_unavailability':P0,
                'event_timing_concentrated_inside_both_windows':True,
                'outage_can_be_shorter_than_both_windows':True,
                'risk_reduction_from_shorter_window_alone':1},
            'illustrative_reference_window_in_dates':F(1),
            'this_reference_window_is_derived_from_JW26':False,
            'local_date_union_and_64_date_reseed_identified':False}


def reseed_requirements():
    """Necessary priced throughput/energy screens; no new plant is certified.

    Keep JW2.6's deliberately conservative global endpoint serial-progress
    bound, two startup dates, urgent reservations, price and packet size.
    """
    _,q = baseline()
    total = q['global_repair_endpoint_units']
    store_auth = 4*128*2*(1032*242+2*1032*72)
    packet_energy = j.COPY*j.EC+F(2,10**5)
    q0 = j.RESEED_ENDPOINT_QUOTA
    rows=[]
    for days in (64,32,16,8,4,2,1):
        if days<=2:
            rows.append({'completion_dates':days,'fixed_two_date_startup_model_feasible':False,
                         'fully_priced_plant_supplied':False})
            continue
        # Urgent traffic consumes the same bucket; retained progress bound must
        # additionally be realized under all its charged partial retries.
        quota=max(ceil(total/(days-2)),q['urgent_recovery_endpoint_bound'])
        auth=max(ceil(F(store_auth,days-2)),q['urgent_recovery_auth_bound'])
        if days==64:
            quota=q0;auth=q['daily_repair_auth_quota']
        da=quota-q0
        energy_delta=da*packet_energy
        activity=q['interconnect_activity']+energy_delta
        allocation=F(ceil(4*activity),4)
        allocation_delta=max(F(0),allocation-j.INTER)
        # Conservative service lower bound after6-unit urgent metadata/control
        # share: max at least average endpoints across172 serving hosts.
        host_wire_lower=F(quota,172)
        transfer_auth_delta=max(0,auth-q['daily_repair_auth_quota'])
        batch=6+ceil(F(quota,2*242))
        batch_delta=max(0,batch-q['canonical_batch_entries_max'])
        auth_inventory=q['authentication_inventory']+transfer_auth_delta+8*batch_delta
        rows.append({'completion_dates':days,'fixed_two_date_startup_model_feasible':True,
            'minimum_endpoint_quota_for_this_progress_bound':quota,
            'minimum_repair_auth_quota':auth,
            'achieved_endpoint_progress_dates':ceil(total/quota)+2,
            'achieved_returned_store_auth_dates':ceil(F(store_auth,auth))+2,
            'endpoint_quota_increase':da,'incremental_local_interconnect_activity_energy':energy_delta,
            'interconnect_activity_with_quota':activity,
            'quarter_grid_interconnect_allocation':allocation,
            'allocation_increase':allocation_delta,
            'energy_margin_before_new_flow_or_idle_cost':q['energy_margin']-allocation_delta,
            'daily_endpoint_work_per_live_host_average_lower':host_wire_lower,
            'repair_endpoint_CPU_per_live_host_average_lower':host_wire_lower*j.COPY,
            'canonical_batch_entries':batch,'existing344_entry_batch_fits':batch<=344,
            'auth_inventory_lower':auth_inventory,
            'existing_auth_reserve_fits_lower_bound':auth_inventory<=7*2**28,
            'post_outage_population':1038,
            'post_outage_slots_per_live_host':7,
            'outage_duration_premise':'physical islands stably return; wall time is physical outage D plus progress dates',
            'fully_priced_plant_supplied':False,
            'unpriced_or_unproved':['per-host burst/retry calendar at new quota','additional idle power/capital',
                                  'new flow-site, certificate, key and routing costs if energy negative']})
    return {'rows':rows,'existing_plant_completion_after_stable_return':64,
            'parallel_returned_store_volume_screen':{
                'returned_store_data_endpoints_both_ends':796704,
                'returned_store_wire_with_header_and_control':F(796704)*(1+F(1,65536))+128,
                'dates_at_existing_endpoint_quota':ceil((F(796704)*(1+F(1,65536))+128)/q0)+2,
                'auth_dates_at_existing_quota':q['repair_auth_completion_dates'],
                'whole_parallel_rebuild_completion_proved':False,
                'gap':'source/target maximum physical loads, overlapping MOVE/checkpoints and bounded retries need a simultaneous progress proof',
            },
            'outage_duration_upper_bound_supplied':False,
            'halving_reseed_halves_unavailability_window':False,
            'global_minimum_plant_price_proved':False}


def urgent_recovery_requirements():
    _,q=baseline()
    # The unchanged explicit serial terms in care: detection, release stages,
    # composed journal, collection, fencing and grace. CPU/NIC/fabric may scale.
    fixed=F(1,20)+F(1,100)+F(1,8)+F(1,20)+F(1,20)+F(228,4096)+F(49,256)+F(1,400)
    scalable=q['care_deadline']-fixed
    assert fixed>F(19,40) and scalable>0
    rows=[]
    for deadline in (F(19,20),F(9,10),F(4,5),F(3,4),F(3,5),F(19,40)):
        can=deadline>fixed
        speed=max(F(1),scalable/(deadline-fixed)) if can else None
        rows.append({'deadline':deadline,'unchanged_serial_stages_feasible':can,
                     'uniform_foreground_service_speed_factor':speed,
                     'CPU_capacity_lower_target':j.FG_CPU*speed+j.BG_CPU if can else None,
                     'host_wire_capacity_lower_target':j.FG_WIRE*speed+j.BG_WIRE if can else None,
                     'pool_wire_capacity_lower_target':j.POOL_FG*speed+j.POOL_BG if can else None,
                     'capital_and_idle_price_supplied':False,
                     'provider_response_and_full_plant_reproved':False})
    return {'fixed_serial_care_floor':fixed,'current_scalable_service_time':scalable,
            'detection_term':F(1,20),'irrevocable_fence_term':F(49,256),
            'journal_term':F(1,8),'stated_grace_term':F(1,400),
            'rows':rows,'half_deadline_fails_even_unbounded_CPU_wire':True,
            'clock_or_fence_can_be_shortened_for_free':False}


def calculate():
    a,q=baseline()
    ac=a['rows'][a['worst_row']]['accounts']
    assert ac['care_mpc_unavailability']==EVENTS*subset(322,79,P0)
    assert ac['background_episode_overflow']==ac['care_mpc_unavailability']
    assert ac['care_slots_and_spreading']==EVENTS*subset(242,110,P0)
    assert a['physical_quorum_tail_union']==EVENTS*subset(242,71,P0)
    phases=phase_audit()
    repairs={'status':'PARTIAL: exact sensitivity and necessary cost screens; no shorter-window plant established',
             'window_sensitivity':window_sensitivity(),
             'reseed_necessary_costs':reseed_requirements(),
             'urgent_recovery_necessary_service':urgent_recovery_requirements(),
             'existing_date_union_p_safely_reduced':False,
             'fully_priced_faster_repair_point':False}
    return {'baseline':'frozen JW2.6 conditional k=2','task1':phases,'task2':repairs,
            'baseline_worst_row':a['worst_row'],
            'baseline_all21_worst':ac,'baseline_with_reserve':a['with_certificate_reserve'],
            'baseline_physical_total':physical(P0),
            'nonphysical_total_with_reserve':risk_at(F(0)),
            'all10_original_IC_margins_positive':all(min(r['IC_gap_lower'],r['IC_extraction_gap_lower'])>0 for r in a['rows'].values()),
            'rung4_established':False,'ordered_prefix_tasks_audited':[1,2],
            'later_tasks_executed':[],
            'later_tasks_deferred':[3,4,5,6,7],
            'reason_for_stopping':'bank and replay bounded prefix at high weekly usage; phase target and temporal law remain unspecified',
            'secret_scattered_placement_integrated':False,'joint_host_shock_rate_computed':False}


if __name__=='__main__':
    print(json.dumps(j.old.encode(calculate()),sort_keys=True,indent=2))
