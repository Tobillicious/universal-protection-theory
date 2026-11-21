# Rung 4: source-enforced founding failure settlement

Lemma F' already provides the all-necessary founding mechanism and collateral
arithmetic. This increment constructs an executable failure-settlement
controller and joins it to that mechanism. Its accepted queue settles in full
under every adaptive anchor-request policy. The fixed source epoch starts
with an admitted failure queue; actual campaign registration, failure/default
trigger, custody and physical transfer correspondence remain explicit.

Parent: draft PR 223, head 4bc750d3524eac4d5208fa91e4b6d92d1ec3fcdd.
The maximal UPT target, full historical and reference requirements, complete
work bill and original risk budget remain fixed. No universal voluntary
adoption premise is introduced. The established holding alternative for an
uncooperative mind is retained.

## The executable source

`PhysicalBridges.AnchorPledgeForfeiture` is import-free Lean. Its byte-identical
canonical copy is `Snuffy/AnchorPledgeForfeiture.lean`; both define the same
public namespace. The two copies are checked in separate build environments.

Each immutable ticket contains a recipient, full refund, failure bonus and a
separately funded complete service charge. State keeps free stock, reserved
refunds/bonuses, reserved service work, the anchor's posted bond, withdrawals,
forfeitures, the remaining queue and the full paid-ticket history.

`commit` checks the entire bond + cash + service liability before admitting
the queue. `accepted_commit_certificate` derives readiness, conservation and
the exact initial ticket list from that executable acceptance result.

The command alphabet is finite: idle, withdraw all free stock, or breach.
Its values contain no unbounded attacker-controlled numeric payload hidden
inside a constant service charge. Arbitrary strategy functions may inspect
the complete current state and time when choosing each request. A withdrawal
can consume only the free account. Breach transfers the entire posted bond
to the forfeiture account and zeroes the bond. The source retains forfeiture
monotonically at every later prefix; repeated breach creates no second bond.

Every nonterminal `tick` automatically settles the next ticket if its full
refund + bonus and service work are funded. There is no command that releases
the reserved accounts to the anchor, changes a ticket, cancels the admitted
queue or waits for the anchor's permission to pay. Completed epochs are
quiescent; later operations require a separately charged source epoch.

The complete ledger includes remaining accounts, withdrawn/forfeited amounts,
paid refunds and bonuses, and already spent service work. Its conserved total
is the original accounted budget, not a claim that spent energy remains
available. `Ready` separately bounds the still-unpaid cash and service bill.

## Source theorems

For every admitted state and every adaptive request policy:

- the complete ledger is conserved at every finite prefix;
- the remaining refunds, bonuses and complete service costs stay funded;
- paid tickets followed by pending tickets equal the original full inventory;
- one ticket is paid on every nonterminal funded tick;
- after the original queue length in ticks, every full ticket is in the paid
  history and the remaining queue is empty;
- a processed breach consumes the bond, and no later prefix reduces forfeiture.

The theorem is over runs of this specified controller. It supplies no physical
clock, accepted-event completeness, actual payments or hardware integrity by
itself. Those are the existing source/installation correspondences.

## The Lemma F' join and the unchanged complete bill

`Snuffy.FoundingEscrowBridge` computes a deterministic recipient-sorted ticket
queue from the actual finite contributor set S. It proves the exact sums of
refunds, bonuses and service charges, no duplicate recipients, and no duplicate
recipient in any paid prefix. It uses computable finite sorting rather than
an arbitrary noncomputable enumeration.

Let N be the eligible ordinary funders, A the anchor's posted pledge/bond,
R its stock, p_i each received pledge, b_i the posted failure bonus and w_i
the complete settlement-service charge. Itemise the ORIGINAL complete
activation bill d as

    d = a + sum_{i in N} w_i.

Here a is charged before this settlement epoch. The original collateral gate

    A + d + sum_{i in N} b_i <= R

then funds every S subset N. Its received pledges sum p_i remain refundable;
the same pledges are not counted as bonus income. After charging a, source
admission uses R + sum_{i in S} p_i - a. Subset sums prove that the whole bond,
queued refunds/bonuses and service work fit in that stock.

`every_subset_has_source_guarantee` constructs the accepted source witness for
every S from that same committed bill. `collateral_backed_all_necessary`
composes this guarantee with PR 223's all-necessary founding result: the
positive bonus, positive ordinary pledges and pivotal benefit margin are
exactly the existing mechanism's premises. The already-funded public-good
case is not substituted for the original construction. Each founder's
commensurate valuation and the anchor's actual commitment remain as stated.

## Verification

There are 44 additional public statements: 33 in the source controller and
11 in its canonical bridge. The candidate canon has 331 modules / 2,058 names.

The scoped checker freshly compiles and kernel-replays nine canonical modules
and audits all 68 public statements in that dependency closure. The other
324 modules byte-match the full run-10 receipt and reuse it. The three earlier
import-only revisions keep their checked proof-body hashes. The full strict
build/audit manifest and claims gates are updated; no fresh full 331-module
compilation is claimed. The physical package builds the same controller in
its separate environment.

Runtime fixtures exercise all 27 three-request paths for three full tickets,
including free withdrawal, repeated breach, exact refund/bonus/service totals,
unchanged ticket payloads, terminal quiescence, unfunded admission rejection
and an explicitly missing-service-reserve case that cannot complete.

Reproduce the canonical increment with pinned Lean 4.35.0 / Mathlib
56a005855ea17e0b0958f73ec801ae140b0a1679:

    python3 evidence/compiled-strongest/tools/verify_energy_swarm.py \
      --mathlib-project /path/to/pinned-mathlib-project \
      --receipt-dir /tmp/anchor-pledge-receipt \
      --scope-file evidence/compiled-strongest/checks/anchor-pledge-scope.json \
      --corpus-root /path/to/Snuffy-Book

The older seven-module Part XIV receipt is frozen at PR 223's source pin; its
default scope is retained. The new explicit scope includes both new modules,
checks source/canonical byte identity, and rejects unchecked downstream imports.
The public local receipt is under verification/ANCHOR-PLEDGE-2026-11-03/.

## Outstanding source correspondence

The source epoch begins with the actual admitted failure queue and the checked
available stock. Registration, receipt/authentication of incoming pledges,
first commitment and pre-failure custody, the trigger attributing default,
physical escrow access control, complete external-effect mediation, actual
recipient identity/transfers, wall-clock progress and calibrated complete
service costs remain installation/source work. The previous stock and work
ledgers are retained; a conservation identity is not a substitute for them.

Sensor coverage and the physical-meter task in Rung 4 remain open. The fixed
finite command interface must be bound to the actual controller/export source;
arbitrary physical actions are not asserted to be covered by a software type.
The full joint instrument, common causes, retained memory, K_act/v_a,
calibration, drift, exposure duration and founding/commissioning remain.
No merge, deposit, release or global physical-UPT verdict is performed.
