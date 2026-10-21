"""Two byte-identical executions, including expected adverse failures."""
from pathlib import Path
import subprocess,sys,json,hashlib
ROOT=Path(__file__).resolve().parents[1]
CONTROLS=['scalar_floor_fits16','dual_encoder_fits16','dual_encoder_fits_daily128',
    'full160_encodes_fresh_checkpoint','three_erasures_recover','two_extra_mirrors_fit',
    'time_spreading_is_free','rekey_only_updates_changed_state']

def main():
    records=[]
    commands=[('calculate',['checks/calculate.py'],0)]
    commands += [(name,['checks/controls.py',name],1) for name in CONTROLS]
    for name,args,expected in commands:
        pair=[]
        for run in [1,2]:
            result=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,capture_output=True)
            assert result.returncode==expected,(name,result.returncode,result.stderr)
            assert (not result.stderr) if expected==0 else bool(result.stderr)
            for stream in ['stdout','stderr']:
                (ROOT/f'outputs/{name}.{run}.{stream}').write_bytes(getattr(result,stream))
            pair.append(result)
        assert pair[0].stdout==pair[1].stdout and pair[0].stderr==pair[1].stderr,name
        if name=='calculate':(ROOT/'RESULTS.json').write_bytes(pair[0].stdout)
        records.append({'name':name,'argv':['python3','-B',*args],'expected_exit':expected,
            'stdout_sha256':hashlib.sha256(pair[0].stdout).hexdigest(),
            'stderr_sha256':hashlib.sha256(pair[0].stderr).hexdigest(),'byte_identical':True})
    receipt={'commands':records,'pairs':len(records),'executions':2*len(records),
        'adverse_controls':len(CONTROLS),'all_matched_expected_exit':True}
    (ROOT/'REPLAY.json').write_text(json.dumps(receipt,sort_keys=True,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k!='commands'},sort_keys=True))

if __name__=='__main__':main()
