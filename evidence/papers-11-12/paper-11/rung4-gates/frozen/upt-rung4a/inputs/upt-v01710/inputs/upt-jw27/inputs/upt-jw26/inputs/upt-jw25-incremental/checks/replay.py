from pathlib import Path
import subprocess,sys,json,hashlib
ROOT=Path(__file__).resolve().parents[1]
CONTROLS=['fresh_ciphertext_is_sparse','duplicate_delta_safe','parity_dirtiness_equals_input_fraction',
    'average_online_budget_proves_cutoff','next_batch_block_fits','next_online_block_fits',
    'energy_alone_fixes_full_encoder','one_island_guarantee_covers_two']
commands=[('calculate',['checks/calculate.py'],0)]+[(x,['checks/controls.py',x],1) for x in CONTROLS]
receipt=[]
for name,args,expected in commands:
    pair=[]
    for run in [1,2]:
        r=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,capture_output=True)
        assert r.returncode==expected,(name,r.returncode,r.stderr)
        assert (not r.stderr) if expected==0 else bool(r.stderr)
        for stream in ['stdout','stderr']:(ROOT/f'outputs/{name}.{run}.{stream}').write_bytes(getattr(r,stream))
        pair.append(r)
    assert pair[0].stdout==pair[1].stdout and pair[0].stderr==pair[1].stderr
    if name=='calculate':(ROOT/'RESULTS.json').write_bytes(pair[0].stdout)
    receipt.append({'name':name,'argv':['python3','-B',*args],'expected_exit':expected,
        'observed_exits':[r.returncode for r in pair],'byte_identical':True,
        'stdout_sha256':hashlib.sha256(pair[0].stdout).hexdigest(),
        'stderr_sha256':hashlib.sha256(pair[0].stderr).hexdigest()})
(ROOT/'REPLAY.json').write_text(json.dumps({'pairs':9,'executions':18,'expected_adverse_failures':8,'commands':receipt},sort_keys=True,indent=2)+'\n')
print(json.dumps({'pairs':9,'executions':18,'expected_adverse_failures':8,'all_byte_identical':True},sort_keys=True))
