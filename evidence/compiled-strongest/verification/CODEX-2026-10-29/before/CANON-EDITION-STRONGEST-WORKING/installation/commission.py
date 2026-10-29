"""Commissioning checker for a Universal Protection Theory installation.

usage: python3 commission.py params.json [report.md]

An installation fills params.json with its measured values. Each check below is the hypothesis of a
compiled theorem; the checker evaluates it on the measured values and reports PASS, FAIL or NOT MEASURED.
NOT MEASURED is never counted as a pass: an installation is commissioned only when every check passes.

Every threshold is the theorem's own; the only inputs are measurements and declared design values.
"""
import json, math, sys

R0 = 376.730313668  # impedance of free space, ohm
GROUP = {}           # check name -> requirement it serves; alternative sufficient tests share one

def get(p, path):
    cur = p
    for k in path.split('.'):
        if not isinstance(cur, dict) or cur.get(k) is None: return None
        cur = cur[k]
    return cur

def check(name, theorem, need, fn):
    """need: dotted parameter paths; fn: callable on their values returning (ok, detail)."""
    def run(p):
        vals = [get(p, n) for n in need]
        missing = [n for n, v in zip(need, vals) if v is None]
        if missing: return name, theorem, 'NOT MEASURED', 'missing: ' + ', '.join(missing)
        ok, detail = fn(*vals)
        return name, theorem, 'PASS' if ok else 'FAIL', detail
    return run

# ---- harm classes: exclusion radius from the total meter (ChannelMeter, ExclusionRadius) ----
def radiated_radius(M, G, S_limit):
    """Far field: all metered power M radiated with directive gain G gives power density
    G M / (4 pi r^2); it is below S_limit for r >= sqrt(G M / (4 pi S_limit)) (n = 2)."""
    return math.sqrt(G * M / (4 * math.pi * S_limit))

def harm_class_checks(p):
    out = []
    classes = p.get('harm_classes')
    if not isinstance(classes, list):
        classes = json.load(open(__file__.replace('commission.py', 'HARM-CLASSES.json')))['harm_classes']
    for hc in classes:
        name = f"harm class: {hc['name']}"
        GROUP[name] = 'harm: ' + hc.get('group', hc['name'])
        kind = hc.get('kind')
        if kind == 'radiated':
            S = hc['S_limit_W_m2'] if 'S_limit_W_m2' in hc else hc['E_limit_V_m'] ** 2 / R0
            def fn(M, G, r_zone, S=S, hc=hc):
                r = radiated_radius(M, G, S)
                return r_zone >= r, (f"r* = {r:.3g} m (M = {M} W, gain {G}, threshold {S:.4g} W/m^2, "
                                     f"{hc['source']}); exclusion zone {r_zone} m")
            out.append(check(name, 'ChannelMeter.every_channel_excluded; ExclusionRadius.exclusion_radius',
                             [hc.get('meter', 'meter.M_W'), 'design.max_directive_gain', f"zones.{hc['zone']}"],
                             fn))
        elif kind == 'photon_energy':
            def fn(V, E_pen=hc['E_penetrate_eV'], hc=hc):
                return V < E_pen, (f"maximum photon energy e*V = {V} eV (Duane-Hunt) < {E_pen} eV, "
                                   f"{hc['source']}")
            out.append(check(name, 'physical bound (Duane-Hunt law)', ['design.max_internal_voltage_V'], fn))
        elif kind == 'dipole':
            def fn(B_ref, r_ref, r_zone, hc=hc):
                r = r_ref * (B_ref / hc['B_limit_T']) ** (1 / 3)
                return r_zone >= r, (f"r* = {r:.3g} m from B = {B_ref} T at {r_ref} m (inverse cube; "
                                     f"{hc['source']}); exclusion zone {r_zone} m")
            out.append(check(name, 'ExclusionRadius (n = 3)', [f"measured.{hc['measurement']}.B_T",
                       f"measured.{hc['measurement']}.r_m", f"zones.{hc['zone']}"], fn))
        elif kind == 'certified_sar':
            def fn(sar, src, hc=hc):
                return sar <= hc['limit_W_kg'], (f"SAR {sar} W/kg at contact <= {hc['limit_W_kg']} W/kg "
                                                 f"({hc['source']}; device report: {src})")
            out.append(check(name, 'ChannelMeter (per-channel measured bound, contact range)',
                             [f"measured.{hc['measurement']}.W_kg", f"measured.{hc['measurement']}.source"], fn))
        elif kind == 'coupling':
            def fn(kappa, P_rx, G_max, hc=hc):
                return kappa * P_rx <= G_max, f"kappa * P = {kappa * P_rx:.3g} vs Gamma_max {G_max}"
            out.append(check(name, 'ExclusionRadius.received_effect_bound',
                             [f"measured.{hc['measurement']}.kappa", f"measured.{hc['measurement']}.P_rx_W",
                              f"measured.{hc['measurement']}.Gamma_max"], fn))
    return out

