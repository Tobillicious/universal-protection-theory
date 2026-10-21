# JW2.5 task 1: checked arithmetic and its scope

All decisions use exact Fractions. Decimal displays are inherited directed floors. This is a budget-limited partial investigation, not a proof that no affordable spread code exists.

## The scalar charge obstruction

Take n=400, d=400-k, M=1032 states/island, checkpoint rate 4/3, and the inherited maximum state size 256 MiB. A state has B=2^27 two-byte symbols. The carried scalar GF(2^16) charge is f=127/10^9 compute/operation, with energy 1/127 per compute. This is a modeling charge, not a physical lower bound; an implementation costing less is not ruled out by an upper-bound performance target.

In a systematic coordinate-wise scalar linear MDS code, each parity symbol must depend on every one of its d data symbols. Otherwise erase that missing data symbol and the other k-1 parities. The remaining symbols cannot determine the missing input, contradicting MDS. A circuit with scalar binary fan-in needs at least d-1 combining gates to connect d independent input leaves to one such output. Shared intermediate results and FFTs cannot avoid that bound for the first output. It is deliberately weak: it ignores the other k-1 parity outputs, padding, IO, encryption, headers, keys and decoding.

The pool-average per-island operation lower bound is M B (d-1)/d per checkpoint, hence (4/3) M B (d-1)/d per date. Multiplying by the scalar charge gives the priced floor in RESULTS.json for every k=2..100. This exceeds even the entire unused part of the16 interconnect allocation. Its encoding time exceeds1/4 date even if every one of the172 guaranteed live hosts gives all160 burst CPU units to encoding. Some island must meet at least the pool mean, so average failure suffices to reject a uniform island cap.

This argument applies to this scalar linear arithmetic model. It does not charge a SIMD XOR over a whole packet as one scalar operation, disprove a cheaper bulk primitive, cover arbitrary nonlinear encoders, or establish a lower bound across all binary array codes. Extending the conclusion to those models would require their justified prices and algorithms. The operation charge inherited from JW2.4 was itself a performance target; a lower bulk charge would be a new justified target, not an algebraic impossibility.

## Explicit two-erasure code

Over the checked field with modulus0x1100b, take398 data symbols x_i and distinct nonzero a_i=i+1. Keep the data systematically and append P=sum x_i and Q=sum a_i x_i. Sums are XOR. If two data symbols u,v are absent, the two residual sums satisfy s=u+v and t=a u+b v. Their determinant is a+b !=0, so v=(t+a s)/(a+b), u=s+v. One absent data symbol plus one absent parity is recovered using the remaining nonzero coefficient. Two absent parities are recomputed. These arguments cover every message, not only the deterministic test vector.

The checker reconstructs all79,800 two-erasure supports from the surviving symbols of one nontrivial398-symbol message. For three absent data symbols with coefficients a,b,c, the nonzero perturbation (b+c,a+c,a+b) has both parity sums zero. Thus three data erasures really are ambiguous.

Encoding costs2(d-1) additions plus d-1 nontrivial multiplications per lane, since a_0=1 needs no multiplication:3(d-1) charged field operations. This is a concrete inexpensive-in-operation-count improvement over a dense high-parity encoder; it still fails the inherited scalar tariff badly.

## Striping and padding

Use400 cyclic stripes. Stripe j puts its two parity blocks on islands j and j+1, and its398 systematic blocks on the other islands. Every island supplies398 input blocks, coordinates one stripe, and stores two parity blocks. Let L=ceil(M B/398) symbols/block. Each island holds398L/B input state units and2L/B parity units. Padding is charged explicitly. Code overhead is400/398, not an extra full coded copy plus the original data.

This layout reuses the old full local primary snapshots. Each extra parity block needs71 physical holders against70 local compute erasures, with two generations. The conservative whole-state packing bound is71 ceil(parity_units/242) extra records/host. Additional streaming buffers and metadata reserve16 units. It fits memory; memory alone does not make the encoder affordable. Gather all data once to the stripe coordinator, send the second parity block, and locally fan out both parities to70 additional holders. The ledger counts both endpoints and copying/network work, with no free communication.

This is a snapshot encoder layout, not a complete service implementation under concurrent faults. No free repair-bandwidth assumption is made: a dense code can require reading much more than one lost-state byte to reconstruct one lost-state byte. JW2.4's mirror-transfer formula and its timing22 must not be reused as an established MDS recovery bound.

## Necessary plant changes, not sufficient ones

RESULTS.json gives necessary bulk-price ceilings for interconnect16, daily128 CPU, reserved8 CPU and checkpoint lag1/4. The lag ceiling gives the encoder only the optimistic1/8 before the inherited final1/8 durable phase and gives all172 hosts the available reserve; IO/propagation consume no time in this bound. A price at this ceiling is necessary, not sufficient. Increasing energy alone does not fix CPU or checkpoint latency. The displayed additional energy/flow numbers are only lower bounds or the explicitly charged snapshot encoder, not a complete new plant design.

Spreading work over extra dates does not preserve the age<=1 contract for unrestricted new full states. Re-keying an unchanged encrypted checkpoint can save work, but an unrestricted changed state has different parity; merely re-wrapping an old key does not update it. An authenticated dirty-fraction bound, a different state-size bound, a cheaper packet primitive or a different freshness contract could change the answer. None is silently introduced here.

## Remaining work

No affordable spread encoder above k=1, global maximum k, or smallest sufficient plant change has been established. Task1 remains partial. Matching keys/mobile refresh, faster recovery and a joint21-account result (tasks2–4) have not been executed. The only carried complete conditional construction is JW2.4's k=1, with all its physical, freshness, release and common-floor assumptions.
