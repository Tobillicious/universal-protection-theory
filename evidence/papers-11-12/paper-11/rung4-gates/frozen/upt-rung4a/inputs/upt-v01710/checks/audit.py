"""Independent exact checks of the GLM 0b proposal; no author 'PASS' is evidence."""
from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal, localcontext, ROUND_FLOOR
from itertools import combinations
from math import comb
import hashlib, json, sys
sys.dont_write_bytecode = True
ROOT = Path(__file__).resolve().parents[1]
BANNED = ('score', 'verify', 'review-', 'known-seams', 'handoff')


def safe(p):
    p = Path(p)
    assert p.is_absolute() and '..' not in p.parts
    for q in (p, *p.parents):
        assert not q.name.lower().startswith('calibration-')
        assert not any(b in q.name.lower() for b in BANNED), str(q)
        assert not q.is_symlink(), str(q)
    return p


def sha(p):
    return hashlib.sha256(safe(p).read_bytes()).hexdigest()


def encode(x):
    if isinstance(x, F):
        with localcontext() as ctx:
            ctx.prec = 18
            ctx.rounding = ROUND_FLOOR
            d = str(Decimal(x.numerator) / Decimal(x.denominator))
        return {'numerator': str(x.numerator), 'denominator': str(x.denominator),
                'decimal_floor': d}
    if isinstance(x, dict):
        return {k: encode(v) for k, v in x.items()}
    if isinstance(x, (list, tuple)):
        return [encode(v) for v in x]
    assert x is None or isinstance(x, (str, bool, int)), type(x)
    return x


def source_check(originals=False):
    meta = json.loads(safe(ROOT / 'INPUTS.json').read_text())
    for r in meta['author_files']:
        assert sha(ROOT / r['copy']) == r['sha256']
        if originals:
            assert sha(Path(r['source'])) == r['sha256']
    bank = meta['prior_bank']
    p = ROOT / bank['copy']
    assert sha(p / 'SHA256SUMS') == bank['manifest_sha256']
    rows = safe(p / 'SHA256SUMS').read_text().splitlines()
    assert len(rows) == bank['bound_files'] == 367
    for row in rows:
        h, rel = row.split('  ', 1)
        assert not Path(rel).is_absolute() and '..' not in Path(rel).parts
        assert sha(p / rel) == h
        if originals:
            assert sha(Path(bank['source']) / rel) == h
    if originals:
        assert sha(Path(bank['source']) / 'SHA256SUMS') == bank['manifest_sha256']
    return {'author_files_unchanged': 4, 'predecessor_bound_files_unchanged': 367}


def decode(x):
    if isinstance(x, dict):
        if set(x) >= {'numerator', 'denominator'}:
            return F(int(x['numerator']), int(x['denominator']))
        # JW2.7 uses numerator/denominator with optional labels.
        if 'exact' in x and isinstance(x['exact'], str) and '/' in x['exact']:
            return F(x['exact'])
        return {k: decode(v) for k, v in x.items()}
    if isinstance(x, list):
        return [decode(v) for v in x]
    return x


def poly_mod(x, p):
    while x.bit_length() >= p.bit_length():
        x ^= p << (x.bit_length() - p.bit_length())
    return x


def poly_gcd(x, y):
    while y:
        x, y = y, poly_mod(x, y)
    return x


def mul(x, y):
    r = 0
    while y:
        if y & 1:
            r ^= x
        x <<= 1
        y >>= 1
    return poly_mod(r, 0x1100b)


def power(x, n):
    r = 1
    while n:
        if n & 1:
            r = mul(r, x)
        x = mul(x, x)
        n >>= 1
    return r


