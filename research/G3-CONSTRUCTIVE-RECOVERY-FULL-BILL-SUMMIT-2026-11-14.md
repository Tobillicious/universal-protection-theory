# G3 summit — 14 November 2026: constructive recovery already proved

**Goal:** recover the strongest existing G3 result, join its *actual* recovery and complete costs, and avoid re-proving original six X3.

## Recovered constructive chain

1. `Snuffy/G3Sweep.lean`: `sweep_recovers`, `sweep_visits`, `waves_from_spread`, `sweep_bill`. For a shell-layered system with single-shot correction and frozen-interior fence, any exterior activity respecting that fence cannot undo recovered shells. A linear age-to-wave bound and metered per-wave work yield `W(t) ≤ ((fixed + α + β + reset)(c+r)^d)t^d`.
2. `Snuffy/G3PatchDecode.lean`: `patch_correction_succeeds`, `patch_sweep_bill`. Derives the required local correction from separated codewords, nearest decoding and within-radius patch reads. **This is already the constructive upper-bound recovery theorem**; don't ask to build it again.
3. `Snuffy/G3GoodEvent.lean`: `sweep_success_on_good_event` obtains recovery on the good event, with failure measure bounded by `∑ δ` over accounts, no independence assumption. `complete_bill_with_archive` adds nonzero archive holding to the sweep cost.
4. `Snuffy/G3ArchiveStock.lean`: `live_stock_bill` derives archive holding `≤ γ(I₀+c)t^d` under a live-stock growth envelope. `retained_stock_quadratic` and `rollover_quadratic` expose designs that violate cheap holding assumptions. This is a meaningful negative control.
5. `Snuffy/G3CompleteBill.lean`: `cumulative_charge_bound` and `valid_bill_bound_in_age` derive the bill from a metered ledger and bounded wave count; the bound is not simply stipulated.

## Direct algebraic composition (existing lemmas)

Let `C_s=(fixed+α+β+reset)(c+r)^d` from `patch_sweep_bill`. Let `C_h=γ(I₀+c_stock)` from `live_stock_bill`. Under the *combined* hypotheses of those two theorems and the same age `t` and dimension `d≥1`, `complete_bill_with_archive` yields:

`sweepCharge(t) + ∑_{s<t} γ·stock(s) ≤ (C_s+C_h)·t^d`.

The recovery conclusion from `patch_sweep_bill` remains true simultaneously. This is the exact constructive recovery-plus-full-bill G3 join to encode as a small Lean theorem, reusing all three theorems. Note that the archive-stock bound's `c_stock` is not necessarily the wavefront propagation `c`; keep names distinct.

## What is not needed again

- No new original-six X3 proxy or reformulation.
- No assumption about the attacker's values; the frozen-interior fence is an *environment/implementation* condition.
- No invented G3 polynomial upper bound: the existing sweep and patch theorems already prove it.
- No conflation of a successful abstract recovery construction with measured physical commissioning.

## Exact remaining work to close today's strongest result

A. **Lean composition**: add a thin `G3ConstructiveFullBillJoin.lean` that calls `G3PatchDecode.patch_sweep_bill`, `G3ArchiveStock.live_stock_bill`, `G3GoodEvent.complete_bill_with_archive`. Preserve the recovery predicate in the conclusion. Run pinned CI before claiming a new Q.E.D.

B. **Risk**: add a separately stated stochastic version using `G3GoodEvent.sweep_success_on_good_event`; do not smuggle a probability into the deterministic bound.

C. **Physical source**: identify whether a particular tested device satisfies `hcorr`/patch radius, `hfence`, propagation and complete metered costs. Only that step can certify a real physical installation.

D. **Original scope**: G3 here is the *recovery/work-scaling theorem* (the original Θ target's matching upper construction), not the cosmological Time Koru G3 notion. Keep those distinct.

**Status at time of note:** exact theorem source inspected via GitHub; no Lean build executed in this session, so this note is a source-level composition plan rather than a newly kernel-checked theorem. Draft only; no merge.
