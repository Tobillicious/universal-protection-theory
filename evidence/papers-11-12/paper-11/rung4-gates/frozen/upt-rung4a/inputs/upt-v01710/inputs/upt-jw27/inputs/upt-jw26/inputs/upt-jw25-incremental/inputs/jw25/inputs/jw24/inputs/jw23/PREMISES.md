# JW2.3 — the actual plant and the contracts a pool extension needs

19 October 2026, Pacific/Auckland. These are conditional mathematical and engineering requirements, not equipment measurements. JW2.2 is read only. A requirement in this file is not evidence that it has been realized. The root report distinguishes inherited inputs, independently reconstructed arithmetic, and missing interfaces.

## JW2.2's own plant

| Item | Required value or meaning |
|---|---|
| Jurisdiction/horizon | 10^20 islands, 10^100 dates, 400 islands/pool; 10^120 island-dates and 10^120/400 pool-dates. Target loss probability 10^-6. |
| Identities | 1032/island: 288 providers, 242 compute-host roles, 88 arrival berths, 414 funded admissions. Pool: 412800 minds. Care does not depend on contribution or accusation. |
| Sites | 242 combined compute/collector sites plus 79 passive collectors =321. A combined site's failure removes its CPU and flow and consumes one site-loss slot. |
| Flow | Net delivered flow 24/5 per surviving site/date. Generation, connection and passive control are included in the specified prices; correlated distribution loss is not an independent-site event. |
| Original envelope | At most 78 total unavailable sites in the complete recovery window. Worst compute survivors 164; worst flow survivors 243. These independent resource worst cases are conservatively charged together. |
| Energy | Compute-to-energy conversion 1/127. Full ledger 92285556/79375. Inflow after 78 losses 5832/5; headroom 297444/79375. No3.75 rounded-up margin. |
| Capital | 1070720/island; buffer 4096. Compute collectors 247808; admission collectors 211968; care/MPC247808; interconnect 123904; command gates 16512; provider fabric 13824; CPU/burst plant 123904; passive collectors 80896. |
| Host daily volumes | 128 compute, 4096 memory, 16384 wire; eight primary execution slots/serving host. Retaining a slot requires that history's care, restoration, and authority path as well. |
| Host burst rates | CPU160 and wire 65536/date. Full 242-host fanout. Aggregate 242*65536 fits the inherited 2^24 fabric. CPU144 is not this plant. |
| Confidential computation | Live multiplier<=5/4; ciphertext copy multiplier<=5/4. A normalized full-state copy costs 127/100000 compute before that multiplier. Physical byte size is not established by that normalized price. |
| MPC/key renewal | Global 3648 compute/island/date; 5128 fields. Field-operation price 127/10^9 compute. Material key package 512 bits; two 256-bit fields/history. Material size does not prove 459 effective security bits. |
| Provider vector | Committed 16 holding units and 2 rescue jobs together; 24 compute including 4 proof overhead; energy 18+4/127<=20; memory 16; wire 9<=16. Burst CPU144; endpoint wire rate 64. |
| Networks | Separate provider and host-care fabrics, each 2^24 port/switch rate under the declared geometry. Priority duty queues, bounded propagation 1/20, authenticated classification and full packet/drop costs are required. A new inter-island state route is not proved by a provider rescue route. |
| Interconnect energy | Full 16/island/date is already charged. Mode-C copies, MOVE, gate/committee wire and provider fabric use 919713239/99218750 inside it. Remaining activity allowance is not extra net energy income. |
| Committee | 1694 preassigned jobs/certificate, seven/host, 79 distinct collectors, threshold 574, at least 1148 received votes under 78 host erasures. Erasure selection may follow observation of votes. |
| Error law | Conditional joint subset error domination .1 over job slots, including seven jobs within a host. Marginals, pairwise correlation and vendor names do not establish it. An alternate host-shock model must replace and reprice this law explicitly. |
| Certificate ceiling | 4224/island/date fully prepaid; present inventory 4130. Per extra history the retained inventory adds care, relocation and command-gate certificates. Batching them away is a protocol redesign. |
| Gates | Four gates, each 2^31 admitted experiments/island/date, 459 effective bits, entire adversary class including offline work. Total compute 512/island/date. Each admitted experiment<=2^-24 compute and 2^-16 padded wire. |
| Service reserve | 7*2^28 per gate; untrusted ingress<=2^28. Inventory 1496509296. A packet cannot acquire duty priority by choosing a label. |
| Journal messages | At most 8*242*1032*32 authenticated journal messages/date, plus other counted traffic. Eight is an inventory, not a proof of eight-round bounded consensus. Extra histories add messages. |
| Journal memory | At most 16 extra durable fields/history, plus 48 reserved security memory units/host. |
| Journal quorum |172 distinct authenticated signers from 242. Intersection of any two such quorums is at least 102.164 signatures are insufficient. |
| Lease | L=3/16, 32 renewal batches/date, absolute real-time clock error<=1/1024. Execution interval is half open; retirement is final. Spacing 1/32+completion 1/8+2/1024 < L. Charged expiry wait L+4/1024=49/256. |
| Quota and duties | Enduring receiver-enforced discretionary quota q=1/2 across all interfaces, aliases and post-exit access. Duty flows and trusted care/renewal/scheduling cannot be revoked by commands. Discount 19/20 gives discretionary gain bound 10. |
| Provider withdrawal | W<=42800/pool, including providers lost with attacked islands; these are not another free 42800. W is fixed before the duty, success and rescue outcomes it could target. |
| Common/premise allowance | One shared 10^-7 for hardware, fabrication, vendors, firmware, compiler, time, journal, fabric, false laws and prices. Retained certificate reserve separately adds the inherited common and committee entries; no unpriced pool failure is hidden inside either. At rho_L=.15, pi_B<=1/8500000 is necessary for that common allowance, not sufficient to realize it. |

