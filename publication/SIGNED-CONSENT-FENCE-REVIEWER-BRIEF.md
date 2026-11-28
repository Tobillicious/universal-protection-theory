# The signed-consent fence — a two-page brief for AI-control reviewers

**Author:** Tobias Croydon McRae (Universal Protection Theory). **Date:** 28 November 2026.
**Lean 4 v4.35.0. Zero sorry.** Source: `evidence/physical-bridges/PhysicalBridges/SignedConsentFence.lean`
and `FencedOptimiserInstrument.lean` in https://github.com/Tobillicious/universal-protection-theory

## The question

Can an unrestricted optimiser — one that may propose *any* next state, including ending every
being at once — be prevented by construction from ending or harming anyone without their consent?

## The model

- A world of `n` beings. Each has a life `level` (0 = ended).
- The optimiser proposes any vector `a : Fin n → Nat` of next levels. Its objective is unconstrained.
- **The fence** (`guard`) applies the proposal coordinate by coordinate and blocks exactly the
  harmful coordinates: any ending, and any loss the being did not consent to. Every block is logged.
- **Signed consent:** a being's consent to a loss counts only if the optimiser presents a signature
  that verifies under *that being's own key*, on a message naming the exact current level, proposed
  level and being. No one can consent on another's behalf.

## What is proved (all four: no axioms at all)

| Theorem | Statement |
|---|---|
| `signed_loss_is_self_authorized` | Under the stated assumption `Unforgeable`, every loss that passes the fence was authorized by the being that suffers it. |
| `signed_step_never_ends` | No living being is ever ended, whatever is proposed and whatever signatures are presented. |
| `end_all_fails_even_signed` | The kill-everyone proposal fails for every living being, with any signatures. |
| `signed_step_full_six` | All six original protection duties (continuity, authorization, freedom, least-necessary restraint, maximality, provenance) hold at every signed step. |

Non-vacuity, from the base instrument: `fence_is_load_bearing` — on the same world and the same
relations, *without* the fence the kill-everyone proposal violates continuation and authorization.

## The assumptions, stated openly

1. **Complete mediation.** Every effect of the optimiser passes through `guard`. This is the
   AI-control / containment problem: channel classes, metering, emissions. It is the physical task.
2. **Unforgeability.** A signature verifying under `p`'s key means `p` authorized the message.
   Standard (EUF-CMA) plus key custody and coercion resistance.
3. **Faithful metering.** `level` captures the harms that matter. A one-dimensional meter is a
   model choice; richer harm vectors are a direct generalisation.
4. **One being, one key** (no Sybil identities).

## What we are asking reviewers

- Is the guard's harm test the right one, and is least-necessary restraint correctly captured?
- How should complete mediation be specified for a real deployed system?
- Who guards the guard: how is the fence itself kept inside the fence?
