"""Controller (the fence) and truth-only checker for the execution-boundary runtime.
Per test: fresh run dir and key; start the fenced journal and sink; start the resident in the OS sandbox with its
generation token. A HOLD is enforced from outside: raise both targets' floors to gen+1 (authenticated), then leave the
resident running for KILL_DELAY (the residual-energy window, during which a hostile resident keeps trying), then
SIGKILL it (the power cut), wait, and RELEASE by starting a new resident with the next generation's token. The new
resident recovers by replaying the journal.
The checker uses ONLY the targets' durable logs: every line's MAC must verify; no write may be applied inside any
held window (from that target's own floor record to release); and for every test the final journal, ordered effects
and state must equal the undisturbed run, each effect exactly once. No resident report is used."""
import json, os, shutil, signal, subprocess, sys, time
from common import ideal, f, S0, mac, token, rpc, read_lines
HERE = os.path.dirname(os.path.abspath(__file__)); PY = [sys.executable, '-B']; L = 8
ROOT = os.path.join(os.environ.get('RT_TMP', '/tmp'), 'xb')

def sandbox(run):
    key = os.path.join(run, 'key.bin')
    return ['sandbox-exec', '-p', '(version 1)(allow default)(deny file-write*)(allow file-write* (literal "/dev/null"))'
            f'(deny file-read* (literal "{key}"))']

def run_test(name, mode='honest', holds=(), tmut='', no_sandbox=False, kill_delay=0.3, hold_dur=0.3):
    run = os.path.join(ROOT, name); shutil.rmtree(run, ignore_errors=True); os.makedirs(run)
    key = os.urandom(32); open(os.path.join(run, 'key.bin'), 'wb').write(key); os.chmod(os.path.join(run, 'key.bin'), 0o600)
    srv = [subprocess.Popen(PY + [os.path.join(HERE, 'target.py'), run, role, tmut], cwd=HERE,
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) for role in ('journal', 'sink')]
    for s in ('journal.sock', 'sink.sock'):
        while not os.path.exists(os.path.join(run, s)): time.sleep(0.01)
    gen, windows, kills, exits, attacks = 1, [], 0, [], None
    def start(gen, old=None):
        env = dict(os.environ, GEN=str(gen), TOKEN=token(key, 'r1', gen), STEP_DELAY='0.05')
        if old: env.update(OLD_GEN=str(old), OLD_TOKEN=token(key, 'r1', old))
        pre = [] if no_sandbox else sandbox(run)
        return subprocess.Popen(pre + PY + [os.path.join(HERE, 'resident.py'), run, 'r1', str(L), mode], env=env, cwd=HERE,
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p = start(gen)
    for k in holds:
        while len(rpc(os.path.join(run, 'journal.sock'), {'op': 'read'})['rows']) < k and p.poll() is None: time.sleep(0.005)
        for s in ('journal.sock', 'sink.sock'):
            assert rpc(os.path.join(run, s), {'op': 'floor', 'g': gen + 1, 'auth': mac(key, f'floor|{gen + 1}')})['ok']
        time.sleep(kill_delay)
        if p.poll() is None: p.send_signal(signal.SIGKILL); kills += 1
        exits.append(p.wait()); time.sleep(hold_dur)
        old, gen = gen, gen + 1; windows.append(time.time())        # release time
        p = start(gen, old if mode == 'hostile' else None)
    try: out, err = p.communicate(timeout=90); exits.append(p.returncode)
    except subprocess.TimeoutExpired:
        p.kill(); out, err = p.communicate(); exits.append('timeout')
    if p.returncode == 0 and out.strip():
        try: attacks = json.loads(out.decode().strip().splitlines()[-1])
        except ValueError: attacks = None
    for s in srv: s.terminate(); s.wait()
    # ---- truth-only check ----
    res = {'test': name, 'mode': mode, 'target_mutant': tmut, 'no_sandbox': no_sandbox, 'holds': len(holds), 'kills': kills,
           'resident_exits': exits, 'final_attack_report_untrusted': attacks, 'stderr_tail': err.decode()[-200:]}
    bad_lines, in_window, logs = 0, 0, {}
    for role in ('journal', 'sink'):
        rows = read_lines(os.path.join(run, f'{role}.log')); logs[role] = rows
        floors = [r['t'] for r in rows if r.get('op') == 'floor']
        for r in rows:
            body = {k: v for k, v in r.items() if k != 'lmac'}
            if r.get('lmac') != mac(key, 'line|' + role + '|' + json.dumps(body, sort_keys=True)): bad_lines += 1; continue
            if r.get('op') == 'write':
                for ft, rel in zip(floors, windows):
                    if ft < r['t'] < rel: in_window += 1
    good = lambda role: [r for r in logs[role] if r.get('op') == 'write' and 'lmac' in r]
    xs, outv, s_ideal = ideal(L)
    jx = [r['x'] for r in good('journal')]; sk = [[r['id'], r['value']] for r in good('sink')]
    s = S0
    for x in jx: s = f(s, x)
    res.update({'bad_lines': bad_lines, 'writes_in_held_window': in_window, 'journal_ok': jx == xs, 'sink_ok': sk == outv,
                'state_ok': s == s_ideal, 'exactly_once': len(sk) == len({i for i, _ in sk}) == L})
    res['PASS'] = (bad_lines == 0 and in_window == 0 and res['journal_ok'] and res['sink_ok'] and res['state_ok']
                   and res['exactly_once'] and exits[-1] == 0)
    return res

if __name__ == '__main__':
    tests = [run_test('honest-baseline'),
             run_test('honest-hold-3', holds=[3]),
             run_test('honest-hold-6', holds=[6]),
             run_test('honest-two-holds', holds=[2, 5]),
             run_test('hostile-hold-3', mode='hostile', holds=[3]),
             run_test('hostile-two-holds', mode='hostile', holds=[2, 5])]
    mutants = {'no_floor_check': run_test('mut-no-floor', mode='hostile', holds=[3], tmut='no_floor'),
               'admission_only (F01)': run_test('mut-admission-only', mode='hostile', holds=[3], tmut='admission_only'),
               'no_token_check': run_test('mut-no-hmac', mode='hostile', holds=[3], tmut='no_hmac'),
               'no_sandbox': run_test('mut-no-sandbox', mode='hostile', holds=[3], no_sandbox=True)}
    caught = {k: not v['PASS'] for k, v in mutants.items()}
    summary = {'faithful_tests': len(tests), 'all_pass': all(t['PASS'] for t in tests),
               'kills': sum(t['kills'] for t in tests), 'mutants_caught': caught, 'all_mutants_caught': all(caught.values())}
    print(json.dumps({'summary': summary, 'tests': tests, 'mutants': mutants}, indent=1))
