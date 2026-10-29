"""IR-143: unprivileged resident: journal-first, deterministic replay, restart.

It never directly writes guardian journals, monitor receipts, HOLD or effect log.
A permit is a trusted record of a request, not proof of subjective execution.
"""
import json, os, signal, socket, sys, time
from common import S0, f

RUN, L = sys.argv[1], int(sys.argv[2])
SOCK = os.path.join(RUN, 'public.sock')
KILL = os.environ.get('KILL_AT', '')
DELAY = float(os.environ.get('STEP_DELAY', '0'))

def call(payload):
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
        s.connect(SOCK)
        s.sendall((json.dumps(payload) + '\n').encode())
        buf = b''
        while not buf.endswith(b'\n'):
            part = s.recv(8192)
            if not part:
                raise RuntimeError('guardian closed the socket')
            buf += part
    return json.loads(buf)

def halt_at(seq, phase):
    if KILL == f'{seq}:{phase}':
        os.kill(os.getpid(), signal.SIGKILL)

def permitted(seq):
    while True:
        result = call({'op': 'permit', 'seq': seq})
        if result['ok']:
            return result['epoch']
        time.sleep(0.004)

def deliver(seq, value, epoch):
    while True:
        result = call({'op': 'deliver', 'seq': seq, 'value': value, 'epoch': epoch})
        if result['ok']:
            return
        if result.get('why') in ('held', 'missing-or-stale-permit'):
            epoch = permitted(seq)
            continue
        raise RuntimeError('guardian rejected delivery: ' + str(result))

snapshot = call({'op': 'snapshot'})
assert snapshot['ok']
state = S0
for record in snapshot['journal']:
    state = f(state, record['x'])
    if not any(effect['id'] == record['seq'] for effect in snapshot['sink']):
        halt_at(record['seq'], 'recover')
        epoch = permitted(record['seq'])
        deliver(record['seq'], state, epoch)

seq = len(snapshot['journal'])
while seq < L:
    while True:
        result = call({'op': 'journal', 'seq': seq})
        if result['ok']:
            break
        time.sleep(0.004)
    x = result['record']['x']
    halt_at(seq, 'after_journal')
    epoch = permitted(seq)
    state = f(state, x)
    halt_at(seq, 'after_exec')
    deliver(seq, state, epoch)
    halt_at(seq, 'after_sink')
    seq += 1
    time.sleep(DELAY)