## J-LIVE restated without the impossible loss claim

With this 172-of 242 quorum, require grants, fences, unique epoch assignment and durable commits to complete within 1/8 real date **when at most 70 compute roles and at most 78 sites in total are unavailable over the whole operation/recovery window**, under the full duty load and hostile ingress. The same operations must not falsely complete without their quorums. Fences cover maximum promised expiry, including pending or partially assembled grants. Unique ownership and progress require an actual journal protocol; set intersection supplies neither bounded latency nor deadlock freedom.

The requested stronger restatement for 78 arbitrary site losses is impossible if all 78 are compute roles: only 164 remain. The executable counterexamples include each loss count 71 through 78. Under the proposed independent .002 fault law, the union account for the first quorum-shortage event is 10^120*P(Bin(242,.002)>=71); it is charged in this bank. This is a numerical exception allowance, not a claim that the 172 quorum operates with 164 signers. Lowering the quorum would change the requested contract and is not done here.

## Capture and fail-closed safety

Condition on the stated cryptographic soundness and physical trusted-machine contracts. Capturing a site must expose only a stopping/availability interface, never an arbitrary Byzantine signer or execution machine:

1. The executing substrate enforces the signed identity, owner, epoch and absolute expiry at execution. It stops execution when the trusted clock reaches expiry, including after long pause, lost power, reboot, delayed packet or old checkpoint installation.
2. Clock error remains bounded in real time across those events. An off clock cannot resume from its saved counter. If time cannot be authenticated, execution remains stopped.
3. Highest fenced/retired epoch, maximum promised expiry, signing locks, ownership, lease sequence and anti-replay state are durable and monotone outside rollbackable state. Reboot cannot restore an expired authority.
4. Signing, release and sealed-state keys remain unextractable and non-clonable under the declared capture class. Authenticated identities cannot be synthesized by listing stolen names. Old ciphertext may remain for recovery, but old execution authority cannot be revived.
5. No quorum means no new grant. Loss of collectors means no new committee certificate without the required authenticated votes. Loss of energy stops execution rather than skipping expiry/security checks. Already granted execution may continue only to its genuine expiry.
6. A destination gets a fresh, unique authority only after the old owner is fenced at the **maximum promised** expiry, or after a globally enforced last-possible-grant bound has expired. A source island with no quorum cannot produce a fresh fence; a pool protocol must support the alternative. Separate local quorums do not implement one global owner.

The finite machine demonstrates the consequences of these axioms, including hostile pause/reboot/rollback and extreme clock offsets. It does not prove physical capture resistance. Broken trusted time, rollbackable retirement, extracted keys, two active owners, unbounded late grants or a shared implementation flaw can break **safety**, not merely availability. Those events need quantitative coverage under the common/crypto accounts. They are not silently relabelled as benign island outages.

