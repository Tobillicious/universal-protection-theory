# U/C-SEQ: a controller-finality adapter

This supplies the remaining item-4 adapter, in the protocol model. It builds on the
20 October ordered-permit and fencing/watchdog theorems, not a replacement for them.
It does not certify a hardware store, clock, cessation time, plant capacity or the
joint physical bridge (item 5). Its implementation artefact is an executable reference
codec/verifier and deterministic state machine, not a deployed PBFT node.

## 1. Fixed model and ordering component

For one allocator domain, enrol a fixed active committee of **N=3f+1 distinct keys**,
with at most f Byzantine keys over this execution. A larger available population may
select this committee; extra keys do not vote. A certificate contains exactly q=2f+1
distinct active signers. For arbitrary N the condition is **2q>N+f**; q=N-f is a suitable
general choice. The weaker statement “N>=3f+1, q=2f+1” alone is insufficient when N
is larger. The reference verifier enforces N=3f+1. There is no implicit reconfiguration
or mobile-corruption claim; another configuration requires an explicitly ordered,
non-overlapping handover before the domain resumes.

Use the signature-based PBFT atomic state machine of Castro–Liskov: [formal safety
proof](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/01/tm590.pdf),
Theorem 4.19, with the deterministic methods below. The theorem supplies agreement
on operation order across views, under its fault and cryptographic model. Section 4.2
of the [OSDI paper](https://pdos.csail.mit.edu/6.824/papers/castro-practicalbft.pdf)
executes only after committed-local and after earlier sequence numbers execute.
Section 4.3 describes stable checkpoints certified by 2f+1 matching checkpoint
messages. These statements were read in the primary sources. We do not infer a hard
deadline from PBFT's eventual liveness, nor attribute our adapter to Theorem 4.19.

Each correct replica's adapter emits a final-prefix signature **only after** it has
executed the named operation, recomputed the complete deterministic result and
prefix root, and durably stored the state/root and its signing high-water mark.
It signs its own executed prefix; a received leader assertion does not invoke this
emitter. The emitter signs a checkpoint only after persisting its exact executed
state. Emission is read-only with respect to PBFT and cannot change its votes or
operation ordering. Therefore adding the emitter preserves PBFT's safety traces.

Two ingredients must not be conflated: quorum intersection supplies an honest
common signer for certificates at the same position; PBFT supplies compatibility of
honest executed histories at different positions and views. Signature unforgeability
and digest binding are named cryptographic premises, not consequences of a quorum.
For a finite execution let their combined deviation probability be delta_crypto;
the adapter conclusions hold on their good event, with deviation at most that
quantity. No zero-error claim for computational cryptography is made.

## 2. Exact bytes and enrolment

Canonical value encoding C has only four forms: null = byte 0; unsigned integer =
byte 1 followed by exactly w bytes, big endian; byte string = byte 2, 4-byte big-endian
length, then those bytes; array = byte 3, 4-byte big-endian item count, then each C
value in order. Integers are in [0,2^(8w)); lengths/counts are in [0,2^32). Booleans,
negative numbers, floats, strings, dictionaries, alternative widths and trailing
bytes are rejected. The enrolled configuration pins w before parsing; the executable reference uses w=64 (512 bits). Parsing has configured total byte, depth and item limits and
re-encodes the result to the identical byte string. Schema lengths and types are
checked separately. C has a deterministic left inverse by structural induction,
so two different structured values cannot share their canonical encoding.

Every message carries its schema tag and version. All hashes below are SHA-256 of
C([purpose-tag, ...fields...]); purpose tags differ for config, state, record,
checkpoint and final receipt. IDs, roots, nonces and context digests are exactly
32 bytes. Replica indices, counters and local tick bounds have the configured w-byte width. A hash is a
binding reference to bytes, not evidence that their contents are true.

The enrolled configuration fixes domain, committee/key map, f, authorised monitor,
hold/release authority, target set, schemas and byte/count/counter limits. A resource
record fixes resource ID and lease incarnation, admitted owner/recipient, policy
and coverage bytes/digests, their validity/coverage endpoints, and L/W bounds. These
are immutable within a generation. Changing them needs an ordered new generation
and the existing retained-reservation/admission rule. A client cannot replace the
registered feasible coverage context with one of its own. This does not derive
the truth of the agreed coverage/admission input from its signature.

The exact challenge context is the array

    ["UPT-CTX" bytes, 1, domain, resource, lease, owner, monitor, targetSet,
     generation, boot, sequence, nonce, policy, coverage,
     validityStart, validityEnd, ageLimitL, watchdogW]

where quoted text denotes its literal ASCII byte string. The targetSet, policy and
coverage hashes refer to immutable, available canonical records; an unavailable or
unrecognised record is an error. Receipts bind the complete array, including both
timing bounds and the complete coverage identity. The Lean `Context.scope` vector
contains these immutable fields; generation/boot/sequence/nonce are distinguished
fields. Its word encoding is proved injective; byte-codec injectivity is the separate
structural argument above and executable round-trip checks, not a Lean byte proof.

An authenticated request is C(["UPT-REQUEST",1,configHash,principal,requestID,
method,context,argument]). Its signature covers every byte. The authenticated
principal comes from the enrolled key, never an unverified payload field. Monitor
keys may Authorize/OpenBoot/Close for their enrolled slot. Only the enrolled
hold/release authority may Retire/Release. Targets sign only their own application
acknowledgements. Methods never authorise a caller to add keys or enlarge coverage.
Malformed, unauthorised, exhausted or oversized requests are total error/no-change
operations. A valid request need not succeed.

## 3. Deterministic state, first grants and retries

Keep per resource the current generation, active/held state, immutable current
context, retained reservation and draining status. Keep per enrolled monitor slot
a boot high-water counter, closed sequence watermark and at most one outstanding
complete challenge/result, including its **original grant position and identity**.
Keep one last successful Retire request/result/origin per resource as well. It is
part of the certified state and survives log compaction and OpenBoot. An exact
Retire retry returns that original authorisation without advancing the floor again.
The concrete default has one outstanding challenge per slot; windowing is not
silently assumed. Never recycle a domain/resource/lease/monitor identity.

* Authorize: look up the complete challenge identity first. If its retained result
  exists and payload bytes match exactly, return that original receipt; do not
  append a first grant, reset its age, extend coverage or refresh anything. A
  different payload for that identity is Conflict. Otherwise require current
  active generation, exact enrolled context, current boot, sequence=closed+1 and
  an empty outstanding slot. Append the successful first Authorize with its exact
  context and commit identity; occupy the slot. Admission and coverage guards are
  the existing lease authority's deterministic validation of the agreed input.
* Retire: require the authorised caller and exact current context; append the
  barrier, advance the floor to g+1 and enter HELD/DRAINING. Retain the reservation,
  result slot and old lookup. It frees no capacity and is not a target acknowledgement.
* Release: require the authorised caller, held current generation, exact newly
  admitted context and strictly newer enrolled instance/boot. Only this ordered
  operation permits a new generation's first token. Retained old demand must still
  satisfy the existing admission/quiescence contract. An arbitrary higher number
  is not a release.
* OpenBoot: a fresh authenticated restart challenge advances the slot's boot
  counter strictly; it clears the former pending slot, resets its sequence watermark
  and returns the current generation/phase/context. It never clears HELD or lowers
  a floor. A stopped recipient cannot enable execution by replaying a former boot.
* Close: the recipient first durably consumes or abandons its current challenge,
  then sends an authenticated Close for that exact sequence. The ordered controller
  closes it, retains a high-water tombstone and deletes its full pending result.
  Old sequences now return Closed, never create a new grant. A repeated Close is
  idempotent. A future sequence cannot be closed speculatively.

The Lean `step` covers these guarded method bodies, including exact pending retries
while active. A cached receipt query is a read-only return of the original prefix
witness, including after retirement; it is not a later invocation of a first-grant
method. Consequently the proofs count no new held-generation grant from such a
query. Method-dispatch ACLs and original result IDs are checked by the executable
reference and specified here; the Lean result is not a compiler refinement of it.

“No conflict” has precise meanings: the same finalised position cannot name two
different transitions/results; the same challenge identity cannot acquire two
different first payloads; resource/lease/generation cannot acquire incompatible
owner, policy or coverage enrolments. Different fresh challenges in an active
generation may each get a grant. A pre-barrier grant and a later Retire are ordered
facts, not contradictory receipts. The immutable-generation rule and one-slot /
closed-watermark rules establish the latter two claims by transition induction.

## 4. Receipt and concrete verification

A prefix record contains absolute position, parent prefix root, exact authenticated
request bytes, deterministic result bytes and resulting state hash. Its new root is
H(C(["UPT-RECORD",1,...those fields...])). A stable checkpoint contains its absolute
height/root, the complete bounded application state (including all floors, boot and
closed watermarks, pending results and retained reservations) and configHash.

A final signature signs the entire C value

    ["UPT-FINAL",1,configHash,domain,
     checkpointHeight,checkpointRoot,checkpointStateHash,
     finalHeight,finalRoot,requestBytes,resultBytes]

not merely an index or a leader's request digest. A checkpoint certificate signs
the distinct "UPT-CHECKPOINT" schema with its exact state hash, height, root and
configuration. Certificates are a signed statement plus exactly q sorted pairs
[replicaIndex,signature]; duplicate, unknown, inactive or out-of-order identities,
wrong lengths, extra entries or any bad signature reject the whole certificate.
Every supplied signature is verified, not only a successful subset.

Use pure Ed25519 with enrolled valid public keys, RFC 8032 §§5.1.2–5.1.7 and §7.1
test vectors. It has 32-byte public keys and 64-byte signatures. The protocol signs
the canonical statement bytes; it does not substitute pairwise MACs for transferable
certificates. Key endowment, signature unforgeability and SHA-256 binding stay named
premises. The separate OpenSSL check exercises actual signatures; the package's
finite unit tests explicitly use an emission-table signature fixture.

A receipt carries checkpoint state/certificate, at most E succeeding prefix records,
the final certificate, and the named transition's absolute position/original grant
identity. If the operation is already in the checkpoint's retained pending-result
table, its original full result and origin are part of that certified state. A
new certificate can wrap that same retained grant; it cannot change its identity.
No unbounded historic inclusion query is promised after its slot is closed.
The same rule applies to the last Retire table. A later retirement can supersede
that record only after the intervening generation was released under its normal
admission contract; older queries then return Superseded, and the current stronger
floor remains certifiable. Grant Close never deletes the current retirement record.

Recipient verification, in this order:

1. Parse canonical bytes under configured bounds; validate every schema, type,
   field length, config/domain, committee and caller/recipient identity. Match the
   *entire* request context to the locally outstanding authenticated challenge.
2. Verify every checkpoint signature and bind the supplied state to its signed
   hash. Reject a checkpoint below retained height/floor/boot watermarks. Genesis
   is the exact state/root pinned in the enrolled configuration, not a supplied one.
3. Starting from that checkpoint, check each absolute index and parent root,
   authenticate each request and its ACL, replay the deterministic transition,
   compare its complete result and resulting state hash, then recompute its root.
   A named success must actually be a successful Authorize or Retire in this replay
   or the certified retained-result table. Mere membership of a failed request is
   insufficient. Reject omissions, reordered records and invented success bits.
4. Verify every final-certificate signature on the exact canonical statement and
   compare both roots, heights, checkpoint and named request/result. Correct emitters
   certify only their executed PBFT prefix. An honest signer therefore places this
   history in the one common durable prefix; binding and replay fix its transition.
5. For a grant, require enabled state, generation at least the retained floor,
   exact current boot/sequence/nonce, unconsumed pending challenge and local age
   0<=age<L, within the separate caller deadline. Atomically consume that challenge
   with issuing the one protected refresh authorisation. Compare challenge identity,
   not certificate bytes or proof hash. No message can extend its issue time or L/W.
6. For a floor authorisation, require the exact pending hold request and exact
   resource/lease/target/old-generation/new-floor linkage. Atomically raise the
   retained floor by max and discard old pending grants. The target separately
   serialises its actual floor raise with durable application under E-LIN, persists
   it and **then** signs TargetApplied. Only acknowledgements for *both* J and K
   start their common held window; a residual effect keeps its reservation.

The reference executable implements canonical parsing, quorum checking, ordered
replay, exact result/context checks and persistent recipient transitions. Its small
fixture has one resource and one monitor. General finite tables are a product of
these guarded per-slot states, with capacity/admission checked by the existing
authority. It does not pretend to test a running distributed PBFT service.

## 5. Restart, checkpoint, retention and finite bounds

A recipient boots DISABLED before processing input. Atomically recover its protected
domain/config identity, largest floor and checkpoint height, boot high-water counter
and consumed/abandoned challenge state. Advance boot without wrap; discard all old
outstanding challenges. Obtain a nonce-bound OpenBoot result through this same
ordered, certified interface; install the maximum of retained and certified floors.
If held, inconsistent, exhausted, unauthenticated, unavailable or past deadline,
remain disabled. Re-enabling requires a fresh challenge under that new boot and
current active context. Every later recovery/installation uses max, never assignment
from an older checkpoint. A target also starts disabled and retains its applied
floor before acknowledging readiness; neither reset nor a new receipt restarts an
old permit lifetime.

If a checkpoint includes retirement of g, every recovery extending it rejects g.
If retirement occurred after that checkpoint but before the ordered OpenBoot,
OpenBoot reports the newer floor/held phase. If Retire is concurrent *after* a valid
grant's linearisation, a delayed pre-barrier receipt still proves that earlier fact;
no asynchronous protocol makes it evidence of the receiver's instantaneous global
state. It is rejected once the recipient/target has installed the floor, remains
bounded by its original challenge age before that, and cannot land through a raised
E-LIN target. This is the original ordered-permit theorem's grace semantics, not a
new instantaneous-revocation claim.

Replica restart also begins non-signing. Recover the last durable signing height,
root and full state; or fetch a valid checkpoint certificate no lower than that
retained anchor, verify it and replay an ordered certified suffix. Any disagreement
at an anchored position stops that replica. Persist restored state/high-water data
before re-enabling the emitter. A replica with unavailable protected recovery data
does not impersonate a recovered correct replica. Thus the adapter's recovery
transition refines append-only abstract execution. Atomic nonrollback persistence
is the protocol storage semantics; its hardware realisation remains a physical
premise. We do not claim PBFT Theorem 4.19 proves power-loss filesystem behaviour.

Checkpoint creation copies the **entire** bounded state after a finalised position;
QC verification commits to those bytes. Fold/replay associativity proves restoring
that exact state then replaying the suffix equals replaying the original history.
An ordered Close or OpenBoot is required before deleting its result. Closed sequence
and boot/floor high-water marks never disappear. Log compaction deletes only entries
at or below a certified checkpoint after that checkpoint and all still-pending
original results have been durably installed. It cannot restore a closed key or
change a grant's origin. This is our application-state refinement, not an unread
citation to PBFT's garbage-collection theorem.

Configure finite bounds R resource/lease slots, M monitor slots per resource, E
records between checkpoints, B maximum record bytes, S maximum full state bytes,
V maximum retained grant-proof bytes and q certificate signers. Enrolment rejects
new slots when full. A snapshot is at most S bytes; keep two certified snapshots,
at most E log records and one pending grant/proof per monitor slot. A conservative
replica application-store bound is **2S+EB+R(M+1)V**, plus at most q(w+64) bytes per
retained certificate, fixed enrolment/key storage and bounded PBFT message windows.
Do not confuse this application bound with the separate PBFT view-change store.
Using unbounded Theorem 4.19 for ordering is valid; a bounded real replica must apply
the cited algorithm's window/backpressure rules or stop accepting new work. This
adapter does not assert unbounded service in bounded memory.

For the lifetime of this configuration, every generation/boot/sequence/position
counter has the configured width and increments only below 2^(8w)-1. At exhaustion the operation
returns Exhausted and stops that namespace, rather than wrapping or silently
re-enrolling it. For a declared service horizon, commissioning must endow counters
and storage large enough for its priced traffic; no indefinite nonzero-rate service
with finitely many identities is asserted. Safety holds at exhaustion as well.
For a finite horizon with at most A admitted ordered operations, at most B boots
and at most C challenges per slot, choose w so 2^(8w)>max(A+1,B+1,C+1). For example
w=max(1,(max(A+1,B+1,C+1).bit_length()+7)//8) suffices, with a separate maximum
for any tick endpoint. This is an explicit parameter construction, not an 18-quintillion
operation limit silently applied to the theory's 10^100-date horizon. Configure input
rate/slot bounds first and include retries, errors and checkpoints in A; counter capacity
is then derived from their finite bill. No physical throughput is inferred from the width.
Outstanding windows, input queues, admitted retries and batch sizes are configured
finite; excess returns Busy without allocating durable state. Tombstones are one
high-water tuple per pre-enrolled slot, not a growing set of all old nonces.

In particular, reserve generation 2^(8w)-1 as a terminal HELD floor: active grants
and Release are forbidden there. Retire from the last active generation 2^(8w)-2
can still advance into that floor. Exhaustion therefore cannot strand an active
generation without a representable retirement barrier.

## 6. Response, deadlines and errors

Each local call has a monotone-clock absolute deadline fixed before transmission.
It returns VerifiedGrant, VerifiedFloorAuthorisation, a certified deterministic
Rejection, or local Timeout/Unavailable/Invalid/Closed/Conflict/Busy/Exhausted.
Pending is a progress state, never permission. No valid response before the deadline
returns Timeout. Timeout is **unknown commit outcome**, not proof the operation
failed: keep its reservation and exact challenge identity; query/retry that same
identity or first durably abandon it and Close it. Never replace it with a new
identity to create a second refresh. A timed-out Retire does not release capacity.
Delayed completions are matched to the original context and cannot reset age.

This is a bounded *response-or-error* contract, not a promise of a grant by any
chosen D. Under PBFT's stated eventual communication/progress assumptions an
admissible honest call can complete, but no finite numeric success bound follows
from Theorem 4.19. A known timed-channel bound must include signature/replay/durable
processing and queue/batch limits if a finite success deadline is required. The
existing clock and cessation bounds and their joint service charging stay item 5.
The earlier B=(L+W)/(1-rho)+R+Q calculation is unchanged.

Per returned receipt there are at most 2q replica signature checks plus at most E+1
request signature checks and E deterministic replay steps; a saved checkpoint can
amortise its q checks. Bytes are at most S+EB+two certificate envelopes+one bounded
result. At M_total monitors refreshing at interval h, include M_total/h first grants,
their replication/durable writes, all admitted retries, OpenBoot/Close/Retire/Release,
checkpoints and target acknowledgements. These are protocol bills, not measured
latencies or a claim they fit the plant. That fit remains in the existing pricing
and physical/timing boundary, not an extra theory rung.

## 7. Proof scope

`ControllerFinality.lean` proves honest quorum presence, the general quorum
intersection inequality, certificate non-equivocation at equal positions, certified
prefix inclusion, context-word injectivity, successful-transition inclusion, immutable
generation context consistency, monotone floors, checkpoint replay, single-use
consumption, disabled restart, retained-floor rejection and the bound on all issued
grants before release. `ControllerFence.lean` imports the **unchanged** UPTFence
proof and derives no landed write at either target in the held window from certified
grant/floor histories. It derives the old-token bounds; it does not assume them as
an unexplained mint restriction. A copied byte-identical UPTFence module is only a
build input so the existing package's standalone probe scheme stays unchanged.

New analytical proofs supply byte-codec injectivity, transition/key retention,
write-before-emission/recovery refinement, and the product storage/cost bounds.
Executable controls cross-check these on small exact states. The kernel proofs use
lists/naturals and one per-resource method body; they do not prove the Python parser,
signature implementation, PBFT itself, durable device semantics or a distributed
binary. Those are respectively our analytical codec argument, named cryptographic
primitives, the read cited PBFT theorem, and retained physical premises. None is
hidden inside a predicate called “finality” whose postcondition merely repeats the
desired conclusion.
