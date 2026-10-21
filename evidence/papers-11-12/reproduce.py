"""Verify this complete candidate: seals, Lean/probe status, exact checks, negative controls, Paper 11.

Python 3.9+, standard library; Lean 4.35.0 for a full result. Measurements are never run. --python-only
returns PARTIAL with exit 2. Expected outputs can be built only in a separate unsealed authoring workspace;
the public command has no flag that rewrites them.
"""
from pathlib import Path
import argparse,hashlib,json,os,re,shutil,subprocess,sys,tempfile
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parent
ENV=dict(os.environ,PYTHONDONTWRITEBYTECODE='1')
NEGATIVE={
 'monitor_controls':('rollback_hides_a_live_call','same_visible_output_implies_safe_release'),
 'conditional_lottery_check':('unconditional_round_uniformity_guarantees_fair_stopping','a_finite_rejection_cap_has_no_abort_mass'),
 'release_scope_check':('zero_probability_loss_forces_strict_dominance','every_sufficient_effect_interface_needs_a_sink_id'),
 'measurement_records_check':('saved_raw_run_proves_corrected_full_sync_timing','saved_component_data_certifies_all_timing_premises'),
 'rung5_dependency_check':('legacy_incentive_filter_covers_all_values','marginal_service_probability_certifies_pool_tail','host_shock_marginals_certify_independent_committee','adaptive_withdrawals_preserve_fixed_set_bound','mixed_ledger_keeps_baseline_8p24e_7')}

def integrity(root=ROOT):
    manifest=root/'SHA256SUMS'
    if not manifest.is_file():raise RuntimeError('missing complete-package SHA256SUMS')
    expected={}
    for line in manifest.read_text().splitlines():
        h,name=line.split('  ',1);p=Path(name)
        if p.is_absolute() or '..' in p.parts or name in expected or not re.fullmatch('[0-9a-f]{64}',h):raise RuntimeError('invalid manifest entry')
        expected[name]=h
    actual={}
    for p in sorted(root.rglob('*')):
        if p.is_symlink():raise RuntimeError('symlink in sealed package')
        if p.is_file() and p!=manifest:actual[str(p.relative_to(root))]=hashlib.sha256(p.read_bytes()).hexdigest()
    if actual!=expected:raise RuntimeError('package differs from its manifest')
    return len(actual)

def execute(argv,cwd,expected_exit=0,env=ENV):
    p=subprocess.run(list(map(str,argv)),cwd=cwd,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE,timeout=180)
    if p.returncode!=expected_exit or p.stderr:
        raise RuntimeError('command failed: '+str(argv)+'\n'+p.stdout.decode(errors='replace')+p.stderr.decode(errors='replace'))
    return p.stdout

def expected(path,data,record):
    if record:
        if (ROOT/'SHA256SUMS').exists():raise RuntimeError('sealed packages cannot rewrite expected outputs')
        path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
    elif path.read_bytes()!=data:raise RuntimeError('output differs: '+str(path.relative_to(ROOT)))

def axiom_rows(data):
    rows=[]
    for line in data.decode().splitlines():
        a=re.fullmatch(r"'([^']+)' does not depend on any axioms",line)
        b=re.fullmatch(r"'([^']+)' depends on axioms: \[(.*)\]",line)
        if a:rows.append({'theorem':a[1],'axioms':[]})
        elif b:rows.append({'theorem':b[1],'axioms':b[2].split(', ') if b[2] else []})
        else:raise RuntimeError('unexpected Lean probe/module output: '+line)
    if any(set(r['axioms'])-{'propext','Classical.choice','Quot.sound'} for r in rows):raise RuntimeError('unexpected axiom')
    return rows

