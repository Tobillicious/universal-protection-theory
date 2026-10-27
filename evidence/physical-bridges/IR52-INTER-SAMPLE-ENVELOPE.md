# IR-52 — Measured inter-sample envelope, not endpoint faith

IR-51 establishes safety of every **represented** physical microstep
under explicit guards. A real instrument may sample only a subset of
times. Even if each sampled reading is below threshold, an unobserved
pulse can exceed the threshold and disappear before the next reading.

This module proves conditional safety for every integer-valued time
when a positive sample period and a physically correct maximum
within-interval rise are supplied. Each sampled value must reserve
an entire period's upper-rise margin below the safety threshold.

Its counterexample sets the physical quantity to 3 at time 1, and
zero everywhere else; all even-time samples remain below 1.
A second theorem shows that the pulse violates an alleged zero-rate
inter-sample envelope.

## Remaining real-world obligations

A measured/physically derived maximum rise rate, complete sensor
coverage and timestamp alignment, actual sampling/dropout bounds,
uncertainty and out-of-band physical transients, and faithful
correspondence from the discrete model to continuous time.

Nothing here experimentally certifies a device or ensures subjective
or historical continuity. The result is a conditional mathematical
implication, with original published Snuffy sources and X3 unchanged.
