from pathlib import Path
import json,hashlib
ROOT=Path(__file__).resolve().parents[1]
r=json.loads((ROOT/'RESULTS.json').read_text());t=r['task1'];p=t['plant'];q=t['resources'];a=t['all21_accounts'];lo=t['lower_energy_variant']
def num(v):return v['decimal_floor'] if isinstance(v,dict) else str(v)
rows=[('Compute hosts',242,p['compute_hosts']),('Passive sites',79,p['passive_sites']),
      ('Memory/host',4096,p['memory']),('Burst CPU/host',160,p['host_burst_CPU']),
      ('Burst wire/host',65536,p['host_burst_wire']),('Pool wire',2**24,p['pool_wire']),
      ('Interconnect energy allocation',16,p['interconnect']),('Stock',1070720,p['stock'])]
table='| Capacity | Previous | JW2.6 |\n|---|---:|---:|\n'+'\n'.join(f'| {name} | {old} | {num(new)} |' for name,old,new in rows)
worst=a['rows'][a['worst_row']]
acc_table='| Account at worst row | Bound, decimal floor |\n|---|---:|\n'+'\n'.join(f'| {name} | {num(value)} |' for name,value in sorted(worst['accounts'].items()))
rep=json.loads((ROOT/'REPLAY.json').read_text())
text=f'''# JW2.6 — conditional k=2 bank

20 October2026. A conditional two-island construction fits the capacity/price targets below. The old plant does not fit. This is a numeric and logical construction under the explicit services in CONTRACT.md, not measured hardware or a supplied implementation of every service. A globally smallest plant change has NOT been proved. Optional task2 was not executed: usage reached86% weekly and88% of the active window, so the priority task was banked first.

## Plant point and result

{table}

Daily CPU128 and host wire16384 stay unchanged. The stock increase is{p['stock_increase']}; the cash/buffer4096 remains. Additional hardware prices are new targets: at most512 per host upgrade package,1024 for the new passive site and1728 for the pool-fabric increment. One additional idle-energy unit/date is paid. These are assumptions to instantiate, not quotations or demonstrated minimum purchases.

- State: primary plus two full encrypted foreign images, on three fixed distinct logical islands;71 local holders. Any two erasures leave an image.
- Keys: fresh512-bit key and1024 coefficient bits/checkpoint,3-of5 Shamir, reconstructed only inside the authorized attested instance. Two observations do not reveal the key; two outages leave three shares.
- Whole-island scope: at most two unavailable/nonconforming/unreseeded islands in the relevant pool window. Local good region: at most70 compute and78 total failures across322 sites; failures beyond it are charged probabilistically.
- Survivor population: {q['post_outage_population']}, including{q['exiles_per_destination']} exiles; at most{q['primary_per_serving_host']} primary duties/live host.
- Pool quorum202, local quorum172. Replacing202 by201 loses the honest-intersection guarantee under two bad islands.

## Complete priced resource calculation

| Quantity | Value, decimal floor | Limit |
|---|---:|---:|
| Care end-to-end | {num(q['care_deadline'])} | .95 |
| Provider response | {num(q['provider_deadline'])} | .95 |
| Foreign checkpoint lag, clock padded | {num(q['checkpoint_bound'])} | .25 |
| Primary checkpoint lag | {num(q['primary_checkpoint_lag'])} | foreign lag |
| Sealed durable prefetch | {num(q['sealed_prefetch_bound'])} | 63/128 |
| Memory/host | {num(q['memory_required'])} |4512|
| Interconnect activity | {num(q['interconnect_activity'])} |23.25|
| Energy use | {num(q['energy_use'])} |1171.2 inflow|
| Energy margin | {num(q['energy_margin'])} |positive|
| Protected auth inventory/gate | {num(q['authentication_inventory'])} |1879048192|
| Certificates/date | {q['certificate_inventory']} |4224|
| Canonical care/return batch entries | {q['canonical_batch_entries_max']} |344|

Clock padding charges1384 captures/home/date. Merely reusing the ideal4/3 rate and a clock-free checkpoint bound would underprice the new schedule. Primary freshness is also explicit: the old primary copy service is reallocated to201024 endpoint records against251196 paid, retaining all242 MPC participants. Both primary generations for the six migrants, local primary headers, all five key-share records,72-copy relay paths and physical host metadata are counted. Main memory is below the8-unit cap4512.

The primary reuse, source-read/retry work cap and streaming authenticated checkpoint service are requirements, not conclusions of these volume inequalities. The joint service must preserve freshness under overlapping disruptions and complete recovery from the first relevant disruption. An intermediate failure does not restart the clock. Ordinary operators never receive a whole key, and prefetch alone does not authorize execution.

## Reseeding and return

Urgent recovery receives priority within the paid byte/auth quotas. Reseeding has a per-island30720 endpoint-unit/date limit and2^24 repair-auth limit; it is not paid from a pool average. Full returned-store auth fits27 dates; the conservative endpoint/progress bound is64 dates after stable physical return. Minds continue at their temporary destinations throughout. Original islands are still counted as lost until current images/shares and resident placement are restored. Power-on alone cannot clear a loss, and repeated flapping cannot consume unbounded repair work.

A lower-energy point uses interconnect{num(lo['interconnect_allocation'])} and7808 endpoint units/island/date, with{lo['reseed_completion_dates_after_stable_return']} stable-return dates to reseed and energy margin{num(lo['energy_margin'])}. The same immediate care bounds fit. This illustrates why there is no unique cheapest plant independent of reseed-time and outage-premise choices. A long reseed period is a long period during which the two loss allowances remain occupied.

## All21 accounts

All ten response/effort rows are recomputed with322 sites and the enlarged stock/wealth span. Worst row: **{a['worst_row']}**.

-21-account sum: **{num(a['sum'])}**.
- With certificate reserve: **{num(a['with_certificate_reserve'])}**, below10^-6.
- Remaining headroom: {num(a['headroom'])}.
- Every response and extraction incentive margin remains positive. All valuation-class, fixed-before-outcomes provider withdrawals, C-SEQ and common-warranty conditions remain binding.

{acc_table}

The physical quorum addend is the subset union{num(a['physical_quorum_tail_union'])}, retaining the old quorum term as well. The independent-binomial expression used in frozen JW2.4 does not follow from subset moments alone. A concrete exact71-fault distribution satisfies every required subset moment and exceeds that binomial tail; the bank checks it. The corrected bound still fits.

## Failures and unproved claims

The old memory, CPU, wire, passive-flow and interconnect settings fail this construction. Three relevant island losses erase every image. Two-of4 sharing reveals its secret to two captured shareholders. A201 pool quorum can split its honest intersection. Seventy local replicas can all disappear. A second serial audit breaks the deadline. A stale daily primary image misses the1.95 continuity bound. Unthrottled local reseeding and clearing a loss on mere power return are both rejected.

Neighboring smaller capacity coordinates are rejected on the declared grids at fixed foreground shares and the64-date repair quotas. **Global minimality remains unresolved.** Package prices, idle power, capture-resistant clocks/erasure, composed journal progress, dynamic partial-read handling, streaming commitments, primary-budget reuse and two-buffer joint freshness are unmeasured implementation obligations. The snapshot matching proof does not supply an adaptive read implementation. Every new interface must fit the same declared10^-7 joint common/premise allowance; no new free failure probability was added. No substantial global coordinated-attacker fraction is inferred from k=2.

## Evidence and replay

The finite checks cover79800 two-erasure supports/home with all homes covered by cyclic symmetry,120 threshold reconstructions,10 secrecy determinants,259 local erasure masks, clock-calendar burst counts and all ten complete21-account rows. {rep['pairs']} command pairs ({rep['executions']} executions) are byte-identical;{rep['adverse_controls']} adverse commands each exit1 as expected. Report rendering is separately paired. PORTABLE-REPLAY.json records a relocated replay; SHA256SUMS binds the source, code, numeric and command evidence.

Run `python3 -B checks/replay.py`, `python3 -B checks/render.py`, then `python3 -B checks/check_bank.py --copies-only` in this bank. Exact Fractions are in RESULTS.json. All new contracts are enumerated in CONTRACT.md; derivations and scope are in MATHEMATICS.md.

JW2.4,JW2.5 and JW2.5-incremental remain frozen. No excluded files, Git writes, publication or release actions were used.
'''
text=text.replace('\n-21-account','\n- 21-account')
(ROOT/'REPORT.md').write_text(text)
print(json.dumps({'REPORT.md':hashlib.sha256((ROOT/'REPORT.md').read_bytes()).hexdigest()},sort_keys=True))
