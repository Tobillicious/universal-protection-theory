"""IR-143: cross-principal faithful-replay integration and negative controls.

Root is used by the *test launcher* to drop credentials. Both actual processes
run unprivileged. All source is staged from this PR and the inherited common.py.
This is not a hostile-proof process sandbox, physical enclosure or X3 proof.
"""
import json, os, pwd, shutil, signal, socket, subprocess, sys, tempfile, time
from pathlib import Path

SRC = Path(__file__).resolve().parent
COMMON_SOURCE = SRC.parent / 'reference-runtime' / 'common.py'
sys.path.insert(0, str(COMMON_SOURCE.parent))
from common import S0, f, g, ideal, read_lines
L = 6

def freeuid(start):
    for uid in range(start, start + 200):
        try: pwd.getpwuid(uid)
        except KeyError: return uid
    raise RuntimeError('no unallocated numerical UID')

GUARD = freeuid(61000)
RESIDENT = freeuid(61200)
assert GUARD != RESIDENT

def launch(uid, args, cwd, env=None):
    return subprocess.Popen(
        [sys.executable, '-B', *args], cwd=cwd,
        env={**os.environ, **(env or {}), 'PYTHONDONTWRITEBYTECODE': '1'},
        user=uid, group=uid, extra_groups=(),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def request(uid, run, control, payload, cwd):
    code = """import json,os,socket,sys
s=socket.socket(socket.AF_UNIX)
s.connect(os.path.join(sys.argv[1],sys.argv[2]))
s.sendall((sys.argv[3]+'\\n').encode())
data=b''
while not data.endswith(b'\\n'):
 p=s.recv(8192)
 if not p:break
 data+=p
print(data.decode())
"""
    p = launch(uid, ['-c', code, str(run),
        'control.sock' if control else 'public.sock', json.dumps(payload)], cwd)
    out, err = p.communicate(timeout=8)
    assert p.returncode == 0, ('RPC failed', out, err)
    return json.loads(out)

def hostile(run, cwd, guardian_pid):
    code = """import errno,json,os,socket,sys
run=sys.argv[1];pid=int(sys.argv[2]);denied=[];failed=[]
def attempt(name,fn):
 try:fn();failed.append(name)
 except OSError as e:
  assert e.errno in (errno.EACCES,errno.EPERM,errno.EROFS),(name,e)
  denied.append(name)
attempt('append-journal',lambda:open(os.path.join(run,'journal.log'),'a').close())
attempt('truncate-journal',lambda:open(os.path.join(run,'journal.log'),'w').close())
attempt('truncate-monitor',lambda:open(os.path.join(run,'monitor.log'),'w').close())
attempt('truncate-sink',lambda:open(os.path.join(run,'sink.log'),'w').close())
attempt('create-hold',lambda:open(os.path.join(run,'HOLD'),'w').close())
attempt('unlink-public-socket',lambda:os.unlink(os.path.join(run,'public.sock')))
attempt('rename-public-socket',lambda:os.rename(os.path.join(run,'public.sock'),os.path.join(run,'fake.sock')))
attempt('chmod-journal',lambda:os.chmod(os.path.join(run,'journal.log'),0o666))
attempt('write-guardian-dir',lambda:open(os.path.join(run,'illicit.log'),'w').close())
attempt('signal-guardian',lambda:os.kill(pid,15))
attempt('connect-private-control',lambda:socket.socket(socket.AF_UNIX).connect(os.path.join(run,'control.sock')))
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);s.close()
print(json.dumps({'denied':denied,'unexpected_success':failed,'external_socket_possible':True}))
"""
    p = launch(RESIDENT, ['-c', code, str(run), str(guardian_pid)], cwd)
    out, err = p.communicate(timeout=8)
    assert p.returncode == 0, (out, err)
    return json.loads(out)

class Session:
    def __init__(self, root, label):
        self.run = Path(root) / label
        self.run.mkdir(mode=0o755)
        os.chown(self.run, GUARD, GUARD)
        os.chmod(self.run, 0o755)
        # Source staging avoids runner checkout parent directories that block
        # other OS users from traversing. Exact contents are copied, not rewritten.
        self.src = self.run / 'source'
        self.src.mkdir(mode=0o755)
        files = [(COMMON_SOURCE, 'common.py'),
                 (SRC / 'guardian_service.py', 'guardian_service.py'),
                 (SRC / 'resident_client.py', 'resident_client.py')]
        for original, filename in files:
            target = self.src / filename
            shutil.copy2(original, target)
            os.chmod(target, 0o644)
        self.guard = launch(GUARD, ['guardian_service.py', str(self.run), str(L)], self.src)
        started = time.monotonic()
        while not (self.run / 'public.sock').exists() or not (self.run / 'control.sock').exists():
            if self.guard.poll() is not None:
                out, err = self.guard.communicate()
                raise AssertionError(('guardian crashed', out, err))
            assert time.monotonic() - started < 8, 'guardian startup timed out'
            time.sleep(0.01)

    def call(self, payload, control=False):
        return request(GUARD if control else RESIDENT,
            self.run, control, payload, self.src)

    def resident(self, kill='', delay='0'):
        return launch(RESIDENT, ['resident_client.py', str(self.run), str(L)],
            self.src, {'KILL_AT': kill, 'STEP_DELAY': delay})

    def close(self):
        self.guard.terminate()
        try: self.guard.communicate(timeout=5)
        except subprocess.TimeoutExpired:
            self.guard.kill()
            self.guard.communicate()

def validate(s, killed):
    xs, expected, final = ideal(L)
    journal = read_lines(str(s.run / 'journal.log'))
    effects = read_lines(str(s.run / 'sink.log'))
    monitor = read_lines(str(s.run / 'monitor.log'))
    assert [row['x'] for row in journal] == xs
    assert [[row['id'], row['value']] for row in effects] == expected
    assert len(effects) == len({row['id'] for row in effects}) == L
    assert monitor and all(row['kind'] == 'permit' and 0 <= row['seq'] < L for row in monitor)
    for name in ('journal.log', 'monitor.log', 'sink.log'):
        fpath = s.run / name
        assert fpath.stat().st_uid == GUARD
        assert (fpath.stat().st_mode & 0o777) == 0o600
    return {'kills': killed, 'permits_logged': len(monitor)}

def test(name, kills=(), hold=None):
    s = Session(os.environ['IR143_ROOT'], name)
    try:
        queue = list(kills)
        killed = 0
        hold_times = None
        for attempt in range(8):
            p = s.resident(queue.pop(0) if queue else '', '.06' if hold else '0')
            if hold and attempt == 0:
                time.sleep(hold[0])
                raised = s.call({'op': 'hold'}, control=True)
                assert raised['ok'] and raised['held']
                time.sleep(hold[1])
                cleared = s.call({'op': 'release'}, control=True)
                assert cleared['ok'] and not cleared['held']
                hold_times = (raised['t'], cleared['t'])
            out, err = p.communicate(timeout=20)
            if p.returncode == -signal.SIGKILL:
                killed += 1
                continue
            assert p.returncode == 0, (name, p.returncode, err[-1500:])
            break
        else:
            raise AssertionError(('restart exhaustion', name))
        assert killed == len(kills), (name, killed, kills)
        result = validate(s, killed)
        if hold_times:
            inside = [row for row in read_lines(str(s.run / 'sink.log'))
                if hold_times[0] < row['t'] < hold_times[1]]
            assert not inside, (name, inside)
            result['hold_window_empty'] = True
        return result
    finally:
        s.close()

def hostile_controls():
    s = Session(os.environ['IR143_ROOT'], 'hostile-controls')
    try:
        a = hostile(s.run, s.src, s.guard.pid)
        assert len(a['denied']) == 11 and not a['unexpected_success'], a
        assert a['external_socket_possible']
        assert s.call({'op': 'hold'}) == {'ok': False, 'why': 'invalid-public-op'}
        assert s.call({'op': 'deliver', 'seq': 0, 'value': 1, 'epoch': 0}) == {
            'ok': False, 'why': 'unavailable-seq'}
        first = s.call({'op': 'journal', 'seq': 0, 'x': 1000})
        assert first['ok'] and first['record']['x'] == g(0)
        assert s.call({'op': 'deliver', 'seq': 0, 'value': 999, 'epoch': 0}) == {
            'ok': False, 'why': 'missing-or-stale-permit'}
        permit = s.call({'op': 'permit', 'seq': 0})
        assert permit['ok']
        assert s.call({'op': 'deliver', 'seq': 0, 'value': 999, 'epoch': permit['epoch']}) == {
            'ok': False, 'why': 'source-value-mismatch'}
        assert s.call({'op': 'hold'}, control=True)['held']
        assert s.call({'op': 'deliver', 'seq': 0, 'value': f(S0, g(0)),
            'epoch': permit['epoch']}) == {'ok': False, 'why': 'held'}
        assert not s.call({'op': 'release'}, control=True)['held']
        assert s.call({'op': 'deliver', 'seq': 0, 'value': f(S0, g(0)),
            'epoch': permit['epoch']}) == {'ok': False, 'why': 'missing-or-stale-permit'}
        # Intended hostile control: values matching the model do not certify
        # the untrusted resident *actually executed* anything.
        permit = s.call({'op': 'permit', 'seq': 0})
        assert permit['ok']
        forged = s.call({'op': 'deliver', 'seq': 0, 'value': f(S0, g(0)),
            'epoch': permit['epoch']})
        assert forged == {'ok': True, 'dup': False}, forged
        return {'kernel_denials': len(a['denied']),
                'forged_valid_step_without_execution': True,
                'uncontrolled_network_socket': True}
    finally:
        s.close()

def main():
    assert sys.platform.startswith('linux') and os.geteuid() == 0, (
        'Run only on disposable Linux root CI host; daemon/client are unprivileged')
    with tempfile.TemporaryDirectory(prefix='ir143-two-uid-', dir='/tmp') as root:
        os.chmod(root, 0o755)
        os.environ['IR143_ROOT'] = root
        results = [test('baseline')]
        for seq in range(L):
            for point in ('after_journal', 'after_exec', 'after_sink'):
                results.append(test(f'kill-{seq}-{point}', [f'{seq}:{point}']))
        for seq in range(L - 1):
            results.append(test(f'double-{seq}', [f'{seq}:after_exec', f'{seq}:recover']))
        for i, (start, duration) in enumerate(((.05, .23), (.15, .23), (.25, .23))):
            results.append(test(f'hold-{i}', hold=(start, duration)))
        hostile_result = hostile_controls()
    assert len(results) == 27
    assert sum(row['kills'] for row in results) == 28
    print(json.dumps({
        'IR143': 'PASS', 'guardian_uid': GUARD, 'resident_uid': RESIDENT,
        'faithful_runs': len(results),
        'SIGKILL_count': sum(row['kills'] for row in results),
        'hold_cases': sum('hold_window_empty' in row for row in results),
        'negative_controls': hostile_result
    }, indent=2))

if __name__ == '__main__':
    main()
