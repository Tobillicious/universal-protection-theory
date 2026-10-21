"""Rerun the bounded prefix from a relocated copy; bind its identical core."""
from pathlib import Path
import tempfile,subprocess,sys,json,shutil,hashlib
sys.dont_write_bytecode=True
from check_bank import inventory,sha,manifest
from seal import seal
ROOT=Path(__file__).resolve().parents[1]

def digest(data):return hashlib.sha256(data).hexdigest()

def main():
    manifest(ROOT)
    core=[rel for rel in inventory(ROOT) if rel not in ['SHA256SUMS','PORTABLE-REPLAY.json']
          and not rel.startswith('outputs/portable-')]
    original={rel:sha(ROOT/rel) for rel in core}
    def run(where,args):
        p=subprocess.run([sys.executable,'-B']+args,cwd=str(where),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        assert p.returncode==0,(args,p.stderr.decode())
        assert not p.stderr,(args,p.stderr.decode())
        return p.stdout
    with tempfile.TemporaryDirectory(prefix='upt-jw27-relocated-') as temp:
        # macOS's tempfile root can be spelled through the /var symlink.
        # Resolve our newly created directory, then retain all strict guards.
        relocated=Path(temp).resolve()/'bank'
        shutil.copytree(str(ROOT),str(relocated))
        replay=run(relocated,['checks/replay.py'])
        assert json.loads(replay)=={'byte_identical_pairs':10,'expected_adverse_failures':9}
        renders=[run(relocated,['checks/render.py']) for _ in range(2)]
        assert renders[0]==renders[1]==(ROOT/'outputs/render.1.stdout').read_bytes()
        checks=[run(relocated,['checks/check_bank.py','--copies-only']) for _ in range(2)]
        assert checks[0]==checks[1]
        assert json.loads(checks[0])['original_frozen_banks_audited']==0
        assert all(sha(relocated/rel)==original[rel] for rel in core)
    (ROOT/'outputs/portable-replay.stdout').write_bytes(replay)
    for i,stdout in enumerate(checks,1):(ROOT/('outputs/portable-check.%d.stdout'%i)).write_bytes(stdout)
    receipt={'identical':True,'identical_core_files':len(core),'paired_runs_reexecuted':10,
             'adverse_claims_rejected':9,'copies_only_checks':2,
             'report_renderings_reexecuted':2,'original_paths_needed':False,
             'replay_stdout_sha256':digest(replay),'copies_only_stdout_sha256':digest(checks[0]),
             'core_files':[{'path':rel,'sha256':original[rel]} for rel in core]}
    (ROOT/'PORTABLE-REPLAY.json').write_text(json.dumps(receipt,sort_keys=True,indent=2)+'\n')
    count=seal()
    print(json.dumps({'portable_identical_core_files':len(core),'final_bound_files':count,
                      'paired_runs_reexecuted':10,'expected_adverse_failures':9},sort_keys=True))

if __name__=='__main__':main()
