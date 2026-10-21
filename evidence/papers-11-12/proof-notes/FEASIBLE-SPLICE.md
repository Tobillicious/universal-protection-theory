# Another sufficient route to the no-killing conclusion

The existing counterexample shows that an alive-top H need not itself dominate every lethal action under the full canonical stochastic order. Making H a top for the full order is one sufficient correction. A different sufficient premise is **feasible selective repair**, which need not make H dominate every action.

Take an action A and a set B of branches on which H strictly increases A's first-stage life set. Define a patched action P to use H on B and A elsewhere. Then A≤L P in every state: on B the first key strictly improves, and off B the whole outcome is unchanged. Every upward event is preserved. In a finite probability model, positive mass on a changed branch gives a principal upward event with a strict probability increase. Thus P strictly stochastically dominates A.

`FeasibleSplice.lean` proves statewise comparison, upward-event preservation, a separating principal event and the finite positive-weight strictness lemma. The probability conclusion follows by normalising the common positive total of those weights. It does not assume all alive-top holds are full-order tops.

Consequently, if **every** feasible action with a positive-probability life deficit has an available feasible selective repair of this kind, none of those actions is stochastically maximal. This is a new conditional sufficient premise. It is not inferred from the mere existence of H and is not asserted to be a physical necessity. Zero-probability losses alone cannot yield strict stochastic dominance under that law.

## The feasibility and information obligation

The formula describes a state-contingent action. A decision-maker may be unable to distinguish the relevant states before choosing. If only a coarse observation is available, choosing H exactly on the desired branches may be unavailable. An observable selector and a policy family closed under the indicated selection suffice; other implementation methods may also suffice. The proof does not produce either property from outcome tables.

In the round-4 three-world family, H has outcomes `(2,2),(2,1),(2,1)` and A has `(2,2),(2,2),(2,0)`. The patch is `(2,2),(2,2),(2,1)`: it keeps A's extra freedom on real-1 and uses H to save the threatened person on real-2. At equal positive world weights this patch dominates A while H does not.

If the only observation distinguishes false alarms from real alarms, real-1 and real-2 remain in the same information cell. No policy selecting between H and A on that information strictly improves A in this example. With full state information, the patch is available. Some intermediate partitions also work because A and H agree on the false-alarm outcome; full information is sufficient, not claimed necessary.

`feasible_splice.py` checks all 2,401 two-world alive-top outcome pairs, including 1,776 strict repaired pairs, and all five information partitions of the three-world witness. This locates a genuine alternative repair obligation: prove feasible branch repair, rather than treating a clairvoyant splice as automatically available. No new D-H assumption, author ruling, release edit or physical feasibility certificate is silently inserted.
