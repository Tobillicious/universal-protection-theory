# Audit of the pasted five-gap closure proposal

20 October 2026. **The claimed closure fails.** The attachment is preserved byte-for-byte.
The tested formulas from the chat are transcribed in inputs/proposal-extract.json. They are hypotheses,
not additions to v0.17.10. The exact checker is checks/proposal.py.

## A decisive contradiction

Assume the proposal's natural domains: Delta > 0, capital K > 0, financial liabilities FA_i >= 0,
coalition resource R_coal >= 0 and total resource R_total > 0. Its finance inequality says

    sum FA_i <= K(1 - 1/Delta).

The right side must be nonnegative, requiring Delta >= 1. Its coalition inequalities say

    R_coal < mu R_total,      mu <= (1-Delta)/2.

The strict resource inequality requires mu > 0, so the second inequality requires Delta < 1.
These requirements have an empty intersection. This is independent of the numerical capital values,
phase lengths, or threat multipliers. Changing those numbers cannot fix the two inequalities.

In twilight, the stated lower bounds already give Delta >= 2.1 × .9 = 1.89 and mu <= -.445.
A nonnegative coalition resource cannot satisfy the resulting negative strict upper bound.

## Gap 1: the proposed reference is not derived

- .841 and .032 have no supplied physical derivation, unit calibration or measurement.
  They could be labelled proposed parameters, but their selection does not close the gap.
- The trigger is exactly 1.15 × .841 = .96715. The stated growth fidelity ends at .95.
  Under linear interpolation of the stated 301-to-1200 endpoints and zero averaging lag,
  the trigger is crossed at 411643/600 = 686.071666666666666, during growth. This interpolation
  is an illustration; the moving-average window was not specified, so an actual trigger is undefined.
- The growth threat .20 + .00039t equals .668 at t = 1200, exceeding its asserted .55 ceiling.
  A line through (.20 at301, .55 at1200) instead needs slope 7/17980 and an offset from301.
- The stated minimum founding protection target gives net margin .0225 at t = 0, below the
  claimed uniform .09. The .09 is attained at the final founding threat, not throughout.
- At the stated minimum targets, net margins are .09, .33, .20 and .99 at the selected phase
  reference points. Those targets do not imply earlier margins greater than twilight's.
  Larger actual earlier targets could change this, but none is supplied or priced.
- MN2 in the existing theory compares population fade with capacity fade. It is not a money
  amount or an equation equating protection to threat. Multiples of “MN2” have no defined units.
- Strictly positive margin at each earlier time need not be uniformly bounded away from zero.
  The function g(t) = t_twilight - t is positive before twilight and has infimum zero there.

## Gap 2: neither physical capability nor recovery is proved

A forged message and a physical halt are alternative attack routes unless the architecture proves
otherwise. A lower bound for a route requiring irreversible erasure does not bound every route
that stops execution while leaving stored bits intact. The max of two proposed costs is therefore
not a universal attack lower bound. No energy conversion for computational cost is supplied.
Landauer's bound concerns logically irreversible information operations; applying it to every
island disablement needs another argument.
[Bennett's primary thermodynamics review](https://research.ibm.com/publications/the-thermodynamics-of-computation-a-review)
states the relevant distinction between erasing a record and other operations.

The recovery sum omits the physical outage, waiting for stable return, and the existing reseed work.
The variables m, d and sigma are not connected to an island model or a proved stochastic process.
Neither the displayed diffusion-like bound nor a dollar penalty yields a finite physical return time.
The corrected rolling-envelope lemma from the frozen v0.17.10 audit remains the applicable conditional
target; its primitive bounds still require evidence.

At the trigger, Phi/(Phi-Phi_crit) is 23/3, which is finite. The claimed “logarithmic dissipation
divergence” does not follow from that limit. More basically, a large expected survival time does not
certify a small early-failure probability. The checker constructs a lifetime .01 with probability .99,
and 10000 with probability .01. Its mean is 100.0099, exceeding recovery deadline1, while 99% fail first.
The requested theorem needs a conditional tail bound over the whole declared horizon.

## Gap 3: the financial ledger is a different object

The original 21 accounts are probability bounds for events such as common failure, committee failure,
quorum liveness, holding, rescue, confidentiality and integrity. The attachment substitutes 21 financial
debits. It supplies no event mapping, probability bounds or recomputation of the original accounts.
Assigning the first four accounts to founding and the last five to twilight also leaves applicable
failure events unaccounted for in other phases.

The dollar prices have no bill of materials, capacity mapping, date-to-cycle conversion, financing
source or conversion from the existing model stock units. Their adequacy is undetermined.
At the stated key-only prices, 64 founding nodes cost $768 per cycle, using $50,000 in about65.10
cycles before any other expense; 1024 growth nodes cost $8192 per cycle, using $250,000 in about30.52
cycles. With an unspecified cycle length, neither calculation verifies a 180-day reserve.

The withdrawal penalty is reversed at its most important endpoint: at zero notice,
Bond(1-exp(-notice/T_rec)) is zero. It rises with longer notice. The SLA formula computes a possible
charge after a missed deadline; it does not supply repair work, available hardware or a timely recovery.
The preactivation formula adds a cryptographic cost to an undefined multiple of MN2.
The emergency-fund formula multiplies an attack cost by an inverse-time rate without supplying the
time factor or currency conversion needed for a reserve.

## Gap 4: named mechanisms do not establish a joint contract

ORAM needs an actual algorithm, adversary view, parameters, stash/failure bounds, client storage,
bandwidth and CPU costs. Its usual security definition compares access-pattern distributions for
different equal-length requests; invoking ORAM does not prove that all power, timing and network
observations are uniformly random or independent of placement.
[The primary Path ORAM paper](https://people.csail.mit.edu/devadas/pubs/PathORAMJACM.pdf)
gives the security definition and nonzero storage/bandwidth requirements.

Exponential delay has unbounded support, so a finite hard deadline requires truncation, a failure
allocation or another scheduling rule. Those costs are absent. The leakage formula uses
epsilon in bits/cycle with sqrt(t), and the redraw trigger compares accumulated bits with a rate;
the units do not agree as written. Even a corrected sublinear leakage bound does not erase what
an attacker learned before redraw.

The displayed advantage bound divides leaked information by attack energy without a dimensional
model. Its right side changes when the energy unit changes. A 256-bit parameter also cannot silently
replace the existing 459-effective-bit per-prefix contract. Substituting256 into the existing
per-attempt horizon accounting yields a union upper bound greater than one, not a useful certificate.
That says the proposed certificate is insufficient, not that actual 256-bit cryptography certainly fails.

A signed erasure statement is compatible with two worlds: one erased every copy and another retained
an unobserved copy. The certificate alone cannot distinguish them. Attestation-triggered isolation
must also count false isolations against the same island allowance. An instantaneous remote rollback
does not pay the existing nonzero detection, communication, quorum and fencing times.

## Gap 5 and disposition

The final “proof” assumes the preceding closures and replaces the required horizon probability bound
with a composite-loss inequality that is itself asserted. The capital/coalition contradiction alone
prevents a consistent instantiation. No indefinite-horizon theorem follows from the finite
10^100-date construction.

All five closure claims are rejected. Useful retained items are the four-phase organizational template
and the requirement to meter all-cause losses, keys, repair, privacy and preactivation care.
The actual new benchmark and k3 numerical screen are documented separately in RUNG4-CANDIDATE.md.
