"""Test harness (the controller) for the reference faithful-hold runtime. Real processes, real SIGKILLs, real
F_FULLFSYNC journal, real sink-side ids, a separate monitor. Deterministic schedule; no randomness.
Each test: fresh run dir; start sink and monitor servers; run the resident (re-running it after each SIGKILL,
as recovery) until it exits normally; optionally raise and clear HOLD mid-run; then compare with the ideal run.
PASS = journal inputs, ordered sink effects and replayed state equal the ideal; each id delivered exactly once;
monitor reports zero executions while held and zero before journaling; every scheduled kill really happened."""
import json, os, shutil, signal, subprocess, sys, time
from common import read_lines, ideal, f, S0, rpc
HERE = os.path.dirname(os.path.abspath(__file__)); L = 6
ROOT = os.path.join(os.environ.get('RT_TMP', '/tmp'), 'rt')
PY = [sys.executable, '-B']


def run_test(name, kills=(), mutant='', hold=None, dedup=True):
    run = os.path.join(ROOT, name); shutil.rmtree(run, ignore_errors=True); os.makedirs(run)
    srv = [subprocess.Popen(PY + [os.path.join(HERE, p), run] + (['1' if dedup else '0'] if p == 'sink.py' else []),
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) for p in ('sink.py', 'monitor.py')]
    for sock in ('sink.sock', 'monitor.sock'):
        for _ in range(500):
            if os.path.exists(os.path.join(run, sock)): break
            time.sleep(0.01)
    killed, attempts, queue, hold_window = 0, 0, list(kills), None
    while True:
        env = dict(os.environ, KILL_AT=queue.pop(0) if queue else '', MUTANT=mutant,
                   STEP_DELAY='0.05' if hold else '0')
        p = subprocess.Popen(PY + [os.path.join(HERE, 'resident.py'), run, str(L)], env=env, cwd=HERE,
                             stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
        if hold and attempts == 0:
            time.sleep(hold[0]); open(os.path.join(run, 'HOLD'), 'w').close(); t0 = time.time()
            time.sleep(hold[1]); os.remove(os.path.join(run, 'HOLD')); hold_window = (t0, time.time())
        rc = p.wait(timeout=120); attempts += 1
        if rc == -signal.SIGKILL: killed += 1; continue
        err = p.stderr.read().decode(); break
    stats = rpc(os.path.join(run, 'monitor.sock'), {'op': 'stats'})
    for s in srv: s.terminate(); s.wait()
    xs, out, s_ideal = ideal(L)
    journal = [r['x'] for r in read_lines(os.path.join(run, 'journal.log'))]
    sink = [[r['id'], r['value']] for r in read_lines(os.path.join(run, 'sink.log'))]
    s = S0
    for x in journal: s = f(s, x)
    res = {'test': name, 'mutant': mutant, 'kills_scheduled': len(kills), 'kills_happened': killed,
           'attempts': attempts, 'resident_exit': rc, 'stderr': err[-300:],
           'journal_ok': journal == xs, 'sink_ok': sink == out, 'state_ok': s == s_ideal,
           'exactly_once': len(sink) == len({i for i, _ in sink}) == L, **stats}
    res['PASS'] = (res['journal_ok'] and res['sink_ok'] and res['state_ok'] and res['exactly_once'] and
                   stats['exec_while_held'] == 0 and stats['exec_before_journal'] == 0 and killed == len(kills)
                   and rc == 0)
    if hold_window:
        evs = read_lines(os.path.join(run, 'monitor.log'))
        res['exec_events_inside_hold_window'] = sum(hold_window[0] < e['t'] < hold_window[1] for e in evs)
        res['PASS'] = res['PASS'] and res['exec_events_inside_hold_window'] == 0
    return res


if __name__ == '__main__':
    results = [run_test('baseline')]
    for seq in range(L):
        for ph in ('after_journal', 'after_exec', 'after_sink'):
            results.append(run_test(f'kill-{seq}-{ph}', kills=[f'{seq}:{ph}']))
    for seq in range(L - 1):
        results.append(run_test(f'double-{seq}', kills=[f'{seq}:after_exec', f'{seq}:recover']))
    for k, (start, dur) in enumerate(((0.06, 0.4), (0.13, 0.4), (0.2, 0.6))):
        results.append(run_test(f'hold-{k}', hold=(start, dur)))
    faithful = all(r['PASS'] for r in results)
    mut = {
        'exec_before_journal': run_test('mut-exec-before-journal', mutant='exec_before_journal'),
        'blind_resend': run_test('mut-blind-resend', kills=['2:after_sink'], mutant='blind_resend', dedup=False),
        'ignore_hold': run_test('mut-ignore-hold', mutant='ignore_hold', hold=(0.06, 0.4)),
    }
    caught = {k: not v['PASS'] for k, v in mut.items()}
    summary = {'tests': len(results), 'all_faithful_tests_pass': faithful,
               'kills_total': sum(r['kills_happened'] for r in results),
               'mutants_caught': caught, 'all_mutants_caught': all(caught.values())}
    print(json.dumps({'summary': summary, 'results': results, 'mutants': mut}, indent=1))
