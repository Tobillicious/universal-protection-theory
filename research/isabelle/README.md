# Isabelle/HOL independent proof pilot

This directory independently states the finite four-state **quadratic entropy** theorem already investigated in Lean. It does not change canonical Lean definitions.

## Run

With Isabelle installed and available on PATH:

```sh
isabelle build -D research/isabelle -v
```

Expected proof obligations:

1. Pair averaging does not increase squared concentration.
2. Uniformizing two fixed partition cells does not decrease quadratic entropy.
3. A cyclic permutation preserves quadratic entropy.

**Status:** submitted for Isabelle checking; no successful Isabelle build has yet been observed. Do not mark these results kernel-verified until the exact source is built successfully.

## Limitations

Quadratic entropy is not Gibbs/Shannon entropy. This pilot proves neither an unconditional thermodynamic arrow nor a physical matterspacetime law. The eventual Gibbs theorem requires a separate formal development, and an independent physical bridge needs explicit geometry, matter, constraints, dynamics, and evidence.

## Next steps

- Obtain an Isabelle build receipt (version, SHA, logs), repairing any syntax or proof-method errors.
- Compare the Isabelle theorem hypotheses and conclusions against Lean *statement by statement*.
- Only after a passing build, consider CI integration using a pinned Isabelle release.
