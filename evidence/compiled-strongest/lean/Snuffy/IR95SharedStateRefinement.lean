import Snuffy.IRA1NineClassComposition
import Snuffy.IRObservedClockedStalls

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR95SharedStateRefinement.lean` at main `740abbb` (sha256 `467ea88074c4131f0b7d6b38946d0d59e205568fbea6c34ce375b7e7b70f1f44`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-95: explicit shared-state refinement obligation.
No identification of source-world and physical states is assumed.
The adapter requires a simulation for each source event and a
physical-safety correspondence. This does not establish these
conditions for a particular installation.
-/
namespace PhysicalBridges.IR95

universe u v
variable {P : Type u}

def Relates (project : IRA1NineClassComposition.World → P)
    (w : IRA1NineClassComposition.World) (p : P) : Prop :=
  project w = p

theorem one_step_refinement
    (project : IRA1NineClassComposition.World → P)
    (sourceStep : IRA1NineClassComposition.World →
      IRA1NineClassComposition.World → Prop)
    (physicalStep : P → P → Prop)
    (simulate : ∀ w w', sourceStep w w' →
      physicalStep (project w) (project w'))
    (w w' : IRA1NineClassComposition.World)
    (p : P) (related : Relates project w p)
    (h : sourceStep w w') :
    ∃ p', physicalStep p p' ∧ Relates project w' p' := by
  refine ⟨project w', ?_, rfl⟩
  rw [← related]
  exact simulate w w' h

theorem finite_trace_refinement
    (project : IRA1NineClassComposition.World → P)
    (sourceStep : IRA1NineClassComposition.World →
      IRA1NineClassComposition.World → Prop)
    (physicalStep : P → P → Prop)
    (simulate : ∀ w w', sourceStep w w' →
      physicalStep (project w) (project w'))
    (trace : List IRA1NineClassComposition.World)
    (chain : ∀ w w', (w, w') ∈ List.zip trace trace.tail →
      sourceStep w w') :
    ∀ w w', (w, w') ∈ List.zip trace trace.tail →
      physicalStep (project w) (project w') := by
  intro w w' h
  exact simulate w w' (chain w w' h)

theorem safe_correspondence
    (project : IRA1NineClassComposition.World → P)
    (physicalSafe : P → Prop)
    (ceiling : Nat)
    (authCheck : IRA1PacketIngress.Packet → Bool)
    (reflectSafe : ∀ w,
      IRA1NineClassComposition.GlobalSafe ceiling authCheck w →
      physicalSafe (project w))
    (w : IRA1NineClassComposition.World)
    (h : IRA1NineClassComposition.GlobalSafe ceiling authCheck w) :
    physicalSafe (project w) :=
  reflectSafe w h

end PhysicalBridges.IR95