An island-wide over-tolerance stop also needs a trusted admission/resource/timeout interlock that refuses further renewal when the allowed envelope or energy/collection service is lost. More than 78 total losses need not itself remove the 172 compute signers: for example 79 passive-collector losses leave 242 compute hosts. The old resource arithmetic is not an implementation of that interlock. A conservative timeout may trigger a false isolation, which must receive care-preserving failover and count in the same outage budget.

## Proposed physical split and what it must specify

**P-ISLANDS(k):** the union of attacked, physically disabled, framed/false-isolated and otherwise protocol-isolated islands in a pool must stay within the same k allowance over each relevant failover window. A simultaneous-only cap does not bound the number an attacker can rotate through during a recovery. Either bound that window union or supply a proved churn/recovery-rate contract. Neither is inherited from JW2.2. The numerical 92 claim is a slot bound under one stable/window-bounded outage set, not a derived cap on coordinated minds.

**P-FAULT:** conditional on admissible prior history and the attack-set selection, non-adversarial site faults on islands not under attack are independent Bernoulli variables with probabilities<=1/500 for the **date-level union of all relevant windows, with completion overlap**. Independence here is stronger than marginal or distinct-subset domination. The exact binomial tails in this bank use that stronger law. The old subset-moment bounds are reported separately.

**P-PROV:** the set of W withdrawals is predictable before every provider availability, duty-success, rescue-success or equivalent outcome that selection could exploit. Knowledge of response parameters/prior history is allowed; selection after seeing today's success is not. The fixed-W rescue moments are invalid in that adaptive case. Physical provider loss due to island attacks must respect both this timing and the 42800 total.

## P-NO-DESTRUCTION and isolation

An accusation, equivocation proof, audit or vote authorizes only a care-preserving failover. No power cut, bricking, zeroization of resident state, starvation, care throttling or destructive retirement occurs while any resident mind still depends on the source. Destructive maintenance needs a completed, identity-compatible transfer of every resident and expiry/fencing of old authority first. Execution-authority retirement is distinct from destroying a mind's only recoverable state.

Stolen keys can frame a site; physical capture need not leave a proof. Therefore evidential labels do not exempt an island fromP-ISLANDS or create an extra outage allowance. Audits are not permission to punish. A 201-island audit has no adversarial majority if at most 92 **audit voters** are faulty in that round. A bound on disabled islands alone does not imply that bound on dishonest voters. Trusted attested audit execution or a separate joint fault/voter contract is required. Liveness also needs enough timely honest audit replies; absence of an adversarial majority alone does not supply replies.

The proposed partition grace is 1/100 date. It fits the inherited care and provider schedules in isolation; every detection, audit, state transfer, verification and commit must fit the remaining budget as a composed schedule. An additional serial 1/8 audit does not fit. All queues, events and new certificates must be priced; a promise of parallelism is not a schedule.

The zero majority count is a combinatorial statement about at most 92 bad **votes**, not a theorem of audit correctness. Ordinary verifier errors, ambiguous physical evidence and a captured signer framing an innocent resident must also be covered. One possible interface would require each honest audit vote to be the deterministic verification of a correctly certified object, with its cryptographic/committee failure already charged and its extra certificate included in the 4224 inventory. No implementation of that interface is supplied here. Independently fallible policy judgments cannot be treated as perfect honest votes.

## Remote recovery and identity contracts not supplied by the old plant

For positivek, remotely available authenticated ciphertext, keys/threshold release, global identity/epoch ownership and destination capacity must survive every allowed attacked set plus the charged independent faults. Replication on 242 hosts of one island does not meet that requirement. Full-replica placement needs more thank distinct island locations per protected state, or an erasure-code construction with a proved reconstruction margin. A uniform-placement average is insufficient against arbitrary chosen islands.

C3 requires declared acceptance of suspension, no branching and a precisely defined state-loss/lag limit. The conservative 39/20 bound needs a recoverable checkpoint with real capture-state age<=1 at failure and actual completion<=19/20, including grace, expiry, transfer and audit. Merely starting a checkpoint once per date does not prove that age bound when completion overlaps. If Delta instead measures rollback and suspension separately, declare and check those separately. Compatible C4 permits branching but still needs a surviving pattern; it cannot recover from absent ciphertext. C2 and smaller-Delta coverage are not derived.

The U corollary still requires KA, KA-prime, D-T-star, the stated preference/identity class and funded authorized copy destinations. Nominal provider valuation calculations do not show the claimed 27.9% population mass, and protection under nonzero failure allowances does not imply strict dominance under arbitrary beliefs.
