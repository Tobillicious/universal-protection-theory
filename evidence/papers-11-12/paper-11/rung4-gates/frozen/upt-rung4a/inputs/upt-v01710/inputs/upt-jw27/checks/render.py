"""Render the bounded-prefix report from exact saved numeric evidence."""
from pathlib import Path
import json,hashlib,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]

def value(v):
    if isinstance(v,dict) and 'decimal_floor' in v:return v['decimal_floor']
    return str(v)

def render():
    d=json.loads((ROOT/'RESULTS.json').read_text())
    m=d['task1']['current_full_pool_margins']
    lines=[
        '# JW2.7 — narrow-place audit, partial ordered prefix',
        '',
        '20 October2026. **Rung4 is not established.** Tasks1 and2 were audited in order; both remain partial in the senses stated below. Tasks3–7 were not executed. Weekly usage was87% at entry and89% at the research stop. This is a replayable prefix under the budget instruction, building on the frozen JW2.6 conditional k=2 point.',
        '',
        '## Task1: what binds at the current point',
        '',
        'The deterministic island premise allows two still-counted losses, exactly the construction’s k=2. There is no integer spare beyond that premise. Among the listed resource capacities, energy has the smallest normalized headroom. Comparing a unit of memory with a date of latency has no intrinsic meaning; normalized utilization is the explicitly chosen resource comparison, not a universal protection metric.',
        '',
        '| Constraint | Use | Limit | Absolute headroom |',
        '|---|---:|---:|---:|',
    ]
    for name in ['energy','memory','interconnect','care_time','provider_time','checkpoint_lag','state_age','authentication','certificates']:
        r=m[name]
        lines.append('| %s | %s | %s | %s |'%(name,value(r['use']),value(r['limit']),value(r['absolute_headroom'])))
    pb=m['fault_rate_boundary'];pb21=m['fault_rate_boundary_at_2p1e_7_total']
    lines += [
        '',
        'Energy headroom is %s of guaranteed inflow (about0.0168%%). Provider headroom is about0.00289006 date. All ten inherited incentive rows remain positive.'%value(m['energy']['normalized_headroom']),
        '',
        'With all other JW2.6 premises fixed, the P-FAULT boundary for the10^-6 total budget is bracketed by **%s safe / %s failing**, width10^-15. This is about10.85%% headroom over.002. The older author value.002108 is conservative, not the boundary of this corrected k=2 account calculation. For a tighter total ceiling2.1e-7, the boundary is **%s safe / %s failing**. These p values are site unavailability over complete covered windows; they are not the whole-host job-shock q of task7.'%(value(pb['lower_safe']),value(pb['upper_fails']),value(pb21['lower_safe']),value(pb21['upper_fails'])),
        '',
        '### Four phases and missing data',
        '',
        'Define founding[0,t_F), growth[t_F,t_M), maturity[t_M,t_T), twilight[t_T,T_end]. No supplied source fixes those endpoints, the live pool/population trajectory, a numerical twilight reference, the phase budgets, or an outage-duration trajectory. They are unknown inputs, not zeros.',
        '',
        '| Phase | Applicable calculation / binding gap | Exposure and risk share |',
        '|---|---|---|',
        '| Founding | A seed is not a JW2.6 construction; key diversity, authority and post-outage capacity need a design | unspecified |',
        '| Growth | Completed400-island pools have the margins above; commissioning/transfer costs are absent | unspecified |',
        '| Maturity | Current conditional point; energy is the smallest normalized resource margin, and k is exactly at the premise cap | unspecified |',
        '| Twilight | No priced fade/threat trajectory; MN2 alone gives no strict numerical ordering | unspecified |',
        '',
        'Thus **the narrowest actual phase cannot be identified**. Founding is the first uncovered phase of the requested whole-life claim. Freezing the same full-pool plant and premises across phases gives equal margins, which fails the requested strict pre-twilight separation. A common equal proportional fade of capacity and living stock satisfies weak MN2 while preserving normalized margin; it does not establish strict separation.',
        '',
        'Necessary founding screens are already informative. At k=2, a3-island seed cannot provide five distinct share islands, an available honest-intersection quorum, or enough care slots. The quorum screen alone needs at least7 islands; the eight-slot care screen alone needs at least8. To retain JW2.6’s actual six-exile envelope, ceil(2064/(n-2))<=6 requires **n>=346**. At n=56 there are39 exiles/survivor. Passing these screens is not a founding implementation. A400-island fixed quorum and adjacent placements cannot silently be transplanted to smaller pools.',
        '',
        'The inherited21-account total with reserve remains **%s**. Removing the declared common10^-7 and base certificate reserve10^-7 leaves about6.4012e-9 of accounted risk against8e-7 of residual budget. Uniform bookkeeping would allocate common and base reserve10^-127 per island-date and residual budget8e-127 per island-date, multiplied by a phase exposure E. No actual E or complete per-phase allocation has been supplied. Such division does not decorrelate a common failure; a single common event can affect every phase. History-dependent bounds also require their own valid exposure cover before proportional allocation.'%value(d['baseline_with_reserve']),
        '',
        '## Task2: shorter windows are an additional temporal contract',
        '',
        'The inherited.002 law covers the date-level union of all relevant recovery windows, including completion overlaps. It does not say probability scales with window length. At an audited pre-window history, fresh independent per-site fault events of probability.002 can be concentrated in the intersection of a window and its half-length subwindow. Every subset at that history has probability.002^r, yet shortening the window retains the same event. Its duration can be short against both windows; a bounded start intensity is also needed. This is a comparison at one pre-window history, not a claim that known persistent faults remain fresh.002 trials at later histories. Faster repair alone therefore licenses **no reduction of inherited p**.',
        '',
        'The following sensitivity is conditional on a NEW complete-window subset law. For an illustrative one-date reference, window ratio w, maximum fault residence d, and n_w=ceil(1/w) windows forming a valid cover, assume p_w<=p_ref*(w+d)/(1+d). Here p_ref is a new reference envelope: a fault-start intensity bound lambda<=p_ref/(1+d), with a proved distinct-site law and bounded residence, can justify this upper bound. An observed upper bound on reference-window probability alone cannot be inverted to obtain the required upper bound on lambda. Matching calibration and a cover of all overlapping recoveries remain obligations. Neither this formula nor its window count follows from JW2.6. The table uses d=0; RESULTS.json also includes d=1/16,1/4,1.',
        '',
        '| w | Window p at reference p=.002 | 71-compute per-window bound | 79-site per-window bound | Safe reference-p boundary |',
        '|---:|---:|---:|---:|---:|',
    ]
    for r in d['task2']['window_sensitivity']['rows']:
        if r['outage_duration_ratio']['exact']=='0':
            lines.append('| %s | %s | %s | %s | %s |'%tuple(value(r[k]) for k in ['window_ratio','scaled_window_p','per_window_71_compute_bound','per_window_79_site_bound','reference_p_boundary_lower']))
    lines += [
        '',
        'For zero-duration faults, halving p reduces the79-site term by2^79≈6.04e23 per window. It reduces the **dominant71-compute term** by2^71≈2.36e21. Doubling the window count leaves improvements2^78 and2^70 respectively. The author’s roughly10^23 comparison concerns the79-site term; it is not the dominant physical account or the full21-account total. With the new half-window law the full total approaches%s, rather than falling by21–23 orders of magnitude. Common/reserve and cryptographic accounts stay.'%value(d['nonphysical_total_with_reserve']),
        '',
        'The local fault/date-union window and the64-date whole-island reseed period are different clocks. They cannot be substituted for each other. With physical outage duration D and reseed R, an island remains counted for at least D+R. Halving R changes this ratio to(D+R/2)/(D+R); an approximately halved counting window needs D much smaller than R, stable physical return, and bounded detection/repair/retries. JW2.6 supplies no numerical upper bound on D.',
        '',
        '### Re-mirroring / return cost screens',
        '',
        'Keep the inherited conservative endpoint-progress bound, two startup dates, urgent priority,1038 cared residents and seven primary duties/live host. Total normalized endpoint work is1890780.8486328125. For R>2 use Q>=ceil(work/(R-2)); returned-store authentication needs A>=ceil(407912448/(R-2)). Q is also constrained by urgent traffic. These are the quotas required by this particular conservative bound, not a proof of globally necessary repair cost. A full local endpoint bucket costs13/400000 energy per unit under the inherited tariff. The table rounds the interconnect allocation upward on JW2.6’s quarter-unit grid.',
        '',
        '| R after stable return | Endpoint quota Q | Repair auth quota A | Interconnect allocation | Energy margin before new idle/flow cost | Existing auth / batch screens |',
        '|---:|---:|---:|---:|---:|---|',
    ]
    for r in d['task2']['reseed_necessary_costs']['rows']:
        if not r['fixed_two_date_startup_model_feasible']:continue
        status=('pass' if r['existing_auth_reserve_fits_lower_bound'] else 'FAIL')+' / '+('pass' if r['existing344_entry_batch_fits'] else 'FAIL')
        lines.append('| %d | %d | %d | %s | %s | %s |'%(r['completion_dates'],r['minimum_endpoint_quota_for_this_progress_bound'],r['minimum_repair_auth_quota'],value(r['quarter_grid_interconnect_allocation']),value(r['energy_margin_before_new_flow_or_idle_cost']),status))
    lines += [
        '',
        '**The32-date quota in this global serial-progress calculation fails the existing energy plant.** Its additional activity is1.0499775 energy/island/date, requiring allocation24.5 and leaving a1.05364147 deficit before added idle costs. Authentication and batch screens still fit, but the larger per-host retry/calendar service and capital/idle prices are unproved. At16 dates the authentication reserve also fails; at8 dates the344-entry single-batch screen fails too. More batches might be possible at additional cost. One/two-date completion fails this unchanged two-startup-date model. None of these rows is a fully instantiated faster-repair plant.',
        '',
        '**Parallel recovery could be cheaper.** One returned-store volume is796704 endpoint units counting both ends, or796844.15673828125 with the same header/control convention. At the existing30720 quota, its single-store byte screen is28 dates and its auth screen27 dates. This does not prove a complete28/32-date rebuild: both returned islands, physical source/target load, MOVE and checkpoint overlap, and retry policing need one simultaneous progress proof. It does show why the more expensive global-serial row is not a lower bound on every32-date construction. The64-date certificate may be conservative; no universal no-go or minimum upgrade is claimed.',
        '',
        'The per-host endpoint figures in RESULTS.json are average capacity requirements **if one island exercises its whole promised bucket**, not an assertion that every island consumes that global work each date. Distribution, maximum host bursts, partial retries, packet blocking, extra certificates and power must all be priced before certifying a new point.',
        '',
        '### Detection, failover and deadline',
        '',
        'The current care path includes detection1/20, a composed journal1/8, the irreversible fence49/256, and other serial collection/release/grace stages. Their fixed sum is **%s date**, before scalable CPU/NIC/fabric work. Consequently halving the.95 care deadline to.475 **fails even with unbounded CPU and wire** unless those serial stages change. RESULTS.json gives exact uniform service-capacity targets for.9,.8,.75,.6 deadlines, but supplies no capital/idle price or renewed provider/journal proof. Detection must cover the complete physical outage, rather than restarting recovery at a later observation.'%value(d['task2']['urgent_recovery_necessary_service']['fixed_serial_care_floor']),
        '',
        '## Status, remaining work and evidence',
        '',
        '- Task1 PARTIAL: full-pool margins and necessary seed screens computed; actual phase exposures/budgets and twilight ordering unresolved.',
        '- Task2 PARTIAL: temporal counterexample, exact conditional window sensitivities and repair/deadline cost screens supplied; no licensed reduction of inherited p or fully priced faster plant.',
        '- Tasks3–7 NOT RUN in this budget-limited prefix. No target-k plant, founding schedule, rung4 proof, secret placement integration or mixed host-shock q boundary is claimed.',
        '',
        'The next dependent work needs an explicit twilight reference/ordering, exposure/budget allocation and bounded temporal outage law. A practical continuation is to price a32-date point, including extra flow and the complete host/auth/calendar ledger, then recompute all21 accounts. It is not enough to halve a probability or rename the64-date reseed interval.',
        '',
        'Ten paired command runs (20 executions) are byte-identical, including nine adverse claims that each exit1. Exact safe/failing p brackets are independently checked through the frozen full account calculator. The copied227-file JW2.6 manifest, author source copies, paired evidence, report rendering and final checksum manifest are audited by checks/check_bank.py. PORTABLE-REPLAY.json records the relocated replay. Run python3 -B checks/replay.py, python3 -B checks/render.py, python3 -B checks/check_bank.py --copies-only.',
        '',
        'Development failures were retained in DEVELOPMENT-NOTES.md: an initial Python3.9 API incompatibility and the first portable attempt’s rejection of macOS’s/var symlink. Both were corrected before the final replay. A proposed persistent-fault counterexample was also narrowed to respect conditioning on previously observed failures; the final comparison uses a fresh event at the audited pre-window history.',
        '',
        'Earlier banks remain frozen. No excluded path was opened; no Git writes, publication or release actions occurred. All performance/capital numbers retain JW2.6’s conditional-target status.',
    ]
    report='\n'.join(lines)+'\n'
    (ROOT/'REPORT.md').write_text(report)
    receipt={'REPORT.md_sha256':hashlib.sha256(report.encode()).hexdigest()}
    print(json.dumps(receipt,sort_keys=True))

if __name__=='__main__':render()
