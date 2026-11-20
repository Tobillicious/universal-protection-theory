import PhysicalBridges.G3PreQGComplete

/-!
# Backwards summit: from the universal protection target to its gates

Find-before-build: reuses G3PreQGComplete.if_bcrd_then_all_six_and_no_E,
FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E,
and the unchanged OriginalX3 predicate.

New result A: the explicit nontermination premise in BCRDIsQG gives an
actual Nat-indexed *mathematical* sequence of physicalStep transitions,
and the existing conditional assembly supplies all six and no AbsoluteE
at each transition. Classical choice extracts successor witnesses.

New result B: any independently witnessed owed original-six violation at
an actual step refutes the conjunction of coverage and authentic reflection
for that same independently specified event domain. This is a useful
backwards diagnostic, not an assertion that such a violation exists.

No physics is derived from pure logic: nontermination, coverage and
reflection remain explicit premises. The result does not prove the
complete physical universe satisfies BCRDIsQG, or real-world consent.
-/

namespace PhysicalBridges.G3BackwardsSummitTrace

open PhysicalBridges.G3PreQGComplete
open PhysicalBridges.FullPhysicalDomainGuardianAssembly
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.TotalEOriginalX3Bridge

/-- A chosen next physical state from the *explicit* nonterminal field.
This is noncomputable: the model merely asserts that a successor exists. -/
noncomputable def witnessNext {S P : Type} (B : BCRDIsQG S P)
    (s : S) : S := Classical.choose (B.nonterminal s)

theorem witnessNext_is_physical {S P : Type}
    (B : BCRDIsQG S P) (s : S) :
    B.physicalStep s (witnessNext B s) :=
  Classical.choose_spec (B.nonterminal s)

/-- Iteration preserves the actual state type and remembers the start. -/
def backwardsRun {S : Type} (next : S → S) (s0 : S) : Nat → S
  | 0 => s0
  | n + 1 => next (backwardsRun next s0 n)

/-- Under the *three* explicit BCRDIsQG obligations, every chosen start
admits an infinite mathematical path whose successive transitions satisfy
all six original duties and have no defined Absolute E.

This is stronger in shape than protection of an externally supplied run,
but NOT stronger in physics: the chosen run is extracted from nonterminal,
which remains an unverified physical premise. -/
theorem backwards_summit_has_infinite_protected_trace
    {S P : Type} (B : BCRDIsQG S P) (s0 : S) :
    ∃ run : Nat → S,
      run 0 = s0 ∧
      (∀ n,
        B.physicalStep (run n) (run (n + 1)) ∧
        (∀ p, B.owed p →
          OriginalX3 B.r.continues B.r.authorized B.r.free
            B.r.restrained B.r.maximal B.r.provenanced
            (run n) (run (n + 1)) p) ∧
        ¬ AbsoluteE
          (fun e : S × S => B.physicalStep e.1 e.2)
          (run n, run (n + 1))) := by
  let run : Nat → S := backwardsRun (witnessNext B) s0
  refine ⟨run, rfl, ?_⟩
  intro n
  have hStep : B.physicalStep (run n) (run (n + 1)) := by
    change B.physicalStep (run n) (witnessNext B (run n))
    exact witnessNext_is_physical B (run n)
  have hSixNoE := if_bcrd_then_all_six_and_no_E B
    (run n) (run (n + 1)) hStep
  exact ⟨hStep, hSixNoE.1, hSixNoE.2⟩

/-- Work backwards from one authentic counterexample: if an actual
owed particular fails the unchanged original-six predicate, a complete
coverage+reflection certificate cannot exist for that same event model.
This does not assume a safety predicate in the physicalStep definition. -/
theorem violated_duty_refutes_complete_bridge
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (s t : S) (p : P)
    (hPhysical : physicalStep s t) (hOwed : owed p)
    (hViolation :
      ¬ OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced s t p) :
    ¬ (CompleteWEventCoverage physicalStep modeledStep
          source stage positiveWholeU ∧
        ForwardRealEventReflection modeledStep stage positiveWholeU
          sixDiagonalRoles carrier r owed) := by
  rintro ⟨hCoverage, hReflection⟩
  have hAll :=
    every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection s t hPhysical
  exact hViolation (hAll.2.2.1 p hOwed)

#print axioms witnessNext_is_physical
#print axioms backwards_summit_has_infinite_protected_trace
#print axioms violated_duty_refutes_complete_bridge

end PhysicalBridges.G3BackwardsSummitTrace
