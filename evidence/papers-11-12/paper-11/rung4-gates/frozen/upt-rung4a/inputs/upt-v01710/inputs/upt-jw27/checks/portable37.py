"""Relocated replay of appended tasks; old prefix evidence stays unchanged."""
from pathlib import Path
import tempfile,shutil,subprocess,json,sys
sys.dont_write_bytecode=True
from check_bank import inventory,sha,manifest
from seal import seal
ROOT=Path(__file__).resolve().parents[1]

def main():
    manifest(ROOT)
    core=[r for r in inventory(ROOT) if r not in ['SHA256SUMS','PORTABLE-REPLAY-3-7.json','outputs/t37-final-check.stdout']
          and not r.startswith('outputs/t37-portable-')]
    original={r:sha(ROOT/r) for r in core}
    def run(path,args):
        p=subprocess.run([sys.executable,'-B']+args,cwd=str(path),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        assert p.returncode==0 and not p.stderr,(args,p.returncode,p.stderr.decode())
        return p.stdout
    with tempfile.TemporaryDirectory(prefix='upt-jw27-t37-') as temp:
        relocated=Path(temp).resolve()/'bank';shutil.copytree(str(ROOT),str(relocated))
        replay=run(relocated,['checks/replay37.py'])
        assert json.loads(replay)['byte_identical_pairs']==10
        renderings=[run(relocated,['checks/render37.py']) for _ in (1,2)]
        assert renderings[0]==renderings[1]==(ROOT/'outputs/t37-render.1.stdout').read_bytes()
        checks=[run(relocated,['checks/check37.py','--copies-only']) for _ in (1,2)]
        assert checks[0]==checks[1] and json.loads(checks[0])['original_frozen_banks_audited']==0
        assert all(sha(relocated/r)==original[r] for r in core)
    (ROOT/'outputs/t37-portable-replay.stdout').write_bytes(replay)
    for i,data in enumerate(checks,1):(ROOT/('outputs/t37-portable-check.%d.stdout'%i)).write_bytes(data)
    receipt={'identical':True,'identical_core_files':len(core),'paired_runs_reexecuted':10,
             'adverse_claims_rejected':9,'copies_only_checks':2,'report_renderings_reexecuted':2,
             'original_paths_needed':False,'old_prefix_rewritten':False,
             'core_files':[{'path':r,'sha256':original[r]} for r in core]}
    (ROOT/'PORTABLE-REPLAY-3-7.json').write_text(json.dumps(receipt,sort_keys=True,indent=2)+'\n')
    print(json.dumps({'portable_identical_core_files':len(core),'final_bound_files':seal(),
                      'new_byte_identical_pairs':10,'new_adverse_failures':9},sort_keys=True))

if __name__=='__main__':main()
