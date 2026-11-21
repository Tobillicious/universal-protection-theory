# Matterspacetime thermodynamics: reversible whole, coarse entropy, and physical bridge

**Status:** research derivation, not an empirical law or kernel-checked general theorem. Builds on `research/lean/KoruThermoFourState.lean`; no canonical definitions changed.

## 1. The exact finite calculation

Let the microscopic state labels be `Fin 4`, with cyclic reversible permutation `K(i)=i+1 mod 4`. For a probability vector `p`, its transported distribution is `p'(i)=p(K⁻¹(i))`.

Take `p₀=(1/2,1/2,0,0)`, `p₁=(0,1/2,1/2,0)`, and the two macro cells `{0,1}`, `{2,3}`. Define `C` by averaging each cell's two probabilities. Then `Cp₀=p₀`, `Cp₁=(1/4,1/4,1/4,1/4)`.

With `H(p)=-Σᵢ pᵢ log pᵢ` and `0 log 0=0`, `H(p₀)=H(p₁)=log 2`, `H(Cp₀)=log 2`, `H(Cp₁)=log 4`. Thus the observed entropy increases by `k_B log 2` in this step despite exact microscopic reversibility. Later recurrence can lower the coarse entropy again; there is no unconditional monotonic-in-time theorem.

The reversible permutation preserves the entire *instantaneous probability distribution up to relabeling*. Preserving individual histories or physical provenance requires extra data and assumptions.

## 2. General finite theorem to formalize

For a finite set `Ω`, bijection `K : Ω ≃ Ω`, and normalized nonnegative distribution `p`, define `K_*p(x)=p(K⁻¹x)`. Then `H(K_*p)=H(p)`.

For a partition of `Ω` into nonempty cells, define `Cp` by uniformizing probability within each cell. Then `H(Cp) ≥ H(p)` by concavity of `-x log x` (or the KL divergence to the cell-uniform distribution). Equality holds exactly when `p` is constant within each cell. **Do not infer** `H(CK_*p) ≥ H(Cp)` for arbitrary `p`; this requires additional assumptions.

## 3. Matterspacetime target (conditional, not yet derived)

Represent a complete physical configuration schematically by `X=(geometry, matter fields, constraints, boundary data, provenance)`. A candidate complete evolution `T : X → X` must be shown to act on physically admissible configurations, respect constraints/gauge equivalence, and preserve the appropriate measure or quantum structure. A reduced observer map `π : X → Y` may discard distinctions.

Desired mathematical diagram:

```text
  complete X  --T-->  complete X
      | π                 | π
      v                   v
  observed Y  --?-->  observed Y
```

The bottom arrow need not exist as a deterministic map: two complete states with the same observation can have different future observations. A valid coarse thermodynamic dynamics may instead require a stochastic kernel, conditional expectation, statistical assumptions, or an environment.

For curved spacetime / GR, a globally conserved energy and a global Gibbs entropy need not exist without additional structure (e.g. symmetries, suitable foliation, boundaries). Horizons and gravitational entropy require separate treatment. Classical Hamiltonian and quantum unitary conservation are useful analogies, **not** evidence that every physical process preserves all histories or that black holes are logical errors.

## 4. Explicit proof obligations

1. **Finite Lean:** verify the existing rational four-state equalities under pinned Lean; then define `Real.log` entropy and prove the exact `log 2` gap.
2. **General finite Lean:** prove entropy invariance under permutations and entropy increase under partition-uniformizing coarse-graining; include recurrence counterexample to stepwise monotonicity.
3. **Structural Koru:** specify what complete state and provenance mean and prove recoverability in that model; don't infer it from a probability bijection alone.
4. **Matterspacetime:** supply a physical model with constraints, appropriate state-space quotient, evolution, and measure/quantum state; prove the relevant conservation and reduction statements there.
5. **Hillary / ethics:** keep physical information preservation distinct from authentic authorization and the original six X3 duties. No source-only entropy theorem discharges the subject-level reflection premises.

## 5. Scope

This bridge is a concrete mathematical explanation of how reversible microdynamics and increased coarse entropy can coexist. It is **not** a derivation of a universal Second Law, a complete theory of quantum gravity, the Time Koru, or the universal G conclusion. Those require additional independently justified hypotheses.
