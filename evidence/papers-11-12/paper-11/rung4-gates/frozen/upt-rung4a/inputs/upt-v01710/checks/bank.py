"""Seal the current bank or audit it read-only; frozen inputs are never written."""
import hashlib, json, sys
sys.dont_write_bytecode = True
from audit import ROOT, safe, sha, source_check, calculate, encode


def inventory(root):
    result = []
    def walk(d):
        safe(d)
        for p in sorted(d.iterdir()):
            safe(p)
            if p.is_dir():
                walk(p)
            elif p.is_file():
                result.append(str(p.relative_to(root)))
            else:
                raise AssertionError('not a regular file: ' + str(p))
    walk(root)
    return result


def core():
    return {rel: sha(ROOT / rel) for rel in inventory(ROOT)
            if rel not in ('SHA256SUMS', 'PORTABLE-REPLAY.json')}


def seal():
    files = [r for r in inventory(ROOT) if r != 'SHA256SUMS']
    safe(ROOT / 'SHA256SUMS').write_text(''.join(sha(ROOT / r) + '  ' + r + '\n' for r in files))
    return {'bound_files': len(files)}


def audit(copies_only=False):
    inputs = source_check(not copies_only)
    lines = safe(ROOT / 'SHA256SUMS').read_text().splitlines()
    manifest = {}
    for line in lines:
        h, rel = line.split('  ', 1)
        assert rel not in manifest and not rel.startswith('/') and '..' not in rel.split('/')
        manifest[rel] = h
        assert sha(ROOT / rel) == h, rel
    assert set(manifest) == set(inventory(ROOT)) - {'SHA256SUMS'}
    r = json.loads(safe(ROOT / 'REPLAY.json').read_text())
    assert r['command_pairs'] == 16 and r['executions'] == 32 and r['expected_adverse_failures'] == 11
    for job in r['commands']:
        assert len(job['runs']) == 2 and job['byte_identical']
        for run in job['runs']:
            assert run['exit'] == job['expected_exit']
            for s in ('stdout', 'stderr'):
                assert sha(ROOT / run[s]) == run[s + '_sha256']
        assert all(safe(ROOT / job['runs'][0][s]).read_bytes() ==
                   safe(ROOT / job['runs'][1][s]).read_bytes() for s in ('stdout', 'stderr'))
    assert safe(ROOT / 'RESULTS.json').read_bytes() == safe(ROOT / 'outputs/independent.1.stdout').read_bytes()
    d = json.loads(safe(ROOT / 'RESULTS.json').read_text())
    assert d == encode(calculate())
    assert not d['full_GLM_0b_claim_established'] and not d['rung4_established']
    mapped = json.loads(safe(ROOT / 'CLAIMS.json').read_text())['claims']
    assert len(mapped) == 56
    for row in mapped:
        lines = safe(ROOT / row['source']).read_text().splitlines()
        assert row['anchor'] in lines[row['line'] - 1]
    rendered = json.loads(safe(ROOT / 'outputs/candidate.2.stdout').read_text())
    for name, h in rendered.items():
        assert sha(ROOT / name) == h
    for p in safe(ROOT / 'checks').iterdir():
        if p.suffix == '.py':
            compile(safe(p).read_text(), str(p), 'exec')
    receipt = ROOT / 'PORTABLE-REPLAY.json'
    if receipt.exists():
        z = json.loads(safe(receipt).read_text())
        assert z['identical_core_files'] == core()
        assert z['paired_jobs_reexecuted'] == 16 and z['adverse_claims_rejected'] == 11
        assert z['read_only_audits'] == 2
    return {**inputs, 'checksums_match': True, 'bound_files': len(manifest),
            'source_claims_mapped': len(mapped), 'byte_identical_pairs': 16,
            'expected_adverse_failures': 11, 'rung4_established': False,
            'full_GLM_0b_claim_established': False, 'candidate_adopted_by_author': False}


if __name__ == '__main__':
    assert sys.argv[1] in ('seal', 'audit')
    if sys.argv[1] == 'seal':
        assert len(sys.argv) == 2
        result = seal()
    else:
        assert all(s == '--copies-only' for s in sys.argv[2:])
        result = audit('--copies-only' in sys.argv)
    print(json.dumps(result, sort_keys=True))
