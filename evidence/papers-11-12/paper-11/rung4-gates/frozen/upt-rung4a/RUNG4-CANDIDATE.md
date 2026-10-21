# TW-1 benchmark, full-pool founding route and exploratory k3 plant

20 October 2026. **Rung 4 is not established.** This bank gives it a concrete numerical target and
a proposed stronger earlier plant. The static numerical screens pass. The generalized joint service,
commissioning and phase-transition proofs remain open. The pasted “all gaps closed” proposal fails
independently; see PROPOSAL-AUDIT.md.

## Numerical reference and metric

TW-1 is the frozen JW2.6 k2 plant for a400-island pool: 1032 minds and288 providers per island,
energy flow1171.2 and margin .196358528503937007; memory4508.28318 of4512; interconnect
23.2428344808873598 of23.25; care .935879553894114257 and provider response .947109937213716052
against .95. The full 21-account bound plus reserve is2.06401198286124585e-7.

The comparison vector uses integer tolerance above an all-cause demand of two islands; normalized
energy, memory, interconnect and deadline headroom; the full fault-rate boundary; and remaining
probability budget. A strictly smaller failure upper bound means a larger probability-budget margin.
This avoids replacing the existing model with an uncalibrated “fidelity fraction.”

TW-1 is a design benchmark, not an observed cosmological forecast. The proposed earlier plant keeps
the same threat premises and installs more redundancy and service capacity. Its price targets and
the external availability of the phase-specific plant must be justified independently.

## Explicit model-date schedule

Let T_end=10^100 dates and one schedule epoch=10^6 dates:

| Phase | Half-open interval | Active complete pools |
|---|---|---|
| Founding | [0,10^6) | One commissioned pool |
| Growth | [10^6,59×10^6) | 58 epochs, min(2^(j+1),2.5×10^17) pools, j=0..57 |
| Maturity | [59×10^6,T_end-58×10^6) | 2.5×10^17 pools |
| Twilight | [T_end-58×10^6,T_end) | 58 epochs, ceil((2.5×10^17)/2^(j+1)) pools, ending at one |

The complete exact exposure counts are in BENCHMARK.json. Active islands never exceed10^20, and
total pool-dates stay below2.5×10^117. Within each active pool the proposed assumptions remain
p=.002, zero additional mixed host shocks, and all-cause unavailable-island demand at most two.
No shorter-window reduction in p or derived global attacker fraction is claimed.

Twilight's cell-level capacity and protected population can fade together only if the retiring cells
have no remaining protected residents: natural or authorized departures must support the schedule.
Forcing minds to disappear to fit capacity is not permitted. This is a scenario condition, not a prediction
or a funding proof. Care before time0 is outside this post-activation schedule and remains unproved.

## Founding capital target

The full-pool route avoids applying a400-island service calculation to an8- or60-island seed.
At the old point, one full seed has412800 identities,115200 providers and stock478950400 model units.
The proposed k3 point requires684569600 stock units for the seed.

The proposed per-island stock is1711424, up514048 from1197376. The incremental price targets are
242 host upgrades at2048 each, ten passive sites at1024 each and fabric upgrades at8192.
Incremental installed idle draw is10 per island-date. A fully endowed maximum-sized world at these
prices would require1.711424×10^26 stock units. None is a dollar quotation.

This states the capital requirement; it does not establish who supplies it, how commissioning is
performed or how care is provided before activation. Adding complete pools also needs a metered
construction and admission schedule. These remain founding gaps.

## Proposed stronger earlier plant

| Quantity | Earlier k3 target/screen | TW-1 |
|---|---:|---:|
| Compute hosts / passive sites | 242 /90 | 242 /80 |
| Guaranteed live compute hosts | 171, tolerating71 local failures | 172, tolerating70 |
| Local copies per image | 73 | 71 |
| Foreign images / key sharing | 3 /4-of7 | 2 /3-of5 |
| Memory use / cap | 5176.21942 /6144 | 4508.28318 /4512 |
| Foreground/background CPU cap | 304 /64 | 152 /14 |
| Foreground/background wire cap | 126976 /32768 | 63488 /3072 |
| Interconnect activity / allocation | 42.2854531067389168 /45 | 23.2428344808873598 /23.25 |
| Energy margin | 11.4295262740157480 | .196358528503937007 |
| Care / provider response | .735944416355558439 /.911724226361229306 | .935879553894114257 /.947109937213716052 |
| Checkpoint lag | .20039162503125 | .246047942676711309 |
| Authentication inventory / protected cap | 2078579400 /2130000000 | 1875437944 /1879048192 |
| Certificate inventory / work cap | 4228 /4288 | 4218 /4224 |
| Canonical batch maximum / cap | 835 /1024 | 70 /344 |
| Repair byte-work / auth-work screens | 19 /32 dates | 64 /27 dates |

The last row is a work-volume projection, not an end-to-end repair schedule. New copying charges
conservatively include rebuilding two retained generations. Partial attempts, dependencies, concurrent
source/receiver progress and the full32-date calendar are still to be proved.

The fresh key scheme uses512-bit keys and three512-bit coefficients each checkpoint. The
effective459-bit per-prefix cryptographic contract and2^31 attempts/gate/date are retained; no
256-bit substitution or dirty-ciphertext assumption is made. Authentication fits a larger protected
service reservation inside the same attempt cap. This leaves fewer untrusted attempts and requires
the admission implementation to enforce the new partition.

The finite-field4-of7 and19-read Hall sublemmas are proved in K3-SUBLEMMAS.md. The placement here
is public adjacent. Secret placement, ORAM, anonymous transport and Mode C implementation are not
silently included as free additions.

## Conditional 21-account and phase comparison

The numerical ledger keeps ten response/effort rows and all21 canonical accounts. It updates the
site-loss subset union to80 failures among332 sites, local quorum loss to72 among242 hosts, committee
work capacity to4288, capital/wealth, and passive-site counts. It retains the other predicate forms
only under the unproved generalized interfaces. All ten incentive/extraction screens remain positive.

The resulting worst numerical bound is2.05872970136994941e-7. Its full-budget p grid bracket is
.002384489094136 safe /.002384489094137 failing. These are exact-ledger certificate boundaries,
not measured physical failure rates. All selected static margin comparisons with TW-1 are strict.

Using the full world-horizon bound separately in each phase gives the conservative union screen

    3 R_k3 + R_TW1 = 8.24020108697109409e-7 < 10^-6.

This needs no independence. The common10^-7 account and the distinct certificate reserve are kept
separate. A jointly warranted global common account could be counted once, but neither uniform
time spreading nor independence follows merely from its horizon bound.

## Remaining gates

The numerical results are insufficient for a completed joint k3 witness or rung4 theorem. Required:

1. A full concurrent repair/read/retry calendar and its admitted partial-work bound.
2. Generalized snapshot reuse, key exposure/release and journal contracts supporting every retained
   probability predicate and the priced host/controller service.
3. Paid commissioning and capital supply, plus preactivation care if included in the jurisdiction.
4. A k3-to-k2 twilight transition with no extra unpriced retained generation, care interruption,
   quorum gap or workload spike. Transition overlap must be charged to the correct phase.
5. An independently justified external capacity/population trajectory and the existing trusted-machine,
   clock, erasure and conditional common-failure warranties.

The candidate has moved from an unspecified “larger margin” to a numerical plant and explicit proof
obligations. The unproved gates remain failures of closure, not implementation details to omit.

The existing all-cause two-island capability cap remains a premise. Problem0b is still open.
