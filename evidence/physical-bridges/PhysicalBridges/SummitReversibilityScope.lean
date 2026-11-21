import PhysicalBridges.SummitBCRDReversibility

/-!
# Does reversibility extend to full experiential X3? — the honest scope

**4 November 2026 · noncanonical · the precise reach of reversibility · no canon edit.**

Answer: **partly.** Reversibility (the frozen source generator is a self-inverse involution,
#274) reaches the IDENTITY components of original X3 but NOT the AGENCY components.

* **Reaches (identity):** persistence / non-erasure (#274) and non-merger (GPT's #273
  `relation_covariance_precludes_identity_merger`, audited sound). The particular persists,
  stays distinct, is not erased or merged. This is `ContinuationSubject.LaterStage` — own-history
  identity.
* **Does NOT reach (agency):** authorization, freedom (`FreeStage`: director = self), restraint.
  Reversibility is a property of information flow; it is silent on *who directs* a transition. A
  **reversibly-shuffled puppet** has its identity perfectly preserved and its agency entirely
  external. So reversibility ⇏ freedom.

Consequence: the summit's remaining pitch is the **agency / direction** components — a separate
principle about who settles a transition (`ContinuationSubject.FreeStage` / `IR105` authorization),
which reversibility does not supply. The identity half of X3 is now sourced from the real frozen
generator; the agency half is the honestly-named open top. Nothing fabricated.
-/

namespace PhysicalBridges.SummitReversibilityScope

/-- A toy step carrying who the subject is and who directed it (the `ContinuationSubject` roles). -/
structure Step (A : Type) where
  director : A

/-- Freedom (agency): the transition is directed by the subject itself. -/
def Free {A : Type} (self : A) (s : Step A) : Prop := s.director = self

/-- **Reversibility does not force freedom/agency.** A nontrivial reversible involution dynamics
(`f = not`, with `f ∘ f = id`, `f ≠ id`) coexists with an externally-directed, UNFREE transition
(`director ≠ self`). Reversibility constrains the information flow `f`; it is logically silent on
the director. So identity-preservation (reversibility) does not entail agency (freedom). -/
theorem reversibility_does_not_force_freedom :
    ∃ (f : Bool → Bool) (s : Step Bool) (self : Bool),
      (∀ x, f (f x) = x) ∧ f ≠ id ∧ ¬ Free self s := by
  refine ⟨fun x => !x, ⟨false⟩, true, ?_, ?_, ?_⟩
  · intro x; cases x <;> rfl
  · intro h; have := congrFun h true; simp at this
  · intro h; simp [Free] at h

/-- The positive half, recorded: reversibility DOES give the identity component (no state erased),
re-exporting the source result. The two halves together: identity ✓ from reversibility, agency ✗. -/
theorem reversibility_gives_identity_persistence (i j : FrozenBCRDEvents.Index) :
    ∃ rho : FrozenBCRDEvents.Matrix6, FrozenBCRDEvents.evolve rho = FrozenBCRDEvents.matrixUnit i j :=
  SummitBCRDReversibility.source_erases_no_basis_state i j

#print axioms reversibility_does_not_force_freedom
#print axioms reversibility_gives_identity_persistence

end PhysicalBridges.SummitReversibilityScope
