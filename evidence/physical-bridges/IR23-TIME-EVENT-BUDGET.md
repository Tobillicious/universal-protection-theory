# IR-23 — A time-progress certificate makes an event budget derivable

IR-2 and IR-15 bound aggregate physical effects **if** a finite
cumulative charge budget has been physically enforced.

This repair supplies one **sufficient derivation** of such a budget:

- each modeled event advances an event clock by at least one tick;
- all events in the examined physical history finish before horizon H;
- each modeled channel effect has nonnegative influence at most C;
- every event belongs to the closed, charged IR-15 channel alphabet.

Then `length(trace) <= H` and `sum(charge(trace)) <= H*C`, so a
physical gate reserving `H*C` slack keeps the end-state below its
upper hazard bound. This is true regardless of the number of agents
creating events.

A separate theorem shows a clock frozen at zero can accommodate
arbitrarily many *modeled event indices*: without physical non-Zeno
progress the finite-horizon bound is unjustified.

**Still open:** a measured event clock with guaranteed minimum progress,
actual maximum effect per event (including latent and bypass effects),
complete event mediation, event timestamp fidelity, continuous dynamics,
and the relevance of the chosen threshold to historical preservation.

The clock is integer-valued and the proof covers nonnegative,
discrete modeled events only. No real device is certified.
