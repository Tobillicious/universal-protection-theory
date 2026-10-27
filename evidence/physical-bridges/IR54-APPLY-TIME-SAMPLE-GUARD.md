# IR-54 — Fresh at decision is not necessarily fresh at physical application

This joins two existing source-level results:

- IR-53 supplies a **last genuine sensor reading at application time**
  with explicit worst-case age and physically bounded rise since it.
- IR-1R supplies the corrected conservative **post-effect** guard,
  including the actuator effect rather than checking only the
  pre-effect state.

The result proves post-effect safety only when the final apply-time
guard includes:
`reading + sensorError + maxAge*maxRisePerTick + maxEffect <= threshold`,
and the actual physical effect is within the separately justified
maximum. A decision-time-only guard can authorize an effect that
becomes unsafe after unaccounted sensing/actuator latency. An explicit
counterexample demonstrates that failure.

**Real-world gaps:** authoritative last-moment sensor age and epoch,
valid sensor units/errors, complete intermediate physical dynamics,
an authenticated correct action/effect bound and atomic enforcement
at each real physical commit. The modeled mathematical implication
is not a physically measured instrument and does not prove
historical/subjective continuation.
