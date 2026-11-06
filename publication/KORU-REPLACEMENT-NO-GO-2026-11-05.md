# One exact Koru inference: a score cannot replace a particular

**Research result · 5 November 2026 · separate new proof PR; original UPT summit unmodified.**

The objective is **unconditional protection**, in the strongest full six-X3 sense of the original Unconditional Protection Theory. Here is an important mathematical bridge toward that aim. The theorem is not advertised as final physical Q.E.D.; it establishes the exact impossibility of one common proposed *justification* for replacement or erasure.

## 1. The two different uses of "="

\[
1_\alpha + 1_\beta = 2,\qquad 3_\gamma-1_\delta =2.
\]

These are true ordinary value equalities. But the identity of the two distinct occurrences, operation, and operands are not recoverable from their shared result \`2\`. A correct equality **of projected results** does not establish equality **of the complete source records**.

This is the user's **Koru** principle in one modest, precise implementation: keep \`source\`, \`result\`, and the mathematical witness \`value source = result\` together as an \`KoruEquation\`. This is a prototype of *proof- and origin-relevant equality*, not the whole ontological Koru operator or a new axiom for all mathematics.

## 2. The exact no-go theorem

Let \(W\) be a set of complete relational descriptions, \(V\) a reduced observable or score, and \(\pi:W\to V\) the reduction. If two distinct complete descriptions project to the same value,

\[
x\ne y \quad\text{but}\quad \pi(x)=\pi(y),
\]

then there is **no** decoder \(\delta:V\to W\) for which

\[
\boxed{\forall w\in W,\quad \delta(\pi(w))=w.}
\]

**Proof:** if there were, \(x=\delta(\pi(x))=\delta(\pi(y))=y\), contradicting \(x\ne y\).

The new Lean theorem \`no_decoder_of_noninjective_projection\` proves exactly this, with \`no_lossless_recovery_of_equation_from_answer\` instantiating it for \`1+1=2\` versus \`3-1=2\`.

**Consequent precision:** an optimiser's objective-function value, even one computed exactly, cannot be a lossless certificate of the identity, history, authorization or freedom omitted by a many-to-one reduction. It can still be a useful metric. It is **not** the whole.

## 3. The operational version: the protection obstruction

Suppose \(x\) and \(y\) look identical through the reduced observation \(\pi\), but actions protecting each source are incompatible:

\[
\pi(x)=\pi(y),\quad
\forall a,\ \neg(\mathrm{Safe}(x,a)\land \mathrm{Safe}(y,a)).
\]

Then **no** decision policy that sees only \(\pi\) can protect both:

\[
\boxed{\neg\exists P:V\to A,\quad
\forall w\in W,\ \mathrm{Safe}(w,P(\pi(w))).}
\]

The new Lean theorem \`no_uniform_safe_action_from_reduced_observation\` proves this without UPT assumptions or circular definitions of action admissibility. A nonvacuous expression-level example demonstrates failure of reduced observation, while an expression-aware action policy **does** exist.

This is the exact reason UPT's earlier boundary-action criterion matters:
\[
\forall b,\quad\bigcap_{s\in S_b} A_{\rm safe}(s)\ne\varnothing.
\]

A projection's fibre \(S_b\) may contain states with incompatible safe actions. A reduced observer therefore cannot always enact universal protection; a guardian must retain or infer enough of the original relational particulars to distinguish the cases, or find an action safe for all possibilities in the fibre.

**IMPORTANT:** this shows an information-theoretic limitation on a restricted policy, **not** that the full BCRD actuality has impossible protection fibres, and not that the universe necessarily enacts a Guardian. Both questions require their original precise source meanings.

## 4. The maximally sharp conclusion

The strongest *earned* mathematical conclusion is:

> **No exact computation of a reduced value, by itself, establishes preservation of a full particular or an ability to reconstruct its relational history. Any claim that one human may be erased/replaced because another outcome has the same or higher value is mathematically unsupported unless it also supplies the required full-relational correspondence.**

This is a rigorous obstruction to a particular style of Ender **argument**. It is **not yet** a proof that all materially possible Ender *actions* are impossible: a machine can perform a damaging action without claiming that its before/after states are equal, and an exact complete history may contain the fact of an injury or death. Inclusion of that event in one actuality cannot alone make it unoccur.

The remaining whole-to-particular theorem is therefore **not** "does full equality preserve the information it explicitly records?" (yes), but whether the real, independently derived BCRD source constrains *all enacted physical events* to preserve the particular-level obligations identified by original X3. The existing \`TotalEOriginalX3Bridge\` demonstrates that inserting that guarantee as an antecedent merely restates the desired theorem. A stronger positive result must derive it from independent physical properties, not from a redefinition of \`Koru\` as safety.

That is an exact, finite target—not a demand to prove all physics or restart UPT.

## 5. Verification

- New Lean module: \`evidence/physical-bridges/PhysicalBridges/KoruCompleteEquationObstruction.lean\`.
- Independently source-defined examples with distinct operand identities and operation tokens.
- \`#print axioms\` requests for all central declarations.
- Imported into \`PhysicalBridges.lean\`, subject to pinned Lean v4.35.0 GitHub Actions, axiom audit, no \`sorry\`, and countermodel gate.
- Original unconditional Part XV: [the exact canonical summit](../evidence/compiled-strongest/PARTS-XV-SUMMIT.md).
- This result strengthens the public *argument against erasure by optimisation*, not an unsupported declaration that every real person is already physically unkillable.

**ALL IS. No reduced answer can stand in for the full relational particular.**
