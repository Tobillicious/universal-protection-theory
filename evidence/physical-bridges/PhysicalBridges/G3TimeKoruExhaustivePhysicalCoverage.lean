import PhysicalBridges.G3TimeKoruNewParticulars

/-!
# G3 — exact scope of Time Koru physical coverage

An independently specified actual physical relation is NOT defined by the
modeled Time Koru path. To derive complete actual coverage from path-specific
witnesses, one must independently establish that every actual transition is
one of the path transitions. This file proves both directions of that join,
and an explicit finite counterexample to the shortcut from path recording
to universal physical coverage.

This is a conditional mathematical theorem, not a law proving that the real
universe contains no unmodeled event. OriginalX3 is unchanged.
-/

namespace PhysicalBridges.G3TimeKoruExhaustivePhysicalCoverage

open PhysicalBridges.G3MatterspacetimeRealizationGate
open PhysicalBridges.G3KoruSpiral
open PhysicalBridges.G3TimeKoruNewParticulars
open PhysicalBridges.OriginalX3Full

universe u v w

def SpiralTransition {C E : Type u} (next : C → E → C)
    (seed : KoruState C E) (events : Nat → E)
    (s t : KoruState C E) : Prop :=
  ∃ n, s = run next seed events n ∧
    t = run next seed events (n + 1)

def EverySpiralStepWitnessed {C E : Type u} {W : Type v}
    (next : C → E → C) (seed : KoruState C E)
    (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W) : Prop :=
  ∀ n, ∃ w,
    R.recorded (run next seed events n)
      (run next seed events (n + 1)) = some w ∧
    R.realizes w (run next seed events n)
      (run next seed events (n + 1))

def AllActualStepsOnSpiral {C E : Type u} {W : Type v}
    (next : C → E → C) (seed : KoruState C E)
    (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W) : Prop :=
  ∀ s t, R.actual s t → SpiralTransition next seed events s t

theorem exhaustive_spiral_witnesses_prove_physical_coverage
    {C E : Type u} {W : Type v}
    (next : C → E → C) (seed : KoruState C E)
    (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W)
    (hExhaustive : AllActualStepsOnSpiral next seed events R)
    (hWitness : EverySpiralStepWitnessed next seed events R) :
    CompletePhysicalCoverage R := by
  intro s t ha
  obtain ⟨n, rfl, rfl⟩ := hExhaustive s t ha
  exact hWitness n

theorem coverage_iff_each_spiral_step_witnessed
    {C E : Type u} {W : Type v}
    (next : C → E → C) (seed : KoruState C E)
    (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W)
    (hExhaustive : AllActualStepsOnSpiral next seed events R)
    (hPathActual : ∀ n, R.actual (run next seed events n)
      (run next seed events (n + 1))) :
    CompletePhysicalCoverage R ↔
      EverySpiralStepWitnessed next seed events R := by
  constructor
  · intro hCoverage n
    exact hCoverage _ _ (hPathActual n)
  · intro hWitness
    exact exhaustive_spiral_witnesses_prove_physical_coverage
      next seed events R hExhaustive hWitness

theorem exhaustive_spiral_coverage_yields_actual_original_six
    {C E : Type u} {W : Type v} {P : Type w}
    (next : C → E → C) (seed : KoruState C E)
    (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W)
    (owed : KoruState C E → KoruState C E → P → Prop)
    (d : SourceSix W P)
    (continues authorized free restrained maximal provenanced :
      KoruState C E → KoruState C E → P → Prop)
    (hExhaustive : AllActualStepsOnSpiral next seed events R)
    (hWitness : EverySpiralStepWitnessed next seed events R)
    (hSource : ∀ s t w p, R.actual s t → owed s t p →
      R.recorded s t = some w → SourceSixHolds d w p)
    (hMeaning : AuthenticRealization R d
      continues authorized free restrained maximal provenanced) :
    ∀ s t p, R.actual s t → owed s t p →
      OriginalX3 continues authorized free restrained maximal provenanced
        s t p := by
  exact coverage_and_authentic_shapes_yield_every_original_X3
    R owed d continues authorized free restrained maximal provenanced
    (exhaustive_spiral_witnesses_prove_physical_coverage
      next seed events R hExhaustive hWitness) hSource hMeaning

def flatNext (_ : Bool) (_ : Unit) : Bool := false
def flatSeed : KoruState Bool Unit := ⟨false, []⟩
def allEvents (_ : Nat) : Unit := ()

def partialRecording : PhysicalRepresentation (KoruState Bool Unit) Unit where
  actual := fun _ _ => True
  recorded := fun s t =>
    if s.content == false && t.content == false then some () else none
  realizes := fun _ _ _ => True

theorem flat_run_content_false (n : Nat) :
    (run flatNext flatSeed allEvents n).content = false := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp [run, spiral, flatNext]

theorem flat_spiral_fully_witnessed :
    EverySpiralStepWitnessed flatNext flatSeed allEvents partialRecording := by
  intro n
  refine ⟨(), ?_, trivial⟩
  simp [partialRecording, flat_run_content_false n,
    flat_run_content_false (n + 1)]

theorem outside_spiral_event_refutes_total_coverage :
    ¬ CompletePhysicalCoverage partialRecording := by
  apply actual_unrecorded_event_refutes_coverage
    partialRecording (s := ⟨true, []⟩) (t := ⟨false, []⟩)
  · trivial
  · rfl

#print axioms exhaustive_spiral_witnesses_prove_physical_coverage
#print axioms coverage_iff_each_spiral_step_witnessed
#print axioms exhaustive_spiral_coverage_yields_actual_original_six
#print axioms flat_spiral_fully_witnessed
#print axioms outside_spiral_event_refutes_total_coverage

end PhysicalBridges.G3TimeKoruExhaustivePhysicalCoverage
