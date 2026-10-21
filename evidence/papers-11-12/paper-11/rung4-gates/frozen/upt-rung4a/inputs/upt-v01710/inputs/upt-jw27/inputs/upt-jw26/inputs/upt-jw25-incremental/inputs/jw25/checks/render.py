"""Deterministic report renderer; numeric decisions remain in calculate.py."""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]
r=json.loads((ROOT/'RESULTS.json').read_text())
d=r['two_parity_construction'];floor=r['scalar_MDS_priced_floor_k2_through100'][0]
def show(x):
    if isinstance(x,dict):return x['decimal_floor']+' (exact '+x['exact']+')'
    return str(x)
text=f'''# JW2.5 — partial task1 bank

19 October 2026. Codex. No increase above the carried conditional k=1 has been established. Task1 remains partial; tasks2–4 were not executed. Weekly usage was80% at entry and81% at this checkpoint, so work stopped at the checked prefix under the brief's budget rule.

## What passed

An explicit systematic[400,398,3] two-parity code over GF(2^16) corrects any two erased island symbols. The determinant argument covers every message; the checker reconstructs all79,800 two-erasure supports of a nontrivial398-symbol message from survivors. A nonzero three-data-erasure ambiguity is also exhibited. Field irreducibility is checked by exhaustive possible factors of degree<=8. These are algebraic tests, not a production256MiB benchmark or a concurrent-fault protocol implementation.

The cyclic stripe layout reuses primary snapshots and adds only parity storage, with71 local holders and two generations. Its conservative memory bound is {show(d['two_generation_parity_memory_upper'])}, below4096. The nominal code storage overhead is400/398. The old extra full mirror is replaced in this candidate's ledger, rather than silently retained under a smaller overhead claim.

## What failed

At the inherited scalar charge127/10^9 per GF operation and the inherited256MiB maximum state, this encoder requires {show(d['operations_per_island_date'])} operations/island/date. Its charged encoder energy alone is {show(d['encoder_energy_charge'])}.

- Interconnect activity: {show(d['interconnect_activity'])}, cap16.
- Old work plus mean daily host CPU: {show(d['old_plus_mean_daily_CPU'])}, cap128. This fails even before a worst-host scheduling bound.
- Encoding time with all172 surviving hosts' full160 burst CPU and free IO: {show(d['checkpoint_encode_time_with_all160_CPU_free_IO'])} dates, against checkpoint lag1/4. The final durable phase and all transmission would make it slower.
- If the interconnect allocation alone were raised to pay this snapshot work, total energy becomes {show(d['energy_if_interconnect_allocation_is_raised'])}, against inflow1166.4. Additional inflow would be {show(d['additional_flow_required_after_allocation_raise'])}. More energy alone leaves the CPU/latency failures.

These are failures of this explicitly charged model, not physical lower bounds on an optimized machine.

## A weaker bound that also rejects scalar fast transforms at this tariff

For a coordinate-wise systematic scalar linear MDS[400,400-k] code, every parity output depends on all400-k input symbols. Binary fan-in therefore costs at least399-k combining gates for even its first parity symbol. Pool-average full-state work is at least(4/3)*1032*2^27*(399-k)/(400-k) operations/island/date. This ignores the other parities and every IO, key, decoder and header cost.

All99 k values from2 through100 fail the16 allocation even at that optimistic floor. At k=2 the encoder energy charge floor is {show(floor['encoder_energy_charge_lower'])}; required interconnect allocation is at least {show(floor['interconnect_allocation_lower'])}. Even with all unused interconnect prepaid, the necessary extra inflow is at least {show(floor['extra_flow_needed_even_after_unused_interconnect_lower'])}. Its full160-CPU checkpoint-time floor is {show(floor['single_checkpoint_time_if_all172_hosts_give_full160_CPU_lower'])}, already above1/4.

Fast-transform algorithms reduce the operation count but do not remove this first-output scalar bound. The primary-source literature triage is linked in SOURCES.md. It supplies no conversion from bulk throughput to this plant's normalized compute price. SIMD packet XORs, binary array codes with another tariff, and other state-size/freshness contracts remain open; a scalar operation upper-price target does not prove they are expensive.

## Necessary changes are priced; a sufficient change is not established

For the concrete two-parity snapshot encoder, the optimistic price ceiling that respects the fixed8-CPU checkpoint reserve and leaves the final1/8 durable phase is {show(d['most_restrictive_optimistic_bulk_GF_price_ceiling'])} compute/operation. The inherited charge is larger by {show(d['inherited_to_necessary_price_ratio'])}. This gives IO/propagation zero time and omits keys/recovery; it is a necessary target, not a demonstrated sufficient implementation or a smallest plant change. Other exact necessary ceilings are in RESULTS.json.

Spreading full-state encoding over extra dates loses the inherited age guarantee for unrestricted new states. Re-wrapping a key alone does not update parity after a state change. Two extra complete mirrors also fail memory. The adverse controls retain each of these failures.

## Scope and remaining work

The affordable spread-code question and smallest sufficient plant change are unresolved. No global maximum across all codes is claimed. The only complete conditional joint point carried here is JW2.4's k=1; its batched resource point is independently recalculated and compared exactly with the frozen result. Its21 accounts are carried as prior evidence and are not recomputed for a new spread construction. No new CERT15 conclusion or physical realization is claimed.

Next work must first justify a cheaper bulk primitive or supply another affordable encoder. Then execute task2 (matching threshold keys and mobile-adversary refresh), task3 (repair traffic, decoding and faster end-to-end failover), and task4 (the joint k with all21 accounts). In particular, the mirror's recovery traffic and timing-limited22 cannot be assumed for a dense MDS code.

## Replay and source boundary

Run `python3 -B checks/replay.py`, then `python3 -B checks/render.py`, then `python3 -B checks/check_bank.py --copies-only` in this bank. The replay runs9 command pairs (18 executions), including8 adverse controls that must each exit1 with byte-identical output. The report renderer is separately run twice. SHA256SUMS binds inputs, scripts, reports and replay evidence. The relocated replay is recorded in PORTABLE-REPLAY.json.

JW2.4's95 bound files stayed unchanged. INPUTS.json lists21 guarded source copies, including UPT-P-v0.17.3 and its Errata. No excluded source, Git write, publication or release action was used. WORK-CLAIM.md records this bank as PARTIAL.
'''
(ROOT/'REPORT.md').write_text(text)
print(text,end='')
