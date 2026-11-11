# Objective-whole construction and fixed-role history consequence

8 November 2026. Source pin: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Read [KoruObjectiveWholeU.lean](../physical-bridges/PhysicalBridges/KoruObjectiveWholeU.lean) in full. This revisits a foundational dependency at proof-body level; no fresh Lean compilation or new kernel-checked declaration is claimed.

FiniteObjectiveU is exactly Index -> Expr Matrix6 WOperator. It supplies six source positions, each carrying an arbitrary finite operator-expression tree; it is not merely six scalar values, nor is it proved equivalent to the physical cosmos. objectiveStep transports the position and maps every expression atom through the fixed W matrix evolution. objective_operator_at_tracked_site proves the precise relationship between whole evolution and expression transport by induction using mapAtoms composition.

objective_wholes_do_not_merge evaluates equal evolved wholes at each tracked position, uses that relationship, then cancels injective expression evolution to recover equality at every original position. The proof retains full syntactic contexts, including distinctions that evaluation or a selected local view may omit. This is same-stage injectivity across initial contexts, not a claim that a terminal state uniquely records elapsed event count or all possible dynamics.

sourceWholeWeb derives its link from operatorEventLink at the first position's expression. complete_objective_link_carriage transports this specified relation exactly. A two-sided tracked-position reindex yields equality with the reindexed whole web and preservation/reflection of the existing binary Koru. The positive matrixUnit(2,3) witness explicitly proves one genuine Koru distinction and transports it through all modeled stages. These relational readouts do not by themselves encode every detail of the richer expression context.

The local event projection and whole evolution form an exact commuting square. The uniformObjective/changedElsewhereObjective control agrees on local roles 0,1,2 but differs at position 5. Whole inequality is proved by evaluating the differing atom and checking matrix entry (2,3): identity gives 0, the matrix unit gives 1. Injectivity preserves whole inequality at every stage; the commuting square preserves equality of local views.

## Further consequence, distinguished from a compiled declaration

The same explicit pair works for EVERY n in local_event_projection_gap_persists_at_every_W_stage. Thus the entire fixed-role sequence n -> LocalEventCut n U is equal for these two wholes by function extensionality, while their initial wholes differ. No universal exact decoder from that entire sequence to initial U can exist: a function must give equal outputs on equal sequences. At any chosen stage the current wholes likewise remain distinct. This is an immediate mathematical consequence of the reviewed theorem, not an added Lean theorem or fresh compiler result.

This sharpens the previous bank-reuse review's caution: although its named decoder theorems have single-stage observation types, the underlying SAME-pair/all-stages witness also establishes insufficiency of the complete fixed-role local sequence. It still says nothing comparable about arbitrary adaptive observation, additional source positions, or richer physical boundary access. In this example the omitted position is not brought into the chosen tracked local roles by W.

Finding: full syntactic source-context nonmerging and persistent loss under a specific projection are both supported. They are compatible: the projection discards information that whole evolution retains. Original-six subject fidelity and physical-domain coverage are separate questions. No theorem source changed.
