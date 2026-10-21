"""Render the appended tasks3–7 report from exact numeric evidence."""
from pathlib import Path
import sys,json,hashlib
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]

def v(x):return x['decimal_floor'] if isinstance(x,dict) and 'decimal_floor' in x else str(x)

def main():
    d=json.loads((ROOT/'RESULTS-3-7.json').read_text());a,b,p,q=[d[k] for k in ['task3','task4','task6','task7']]
    lines=[
        '# JW2.7 continuation — tasks 3–7', '',
        '20 October 2026. All five requested tasks were examined in order. **Rung 4 is not established.** Tasks 3–5 have quantitative conditional results and an explicit unresolved gap. Task 6 has a balanced scattered construction and a conditional capacity/key price point; traffic and cache secrecy remain realization obligations. Task 7 has a certified numerical boundary for the stated joint host-error ledger.', '',
        'The original 298 bound prefix files remain byte-identical. REPORT.md and RESULTS.json describe that earlier prefix; this report and RESULTS-3-7.json contain the continuation. Earlier banks remain frozen. The user explicitly authorized continuation with the remaining weekly budget.', '',
        '## Task 3: target k and what it would cost', '',
        'No numerical twilight reference, common margin metric, phase exposure schedule or capital-price function was supplied. There is therefore no uniquely determined rung-4 k or globally smallest plant purchase. The following **illustrative coalition calculation** uses the author’s literal global disabled fraction 0.46%, 10^20 islands, uniformly secret pools of 400, and 2.5×10^117 pool-dates. The disabled global set is fixed before pool selection. We use the exact finite-population hypergeometric law, not an independent-binomial approximation. Independence across pool-dates is unnecessary for the union bound; secret sampling and nonadaptive targeting remain assumptions.', '',
        '| Repair-window ratio | Assumed disabled fraction | Minimum k for coalition budget 10^-8 | Coalition union |',
        '|---:|---:|---:|---:|',
    ]
    for row in a['illustrative_targets']:
        lines.append('| %s | %s | %s | %s |'%tuple(v(row[k]) for k in ['repair_window_ratio','assumed_disabled_fraction','minimal_k_for_illustrative_coalition_account','horizon_union']))
    lines += ['',
        'At the literal 0.46%% value the budget-minimum is k=93; the author’s “about k=92” is approximate. The k=93 coalition union, %s, is used below as an explicitly chosen surrogate reference. It is **not a supplied physical twilight trajectory**. To beat that reference by a factor of two at the same full exposure, the minimum k values and mirror cost screens are:'%v(a['surrogate_coalition_reference_union']), '',
        '| Window ratio | k to beat surrogate by factor 2 | Mirror memory projection | Interconnect activity projection | Provider time with old pool share |',
        '|---:|---:|---:|---:|---:|',
    ]
    for row in a['strict_surrogate_reference_targets']:
        z=row['cost_screen']
        lines.append('| %s | %s | %s | %s | %s |'%(v(row['repair_window_ratio']),row['k'],v(z['mirror_memory_lower_projection']),v(z['interconnect_activity_lower_projection']),v(z['same_pool_foreground_provider_projection'])))
    lines += ['',
        'These are resource projections, **not fully priced high-k plants**. Each additional full mirror above k=2 adds 608.35128 modeled memory units with the same balanced holder pattern and extra key-share metadata, before the larger resident population and controls. It adds 6.47712 interconnect energy units per date at the clock-padded JW2.6 checkpoint rate. Fresh (k+1)-of-(2k+1) sharing costs (k+1)/20000 + 32(2k+1)(2k)·FC compute per state/checkpoint. Reseeding and recovery, foreground service, cryptographic realization, idle power, capital targets and all 21 accounts must still be integrated. The provider-only wire projection already fails .95 at every listed target.', '',
        'The same rows include the inherited online incremental-parity calculation with a conservatively rounded 0.01% changed-block fraction and the JW2.6 clock-padded rate. That can make the **encoder projection** affordable; it is incompatible with simply retaining JW2.6’s fresh whole-state data key every checkpoint. A stable data key, fresh share refresh, authenticated page updates, metadata hiding, decoding and repair are separate requirements. Sparse plaintext change does not establish sparse ciphertext change. No omitted cost is declared free.', '',
        'Halving the assumed global disabled fraction when halving repair time is an additional coordinated-start/outage-duration capability premise. It does not follow from ordinary site P-FAULT or from a shorter software timer.', '',
        '## Task 4: a conditional growth/exposure schedule', '',
        'For each candidate stage below, declare at most 10^12 pool-dates, rather than infer an actual duration. Total phase budget is 10^-8. Choose each feasible commissioned stage’s coalition target as the surrogate reference union divided by 16. A schedule of at most eight such feasible stages then has union at most half the reference. This is a conditional certificate for the **coalition component only**, not all resource/identity/common-premise margins. Rows marked FAIL are uncovered seeds, not stages certified by pretending their impossible k is available; they must be skipped before activation or redesigned.', '',
        '| Islands | Required k, window 1 | Window 1/2 | Window 1/4 | Window 1/8 | Slot-only maximum k |',
        '|---:|---:|---:|---:|---:|---:|',
    ]
    for row in b['stage_rows']:
        values=[str(t['k_required'])+(' FAIL' if not t['slots_fit'] else '') for t in row['variants']]
        lines.append('| %d | %s | %d |'%(row['islands'],' | '.join(values),row['islands']//4))
    lines += ['',
        'The slot screen is k<=floor(n/4), from (n-k)·344>=1032k. Honest-intersection authority also requires n>3k; keys need 2k+1 distinct islands. Passing these screens is not an implementation. At the original window, even k=2 cannot fund one full stage against the illustrative threat; RESULTS-3-7.json gives its maximum allowed exposure at every stage.', '',
        '| Window ratio | Smallest seed passing this scenario’s slot-risk screen | k at that seed |',
        '|---:|---:|---:|',
    ]
    for row in b['smallest_seeds_for_slot_screen_in_this_scenario']:
        lines.append('| %s | %s | %s |'%(v(row['window_ratio']),row['smallest_slot_screen_seed'],row['k']))
    lines += ['',
        'One coalition-only candidate at the original window is to commission 60 islands at k=15, then grow through 100/k=17, 200/k=22 and 400/k=27, each within the stated stage exposure. Upgrade to the strict-reference k=94 before the long cosmic-exposure stage. The 60-island seed already saturates the eight-slot post-outage screen; it is not a JW2.6 six-exile plant. Provider withdrawal also needs a new joint derivation: 60 islands contain only 17280 providers, so the full-pool absolute cap42800 cannot simply be reused as a useful small-pool withdrawal guarantee.', '',
        'Upgrade k and commission the repair service **before** a stage exceeds E_i <= target_i/H(n_i,k_i,phi_i). Do not clear old losses before current images, shares and resident placement are restored. The long cosmic-exposure stage needs a further upgrade to the task-3 target; a short 400-island founding stage does not inherit cosmic safety. A physical schedule still needs actual pool births, dwell times, available capital and an outage/attack start bound. No protection before activation or universal seed-stage protection is claimed.', '',
        '## Task 5: rung-4 statement and gap', '',
        '**Failure to establish rung 4 is the result.** Founding remains the first uncovered phase. The conditional schedule above can control one coalition-risk component after commissioning; it does not construct the early seed plant, establish all phase risks or price a fading twilight. Weak MN2 still permits equal normalized margins. Consequently the smallest change that closes the complete gap cannot be identified from the supplied inputs.', '',
        'The missing closure is quantitative: a twilight reference and comparison metric; actual phase exposures and budgets; a bounded temporal coalition/outage model; complete funded high-k founding/maturity plants; and a joint realization/security argument. Commissioning a larger seed or repairing faster is a candidate change, not a proof that the whole-life gap is closed.', '',
        '## Task 6: secret scattered placement', '',
        'For each identity rank r, derive independent keyed uniform cycles. The main candidate uses one 200-cycle for even island labels and one for odd labels. A home’s two foreign images are the next two members of its cycle; its five key shares are the next five including home. Thus every destination receives exactly two image records and five shares per rank. The main variant excludes numeric h−1 and h+1; no geographic-separation claim is made. A single 400-cycle per rank gives a larger anonymity set and the same load proof, while allowing chance numeric-neighbor coincidences.', '',
        'The complete 412800-identity fixture checks distinct images/shares, strict numeric non-adjacency, and balance. For any two lost homes, each serving island exports at most two records per rank: its demand is a subset of JW2.6’s two-record-per-rank problem. The original Hall/interval argument therefore still supplies at most 12 reads/live host for any 70-erasure mask. All 259 existing masks are rerun. Holder maxima remain 606 image and 1515 share records/host. Rank staggering still gives the same checkpoint burst envelope. Dispatching 2064 evacuees over 398 survivors still needs at most six per survivor. Adjacency itself was not the needed invariant; bounded per-rank incoming multiplicity was.', '',
        'Use a stable 512-bit placement key, held 3-of-5, with fresh independent degree-two coefficients and secure retirement each refresh. At most two shares of each generation may be observed, including staging; whole-key material remains in the authorized attested setup/refresh service. Hosts keep two sealed copies of four direct successor labels per public (home,rank) row; home itself is implicit. Reading fixed row offsets avoids a secret-dependent inverse/permutation lookup. Cache availability avoids putting a new threshold lookup on the urgent recovery path.', '',
        '| Priced quantity | Result | Limit / status |',
        '|---|---:|---|',
    ]
    entries=[('Memory/host','memory_total','4512'),('Setup memory upper','setup_memory_upper','4512'),('Auth inventory','authentication_total',str(7*2**28)),
             ('Extra lookup compute/island/date','lookup_compute_required','4 reserved'),
             ('Placement-key refresh compute/pool/date','key_refresh_compute_per_pool_date','charged'),
             ('Remaining energy margin','energy_margin_after_key_and_lookup','positive'),
             ('Checkpoint lag','checkpoint_projected','.25'),('Care','care_projected','.95'),
             ('Provider response','provider_projected','.95'),('Reseed after stable return','reseed_dates_with_cache_restore','64 dates'),
             ('Returned-store auth completion','return_auth_dates_with_cache_restore','64 dates'),
             ('Returned-cache validation completion','cache_validation_completion_dates','64 dates'),
             ('One-time setup compute/pool','setup_bounded_compute_per_pool','before activation'),
             ('One-time setup energy/pool','setup_one_time_energy_per_pool','additional commissioning funding')]
    for name,key,limit in entries:lines.append('| %s | %s | %s |'%(name,v(p[key]),limit))
    lines += ['',
        'All listed capacity screens pass at the existing 4512-memory/166-burst-CPU/23.25-allocation target, with one extra certificate under the prepaid cap. Existing 128-field placement/generation headers are reused explicitly; adding fields to every transfer is not assumed free. Lookup costs at most 16 field-operation equivalents/endpoint, immutable-cache validation at most eight/field, and an extra four compute/island/date pays lookup, refresh and validation work. Beyond normal checkpoints, a receiver-enforced 60000-lookup bucket covers30720 repair endpoints,20000 urgent/control operations and9280 margin; failed partial attempts consume lookup tokens before access. Urgent work has priority. One compute/date is separately reserved within the four for cache validation, completing in53 dates. The saved daily/background CPU values are balanced volume projections; check37.py also charges the entire additional island reservation to one host, obtaining daily CPU below53 (limit128) and background CPU below9 (limit14), without assuming that balance. This quota/progress service is an explicit functional requirement, not an adaptive implementation. No extra installed RAM capacity is needed; setup energy and the new primitive performance targets still require funding/realization. This is a newly commissioned point, not a priced live migration from a running adjacent layout.', '',
        'A bounded rejection sampler abort is charged to crypto_protocol_512, not a new allowance: horizon bound %s for at most10^120 authorized setups under the ideal keyed-stream contract. No arbitrary unpriced placement-redraw frequency is supplied. The SHAKE implementation in the fixture uses a disclosed test seed for reproducibility and **does not instantiate or prove 459-bit security**. The priced setup target is one 512-bit primitive block per 10^-4 compute.'%v(p['horizon_sampler_abort_charge']), '',
        'Ideal-cycle blind home-plus-two loss is **%s = 1/19701** for the strict parity variant, conditional on no relevant map/traffic disclosure. The full-400 option gives **%s = 1/79401**, the author’s approximately1.26e-5. These are different candidate sets. A real keyed implementation must add its distinguishing/leakage advantage; that advantage is not proved zero here. Neither figure applies after an attacker learns the target pair. A threshold-held seed alone does not protect plaintext cached routes. Sealed-cache confidentiality, uniform keyed outputs, recipient anonymity, adaptive-query leakage resistance and the stronger joint common/security warranty remain unproved realization obligations. Full secret-placement privacy is therefore not claimed as implemented.'%(v(p['blind_home_plus_two_loss_strict_variant']),v(p['blind_home_plus_two_loss_full400_variant'])), '',
        '## Task 7: mixed whole-host errors', '',
        'Use the stated conditional independent-host law: each of 242 hosts has shock probability q; a shock makes all seven jobs wrong, otherwise its seven jobs err independently with probability .1. Let A be the number of shocked hosts. Conditional on A=a, total errors are 7a + Binomial(7(242−a),.1). Sum the exact tails at thresholds 574 and 575 over A. This is an exact **error-count** distribution and a union upper bound for committee failure under the inherited erasure accounting; it is not an exact measured protocol failure probability.', '',
        'The committee entry and the committee portion of the certificate reserve are both replaced. The legacy one-job-per-host quorum term is also conservatively recomputed at marginal .1+.9q, retaining the physical .002 quorum tail. The other 19 accounts and noncommittee reserve remain fixed. All ten rows are recomputed.', '',
        '| Accounting method | Safe q | Next grid q exceeding 2.1e-7 | Grid width |',
        '|---|---:|---:|---:|',
        '| Exact mixed error-count tails | %s | %s | %s |'%(v(q['safe_q']),v(q['next_grid_q_exceeds_budget']),v(q['grid_width'])),
        '| Retained historical moment bound | %s | %s | 10^-9 |'%(v(q['historical_moment_bound_safe_q']),v(q['historical_moment_bound_next_q'])), '',
        'Exact-ledger total at the safe point: **%s**; at the next point: **%s**. Worst row remains %s. Monotonicity follows by coupling a larger q to turn additional hosts’ seven-job vectors into all errors. Thus the adjacent grid points bracket the real boundary, and the lower is the largest certified grid value.'%(v(q['safe_total']),v(q['next_total']),q['worst_row']), '',
        'The old “q around1.6e-4 uses the whole10^-6” was a conservative moment-account statement, not the exact mixed tail or an observed failure probability. At q=.00016 the exact total is about2.16889e-7: above the requested2.1e-7, but far below10^-6. The exact tail permits a larger q than the retained moment proof at the tighter target. Positive q does not preserve the literal per-job .1 subset law; this is a replacement joint law. Per-host q marginals alone also do not imply independent-host tails: a shared pool-wide shock defeats that inference.', '',
        'The rate applies to the specified job-error model, not an unmodeled physical halt, shared vendor failure, every host computation, or a globally optimal protocol. Task 7 is evaluated at JW2.6 as requested; it does not silently combine the unresolved privacy realizations of task 6.', '',
        '## Evidence and replay', '',
        'REPLAY-3-7.json records ten byte-identical command pairs, including nine deliberately false claims with expected exit1. Small-host direct convolution independently checks the shock-mixture decomposition. Target minima use exact finite-population tails; every next-smaller k fails its declared target. PORTABLE-REPLAY-3-7.json records the relocated continuation replay. PREFIX-FROZEN.json and the archived prefix manifest certify that all 298 earlier prefix files are unchanged. The older prefix’s own paired/portable evidence is preserved.', '',
        'The initial continuation render failed on an unescaped percent sign; it was corrected before the paired report render and bank seal. DEVELOPMENT-TASKS3-7.md records the transient render/seal failures. Run python3 -B checks/replay37.py, python3 -B checks/render37.py, and python3 -B checks/check37.py --copies-only in a working copy. The original REPORT.md remains the frozen prefix report. No excluded files, Git writes, publication or release actions were used.',
    ]
    report='\n'.join(lines)+'\n';(ROOT/'REPORT-TASKS3-7.md').write_text(report)
    print(json.dumps({'REPORT-TASKS3-7.md_sha256':hashlib.sha256(report.encode()).hexdigest()},sort_keys=True))

if __name__=='__main__':main()
