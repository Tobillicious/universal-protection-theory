"""Replay from relocated copies; compare every core byte and audit twice."""
from pathlib import Path
import json, subprocess, sys, tempfile
sys.dont_write_bytecode = True
from audit import ROOT, safe
from bank import inventory, core, audit, seal


def main():
    audit()
    before = core()
    with tempfile.TemporaryDirectory(prefix='upt-v01710-') as temp:
        # Resolve only our new temp directory; macOS /var is an alias to /private/var.
        relocated = Path(temp).resolve() / 'bank'
        safe(relocated).mkdir()
        for rel in inventory(ROOT):
            p = safe(relocated / rel)
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_bytes(safe(ROOT / rel).read_bytes())
        p = subprocess.run([sys.executable, '-B', 'checks/replay.py'], cwd=str(relocated),
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        assert p.returncode == 0, p.stderr.decode()
        replay = json.loads(p.stdout)
        for i in range(2):
            p = subprocess.run([sys.executable, '-B', 'checks/bank.py', 'audit', '--copies-only'],
                               cwd=str(relocated), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            assert p.returncode == 0, p.stderr.decode()
        for rel, h in before.items():
            import hashlib
            assert hashlib.sha256(safe(relocated / rel).read_bytes()).hexdigest() == h, rel
        files = set(inventory(relocated)) - {'SHA256SUMS', 'PORTABLE-REPLAY.json'}
        assert files == set(before)
    assert core() == before
    receipt = {'identical_core_files': before, 'core_file_count': len(before),
               'paired_jobs_reexecuted': replay['command_pairs'],
               'adverse_claims_rejected': replay['expected_adverse_failures'],
               'read_only_audits': 2, 'uses_only_copied_inputs': True}
    safe(ROOT / 'PORTABLE-REPLAY.json').write_text(json.dumps(receipt, sort_keys=True, indent=2) + '\n')
    seal()
    audit()
    print(json.dumps({k: receipt[k] for k in ('core_file_count', 'paired_jobs_reexecuted',
                                            'adverse_claims_rejected', 'read_only_audits')}, sort_keys=True))


if __name__ == '__main__':
    main()
