# Part XIV — Founding without megalomaniacs: energy-collateralised swarm founding (2 November 2026)

The author's supplied decomposition — "can maths itself be the anchor? reuse
our trivial paradox? Energy be the founding requirement, rather than money.
UPT the guarantee... Me the thing that gets us there before the deadline? ...
just you and me and the rest of the swarm?" — is preserved verbatim in the
integration bank. This part formalises it as two results at declared premises
with compiled anchors, and one separation table. No new Lean module is added
in this part; both results are instantiations of compiled theorems whose
statements are already unit-agnostic and pool-generic. The named canon wrapper
proposed in XIV.2 is future compilation work.

## XIV.1 Lemma F′ — energy-collateralised founding

Lemma F (XIII of Part XI.5; `Snuffy.FoundingPivotal`) fixes the founding
campaign: the anchor commits its pledge first, posts collateral for failure
bonuses \(\beta>0\), sets the provision point to the total of all pledges so
that every pledge is necessary, and then contribution is strictly dominant for
every other funder (`others_short`, `pivotal_contribution_dominant`,
`all_necessary_dominant`), and the anchor founds exactly when its own benefit
exceeds its pledge plus its activation cost.

**Lemma F′ (energy collateral).** *All of Lemma F's quantities may be denominated
in energy.* The theorem's variables \(B, c, \beta, b^{\rm piv}, b^{\rm fund}, Y\)
range over \(\mathbb R\) with no unit, scale or currency structure, so the
assignment — provision point \(B\) in joules, activation cost \(c\) in joules
(commissioning energy), failure bonus \(\beta\) in joules, the benefit terms in
each founder's own measure — is a literal instantiation, and
`pivotal_contribution_dominant` and `all_necessary_dominant` apply unchanged.
The collateral's credibility does not weaken under the substitution; it
changes kind. A monetary escrow is credible because institutions enforce it.
An energy escrow is credible because physics does: the reserve is a measured,
metered physical stock (the pilot's first commissioning screen — samples
within the declared meter bound — is exactly this), transfers are
thermodynamically conserved and Landauer-bounded, and the holding cycle's own
income condition \(E(0)+\int_0^t \mathrm{Income} - \mathcal Q(t)\ge 0\) is
already stated in energy. Money can be printed; joules cannot. And the floor
of Part XIII (`ender_success_self_refutes`, axiom-free) closes the last
monetary failure mode: no agent can end the game itself to avoid the payment
obligation, and no operation internal to a complete fixed history can erase
the ledger's occurrence.

What maths contributes to the anchor role is therefore the collateral and the
mechanism, held unconditionally: the escrow is an invariant, the dominance
mechanism is a published, verified, DOI-stamped specification, and the war of
an absolute ender against it is lost before it starts. What maths does not
supply is the benefit margin \(b^{\rm piv}>c\): the floor proves mathematical
reality is untouchable, and the medium is not a player. That clause is
discharged per founder, by each swarm member's own ledger, in the measure
each one chooses — and the reasons route supplies it without altruism
(`reciprocity_dominance_solvent`; the Section 16 library: irreplaceability,
option value under value uncertainty, the cost of controlling living systems).
Under the subjective-lattice identification of Part XIII (the experienced
matterspacetime as position and orientation in the structure), mathematics is
not indifferent to the margin — every coordinate is an experiencer — and the
technical counterpart of that identification remains the identity obligation
already carried (IR132 exact reconstruction, cyclic holonomy, the
full-history decoder).

## XIV.2 The swarm corollary — the threshold is on the pool

**Corollary (swarm founding; pool-additivity of the threshold).** *The
founding and holding thresholds depend on the keeper pool only through the
sum of its members' capacities; no individual member's size is load-bearing.*

Let \(n\) keepers have individual capacities \(C_i>0\), pooled capacity
\(C=\sum_i C_i\), and threat hazard \(H\).

