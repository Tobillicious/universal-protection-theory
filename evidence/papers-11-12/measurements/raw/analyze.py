"""Compute every reported figure from a raw collector record (collect.py output). Python 3.9, deterministic.
Usage: python3 analyze.py outputs/raw-*.json
Clock drift bound: for every pair of readings i < j, |offset_j - offset_i| + err_i + err_j over (t_j - t_i);
the reported bound is the SMALLEST such pair-bound over the longest interval (conservative: it counts both error bars).
P-LAT lower bound on the date length: delta >= 1024 * (worst observed RTT + worst durable commit) * slack."""
import json, re, statistics, sys
sys.dont_write_bytecode = True
raw = json.load(open(sys.argv[1]))
out = {'source': sys.argv[1], 'start_utc': raw['start_utc'], 'paths': {}}
worst = 0.0
for name, d in raw['rtt'].items():
    ms = sorted(s['ms'] for s in d['samples'] if 'ms' in s); fails = sum('error' in s for s in d['samples'])
    ips = sorted({s['ip'] for s in d['samples'] if 'ip' in s})
    p95 = ms[min(len(ms) - 1, int(round(0.95 * (len(ms) - 1))))] if ms else None
    out['paths'][name] = {'host': d['host'], 'ips': ips, 'n': len(ms), 'failures': fails, 'min_ms': ms[0] if ms else None,
                          'median_ms': round(statistics.median(ms), 3) if ms else None, 'p95_ms': p95,
                          'max_ms': ms[-1] if ms else None}
    if ms: worst = max(worst, ms[-1])
pts = []
for r in raw['sntp']:
    m = re.match(r'\s*([+-][0-9.]+)\s+\+/-\s+([0-9.]+)', r['stdout'].strip().splitlines()[-1] if r['stdout'].strip() else '')
    if m: pts.append((r['unix'], float(m.group(1)), float(m.group(2))))
out['clock_readings'] = [{'unix': t, 'offset_s': o, 'err_s': e} for t, o, e in pts]
if len(pts) >= 2:
    (t0, o0, e0), (t1, o1, e1) = pts[0], pts[-1]
    bound = (abs(o1 - o0) + e0 + e1) / (t1 - t0); point = (o1 - o0) / (t1 - t0)
    out['clock_drift'] = {'interval_s': round(t1 - t0, 3), 'point_ppm': round(point * 1e6, 3),
                          'bound_ppm': round(bound * 1e6, 3), 'allowed_ppm': round(1e6 / 1024, 3),
                          'pass': bound < 1 / 1024}
durable_max_ms = 13.067833                                 # Codex's raw F_FULLFSYNC record, durable-fullsync-2026-10-21.json
out['worst_rtt_ms'] = worst
for slack in (1, 10):
    out[f'delta_min_s_slack{slack}'] = round(1024 * (worst + durable_max_ms) / 1000 * slack, 1)
print(json.dumps(out, indent=1))
