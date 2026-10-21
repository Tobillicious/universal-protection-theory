"""Run GLM audit, predecessor check and integration in that order, twice each."""
import hashlib, json, subprocess, sys
sys.dont_write_bytecode = True
from audit import ROOT, safe

CONTROLS = [
    'expectation_excludes_early_success', 'sixteen_probes_equal_one_blind_pair',
    'blind_hit_fits_common_budget', 'arrival_cap_is_outstanding_cap',
    'energy_conservation_implies_draw_floor', 'one_over5120_is_double_one_over8192',
    'one_other_loss_fits_same_cap', 'critical_lifetime_boundary_is_safe',
    'strict_parity_has399_foreign_candidates', 'one_sided_rounding_test_is_sound',
    'two_member_intersection_survives_two_bad']


def main():
    jobs = [
        ('glm-original', ['inputs/author/proposals/glm-0b/check_0b.py'], 0),
        ('independent', ['checks/audit.py'], 0),
    ] + [(name, ['checks/audit.py', '--claim', name], 1) for name in CONTROLS] + [
        ('jw27-read-only', ['inputs/upt-jw27/checks/check37.py', '--copies-only'], 0),
        ('claim-map', ['checks/claims.py'], 0),
        ('candidate', ['checks/build_candidate.py'], 0)]
    records = []
    for name, args, want in jobs:
        runs = []
        for i in (1, 2):
            p = subprocess.run([sys.executable, '-B'] + args, cwd=str(ROOT),
                               stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            assert p.returncode == want, (name, p.returncode, p.stderr.decode())
            row = {'exit': p.returncode}
            for stream, data in [('stdout', p.stdout), ('stderr', p.stderr)]:
                rel = 'outputs/%s.%d.%s' % (name, i, stream)
                safe(ROOT / rel).write_bytes(data)
                row[stream] = rel
                row[stream + '_sha256'] = hashlib.sha256(data).hexdigest()
            runs.append(row)
        assert all(runs[0][s + '_sha256'] == runs[1][s + '_sha256']
                   for s in ('stdout', 'stderr'))
        records.append({'name': name, 'args': args, 'expected_exit': want,
                        'byte_identical': True, 'runs': runs})
    safe(ROOT / 'RESULTS.json').write_bytes(safe(ROOT / 'outputs/independent.1.stdout').read_bytes())
    result = {'command_pairs': len(jobs), 'executions': 2 * len(jobs),
              'expected_adverse_failures': len(CONTROLS),
              'order': ['GLM 0b original and independent audit', 'JW2.7 read-only check', 'local candidate integration'],
              'commands': records}
    safe(ROOT / 'REPLAY.json').write_text(json.dumps(result, sort_keys=True, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ('command_pairs', 'executions', 'expected_adverse_failures')}, sort_keys=True))


if __name__ == '__main__':
    main()
