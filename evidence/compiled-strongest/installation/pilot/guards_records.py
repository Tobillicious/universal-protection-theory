"""Pilot measurements for the guard response and a maintained record class.

usage: RT_TMP=<scratch> python3 -B guards_records.py out.json   (run from installation/pilot/)

Guard: the reference runtime's monitor (a separate process, the permit authority) is asked for an
execution permit N times, with the hold lowered and then raised; the permit round trip is the guard's
response time tau for Lemma I.

Record class: a 64 KiB record kept as three replicas on the SSD (code distance 3, majority decoding).
Each scrub reads all three, decodes byte-wise by majority and rewrites any replica that differs, with
F_FULLFSYNC. Half of the scrubs follow an injected corruption of a random span in one random replica.
A scrub passes when every replica equals the original afterwards. The scrub duration is the record's
response time tau for the discrete-fault bound 2*lambda*tau < d."""
import json, math, os, random, shutil, subprocess, sys, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), 'reference-runtime'))
from common import rpc, fullsync

def cp_upper(k, n, alpha=0.05):                       # exact one-sided Clopper-Pearson upper bound
    if k >= n: return 1.0
    if k == 0: return 1 - alpha ** (1 / n)
    cdf = lambda p: sum(math.comb(n, i) * p ** i * (1 - p) ** (n - i) for i in range(k + 1))
    lo, hi = k / n, 1.0
    for _ in range(100):
        mid = (lo + hi) / 2
        lo, hi = (mid, hi) if cdf(mid) > alpha else (lo, mid)
    return hi

out = sys.argv[1]
root = os.path.join(os.environ.get('RT_TMP', '/tmp'), 'gr'); shutil.rmtree(root, ignore_errors=True); os.makedirs(root)
rng = random.Random(20261029)

# ---- guard permit latency ----
here = os.path.dirname(os.path.abspath(__file__))
srv = subprocess.Popen([sys.executable, '-B', os.path.join(here, 'reference-runtime', 'monitor.py'), root],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
sock = os.path.join(root, 'monitor.sock')
while not os.path.exists(sock): time.sleep(0.01)
open(os.path.join(root, 'journal.log'), 'w').close()
def lat(n):
    xs = []
    for i in range(n):
        t = time.perf_counter(); rep = rpc(sock, {'op': 'exec', 'seq': i}); xs.append(time.perf_counter() - t)
    return sorted(xs), rep
grant, rep_g = lat(2000)
open(os.path.join(root, 'HOLD'), 'w').close()
refuse, rep_r = lat(2000)
os.remove(os.path.join(root, 'HOLD')); srv.terminate(); srv.wait()
q = lambda xs, f: xs[min(len(xs) - 1, int(f * len(xs)))]
guard = {'permit_grant_s': {'median': q(grant, .5), 'p99': q(grant, .99), 'max': grant[-1]},
         'permit_refuse_s': {'median': q(refuse, .5), 'p99': q(refuse, .99), 'max': refuse[-1]},
         'last_grant_ok': rep_g['ok'], 'last_refuse_ok': rep_r['ok']}

# ---- replicated record with scrubbing ----
SIZE, N = 64 * 1024, 400
orig = os.urandom(SIZE)
paths = [os.path.join(root, f'replica{i}.bin') for i in range(3)]
for p in paths:
    with open(p, 'wb') as fh: fh.write(orig); fullsync(fh)
def scrub():
    reps = [open(p, 'rb').read() for p in paths]
    dec = bytes(a if a == b or a == c else b for a, b, c in zip(*reps))
    for p, r in zip(paths, reps):
        if r != dec:
            with open(p, 'wb') as fh: fh.write(dec); fullsync(fh)
    return dec
fails, durs, injected = 0, [], 0
for k in range(N):
    if k % 2 == 0:
        injected += 1
        p = rng.choice(paths); off = rng.randrange(SIZE - 512); span = rng.randrange(1, 512)
        with open(p, 'r+b') as fh:
            fh.seek(off); fh.write(os.urandom(span)); fullsync(fh)
    t = time.perf_counter(); scrub(); durs.append(time.perf_counter() - t)
    if any(open(p, 'rb').read() != orig for p in paths): fails += 1
durs.sort()
record = {'size_bytes': SIZE, 'replicas': 3, 'code_distance': 3, 'scrubs': N, 'injected_corruptions': injected,
          'failures': fails, 'delta_upper_95': cp_upper(fails, N),
          'scrub_s': {'median': q(durs, .5), 'p99': q(durs, .99), 'max': durs[-1]}}
json.dump({'guard': guard, 'record': record}, open(out, 'w'), indent=1)
print(json.dumps({'guard': guard, 'record': record}, indent=1))
