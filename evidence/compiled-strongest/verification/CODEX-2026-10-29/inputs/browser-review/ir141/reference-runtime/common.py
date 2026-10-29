"""Shared helpers for the reference faithful-hold runtime (Python 3.9, standard library only, macOS)."""
import fcntl, json, os, socket, time
from contextlib import contextmanager
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
def ideal(L):
    s, out, xs = S0, [], []
    for seq in range(L):
        x = g(len(out)); s = f(s, x); xs.append(x); out.append([seq, s])
    return xs, out, s


@contextmanager
def hold_guard(run):
    """Cooperative POSIX inter-process serialization of a hold transition with execution/apply.

    This is NOT an adversarial security boundary: an OS-enforced separate principal
    must prevent the resident from modifying the lock, HOLD flag, or sink files.
    """
    with open(os.path.join(run, 'hold.lock'), 'a+') as fh:
        fcntl.flock(fh.fileno(), fcntl.LOCK_EX)
        try:
            yield
        finally:
            fcntl.flock(fh.fileno(), fcntl.LOCK_UN)


def set_hold(run, active):
    """Linearization point of a controller hold; also return request-to-ACK latency.

    Every cooperating resident step and sink commit uses the same hold_guard.
    A hold request can wait for in-flight work. It is NOT effective until ACK.
    """
    requested = time.monotonic()
    with hold_guard(run):
        flag = os.path.join(run, 'HOLD')
        if active:
            open(flag, 'w').close()
        else:
            os.remove(flag)
        ack = time.time()
    return ack, time.monotonic() - requested

