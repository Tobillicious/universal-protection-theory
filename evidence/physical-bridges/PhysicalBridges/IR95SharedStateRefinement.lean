import PhysicalBridges.IRA1NineClassComposition
import PhysicalBridges.IRObservedClockedStalls

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
