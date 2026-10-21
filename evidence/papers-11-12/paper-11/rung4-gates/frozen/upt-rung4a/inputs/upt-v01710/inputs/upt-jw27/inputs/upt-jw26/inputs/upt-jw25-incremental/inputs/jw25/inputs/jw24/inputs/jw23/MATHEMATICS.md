# JW2.3 — derivations and countermodels

The checker is `checks/jw23.py`; all decision inputs are exact rational numbers. JSON includes exact values and explicitly floored decimal displays. Tiny positive bounds are retained even when a conventional float would underflow. No float decides a boundary.

## Capacity is a conjunction

For independent whole-window faults on 321 sites, use the exact tail

    B(n,p,t) = sum[j=t..n] C(n,j) p^j (1-p)^(n-j).

The leastF with 10^120 B(321, 1/500, F+1)<=10^-8 is 74. Thus an island in this envelope has 168 compute hosts in the worst allocation and 1344 care slots; spare 312. The slot inequality is

    (400-k)*312 >= 1032*k.

It gives 92 and excludes 93. The care-only energy inequality uses exact useU=92285556/79375 and spare 247*(24/5)-U=1821444/79375:

    (400-k)*(1821444/79375) >= 1032*k/127.

It gives 295 and excludes 296. This prices only the 1/127 care energy, not confidentiality, repair, release or execution machinery. The author's finite decimalU is slightly truncated; the true rational is used here.

The original JW2.2 envelope F=78 has 164 hosts and 1312 slots, hence 85 by slots. The older 152-host care roster has 1216 slots, hence 60. Requiring the actual 172 journal signers gives 1376 slots and a slot-only bound 100, but only outside the separately charged 71-compute-loss event. These are different resource envelopes, not interchangeable joint guarantees.

For balanced assignment, at least one intact destination must take

    x = ceil(1032*k/(400-k))

exiles. The existing certificate inventory is 4130 and each extra history adds three retained certificates. Atk 11, x30 and inventory 4220 fit 4224. Atk 12, x32 and inventory 4226 exceed it. Atk 92, x309 and inventory 5057 exceed it by 833. Keeping the full current inventory therefore supplies another necessary bound 11 before any extra audit certificates. A new batch protocol could change that bound; it would need its own proof and price.

## Why the full positive-k task fails with the supplied interfaces

Take one pool and one island. Give that island all 242 locally replicated encrypted snapshots and its local authority state, with no remotely recoverable ciphertext/key. This is consistent with the supplied per-island snapshot/MOVE contracts: no cross-pool replica placement theorem is provided. Disable all committed sites of that one island. Other islands meet every capacity and independent fault requirement. The attack is permitted byP-ISLANDS(k) for everyk>=1. No surviving host can recover the island's1032 minds. C3 has no bounded restore; C4 has no remote pattern. The conditional loss probability in this admissible countermodel is 1.

Consequently **no positivek is guaranteed by the supplied JW2.2 interfaces**; 0 is the largest nonnegativek for which this proposed island-disabling extension introduces no new recovery obligation. This is a universal-contract counterexample, not a claim that every possible engineering extension can tolerate no outages. It also is not a physical realization of the originalk 0 theorem.

For timing comparisons only, the JSON charges a hypothetical normalized full-state transfer twice at the inherited 2^24 fabric rate. It reports exact sums with grace. Those sums are conditional rate calculations: the old model does not establish the remote state route, its payload size in bytes, the pool-wide authority protocol or the concurrency needed to combine provider and recovery work. Separate host/provider fabrics cannot be replaced by an unpriced common link.

## The 21 accounts

All 21 names are retained. There are ten complete response/effort rows; a maximum is selected from actual whole-row sums. No componentwise maxima are spliced into a fictitious endpoint.