def lean_suite(lean,record=False):
    version=execute([lean,'--version'],ROOT).decode().strip()
    if 'version 4.35.0' not in version:raise RuntimeError('Lean 4.35.0 is required')
    ldir=ROOT/'lean';files=sorted(p for p in ldir.glob('*.lean') if p.name!='NegativeControl.lean');audits=[]
    for source in files:
        out=execute([lean,source.name],ldir)
        if out:raise RuntimeError('unexpected standalone Lean output: '+source.name)
        src=source.read_text();ns=re.search(r'^namespace (\w+)',src,re.M)[1]
        names=[ns+'.'+n for n in re.findall(r"^theorem ([\w.']+)",src,re.M)]
        with tempfile.TemporaryDirectory(prefix='upt-probe-') as d:
            probe=Path(d)/'Probe.lean';probe.write_text(src+''.join('\n#print axioms _root_.'+n+'\n' for n in names))
            # Probe return code and stderr are checked, not merely its stdout.
            data=execute([lean,'Probe.lean'],d)
        rows=axiom_rows(data)
        if [r['theorem'] for r in rows]!=names:raise RuntimeError('incomplete axiom probe: '+source.name)
        audits.extend(rows);expected(ROOT/'expected'/('axioms_'+source.stem+'.txt'),data,record)
        print('Lean '+source.name+': OK ('+str(len(rows))+' axiom audits)',flush=True)
    mdir=ldir/'modules';order=(mdir/'ORDER').read_text().split()
    with tempfile.TemporaryDirectory(prefix='upt-modules-') as d:
        for name in order:shutil.copyfile(mdir/(name+'.lean'),Path(d)/(name+'.lean'))
        env=dict(ENV,LEAN_PATH=d)
        for name in order:
            data=execute([lean,'-o',name+'.olean',name+'.lean'],d,env=env)
            audits.extend(axiom_rows(data));expected(ROOT/'expected'/('module_'+name+'.txt'),data,record)
            print('Lean module '+name+': OK',flush=True)
    bad=execute([lean,'NegativeControl.lean'],ldir,expected_exit=1)
    if b'error:' not in bad:raise RuntimeError('false Lean control did not fail as a theorem')
    print('Lean false statement: rejected',flush=True)
    return {'version':version,'standalone_files':len(files),'module_builds':len(order),'axiom_entries':len(audits),
            'negative_control_rejected':True,'audits':audits}

def python_suite(record=False):
    count=0
    for sub in ('','codex'):
        directory=ROOT/'checks'/sub
        for p in sorted(directory.glob('*.py')):
            data=execute([sys.executable,'-B',p.name],directory)
            expected(ROOT/'expected'/sub/(p.stem+'.stdout'),data,record);count+=1
            print('Exact '+(sub+'/' if sub else '')+p.name+': OK',flush=True)
    negative=0
    for script,claims in NEGATIVE.items():
        for claim in claims:
            data=execute([sys.executable,'-B',script+'.py',claim],ROOT/'checks',expected_exit=1)
            if json.loads(data).get('accepted') is not False:raise RuntimeError('false claim accepted')
            expected(ROOT/'expected/negative'/script/(claim+'.stdout'),data,record);negative+=1
    return {'positive_checks':count,'negative_controls':negative,'all_expected':True}

def paper11(record=False):
    directory=ROOT/'paper-11/rung4-gates'
    data=execute([sys.executable,'-B','run_all.py'],directory)
    summary=json.loads(data.decode().strip().splitlines()[-1])
    if summary!={'checkers':8,'all_pass':True,'checks':140}:raise RuntimeError('Paper 11 result differs')
    expected(ROOT/'expected/paper11.stdout',data,record);print('Paper 11 rungs 3-5: 140/140',flush=True)
    return summary

def run_suite(lean,record=False,check_manifest=True):
    payload=integrity() if check_manifest else None
    proof=lean_suite(lean,record) if lean else None
    exact=python_suite(record);paper=paper11(record)
    result={'status':'PASS' if proof else 'PARTIAL','integrity_payloads':payload,'lean':proof,'python':exact,
            'paper11':paper,'measurements_rerun':False}
    return result

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--lean');parser.add_argument('--python-only',action='store_true');args=parser.parse_args()
    lean=None if args.python_only else args.lean or os.environ.get('LEAN') or shutil.which('lean') or str(Path.home()/'.elan/bin/lean')
    if lean and not Path(lean).is_file():lean=None
    try:
        result=run_suite(lean)
        compact=dict(result)
        if compact['lean']:compact['lean']={k:v for k,v in compact['lean'].items() if k!='audits'}
        print(json.dumps(compact,sort_keys=True))
        if not lean:print('PARTIAL: Lean was not checked; no complete-proof success is claimed.')
        return 0 if lean else 2
    except (RuntimeError,ValueError,OSError,subprocess.TimeoutExpired) as e:
        print('FAIL: '+str(e),file=sys.stderr);return 1
if __name__=='__main__':raise SystemExit(main())
