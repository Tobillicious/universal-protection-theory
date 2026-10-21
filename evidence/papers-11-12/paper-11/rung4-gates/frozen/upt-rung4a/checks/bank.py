"""Read-only final audit or seal of new bank; no frozen source writes."""
import json,sys
sys.dont_write_bytecode=True
from common import ROOT,safe,sha,inputs,encode

def inventory(root):
    rows=[]
    def walk(d):
        safe(d)
        for p in sorted(d.iterdir()):
            safe(p)
            if p.is_dir():walk(p)
            else:
                assert p.is_file();rows.append(str(p.relative_to(root)))
    walk(root);return rows

def core():
    return {p:sha(ROOT/p) for p in inventory(ROOT) if p not in ('SHA256SUMS','PORTABLE-REPLAY.json')}

def seal():
    rows=[p for p in inventory(ROOT) if p!='SHA256SUMS']
    safe(ROOT/'SHA256SUMS').write_text(''.join(sha(ROOT/p)+'  '+p+'\n' for p in rows))
    return {'bound_files':len(rows)}

def audit(copies_only=False):
    count=inputs(not copies_only)
    rows=safe(ROOT/'SHA256SUMS').read_text().splitlines();bound={}
    for row in rows:
        h,p=row.split('  ',1);assert p not in bound and '..' not in p.split('/') and not p.startswith('/')
        bound[p]=h;assert sha(ROOT/p)==h,p
    assert set(bound)==set(inventory(ROOT))-{'SHA256SUMS'}
    r=json.loads(safe(ROOT/'REPLAY.json').read_text())
    assert r['paired_jobs']==13 and r['executions']==26 and r['expected_adverse_failures']==9
    for job in r['jobs']:
        assert len(job['runs'])==2 and job['byte_identical']
        for run in job['runs']:
            assert run['exit']==job['expected_exit']
            for s in ('stdout','stderr'):assert sha(ROOT/run[s])==run[s+'_sha256']
        assert all(safe(ROOT/job['runs'][0][s]).read_bytes()==safe(ROOT/job['runs'][1][s]).read_bytes() for s in ('stdout','stderr'))
    data={}
    for name,p in [('proposal','PROPOSAL-RESULTS.json'),('k3','K3-SCREEN.json'),('benchmark','BENCHMARK.json')]:
        assert safe(ROOT/p).read_bytes()==safe(ROOT/('outputs/'+name+'.1.stdout')).read_bytes()
        data[name]=json.loads(safe(ROOT/p).read_text())
    d,k,b=[data[n] for n in ('proposal','k3','benchmark')]
    assert d['algebraic_infeasibility']['joint_feasible_set_empty']
    assert not d['all_five_gaps_closed'] and d['all_claimed_closures_rejected']
    assert k['all_static_checks'] and all(k['checks'].values())
    assert not k['conditional_k3_witness_established'] and not k['rung4_established']
    assert k['benchmark_comparison']['all_selected_static_comparisons_strict']
    assert k['benchmark_comparison']['four_phase_union_fits']
    assert b['proved_sublemmas']['degree3_three_share_secrecy_nonzero_determinants']==35
    assert b['proved_sublemmas']['four_share_reconstruction_cases']==420
    assert not b['founding']['full_founder_construction_proved'] and not b['rung4_established']
    assert b['TW1']['repair_byte_work_dates']==64 and b['TW1']['repair_auth_work_dates']==27
    for p in safe(ROOT/'checks').iterdir():
        if p.suffix=='.py':compile(safe(p).read_text(),str(p),'exec')
    receipt=ROOT/'PORTABLE-REPLAY.json'
    if receipt.exists():
        z=json.loads(safe(receipt).read_text());assert z['identical_core_files']==core()
        assert z['paired_jobs_reexecuted']==13 and z['adverse_claims_rejected']==9 and z['read_only_audits']==2
    return {'frozen_predecessor_files_unchanged':count,'checksums_match':True,'bound_files':len(bound),
      'byte_identical_pairs':13,'expected_adverse_failures':9,'k3_static_checks_pass':True,
      'new_21_account_rows':10,'all_selected_static_margins_strict':True,
      'joint_k3_witness_established':False,'rung4_established':False,'pasted_closure_valid':False}

if __name__=='__main__':
    assert len(sys.argv)>=2 and sys.argv[1] in ('seal','audit')
    if sys.argv[1]=='seal':
        assert len(sys.argv)==2;result=seal()
    else:
        assert all(a=='--copies-only' for a in sys.argv[2:]);result=audit('--copies-only' in sys.argv)
    print(json.dumps(result,sort_keys=True))
