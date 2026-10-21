"""Paired new evidence; frozen predecessor is audited read-only."""
import hashlib,json,subprocess,sys
sys.dont_write_bytecode=True
from common import ROOT,safe
CONTROLS=['twilight_share_is_nonnegative','growth_curve_respects_ceiling',
 'founding_gap_is_point09_at_every_time','ratio_diverges_at_trigger',
 'large_mean_implies_small_failure_tail','abrupt_withdrawal_penalty_is_positive',
 '256_substitution_preserves_horizon_budget','FA_labels_reproduce_existing21',
 'minimum_phase_targets_widen_before_twilight']

def main():
    jobs=[
      ('proposal',['checks/proposal.py'],0),
      ('k3',['checks/k3_screen.py'],0),
      ('benchmark',['checks/benchmark.py'],0)
    ]+[(name,['checks/proposal.py','--claim',name],1) for name in CONTROLS]+[
      ('predecessor',['inputs/upt-v01710/checks/bank.py','audit','--copies-only'],0)]
    rows=[]
    for name,args,want in jobs:
        runs=[]
        for i in (1,2):
            p=subprocess.run([sys.executable,'-B']+args,cwd=str(ROOT),stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            assert p.returncode==want,(name,p.returncode,p.stderr.decode())
            run={'exit':p.returncode}
            for s,data in [('stdout',p.stdout),('stderr',p.stderr)]:
                rel='outputs/%s.%d.%s'%(name,i,s)
                safe(ROOT/rel).write_bytes(data)
                run[s]=rel;run[s+'_sha256']=hashlib.sha256(data).hexdigest()
            runs.append(run)
        assert all(runs[0][s+'_sha256']==runs[1][s+'_sha256'] for s in ('stdout','stderr'))
        rows.append({'name':name,'args':args,'expected_exit':want,'runs':runs,'byte_identical':True})
    for name,out in [('proposal','PROPOSAL-RESULTS.json'),('k3','K3-SCREEN.json'),('benchmark','BENCHMARK.json')]:
        safe(ROOT/out).write_bytes(safe(ROOT/('outputs/'+name+'.1.stdout')).read_bytes())
    result={'paired_jobs':len(jobs),'executions':len(jobs)*2,'expected_adverse_failures':len(CONTROLS),'jobs':rows}
    safe(ROOT/'REPLAY.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ('paired_jobs','executions','expected_adverse_failures')},sort_keys=True))

if __name__=='__main__':main()
