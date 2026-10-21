"""Read-only bank audit. --copies-only supports an isolated relocated replay."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json,sys,os
sys.dont_write_bytecode=True
import calculate as c

ROOT=Path(__file__).resolve().parents[1]
FORBIDDEN=('SCORE','VERIFY','REVIEW-','KNOWN-SEAMS','HANDOFF')

def safe(p):
    p=Path(p)
    for part in p.parts:
        assert not part.lower().startswith('calibration-'),str(p)
        assert not any(word in part.upper() for word in FORBIDDEN),str(p)
    for v in [p]+list(p.parents):
        assert not v.is_symlink(),'symlink '+str(v)
    return p

def read(p):return safe(p).read_bytes()
def sha(p):return hashlib.sha256(read(p)).hexdigest()
def obj(p):return json.loads(read(p))

def inventory(root):
    root=safe(root);out=[]
    for base,dirs,files in os.walk(str(root),topdown=True,followlinks=False):
        # Reject before descent. All checked bank directories are controlled
        # copies; this never scans the author source tree.
        for name in dirs:safe(Path(base)/name)
        for name in files:
            p=safe(Path(base)/name)
            assert p.is_file(),str(p)
            out.append(p.relative_to(root).as_posix())
    return sorted(out)

def manifest(root,expected_sha=None):
    p=safe(root)/'SHA256SUMS'
    if expected_sha is not None:assert sha(p)==expected_sha
    entries={}
    for line in read(p).decode().splitlines():
        digest,rel=line.split('  ',1)
        assert not Path(rel).is_absolute() and '..' not in Path(rel).parts
        assert rel not in entries
        assert sha(safe(root)/rel)==digest,rel
        entries[rel]=digest
    assert sorted(entries)==[v for v in inventory(root) if v!='SHA256SUMS'], 'unbound or extra file'
    return entries

def fractions(v):
    if isinstance(v,dict):
        if set(v)=={'exact','decimal_floor'}:
            assert F(v['decimal_floor'])<=F(v['exact']), 'decimal must be a floor'
            return F(v['exact'])
        return {k:fractions(w) for k,w in v.items()}
    if isinstance(v,list):return [fractions(w) for w in v]
    assert not isinstance(v,float),'binary floating point output'
    return v

def check(copies_only=False):
    frozen=obj(ROOT/'FROZEN-BASELINE.json')
    copied=ROOT/frozen['copy']
    entries=manifest(copied,frozen['manifest_sha256'])
    assert len(entries)==frozen['bound_files']==227
    originals=0
    if not copies_only:
        source=Path(frozen['source'])
        manifest(source,frozen['manifest_sha256']);originals+=1
        for old in obj(copied/'FROZEN-SOURCES.json'):
            got=manifest(Path(old['root']),old['manifest_sha256'])
            assert len(got)==len(old['files'])
            originals+=1
    for source in frozen['author_inputs']:
        assert sha(ROOT/source['copy'])==source['sha256']
        if not copies_only:assert sha(Path(source['source']))==source['sha256']
    replay=obj(ROOT/'REPLAY.json')
    assert replay['command_pairs']==10 and replay['expected_adverse_failures']==9
    for job in replay['commands']:
        assert job['expected_exit']==(0 if job['name']=='calculation' else 1)
        runs=job['runs'];assert len(runs)==2
        for run in runs:
            assert run['exit']==job['expected_exit']
            for stream in ['stdout','stderr']:
                assert sha(ROOT/run[stream])==run[stream+'_sha256']
        for stream in ['stdout','stderr']:
            assert read(ROOT/runs[0][stream])==read(ROOT/runs[1][stream])
    assert read(ROOT/'RESULTS.json')==read(ROOT/'outputs/calculation.1.stdout')
    d=fractions(obj(ROOT/'RESULTS.json'))
    assert sum(d['baseline_all21_worst'].values())+c.baseline()[0]['with_certificate_reserve']-c.baseline()[0]['sum']==d['baseline_with_reserve']
    assert len(d['baseline_all21_worst'])==21
    assert not d['rung4_established'] and d['later_tasks_executed']==[]
    assert d['later_tasks_deferred']==[3,4,5,6,7]
    assert not d['task1']['narrowest_phase_identifiable']
    assert len(d['task1']['phase_definitions'])==4
    assert all(p['island_date_exposure'] is None and p['assigned_nonfloor_budget'] is None for p in d['task1']['phase_definitions'])
    assert d['task1']['current_full_pool_margins']['smallest_normalized_resource_headroom']=='energy'
    assert not d['task2']['existing_date_union_p_safely_reduced']
    assert not d['task2']['fully_priced_faster_repair_point']
    assert len(d['task2']['window_sensitivity']['rows'])==16
    par=d['task2']['reseed_necessary_costs']['parallel_returned_store_volume_screen']
    assert par['dates_at_existing_endpoint_quota']==28 and par['auth_dates_at_existing_quota']==27
    assert not par['whole_parallel_rebuild_completion_proved']
    # Independent route through the inherited full calculator at both edges.
    pb=d['task1']['current_full_pool_margins']['fault_rate_boundary']
    m=c.j.m;spares,stock=m.SPARES,m.STOCK_EXTRA
    try:
        m.SPARES=80;m.STOCK_EXTRA=stock+c.j.STOCK_ADD
        for p in (pb['lower_safe'],pb['upper_fails']):
            full=m.full(242,W=42800,physical_p=p)
            assert len(full['rows'])==10
            value=max(sum(r['accounts'].values()) for r in full['rows'].values())+full['eta_cert']+c.EVENTS*c.subset(242,71,p)
            assert value==c.risk_at(p),'independent ten-row boundary recomputation'
    finally:m.SPARES,m.STOCK_EXTRA=spares,stock
    assert c.risk_at(pb['lower_safe'])<=c.ETA<c.risk_at(pb['upper_fails'])
    rr=obj(ROOT/'RENDER.json')
    assert len(rr['runs'])==2
    for run in rr['runs']:
        assert run['exit']==0 and sha(ROOT/run['stdout'])==run['stdout_sha256']
        assert obj(ROOT/run['stdout'])['REPORT.md_sha256']==sha(ROOT/'REPORT.md')
    assert read(ROOT/rr['runs'][0]['stdout'])==read(ROOT/rr['runs'][1]['stdout'])
    manifest(ROOT)
    portable=ROOT/'PORTABLE-REPLAY.json'
    if portable.exists():
        receipt=obj(portable)
        assert receipt['identical'] and receipt['paired_runs_reexecuted']==10
        assert receipt['adverse_claims_rejected']==9 and receipt['copies_only_checks']==2
        for item in receipt['core_files']:
            assert sha(ROOT/item['path'])==item['sha256']
    return {'checksums_match':True,'copied_JW26_files':227,
            'original_frozen_banks_audited':originals,
            'byte_identical_pairs':10,'expected_adverse_failures':9,
            'independent_full_account_boundary_edges_match':True,
            'task1_partial':True,'task2_partial':True,'later_tasks_run':False,
            'rung4_established':False}

if __name__=='__main__':
    assert all(arg=='--copies-only' for arg in sys.argv[1:])
    print(json.dumps(check('--copies-only' in sys.argv),sort_keys=True))
