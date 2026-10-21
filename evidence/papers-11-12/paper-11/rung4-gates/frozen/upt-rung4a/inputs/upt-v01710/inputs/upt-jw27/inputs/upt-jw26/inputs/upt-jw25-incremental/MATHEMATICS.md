# Cost per k and incremental encoding — follow-up

This is an encoder-resource projection under the scalar price model, not an achieved joint k or an optimal cost curve. The sealed JW2.5 prefix and JW2.4 stay unchanged. All decisions use exact Fractions. A block is4KiB; delta work includes every16-bit word in a charged block even when only one byte changed. Repeated online updates count repeatedly unless safely coalesced. Nominal k means island erasure tolerance of the algebraic ciphertext code, not a completed physical guarantee.

## An alternative if the memory cap changes

Primary plus k foreign images at cyclic offsets1..k places k+1 copies on distinct islands. Erasing at most k islands leaves a ciphertext image by cardinality, with no parity arithmetic. Each image retains71 local holders and two generations. At the intact-pool population1032, held=71*ceil(1032/242)=355 records/host per mirror. The memory target is old_memory+2*k*355*(1+128/100000)+16. The k=1 value exactly matches the carried JW2.4 memory bound; k=2 exceeds4096.

Each extra mirror's endpoint traffic is2*1032*71*(4/3) state units/date. The charged copying/network increment is6.35024 energy units/date. With6 primary/forwarding roles, its conservative background host wire is(4/3)*(355+70*6+6), and background compute is that wire times COPY. Scale the existing receive/forward CPU reservations4+4 to4k+4k, host wire2048 to2048k and pool background2^21 to k*2^21, preserving foreground allocations. This preserves the ratios used by the snapshot data-copy service bound, provided its old calendar/priority contracts extend jointly. It is a conservative allocation, not the minimum possible one or proof of the complete service. The separate daily caps must also rise where the curve says so.

This replication curve omits new keys, control/root service, post-outage populations, recovery, reseeding, added memory/hardware capital and idle energy. It is a cheap encoder alternative when lifting memory is allowed, not a demonstrated new joint-k plant. The fixed4096 memory cap is why it cannot be silently substituted for the required affordable spread code.

## A code family with explicit costs

Let d=400-k. Take a k by d Cauchy matrix over the inherited GF(2^16), with disjoint field points x_i=i and y_j=k+j. Normalize its rows and columns so its first row and first column are1:

A_ij = (x_i+y_0)(x_0+y_j)/[(x_0+y_0)(x_i+y_j)].

All factors are nonzero. Nonzero row/column scaling preserves every nonsingular Cauchy minor, so the systematic matrix[I;A] is MDS. An entry outside the first row/column cannot equal1, because that would imply(x_i+x_0)(y_j+y_0)=0. Full encoding therefore takes(k-1)(d-1) nontrivial multiplications plus k(d-1) additions, or(2k-1)(d-1) operations per symbol lane.

Use400 cyclic stripes; each island supplies d systematic chunks, coordinates one stripe and stores k parity chunks. Let B=2^27 symbols/state and L=2048*ceil(1032B/(2048d)). This charges4KiB alignment. Each island supplies dL/B state units and stores kL/B parity units. The daily checkpoint rate is4/3. Data gather, forwarding the other k-1 parities, and70 extra local copies of every parity give2[dL/B+(k-1)L/B+70kL/B] endpoint state units per checkpoint. They are charged at COPY=127/80000 compute/unit plus the inherited network charge. Both parity generations and71 local holders are included in a conservative snapshot memory bound.

The interconnect16 line is an ENERGY ALLOCATION. It is distinct from host burst160, host daily128, and pool wire2^24. Here the priced encoding work is booked to that allocation alongside IO. Increasing the allocation requires energy headroom or more inflow and independently requires CPU and delivery capacity. These are normalized model quantities, not monetary quotations.

The table gives uniform per-island charges for the intact400-island snapshot, pool-average CPU over172 surviving local hosts, and an optimistic1/8 active interval before a final1/8 durable phase. Some island/host must bear at least the average. Actual scheduling may be worse. It omits new keys, metadata, repair, capture/reseeding, extra hardware capital/idle energy and the larger ongoing populations after island losses. It is not a claim that buying the displayed resources establishes the complete k. Fast or XOR encoders can have a different curve.

