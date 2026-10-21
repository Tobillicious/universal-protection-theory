# Bounded recovery work does not bound full-history storage

The checkpoint construction bounds the replay suffix. It deliberately retains the entire committed input journal, so it does not supply a constant storage bill for an unbounded run.

The elementary counting obligation depends on the admitted history family and on side information. If a common decoder must recover every one of 2^T possible binary histories of length T from a device with W binary cells, losslessness makes the encoder injective. There are only 2^W device states, so W≥T. For every binary history of lengths zero through T, the number is 2^(T+1)−1; a fixed W-cell device therefore has W≥T+1 when T≥1, unless some distinguishing information is supplied elsewhere and charged separately. These are finite cardinality arguments, not a physical energy bound.

That linear bound must **not** be imposed on a deterministic single trajectory as though it had arbitrary binary branching. If f, feedback g and the initial state are all fixed and available to the decoder, there may be only one admitted ideal history at each length. Its T+1 distinct prefixes then yield only the counting bound 2^W≥T+1. A program and length can sometimes regenerate the history, exchanging storage for computation. Computation time, program availability, exact length and the author's identity/replay convention still need an account.

Conversely, compression of a special family does not establish lossless compression for arbitrary histories. An environment, external archive or seed that supplies the distinguishing information is part of the joint decoding resource. Treating a Lean `Nat` as one field does not make its unbounded values occupy one physical bit or one fixed register.

No infinite-horizon storage assertion is attributed to the finite I-1 certificates here. A finite application should name its admitted histories, horizon, decoder side information, journal/checkpoint footprint and recovery time. The new window proof addresses recovery evaluations after the last crash; it does not replace that bill or close the physical phase.

This note is an analytical scope check. It is not advertised as a Lean cardinality theorem or a new attack on the author's accepted archive format.
