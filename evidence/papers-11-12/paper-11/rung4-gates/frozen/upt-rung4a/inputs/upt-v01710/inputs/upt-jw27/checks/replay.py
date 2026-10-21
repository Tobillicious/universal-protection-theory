"""Paired subprocess evidence; expected adverse exits are part of the contract."""
from pathlib import Path
import hashlib,json,subprocess,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
CONTROLS=['half_window_implied_by_date_union','half_deadline_from_unbounded_CPU',
          'serial_reseed32_quota_with_old_energy','reseed16_with_old_authentication',
          'three_island_founder_at_k2','56_island_founder_uses_JW26_envelope',
          '79_site_term_dominates_physical_risk','uniform_accounting_removes_common_correlation',
          'MN2_proves_strict_twilight_separation']

def sha(data):return hashlib.sha256(data).hexdigest()

def main():
    jobs=[('calculation',['checks/calculate.py'],0)]+[(n,['checks/controls.py',n],1) for n in CONTROLS]
    evidence=[]
    for name,args,want in jobs:
        runs=[]
        for run in (1,2):
            p=subprocess.run([sys.executable,'-B']+args,cwd=str(ROOT),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            assert p.returncode==want,(name,p.returncode,p.stderr.decode())
            stdout='outputs/%s.%d.stdout'%(name,run)
            stderr='outputs/%s.%d.stderr'%(name,run)
            (ROOT/stdout).write_bytes(p.stdout);(ROOT/stderr).write_bytes(p.stderr)
            runs.append({'exit':p.returncode,'stdout':stdout,'stderr':stderr,
                         'stdout_sha256':sha(p.stdout),'stderr_sha256':sha(p.stderr)})
        assert runs[0]['stdout_sha256']==runs[1]['stdout_sha256']
        assert runs[0]['stderr_sha256']==runs[1]['stderr_sha256']
        evidence.append({'name':name,'args':args,'expected_exit':want,'runs':runs,'byte_identical':True})
    (ROOT/'RESULTS.json').write_bytes((ROOT/'outputs/calculation.1.stdout').read_bytes())
    result={'command_pairs':len(jobs),'subprocess_executions':2*len(jobs),
            'expected_adverse_failures':len(CONTROLS),'commands':evidence}
    (ROOT/'REPLAY.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n')
    print(json.dumps({'byte_identical_pairs':len(jobs),'expected_adverse_failures':len(CONTROLS)},sort_keys=True))

if __name__=='__main__':main()
