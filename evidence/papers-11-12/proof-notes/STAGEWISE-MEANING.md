# The exact no-needless-loss characterisation

The captured Lean source's `Needless` includes **current-stage containment**: a feasible alternative preserves everyone kept at the current stage and adds a person not currently kept. Its lexicographic recursion then restricts later-stage competitors to options equal at all earlier keys.

For a feasible chosen option, absence of that loss at every stage is equivalent to canonical lexicographic alignment. `StagewiseMeaning.lean` proves both directions for arbitrary outcome and person types and any finite list of stage keys. The reverse implication uses classical double-negation elimination for arbitrary predicate sets; the axiom report records `Classical.choice`, `propext` and `Quot.sound`. No extra axiom or `sorry` is introduced.

The current containment clause matters. With two residents, consider kept sets {a} and {b}. Both are maximal for inclusion. Neither preserves the other's kept resident, so neither supplies a needless-loss witness against the other. A predicate that merely finds someone newly kept calls both choices defective, despite both being aligned in the declared partial order. This is the round-4 printed-definition mismatch, rather than a failure of the source Lean theorem.

Feasibility matters as well. In an empty feasible family, no feasible witness exists against any option, while no option is aligned. The file proves this counterexample without axioms.

`stagewise_meaning.py` independently compares all three-option, two-person, two-stage families and feasible masks. The test checks the actual inclusion order and the predicate directly, not the theorem's proof recursion. It also counts disagreements with the printed predicate lacking current containment.

## An equally valid alternative wording

Earlier-stage **equality** is the exact source recursion, but it is not forced by the global alignment characterisation. One can instead allow competitors preserving all earlier-stage sets, as long as they also preserve the **current** set and add the lost individual. `WeakPrefixMeaning.lean` proves that this alternative's absence of needless loss is also equivalent to canonical alignment, with chosen-option feasibility retained. At an aligned choice, a preserving feasible competitor cannot strictly improve an earlier stage, so it actually ties those earlier stages. Conversely a lexicographically better option supplies a witness at its first strict stage.

The independent finite check verifies this alternative in the same 98,304 cases. Thus a repair saying "keeps everything through the current stage, plus the lost individual" can work; the author need not adopt the exact equality-based witness definition. The two definitions can name different witnesses at options already unaligned, while agreeing on global absence of needless loss. Neither licenses the currently printed omission of current-stage containment.

This supplies a precise candidate text/definition correspondence. It does not resolve which order the theory should adopt, establish a physical necessity, or amend the author's release.
