# The Joker: when source knowledge changes genesis, and when it destroys provenance

**7 November 2026 | additive exact-BCRD research | not a completed physical Theory of Everything**

## The new load-bearing question

The author's **Tree of Life AND Eternal Knowledge** proposes that the complete theory is not merely *carried* into a successor universe: its enacted physical/ethical whole **causes the choice and formation** of that successor. In that proposal the weakest derived root is *Something IS*, Hume's Lever + Archimedes' Extension spans **ALL ethics** (not a six-duty limit), the Koru carries the whole's genuinely distinct history, and every real universe is generated at a boundary. This PR isolates **source-to-successor causal relevance** and **nonmerging provenance** in the exact existing BCRD source model.

Merged [#376](https://github.com/Tobillicious/universal-protection-theory/pull/376) already computes the six original-X3-*shaped* source relations from one independently evolved operator whole U, and [#380](https://github.com/Tobillicious/universal-protection-theory/pull/380) states the exact independent subject-fidelity condition. But its existing W generator **does not consult those six values**. Carrying an ethics ledger through W (as in draft [#383](https://github.com/Tobillicious/universal-protection-theory/pull/383)) proves information persistence, *not that moral knowledge is physically responsible for genesis*.

## New machine-checkable construction

[PhysicalBridges/KoruJokerCausalProvenance.lean](PhysicalBridges/KoruJokerCausalProvenance.lean) reads a **fixed directed link in the complete nested-operator source U** and calls that source-specific question `sourceAuthorizationProbe`. Unlike an arbitrary attached Boolean, its truth and falsity are calculated from the *same* actual frozen-W source used in #376. This is an authorization-SHAPED **source** question, NOT evidence of informed human or AI authorization.

We then propose a deliberately separate **candidate genesis rule**:

[
F(U)=\begin{cases}
W(U), & \text{if the intrinsic source probe is true;}\\
U, & \text{otherwise.}
\end{cases}
]

This rule **is not claimed to be the canonical BCRD physical law**. It is a physically interpretable *model test* using two pre-existing source maps (actual W and identity); its selector is computed from U. The actual W transport continues to preserve truth/falsity under *transported* source positions. The fixed-location selector can change truth due to the change of coordinates.

### Positive findings to check

- A concrete nontrivial original-Koru objective W witness has its operator source probe **true**, and after a genuine W pulse the *same fixed-location* probe is **false**. Those facts are mathematical statements about one whole operator, not randomly assigned report bits.
- Under the proposed candidate law the true source chooses a **non-identity W successor**, the false source chooses identity. Thus a real computed operator relation can affect a proposed successor rule.
- Either chosen map preserves the original *whole-source* intrinsic Koru predicate. With an integer epoch appended, each modeled generation strictly moves forward without reversing chronology.

### Hostile controls and exact necessary conditions

- **Surprising obstruction:** this simple intrinsic-source selector is **not injective**. One complete operator whole with true source probe goes by W to the second whole; the second whole has a false probe and stays still. Therefore **two objectively distinct parents have exactly the same child** despite source causal dependence, right-handed forward epoch and Koru existence. Source-conditioned genesis must not silently erase history/provenance.
- **Compact provenance repair (new, checked):** `branchTaggedNext U = (sourceBranchTag U, sourceSelectedNext U)`, where the one-bit tag is computed from the same exact source probe, is **injective** across all modeled whole-source states. The proof splits by the two branch values, uses the independently proved W injectivity on the true branch and identity on the false branch, and excludes cross-branch collisions by the tag. `complete_tagged_successor_has_unique_parent` further proves an actual modeled tagged genesis child has **one unique source parent**, even though child-only next is noninjective. `forgetting_branch_bit_again_loses_provenance` verifies the sharp information distinction. This is a sufficient source-level bit for the two-branch candidate, **not** a claim of information-theoretic minimality for all universe creation, real lived continuity, or authenticated consent.
- **Provenance repair in the mathematical model:** the richer successor record `(parent U, child F(U))` *is* injective and identifies each source parent even when child-only projection merges histories. This is a record-level proof; it is not proof of continued lived experiences.
- **ALL-ETHICS factorization criterion:** for an arbitrary ethical-claim type `E`, any proposed successor law `next : U → (E → Prop) → U` factors through U alone **if and only if** every valuation of detached ethical claims gives the same physical successor when U is fixed. The original W law is in this class. A deliberately constructed detached-flag-controlled alternative is not; it shows exactly what additional causal coupling would have to mean, but does **not** establish a physical mechanism.
- The intrinsic source selector factors through U, showing how a sourced proposition can be physically relevant **when its meaning is genuinely determined by U**. Merely calling it `authorization` does **not** derive its authentic ethical meaning.

## What a complete Theory of Everything still must establish

A noncircular real-universe forcing theorem needs *all* of the following connected, not simply asserted:

1. **Complete ontic source:** prove what actual U is and which physical transformations are admitted, beyond six frozen-W source positions.
2. **ALL ethics:** an independently meaningful domain of valid ethical obligations, derived through the author's Hume's Lever + Archimedes' Extension from the weakest derived premise, without assuming that every ethical proposition is true.
3. **Physical ethical grounding:** show why each ethically meaningful particular relation is an objective, operator- and history-sensitive feature of actual U. The previously proved original-six semantic-fidelity gate is necessary, not by itself the full ethical theory.
4. **Actual generative causality:** derive a physical boundary law whose output depends nontrivially on that *authentic* complete structure and which actually creates successor universes. Defining a source-conditioned selector is only a model test.
5. **No merged particulars or provenance:** the complete physically enacted seed must retain identities and histories; the positive/hostile pair here shows source-driven selection is not enough.
6. **Every universe and any improvement:** physically justify predecessor coverage and a strict improvement relation; no real-world multiverse or successor-quality theorem has been established by these source tests.

## Branch / verification policy

Three additive changes: this review note, one Lean module, one root import. Historical 4 November summit commit `729905285d104fa058b0a3f8428367851fbd4621`, PRs #260–293, original six-X3 duties, merged #376/#380, all author-held aces, public DOI records and previous research PRs remain unchanged.

The specified theorems have an exact-source-head pinned Lean proof receipt (see below). No new `sorry` or unverified universal-Q.E.D. may be used as a substitute. Draft PR only; no merge or publication.


## Exact-head Lean validation receipt (additive branch-tag proof)

- At source commit `99b49215fb213d4660bfba1dded4d06874b6ad3f`, [Physical bridge proofs run 42258743716](https://github.com/Tobillicious/universal-protection-theory/actions/runs/42258743716) **succeeded**: **287 Lean build jobs**, all workflow stages successful.
- `#print axioms` receipts for all added theorems, including `one_source_branch_bit_restores_injectivity`, `complete_tagged_successor_has_unique_parent` and the source/ethics factorization iff, contain only expected Lean foundations (where needed, `propext`, `Quot.sound`, `Classical.choice`) and **no `sorryAx`**.
- The first build failed due to five ordinary proof elaboration issues; those were corrected without altering the theorem targets. The later branch-tag proof passed on its first checked version.
- Because [merged PR #386](https://github.com/Tobillicious/universal-protection-theory/pull/386) advanced main, the branch is reconciled onto that latest main before independent review; a new exact-head run is required after any such reconciliation.