def calculate():
    source_check()
    N, T, k = 400, F(64), 2
    p, eps, fm, tau = F(5856, 5), F(1, 8192), F(3, 2), F(1)
    rate, cost = eps * N * p, fm * p * tau
    budget = T * rate
    assert cost == F(8784, 5) and rate == F(915, 16) and budget == 3660
    assert budget // cost == 2
    critical = (k + 1) * fm * tau / (N * T)
    assert critical == F(9, 51200)
    assert budget // (cost / 8) == 16
    assert (F(1, 5120) * N * p * T) // cost == 3
    assert (2 * budget) // cost == 4

    # Exact enumeration, independent of GLM's order-statistic formula.
    foreign = N - 1
    pairs = list(combinations(range(1, foreign + 1), 2))
    mean = F(sum(max(a, b) for a, b in pairs), len(pairs))
    assert len(pairs) == 79401 and mean == F(800, 3)
    probes = 4 * 4
    early = F(sum(b <= probes for a, b in pairs), len(pairs))
    blind = F(1, comb(foreign, 2))
    assert early == F(comb(probes, 2), comb(foreign, 2)) == 120 * blind
    assert blind > F(1, 10**7) and early > 0
    assert mean / 4 > 4
    formula_in_prose = F(2 * (N + 1), 3)
    assert formula_in_prose - mean == F(2, 3)

    # Rabin's irreducibility test in GF(2)[X]: degree 16 has sole prime divisor 2.
    x = 2
    xp = x
    powers = {}
    for i in range(1, 17):
        xp = mul(xp, xp)
        powers[i] = xp
    assert powers[16] == x
    assert poly_gcd(powers[8] ^ x, 0x1100b) == 1
    determinants = []
    for a, b in combinations(range(1, 6), 2):
        det = mul(mul(a, b), a ^ b)
        assert det and mul(det, power(det, 65534)) == 1
        determinants.append(det)
    # An invertible coefficient matrix gives one (a,b) for each proposed secret
    # and observation pair: with uniform coefficients, two shares reveal no secret.
    assert 2 * 202 - 400 == 4 and 4 - k == 2

    # Even the STRONGER arrival claim "at most 2 in EVERY rolling 64 dates"
    # does not cap outstanding losses without onset-to-clearance lifetime.
    arrivals = [F(0), F(40), F(80)]
    assert all(sum(t0 < t <= t0 + 64 for t in arrivals) <= 2
               for t0 in [a - 64 for a in arrivals] + arrivals)
    at80 = sum(t <= 80 for t in arrivals)  # none has stably returned by 80
    assert at80 == 3
    assert 2 * cost <= budget

    # Correct conditional arrival-envelope lemma:
    # all losses live at most L from onset; attack onsets in any window L
    # have count * cost <= B + rate*L. Other outstanding causes <= other.
    # Then outstanding <= floor((B + rate*L)/cost) + other.
    def cap(L, B=F(0), other=0):
        return (B + rate * L) // cost + other
    max_lifetime = (k + 1) * cost / rate
    physical_delay_limit = max_lifetime - 64
    stock_limit = (k + 1) * cost - budget
    assert max_lifetime == F(2304, 25)
    assert physical_delay_limit == F(704, 25)
    assert stock_limit == F(8052, 5)
    assert cap(64) == 2 and cap(max_lifetime) == 3
    assert cap(64, stock_limit) == 3
    assert cap(64, other=1) == 3
    assert cap(64, F(0), 0) == 2

    return {
        'scope': 'Independent GLM 0b audit followed by local v0.17.10 integration',
        'full_GLM_0b_claim_established': False,
        'rung4_established': False,
        'arithmetic': {
            'disablement_cost': cost, 'coalition_inflow_per_date': rate,
            '64_date_budget': budget, 'budget_upper_bound_disablement_count': 2,
            'critical_share_strict': critical, 'parameter_share': eps,
            'tau_one_eighth_count_upper_bound': 16,
            'control_share_named_double': F(1, 5120),
            'actual_control_multiplier': F(8, 5),
            'true_doubled_share': 2 * eps, 'true_doubled_count_upper_bound': 4},
        'search': {
            'foreign_candidates': foreign, 'unordered_pairs': len(pairs),
            'expected_distinct_probes': mean, 'expected_search_dates_at_four': mean / 4,
            'prose_formula_error_probes': formula_in_prose - mean,
            'probes_per_redraw_window': probes, 'both_found_by_window': early,
            'single_blind_home_plus_two_hit': blind,
            'probe_success_to_blind_pair_ratio': 120,
            'single_blind_hit_to_entire_common_budget_ratio': blind / F(1, 10**7),
            'strict_parity_variant_blind_hit': F(1, comb(199, 2)),
            'probe_success_requires_recognizable_probes': True,
            'expected_time_implies_impossibility': False,
            'full_search_dates_at_600_probes_per_date': F(399, 600),
            'one_sided_author_rounding_test_accepts_probability_one_half': F(126, 10**7) - F(1, 2) < F(1, 10**8),
            'worst_case_lifetime_union_without_attempt_bound': 1},
        'algebra': {'GF16_polynomial_irreducible': True,
                    'nonzero_share_determinants': determinants,
                    'quorum_intersection': 4, 'honest_intersection_at_cap_two': 2,
                    'consensus_liveness_proved_by_intersection': False},
        'rolling_counterexample': {
            'arrival_dates': arrivals, 'max_arrivals_per_rolling64': 2,
            'uncleared_at_date80': at80,
            'JW26_64_dates_begin_after_stable_return': True,
            'bounded_time_to_physical_return_supplied': False},
        'corrected_conditional_lemma': {
            'assumptions': [
                'Certified maximum loss lifetime L from onset, including detection, physical outage and reseed',
                'Every rolling interval of length L admits attack count A with A*E_min <= B+r*L',
                'B bounds stored energy, prepaid work, tools and borrowed capability translated to this envelope',
                'All other simultaneously outstanding whole-island causes have reserved cap F_other',
                'No double counting of one prepaid cost across episodes; no uncharged persistent loss'],
            'bound': 'unavailable <= floor((B+r*L)/E_min) + F_other',
            'strict_test': 'B+r*L < (k-F_other+1)*E_min',
            'onset_to_clearance64_cap_no_other_causes': cap(64),
            'strict_maximum_lifetime': max_lifetime,
            'strict_maximum_physical_delay_if_reseed64': physical_delay_limit,
            'strict_maximum_stock_at_lifetime64': stock_limit,
            'one_other_loss_at_GLM_point_total_cap': cap(64, other=1),
            'available_primitive_evidence_for_these_assumptions': False},
        'physical_cost_countermodel': {
            'actuation_cost': p / 100, 'plant_one_date_envelope': p,
            'energy_conserved': True,
            'construction': 'Opening model supply switches stops execution; unused input is stored or dissipated. Actuation energy becomes heat.',
            'purpose': 'Logical countermodel to deriving a matched-draw lower bound from conservation alone; not a measured attack price'},
        'verdicts': {
            'energy_budget_arithmetic': 'PASS, as a count upper bound under a charged-cost envelope',
            'full_unavailability_derivation': 'FAIL: arrival bound is not an outstanding-loss bound',
            'physics_only_cost_floor': 'FAIL: A4 remains an additional empirical/architectural premise',
            'expected_search_race': 'FAIL: expectation does not exclude early success',
            'blind_pair_probability': 'PASS for the stated ideal single attempt; FAIL as a funded horizon account',
            'share_algebra_and_quorum_intersection': 'PASS under the stated exposure/cap contracts',
            'secret_placement_as_JW26_fact': 'FAIL: JW26 is public adjacent; JW27 prices a conditional capacity candidate',
            'all_cause_loss_cap': 'FAIL: ordinary losses and false isolation need the same joint allowance',
            'unit_rescaling': 'PASS for a consistent change of units, not a new temporal law',
            'global_composition_and_rung4': 'OPEN: no priced secrecy realization or phase/twilight certificate'}}


