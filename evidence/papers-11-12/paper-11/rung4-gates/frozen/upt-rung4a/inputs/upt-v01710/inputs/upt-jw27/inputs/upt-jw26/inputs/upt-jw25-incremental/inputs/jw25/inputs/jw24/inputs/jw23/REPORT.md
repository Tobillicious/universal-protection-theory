# JW2.3 — fail-closed islands and pool failover

19 October 2026, Pacific/Auckland. New local bank `upt-jw23`; JW2.2 remains unchanged. The protocol, including its Errata, and the named author checkers were treated as hypotheses. No publication, deposit, dispatch, Zenodo or Git write occurred. Excluded calibration folders and excluded file classes were not used as evidence. The initial workspace boot script made read-only Git queries; the user explicitly clarified that these are permitted. No commit, staging, branch change or push occurred.

**The supplied contracts do not guarantee any positive number of disabled islands per pool.** One allowed island outage can make every copy and key for its 1032 minds unavailable locally; no remotely recoverable placement/release path is established. The maximum guaranteed extension from these inputs is therefore k=0, meaning no new whole-island outage is admitted. This is a counterexample to the proposed extension, not a physical claim about the best possible redesigned plant. The 92-island slot calculation and 295-island care-energy calculation both reproduce, but neither is the full task.

Every decision uses exact Fractions or outward rational enclosures. Decimal displays below are rounded down; they are displays, not replacement exact bounds. Full fractions and all ten complete rows are in `RESULTS.json`. Derivations and countermodels are in `MATHEMATICS.md`; the actual plant and required contracts are in `PREMISES.md`.

## 1. Fail-closed safety and the quorum mismatch

Under unextractable keys, authenticated genuine signatures, bounded real-time clocks, monotone durable retirement/promises and unique epoch ownership, a stopped or captured host cannot mint a 172-signature grant, revive expired execution or execute beside its correctly fenced successor. The finite machine exercises pause, power loss, reboot, rollback, wrong epochs, 171 signers, pending grants and all extreme clock offsets. These are consequences of explicit trusted-machine axioms, not a physical realization of them.

A quorum requires 172 of 242 compute roles: at most 70 may be unavailable. Loss counts 71 through 78 are concrete liveness counterexamples. The advertised J-LIVE claim for 78 arbitrary site losses cannot be restated with this quorum; 78 compute losses leave 164 signers. The defensible replacement is a 1/8-date completion contract for at most 70 compute losses and 78 total site losses, with the independent 71-compute-loss tail charged separately. No lower quorum is substituted.

A trusted over-tolerance/resource interlock is also needed: 79 passive losses alone leave all 242 compute signers, so the arithmetic does not itself stop renewal. Loss of that interlock, trusted time, retirement, key integrity or global ownership can break safety. Losing quorum/collectors/energy must stop authority issuance or execution safely, while existing execution remains valid only to its actual expiry. Permanent retirement must not destroy a resident mind's last recoverable state.

The promised-expiry wait is 49/256=.19140625 dates. Waiting only on already assembled grants admits the retained pending-grant fork counterexample. Separate local journals also permit two owners unless a pool-wide authority service prevents them. Recovery from an island with no fencing quorum requires a globally enforced last-possible-grant bound and expiry wait; it cannot demand a new fence from an unavailable source.

## 2. Capacity, energy, timing, replicas and identity

The least whole-window F at a 10^-8 horizon allowance is 74: the first excluded site-count 75 has horizon tail 7.50447974749816951E-9; count 74 has 0.00000113719494723592393. The extra quorum tail is accounted in section 3.

| Care roster/envelope | Slots/island | Spare | Slot-only k |
|---|---:|---:|---:|
| inherited rung 2 (152 hosts) | 1216 | 184 | 60 |
| JW2.2, F=78 (164 hosts) | 1312 | 280 | 85 |
| author F=74 (168 hosts) | 1344 | 312 | 92 |
| journal Q=172 (172 hosts) | 1376 | 344 | 100 |

The actual ledger reconstructs to 92285556/79375 = 1162.65267401574803 energy/date. The original 78-loss margin is **297444/79375 = 3.74732598425196850**, not 3.75. At F=74 the spare energy is 1821444/79375 = 22.9473259842519685; paying only 1/127 per exile givesk 295. Confidential live work alone costs 5/(4*127) per extra mind before restoration/release, so care-only is explicitly a lower cost estimate.

Retaining the current three per-history certificate entries gives another necessary capacity limit: inventory 4130 against ceiling 4224 allowsk 11 (a destination with 30 exiles, 4220 certificates), whilek 12 requires 32 exiles and 4226 certificates. Atk 92, a destination needs 309 exiles and 5057 certificates, 833 beyond the ceiling. This bound can change with a separately priced care-only or batching redesign; it is not an impossibility theorem for all redesigns.

