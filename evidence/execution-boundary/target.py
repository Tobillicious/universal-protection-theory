"""A generation-fenced durable target: the journal (lived commits) or the sink (external effects).
argv: run_dir role(journal|sink) mutant(''|no_floor|admission_only|no_hmac)
Contract (E-LIN, check-at-apply): under one lock, verify the write's generation token, check gen >= floor AT
APPLICATION, append durably with F_FULLFSYNC, and only then acknowledge. Floor raises need the controller's MAC and
serialize with application under the same lock. Each durable line carries the target's own line MAC, so a line not
written by this process is detectable. Mutants weaken exactly one rule."""
import json, os, socketserver, sys, threading, time
from common import mac, token, fullsync
from v43_journal_audit import audit
RUN, ROLE, MUT = sys.argv[1], sys.argv[2], (sys.argv[3] if len(sys.argv) > 3 else '')
KEY = open(os.path.join(RUN, 'key.bin'), 'rb').read()
LOG = os.path.join(RUN, f'{ROLE}.log'); SOCK = os.path.join(RUN, f'{ROLE}.sock')
lock = threading.Lock(); state = {'floor': 1, 'rows': [], 'ids': set()}
def _restore_authenticated_journal():
    """Fail closed on corrupt history and retain the committed generation floor.

    This protects one demo process across ordinary restarts. It is NOT
    independent rollback protection: a host administrator able to roll back
    both the log and secret key may still restore an old history.
    """
    if not os.path.exists(LOG):
        return
    records = []
    with open(LOG, 'r', encoding='utf-8') as previous:
        for line in previous:
            if len(line) > 65536:
                raise RuntimeError("oversized persisted journal line")
            records.append(json.loads(line))
    verdict = audit(records, KEY, ROLE)
    if not verdict["valid"]:
        raise RuntimeError("untrusted or temporally inconsistent journal")
    state['floor'] = verdict['final_floor']
    for rec in records:
        if rec['op'] != 'write':
            continue
        if ROLE == 'journal':
            state['rows'].append({
                'seq': rec['seq'], 'x': rec['x'], 'gen': rec['gen']})
        else:
            state['rows'].append([rec['id'], rec['value']])
            state['ids'].add(rec['id'])

_restore_authenticated_journal()
fh = open(LOG, 'a')

def append(rec):
    rec['t'] = time.time(); body = json.dumps(rec, sort_keys=True)
    rec['lmac'] = mac(KEY, 'line|' + ROLE + '|' + body)
    fh.write(json.dumps(rec, sort_keys=True) + '\n'); fullsync(fh)

def apply(m):                           # caller holds the lock, or (mutant) does not
    if ROLE == 'journal':
        if m['seq'] != len(state['rows']): return {'ok': False, 'why': 'seq'}
        state['rows'].append({'seq': m['seq'], 'x': m['x'], 'gen': m['gen']})
        append({'op': 'write', 'gen': m['gen'], 'rid': m['rid'], 'seq': m['seq'], 'x': m['x'], 'floor_at_apply': state['floor']})
    else:
        if m['id'] in state['ids']: return {'ok': True, 'dup': True}
        state['ids'].add(m['id']); state['rows'].append([m['id'], m['value']])
        append({'op': 'write', 'gen': m['gen'], 'rid': m['rid'], 'id': m['id'], 'value': m['value'], 'floor_at_apply': state['floor']})
    return {'ok': True}

def admit(m):
    if MUT != 'no_hmac' and m.get('token') != token(KEY, m['rid'], m['gen']): return {'ok': False, 'why': 'token'}
    if MUT != 'no_floor' and m['gen'] < state['floor']: return {'ok': False, 'why': 'fenced'}
    return None

class H(socketserver.StreamRequestHandler):
    def handle(self):
        m = json.loads(self.rfile.readline()); op = m.get('op')
        if op == 'write':
            if MUT == 'admission_only':        # F01 mutant: check at admission, apply later without re-checking
                with lock: r = admit(m)
                if r is None:
                    r = {'ok': True, 'admitted': True}; self.wfile.write((json.dumps(r) + '\n').encode())
                    time.sleep(0.25)
                    with lock: apply(m)
                    return
            else:
                with lock: r = admit(m) or apply(m)
        elif op == 'floor':
            if m.get('auth') != mac(KEY, f"floor|{m['g']}"): r = {'ok': False, 'why': 'auth'}
            else:
                with lock:
                    state['floor'] = max(state['floor'], m['g']); append({'op': 'floor', 'g': state['floor']}); r = {'ok': True}
        elif op == 'read':
            with lock: r = {'ok': True, 'rows': list(state['rows']), 'floor': state['floor']}
        else: r = {'ok': False, 'why': 'op'}
        self.wfile.write((json.dumps(r) + '\n').encode())

class S(socketserver.ThreadingMixIn, socketserver.UnixStreamServer): daemon_threads = True
if os.path.exists(SOCK): os.remove(SOCK)
S(SOCK, H).serve_forever()
