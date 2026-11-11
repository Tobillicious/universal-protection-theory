# Whole-event enactment: coherence and direction review

8 November 2026. Source pin: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Read [KoruWholeEventEnactment.lean](../physical-bridges/PhysicalBridges/KoruWholeEventEnactment.lean) in full. Proof-body review plus the narrow independent integer calculation below; no fresh Lean kernel replay.

WholeOperatorEvent retains three complete expression trees (subject, action, effect) and two ordered role indices. enactmentFootprint evaluates action then subject as the ordered matrix product. EnactmentCoherent means evaluated effect equals that footprint. It is an algebraic consistency predicate, not authentic authorization or safety; it does not require identical syntax between effect and a product expression.

The module proves product covariance for every W iterate by induction from one-step covariance, and injectivity of each iterate by undoing W. Expression-evaluation covariance then yields footprint covariance. Coherence preservation is immediate in the forward direction; reflection explicitly uses injectivity to cancel the evolved outputs. Consequently an incoherent event cannot become coherent merely through this transport either.

Entry transport proves preservation AND reflection of all nonzero directed footprint entries at tracked positions, including the designated intrinsic enactment link. Separately, expression-map and role-transport injectivity prove full event nonmerging. This stronger syntactic result must not be confused with injectivity of evaluation itself: distinct expressions can evaluate equally and still remain distinct events.

The concrete sample uses subject E22, action E32, and an effect expression whose evaluation is the ordered product. Source coherence is definitional; direction is independently checked from the product entries. I independently recalculated, using six-by-six integer matrices and the swap permutation (0,1,3,2,4,5): E32 E22 = E32; entry (3,2) is 1 and reverse (2,3) is 0; W conjugation respects this product and both tracked entry values. All assertions passed, exit code 0. This sample replay is not an enumeration of all matrices or a new compiler pass; the general all-stage claim is in the reviewed source proof.

The final theorem simultaneously transports coherent effect, true forward link and false reverse link through every modeled stage. These are nonvacuous ordered operator facts. They do not by themselves authenticate experiencing subjects, consent, ethical entitlement, complete physical dynamics or the original six duties. The subsequent objective-whole construction supplies a common source context for the three expression fields; this standalone event type does not impose that additional provenance by itself.

No theorem source changed.
