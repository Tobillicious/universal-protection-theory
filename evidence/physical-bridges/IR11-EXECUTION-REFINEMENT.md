# IR-11 — Explicitly modeled effect-register refinement

The constructed instrument has a separate mutable physical-effect register.
Its only allowed operations are gated raise, mint and write events from the
original UPTFence source. An accepted write changes both the durable target
log and the physical effect register, by the selected impact function; a
rejected write changes neither.

Lean proves trace refinement, register/log coupling, and the no-modeled-effect
result for the original source-level certified hold. The source is imported,
not copied or modified in Git.

**Unproved physical obligations:** complete effect/channel inventory,
unauthorized bypass exclusion, identity semantics, independent environmental
dynamics, correct impact calibration, timing/cryptographic endowments and
deployment evidence. The counterexample demonstrates that the log cannot
prove anything about an independent bypass channel.

The finite-model checker exercises 12,440 short traces. Finite tests are
supplemental; the Lean theorem covers arbitrary finite event sequences.
