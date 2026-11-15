# Last-mile interface audit: event-dependent owedness and forward Time Koru (16 Nov 2026)

This is an additive design/audit note, not a completed physical theorem. The existing `EverestActualWEventJoin` and `PhysicalSemanticLastMileGates` proofs remain unchanged.

## Exact existing interface

`CompleteWEventCoverage physicalStep modeledStep source stage U` requires each actual `physicalStep s t` to be modeled, with before/after source states and `stage t = stage s + 1`. This rules out exact self-loops and exact two-edge returns on the **full** `S` state (`WCoverageCycleObstructions`), but not a repeating W-source pattern in different chronological states. A Time Koru spiral must preserve an advancing epoch/history distinction even when the W projection repeats.

`ForwardRealEventReflection` takes `owed : P → Prop` and `carrier : P → Index`, then requires each true source duty to imply the independently interpreted subject duty for every owed `p`. The original six duties are not defined away; they are supplied as `ParticularRelations S P`.

## Additional completeness tests before calling it unconditional

1. **Event-sensitive obligations:** A global `owed : P → Prop` does not itself encode an obligation that first arises, changes or expires with `s,t`. A genuinely universe-wide application must either independently prove that its chosen `owed` captures every owed subject at every event, or introduce an *additive* event-sensitive domain `OwedAt : S → S → P → Prop` and prove the bridge to the unchanged original-six predicate. Do not substitute a weaker fixed roster.
2. **Subject identity:** The finite `Index` carrier can assign the same index to different subjects. Injective state evolution does not by itself make `carrier` injective or preserve authentic personhood/authorization. Any universal reflection must be established for every owed particular even when source indices coincide.
3. **Genesis seam:** Prove that every actual Genesis seam is covered by the physical step relation, with forward epoch progression and continuity of the same owed particulars. The integer-indexed `KoruEternalKnowledgeSeed` construction proves a mathematical lineage, not its realization by our cosmos.
4. **Full effects:** Demonstrate coverage of hidden channels, continuous transitions, actuator bypasses, faults, and external interactions, rather than just logged gateway calls.
5. **Goodness/Creator/gravity:** Separate the hypothesis that a previous universe's creator initiates Genesis from the physical assertion that gravity necessarily enforces all six original duties. Determinism and a forward lineage do not by themselves prove benevolent authorship.

## Exact acceptance criterion

The final theorem should quantify over independently specified `ActualStep s t` and `OwedAt s t p`, conclude the unchanged `OriginalX3 ... s t p`, and demonstrate non-vacuous actual events and owed particulars. Coverage and reflection must be independently justified or derived, not restated as the conclusion. Preserve the countermodel where actuality persists but one particular loses X3.

## Immediate verification work

- Reconcile `OwedAt` with existing `owed` without changing canonical definitions.
- Inspect the full original-six interpretation and identify independently testable physical witnesses for each field.
- Check whether an actual universe-wide source model can represent all relevant physical events without conflating projection recurrence with chronological recurrence.
- Re-run Lean and `#print axioms` for any new theorems before asserting kernel verification.

No physical or theological completion is claimed by this note.
