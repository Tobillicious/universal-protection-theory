from pathlib import Path
import subprocess,json,hashlib,sys
ROOT=Path(__file__).resolve().parents[1]
CONTROLS=['three_islands','two_of_four_hides_two','local70_copies','pool_quorum201',
    'memory4096','burst165','old_host_wire','old_pool_wire','interconnect23','passive79',
    'unthrottled_reseed','power_on_clears_outage','binomial_from_subset_moments',
    'source_seven_reads','serial_audit','stale_primary_image']
commands=[('calculate',['checks/calculate.py'],0)]+[(x,['checks/controls.py',x],1) for x in CONTROLS]
receipt=[]
for name,args,expected in commands:
    pair=[]
    for run in [1,2]:
        p=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,capture_output=True)
        assert p.returncode==expected,(name,p.returncode,p.stderr)
        assert (not p.stderr) if expected==0 else bool(p.stderr)
        for stream in ['stdout','stderr']:(ROOT/f'outputs/{name}.{run}.{stream}').write_bytes(getattr(p,stream))
        pair.append(p)
    assert pair[0].stdout==pair[1].stdout and pair[0].stderr==pair[1].stderr,name
    if name=='calculate':(ROOT/'RESULTS.json').write_bytes(pair[0].stdout)
    receipt.append({'name':name,'argv':['python3','-B',*args],'expected_exit':expected,
        'observed_exits':[p.returncode for p in pair],'byte_identical':True,
        'stdout_sha256':hashlib.sha256(pair[0].stdout).hexdigest(),
        'stderr_sha256':hashlib.sha256(pair[0].stderr).hexdigest()})
summary={'pairs':len(commands),'executions':2*len(commands),'adverse_controls':len(CONTROLS)}
(ROOT/'REPLAY.json').write_text(json.dumps(dict(summary,commands=receipt),sort_keys=True,indent=2)+'\n')
print(json.dumps(dict(summary,all_byte_identical=True),sort_keys=True))