## Incremental identity and work

For linear parity P=A D, let Delta=D_new+D_old. Then P_new=P_old+A Delta. In characteristic two,+ is XOR. For one modified symbol outside the all-one column, forming Delta costs1 XOR, multiplying the k-1 nontrivial coefficients costs k-1 operations, and applying all k parity deltas costs k XORs:2k operations. The first column is cheaper;2k is a safe worst-position charge. Full encoding is unnecessary if old authenticated parity and only the new deltas are available.

If r charged input words change, the batch calculation uses at most min(L,r) changed parity positions per parity chunk. Input sparsity does not imply the same parity sparsity: changes in just one full data column can alter every parity page. The batch calculation charges coalesced parity fanout once per checkpoint. The online calculation charges fanout per applied delta, including repeated page changes; it does not take the coalescing discount.

For a batch, all charged work must fit the8-CPU reserve on172 hosts for1/8 date, with the corresponding network shares. For online maintenance, the same reserve is available throughout3/4 date. The latter is a throughput calculation. It does not guarantee a bounded final queue if writes arrive just before the checkpoint. A real online guarantee needs a per-window arrival/burst bound, backpressure compatible with committed care, and a maximum authenticated backlog before commit. The exact dirty-block frontiers solve these aggregate inequalities plus interconnect16, daily CPU128, background host wire2048 and pool background wire2^21. The next block is explicitly checked to fail. They are optimistic upper limits on the new update contract under this tariff, not proofs of a complete implementation.

The numerator of dirty fraction counts encrypted-page update applications, including tags/versions if placed inside the coded page, repeated online changes and any effective inflation caused by encryption. A small plaintext dirty set is insufficient. An independent full-image encryption can change almost every ciphertext word even when plaintext is constant. A sample control shows this directly.

## Key refresh can be separated from rewriting all ciphertext

A candidate change is independently authenticated/versioned page encryption under a stable data-encryption key kept inside the authorized attested instance, with fresh sharing coefficients or key wrapping rather than full-image encryption at each checkpoint. Unmodified encrypted pages remain byte-identical; only changed pages and authenticated version/root metadata are updated. This changes JW2.4's explicit fresh data-key-per-checkpoint contract and therefore requires a new security proof and price.

Share refresh need not change the shared secret. In Shamir sharing with degree k, at most k nonzero-point observations in a generation reveal no information about its constant term. Fresh independent polynomial coefficients give this property again in the next generation even when the secret is unchanged; views cannot simply be pooled as points of one polynomial. The mobile-adversary condition must bound distinct exposed shares during the FULL lifetime of each retained sharing generation, including overlaps, and require secure erasure/antirollback. A cap on simultaneously disabled islands alone supplies no such exposure bound. One sufficient key-holder count is2k+1 with threshold k+1 for k<=199, with reconstruction solely inside authorized trusted execution. Sharing, refresh, release, attack budgets and longer key lifetimes still need joint pricing and C-SEQ verification. The cited proactive-sharing literature supplies mechanisms under its own assumptions, not a realized service in this plant.

Incremental encryption must not leak action-dependent page addresses, dirty counts or timing through the operator view. Padding counts alone does not conceal addresses. An oblivious update schedule or equivalent C-SEQ realization has to be supplied and charged. Every checkpoint needs an authenticated root tying page versions, code version, placement and identity together; deltas need monotonic version checks and replay deduplication. Applying the same XOR delta twice cancels the update. Initial encoding, full rebuilds, recovery under partial transfers and reseeding remain charged events; the steady-update table does not make them free.

## Attack scope

The k=1 construction tolerates one whole-island erasure per400-island pool over its defined window, including an adversarial outage, PROVIDED its freshness, unique execution, capture, release and local-fault contracts hold. It is not confined to ordinary faults. It cannot cover coordinated attacks causing two image-island erasures, and it proves no positive global coalition fraction without a justified sampling/placement/exposure and pool-cap argument. The original local ordinary-fault law by itself also does not supply a global whole-island law.

Appropriate wording: conditional continuity under at most one whole-island loss per pool/window; broader resistance to coordinated island withdrawal remains unestablished. No manuscript or release file was changed here.
