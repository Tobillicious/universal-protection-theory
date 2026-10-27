# Physical-interface proof bridges (independent research candidate)

**Status:** Pull-request candidates; not an adopted Snuffy edition or a deployed instrument.

These files introduce *standalone* Lean 4.35 modules for the IR-1R through IR-4 physical-bridge programme. The formal statements are conditional. They neither alter the existing Snuffy proofs nor silently discharge their physical, cryptographic, timing, endowment, semantics, or coverage premises.

## Running the isolated checker

```sh
cd evidence/physical-bridges
lake build
python3 checks.py
```

GitHub Actions runs both checks. The Lean files print axiom dependencies for named theorems, and CI rejects proof placeholders.

## IR-1R: post-effect guards

`post_effect_guard_sound` bounds **the true state after an admitted effect**, not merely the pre-effect sample. The conditional premises are: (i) observation error is within the claimed envelope, (ii) every consequential transition fits the specified drift-plus-jump bound, and (iii) the gate checks that entire envelope.

`omitted_jump_counterexample` demonstrates that a pre-effect-only test need not be safe.

**Source-level seam:** existing `evidence/papers-11-12/lean/modules/ControllerFence.lean` proves conditional no-write-on-hold; it does not prove the physical bound on the effect of an *authorized* write. IR-1R is independent until a verified refinement connects it with controller-issued receipts and an exhaustive physical channel inventory.

Follow-on modules cover aggregate interference (IR-2), observation-robust permissions (IR-3), and robust finite-horizon viability (IR-4). Their proofs remain conditional on their named models. None establishes historical/subjective continuity, an actual plant's conformance, or guaranteed adoption by every agent.
