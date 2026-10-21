# A conditional co-hold certificate with an unchanged outside trace

`ClosedCohold.lean` adds two statements beyond an erasure identity. Both require a specified model rather than an asserted physical boundary.

First, for a supplied relation R of co-hold obligations and seed set B, reachability from B is closed under R and is contained in every R-closed set containing B. This gives the least co-hold set **for that relation**. Lean proves the general result without axioms. The relation must itself be justified: missing dependencies invalidate the application, and reachability cannot discover them from their absence in the input.

Second, suppose a joint state factorises as (s,e), with unheld transition `(f(s),g(e))`. During a co-hold of the first component it becomes `(s,g(e))`. This factorisation is a concrete independence premise. For any finite pause word, the first component ends at `f^(number of active ticks)(s0)` while the outside ends at `g^(all ticks)(e0)`. Moreover the **full outside state trace at global ticks** is the same as in the unheld product system. Both conclusions are checked in Lean. This is stronger than equating only an endpoint of a frozen joint state, but conditional on a stronger explicit separation premise.

An outgoing dependency breaks the result: if the outside update reads the held component, a pause can change the outside on a later tick. The file proves a small counterexample. Incoming dependencies can likewise change the held component's future inputs. Buffering, admissible observation quotients or a larger joint boundary may provide other sufficient interface contracts; this factorised construction is not asserted necessary for all faithful holds.

The independent finite check verifies all 61,440 four-node graph/seed combinations and 1,023 product-system pause histories. A deliberately illustrative resource example has seed cost 2, closure cost 10 and budget 7: certifying the seed alone does not certify its closure. These numbers are not a plant bill or a new physical bound.

A usable application certificate therefore has at least a justified dependency/interface model, a chosen closed set, a scheduler that enforces the freeze, a resource/deadline account for that whole set and a correspondence between logical and physical observations. The original I-1/rung-4 ledger is unchanged. This note contributes conditional mathematical certificates and identifies the remaining application obligations; it does not claim O-2B solved for an actual plant or world.
