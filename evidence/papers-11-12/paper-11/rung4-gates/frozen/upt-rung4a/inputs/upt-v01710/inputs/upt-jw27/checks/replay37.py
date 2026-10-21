"""Paired continuation evidence; original298-file prefix is not rewritten."""
from pathlib import Path
import sys,json,hashlib,subprocess
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
CONTROLS=['k92_at_literal_0p46percent','target_k_on_old_provider_wire',
          'arbitrary_scatter_preserves_source_bound','strict_parity_has399_candidate_privacy',
          'positive_q_retains_point1_joblaw','q_00016_meets_2p1e7',
          'host_marginals_imply_independent_host_tail','threshold_key_alone_hides_plaintext_cache',
          'budget_k93_strictly_beats_same_reference']

def main():
    records=[]
    for name,args,want in [('calculation',['checks/tasks37.py'],0)]+[(n,['checks/controls37.py',n],1) for n in CONTROLS]:
        runs=[]
        for run in (1,2):
            p=subprocess.run([sys.executable,'-B']+args,cwd=str(ROOT),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            assert p.returncode==want,(name,p.returncode,p.stderr.decode())
            item={'exit':p.returncode}
            for stream,data in [('stdout',p.stdout),('stderr',p.stderr)]:
                rel='outputs/t37-%s.%d.%s'%(name,run,stream)
                (ROOT/rel).write_bytes(data);item[stream]=rel
                item[stream+'_sha256']=hashlib.sha256(data).hexdigest()
            runs.append(item)
        assert all(runs[0][s+'_sha256']==runs[1][s+'_sha256'] for s in ['stdout','stderr'])
        records.append({'name':name,'args':args,'expected_exit':want,'runs':runs,'byte_identical':True})
    (ROOT/'RESULTS-3-7.json').write_bytes((ROOT/'outputs/t37-calculation.1.stdout').read_bytes())
    (ROOT/'REPLAY-3-7.json').write_text(json.dumps({'command_pairs':10,'executions':20,'expected_adverse_failures':9,'commands':records},sort_keys=True,indent=2)+'\n')
    print(json.dumps({'byte_identical_pairs':10,'expected_adverse_failures':9,'task_order':[3,4,5,6,7]},sort_keys=True))

if __name__=='__main__':main()
