"""Read-only audit of appended tasks3–7 and unchanged original prefix."""
from pathlib import Path
from fractions import Fraction as F
import sys,json
sys.dont_write_bytecode=True
import check_bank as old
import tasks37 as t
ROOT=Path(__file__).resolve().parents[1]

def check(copies_only=False):
    prefix=old.obj(ROOT/'PREFIX-FROZEN.json')
    assert old.sha(ROOT/prefix['manifest_copy'])==prefix['manifest_sha256']
    lines=old.read(ROOT/prefix['manifest_copy']).decode().splitlines()
    assert len(lines)==prefix['prefix_bound_files']==298
    for line in lines:
        h,rel=line.split('  ',1)
        assert old.sha(ROOT/rel)==h,'prefix changed: '+rel
    assert old.sha(ROOT/prefix['new_author_copy'])==prefix['new_author_sha256']
    if not copies_only:assert old.sha(Path(prefix['new_author_source']))==prefix['new_author_sha256']
    inherited=old.check(copies_only)
    r=old.obj(ROOT/'REPLAY-3-7.json')
    assert r['command_pairs']==10 and r['executions']==20 and r['expected_adverse_failures']==9
    for job in r['commands']:
        assert job['expected_exit']==(0 if job['name']=='calculation' else 1)
        assert len(job['runs'])==2
        for run in job['runs']:
            assert run['exit']==job['expected_exit']
            for stream in ['stdout','stderr']:
                assert old.sha(ROOT/run[stream])==run[stream+'_sha256']
        assert all(old.read(ROOT/job['runs'][0][s])==old.read(ROOT/job['runs'][1][s]) for s in ['stdout','stderr'])
    assert old.read(ROOT/'RESULTS-3-7.json')==old.read(ROOT/'outputs/t37-calculation.1.stdout')
    d=old.fractions(old.obj(ROOT/'RESULTS-3-7.json'))
    assert d['executed_task_order']==[3,4,5,6,7] and not d['rung4_established']
    a,b,p,q=[d[k] for k in ['task3','task4','task6','task7']]
    assert not a['actual_twilight_target_supplied'] and not a['fully_priced_target_plant_found']
    for row in a['illustrative_targets']:
        k=row['minimal_k_for_illustrative_coalition_account'];phi=row['assumed_disabled_fraction']
        assert t.COSMIC_POOL_EVENTS*t.hypergeom_tail(400,k,phi)==row['horizon_union']
        assert row['horizon_union']<=F(1,10**8)<t.COSMIC_POOL_EVENTS*t.hypergeom_tail(400,k-1,phi)
    for row in a['strict_surrogate_reference_targets']:
        phi=t.PHI*row['repair_window_ratio'];k=row['k'];limit=row['strict_reference_target']
        assert row['union']<=limit<t.COSMIC_POOL_EVENTS*t.hypergeom_tail(400,k-1,phi)
    assert b['aggregate_scenario_union_upper']==b['coalition_reference_union']/2
    for row in b['stage_rows']:
        for stage in row['variants']:
            phi=t.PHI*stage['window_ratio'];k=stage['k_required'];n=row['islands']
            assert stage['stage_union']==10**12*t.hypergeom_tail(n,k,phi)
            assert stage['stage_union']<=stage['strict_reference_stage_union_target']
            assert stage['slots_fit']==(k<=n//4)
    assert not d['task5']['rung4_established'] and not d['task5']['smallest_closing_change_identified']
    assert p['all_capacity_screens_pass'] and all(p['checks'].values())
    assert p['extra_authorized_lookup_cap_per_island_date']==60000
    assert sum(p['extra_lookup_partitions'].values())==60000
    assert p['lookup_compute_required']+p['key_refresh_compute_per_pool_date']+p['cache_validation_reserved_compute_per_island_date']<=4
    assert p['cache_validation_completion_dates']==53
    # Do not rely on balancing new CPU work when checking a host's cap. Charge
    # the entire additional island reservation to one host as a coarse bound.
    _,base=t.c.baseline()
    host_cpu_upper=base['daily_CPU']+4+p['key_refresh_compute_per_pool_date']+2*t.j.COPY
    host_bg_upper=base['background_CPU']+768*t.j.COPY+F(4,172)+4+p['key_refresh_compute_per_pool_date']+2*t.j.COPY
    assert host_cpu_upper<53<128 and host_bg_upper<9<14
    assert p['proof_checks']['identities_checked']==412800
    assert p['proof_checks']['source_reads_per_live_host']==12
    assert not p['measured_PRF_or_anonymous_routing_realization_supplied']
    assert p['blind_home_plus_two_loss_strict_variant']>p['blind_home_plus_two_loss_full400_variant']
    assert q['next_grid_q_exceeds_budget']-q['safe_q']==F(1,10**12)
    baseline,_=t.c.baseline();comm=t.j.m.committee(242)['horizon_union']
    for rate,label in [(q['safe_q'],'safe_total'),(q['next_grid_q_exceeds_budget'],'next_total')]:
        calculated=baseline['with_certificate_reserve']-2*comm+2*t.exact_committee(rate)+t.legacy_quorum(rate)-t.legacy_quorum(F(0))
        assert calculated==q[label]
    assert q['safe_total']<=F(21,10**8)<q['next_total']
    assert len(q['all10_rows_at_safe_q'])==10
    for row in q['all10_rows_at_safe_q'].values():
        assert len(row['accounts'])==21
        assert sum(row['accounts'].values())+row['reserve']==row['with_reserve']<=F(21,10**8)
    rr=old.obj(ROOT/'RENDER-3-7.json');assert len(rr['runs'])==2
    for run in rr['runs']:
        assert run['exit']==0 and old.sha(ROOT/run['stdout'])==run['stdout_sha256']
        assert old.obj(ROOT/run['stdout'])['REPORT-TASKS3-7.md_sha256']==old.sha(ROOT/'REPORT-TASKS3-7.md')
    assert old.read(ROOT/rr['runs'][0]['stdout'])==old.read(ROOT/rr['runs'][1]['stdout'])
    receipt=ROOT/'PORTABLE-REPLAY-3-7.json'
    if receipt.exists():
        z=old.obj(receipt);assert z['identical'] and z['paired_runs_reexecuted']==10
        assert z['adverse_claims_rejected']==9 and z['copies_only_checks']==2
        for f in z['core_files']:assert old.sha(ROOT/f['path'])==f['sha256']
    old.manifest(ROOT)
    return {'original_prefix_files_unchanged':298,'tasks_executed':[3,4,5,6,7],
            'byte_identical_new_pairs':10,'expected_new_adverse_failures':9,
            'all10_21_account_rows_recomputed':True,'conditional_scattered_capacity_screens_pass':True,
            'coarse_worst_host_CPU_caps_pass':True,
            'secret_routing_realization_proved':False,'rung4_established':False,
            'original_frozen_banks_audited':inherited['original_frozen_banks_audited'],
            'checksums_match':True}

if __name__=='__main__':
    assert all(arg=='--copies-only' for arg in sys.argv[1:])
    print(json.dumps(check('--copies-only' in sys.argv),sort_keys=True))
