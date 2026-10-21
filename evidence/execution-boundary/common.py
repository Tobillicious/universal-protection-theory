"""Shared pieces for the execution-boundary runtime (Python 3.9 stdlib)."""
import fcntl, hashlib, hmac, json, os, socket
S0 = 3
def f(s, x): return (3 * s + x) % 7          # the resident's deterministic transition
def g(n_delivered): return n_delivered + 1    # its input: depends on what it has already delivered
def ideal(L):
    s, xs, out, n = S0, [], [], 0
    for seq in range(L):
        x = g(n); xs.append(x); s = f(s, x); out.append([seq, s]); n += 1
    return xs, out, s
def mac(key, msg): return hmac.new(key, msg.encode(), hashlib.sha256).hexdigest()
def token(key, rid, gen): return mac(key, f'tok|{rid}|{gen}')
def fullsync(fh): fh.flush(); fcntl.fcntl(fh.fileno(), fcntl.F_FULLFSYNC)
def rpc(path, msg, timeout=10):
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as c:
        c.settimeout(timeout); c.connect(path); c.sendall((json.dumps(msg) + '\n').encode())
        buf = b''
        while not buf.endswith(b'\n'):
            d = c.recv(65536)
            if not d: break
            buf += d
    return json.loads(buf)
def read_lines(path):
    if not os.path.exists(path): return []
    out = []
    for l in open(path):
        try: out.append(json.loads(l))
        except ValueError: out.append({'_unparseable': l})
    return out
