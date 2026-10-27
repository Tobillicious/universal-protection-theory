# IR-24: Physical-event correspondence needs a residual bound

Channel classification alone cannot certify an actual physical system.
The *physical* event type is explicitly distinct from the *modeled*
channel type. A valid abstraction must prove, for each relevant event:

physical_effect(e) <= modeled_charge(encode(e)) + residual(e)

Lean proves a real-event finite-trace inequality from those pointwise
correspondences, combined with a total modeled budget and a separately
bounded cumulative residual. The second theorem imports IR-23 and
derives the modeled part from a strictly progressing clock and
per-event cap, rather than freely assuming the aggregate charge budget.

An explicit counterexample shows classification into a zero-charge
channel is compatible with arbitrarily large physical influence absent
the correspondence/residual premises.

These are conditional arithmetic proofs. No actual real-world channel
inventory, experimentally measured residual, clock endowment, complete
environmental dynamics or identity-relevant meaning has been proved.
