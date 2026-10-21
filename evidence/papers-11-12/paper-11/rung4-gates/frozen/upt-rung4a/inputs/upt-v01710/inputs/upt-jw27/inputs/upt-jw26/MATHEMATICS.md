# JW2.6 derivations and limitations

Every decision is an exact Fraction. Decimal displays are floors; RESULTS.json retains exact rationals. Inputs are guarded frozen copies. No independent Bernoulli assumption is silently inferred from a subset-moment law.

## State, keys and local reads

For logical home h, the full encrypted state has island locations h,h+1,h+2. Any two erased islands leave one image. Cyclic translation proves the same for all400 homes; the checker tests all79800 two-erasure supports for one home. Three relevant erasures destroy the code.

For each16-bit key limb use f(x)=s+a x+b x^2 at x=1..5, with independently uniform a,b. Any three points interpolate s. For two nonzero distinct points x,y, the coefficient matrix for(a,b) has determinant xy(x+y)!=0. For each possible s the observed pair fixes exactly one coefficient pair; its observation probability is therefore independent of s. Independent limbs give the512-bit statement. This does not prove the separate459-effective-bit computational C-SEQ requirement. The code checks120 three-share reconstructions and all10 two-observation determinants.

Each local ciphertext record r has71 consecutive holders starting at71r modulo242. Across1032 records each host holds at most303, hence606 for two home groups and1515 key-share records for five groups. With70 whole-window local losses every record has a surviving copy. The two-home read problem has2064 records and172 live hosts, so12 reads/host is the capacity boundary. For g distinct starting groups, the union of holder intervals contains at least min(242,g+70) hosts and at least min(172,g) after70 erasures. There are at most10 records/start group. For g<=172,10g<=12g; for larger g,2064<=12*172. Hall's inequality proves a12-capacity matching for every mask. FIFO/earliest-deadline scheduling on these cyclic intervals finds the matching after one warm-up cycle; the checker exercises259 masks. This is a snapshot theorem. CONTRACT.md explicitly retains the stronger dynamic read/partial-retry work/latency requirement as an unimplemented engineering interface.

## Survivor population, primary service and clocks

Two losses evacuate2064 identities. Ceiling(2064/398)=6 extra per survivor gives1038 total, at most7 primary execution duties per live host. Original logical mirrors and key-share locations stay fixed. No growing sequence of migrations can clear old losses without returning/rebalancing their residents.

The home image cannot rely on a stale daily snapshot. Reuse the existing primary-snapshot copy budget, all242 MPC participants unchanged, for fresh71-holder local ciphertext checkpoints. With clock padding there are at most1384 capture events/home/date and12 migrant events,1396 primary captures/care island/date. Seventy-two copies and both endpoints cost201024 records, plus small headers, below the already paid242*1038=251196 primary-copy budget. The per-host copy/NIC envelope also decreases. Its local lag bound is.133029 or less. A further201024 primary authentication invocations are counted, using the existing primary whole-frame verifier price rather than silently deleting them. All these reuse/price requirements are explicit in CONTRACT.md.

With clock error delta=1/1024, nominal period3/4-2delta=383/512 gives real spacing<=3/4. In any true date, the source clock spans at most1+2delta. Ceiling(1032*(1+2delta)/(383/512))+1=1384 includes a guard tick. The code also charges a four-phase pool burst3264 and2delta extra checkpoint latency. Background13 CPU fails this padded bound;14 passes. Ciphertext lag is below.246048, so age is below.996048. Two retained generations and early sealed prefetch below63/128 prevent an old recovery pin from requiring a third staging generation. Freshness is a joint requirement across overlapping failures; the end-to-end recovery clock is not restarted by an intermediate failure.

## Authority and service capacity

Two202-of400 pool quorums overlap in at least4 islands, leaving at least2 honest intersection members under a two-island nonconformance allowance. Two201 quorums can overlap only in the two bad islands. Local172-of242 availability needs at most70 compute failures. Pending promises and unassembled grants are included in maximum expiry; half-open execution and irrevocable retirement use the inherited49/256 fence. These prove useful safety implications, not consensus liveness. Composed1/8 journal service, sealed release, trusted time and capture/rollback resistance remain required functionalities.

