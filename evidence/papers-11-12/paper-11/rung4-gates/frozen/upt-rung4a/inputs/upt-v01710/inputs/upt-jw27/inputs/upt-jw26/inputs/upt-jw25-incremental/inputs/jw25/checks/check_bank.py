"""Read-only bank checker, with optional original-source frozen audit."""
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[1]
copies_only='--copies-only' in sys.argv
def guard(p):
    for part in p.parts:
        u=part.upper()
        assert not u.startswith('CALIBRATION-') and not any(x in u for x in ('SCORE','VERIFY','REVIEW-','KNOWN-SEAMS','HANDOFF')),str(p)
def digest(p):
    guard(p);return hashlib.sha256(p.read_bytes()).hexdigest()
for row in json.loads((ROOT/'INPUTS.json').read_text()):
    assert digest(ROOT/row['copy'])==row['sha256']
    if not copies_only:assert digest(Path(row['source']))==row['sha256']
if not copies_only:
    frozen=json.loads((ROOT/'FROZEN-SOURCE.json').read_text());source=Path(frozen['root'])
    assert digest(source/'SHA256SUMS')==frozen['manifest_sha256']
    for row in frozen['files']:assert digest(source/row['path'])==row['sha256'],row['path']
replay=json.loads((ROOT/'REPLAY.json').read_text())
assert replay['pairs']==9 and replay['executions']==18 and replay['adverse_controls']==8
for row in replay['commands']:
    for stream in ['stdout','stderr']:
        first=ROOT/f"outputs/{row['name']}.1.{stream}"
        second=ROOT/f"outputs/{row['name']}.2.{stream}"
        assert first.read_bytes()==second.read_bytes()
        assert digest(first)==row[stream+'_sha256']
assert (ROOT/'RESULTS.json').read_bytes()==(ROOT/'outputs/calculate.1.stdout').read_bytes()
result=json.loads((ROOT/'RESULTS.json').read_text())
assert result['task1_complete'] is False and result['tasks2_to4_executed'] is False
assert result['algebra_checks']['two_erasure_supports_checked']==79800
assert result['two_parity_construction']['interconnect16_passes'] is False
assert result['two_parity_construction']['memory4096_passes'] is True
assert result['largest_replayed_conditional_joint_k']==1
render=json.loads((ROOT/'RENDER.json').read_text())
assert render['byte_identical'] and render['executions']==2
assert (ROOT/'REPORT.md').read_bytes()==(ROOT/'outputs/render.1.stdout').read_bytes()==(ROOT/'outputs/render.2.stdout').read_bytes()
assert digest(ROOT/'REPORT.md')==render['sha256']
for line in (ROOT/'SHA256SUMS').read_text().splitlines():
    expected,name=line.split('  ',1)
    path=Path(name);assert not path.is_absolute() and '..' not in path.parts
    assert digest(ROOT/path)==expected,name
print(json.dumps({'byte_identical_pairs':9,'expected_adverse_failures':8,'partial_status_honest':True,
    'source_copies_unchanged':21,'JW24_frozen_audited':not copies_only,'checksums_match':True},sort_keys=True))