A 1/100 partition grace raises care timing to 0.930565762001352339 and provider timing to 0.945496012369791666 against .95. Maximum grace before any other new serial work is 7129/491520 = 0.0145039876302083333. A new serial 1/8 audit instead gives 1.07049601236979166, which exceeds .95. JSON prices hypothetical normalized inter-island transfer volume for several k values. Those transfer sums are conditional: no remote state route, byte-rate conversion, global release service or composed concurrency schedule is supplied.

Positive k therefore remains unestablished even below the separate capacity maxima. The one-island local-copy countermodel loses remotely recoverable ciphertext/key material, not just spare CPU. C3(Delta>=39/20) needs no fork, accepted suspension, a stated recoverable checkpoint age and actual bounded completion. The conservative 1+.95 derivation requires checkpoint state age<=1 at failure, not merely a checkpoint started every date. C4 permits branching but cannot restore an unavailable pattern. No smaller-Delta or C2 coverage is inferred.

## 3. Physical split and all 21 CERT15 accounts

P-ISLANDS must count the union of attacked and falsely/protocol-isolated islands against the same k during recovery. An at-once cap does not bound adversarial rotation through islands during a window; either a window-union or a proved churn-rate contract is additionally needed. P-FAULT here is conditional independence atp<=.002 on nonattacked islands over the date-level union of recovery windows, including completion overlap. That is stronger than subset moments alone. Provider losses with disabled islands count inside W=42800.

The conditional numerical vector, assuming the missing recovery contracts, has sum **1.21258098406338987E-7**, and with the separate reserve **2.21258098406338987E-7**. It has numerical headroom 7.78741901593661012E-7 below 10^-6. Its maximizing complete endpoint is`slack:89/100`. It replaces both availability/overflow entries with the 75-site exact independent tail and the journal entry with the 71-compute tail; the other entries remain.

| Account | Conditional numerical split (floored display) | Allowed local-copy countermodel |
|---|---:|---:|
| `arrival_history_exit` | 6.55255911008389626E-23 | 6.55255911008389626E-23 |
| `arrivals_max_alternatives` | 6.55255911008389626E-31 | 6.55255911008389626E-31 |
| `background_episode_overflow` | 7.50447974749816951E-9 | 7.50447974749816951E-9 |
| `care_mpc_unavailability` | 7.50447974749816951E-9 | 1 |
| `care_slots_and_spreading` | 1.73398209778636274E-106 | 1.73398209778636274E-106 |
| `committee_good_editions` | 3.17797678004473240E-31 | 3.17797678004473240E-31 |
| `common_plus_premise` | 1E-7 | 1E-7 |
| `confidentiality_ModeC` | 2.88530581805804243E-9 | 2.88530581805804243E-9 |
| `coordinated_load_channels` | 8.63055540456663111E-217 | 8.63055540456663111E-217 |
| `crypto_legacy_448` | 1.37582102682973977E-15 | 1.37582102682973977E-15 |
| `crypto_protocol_512` | 2.00208309518310092E-26 | 2.00208309518310092E-26 |
| `domain_fault_vacancy_exit` | 9.98308670110918747E-11 | 9.98308670110918747E-11 |
| `dormant_broadcast_reservoir_overflow` | 0 | 0 |
| `edition_accumulated_corruption` | 0 | 0 |
| `integrity_attestation_freshness` | 2.88530581805804243E-9 | 2.88530581805804243E-9 |
| `ordinary_holding_channel` | 6.18869209476515655E-497 | 6.18869209476515655E-497 |
| `ordinary_rescue_channel` | 8.63055540456663111E-217 | 8.63055540456663111E-217 |
| `physical_geometry` | 5.19440225091869446E-15 | 5.19440225091869446E-15 |
| `quorum_abuse_original` | 0 | 0 |
| `quorum_liveness` | 3.78689837992128834E-10 | 3.78689837992128834E-10 |
| `recruitment_family_R25` | 0 | 0 |

The complete countermodel vector totals 1.00000011375361865, or 1.00000021375361865 with reserve, exceeding the target by 0.999999213753618658. This is an overlapping accounting sum, not a probability greater than 1. More directly, the countermodel's actual loss probability is 1, exceeding 10^-6 by **999999/1000000=.999999**. An allowed deterministic outage cannot be hidden in a 10^-7 common allowance. Thus the full positive-k conclusion fails, despite the conditional numerical vector fitting.

## 4. Seven jobs per host: two different error laws

If whole-host errors are the **only** errors and are independent across hosts conditional on admissible history, 574 false votes need 82 erroneous hosts. At q_host=.001 the exact horizon account is 3.82469064312695570E-57. It fits; .001 is conservative, not the boundary. The exact-tail sufficient accounting bracket is[0.004096547, 0.004096548] on the 10^-9 grid, with the committee charged again in the reserve.

