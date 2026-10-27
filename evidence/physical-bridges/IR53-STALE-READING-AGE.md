# IR-53 — Maximum authenticated reading age under sampling jitter

A fixed sampling period is an *assumption*, not a fact about a
fault-prone instrument. Sensors may stall, skip frames, reset, or
replay an old reading.

This follow-up permits irregular observation times by supplying
`lastSample(t)` and an explicit predicate indicating that a genuine
reading was taken there. The theorem establishes all-time safety
in the discrete model only if:

1. the last sample exists, precedes the current time, and is no older
   than a justified maximum;
2. every physical rise since that sample is bounded by the declared
   per-tick rate;
3. the actual reading includes the entire max-age × max-rise margin.

Negative controls show that a physically rising variable can be
safe when first read and later unsafe; a permanently retained old
reading fails even a modest claimed age guarantee.

The theorem does NOT show that a real sensor is authentic, that
the latest reading has been correctly identified, that timestamps
are trusted, or that the real continuous physical trajectory
satisfies the envelope. Those require independent measurements and
fault-injection testing. The original X3 freedoms remain unchanged.
