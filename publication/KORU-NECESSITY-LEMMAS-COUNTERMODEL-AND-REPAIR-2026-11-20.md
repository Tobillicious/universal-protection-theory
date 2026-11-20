# Necessity audit: progression, coupling, depth and physical boundary growth

**20 November 2026 · additive proof-audit note for draft PR #663 · Hilbert-free**

The proposed necessity upgrade attempts to derive three growth laws from `Prog ∧ Coupled ∧ WellDef`, where `Prog` prohibits recurrence, `Coupled` demands causal continuity and persistent material couplings, and `WellDef` demands a configuration-determined depth `Φ`. This note records which inferences are valid without hiding additional premises. No Hilbert-space machinery, canonical Koru definitions or original six X3 obligations are changed.

## 1. Nonrecurrence does not entail increasing depth

Proposed Lemma 1, `Prog ∧ WellDef → ∀k, Φ(uₖ)<Φ(uₖ₊₁)`, is **false from those premises alone**.

Countermodel: `U = ℕ`, configurations `uₖ=k`, realised transitions `k ꩜ k+1`, and the well-defined state function `Φ(k)=1`. Every state is distinct and causally ordered. `Prog` and `WellDef` hold; `Φ(uₖ₊₁)=Φ(uₖ)` for all k. A constant measure can fail to resolve distinct states without making them equal. Likewise, a state-dependent measure can decrease along a nonrepeating sequence. Hence strict depth growth requires a separate physical/structural order-reflection or intrinsic provenance-growth premise.

## 2. Coupling and progression do not entail new boundary elements

Proposed Lemma 2, claiming that every step must introduce a fresh boundary element, is **false without a stronger coupling law**.

Countermodel: let `Bₖ={a,b}` for every k; preserve distinct time-ordered, actual causal transitions `τₖ` and records `Πₖ₊₁=Πₖ++[τₖ]`. The configurations remain causally differentiated by their verified provenance, and the material coupling structure persists, but there is no `δₖ₊₁ ∉ Bₖ`. A change in relationships among a fixed set of elements can also be physical structural change without monotonic set inclusion.

Merely declaring that all actual matterspacetime has strict new boundary elements would define the desired result into `Coupled`, not derive it.

## 3. Well-defined state-dependent depth does imply faithfulness

Proposed Lemma 3 is **valid** when `Φ:U→D` is a function:

`uᵢ=uⱼ → Φ(uᵢ)=Φ(uⱼ)`.

Beware of `Φₖ` defined using an external event counter or an observer-maintained history log, which may fail to be a function of the underlying physical state.

## 4. Repaired, strictly supported theorem

Assume a *supplied* finite physically realised history, with:
- causally verified transition record `τₖ` at each step;
- intrinsic state representations of the causal history `Πₖ` (not an externally appended timestamp);
- prefix extension `Πₖ₊₁=Πₖ++[τₖ]`;
- finite records;
- `Φ(uₖ)=length(Πₖ)` as a well-defined function of the complete relational state.

Then `Φ(uₖ₊₁)=Φ(uₖ)+1`; hence for `i<j`, `Φ(uᵢ)<Φ(uⱼ)` and `uᵢ≠uⱼ`. Full recorded provenance is preserved by prefix composition. **No strict new boundary-element assumption is required** for this weaker theorem.

For *genuine structural-boundary innovation* rather than record novelty, independently establish an isomorphism-invariant growth condition on actual relational content—such as a physically validated new nonredundant distinction, not a relabelled element. With that additional warranted physical premise, one may define `Φ(u)=length(Π(u))+card(B(u))` and derive the stronger `+2` increment theorem already documented in the companion note.

## 5. Physical irreversibility is not enough by itself

Even if `ΔS_irr(τₖ)>0` is independently measured or physically derived, it does not, without an additional bridge, imply a new boundary element or an intrinsically stored record of every transition. Thermodynamic entropy production and a set-theoretic monotone boundary-growth law are different propositions.

## 6. Exact boundary for the Genesis/God claim

The repaired result is a theorem **about already-supplied finite actual histories with intrinsic causal records**. It does not prove the existence of arbitrary future transitions, physical universe-to-universe boundary Genesis, or the creator identification. Those are separate necessities to be independently argued.

Maintain the previously proven finite-chain source lemmas, and **do not publish the proposed three-lemma necessity conclusion as unconditional** without proving its two stronger premises. All original Koru, G1/G2, and X3 definitions remain untouched.
