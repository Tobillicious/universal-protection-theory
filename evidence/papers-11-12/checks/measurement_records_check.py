"""Check evidence custody and collector arithmetic without network calls or timing claims."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,importlib.util,json,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]

def main():
    meta=json.loads((ROOT/'measurements/PROVENANCE.json').read_text());row=meta['raw_records'][0]
    raw_path=ROOT/'measurements'/row['path'];assert hashlib.sha256(raw_path.read_bytes()).hexdigest()==row['sha256']
    raw=json.loads(raw_path.read_text());old=(ROOT/'provenance/measure_local.py.v1.5.txt').read_text()
    assert 'os.fsync(' in old and 'F_FULLFSYNC' not in old and 'time.sleep(5)' in old
    assert raw['M2_fsync']=={'appends':1000,'median_ms':0.063,'p99_ms':0.327,'max_ms':5.494}
    assert not meta['corrected_full_sync_and_long_clock_interval_raw_records_present'] and not meta['deployment_premises_certified_by_this_record']
    spec=importlib.util.spec_from_file_location('measurement_collector',ROOT/'measurements/measure_local.py')
    m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
    assert m.parse_offset('+0.073541 +/- 0.034641 time.apple.com')==(F(73541,10**6),F(34641,10**6))
    assert m.parse_offset('unavailable') is None
    assert m.empirical([10,30,20,40])['median_ns']=='25' and m.empirical([10,30,20,40])['empirical_p99_ns']==40
    newer=meta['raw_records'][1];np=ROOT/'measurements'/newer['path']
    assert hashlib.sha256(np.read_bytes()).hexdigest()==newer['sha256']
    assert hashlib.sha256((ROOT/'measurements/measure_local.py').read_bytes()).hexdigest()==newer['collector_sha256']
    fresh=json.loads(np.read_text());d=fresh['durable']
    assert fresh['platform']=='darwin' and d['mechanism_requested']=='F_FULLFSYNC'
    assert len(d['duration_ns'])==1000 and all(isinstance(n,int) and n>0 for n in d['duration_ns'])
    assert d['empirical']==m.empirical(d['duration_ns'])
    if len(sys.argv)>1:
        claim={'saved_raw_run_proves_corrected_full_sync_timing':'F_FULLFSYNC' in old,
               'saved_component_data_certifies_all_timing_premises':bool(meta['deployment_premises_certified_by_this_record'])}[sys.argv[1]]
        print(json.dumps({'claim':sys.argv[1],'accepted':claim},sort_keys=True));return 0 if claim else 1
    print(json.dumps({'historical_raw_hash_matches':True,'original_mechanism':'os.fsync','original_clock_wait_seconds':5,
      'original_reported_corrected_runs_are_saved':False,'new_local_full_sync_record_saved':True,'new_local_full_sync_samples':1000,'collector_parsing_and_empirical_arithmetic':True,
      'network_or_physical_measurements_rerun':False,'deployment_verdict':'not certified by this record'},sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