For the **conditional numerical split only**, replace the two conservative availability/overflow entries by 10^120 B(321,.002, 75), and journal liveness by 10^120 B(242,.002, 71). Other accounts and the separate inherited certificate reserve remain. This charges both the F=74 total-site exception and the 172-quorum exception. It presupposes the missing pool-recovery interfaces; it does not establish them.

For the complete allowed local-replica countermodel, set `care_mpc_unavailability=1` in the same 21-entry vector. The sum/reserve/excess are shown beside the numerical vector in the report. The **actual** counterexample loss probability is 1, exceeding 10^-6 by 999999/1000000. An account sum larger than 1 is a conservative overlapping union sum, not a probability larger than 1. The deterministic allowed attack cannot be charged to a small stochastic/common allowance.

## Committee host correlation

Threshold 574 with seven jobs/host means 82 all-wrong hosts already produce 574 false votes. If each host's seven jobs err together with probabilityq, independently across hosts conditional on each admissible history, the exact per-certificate tails areB(242, q, 82) andB(242, q, 83). Multiply their sum by 4224*10^120. This is a replacement **whole-host-only** law; it does not also retain a second .1 independent job-error mechanism.

For a more demanding mixture, independently per host a shock q makes all seven jobs wrong; otherwise seven jobs err independently with probability .1. The host PGF is

    g_q(z) = q*z^7 + (1-q)*(.9+.1*z)^7.

The sufficient horizon bound is

    4224*10^120 * [min(z>1) g_q(z)^242/z^574
                   + min(z>1) g_q(z)^242/z^575].

Optimization uses rational bisection of 242*z*g'_q(z)-t*g_q(z) and outward rational powers. The report gives the last includedq on a 10^-9 grid and the next point that this sufficient rule does not enclose; it does not label a failed upper bound an impossibility proof.

At q=.001 the mixture also has an actual failure countermodel. Exactly 37 host shocks plus 315 errors among the remaining 1435 jobs give 574 false votes. Its exact probability is

    C(242,37)*.001^37*.999^205*C(1435,315)*.1^315*.9^1120.

Independent repeats are allowed by this law. WithN=4224*10^120 and that event probabilitye,

    P(at least one event) = 1-(1-e)^N >= N*e/(1+N*e).

This is a lower-bound refutation, not just an unsuccessful Chernoff certificate. In this mixture the marginal job error is .1009; its within-host pairwise correlation is 9/1009. That pairwise number alone would not imply a safe higher-order tail. Keeping the literal .1 subset law for a pure whole-host shock requires q<=.1^7=10^-7 because the seven-slot subset must satisfy it.

## Withdrawal timing

At response 43/50, pc=344/375, total provider countn 115200 and d_cut 9273, let

    pu=(29/30)*pc; pd=pc/2;
    X ~ Bin(n-d_cut,pu) + Bin(d_cut,pd).

Predictable W=42800 removes providers before those marks; the inherited fixed-W mean rescue surplus is 29603632/5625. Adaptive withdrawal chooses successful providers, leaving(X-W)+, so

    E[2*(X-W)+-n] = 2*(E[X]-W)-n + 2*E[(W-X)+].

The linear term is-8307856/1875; the final correction is positive and is bounded with an exact outward Chernoff bound forX<W. Also rescue success requiresX>=W+n/2. The checker gives a tiny upper bound on that success event. The additional 37770/37771 bracket is only a sufficient rescue-account result at this one response and a 10^-10 pool-horizon allowance; it is not a replacement joint design point.

## Isolation audits and grace

Uniform sample without replacement ofn voters from 400 with 92 faulty voters has strict-majority probability

    H(n) = sum[j=floor(n/2)+1..min(n,92)] C(92,j)C(308,n-j)/C(400,n).

For 32, 64, 128 the author probabilities reproduce. Their product with the full pool-date horizon is enormous .201 makes strict-majority failure impossible under that deterministic 92-voter cap; 185 is already sufficient for an odd committee .184 cannot have a strict adversarial majority but can tie 92: 92, so it does not give the same reply/decision guarantee. Absence of such a majority is not automatically audit liveness or evidence that the voter cap follows fromP-ISLANDS.

