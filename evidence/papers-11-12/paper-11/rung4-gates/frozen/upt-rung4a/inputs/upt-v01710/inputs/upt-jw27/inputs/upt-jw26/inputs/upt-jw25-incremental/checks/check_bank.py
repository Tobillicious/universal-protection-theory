from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[1]
copies_only='--copies-only' in sys.argv
def guard(path):
    for part in path.parts:
        u=part.upper()
        assert not u.startswith('CALIBRATION-') and not any(x in u for x in ('SCORE','VERIFY','REVIEW-','KNOWN-SEAMS','HANDOFF')),str(path)
def digest(path):guard(path);return hashlib.sha256(path.read_bytes()).hexdigest()
source=json.loads((ROOT/'SOURCE.json').read_text())
assert len(source['files'])==78
for row in source['files']:
    assert digest(ROOT/'inputs/jw25'/row['path'])==row['sha256'],row['path']
    if not copies_only:assert digest(Path(source['root'])/row['path'])==row['sha256'],row['path']
if not copies_only:
    assert digest(Path(source['root'])/'SHA256SUMS')==source['manifest_sha256']
    frozen=json.loads((ROOT/'inputs/jw25/FROZEN-SOURCE.json').read_text())
    assert len(frozen['files'])==95
    assert digest(Path(frozen['root'])/'SHA256SUMS')==frozen['manifest_sha256']
    for row in frozen['files']:assert digest(Path(frozen['root'])/row['path'])==row['sha256'],row['path']
replay=json.loads((ROOT/'REPLAY.json').read_text())
assert (replay['pairs'],replay['executions'],replay['expected_adverse_failures'])==(9,18,8)
for row in replay['commands']:
    assert row['observed_exits']==[row['expected_exit']]*2 and row['byte_identical']
    for stream in ['stdout','stderr']:
        a=ROOT/f"outputs/{row['name']}.1.{stream}";b=ROOT/f"outputs/{row['name']}.2.{stream}"
        assert a.read_bytes()==b.read_bytes()
        assert digest(a)==row[stream+'_sha256']
assert (ROOT/'RESULTS.json').read_bytes()==(ROOT/'outputs/calculate.1.stdout').read_bytes()
r=json.loads((ROOT/'RESULTS.json').read_text())
assert r['incremental_full_guarantee_established'] is False
assert len(r['full_encode_by_k'])==100 and len(r['incremental_dirty_frontiers'])==99
assert len(r['replication_curve'])==100
assert all(x['parities_equal_full_reencode'] for x in r['algebra_checks']['full400_symbol_examples'])
for row in r['incremental_dirty_frontiers'].values():
    for item in row.values():assert item['aggregate_bounds_pass'] and item['next_block_failures']
render=json.loads((ROOT/'RENDER.json').read_text())
assert render['executions']==2 and render['byte_identical']
assert (ROOT/'outputs/render.1.stdout').read_bytes()==(ROOT/'outputs/render.2.stdout').read_bytes()
for name,expected in render['documents'].items():assert digest(ROOT/name)==expected,name
for line in (ROOT/'SHA256SUMS').read_text().splitlines():
    expected,name=line.split('  ',1);rel=Path(name)
    assert not rel.is_absolute() and '..' not in rel.parts
    assert digest(ROOT/rel)==expected,name
print(json.dumps({'bound_sources':78,'JW24_95_frozen_files_audited':not copies_only,
    'JW25_78_frozen_files_audited':not copies_only,'identical_command_pairs':9,
    'expected_adverse_failures':8,'full_curve_k_values':100,'incremental_k_values':99,
    'new_joint_k_claimed':False,'checksums_match':True},sort_keys=True))