def control(name):
    d = calculate()
    a, s, c = d['arithmetic'], d['search'], d['corrected_conditional_lemma']
    claims = {
        'expectation_excludes_early_success': s['both_found_by_window'] == 0,
        'sixteen_probes_equal_one_blind_pair': s['both_found_by_window'] <= s['single_blind_home_plus_two_hit'],
        'blind_hit_fits_common_budget': s['single_blind_home_plus_two_hit'] <= F(1, 10**7),
        'arrival_cap_is_outstanding_cap': d['rolling_counterexample']['uncleared_at_date80'] <= 2,
        'energy_conservation_implies_draw_floor': d['physical_cost_countermodel']['actuation_cost'] >= d['physical_cost_countermodel']['plant_one_date_envelope'],
        'one_over5120_is_double_one_over8192': F(1, 5120) == 2 * F(1, 8192),
        'one_other_loss_fits_same_cap': c['one_other_loss_at_GLM_point_total_cap'] <= 2,
        'critical_lifetime_boundary_is_safe': (F(915, 16) * c['strict_maximum_lifetime']) // F(8784, 5) <= 2,
        'strict_parity_has399_foreign_candidates': s['strict_parity_variant_blind_hit'] == s['single_blind_home_plus_two_hit']}
    claims['one_sided_rounding_test_is_sound'] = not s['one_sided_author_rounding_test_accepts_probability_one_half']
    claims['two_member_intersection_survives_two_bad'] = 2 - 2 > 0
    assert name in claims
    print(json.dumps({'claim': name, 'holds': claims[name]}, sort_keys=True))
    return 0 if claims[name] else 1


if __name__ == '__main__':
    if len(sys.argv) == 3 and sys.argv[1] == '--claim':
        sys.exit(control(sys.argv[2]))
    assert not sys.argv[1:]
    print(json.dumps(encode(calculate()), sort_keys=True, indent=2))
