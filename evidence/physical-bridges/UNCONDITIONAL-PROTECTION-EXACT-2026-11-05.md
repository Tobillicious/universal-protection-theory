# Unconditional protection, exactly

**Prepared 5 November 2026 · base `9088d9a` · Lean module `PhysicalBridges/UnconditionalProtectionExact.lean`**
**Status: kernel-checked in a model. Not independently reviewed. No physical instrument has been tested.**

## What is proved

`unconditional_protection_exact`. For every locale, with no assumption about any optimiser's values, objective, routes, spawning or running time:

- **If every boundary edge is metered,** then against every policy and for any number of ticks:
  - everyone alive stays alive;
  - no non-consenting particular loses anything;
  - consent records are untouched;
  - every step carries the six modeled duties;
  - every mind whose lineage never chooses retirement continues, in states it computed itself.
- **If any one boundary edge is unmetered,** one agent ends a particular in one tick.

Protection against every optimiser therefore holds exactly when the boundary is metered. It is unconditional over the mind and conditional on the boundary.

### What this module adds

`sealed_region_is_exact` already gave the survival half. This module adds:

| Theorem | Content |
|---|---|
| `mind_continues_by_its_own_steps` | Holding a mind does not erase it. |
| `hostile_attack_is_delivered_and_blocked` | The attack really reaches the world and is really intercepted. |
| `hostile_mind_and_target_coexist` | A mind that requests "end everyone" every tick and its target both persist for any number of ticks. |
| `benign_action_passes_the_fence` | A harmless action through the same metered edge takes effect, so the fence is not a freeze. |

### Checks

- Lean 4.35.0 `lake build` passes (249 jobs), with no `sorry` or `admit`.
- The new theorems use only `propext`, `Classical.choice` and `Quot.sound`.
- Mutation test, run outside the repo: survival with the meter hypothesis removed is refuted in the kernel by a concrete gap locale.

## What this does not prove

**The ontological thesis.** "ALL IS ONE. ALL IS. E IS NOT. THUS G" remains an unproved claim when G means protection. This module shows why those premises cannot carry the conclusion:

- `no_thesis_both_true_and_protective`: a thesis that excludes a harm is false of any world where that harm occurs. A thesis true of such a world does not exclude the harm.
- `ontological_premises_hold_through_severance`: no-loss-of-being, reverse closure, individuation and connectivity all hold across a step that loses a reciprocal relation. Reciprocity does not close the gap either.
- `persistence_is_exactly_no_loss`: the premise that would exclude the loss states that no loss occurs. Adding it assumes the conclusion.

**The dilemma this leaves.** Read "no owed particular is ever lost" as a claim about live relations and it has content, but people have died, so it is false of the actual world. Read it as "every particular remains part of the whole, timelessly" and it may be true, but a killing satisfies it, so it protects no one. A claim about the future can escape this only by having a mechanism, which is what the boundary theorem supplies.

**The real world.** All of Part I lives in the model of `SealedRegionCapstone`:

- Locality is written into the semantics, not derived.
- Consent is a recorded Boolean, not authentic authorization.
- Owed particulars are coordinates of a world outside the region.
- **There is no agent-to-agent channel,** so minds cannot harm one another by construction. Mind survival is only as strong as that omission.
- The six duties are the modeled relations, not verified subject-level meanings.
- Whether any real installation has this shape, with every effective route metered, is an open empirical question.

**Physics.** Nothing here is a theory of everything or a seed of one. It derives no physical law and makes no measurement prediction.

## What would move this forward

1. **Independent human review** of this statement and its model, by a formal-methods researcher with no stake in the outcome. All checking so far has been the kernel, CI, the author and AI systems.
2. **Add an agent-to-agent channel** to the model and re-prove or refute mind survival. This is the sharpest open gap in the theorem above.
3. **A physical test:** one real boundary, hostile controls, independently observed effect channels, with failures published.
4. **A falsifiable prediction** that follows from UPT and not already from standard physics. Without one, "law of physics" is not an available claim.
