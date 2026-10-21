"""Relocated new replay with copied inputs only."""
from pathlib import Path
import json,subprocess,sys,tempfile
sys.dont_write_bytecode=True
from common import ROOT,safe,sha
from bank import core,inventory,audit,seal

def main():
    audit();before=core()
    with tempfile.TemporaryDirectory(prefix='upt-rung4a-') as t:
        dest=Path(t).resolve()/'bank';safe(dest).mkdir()
        for rel in inventory(ROOT):
            p=safe(dest/rel);p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(safe(ROOT/rel).read_bytes())
        p=subprocess.run([sys.executable,'-B','checks/replay.py'],cwd=str(dest),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        assert p.returncode==0,p.stderr.decode()
        replay=json.loads(p.stdout)
        for i in range(2):
            p=subprocess.run([sys.executable,'-B','checks/bank.py','audit','--copies-only'],cwd=str(dest),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            assert p.returncode==0,p.stderr.decode()
        assert set(inventory(dest))-{'SHA256SUMS','PORTABLE-REPLAY.json'}==set(before)
        assert all(sha(dest/rel)==h for rel,h in before.items())
    assert core()==before
    z={'identical_core_files':before,'core_file_count':len(before),'paired_jobs_reexecuted':replay['paired_jobs'],
       'adverse_claims_rejected':replay['expected_adverse_failures'],'read_only_audits':2,'uses_only_copied_inputs':True}
    safe(ROOT/'PORTABLE-REPLAY.json').write_text(json.dumps(z,sort_keys=True,indent=2)+'\n')
    seal();audit()
    print(json.dumps({k:z[k] for k in ('core_file_count','paired_jobs_reexecuted','adverse_claims_rejected','read_only_audits')},sort_keys=True))

if __name__=='__main__':main()
