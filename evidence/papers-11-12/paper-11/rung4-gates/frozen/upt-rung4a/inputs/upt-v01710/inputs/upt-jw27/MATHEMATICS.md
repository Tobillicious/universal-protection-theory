# JW2.7 exact audit and scope

20 October2026. The numeric result is a partial ordered prefix, not a rung4 proof.

Let U(n,r,p)=min(1,C(n,r)*p^r). Conditional distinct-site subset bounds imply U by union over r-subsets. They do not imply a binomial tail. No independence of successive windows is needed for a union bound over a valid complete cover, but the cover itself must be supplied.

With E=10^120 island-dates, the p-dependent part of the frozen JW2.6 ledger is

    P(p)=E*[2*U(322,79,p)+U(242,71,p)+U(242,110,p)].

The two79-site entries are care MPC and background overflow;71 is the added physical compute-quorum bound;110 is the inherited care-slot/spreading bound. Preserve the old job-quorum entry separately. Let C be the exact worst21-account total plus reserve at p0=1/500. Then

    R(p)=C-P(p0)+P(p).

Every term outside P is retained. The exact common budget and cryptographic terms do not disappear as p tends to zero. All ten rows have the same p dependence, so their maximizing row stays the same. The boundary is certified with adjacent rational grid points of denominator10^15, one safe and one failing. check_bank.py also calls the frozen full ten-row calculator at both brackets, with its original site-count/stock parameters adjusted exactly as JW2.6 did, and adds the physical71-compute term independently.

For a new complete window cover of size n_w per date, replace P by n_w*P(p_w). This is a different temporal contract, not a consequence of P-FAULT. At the audited pre-window history, draw independent Bernoulli(1/500) site faults, placing each event in the intersection of the two compared nested windows. Every r-site subset has probability(1/500)^r at that history, yet the shorter window retains the same events. They can have duration smaller than both windows. A subset probability bound alone therefore cannot provide the missing uniform fault-start intensity bound. The comparison does not carry known failures as fresh .002 trials at later histories; a full temporal model/cover still has to be supplied. An earlier persistent-across-horizon example was discarded for precisely that conditioning problem.

The illustrative temporal envelope assumes a conditional fault-start intensity/subset law with lambda<=p_ref/(1+d), maximum residence d, and an exhaustive indexed cover. Here the reference window is one date and d is in those units. It gives p_w<=p_ref*(w+d)/(1+d). The source upper bound at w=1 cannot be inverted to infer the intensity bound: that is an additional premise. For arbitrarily overlapping recovery windows, n_w=ceil(1/w) is not automatically a valid cover; an implementation may need a larger envelope or longer cover windows. The result is conditional sensitivity only.

At d=0,w=1/2, a single r-subset term shrinks by2^r. Doubling the number of windows leaves2^(r-1). JW2.6's71-compute term dominates the79-site entries, so the dominant physical gain is2^70 after the doubled count, while the full ledger approaches its unchanged nonphysical total. For d>0 the gain is weaker. For whole-island unavailable duration D+R, halving reseed time R gives duration ratio(D+R/2)/(D+R), approaching one when D dominates R. A64-date whole-island reseed bound is not the local date-union fault window.

For the same conservative serial endpoint-progress certificate as JW2.6, total endpoint wire L=1890780.8486328125, startup allowance2 dates, and desired R>2, choose

    Q>=ceil[L/(R-2)],
    A>=ceil[407912448/(R-2)].

Also retain urgent endpoint/auth reservations. Returned-store auth is512 units per endpoint record, with both ends conservatively charged. The endpoint energy tariff is COPY/127+2e-5=13/400000. New full-bucket interconnect activity is old_activity+(Q-30720)*13/400000. Round its paid allocation up to the next quarter unit; subtract the increase from the old energy margin. This is a specific full local quota reservation, not a universal lower bound for every repair schedule. Increased quotas need fresh maximum-host/retry/calendar, idle power, capital, certificate and authentication pricing.

The serial global bound can be loose. A single returned store has796704 endpoints counting both ends, or796844.15673828125 with headers/control. Its isolated byte screen is28 dates at the existing30720 quota; authentication screen27. A simultaneous physical-load/progress proof is still missing, so neither a free28-date repair nor the necessity of the more expensive32-date quota is asserted. More parallelism may improve the certificate without new hardware.

On urgent care, isolate the fixed serial terms:

    L_fixed=1/20+1/100+1/8+1/20+1/20+228/4096+49/256+1/400
           =0.5345703125.

The old deadline is L_fixed+L_service. If every foreground CPU/NIC/fabric service were sped up uniformly by s, with no additional queues, the projected deadline is L_fixed+L_service/s. For a target D>L_fixed, s>=L_service/(D-L_fixed); D<=L_fixed is impossible in this unchanged serial-stage model. These are service targets, not a priced or implementation-verified plant. The.475 half-deadline fails even as s tends to infinity. In particular, fencing cannot be shortened by merely increasing CPU.

For a k=2 founding pool of n islands, any honest-intersection pool quorum needs2q-n>2, while available votes require q<=n-2. Thus n>=7 is necessary. Five distinct key locations independently require n>=5. After two whole-home losses, exiles/survivor are at least ceil(2064/(n-2)). Eight care slots on172 live hosts require at least n=8; the actual JW2.6 six-exile envelope requires n>=346. None is a sufficiency theorem. At small n, placement, service, capital, quorums, certificate and population ledgers must be rebuilt.

Four phase intervals are defined symbolically; durations, populations and exposures remain unknown. There is no intrinsic scalar ordering of k, energy and probability margins. The report explicitly uses normalized resource headroom only for a full-pool utilization comparison. The weak MN2 inequality admits equal proportional stock/capacity fade, hence equal normalized margins. Strict twilight separation needs additional quantified assumptions and a stated reference. An equal allocation of a common bound is ledger bookkeeping; it does not turn a correlated horizon event into independent date hazards.

All computations use Fractions; decimal displays are floors. No fault-arrival calibration, measured hardware, price quotation, faster complete repair protocol, or global minimum is supplied. Existing JW2.6 interfaces remain conditional on their common/premise allowance.
