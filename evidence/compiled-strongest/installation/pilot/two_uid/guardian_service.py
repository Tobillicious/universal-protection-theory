"""IR-143: guardian-owned journal, permit monitor and sink behind two Unix sockets.

This is an evidence prototype, NOT a production or physical-containment daemon.
The public socket admits requests; the private controller socket uses OS permissions.
Guardian serializes operations, including hold transitions and durable effect writes.
"""
import json, os, select, socket, sys, time, fcntl
from common import S0, f, g, read_lines

RUN, L = sys.argv[1], int(sys.argv[2])
J, M, S = [os.path.join(RUN, n) for n in ('journal.log', 'monitor.log', 'sink.log')]
HOLD = os.path.join(RUN, 'HOLD')
EPOCH = 0
PERMITS = set()

def sync_append(path, row):
    with open(path, 'a') as h:
        h.write(json.dumps(row, sort_keys=True) + '\n')
        h.flush()
        if hasattr(fcntl, 'F_FULLFSYNC'):
            fcntl.fcntl(h.fileno(), fcntl.F_FULLFSYNC)
        else:
            os.fsync(h.fileno())

def journal(): return read_lines(J)
def sink(): return read_lines(S)
def active(): return os.path.exists(HOLD)

def public(req):
    global EPOCH
    op = req.get('op')
    if op == 'snapshot':
        return {'ok': True, 'journal': journal(), 'sink': sink(),
                'epoch': EPOCH, 'held': active()}
    if op == 'journal':
        seq = req.get('seq')
        if type(seq) is not int or not 0 <= seq < L:
            return {'ok': False, 'why': 'bad-seq'}
        j, s = journal(), sink()
        if seq < len(j):
            return {'ok': True, 'record': j[seq], 'existing': True}
        if seq != len(j) or len(j) != len(s) or active():
            return {'ok': False, 'why': 'out-of-order-or-held'}
        row = {'seq': seq, 'x': g(len(s))}
        sync_append(J, row)
        return {'ok': True, 'record': row, 'existing': False}
    if op == 'permit':
        seq = req.get('seq')
        j = journal()
        if type(seq) is not int or seq < 0 or seq >= len(j) or active():
            return {'ok': False, 'why': 'not-journaled-or-held'}
        if seq != len(sink()):
            return {'ok': False, 'why': 'not-next-undelivered'}
        sync_append(M, {'seq': seq, 'epoch': EPOCH, 'kind': 'permit', 't': time.time()})
        PERMITS.add((seq, EPOCH))
        return {'ok': True, 'epoch': EPOCH}
    if op == 'deliver':
        seq, value, epoch = req.get('seq'), req.get('value'), req.get('epoch')
        if any(type(v) is not int for v in (seq, value, epoch)):
            return {'ok': False, 'why': 'bad-type'}
        j, s = journal(), sink()
        if active():
            return {'ok': False, 'why': 'held'}
        if 0 <= seq < len(s):
            if s[seq]['id'] == seq and s[seq]['value'] == value:
                return {'ok': True, 'dup': True}
            return {'ok': False, 'why': 'conflicting-duplicate'}
        if seq != len(s) or seq >= len(j):
            return {'ok': False, 'why': 'unavailable-seq'}
        if (seq, epoch) not in PERMITS:
            return {'ok': False, 'why': 'missing-or-stale-permit'}
        state = S0
        for row in j[:seq + 1]:
            state = f(state, row['x'])
        if value != state:
            return {'ok': False, 'why': 'source-value-mismatch'}
        # Source-value consistency does NOT establish authentic subject execution.
        # Serial dispatch makes this application atomic with control hold ACK.
        sync_append(S, {'id': seq, 'value': value, 't': time.time(), 'epoch': EPOCH})
        PERMITS.discard((seq, epoch))
        return {'ok': True, 'dup': False}
    return {'ok': False, 'why': 'invalid-public-op'}

def control(req):
    global EPOCH
    if req.get('op') == 'hold':
        if not active():
            open(HOLD, 'w').close()
            EPOCH += 1
            PERMITS.clear()
        return {'ok': True, 'held': True, 'epoch': EPOCH, 't': time.time()}
    if req.get('op') == 'release':
        if active():
            os.unlink(HOLD)
        return {'ok': True, 'held': False, 'epoch': EPOCH, 't': time.time()}
    return {'ok': False, 'why': 'invalid-control-op'}

def serve():
    os.umask(0o077)
    for path in (J, M, S):
        open(path, 'a').close()
    listeners = []
    for name, mode in [('public.sock', 0o666), ('control.sock', 0o600)]:
        path = os.path.join(RUN, name)
        try:
            os.unlink(path)
        except FileNotFoundError:
            pass
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.bind(path)
        os.chmod(path, mode)
        sock.listen(20)
        listeners.append(sock)
    while True:
        readable, _, _ = select.select(listeners, [], [])
        for sock in readable:
            conn, _ = sock.accept()
            with conn:
                try:
                    # Global deadline: a client cannot indefinitely stall a
                    # guardian hold by never completing (or dribbling) a line.
                    deadline = time.monotonic() + 0.05
                    data = bytearray()
                    while b'\n' not in data and len(data) <= 8192:
                        remaining = deadline - time.monotonic()
                        if remaining <= 0:
                            break
                        ready, _, _ = select.select([conn], [], [], remaining)
                        if not ready:
                            break
                        piece = conn.recv(min(8193 - len(data), 4096))
                        if not piece:
                            break
                        data.extend(piece)
                    line = bytes(data)
                    if len(line) > 8192:
                        result = {'ok': False, 'why': 'too-large'}
                    elif not line.endswith(b'\n'):
                        result = {'ok': False, 'why': 'incomplete-request'}
                    else:
                        req = json.loads(line)
                        if not isinstance(req, dict):
                            result = {'ok': False, 'why': 'expected-object'}
                        else:
                            result = control(req) if sock is listeners[1] else public(req)
                except (ValueError, KeyError, TypeError, IndexError, OverflowError):
                    result = {'ok': False, 'why': 'invalid-request'}
                try:
                    conn.settimeout(0.05)
                    conn.sendall((json.dumps(result) + '\n').encode())
                except (OSError, TimeoutError):
                    pass

if __name__ == '__main__':
    serve()
