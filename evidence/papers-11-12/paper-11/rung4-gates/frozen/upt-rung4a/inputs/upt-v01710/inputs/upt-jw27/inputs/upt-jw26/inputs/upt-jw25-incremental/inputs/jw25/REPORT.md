# JW2.5 — partial task1 bank

19 October 2026. Codex. No increase above the carried conditional k=1 has been established. Task1 remains partial; tasks2–4 were not executed. Weekly usage was80% at entry and81% at this checkpoint, so work stopped at the checked prefix under the brief's budget rule.

## What passed

An explicit systematic[400,398,3] two-parity code over GF(2^16) corrects any two erased island symbols. The determinant argument covers every message; the checker reconstructs all79,800 two-erasure supports of a nontrivial398-symbol message from survivors. A nonzero three-data-erasure ambiguity is also exhibited. Field irreducibility is checked by exhaustive possible factors of degree<=8. These are algebraic tests, not a production256MiB benchmark or a concurrent-fault protocol implementation.

The cyclic stripe layout reuses primary snapshots and adds only parity storage, with71 local holders and two generations. Its conservative memory bound is 3420.16102309944152 (exact 44828734561969/13107200000), below4096. The nominal code storage overhead is400/398. The old extra full mirror is replaced in this candidate's ledger, rather than silently retained under a smaller overhead claim.

## What failed

At the inherited scalar charge127/10^9 per GF operation and the inherited256MiB maximum state, this encoder requires 552658694624 (exact 552658694624) operations/island/date. Its charged encoder energy alone is 552.658694624 (exact 17270584207/31250000).

- Interconnect activity: 562.049371409608235 (exact 112271457259125860027/199753728000000000), cap16.
- Old work plus mean daily host CPU: 453.361119596835010 (exact 5028607608063599036027/11091836928000000000), cap128. This fails even before a worst-host scheduling bound.
- Encoding time with all172 surviving hosts' full160 burst CPU and free IO: 1.91281761129854651 (exact 6580092582867/3440000000000) dates, against checkpoint lag1/4. The final durable phase and all transmission would make it slower.
- If the interconnect allocation alone were raised to pay this snapshot work, total energy becomes 1708.70204542535626 (exact 341319603614940260027/199753728000000000), against inflow1166.4. Additional inflow would be 542.302045425356266 (exact 108326855275740260027/199753728000000000). More energy alone leaves the CPU/latency failures.

These are failures of this explicitly charged model, not physical lower bounds on an optimized machine.

## A weaker bound that also rejects scalar fast transforms at this tariff

For a coordinate-wise systematic scalar linear MDS[400,400-k] code, every parity output depends on all400-k input symbols. Binary fan-in therefore costs at least399-k combining gates for even its first parity symbol. Pool-average full-state work is at least(4/3)*1032*2^27*(399-k)/(400-k) operations/island/date. This ignores the other parities and every IO, key, decoder and header cost.

All99 k values from2 through100 fail the16 allocation even at that optimistic floor. At k=2 the encoder energy charge floor is 184.219564598030150 (exact 71600963584/388671875); required interconnect allocation is at least 193.489115353305741 (exact 19101759423141/98722656250). Even with all unused interconnect prepaid, the necessary extra inflow is at least 173.741789369053772 (exact 17152250948141/98722656250). Its full160-CPU checkpoint-time floor is 0.637605869475376884 (exact 1239097344/1943359375), already above1/4.

Fast-transform algorithms reduce the operation count but do not remove this first-output scalar bound. The primary-source literature triage is linked in SOURCES.md. It supplies no conversion from bulk throughput to this plant's normalized compute price. SIMD packet XORs, binary array codes with another tariff, and other state-size/freshness contracts remain open; a scalar operation upper-price target does not prove they are expensive.

## Necessary changes are priced; a sufficient change is not established

For the concrete two-parity snapshot encoder, the optimistic price ceiling that respects the fixed8-CPU checkpoint reserve and leaves the final1/8 durable phase is 4.14963766180064731E-10 (exact 43/103623505242) compute/operation. The inherited charge is larger by 306.050817807767441 (exact 6580092582867/21500000000). This gives IO/propagation zero time and omits keys/recovery; it is a necessary target, not a demonstrated sufficient implementation or a smallest plant change. Other exact necessary ceilings are in RESULTS.json.

Spreading full-state encoding over extra dates loses the inherited age guarantee for unrestricted new states. Re-wrapping a key alone does not update parity after a state change. Two extra complete mirrors also fail memory. The adverse controls retain each of these failures.

## Scope and remaining work

The affordable spread-code question and smallest sufficient plant change are unresolved. No global maximum across all codes is claimed. The only complete conditional joint point carried here is JW2.4's k=1; its batched resource point is independently recalculated and compared exactly with the frozen result. Its21 accounts are carried as prior evidence and are not recomputed for a new spread construction. No new CERT15 conclusion or physical realization is claimed.

Next work must first justify a cheaper bulk primitive or supply another affordable encoder. Then execute task2 (matching threshold keys and mobile-adversary refresh), task3 (repair traffic, decoding and faster end-to-end failover), and task4 (the joint k with all21 accounts). In particular, the mirror's recovery traffic and timing-limited22 cannot be assumed for a dense MDS code.

## Replay and source boundary

Run `python3 -B checks/replay.py`, then `python3 -B checks/render.py`, then `python3 -B checks/check_bank.py --copies-only` in this bank. The replay runs9 command pairs (18 executions), including8 adverse controls that must each exit1 with byte-identical output. The report renderer is separately run twice. SHA256SUMS binds inputs, scripts, reports and replay evidence. The relocated replay is recorded in PORTABLE-REPLAY.json.

JW2.4's95 bound files stayed unchanged. INPUTS.json lists21 guarded source copies, including UPT-P-v0.17.3 and its Errata. No excluded source, Git write, publication or release action was used. WORK-CLAIM.md records this bank as PARTIAL.
