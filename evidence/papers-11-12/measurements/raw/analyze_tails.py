"""Compute latency-tail statistics from a collect_tails.py JSONL record (Python 3.9, deterministic).
Per path: samples, failures, p50, p90, p99, p99.9 (nearest-rank), max; and the date length P-LAT then needs:
delta >= 1024 * (worst sample + worst durable commit), with no slack and with tenfold slack."""
import json, math, sys
from collections import defaultdict
sys.dont_write_bytecode = True
rows = [json.loads(l) for l in open(sys.argv[1]) if l.strip()]
head, samples = rows[0], rows[1:]
by = defaultdict(list); fails = defaultdict(int)
for s in samples:
    if 'ms' in s: by[s['path']].append(s['ms'])
    else: fails[s['path']] += 1
def q(v, p): return v[max(0, math.ceil(p * len(v)) - 1)]
out = {'source': sys.argv[1], 'start_unix': head.get('start_unix'), 'paths': {}}
worst = 0.0
for path, v in sorted(by.items()):
    v.sort(); worst = max(worst, v[-1])
    out['paths'][path] = {'n': len(v), 'failures': fails[path], 'p50': q(v, .5), 'p90': q(v, .9), 'p99': q(v, .99),
                          'p999': q(v, .999), 'max': v[-1]}
durable_max_ms = 13.067833          # Codex's raw F_FULLFSYNC record
out['worst_ms'] = worst
out['delta_min_s'] = {'slack1': round(1024 * (worst + durable_max_ms) / 1000, 1),
                      'slack10': round(10 * 1024 * (worst + durable_max_ms) / 1000, 1)}
out['last_sample_unix'] = samples[-1]['unix'] if samples else None
print(json.dumps(out, indent=1))