CHECKS = [
    check('meter: total emission bounded by the meter', 'ChannelMeter.channel_le_meter',
          ['meter.M_W', 'meter.measured_max_W'],
          lambda M, m: (m <= M, f"measured maximum {m} W <= declared meter bound {M} W")),
    check('founding threshold r = C(1-eps)/H > 1 (lower confidence bound)', 'Theorem NP; NarrowPlace',
          ['keepers.C', 'keepers.eps_upper', 'keepers.H'],
          lambda C, e, H: (C * (1 - e) / H > 1, f"r_lower = {C * (1 - e) / H:.4g}")),
    check('holding failure, independent keepers', 'NarrowPlace.np_splitting_bound',
          ['keepers.n', 'keepers.C', 'keepers.eps_upper', 'keepers.H', 'budget.phi'],
          lambda n, C, e, H, phi: (1 - e - H / C > 0 and math.exp(-2 * n * (1 - e - H / C) ** 2) <= phi,
                                   f"exp(-2n delta^2) = {math.exp(-2 * n * max(0, 1 - e - H / C) ** 2):.3g} "
                                   f"<= phi = {phi}")),
    check('holding failure, any joint law of keepers', 'CorrelatedHolding.random_threat_correlated',
          ['keepers.C', 'keepers.eps_upper', 'keepers.H', 'keepers.eta_H', 'budget.phi_correlated'],
          lambda C, e, H, eH, phi: (H < C and eH + e / (1 - H / C) <= phi,
                                    f"eta_H + eps/(1-H/C) = {eH + e / (1 - H / C):.3g} <= {phi}")),
    check('round-trip interception before the deadline', 'ReachTiming.round_trip_in_time',
          ['guards.rho_m', 'guards.signal_speed_m_s', 'guards.response_s', 'guards.deadline_s'],
          lambda rho, cs, tau, d: (rho <= cs * (d - tau) / 2,
                                   f"rho = {rho} m <= c_s(d - tau)/2 = {cs * (d - tau) / 2:.4g} m")),
    check('wavefront at least as fast as the domain', 'OuterLane.wavefront_coverage',
          ['guards.v_m_s', 'guards.domain_speed_m_s'],
          lambda v, c: (c <= v, f"c = {c} <= v = {v}")),
    check('hold interval (continuous perturbation)', 'Bridge.qsl_within_radius',
          ['records.eps', 'records.W_J', 'records.Delta_s', 'records.r_dec'],
          lambda e, W, D, r: (e + W / 1.054571817e-34 * D <= r, f"eps + (W/hbar)Delta = {e + W / 1.054571817e-34 * D:.3g} <= r_dec = {r}")),
    check('hold interval (discrete faults)', 'Bridge.headroom_within_radius',
          ['records.lambda_per_s', 'records.tau_s', 'records.code_distance'],
          lambda l, t, d: (2 * l * t < d, f"2 lambda tau = {2 * l * t:.3g} < d = {d}")),
    check('hosted minds: no effect lands while held', 'UPTFence.raise_then_nothing_lands',
          ['measured.hold_campaign.landings_while_held', 'measured.hold_campaign.trials'],
          lambda k, n: (k == 0, f"{k} effects landed inside {n} randomised hold windows")),
    check('hosted minds: hold interval Delta', 'HoldCommonAction.hold_is_common_viable_action',
          ['measured.hold_campaign.tau_max_s', 'design.hold_interval_bound_s'],
          lambda t, b: (t <= b, f"measured tau_max = {t:.4g} s <= declared Delta = {b} s")),
    check('itemised accounts within the declared budget', 'ItemisedRisk.itemised_risk; OuterLane.outer_lane_risk',
          ['accounts', 'budget.total'],
          lambda a, B: (sum(x['delta_upper_95'] for x in a.values()) <= B,
                        ' + '.join(f"{k} {x['delta_upper_95']:.3g}" for k, x in a.items()) +
                        f" = {sum(x['delta_upper_95'] for x in a.values()):.3g} <= {B}")),
    check('funding: endowment covers the growing bill', 'GrowingBill.endowment_suffices',
          ['funding.bill_coeffs', 'funding.r_min', 'funding.endowment'],
          lambda c, r, E: (lambda es: (es <= E, f"e* = {es:.4g} <= endowment {E}"))(
              sum(sum(a * t ** i for i, a in enumerate(c)) * (1 + r) ** -t for t in range(0, 20000)))),
    check('founding: anchor benefit exceeds pledge plus activation cost', 'FoundingAnchor.anchor_founds_iff',
          ['founding.anchor_benefit', 'founding.anchor_pledge', 'founding.activation_cost'],
          lambda b, c, a: (b > c + a, f"{b} > {c} + {a}")),
    check('founding coverage: every location within rho of a commissioned guard', 'FoundingCover.founded_reach',
          ['founding.guards_commissioned', 'founding.guards_required'],
          lambda g, r: (g >= r, f"{g} commissioned of {r} required")),
]

