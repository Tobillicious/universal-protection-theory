from pathlib import Path
from fractions import Fraction as F
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[1]
copies_only='--copies-only' in sys.argv
def guard(path):
    for part in path.parts:
        u=part.upper()
        assert not u.startswith('CALIBRATION-') and not any(x in u for x in ('SCORE','VERIFY','REVIEW-','KNOWN-SEAMS','HANDOFF')),str(path)
def digest(path):guard(path);return hashlib.sha256(path.read_bytes()).hexdigest()
frozen=json.loads((ROOT/'FROZEN-SOURCES.json').read_text())
assert [len(x['files']) for x in frozen]==[95,78,137]
for bank in frozen:
    if not copies_only:
        assert digest(Path(bank['root'])/'SHA256SUMS')==bank['manifest_sha256']
        for row in bank['files']:assert digest(Path(bank['root'])/row['path'])==row['sha256'],row['path']
    if Path(bank['root']).name=='upt-jw25-incremental':
        for row in bank['files']:assert digest(ROOT/'inputs/upt-jw25-incremental'/row['path'])==row['sha256']
brief=json.loads((ROOT/'BRIEF.json').read_text())
assert digest(ROOT/brief['copy'])==brief['sha256']
if not copies_only:assert digest(Path(brief['source']))==brief['sha256']
rep=json.loads((ROOT/'REPLAY.json').read_text())
assert (rep['pairs'],rep['executions'],rep['adverse_controls'])==(17,34,16)
for row in rep['commands']:
    assert row['observed_exits']==[row['expected_exit']]*2 and row['byte_identical']
    for stream in ['stdout','stderr']:
        a=ROOT/f"outputs/{row['name']}.1.{stream}";b=ROOT/f"outputs/{row['name']}.2.{stream}"
        assert a.read_bytes()==b.read_bytes() and digest(a)==row[stream+'_sha256']
assert (ROOT/'RESULTS.json').read_bytes()==(ROOT/'outputs/calculate.1.stdout').read_bytes()
r=json.loads((ROOT/'RESULTS.json').read_text());t=r['task1'];q=t['resources'];acc=t['all21_accounts']
assert t['conditional_k']==2 and t['globally_smallest_plant_change_proved'] is False
assert r['task2_executed'] is False and all(q['checks'].values())
assert t['plant']['host_burst_CPU']==166 and t['plant']['memory']==4512
assert q['checkpoint_events_per_home_date_upper']==1384
assert len(acc['rows'])==10
for row in acc['rows'].values():
    assert len(row['accounts'])==21
    assert sum(F(v['exact']) for v in row['accounts'].values())==F(row['sum']['exact'])
    assert F(row['with_reserve']['exact'])<F(1,10**6)
    assert min(F(row['IC_gap_lower']['exact']),F(row['IC_extraction_gap_lower']['exact']))>0
assert all(t['lower_energy_variant']['checks'].values())
assert t['algebra']['two_island_erasure_supports_per_home']==79800
assert t['algebra']['source_matching_masks']==259
assert F(q['energy_margin']['exact'])>0
assert sum(F(v['exact']) if isinstance(v,dict) else F(v) for v in t['plant']['capital_ledger'].values())==t['plant']['stock']
render=json.loads((ROOT/'RENDER.json').read_text())
assert render['executions']==2 and render['byte_identical']
assert (ROOT/'outputs/render.1.stdout').read_bytes()==(ROOT/'outputs/render.2.stdout').read_bytes()
for name,sha in render['documents'].items():assert digest(ROOT/name)==sha,name
for line in (ROOT/'SHA256SUMS').read_text().splitlines():
    sha,name=line.split('  ',1);rel=Path(name)
    assert not rel.is_absolute() and '..' not in rel.parts
    assert digest(ROOT/rel)==sha,name
print(json.dumps({'conditional_k':2,'ten_complete21_account_rows':True,'byte_identical_pairs':17,
    'expected_adverse_failures':16,'copied_predecessor_files':137,
    'frozen_banks_audited':0 if copies_only else 3,'checksums_match':True,
    'global_minimum_proved':False,'task2_executed':False},sort_keys=True))
