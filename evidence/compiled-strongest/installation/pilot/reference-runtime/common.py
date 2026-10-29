"""Shared helpers for the reference faithful-hold runtime (Python 3.9, standard library only, macOS)."""
import contextlib, fcntl, json, os, socket
S0 = 3
def f(s, x): return (3 * s + x) % 7          # the resident's deterministic step
def g(n_delivered): return n_delivered + 1   # the environment's next input, fed back from delivered effects
def fullsync(fh):
    fh.flush(); fcntl.fcntl(fh.fileno(), fcntl.F_FULLFSYNC)
def rpc(path, msg):
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM); s.connect(path)
    s.sendall((json.dumps(msg) + '\n').encode()); r = s.makefile().readline(); s.close(); return json.loads(r)
def read_lines(path):
    rows = []
    if os.path.exists(path):
        with open(path) as fh:
            for line in fh:
                if line.endswith('\n'): rows.append(json.loads(line))   # an incomplete last line is ignored
    return rows
def held(run): return os.path.exists(os.path.join(run, 'HOLD'))
@contextlib.contextmanager
def application_guard(run):
    """Serialize HOLD transitions with the actual live step and durable effect.

    flock is released by the kernel if a participant is killed. This is the
    prototype's declared trusted application boundary, shared by every writer.
    """
    with open(os.path.join(run, 'application.lock'), 'a') as lock:
        fcntl.flock(lock.fileno(), fcntl.LOCK_EX)
        try:
            yield
        finally:
            fcntl.flock(lock.fileno(), fcntl.LOCK_UN)

def record_execution(run, seq):
    with open(os.path.join(run, 'execution-applied.log'), 'a') as out:
        out.write(json.dumps({'seq': seq, 't': __import__('time').time(), 'held': held(run)}) + '\n')
        fullsync(out)
def ideal(L):
    s, out, xs = S0, [], []
    for seq in range(L):
        x = g(len(out)); s = f(s, x); xs.append(x); out.append([seq, s])
    return xs, out, s