Foreground shares stay152 CPU,63488 host wire and7*2^21 pool wire. Background is14 CPU,3072 host wire and2^22 pool wire. Actual host caps are166 and66560; total pool cap is9*2^21. Full care/source/fanout work is charged, including at most90 foreground image-equivalent operations per host. Ordinary checkpoint traffic is reserved before prefetch, which uses residual pool service. Local fanout stays on the local NIC service. The provider and care projections both fit. No second serial audit is included.

## Reseeding has both local energy and authentication limits

Count temporary restoration, return of two primary groups to242 hosts, and rebuilding four lost mirror groups through72-copy paths. Global endpoint count is2*(2*1032*72+2*1032*242+4*1032*72)=1890624. Add one4KiB header/state endpoint and128 control units. Fresh key shares are already rewritten in full every normal checkpoint; old key archives are retired, so they do not need an additional full archive rebuild.

A returned island rebuilding its store cannot spend a pool-average energy allowance. Each island receives a30720 endpoint-unit/date bucket and a2^24 repair-auth/date bucket. A full returned store needs at most2*(1032*242+2*1032*72) data endpoint headers at512 admitted units/header. Authentication completes in at most27 dates; the more conservative global byte-count bound plus two startup/refresh dates is64. Throttled retry/partial-transfer work consumes the same buckets. Urgent recovery takes priority and fits both. Image-level read/staging deadlines and progress under the required stable service are contracts; the whole64-day rebuild does not pin a single key generation for64 days. Already committed records enter the ordinary fresh-checkpoint stream.

Minds continue at their temporary destinations while their homes rebuild. Original islands remain counted against the two-island allowance until current state, current shares, authority and resident placement have been restored. Repeated flapping cannot reset this count or open extra work queues. A lower endpoint bucket7808 and allocation22.5 extend the completion target to245 stable-return dates. Neither version promises recovery of powered-off islands.

## Energy, capital and the21 accounts

The original primary/MOVE activity is recomputed at1038 residents and172 serving hosts, rather than copied unchanged from1032/164. Both full foreign mirror streams, field headers, key payloads and a full local repair quota are charged. Fresh key generation/sharing, four control compute units, migrant care, added passive control and one idle-energy unit are separately paid. One additional passive gives322 sites and guaranteed244-site inflow1171.2 after78 total losses. New stock includes capped host-upgrade packages, a passive site and a pool-fabric increment; all are performance/price targets. The original4096 cash line is preserved.

Recompute all ten response/effort rows with80 passive sites and stock1197376. The two total-site accounts use the322-site union bound for79 failures. Add the71-compute subset union while retaining the legacy quorum term. The21-account sum plus the inherited certificate reserve remains below10^-6; all ten incentive rows remain positive. These are conditional accounts, with every new realization obligation charged to the same declared10^-7 common/premise warranty, not new calibrated reliability evidence.

The corrected physical quorum bound10^120*C(242,71)*.002^71 is about5.30749e-10. A sharp counterexample to substituting the independent-binomial tail is: with probability q=C(242,71)*.002^71 choose exactly71 uniformly random failed hosts, otherwise none. All subset moments obey the stated bound; its71-failure probability exceeds the independent tail. The checker verifies all72 nontrivial moment orders. Frozen JW2.4 used an independent-binomial expression for this term; this bank uses the bound justified by subset moments alone.

## What is and is not complete

This is a fully enumerated conditional interface/capacity point, including reseeding and post-outage accounts. It is not a hardware instantiation, a consensus/read-protocol implementation, proof of the common warranty, or a global minimum. In particular the primary snapshot reuse, streaming checkpoint commitments, composed journal, dynamic read/retry and two-buffer freshness requirements must all be realized jointly at their paid targets. Failure of any one invalidates the conditional conclusion.

The neighboring smaller memory/CPU/wire/pool/flow/allocation coordinates fail within the declared grids and fixed foreground shares at the64-date quota. Another code, calendar, hardware tariff or reseed time can change that frontier. Global minimization is unresolved. Optional task2 was not executed because usage reached86% weekly and88% of the active window; task1 was banked first as requested.