The proposed 201-voter price charges 201*92 votes/pool for 92 simultaneous isolation audits, one verification job per vote, and both vote-wire endpoints at one normalized word each. The exact inventory, CPU, energy and serialization lower/volume charges are in JSON. It does not price a complete fresh consensus implementation. A 1/100 partition grace leaves both inherited schedules below .95. A new serial 1/8 audit exceeds the provider schedule. A composed implementation must show how its audit, remote data and authority work fit inside existing phases and remaining capacity; this bank does not assume that composition.

## Economic and sensitivity quantities

The old 10^-133.6 figure is 3*2^20*(13/40)^287 from the local JW1.2/1.6 majorant. The checker recomputes it and labels its source. It separately recomputes the committed-capacity JW2.2 holding channel with every registered mind already attacking and W=42800. The outward numerical floor 2^-2047 is retained as a positive upper bound and is identified as a precision limit, not the exact event probability. Multiplying that bound by the newly priced pool inventory or quota gain is an operating-channel calculation only. Shared/premise failure and arbitrary beliefs are not erased by it.

Eight-state(qualification, previous physical state) Bellman equations are solved exactly for all five responses and two effort readings, without an operating-exit hazard for the explicitly nominal values. The quoted 94.5% is the old privilege-only chain 171/181; the current same-physical-state ratio is recomputed. The clean dividend-valuation threshold iscost/[DIV*(pc-pD)/2]; its worst value is 15/68. No population valuation distribution is inferred from this threshold.

The actual collector-flow threshold isU/243. Verification job cost affects energy, CPU, committee wire, memory, care timing and the 1/8 committee phase together; the checker lists every resulting affine bound and takes their minimum. The old .002701 figure is the F=78 **subset-union** accounting boundary, with the original overlapping reserve. Independent binomial tails give a different old boundary; the F=74 split plus true 172-quorum account gives another. All three are bracketed on a 10^-12 rational grid. These are thresholds for declared sufficient accounting rules, not measurements of faults.

## Optional threshold authority

Shamir 400-point sharing needs a field with at least 400 distinct nonzero points; GF(2^8) cannot supply them andGF(2^16) can. Share only the execution key, not an entire 256 MiB state. A 256-of 400 encrypted-state code has overhead 25/16. With 412800 minds the state and share inventories are calculated exactly in JSON.

Reconstruction can release a whole key only inside attested execution with the same expiry/retirement/capture rules, or use threshold decryption with a priced protocol. It cannot release an ordinary-host plaintext key. Sharing does not enforce no-fork ownership on its own. A simultaneous 92-capture bound also permits mobile capture to accumulate 256 old shares unless there is securely erased proactive refresh/epoch isolation. Finally a bare 256-bit guessing guarantee is weaker than the required 459 effective-bit bound under the declared experiment/horizon account. Threshold secrecy and state-encryption security are different properties.

The optional inventory is a cost exercise, not a completed recovery protocol. Encoding, decoding, proactive refresh, proofs, threshold decryption, key traffic, destination release and remote byte-rate prices must be included before it could repair the positive-k gap.

For a more explicit plant comparison, the code counts a straight Horner dealer sharing 16 GF(2^16) elements/key with 255 multiply/add steps at 400 points for 412800 minds. At the inherited price, count multiplication and addition separately. It also prices one straightforward systematic 400/256 parity encoder, with 144 parity chunks and 256 input chunks of 524288 field words each per mind. That encoder exceeds the 3648-compute plant by orders of magnitude. A faster erasure code may change the price; this is not a lower bound on all encoders. The one-copy wire/energy number alone is not the encoding bill. Neither a trusted-dealer sharing cost nor this example supplies proactive refresh or threshold decryption.
