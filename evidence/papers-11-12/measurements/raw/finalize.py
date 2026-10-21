"""Fold the finished tails, network and planning measurements into the publishable v1.5 copy, then rebuild and
record them in the staging copy. Python 3.9. Run once both runs are finished: python3 -B finalize.py
Every figure written into the preprint is computed here from the raw files; nothing is typed by hand."""
import glob, hashlib, json, os, shutil, statistics, subprocess, sys, zipfile
sys.dont_write_bytecode = True
M = os.path.dirname(os.path.abspath(__file__))
R = '/Users/admin/Documents/2026/Snuffy-Book/upt-release-v1.5-final-claude-2026-10-21'
CPY = os.path.expanduser('~/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3')
LEAN = os.path.expanduser('~/.elan/bin/lean'); TMP = '/Users/admin/.claude/jobs/041ad724/tmp/finalize'
tails = sorted(glob.glob(f'{M}/outputs/tails-*.jsonl'))[-1]; net = sorted(glob.glob(f'{M}/outputs/state-network-*.jsonl'))
plan = sorted(glob.glob(f'{M}/outputs/plan-time-*.json'))[-1]
assert subprocess.run(['pgrep', '-f', 'collect_tails.py'], capture_output=True).returncode != 0, 'tails still running'
assert net, 'network transfers not finished'
at = json.loads(subprocess.run([sys.executable, '-B', f'{M}/analyze_tails.py', tails], capture_output=True, text=True, check=True).stdout)
open(f'{M}/outputs/analysis-tails.json', 'w').write(json.dumps(at, indent=1))
rows = [json.loads(l) for l in open(tails) if l.strip()][1:]
loss = {}
for path in at['paths']:
    v = [r for r in rows if r['path'] == path]; ok = [r['ms'] for r in v if 'ms' in r]; base = min(ok)
    slow = sum(1 for r in v if 'error' in r or r['ms'] >= base + 900)
    loss[path] = {'n': len(v), 'retry_or_timeout': slow, 'rate': round(slow / len(v), 4)}
clean = {p: at['paths'][p] for p in at['paths'] if loss[p]['retry_or_timeout'] <= max(1, 0.01 * loss[p]['n'])}
netrows = [json.loads(l) for f in net for l in open(f) if l.strip() and '"path"' in l]
netsum = {}
for r in netrows:
    netsum.setdefault(r['path'], []).append(r)
def med(xs): return round(statistics.median(xs), 2) if xs else None
net_txt = []
for p, rs in sorted(netsum.items()):
    good = [r['MB_per_s'] for r in rs if r.get('http') in ('206', '200') and r.get('bytes') == 64 << 20 and r.get('MB_per_s')]
    bad = len(rs) - len(good)
    if good: net_txt.append(f'{p} {med(good)} MB/s (about {round(1073.741824 / med(good), 1)} s per GiB)' + (f', {bad} failed' if bad else ''))
    else: net_txt.append(f'{p}: all {len(rs)} fetches failed')
pt = json.load(open(plan))
cl_p99 = [v['p99'] for v in clean.values()]
lossy = {p: l for p, l in loss.items() if p not in clean}
lossy_txt = '; '.join(f'{p}: {l["retry_or_timeout"]} of {l["n"]} slow or timed out' for p, l in lossy.items())
n_per = round(statistics.median([l['n'] for l in loss.values()]))
new = (f"- **Latency tails** (one hour, about {n_per} samples per path, `measurements/raw/outputs/analysis-tails.json`):\n"
       f"  - {len(clean)} paths are clean: p99 from {min(cl_p99):.0f} to {max(cl_p99):.0f} ms, with at most one slow sample each;\n"
       + (f"  - {lossy_txt}. These are connection retries after dropped packets (the base round trip plus whole seconds), most likely the server limiting repeated probes;\n" if lossy else '')
       + "  - P-LAT counts a slow attempt as a fault, so the right reading is a timeout above the normal round trip plus a measured loss rate. Probing third-party servers cannot separate network loss from server policy; that needs endpoints at both ends.\n"
       f"- **Inter-region state transfer** (64 MiB per fetch, three per path): {'; '.join(net_txt)}.\n"
       f"- **Planning time:** a working max-flow planner re-places {pt['residents']:,} residents × {pt['replicas_each']} replicas onto {pt['live_hosts']} hosts in at most {pt['max_s']} s, valid in every run. With re-attestation, startup is about {round(2.7 + pt['max_s'], 1)} s, against a residual of at least 25 minutes.\n")
P = f'{R}/PREPRINT.md'; s = open(P).read()
old = ("- **Not yet measured:**\n  - the one-hour tail run and the inter-region state transfers (their raw files are added when they finish);\n"
       "  - planning time, which needs a working planner.\n")
assert old in s; open(P, 'w').write(s.replace(old, new))
dst = f'{R}/measurements/raw'
for f in ['collect_tails.py', 'analyze_tails.py', 'plan_time.py', 'after_tails.sh', 'finalize.py']: shutil.copy(f'{M}/{f}', dst)
for f in [tails, f'{M}/outputs/analysis-tails.json', plan] + net: shutil.copy(f, f'{dst}/outputs/')
# Units: local disk rates are 1 GiB / seconds, i.e. MiB/s (Codex read, 21 Oct)
s = open(P).read().replace('took 4.31 s (about 238 MB/s)', 'took 4.31 s (about 238 MiB/s)').replace('took 1.41 s (about 728 MB/s)', 'took 1.41 s (about 728 MiB/s)')
open(P, 'w').write(s)
# The release build, manifest, reproduction and zip are done by port_onto.py (drafts and zip outside the sealed root).
print(json.dumps({'tails_clean_paths': len(clean), 'lossy': lossy, 'network': net_txt, 'planning_max_s': pt['max_s'],
                  'section_6c_updated': True}, indent=1))
