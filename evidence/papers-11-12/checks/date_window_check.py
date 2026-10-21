"""Which model-date lengths the saved timing record and the site-fault boundary jointly admit (Claude, 22 Oct 2026).

Exact Fractions and integer powers; Python 3.9 standard library. Inputs, all already in this package:
- the saved one-hour connection record (measurements/raw/outputs/tails-*.jsonl): every successful sample, all six paths;
- the saved F_FULLFSYNC record's maximum (measurements/outputs/durable-fullsync-2026-10-21.json);
- P-LAT's 1/1024-date timeout and the tenfold slack used in Codex's N5 repair;
- PF.4-PF.8's conversion and ledger boundary (paper-11/rung4-gates/check_physical.py): a per-site annual rate a gives a
  32-date window probability 1-(1-a)^(32 d / 365), d the date in days, which must not exceed p* = 0.002384;
- PF's inherited illustrative rates: 1.36% (2025 drive fleet), 2-4% common, 13% outlier.
FLOOR: delta >= 10 * 1024 * (largest successful connect + largest flush). CEILING: fits(a, delta), which is monotone:
it holds for every shorter date once it holds for one. So a date is admissible at rate a exactly when fits(a, FLOOR).
Scope: the same conditional arithmetic as PF.3-PF.8. It converts only the site-level fault input; it certifies no
joint fault or timing law, no P-LAT/P-LOCK/P-START, and no rare tail. Timed-out samples are counted, not bounded.
"""
from fractions import Fraction as F
from pathlib import Path
import glob, json, sys

ROOT = Path(__file__).resolve().parent.parent
DAY = 86400
PSTAR = F(2384, 10**6)


def fits(a, days):
    """(1-a)^(32 d) >= (1-p*)^365 with d = n/m days, as (1-a)^(32 n) >= (1-p*)^(365 m): exact."""
    n, m = days.numerator, days.denominator
    return (1 - a) ** (32 * n) >= (1 - PSTAR) ** (365 * m)


def main():
    tails = sorted(glob.glob(str(ROOT / 'measurements/raw/outputs/tails-*.jsonl')))
    assert len(tails) == 1
    ok, timeouts, paths = [], 0, set()
    with open(tails[0]) as fh:
        header = json.loads(fh.readline())
        for line in fh:
            row = json.loads(line, parse_float=F)
            paths.add(row['path'])
            if 'error' in row:
                timeouts += 1
            else:
                ok.append(F(row['ms']))
    assert header['duration_s'] == 3600.0 and len(paths) == 6
    durable = json.loads((ROOT / 'measurements/outputs/durable-fullsync-2026-10-21.json').read_text())['durable']
    flush_ms = F(max(durable['duration_ns']), 10**6)
    assert flush_ms == F('13.067833')
    floor_s = 10 * 1024 * (max(ok) + flush_ms) / 1000
    assert floor_s == F('74667.49780992')         # exact; Codex N5 rounds it to 7,466.749781 s before the tenfold
    floor_d = floor_s / DAY

    lo, hi = F(108, 125), F(7, 8)                 # 20.736 h <= FLOOR <= 21 h, small exact brackets
    assert lo <= floor_d <= hi
    rates = {'1.36%': F(136, 10**4), '2%': F(2, 100), '3%': F(3, 100), '3.2%': F(32, 1000), '4%': F(4, 100),
             '13%': F(13, 100)}
    admissible = {k: fits(a, hi) for k, a in rates.items()}       # True: every date in [FLOOR, 21 h] is admitted
    refused = {k: not fits(a, lo) for k, a in rates.items()}      # True: no date at or above FLOOR is admitted
    # Ceilings at the two inherited central rates, bracketed to the hour.
    ceil_bb = fits(rates['1.36%'], F(47, 24)) and not fits(rates['1.36%'], F(2))
    ceil_2 = fits(rates['2%'], F(4, 3)) and not fits(rates['2%'], F(11, 8))
    ceil_4 = fits(rates['4%'], F(2, 3))           # the inherited 16-hour figure is the 4% ceiling
    assert admissible == {'1.36%': True, '2%': True, '3%': True, '3.2%': False, '4%': False, '13%': False}
    assert refused == {'1.36%': False, '2%': False, '3%': False, '3.2%': True, '4%': True, '13%': True}
    assert ceil_bb and ceil_2 and ceil_4 and not fits(rates['4%'], lo)

    if len(sys.argv) > 1:
        claim = {'sixteen_hours_clears_the_measured_floor': F(2, 3) >= floor_d,
                 'a_date_is_admissible_at_four_percent': not refused['4%']}[sys.argv[1]]
        print(json.dumps({'claim': sys.argv[1], 'accepted': claim}, sort_keys=True))
        return 0 if claim else 1
    print(json.dumps({
        'successful_samples': len(ok), 'timed_out_samples_counted_not_bounded': timeouts, 'paths': len(paths),
        'largest_connect_ms': str(max(ok)), 'largest_flush_ms': str(flush_ms),
        'floor_seconds': str(floor_s), 'floor_bracket_hours': ['20.736', '21'],
        'admissible_date_exists_in_floor_to_21h': admissible,
        'no_admissible_date_at_or_above_floor': refused,
        'ceiling_hours': {'1.36%': 'between 47 and 48', '2%': 'between 32 and 33', '4%': 'at least 16, below the floor'},
        'scope': 'conditional PF arithmetic for the site-fault input only; no joint law, timing premise or rare tail certified'},
        sort_keys=True, indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
