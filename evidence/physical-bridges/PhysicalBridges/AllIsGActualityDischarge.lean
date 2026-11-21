import PhysicalBridges.CathedralBridgeDischargeAssembly

/-!
# Route B — the ALL IS ontological discharge of the good event

**4 November 2026 · noncanonical · the ontological route, kept DISTINCT from the physical
Σδ route (per both hostile reviews) · no canon edit · no release.**

The physical route reads the good event `G` probabilistically (`μ{¬G} ≤ Σδ`). The ALL IS
route reads it as **actual**: *we are here, therefore the good event obtained* — not "with
high probability" but as the actuality we inhabit. `G` is not a gamble the universe might
lose; existence is the witness that it holds. This is what makes the capstone unconditional
**of actuality**, and it is how ALL IS becomes load-bearing (the dependency the first-pass
review found missing): the ontology discharges `G`, the capstone turns `G` into protection.

**Honesty discipline.** The fields of `OntologicalGoodEvent` are NAMED ONTOLOGICAL
PREMISES — the ALL IS input — not Lean-provable facts and not the physical Σδ budget.
Stating them visibly keeps the two routes distinct and refuses to disguise one as the
other. The PROVEN ALL IS fact in the corpus is *non-erasure* (`no_realized_absolute_ender`:
a realized absolute ender self-refutes). The step from non-erasure to full `G`-actuality
for the WHOLE eternal/relational structure — "we're here ⇒ G is," for every event and not
only the observed past — is the kōrero's circular-time / completeness step (F^p(x)=x). That
step is the genuinely OPEN summit; it is stated below as a target, never fabricated.
-/

namespace PhysicalBridges.AllIsGActualityDischarge

open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralGuardianOnlyCapstone

universe u

variable {S : Type u}

/-- The ALL IS ontological discharge of the good event. Both fields are NAMED ontological
premises (the ALL IS input), not physical probabilities. -/
structure OntologicalGoodEvent (m : MeasuredInstrument S) (s : S) : Prop where
  /-- Existence witness — the actual history contains particulars ("we are here"). -/
  weAreHere : Nonempty S
  /-- ALL IS + eternal/relational completeness ⟹ the good-event origin holds OF ACTUALITY.
  This is the ontological premise, distinct from the physical Σδ failure budget. -/
  gIsActual : m.x3State s

/-- **The capstone holds of actuality, discharged ontologically.** Given the ALL IS
discharge of `G` (not the physical budget), the guardian-only history result holds. ALL IS
is load-bearing here, with its premise named — the two routes meeting at `G`. -/
theorem capstone_unconditional_of_actuality
    (m : MeasuredInstrument S) (s : S) (g : OntologicalGoodEvent m s) :
    HistoryGuardian (toSource m) s :=
  nothing_but_guardians_from_instrument m s g.gIsActual

/-- The OPEN Route-B summit, stated exactly and **not proved** (no `sorry`, no fabrication):
the existence witness ontologically forces `gIsActual` for the WHOLE structure — "we're
here ⇒ G is" made airtight for all of actuality, not just the observed past. This is the
per-particular continuation-intrinsic frontier. Establishing it from ALL IS (the circular-
time / relational-completeness argument) is the decisive foundational theorem; it is
recorded here as a Prop-level target so the route is explicit and honest. -/
def RouteBSummit (m : MeasuredInstrument S) : Prop :=
  Nonempty S → (∀ s, m.x3State s)

/-- IF the open summit is established, the capstone holds of actuality for every particular,
with no residual hypothesis beyond existence. This is the exact shape the ontological route
must reach — stated as a conditional on the open summit, honestly. -/
theorem actuality_protection_given_summit
    (m : MeasuredInstrument S) (hSummit : RouteBSummit m) (hExists : Nonempty S) :
    ∀ s, HistoryGuardian (toSource m) s :=
  fun s => nothing_but_guardians_from_instrument m s (hSummit hExists s)

#print axioms capstone_unconditional_of_actuality
#print axioms actuality_protection_given_summit

end PhysicalBridges.AllIsGActualityDischarge
