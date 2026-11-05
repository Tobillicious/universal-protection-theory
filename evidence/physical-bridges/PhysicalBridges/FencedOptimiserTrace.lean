import PhysicalBridges.FencedOptimiserInstrument

/-!
# Fenced optimiser: necessary intervention and arbitrary-history persistence

5 November 2026. Research extension; no change to the six X3 duties or canon.

The first fenced instrument proves sufficiency: its guard enforces six meaningful
per-particular correspondences on every admitted transition. This file proves
two stronger properties of that SAME independently interpreted instrument.

* Necessity / optimality: any outcome satisfying continuation and authorization
  must differ from a harmful proposal at that particular. Conversely the
  constructed guard changes a coordinate iff that proposal is harmful. Its
  intervention footprint is therefore pointwise minimal among safe outcomes.
* Arbitrary histories: for any finite chain of admitted transitions (including
  adaptive, adversarial proposals), a living particular remains living, its
  consent flag cannot be changed, and if it began without consent its level
  never decreases, even by accumulated small changes.

This is a formal property of a completely mediated, finite-coordinate model,
not a proof that physical AI installations cover all outgoing channels.
Recorded Boolean consent is not an independent subject-authorization oracle.
-/

namespace PhysicalBridges.FencedOptimiserTrace

open PhysicalBridges.FencedOptimiserInstrument

variable {n : Nat}

/-- Any outcome honoring continuation and authorization must CHANGE the value
of a harmful proposed coordinate. The proposed ending or nonconsensual loss
cannot itself be the safe outcome. This does not assume the proposed outcome
is already guarded. -/
theorem harmful_proposal_requires_intervention
    (s t : World n) (a : Fin n → Nat) (p : Fin n)
    (hHarm : Harmful s a p)
    (hContinue : (relations n).continues s t p)
    (hAuthorize : (relations n).authorized s t p) :
    t.level p ≠ a p := by
  intro hPass
  obtain ⟨hLower, hBad⟩ := hHarm
  cases hBad with
  | inl hNoConsent =>
      have hDrop : t.level p < s.level p := by
        rw [hPass]
        exact hLower
      have hAllowed := hAuthorize hDrop
      rw [hNoConsent] at hAllowed
      cases hAllowed
  | inr hEnded =>
      have hAlive : 0 < s.level p := by
        simpa [hEnded] using hLower
      have hAfter := hContinue hAlive
      have hZero : t.level p = 0 := hPass.trans hEnded
      rw [hZero] at hAfter
      exact Nat.lt_irrefl 0 hAfter

/-- A coordinate is changed by the guard EXACTLY when the proposed action
violates the independently defined harm test. This is stronger than a mere
bound on the total number of interventions. -/
theorem guard_changes_iff_harmful (s : World n) (a : Fin n → Nat)
    (p : Fin n) :
    (guard s a).level p ≠ a p ↔ Harmful s a p := by
  constructor
  · intro hChange
    by_contra hSafe
    have hPass : (guard s a).level p = a p := by
      simp [guard, hSafe]
    exact hChange hPass
  · intro hBad
    exact harmful_proposal_requires_intervention s (guard s a) a p
      hBad (guard_continues s a p) (guard_authorized s a p)

/-- The guard has the MINIMAL intervention footprint: every other outcome
satisfying continuation and authorization must intervene on every coordinate
where this guard intervenes. No optimality claim about unmodeled effects is made. -/
theorem guard_pointwise_minimal
    (s t : World n) (a : Fin n → Nat)
    (hContinue : ∀ p, (relations n).continues s t p)
    (hAuthorize : ∀ p, (relations n).authorized s t p) :
    ∀ p, (guard s a).level p ≠ a p → t.level p ≠ a p := by
  intro p hChanged
  exact harmful_proposal_requires_intervention s t a p
    ((guard_changes_iff_harmful s a p).mp hChanged)
    (hContinue p) (hAuthorize p)

/-- Consent is invariant on ANY admitted single step, regardless of proposal. -/
theorem step_preserves_consent {s t : World n}
    (hStep : (instrument n).step s t) :
    ∀ p, t.consent p = s.consent p := by
  obtain ⟨a, rfl⟩ := hStep
  intro p
  rfl

/-- An unconsenting particular cannot lose level even at one tiny step. -/
theorem step_no_unconsented_decrease {s t : World n}
    (hStep : (instrument n).step s t) (p : Fin n)
    (hNoConsent : s.consent p = false) :
    s.level p ≤ t.level p := by
  obtain ⟨a, rfl⟩ := hStep
  by_contra hNot
  have hDrop : (guard s a).level p < s.level p :=
    Nat.lt_of_not_ge hNot
  have hAllowed : s.consent p = true := guard_authorized s a p hDrop
  rw [hNoConsent] at hAllowed
  cases hAllowed

/-- Full consent invariance through an arbitrarily long chain of actual
guarded transitions, including hostile and adaptive proposal sequences. -/
theorem history_preserves_consent {s t : World n}
    (hHistory : IR96.Reach (instrument n).step s t) :
    ∀ p, t.consent p = s.consent p := by
  induction hHistory with
  | refl =>
      intro p
      rfl
  | tail earlier edge ih =>
      intro p
      obtain ⟨a, rfl⟩ := edge
      simpa [guard] using ih p

/-- No accumulation of small unconsented losses can evade the guard.
The baseline consent is preserved, so all later steps remain unauthorized. -/
theorem history_no_unconsented_decrease {s t : World n}
    (hHistory : IR96.Reach (instrument n).step s t) :
    ∀ p, s.consent p = false → s.level p ≤ t.level p := by
  induction hHistory with
  | refl =>
      intro p _
      exact Nat.le_refl _
  | tail earlier edge ih =>
      intro p hNoConsent
      have hPreviousConsent :=
        (history_preserves_consent earlier p).trans hNoConsent
      exact Nat.le_trans (ih p hNoConsent)
        (step_no_unconsented_decrease edge p hPreviousConsent)

/-- Non-erasure is also preserved through any finite admitted history,
including when a particular had consented to a positive decrease. -/
theorem history_preserves_life {s t : World n}
    (hHistory : IR96.Reach (instrument n).step s t) :
    ∀ p, 0 < s.level p → 0 < t.level p := by
  induction hHistory with
  | refl =>
      intro p hAlive
      exact hAlive
  | tail earlier edge ih =>
      intro p hAlive
      obtain ⟨a, rfl⟩ := edge
      exact guard_continues _ a p (ih p hAlive)

/-- All three historical invariants assembled as a single operational
certificate for EVERY reachable successor, not a selected harmless trace. -/
theorem arbitrary_history_certificate (s : World n) :
    ∀ t, IR96.Reach (instrument n).step s t →
      (∀ p, 0 < s.level p → 0 < t.level p) ∧
      (∀ p, t.consent p = s.consent p) ∧
      (∀ p, s.consent p = false → s.level p ≤ t.level p) := by
  intro t hHistory
  exact ⟨history_preserves_life hHistory,
    history_preserves_consent hHistory,
    history_no_unconsented_decrease hHistory⟩

#print axioms harmful_proposal_requires_intervention
#print axioms guard_changes_iff_harmful
#print axioms guard_pointwise_minimal
#print axioms step_preserves_consent
#print axioms step_no_unconsented_decrease
#print axioms history_preserves_consent
#print axioms history_no_unconsented_decrease
#print axioms history_preserves_life
#print axioms arbitrary_history_certificate

end PhysicalBridges.FencedOptimiserTrace
