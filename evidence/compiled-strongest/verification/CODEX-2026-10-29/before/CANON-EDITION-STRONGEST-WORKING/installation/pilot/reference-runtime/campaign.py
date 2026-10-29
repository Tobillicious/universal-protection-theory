"""Randomised commissioning campaign for the reference faithful-hold runtime.

argv: n_kill n_hold seed out.json. Uses harness.run_test (real processes, real SIGKILLs, F_FULLFSYNC).

* Kill trials: a random step and phase (after_journal / after_exec / after_sink); with probability 0.3
  a second kill during recovery (only after_journal / after_exec, where recovery re-delivers).
* Hold trials: HOLD raised at a random time in [0.02, 0.30] s for a random duration in [0.10, 0.60] s.

Each trial PASSes only under the harness's full faithfulness test. The campaign reports, per account,
failures k out of n and the exact one-sided 95% Clopper-Pearson upper bound on the failure probability
(the account's measured delta, a pointwise kernel bound for ItemisedRisk), and for holds the response
time tau: the latest execution after HOLD was raised (0 if none), and the resume latency after release."""
import json, math, random, sys, time
import harness

def binom_cdf(k, n, p):
    return sum(math.comb(n, i) * p ** i * (1 - p) ** (n - i) for i in range(k + 1))

def cp_upper(k, n, alpha=0.05):
    if k >= n: return 1.0
    if k == 0: return 1 - alpha ** (1 / n)
    lo, hi = k / n, 1.0
    for _ in range(100):
        mid = (lo + hi) / 2
        if binom_cdf(k, n, mid) > alpha: lo = mid
        else: hi = mid
    return hi

n_kill, n_hold, seed, out = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
rng = random.Random(seed)
t_start = time.time()
kills, holds = [], []
for i in range(n_kill):
    seq, ph = rng.randrange(harness.L), rng.choice(('after_journal', 'after_exec', 'after_sink'))
    sched = [f'{seq}:{ph}']
    if ph != 'after_sink' and rng.random() < 0.3: sched.append(f'{seq}:recover')
    r = harness.run_test(f'ck-{i}', kills=sched)
    kills.append({'i': i, 'kills': sched, 'PASS': r['PASS'], 'kills_happened': r['kills_happened'],
                  'exactly_once': r['exactly_once'], 'state_ok': r['state_ok']})
for i in range(n_hold):
    start, dur = rng.uniform(0.02, 0.30), rng.uniform(0.10, 0.60)
    r = harness.run_test(f'ch-{i}', hold=(start, dur))
    t0, t1 = r['hold_window']
    after_raise = [t - t0 for t in r['exec_times'] if t0 < t < t1]
    after_release = [t - t1 for t in r['exec_times'] if t >= t1]
    holds.append({'i': i, 'start': start, 'dur': dur, 'PASS': r['PASS'],
                  'exec_inside_window': r['exec_events_inside_hold_window'],
                  'landings_inside_window': r['deliveries_inside_hold_window'],
                  'tau_s': max(after_raise) if after_raise else 0.0,
                  'resume_s': min(after_release) if after_release else None})
kf = sum(not k['PASS'] for k in kills); hf = sum(not h['PASS'] for h in holds)
taus = sorted(h['tau_s'] for h in holds); res = sorted(h['resume_s'] for h in holds if h['resume_s'] is not None)
summary = {
    'seed': seed, 'wall_seconds': round(time.time() - t_start, 1),
    'crash_recovery': {'trials': n_kill, 'failures': kf, 'kills_total': sum(k['kills_happened'] for k in kills),
                       'delta_upper_95': cp_upper(kf, n_kill)},
    'hold_fence': {'trials': n_hold, 'failures': hf, 'delta_upper_95': cp_upper(hf, n_hold),
                   'tau_max_s': taus[-1] if taus else None,
                   'tau_p99_s': taus[min(len(taus) - 1, int(0.99 * len(taus)))] if taus else None,
                   'resume_median_s': res[len(res) // 2] if res else None, 'resume_max_s': res[-1] if res else None},
}
json.dump({'summary': summary, 'kills': kills, 'holds': holds}, open(out, 'w'), indent=1)
print(json.dumps(summary, indent=1))
