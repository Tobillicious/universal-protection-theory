import PhysicalBridges.HumeHillaryReciprocalHand
import PhysicalBridges.OriginalKeystoneForwardSemanticReflection

/-!
# Hume–Hillary: both participants, one-way semantic reflection

A conditional composition of existing canonical results. The original
six X3 meanings are unchanged. Authentic offer/acceptance interpretation,
positive source origin, and forward semantic reflection are explicit
independent premises, not derived from U by this theorem.
-/

namespace PhysicalBridges.HumeHillaryTwoHandsForwardReflection

open PhysicalBridges.HumeHillaryReciprocalHand
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.KoruWholeUSubjectSixJoin
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker

/-- Both hands and all original duties for both owed participants.
Unlike the prior two-hands draft, six-duty subject fidelity is only
one-way (source truth implies independently interpreted subject truth). -/
theorem reciprocal_hand_and_both_original_six_from_forward_reflection
    {P : Type}
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations Nat P)
    (owed : P → Prop)
    (offer accept : P → P → Prop)
    (p q : P) (n : Nat)
    (hSourceHand : SourceMutualHand U (carrier p) (carrier q))
    (hForwardMeaning :
      (sourceWholeWeb (objectiveAt U n)).link
        (trackedPosition (carrier p) n)
        (trackedPosition (carrier q) n) ↔ offer p q)
    (hReturnMeaning :
      (sourceWholeWeb (objectiveAt U n)).link
        (trackedPosition (carrier q) n)
        (trackedPosition (carrier p) n) ↔ accept q p)
    (hOrigin : PositiveSourceOrigin U roles carrier owed)
    (hReflection : ForwardSemanticReflection U roles carrier r owed)
    (hp : owed p) (hq : owed q) :
    AuthenticMutualHand offer accept p q ∧
      SubjectOriginalSixAt r n p ∧
      SubjectOriginalSixAt r n q := by
  have hStage := (mutual_hand_is_exact_under_physical_W
    U (carrier p) (carrier q) n).mpr hSourceHand
  have hDistinct : p ≠ q := by
    intro heq
    exact hSourceHand.1 (congrArg carrier heq)
  have hAll : ∀ k x, owed x → SubjectOriginalSixAt r k x :=
    (all_owed_original_six_iff_forward_reflection
      U roles carrier r owed hOrigin).mpr hReflection
  exact ⟨⟨hDistinct, hForwardMeaning.mp hStage.2.1,
      hReturnMeaning.mp hStage.2.2⟩,
    hAll n p hp, hAll n q hq⟩

#print axioms reciprocal_hand_and_both_original_six_from_forward_reflection

end PhysicalBridges.HumeHillaryTwoHandsForwardReflection
