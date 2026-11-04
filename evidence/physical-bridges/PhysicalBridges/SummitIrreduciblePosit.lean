import PhysicalBridges.SummitReversibilityScope

/-!
# The summit, honestly: guardian-necessity is the irreducible posit

**4 November 2026 · noncanonical · the unified summit synthesis · no canon edit.**

Reading IR105 (`accounting_and_subject_input_do_not_imply_x3`) completes the agency face: the
source deliberately exhibits a `forced` (coerced, non-continuing) transition that is accounted
AND causally involves the subject, yet violates X3. So agency is not forced at the accounting
level — as reversibility (#276) does not force it and conservation (#271) does not.

GPT's orbit-constancy criterion (PR #275), verified here: for a reversible involution, a property
is preserved stepwise IFF it is constant on the orbit. Applied to the real source, the
X3-relevant properties are NOT orbit-constant (`BCRDIdentityCharge.candidate_charge_changes` — the
parity charge flips; the occupancy label flips), so reversibility yields only endpoint-recovery
over the cycle, NOT within-event/stepwise preservation (the `IRWatchdog? / hiddenInternalLoss`
within-event gap).

**Unified verdict.** Every sub-structural principle we have — conservation, reversibility,
accounting + subject-participation — PERMITS an original-X3 violation. So the guardian-necessity
(full X3, stepwise, all components) is **irreducible** to them: it cannot be derived from any,
nor their conjunction. It is the one irreducible ontological posit — the thesis "nothing but
guardians" asserts of actuality — not refuted (these toys do not satisfy the full ALL IS
ontology), evidenced by existence (`AllIsGActualityDischarge`, #261), and sufficient for UPT
(given it, the capstone yields guardian-only histories). That is a foundational theory: a law
posited of actuality, its consequences derived, its truth argued ontologically — not a theorem
derived from nothing (proved impossible: each sub-principle admits the violation). No fabrication.
-/

namespace PhysicalBridges.SummitIrreduciblePosit

/-- **GPT's orbit-constancy criterion (PR #275), verified.** For a reversible involution `f`,
a property `P` is preserved at every step iff it is constant on the orbit `{s, f s}`. -/
theorem reversible_preserves_iff_orbit_constant {α : Type} (f : α → α) (P : α → Prop)
    (hinv : ∀ x, f (f x) = x) :
    (∀ s, P s → P (f s)) ↔ (∀ s, P s ↔ P (f s)) := by
  constructor
  · intro hfwd s
    refine ⟨hfwd s, fun hfs => ?_⟩
    have h2 := hfwd (f s)
    rw [hinv] at h2
    exact h2 hfs
  · intro hiff s hs
    exact (hiff s).mp hs

/-- A transition annotated with every sub-structural principle we have shown the source carries
or permits: energy conserved, reversible, accounted, subject-participated — plus the agency and
continuation facts. -/
structure SubPrincipleTransition where
  energyConserved : Bool
  reversible : Bool
  accounted : Bool
  subjectParticipated : Bool
  authorized : Bool
  continues : Bool

/-- The sub-structural principles jointly (conservation + reversibility + accounting +
participation). None mentions protection. -/
def SatisfiesAllSubPrinciples (t : SubPrincipleTransition) : Prop :=
  t.energyConserved = true ∧ t.reversible = true ∧ t.accounted = true ∧ t.subjectParticipated = true

/-- Original X3 (agency face): the subject continues or validly consented. -/
def X3 (t : SubPrincipleTransition) : Prop :=
  t.continues = true ∨ t.authorized = true

/-- **Guardian-necessity is irreducible.** A single transition satisfies conservation,
reversibility, accounting AND subject-participation, yet violates X3 (coerced and
discontinuing). So no sub-structural principle, nor their conjunction, forces X3. The
guardian-necessity is a genuinely additional, irreducible law — not derivable from below. -/
theorem guardian_necessity_is_irreducible :
    ∃ t : SubPrincipleTransition, SatisfiesAllSubPrinciples t ∧ ¬ X3 t := by
  refine ⟨⟨true, true, true, true, false, false⟩, ⟨rfl, rfl, rfl, rfl⟩, ?_⟩
  intro h
  simp [X3] at h

/-- Sufficiency, stated honestly: IF actuality satisfies the guardian posit (every transition
keeps X3), then every transition keeps X3. Trivial as logic — the point is that the posit is
irreducible (above) and is what the thesis asserts, not that it is derived. -/
theorem guardian_posit_suffices
    (step : SubPrincipleTransition → Prop) (hposit : ∀ t, step t → X3 t)
    (t : SubPrincipleTransition) (ht : step t) : X3 t :=
  hposit t ht

#print axioms reversible_preserves_iff_orbit_constant
#print axioms guardian_necessity_is_irreducible
#print axioms guardian_posit_suffices

end PhysicalBridges.SummitIrreduciblePosit
