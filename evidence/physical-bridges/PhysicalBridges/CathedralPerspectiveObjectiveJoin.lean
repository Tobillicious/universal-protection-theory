import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.IR128EquivariantProcessEmbedding
import PhysicalBridges.IR102SectorSemanticBridge

/-!
# Cathedral: an objective source fact need not be decidable by a subjective cut

This is a narrow composition of ALREADY BANKED IR-132, IR-128 and IR-102.
There is no exterior observer, exterior clock, cosmic-cycle premise, or
replacement of the original UPT/X3 semantic obligations.

(A) A certified live historical source orbit is retained at every finite
generator iterate, even though a single observation cut cannot decide
liveness if it also identifies a nonlive alternative.

(B) An independently source-certified actual execution is X3-protected
even when its observed cut cannot distinguish it from an X3-violating
alternative. This is NOT a proof that every actual execution is certified.
The source certificates, initial protection and actual model correspondence
remain substantive physical premises.

The distinction between objective source fact and subjective access is
mathematical, not a claim of consciousness or evidence for cyclic cosmology.
-/

namespace PhysicalBridges.CathedralPerspectiveObjectiveJoin

universe u v w
variable {S : Type u} {T : Type v} {O : Type w}

/-- If an observation identifies two objectively distinct source states,
then that observer's cut cannot be an exact account of the entire source
state. The observed result can be an accurate LOCAL datum; it is false to
promote it into a complete objective-state representation. -/
theorem partial_cut_not_complete_objective_state
    (cut : S → O) (s t : S)
    (sameView : cut s = cut t) (differentStates : s ≠ t) :
    ¬ IR132.ExactDecoder cut (fun x : S => x) := by
  intro hDecoder
  have hFiber :=
    IR132.exact_decoder_implies_fiber_constant cut (fun x : S => x) hDecoder
  exact differentStates (hFiber s t sameView)

/-- IR-128 guarantees an actual old live orbit is represented at every
finite source iteration. IR-132 simultaneously proves that a blind cut
cannot be a universal oracle for whether a target state is live.
Neither statement assumes a viewpoint outside either source process. -/
theorem source_continuation_with_no_local_liveness_oracle
    (source : IR128.Process S) (target : IR128.Process T)
    (embedding : IR128.Embedding source target)
    (sourceClosed : ∀ x, source.live x → source.live (source.generator x))
    (cut : T → O)
    (x : S) (liveX : source.live x)
    (alternative : T)
    (indistinguishable : cut (embedding.map x) = cut alternative)
    (alternativeNotLive : ¬ target.live alternative) :
    (∀ n : Nat,
      target.live (IR128.iterate target.generator n (embedding.map x))) ∧
    ¬ IR132.ExactDecoder cut target.live := by
  constructor
  · intro n
    exact IR128.old_living_orbits_remain_represented
      source target embedding sourceClosed x liveX n
  · intro hDecoder
    have hFiber :=
      IR132.exact_decoder_implies_fiber_constant cut target.live hDecoder
    have hSameFact :
        target.live (embedding.map x) = target.live alternative :=
      hFiber (embedding.map x) alternative indistinguishable
    have hAltLive : target.live alternative := by
      simpa only [hSameFact] using (embedding.retainsLive x liveX)
    exact alternativeNotLive hAltLive

/-- IR-102's actual-source semantic bridge can certify original X3 on
one real execution independently of whether its observational cut is
rich enough to decide X3 on ALL candidate states. IR-132 prohibits
promoting a cut-confined perspective into a universal truth oracle.

The complete/sectorClosed/entails premises are NOT inferred from
subjective blindness or nonemptiness of the universe. -/
theorem actual_x3_with_no_local_global_x3_oracle
    (physicalStep modelStep : S → S → Prop)
    (sector x3 : S → Prop)
    (complete : ∀ a b, physicalStep a b → modelStep a b)
    (sectorClosed : ∀ a b, sector a → modelStep a b → sector b)
    (sectorEntailsX3 : ∀ a, sector a → x3 a)
    {start actual : S}
    (execution : IR102.Reach physicalStep start actual)
    (initial : sector start)
    (cut : S → O) (alternative : S)
    (sameView : cut actual = cut alternative)
    (alternativeViolatesX3 : ¬ x3 alternative) :
    x3 actual ∧ ¬ IR132.ExactDecoder cut x3 := by
  have hActual : x3 actual :=
    IR102.physical_sector_semantic_bridge
      physicalStep modelStep sector x3
      complete sectorClosed sectorEntailsX3 execution initial
  refine ⟨hActual, ?_⟩
  intro hDecoder
  have hFiber :=
    IR132.exact_decoder_implies_fiber_constant cut x3 hDecoder
  have hSameFact : x3 actual = x3 alternative :=
    hFiber actual alternative sameView
  have hAltX3 : x3 alternative := by
    simpa only [hSameFact] using hActual
  exact alternativeViolatesX3 hAltX3

#print axioms partial_cut_not_complete_objective_state
#print axioms source_continuation_with_no_local_liveness_oracle
#print axioms actual_x3_with_no_local_global_x3_oracle

end PhysicalBridges.CathedralPerspectiveObjectiveJoin
