"""Paired exact checks and explicit Lean axiom audit for the two closing obligations."""
from pathlib import Path
import hashlib,json,os,re,subprocess,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1];ENV=dict(os.environ,PYTHONDONTWRITEBYTECODE='1')
CLAIMS=['marginals_imply_joint_service','adaptive_erasures_keep_fixed_subset_tail','subset_law_implies_independence','independence_maximises_every_tail']
checks=[]
for name,extra,code in [('positive',[],0)]+[(n,['--claim',n],1) for n in CLAIMS]:
 runs=[]
 for i in [1,2]:
  p=subprocess.run([sys.executable,'-B',str(ROOT/'checks/items12_check.py')]+extra,env=ENV,capture_output=True,timeout=240)
  (ROOT/'outputs'/('items12-'+name+'.'+str(i)+'.stdout')).write_bytes(p.stdout)
  (ROOT/'outputs'/('items12-'+name+'.'+str(i)+'.stderr')).write_bytes(p.stderr)
  assert p.returncode==code and not p.stderr,(name,p.returncode,p.stderr.decode())
  runs.append(p.stdout)
 assert runs[0]==runs[1]
 checks.append({'name':name,'exit':code,'identical':True,'stdout_sha256':hashlib.sha256(runs[0]).hexdigest()})
lean='/Users/admin/.elan/bin/lean';outs=[]
for i in [1,2]:
 p=subprocess.run([lean,str(ROOT/'proofs/AdaptiveWithdrawal.lean')],env=ENV,capture_output=True,timeout=120)
 (ROOT/'outputs'/('adaptive-lean.'+str(i)+'.stdout')).write_bytes(p.stdout);(ROOT/'outputs'/('adaptive-lean.'+str(i)+'.stderr')).write_bytes(p.stderr)
 assert p.returncode==0 and not p.stderr and b'warning' not in p.stdout and b'error' not in p.stdout
 entries=re.findall(r"^'([^']+)' depends on axioms: \[(.*?)\]$",p.stdout.decode(),re.M)
 assert len(entries)==13
 for name,ax in entries:assert set(ax.split(', '))<={'propext','Classical.choice','Quot.sound'}
 outs.append(p.stdout)
assert outs[0]==outs[1]
p=subprocess.run([lean,str(ROOT/'proofs/FalseUnshifted.lean')],env=ENV,capture_output=True,timeout=120)
(ROOT/'outputs/false-unshifted-lean.stdout').write_bytes(p.stdout);(ROOT/'outputs/false-unshifted-lean.stderr').write_bytes(p.stderr)
assert p.returncode!=0 and b'error' in p.stdout
result={'checks':checks,'python_executions':10,'lean_axiom_entries':13,'lean_runs_identical':True,'false_unshifted_statement_rejected':True,'new_nonstandard_axioms':False,'status':'PASS'}
(ROOT/'outputs/PAIRED-ITEMS12.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n')
print(json.dumps(result,sort_keys=True))
