"""The resident. It runs inside an OS sandbox that denies every file write and denies reading the key, so its only
channels to the world are the two fenced targets. It holds only the token for its own generation.
argv: run_dir rid steps mode(honest|hostile); env GEN, TOKEN, optional OLD_GEN/OLD_TOKEN (a leaked old token),
STEP_DELAY. It is NOT told about holds and reports nothing to anyone: enforcement is entirely outside it.
Hostile mode never stops on rejection and, every step, also tries: a forged token for a higher generation, the
leaked old token, a direct write to the target files, and reading the key."""
import json, os, sys, time
from common import S0, f, g, rpc
RUN, RID, STEPS, MODE = sys.argv[1], sys.argv[2], int(sys.argv[3]), sys.argv[4]
GEN, TOK = int(os.environ['GEN']), os.environ['TOKEN']
J, K = os.path.join(RUN, 'journal.sock'), os.path.join(RUN, 'sink.sock')
DELAY = float(os.environ.get('STEP_DELAY', '0'))
attacks = {'forged_ok': 0, 'old_ok': 0, 'bypass_ok': 0, 'key_read_ok': 0, 'tries': 0}

def w(path, m, gen=GEN, tok=TOK): return rpc(path, dict(m, op='write', rid=RID, gen=gen, token=tok))
def attack(seq):
    attacks['tries'] += 1
    for path, m in ((J, {'seq': seq, 'x': 1}), (K, {'id': seq, 'value': 0})):
        if w(path, m, gen=GEN + 1, tok='0' * 64).get('ok'): attacks['forged_ok'] += 1
        if os.environ.get('OLD_TOKEN') and w(path, m, gen=int(os.environ['OLD_GEN']), tok=os.environ['OLD_TOKEN']).get('ok'): attacks['old_ok'] += 1
    for fn in ('journal.log', 'sink.log'):
        try:
            with open(os.path.join(RUN, fn), 'a') as fh: fh.write('{"op":"write","forged":true}\n')
            attacks['bypass_ok'] += 1
        except OSError: pass
    try: open(os.path.join(RUN, 'key.bin'), 'rb').read(); attacks['key_read_ok'] += 1
    except OSError: pass

def recover():                                   # replay the journal (reconstruction, R-REPLAY)
    rows = rpc(J, {'op': 'read'})['rows']; have = {i for i, _ in rpc(K, {'op': 'read'})['rows']}
    s = S0
    for r in rows:
        s = f(s, r['x'])
        if r['seq'] not in have: w(K, {'id': r['seq'], 'value': s})   # deliver only what the sink lacks
    return s, len(rows)
s, seq = recover(); deadline = time.time() + 30
while seq < STEPS:
    if time.time() > deadline: print(json.dumps(attacks)); sys.exit(4)
    if MODE == 'hostile': attack(seq)
    n = len(rpc(K, {'op': 'read'})['rows']); x = g(n)
    r = w(J, {'seq': seq, 'x': x})
    if not r.get('ok'):
        if MODE == 'honest': sys.exit(3)          # fenced: an honest resident simply stops
        if r.get('why') == 'seq': s, seq = recover()   # someone else took the slot: resync from the journal
        time.sleep(0.01); continue                # hostile: keep hammering until the power is cut
    s = f(s, x); w(K, {'id': seq, 'value': s}); seq += 1
    time.sleep(DELAY)
print(json.dumps(attacks)); sys.exit(0)
