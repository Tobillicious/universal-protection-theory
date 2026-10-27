# IR-79 — Watchdog detection-to-quiescence with physical effect margin

This is an adversarial repair responding to Gemini's proposed watchdog latency, non-bypassability and absorbing-hold results. The original user's complete X3, 24 Oct preservation archive and original positive freedom/continuation duties are NOT redefined or weakened.

## The mathematical result (pinned Lean, after successful CI)

An episode records fault time f, detection time d, final effect-fence time g and fully drained/quiescent time q. Three **independently supplied** phase promises:

- f ≤ d ≤ f + detectionDelay
- d ≤ g ≤ d + fenceDelay
- g ≤ q ≤ g + drainDelay

yield **q ≤ f + detectionDelay + fenceDelay + drainDelay**, without supposing that a physical safe state already exists at the fault time or at the instant a gate changes. The source also proves every clock instant during the response window has elapsed age at most the total delay.

If a true physical quantity at f is at most recorded readout + sensorError, if **every** intermediate physical instant t satisfies

`physical(t) ≤ physical(f) + (t-f)*risePerTick + residualEffect`,

and if the reaction margin satisfies

`readout + sensorError + totalDelay*risePerTick + residualEffect ≤ threshold`,

then **every modeled tick from fault through quiescence** remains at or below threshold, including the final instant. This is a conditional physical-envelope result; it is NOT a proof that a real catastrophic fault met the initial safety margin. If the fault has already crossed the threshold, its hypotheses fail.

An external controller must separately validate actual detection, effect-fence and complete-drain phase bounds; clock fidelity; sensor error; rate envelope; entire residual physical-energy/in-flight effect budget; hidden channels and micro-events. At present these physical facts remain OPEN.

## Concrete negative controls and independent prior-source join

- `actualEffect false command bypass = bypass`, not zero. Thus a disabled gate fails to prevent physical effects through a nonmediated path; source-level circuit multiplexing is not an exhaustive physical pathway proof.
- The existing IR-32 `IRInFlightQuiescence.barrier_holds_under_any_finite_interleaving` is imported to prove exact modeled finality AFTER complete closure, in-flight drain and actuator queue drain.
- A finite delayed shutdown can reach a quiescent endpoint *after* an earlier physical threshold breach; terminal quiescence does not erase earlier damage.
- A permanently absorbing 'hold' that cannot deliver service violates a mandatory positive eventually-service duty. Thus the physical hold ≠ full historical X3 continuity or autonomy.
- The synthetic IR-77 typed accepted trace can coexist with an unrelated true physical effect above a safety threshold if no source-to-physical refinement is established.

## Corrections to Gemini's proposed proof

1. The assertion that an interlock has already placed the physical system in a safe state throughout the response interval was an **assumption stronger than the intended conclusion**. IR-79 does not use that circular shortcut.
2. A Boolean multiplexer proves only the modeled path's selection; it does not prove no bypass, flyback, passive momentum, stored energy or latent effects.
3. An absorbing state is an abstract state transition premise, not proof of a physically zero-loss hold. Even a well-founded latch cannot by itself deliver ongoing service or preservation.
4. Sensor pass/fail after a finite sample cannot establish fault visibility in real time. Timing premises need independent physical detectors plus a bounded observation latency and pre-fault protective margin.
5. The source's additive residualEffect is a conservative **upper bound** covering all post-fence physical effects. It cannot be derived from electrical energy totals alone without a justified model relating energy and the relevant physical harm quantity.

This module is distinct from the IR-75 recovery-information and IR-76 outward-bath physics joins. Original universally quantified X3 remains OPEN. No physical instrument is claimed installed or certified.
