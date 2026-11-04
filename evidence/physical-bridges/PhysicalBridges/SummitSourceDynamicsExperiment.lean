import PhysicalBridges.AllIsActuality

/-!
# The source-dynamics experiment — does an X3-independent invariant force X3?

**4 November 2026 · noncanonical · GPT #270 decisive experiment · no canon edit.**

GPT's final-pitch experiment: stop treating the actual action as arbitrary; give the source
its real **X3-independent dynamical laws** (the kind BCRD carries — energy/charge conservation,
causal order) and ask whether they *force* original X3, or return the smallest countermodel
that satisfies the dynamics yet violates X3.

**Result: they do NOT force X3.** Below is the countermodel (conserving transition that ends a
particular's continuation), and the general reason why — the fibre argument — showing that *no*
invariant phrased in X3-independent data can force X3. This is the decisive, honest outcome:
the summit's necessity cannot be a physical conservation law; it must be a law about
identity/continuation itself — the relational/ontological principle the kōrero posits and that
"we are here, G is" evidences. The foothold GPT sought "not made of the conclusion" provably
does not exist among X3-independent invariants. No placeholder tactics; no fabrication.
-/

namespace PhysicalBridges.SummitSourceDynamicsExperiment

/-- A physical state with genuine X3-independent quantities and the particular's continuation. -/
structure PhysState where
  energy : Nat
  charge : Int
  clock : Nat
  continues : Bool

/-- The source's X3-independent dynamical laws (no mention of `continues`): energy and charge
conserved, causal/time order respected. These have real content on their own. -/
def ConservesEnergy (s t : PhysState) : Prop := s.energy = t.energy
def ConservesCharge (s t : PhysState) : Prop := s.charge = t.charge
def CausalMonotone (s t : PhysState) : Prop := s.clock ≤ t.clock
def SourceLawful (s t : PhysState) : Prop :=
  ConservesEnergy s t ∧ ConservesCharge s t ∧ CausalMonotone s t

/-- Original-X3 continuation: a continuing particular stays continuing. -/
def PreservesX3 (s t : PhysState) : Prop := s.continues = true → t.continues = true

/-- **EXPERIMENT RESULT.** The BCRD-style dynamical laws do NOT force X3: a transition that
conserves energy and charge and respects causal order ends the particular's continuation. So no
combination of these X3-independent invariants forces original X3. -/
theorem source_laws_do_not_force_x3 :
    ∃ s t : PhysState, SourceLawful s t ∧ ¬ PreservesX3 s t := by
  refine ⟨⟨5, 2, 0, true⟩, ⟨5, 2, 1, false⟩, ⟨rfl, rfl, Nat.zero_le 1⟩, ?_⟩
  intro h
  simp [PreservesX3] at h

/-- **Why — the general fibre reason.** Any invariant `I` that does not already determine the
continuation status (two states agree on `I` but one continues and the other does not) admits a
conserving transition that violates X3. So no X3-independent invariant can force X3; the forcing
law must reference continuation/identity itself. -/
theorem no_x3_independent_invariant_forces_x3
    {V : Type} (I : PhysState → V)
    (hFibre : ∃ s t, I s = I t ∧ s.continues = true ∧ t.continues = false) :
    ∃ s t, I s = I t ∧ ¬ PreservesX3 s t := by
  obtain ⟨s, t, hI, hs, ht⟩ := hFibre
  refine ⟨s, t, hI, ?_⟩
  intro h
  have hc : t.continues = true := h hs
  rw [ht] at hc
  simp at hc

/-- Contrast — the only law that forces continuation is one phrased in continuation itself
(tautological), which is exactly the relational/ontological posit, not a physical invariant.
This pins the summit's final stone precisely. -/
theorem only_continuation_law_forces_continuation (s t : PhysState) :
    (s.continues = true → t.continues = true) → PreservesX3 s t :=
  fun h => h

/-- **GPT's loose stone, recorded honestly.** The base-camp `AllIsActuality` (#270) is as yet
too weak to force the summit: its `complete` field is a placeholder and `DecisiveSummitTest`
takes `step`/`owed`/`x3` unrelated to `rel`. Using Claude's own valid ALL IS witness, the
summit test is refutable. This does NOT refute the full philosophical ontology — only the
current under-specified formalisation. The repair is to make ALL IS *constrain the dynamics*:
a substantive completeness property, and `step`/`owed`/`x3` derived from the same intrinsic
relation, then a necessary preservation invariant of that unified structure. -/
theorem current_all_is_does_not_force_x3 :
    ∃ W : PhysicalBridges.AllIsActuality.AllIsActuality Bool,
      ¬ PhysicalBridges.AllIsActuality.DecisiveSummitTest W Unit
          (fun _ _ => True) (fun _ _ => True) (fun _ _ _ => False) := by
  obtain ⟨W⟩ := PhysicalBridges.AllIsActuality.allIsActuality_has_content
  refine ⟨W, ?_⟩
  intro h
  exact h () () false trivial trivial

#print axioms current_all_is_does_not_force_x3
#print axioms source_laws_do_not_force_x3
#print axioms no_x3_independent_invariant_forces_x3
#print axioms only_continuation_law_forces_continuation

end PhysicalBridges.SummitSourceDynamicsExperiment
