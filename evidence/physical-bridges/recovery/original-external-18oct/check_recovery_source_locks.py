#!/usr/bin/env python3
"""Verifies exact recovered SOURCE BYTES and recovery-ledger consistency.
NOT a mathematical proof, recovered original file authentication or X3 check.
"""
import csv
import hashlib
from pathlib import Path
base=Path(__file__).resolve().parent
locks={}
for line in (base/'SHA256SUMS').read_text().splitlines():
    digest,name=line.split('  ',1)
    assert len(digest)==64 and name
    locks[name]=digest
assert len(locks)==6
for name,sha in locks.items():
    data=(base/name).read_bytes()
    assert hashlib.sha256(data).hexdigest()==sha,(name, 'mismatched recovered SHA-256')
    if name.startswith('UPT-P-'):
        assert data.count(b'\n')==1039
    if name.startswith('GATE-B-'):
        assert data.count(b'\n')==263
    if name.startswith('VIABILITY-'):
        assert data.count(b'\n')==367
    if name.startswith('GATE-D-'):
        assert data.count(b'\n')==162
    if name.endswith('v0.17.2.md'):
        assert data.count(b'\n')==257
    if name.endswith('v0.17.3.md'):
        assert data.count(b'\n')==251
external=(base/'UPT-P-v0.12.1--line-numbered-readback.md').read_text()
gate=(base/'GATE-B-THEOREM-E-v1.1.md').read_text()
assert 'Coverage, date by date' in external
assert 'Lexicographic capacity with margins' in external
assert 'Theorem NP' in external and 'Theorem Φ' in external
assert 'not removable without replacement' in external.lower()
assert '(E1) Preservation. PROVED.' in gate
assert '(E4) The two routes' in gate
with (base/'PRE-REGRESSION-RECOVERY-LEDGER.csv').open(newline='') as stream:
    rows=list(csv.DictReader(stream))
assert len(rows)>=18
ids={r['result_id'] for r in rows}
assert len(ids)==len(rows)
valid={'NOT_READ','SOURCE_READ','REPLAYED','FORMALLY_PROVED_UNDER_ASSUMPTIONS',
       'INDEPENDENTLY_REVIEWED','REFUTED','RETRACTED','UNKNOWN'}
for r in rows:
    assert r['status'] in valid,(r['result_id'],r['status'])
    if r['source_path']:
        assert r['source_path'] in locks,r['result_id']
        assert r['source_hash']==locks[r['source_path']],r['result_id']
        assert r['status'] not in ('NOT_READ','UNKNOWN')
    else:
        assert r['status'] in ('NOT_READ','UNKNOWN','REFUTED'),r['result_id']
assert 'U-P3' in ids and 'U-P4c' in ids and 'H6-Living' in ids
assert {'V-GateA','GATE-D-D2','GATE-D-D3','UPT-19J','UPT-19R3'} <= ids
assert next(r for r in rows if r['result_id']=='H6-Living')['status']=='NOT_READ'
assert next(r for r in rows if r['result_id']=='V-GateA')['status']=='SOURCE_READ'
assert next(r for r in rows if r['result_id']=='DD-Withdrawal')['status']=='RETRACTED'
print('PASS: 6 exact working-copy hashes and source lines,',len(rows),
      'scoped recovery claims. This verifies neither physics nor original X3.')