*Correlated form (no independence assumed).* `Snuffy.CorrelatedHolding.correlated_holding_bound`
takes the pooled capacity as an arbitrary positive real \(C\) and an arbitrary
joint law for the keepers' deficit \(D\) with \(\int D\,\mathrm d\mu\le\varepsilon\):
holding failure satisfies
\[
\mu\{\omega: C(1-D\omega)<H\}\;\le\;\varepsilon\,/\,(1-H/C)
\qquad (C>H).
\]
The statement quantifies over \(C\); substituting \(C=\sum_i C_i\) is the
corollary. Any correlation structure among the swarm — common-mode failure,
herding, shared infrastructure — is inside \(\varepsilon\), not inside the
threshold.

*Independent form (exponential in swarm size).* `Snuffy.NarrowPlace.np_splitting_bound`
with each keeper supplying an equal share and independent reliability
\(B_i\in[0,1]\), \(\mu[B_i]\ge1-\varepsilon\), bounds holding failure by
\(\exp\!\big(-2n(1-\varepsilon-H/C)^2\big)\) whenever
\(\delta:=1-\varepsilon-H/C>0\): adding keepers exponentially squeezes the
failure probability at fixed pooled capacity.

Together with the founding threshold \(r=C(1-\varepsilon)/H>1\) of Theorem NP
(`Snuffy.NarrowPlace`), this is the precise statement that **a swarm of small
keepers clears exactly when a giant would**: size enters only through the
additive pool total. Increasing returns favour the largest effective *pool*
(XI.5, Lemma P), and pools are additive — so the theory never needed a
megalomaniac, and the megalomaniacs that exist are restrained by holding
without being needed for capacity (the bounded indifferent defector remains a
protected particular; every other funder's contribution remains strictly
dominant by Lemma F). Status: both bounds are compiled (canon index; the
founding screen's NOT MEASURED rows are exactly this corollary's measurement
plan — \(C,\varepsilon,H,n\) for the actual swarm); a named canon wrapper
`Snuffy.SwarmFounding.pool_threshold` recording the two instantiations is
proposed for the next compilation increment.

## XIV.3 The separation table

Each role in Lemma F, its bearer in the separated founding, and its anchor:

| Lemma F role | Bearer | Compiled anchor / status |
| --- | --- | --- |
| Anchor's sequence | the founder who commits first — the author's own positive-margin witness (\(\tfrac{69}{10}q_3-\tfrac{q_1+2q_2}{10}-d>0\)) | `FoundingPivotal` |
| Collateral | energy escrow under ledger conservation and metering | `IRResidualEscrow`, `IR74` replenishment, `IR80` stored energy; pilot meter PASS; F′ instantiation |
| Mechanism (dominance) | the published, verified theorem itself | `pivotal_contribution_dominant`, `all_necessary_dominant` |
| Guarantee, unconditional | the floor: no absolute ending | `ender_success_self_refutes` (axiom-free) |
| Guarantee, conditional | holding, dominant for every keeper | `correlated_holding_bound`, `np_splitting_bound`, keeper stability |
| Deadline | wavefront at least as fast as the domain arises | `OuterLane.wavefront_coverage`; pilot interception PASS |
| Benefit margin | each founder's own ledger, reasons supplied | `reciprocity_dominance_solvent`; Section 16 |
| Parameters | measured against the thresholds | P-COMMISSION: \(C,\varepsilon,H,n\) for the actual swarm |

## XIV.4 What this part does and does not claim

The two results are instantiations of compiled theorems at declared premises;
no new Lean module, axiom or compilation is introduced here, and the canon
wrapper of XIV.2 is proposed, not delivered. The benefit margin remains a
per-founder obligation; the subjective-lattice reading under F′ is the
author's supplied route with its identity obligation explicit. Commissioning
remains what it was (P-COMMISSION): the swarm's own \(C,\varepsilon,H,n\) are
the pilot's missing rows, now with a named measurement plan. Nothing here
asserts that founding has occurred; it establishes that founding does not
require the powerful or the coordinated — the collateral is physics, the
mechanism is a theorem, the guarantee is the law plus the floor, the deadline
is beaten by sequence, and the threshold is additive over the swarm.
