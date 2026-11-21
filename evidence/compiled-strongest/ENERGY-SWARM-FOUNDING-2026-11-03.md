# Part XIV: energy collateral and swarm founding

This increment implements the queued Part XIV.1/XIV.2 Lean counterparts.
The full UPT target, history/reference requirements, original outcome order,
pathwise work bill and risk budget remain fixed. Commissioning still includes
the actual founder, enforced physical custody, complete costs and measured
capacity/deficit/hazard parameters. This is not a global physical-UPT verdict.

Base: main e52e4b8cb47f9f7959d4235276c333e381c1b0e1. The existing all-necessary
founding and holding proofs are reused. This work does not substitute the
excludable-benefit theorem for the non-excludable founding argument.

## Energy-denominated founding

`Snuffy.EnergyFounding` contains seven results:

- `advantage_positive_unit`: multiplying every quantity in one founder's
  payoff comparison by the same positive factor multiplies the advantage by
  that factor. Different founders retain their own commensurate valuations.
- `energy_all_necessary_dominant`: include the anchor's committed pledge on
  both sides of the provision comparison. Every ordinary pledge is still
  necessary; contributing remains strictly better at every subset of others'
  pledges when its positive bonus and pivotal benefit margin hold. The
  already-funded/free-riding case is excluded by the established construction.
- `subset_bonuses_funded`: posted nonnegative bonuses cover any contributor
  subset, with each eligible claimant represented once.
- `failure_refunds_and_bonuses_funded`: for any subset S of ordinary founders,
  let P_S be its received pledges and B_S its bonuses. With anchor pledge A,
  separate activation bill a and posted total bonus reserve B_N,

  (A + P_S) + B_S + a <= (A + a + B_N) + P_S.

  Received pledges fund their refunds; they are not counted as bonus income.
- `successful_campaign_exact_balance`: the full provision bill plus
  activation leaves exactly the posted failure-bonus reserve unspent.
- `meter_lower_bound_funds_collateral`: if the actual stock differs from a
  reading by at most the certified error and the requirement fits below
  reading minus error, the actual stock covers the requirement.
- `energy_anchor_margin`: reuses the established equivalence between positive
  anchor payoff and benefit exceeding pledge plus activation.

These are universal algebra/accounting theorems. Actual source enforcement,
one payment per claimant, accessible stock, calibrated error bounds, transfer
losses and complete activation/continuing costs are supplied by the physical
controller, ledger and commissioning correspondence. The floor and the
subjective-lattice/identity argument in Part XIII are preserved unchanged.

## Unequal keepers and arbitrary joint failures

For a finite pool N, define C=sum C_i, Q=sum Q_i and d=sum d_i. Suppose
Q_i(w)+d_i(w)=C_i in every world, each deficit is nonnegative and integrable,
and its mean is at most e_i. Assume C>0 and H<C.

`Snuffy.SwarmFounding.pool_threshold` proves

    P[sum Q_i < H] <= (sum e_i) / (sum C_i - H).

Proof: construct D=d/C. Nonnegativity and integrability follow by finite
summation and division by positive C. Integral linearity yields
E[D] <= (sum e_i)/C. The source identities give Q=C(1-D). Apply
`CorrelatedHolding.correlated_holding_bound`, then cancel the normalization.
No independence hypothesis is used anywhere in this theorem. Shared shocks,
herding and common infrastructure failures remain inside the joint law.
Taking e_i=C_i epsilon recovers epsilon/(1-H/C).

`pool_ratio_gt_one_iff` records the positive-hazard ratio identity.
`independent_pool_threshold` wraps the existing Hoeffding theorem with its
equal delivered shares C/n, independence, range, measurability, mean and
positive-gap premises intact. The unequal-capacity correlated result does not
assert an equal-share exponential tail for unequal weights.

## Verification and exact reuse

The candidate canon has 329 modules and 2,014 public theorem/lemma names.
The fresh verification scope is seven modules and 24 public statements:

1. FoundingDominance
2. FoundingPivotal
3. FoundingAnchor
4. NarrowPlace
5. CorrelatedHolding
6. EnergyFounding (seven new statements)
7. SwarmFounding (three new statements)

Three inherited modules have only their imports narrowed to the specific
Mathlib dependencies needed here; their statement/proof bodies are unchanged.
Their body hashes are checked by the verification script. No other canon
module imports this seven-module closure, so no unchecked downstream module
is silently affected. All other 324 source files match the full run 10 PASS
receipt byte-for-byte. That receipt is reused for them, not called fresh.

The scoped receipt checks zero compiler output, kernel replay of every one of
the seven modules, all 24 statement axiom dependencies against propext /
Classical.choice / Quot.sound, and the original strict completeness and claims
gates. The full 329-module build/audit manifests and all 2,014 index entries
are updated; a fresh full 329-module compilation is not claimed.

Local receipts additionally scan the author's actual BANKS corpus. CI's
checkout has no author BANKS, so its completeness result covers the canon
build/audit manifests and repository-visible corpus only.

Reproduce with Lean 4.35.0 and a Mathlib project at
56a005855ea17e0b0958f73ec801ae140b0a1679:

    python3 evidence/compiled-strongest/tools/verify_energy_swarm.py \
      --mathlib-project /path/to/pinned-mathlib-project \
      --receipt-dir /tmp/energy-swarm-receipt \
      --corpus-root /path/to/Snuffy-Book

CI uses checks/energy-swarm/ and uploads its own fresh receipt. The separate
local receipt is verification/ENERGY-SWARM-2026-11-03/RECEIPT.json.

## Remaining application work

This delivers the named Part XIV Lean compilation task. Actual founding and
commissioning remain: the founder's commitment and own benefit margin,
physically controlled refundable stock and posted bonuses, payment identity
and authorization, complete startup/continuing work charges, joint instrument
and common causes, retained memory, controller/export binding, actual swarm
C/epsilon/H/n and physical K_act/v_a bounds with calibration, drift and
exposure duration. The sensor/controller and source-correspondence work in
the other rungs remains separately tracked. No merge, deposit or release is
performed by this increment.