If a whole-host shock q is **added to** otherwise independent .1 job errors, the answer is much tighter. A sufficient moment-bound grid includes q=0.000162183 and does not enclose the next q=0.000162184. Their total accounts with reserve are 9.99962714796347596E-7 and 0.00000100008963890292849. This brackets a sufficient Chernoff rule, not the exact largest permissible probability.

In that mixed law, q=.001 does not work: 37 host shocks plus 315 other job errors give a concrete false-accept event with expected horizon count 30642600487499730.4. Independent repetitions imply horizon loss probability at least 0.999999999999999967. A bare .1 whole-host law is worse: one exact event already gives expected horizon count 2.13424218374525114E+100. These are lower-bound counterexamples, not only failed upper bounds.

Neither replacement preserves the literal .1 slot-subset premise automatically. A pure shared seven-job error requires q<=10^-7 to preserve that literal subset bound. Pairwise correlation alone cannot certify the required seven-way and cross-host tails. The new joint error law must be stated, not inferred from marginals or vendor diversity.

## 5. Predictable versus adaptive withdrawal

At response 43/50, d_cut 9273 and W=42800, predictable withdrawal has expected rescue surplus **29603632/5625 = 5262.86791111111111**. Choosing successful providers after observing outcomes changes it to **-8307856/1875 = -4430.85653333333334**, plus a positive correction no larger than 5.29752043311897400E-612. Rescue success in that adaptive case is bounded above by the exact outward rational whose display is 3.26706513781732042E-86.

P-PROV must fix the withdrawn set before every outcome it could target. A supplemental sufficient rescue-only cap at this one response is 37770; the next integer 37771 is not enclosed at the 10^-10 pool-horizon allocation. This is not a joint adaptive holding/incentive/ten-row replacement design.

## 6. Recomputed economics and engineering boundaries

The old local futility majorant 3*2^20*(13/40)^287 is 2.56003421037639826E-134 (the source of the approximate 10^-133.6). It belongs to the JW1.2/1.6 local model. At the present committed JW2.2 load, every row's holding-channel upper enclosure is 2^-2047, whose display is 6.18869209476515655E-617. That value is the outward arithmetic floor, not an exact probability. The resulting expected gain bound is an operating-channel result; it omits neither an explanation nor a warning that common/premise events can dominate beliefs. No arbitrary-belief dominance follows.

The newly priced physical pool inventory bound is 4636682190400/10287 = 450732204.763293477; the enduring discretionary gain bound is 10. The corresponding worst-row operating expected physical gain display is 2.78944283247466418E-608. The old .1699142625 role value and 171/181 excluded-role ratio are source-model figures, not current-row values.

| Response/effort | Nominal initial role value | Excluded, same physical-up state / initial | Clean dividend-value threshold |
|---|---:|---:|---:|
| slack: 22/25 | 0.166754512651767262 | 0.966750183663741353 | 0.215517241379310344 |
| slack: 43/50 | 0.164646157611648835 | 0.965622201151776459 | 0.220588235294117647 |
| slack: 87/100 | 0.165702916869538491 | 0.966193202603203705 | 0.218023255813953488 |
| slack: 89/100 | 0.167801493418266129 | 0.967293566246356817 | 0.213068181818181818 |
| slack: 9/10 | 0.168844407628966067 | 0.967823752394540976 | 0.210674157303370786 |
| tremble: 22/25 | 0.167203950854014453 | 0.966839557973396660 | 0.210674157303370786 |
| tremble: 43/50 | 0.165545034016143217 | 0.965808865719558715 | 0.210674157303370786 |
| tremble: 87/100 | 0.166377074172909277 | 0.966330187217712197 | 0.210674157303370786 |
| tremble: 89/100 | 0.168026212519389724 | 0.967337307995241558 | 0.210674157303370786 |
| tremble: 9/10 | 0.168844407628966067 | 0.967823752394540976 | 0.210674157303370786 |

These are exact eight-state Bellman solutions without an operating-exit hazard, explicitly nominal. The clean threshold is 15/68=0.220588235294117647, not the toy .112. No27.9% valuation-distribution claim is rederived. Nominal privilege gaps and the physical pool inventory put break-even beliefs around 1.2e-11; a 10^-7 floor does not imply strict dominance under every belief. At rho_L=.15 the common-floor prior condition ispi_B<=1/8500000=1.17647058823529411E-7, not 1.2e-6.

The actual net-flow threshold is 30761852/6429375 = 4.78457890541460095 per surviving site. The binding job-compute threshold is 454365883/3698315034624 = 0.000122857538837600522, set by the 1/8 committee phase. The energy-only job threshold is 0.000166510142749812171 and is not the simultaneous limit. Other CPU/wire/memory/care/interconnect thresholds are retained in JSON.