# alternative sufficient forms of one requirement
GROUP.update({
    'holding failure, independent keepers': 'holding failure within budget',
    'holding failure, any joint law of keepers': 'holding failure within budget',
    'hold interval (continuous perturbation)': 'records: hold interval',
    'hold interval (discrete faults)': 'records: hold interval',
})

def main():
    p = json.load(open(sys.argv[1]))
    rows = [c(p) for c in CHECKS] + [c(p) for c in harm_class_checks(p)]
    # a requirement passes when any of its sufficient tests passes; else FAIL if any test fails
    req = {}
    for n, t, st, d in rows: req.setdefault(GROUP.get(n, n), []).append(st)
    status = {g: 'PASS' if 'PASS' in v else ('FAIL' if 'FAIL' in v else 'NOT MEASURED') for g, v in req.items()}
    counts = {s: sum(v == s for v in status.values()) for s in ('PASS', 'FAIL', 'NOT MEASURED')}
    lines = [f"# Commissioning report: {p.get('installation', '?')}", '',
             f"Requirements: {counts['PASS']} PASS, {counts['FAIL']} FAIL, {counts['NOT MEASURED']} NOT MEASURED "
             f"of {len(status)}. Commissioned: {'YES' if counts['PASS'] == len(status) else 'NO'}.", '',
             '| Requirement | Status |', '|---|---|']
    lines += [f"| {g} | {v} |" for g, v in status.items()]
    lines += ['', f"Tests ({len(rows)}; alternative sufficient tests for one requirement share it):", '',
              '| Check | Theorem | Status | Detail |', '|---|---|---|---|']
    lines += [f"| {n} | `{t}` | {s} | {d} |" for n, t, s, d in rows]
    text = '\n'.join(lines) + '\n'
    print(text)
    if len(sys.argv) > 2: open(sys.argv[2], 'w').write(text)

if __name__ == '__main__':
    main()
