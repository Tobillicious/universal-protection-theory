from pathlib import Path
from fractions import Fraction as F
import json,hashlib
ROOT=Path(__file__).resolve().parents[1]
r=json.loads((ROOT/'RESULTS.json').read_text())
def frac(v):return F(v['exact']) if isinstance(v,dict) else F(v)
def fixed(v,places=2,up=False):
    v=frac(v)*10**places
    q=-(-v.numerator//v.denominator) if up else v.numerator//v.denominator
    sign='-' if q<0 else '';q=abs(q)
    return sign+str(q//10**places)+'.'+str(q%10**places).zfill(places)
def cost_row(k):
    a=r['full_encode_by_k'][str(k)]
    return f"| {k} | +{fixed(a['interconnect_allocation_increase_over16'],up=True)} | +{fixed(a['daily_CPU_cap_increase_over128_at_least'],up=True)} | {fixed(a['background_CPU_rate_for_one_eighth_optimistic_window_mean'],up=True)} |"
def dirty_row(k):
    a=r['incremental_dirty_frontiers'][str(k)]
    return f"| {k} | {fixed(100*frac(a['batch']['charged_dirty_fraction']),6)}% | {fixed(100*frac(a['online']['charged_dirty_fraction']),6)}% | {fixed(a['online']['per_state_equivalent_changed_KiB'])} |"
def mirror_row(k):
    a=r['replication_curve'][str(k)]
    return f"| {k} | +{fixed(a['extra_interconnect_over16'],up=True)} | +{a['extra_host_burst_over160']} | +{fixed(a['extra_daily_CPU_cap_over128'],up=True)} | +{fixed(a['extra_memory_over4096'],up=True)} |"
cost_header='| k | Added interconnect energy allocation above16 | Added daily CPU cap above128/host | Background CPU rate needed in1/8, mean/host |\n|---:|---:|---:|---:|\n'
dirty_header='| k | Batch: dirty fraction ceiling | Online: dirty fraction ceiling | Online equivalent KiB/state/checkpoint |\n|---:|---:|---:|---:|\n'
mirror_header='| k | Extra interconnect energy above16 | Extra burst CPU above160/host | Extra daily CPU cap above128/host | Extra memory above4096/host |\n|---:|---:|---:|---:|---:|\n'
selected=[2,3,5,10,22,50,92,100]
cost_table=cost_header+'\n'.join(cost_row(k) for k in selected)
dirty_table=dirty_header+'\n'.join(dirty_row(k) for k in selected)
mirror_table=mirror_header+'\n'.join(mirror_row(k) for k in [1,2,3,5,10,22,50,92,100])
example=r['incremental_examples']['92']['1/10000']['online']
report=f'''# JW2.5 follow-up — cost per k and incremental encoding

19 October 2026. The dense scalar-priced code is extremely expensive to rebuild. Adding mirrors instead trades more memory for much lower encoder cost. Incremental updates are algebraically valid and can make steady spread-code maintenance much cheaper, provided a new encrypted-update-rate and security contract holds. This bank does not raise the established conditional joint k above1.

## If memory can increase: replication is a much cheaper encoder path

Put k foreign ciphertext images plus the primary on k+1 distinct islands. There are zero field parity operations, so full refresh still uses the old copy tariff. At1032 states/island, one more mirror costs6.35024 interconnect energy units/date before keys or recovery, and about1.6532 additional compute units/host/date. Scaling the background reservations by k is a conservative way to preserve the existing foreground schedule: add8 burst CPU,2048 host burst wire units and2^21 pool wire units for each mirror beyond the first. These are capacity targets for data copying, not a completed service proof.

{mirror_table}

For k=2, the new memory cap is about4700, and the interconnect allocation about21.98. The data-copy projection needs about2.223 extra daily inflow before new keys/repair. Keep the foreground CPU share152 by raising the burst cap160 to168. Host burst wire rises65536 to67584 and pool wire2^24 to9*2^21. This avoids the dense-field encoder cost. It also explains why replication failed the unchanged4096-memory requirement. Larger k increases memory and wire rapidly. Complete curves and separate daily/burst wire targets are in MIRROR-CURVE.md and RESULTS.json. These are intact-pool checkpoint projections; post-outage populations, key thresholds, journal changes, authenticated control traffic, repair, reseeding and all21 accounts remain additional obligations.

## Cost of full checkpoint rebuilds

For an explicit normalized Cauchy systematic[400,400-k] family, one full checkpoint costs(2k-1)(d-1)L field operations per island, d=400-k. L is the4KiB-aligned symbol count per stripe chunk. Both IO endpoints, copying,70 extra local parity copies and two generations are charged. These are normal intact-pool snapshot costs at1032 states/island; complete post-outage operation may cost more.

{cost_table}

Capacity displays are rounded upward to0.01; exact Fractions are in RESULTS.json. The interconnect column is an ENERGY allocation, not link bandwidth. CPU's second column is an increase to the128/date cap; its burst requirement is separately much larger. The currently banked k=1 mirror needs no increase in these numerical caps. The table's k=2 is a change to a spread-code design, not merely one more mirror.

Within this dense code family, each further k costs roughly368 more interconnect energy units and272 more compute units/host/date. All99 per-step differences are in COST-CURVE.md. This is not a universal or optimal price: cheaper bulk XOR/transform hardware could give another curve.

Raising energy alone leaves CPU, bandwidth and completion-time failures. The pool has2^24 total wire units/date, of which2^21 are reserved for background work. The full-code curve separately records the larger background wire rate needed to deliver a complete gathered snapshot in an optimistic1/8 active window. Buying any displayed encoder resource does not price matching keys, reconstruction, all21 accounts, new hardware capital/idle energy or the larger surviving populations.

## Incremental encoding can work

For linear parity P=A D, compute Delta=D_new XOR D_old, then P_new=P_old XOR A Delta. One changed16-bit word costs at most2k scalar operations including delta formation. The implemented examples at k=2,3,5,10,22,50,92,100 exactly match full re-encoding. The general MDS property follows from nonzero scaled Cauchy minors. See MATHEMATICS.md and the primary-source links in SOURCES.md.

Keep the old encoder CPU reserve8 and interconnect allocation16. The following projected dirty-update ceilings satisfy the modeled aggregate CPU, copy, energy and wire inequalities; authentication metadata, keys, access-pattern privacy and recovery are excluded. A dirty update charges a whole4KiB encrypted block. Repeated online applications count repeatedly.

{dirty_table}

Percentages are floored. Batch means finish after capture in1/8 before the final1/8 durable phase. Online means spread updates through the3/4-date interval, charging parity fanout for every applied update. The online column is a throughput bound: an adversary can put the whole allowed average into a late burst, so a per-window write/burst bound and final-queue guarantee are still required. The next dirty block is explicitly checked to fail the limiting modeled inequality for each k and each mode.

At k=92, a nominal0.01% update budget (about26.2KiB per256MiB state per checkpoint, with updates balanced across stripe coordinators and hosts) gives interconnect activity {fixed(example['interconnect_activity'],4,up=True)} against16 and background CPU {fixed(example['background_CPU_rate_mean'],4,up=True)} against8 in the online model. Total daily host CPU mean is {fixed(example['total_daily_CPU_mean'],4,up=True)} against128. This is a useful conditional encoder point, not an achieved k=92 failover guarantee. Dirty positions can spread across parity pages, so parity traffic is not simply multiplied by the input dirty fraction. A pool-wide dirty average alone does not establish these island and host load bounds.

## What the incremental contract must change

Fresh full-image encryption can make nearly every ciphertext word dirty even when plaintext barely changes. One candidate is versioned page encryption with a stable data key confined to the attested instance, while refreshing its shares or wrapping key instead of rewriting every page. Share refresh can preserve the secret while replacing its sharing polynomial. That requires a retained-generation exposure bound, secure erasure, antirollback, protected refresh traffic and a new C-SEQ proof; changing the secret is not the only refresh mechanism.

The new checkpoint root must authenticate page versions and code/placement epochs. Update records need ordering and deduplication: applying an XOR delta twice cancels it. Dirty addresses, counts and timing must satisfy C-SEQ; padding the count alone does not hide addresses. Initial encoding, full rebuilds, conversion from the mirror, outage repair and reseeding still need paid resources. The tables do not prove that actual mind states meet the low dirty-rate bound or that a privacy-preserving implementation stays inside it.

## The decentralisation claim needs a narrow scope

k=1 covers one adversarial whole-island outage as well as ordinary erasures, under all the retained physical/freshness/release contracts. It does not support broad resistance to coordinated island attacks. A coordinated attacker that can erase the primary and its mirror defeats the present ciphertext code. The appropriate claim is conditional continuity with at most one whole-island loss per pool/window. No substantial global coalition fraction has been proved; hidden placement alone does not supply the required cap or mobile-exposure law.

## Evidence

Nine command pairs ran byte-identically, including eight adverse controls with expected exit1. The numeric frontier checks cover every k=2..100; code examples verify full versus incremental parity at eight full-size matrix splits. A relocated replay is recorded in PORTABLE-REPLAY.json. Source checks bind the78-file JW2.5 prefix and the frozen95-file JW2.4 bank. No excluded files, Git writes, manuscript edits or release actions were used.

Run `python3 -B checks/replay.py`, `python3 -B checks/render.py`, then `python3 -B checks/check_bank.py --copies-only` in this bank.
'''
(ROOT/'REPORT.md').write_text(report)
curve='# Full dense-code cost curve\n\nEncoder-only intact-pool projections, not global minima or joint guarantees. Row1 is a dense single-parity candidate, not the existing mirror. Cost values are rounded upward; marginal values are floored.\n\n'
curve+='| k | Added allocation above16 | Added daily CPU cap above128 | Next k: added allocation | Next k: added daily CPU/host |\n|---:|---:|---:|---:|---:|\n'
for k in range(1,101):
    a=r['full_encode_by_k'][str(k)]
    marginal=[fixed(a[x],4) if x in a else '—' for x in ['next_k_extra_interconnect','next_k_extra_daily_CPU_mean']]
    curve+=f"| {k} | {fixed(a['interconnect_allocation_increase_over16'],up=True)} | {fixed(a['daily_CPU_cap_increase_over128_at_least'],up=True)} | {marginal[0]} | {marginal[1]} |\n"
(ROOT/'COST-CURVE.md').write_text(curve)
(ROOT/'DIRTY-CURVE.md').write_text('# Incremental update ceilings\n\nModel-only aggregate ceilings before keys, metadata, privacy, queueing and recovery. Percentages are floored; not full guarantees.\n\n'+dirty_header+'\n'.join(dirty_row(k) for k in range(2,101))+'\n')
(ROOT/'MIRROR-CURVE.md').write_text('# Replication capacity tradeoff\n\nPrimary plus k foreign images,71 local holders, two generations. These are intact-pool data-copy projections; keys, control, recovery, reseeding, post-outage populations and all21 accounts remain additional. Snapshot copy shares are scaled together to preserve foreground allocations. Values are rounded upward.\n\n'+mirror_header+'\n'.join(mirror_row(k) for k in range(1,101))+'\n')
print(json.dumps({name:hashlib.sha256((ROOT/name).read_bytes()).hexdigest() for name in ['REPORT.md','COST-CURVE.md','DIRTY-CURVE.md','MIRROR-CURVE.md']},sort_keys=True))