- Old F=78 subset-union rule: [0.002701253203, 0.002701253204] on the 10^-12 grid.
- Old F=78 independent-tail rule: [0.002723629791, 0.002723629792] on the 10^-12 grid.
- F=74 split plus 172-quorum independent-tail rule: [0.002108851068, 0.002108851069] on the 10^-12 grid.

These are sufficient full-account accounting boundaries with the stated reserve, not empirical fault estimates. The .002701 number is identified by its original subset-union source rule; it is not silently carried into the new split.

## 7. Non-destructive isolation and full-pool audit

No accusation, proof, vote or audit permits power cut, bricking or zeroization while any resident mind depends on the source. Isolation is failover only; destructive work is deferred until every resident has an identity-compatible recovery and old execution authority is fenced/expired. Framed and falsely isolated islands consume the sameP-ISLANDS allowance. Stolen keys can produce apparent equivocation; physical capture need not produce a proof. These facts cannot be repaired by an evidential label.

| Uniform full-pool audit size | Strict adversarial majority, 92 of 400 | Raw union at one audit/pool/date |
|---|---:|---:|
| 32 | 0.000104229763777967463 | 2.60574409444918659E+113 |
| 64 | 3.49630065291642644E-8 | 8.74075163229106611E+109 |
| 128 | 1.51288870261087912E-18 | 3.78222175652719780E+99 |
| 185 | 0 | 0 |
| 201 | 0 | 0 |

Choose 201 for the combinatorial audit against that deterministic 92-bad-voter cap; 185 already suffices for an odd committee. The 201*92 simultaneous-audit volume price is 1.8492 compute/pool, 0.0145606299212598425 activity energy/pool, 36984 normalized wire units and 0.00220441818237304687 fabric dates, plus at most 47 signer jobs/island. This is an explicit volume/serialization price, not a supplied full consensus/authority implementation. Existing phase concurrency, certificates, QoS and actual payload/proof sizes still require a composed budget.

P-ISLANDS bounds disabled islands, not automatically dishonest audit voters. Ordinary verification errors and ambiguous accusations are not eliminated by the zero-majority count. The audit needs either correctly certified deterministic honest votes with their errors already charged, or a separately priced joint voter-error law. Its outcome must never delay essential care or trigger punishment.

## 8. Optional threshold-shared execution authority

GF(2^8) supplies only 255 nonzero points; GF(2^16) supplies 65535. Share a 256-bit key into 400 32-byte shares with threshold 256, and code ciphertext at 400/256 overhead. For 412800 minds with 256 MiB state, the encoded state inventory is 173140869120000 bytes = 157.470703125 TiB/pool, or 432852172800 bytes/island. Key shares occupy 5283840000 bytes/pool and 13209600 bytes/island. With 92 unavailable islands, 308 remain, 52 above threshold.

The simple Horner key dealer costs 427.792896 compute/island/epoch when multiplication and addition are priced separately at the inherited field-operation rate. The corresponding energy is activity inside a prepaid compute budget if it fits; it is not automatically another whole energy debit. A straightforward systematic parity encoder instead costs 5066240.343146496 compute/island/epoch, far beyond 3648. A faster encoder may change that cost; no lower bound on every code is asserted. Ciphertext-copy volume alone is not an encoding/reconstruction bill.

Reconstruction must use threshold decryption or occur inside attested execution; no ordinary host may receive the whole key. A mobile adversary can accumulate old shares without secure refresh/epoch isolation. A bare 256-bit key-guessing account at the stated online volume/horizon is 1.85460307534371069E+52, so 256 material bits do not supply 459 effective bits. The 512-bit variant doubles key/share volume and dealer work but still needs an actual security/refresh theorem. Threshold proofs, entropy, refresh, decoding, decryption, release and byte-rate prices remain absent. This option does not complete the pool repair.

## 9. Local evidence and reproduction

The recorded arithmetic/author/control suite has 22 byte-identical command pairs, 44 executions, including 18 pairs of false assertions that exit nonzero. The three author programs reproduce their own output, including the first-pass 5/5; their success does not supply the missing interfaces. Raw stdout/stderr and exit expectations are saved in`outputs/` and`REPLAY.json`.

`INPUTS.json` names and hashes every copied source. `checks/check_bank.py` compares the copies and original allowed sources; `--copies-only` makes the check portable. Source copies preserve the frozen chain needed for calculation. Report rendering is repeated separately byte for byte. `SHA256SUMS` binds the final local files.

Reproduce in a writable copy: `python3 -B checks/replay.py`, then `python3 -B checks/render_report.py`, then `python3 -B checks/check_bank.py --copies-only`. The report command emits Markdown to stdout. Nothing in these commands publishes, dispatches, deposits, stages a release or performs a Git action.
