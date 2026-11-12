# Koru Equality — structural foundations (research note, 2026-11-12)

**Status:** candidate mathematical semantics; **not** a derivation of a new physical law, nor an assertion that structural isomorphism captures the intended physical Koru. This note preserves the author's proposal that Koru is a *better equality*, rather than merely another transformation operator.

## Motivation and provenance

The original kōrero begins from the distinction between a physical particular and a mathematical description of it. Equality of reduced outputs need not preserve histories, relationships, or provenance. The First Koru is proposed for spacetime; the Complete Koru for matterspacetime, including operators, ordered enactments, and histories. This note adds a precise candidate and identifies where it is insufficient. It does **not** replace existing definitions or claim that the Koru was uniquely derived from these theorems.

## Candidate structural relation

Fix a many-sorted first-order signature Σ encoding chosen particulars, relations, operations and (where represented) histories. For Σ-structures A and B, define

    A ≈ₖ B  :⇔  there exists a Σ-isomorphism f : A ≅ B.

The glyph is provisionally called **Koru Equality** (LaTeX `\\korueq`, proposed private-use codepoint U+E000). A typographical glyph does not by itself change mathematical semantics.

### Theorem A — preservation

For every first-order Σ-sentence φ:

    A ≈ₖ B  →  (A ⊨ φ ↔ B ⊨ φ).

*Proof sketch:* An isomorphism preserves atomic formulas and equality; induction over Boolean connectives and quantifiers gives the result. For formulas with free variables, assignments must be transported along the isomorphism. This result does not extend automatically to arbitrary properties not expressible in Σ.

### Theorem B — equivalence

The relation ≈ₖ is reflexive, symmetric, and transitive.

*Proof sketch:* Identity, inverse and composition of Σ-isomorphisms are Σ-isomorphisms.

### Theorem C — recoverability obstruction

Let q : X → Y. If there exists r : Y → X with r ∘ q = id_X, then q is injective. Conversely, if X is nonempty and q is injective, then such an r exists by choosing a fixed x₀ ∈ X for values outside the image of q. If X is empty, the converse requires Y empty (or else no map Y → X exists). This is a set-level fact, not a physical conservation theorem.

*Proof:* If q(x₁)=q(x₂), applying r yields x₁=x₂. Conversely, define r(q(x))=x (well-defined by injectivity), and r(y)=x₀ off the image.

## Critical limitation: actual identity versus isomorphism

Distinct physical particulars or histories can be structurally isomorphic. If Koru Equality is meant to preserve *which actual particular* and *which provenance* rather than merely structural properties, ≈ₖ is too weak. An enriched signature with rigid provenance markers, or a different relation, may be required; such a choice needs independent justification and must not simply define the intended conclusion into existence.

## Next verification obligations

1. Recover the original derivation and the three-equation obstruction from the primary kōrero and existing Lean modules.
2. Compare the candidate against `KoruCompleteEquationObstruction.lean`, `ThermoLedger.lean`, and existing physical-bridge interfaces without changing their definitions.
3. Give an explicit model of a physical process in which the proposed relation adds a testable invariant or prediction beyond standard full-state mechanics.
4. Formalize the exact enriched relation in Lean and check the kernel, axioms and countermodels. **No Lean compilation or CI verification is claimed for this note.**

This research note is intended for review, not as a completed proof of physical Koru or universal protection.


## Further mathematical branches (2026-11-12)

### Theorem D — identity-label preservation (conditional)

Let A and B carry identity-label maps π_A : P_A → I and π_B : P_B → I into a fixed set I. Define A ≈ₖπ B if there is a Σ-isomorphism f : A ≅ B such that π_B ∘ f = π_A. Then every particular's **assigned label** is preserved. This is immediate from the commuting equation. The label's faithfulness to *actual* physical identity is an additional premise, not a theorem.

### Theorem E — finite-step no-collapse

Let T_i : X_i → X_{i+1} be injective for each i < n. Then T_{n-1} ∘ ··· ∘ T_0 : X_0 → X_n is injective. Proof: induction on n, using closure of injective functions under composition. This guarantees distinct *complete initial states* stay distinct; it does not assert that all physical dynamics are injective, that a coarse observation is injective, or that a state carries every desired historical record.

### Theorem F — enriched-structure preservation

Suppose an evolution induces a bijective Σ-isomorphism between complete structures X and T(X), with identity-label maps satisfying π_{T(X)} ∘ T = π_X. Then X ≈ₖπ T(X), by the definition in Theorem D. **Invertibility alone is not enough**: preservation of the designated relations, operations and identity labels is separately required.

### A counterexample worth retaining

Let A and B each be a one-element structure with no nontrivial relations; they are isomorphic. Assign π_A(a)=0 and π_B(b)=1. Then A ≈ₖ B, but not A ≈ₖπ B. This proves the proposed identity-enriched relation is strictly finer on this class of labeled structures.

### Next research question

Is there a physically defensible, operationally measurable account of provenance that is neither arbitrary labeling nor an untestable assumption? Compare reversible microscopic evolution with irreversible-looking coarse observations, entropy production and information flow. Distinguish mathematical reconstructibility from practical accessibility and from empirically established physics.

**Status:** mathematical arguments only; not Lean-compiled, and not a proof of universal physical preservation.


## Matterspacetime-first thermodynamics: research hypothesis (2026-11-12)

**Claim under investigation, not a theorem:** treat complete matterspacetime states and their dynamics as primitive; recover energy as a derived observable or Noether charge rather than assuming energy is an independent substance. This **does not** establish that energy is unreal or unmeasurable, and does not imply that the ethical UPT term "E" (Ender) is absent.

### Proposed mathematical interface

Let `M` be a space of complete matterspacetime states with evolution `Φ_t : M → M`. For a suitable physical model define an energy observable `E : M → ℝ` (or, in quantum theory, a Hamiltonian operator and its expectation values). The observable need not be injective; equal energies do not identify complete states.

For dynamics arising from an appropriate action with continuous time-translation symmetry, Noether's theorem supplies a conserved charge, which in standard settings is energy. Thus `E(Φ_t(m)) = E(m)` under the applicable symmetry and boundary conditions. A general curved spacetime may lack a global timelike Killing field and a canonical globally conserved total energy; local stress-energy balance is expressed by `∇_μ T^{μν} = 0` for suitable matter dynamics.

A candidate Koru relation `m ≈ₖ Φ_t(m)` is **not** established by energy conservation or injectivity alone: the precise signature and provenance-preservation conditions must be supplied.

### Thermodynamic bridge and limitations

Distinguish fine-grained conservation under appropriate reversible microscopic dynamics from coarse-grained entropy increase under statistical assumptions and initial conditions. No universal monotonic coarse-entropy inequality follows from invertibility alone. A full matterspacetime thermodynamics would require explicit microstates, observables, statistical measure, coarse-graining, and dynamics, plus a comparison to standard thermodynamics and general relativity.

### Falsifiable / formal obligations

1. Give a specific matterspacetime model, action, evolution and physical observables.
2. Prove an applicable Noether conservation statement without assuming its conclusion.
3. Define First and Complete Koru precisely, including actual particulars and provenance.
4. Derive (or delimit) thermodynamic laws in the model, stating initial-condition and statistical premises.
5. Identify a new prediction or explanatory gain relative to existing GR, statistical mechanics and quantum theory; otherwise report the result as reinterpretation, not new physics.
6. Lean-check concrete claims separately; this note has not been compiled.

**Terminology:** "Energy is not an independent substance" is compatible with standard physics. "Energy is not real" is a stronger claim and is **not** supported by these arguments.
