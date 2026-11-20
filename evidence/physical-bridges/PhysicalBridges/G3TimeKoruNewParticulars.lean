import PhysicalBridges.G3MatterspacetimeRealizationGate
import PhysicalBridges.G3KoruSpiral

/-!
# G3 — Time Koru, new owed particulars, and complete event realization

Research-only additive join. Requires staging the companion
G3MatterspacetimeRealizationGate.lean in the PhysicalBridges import tree.
No changes to the original Koru or the six-field OriginalX3 definition.

The old source transport preserves carried histories and positions. That
alone does not discharge duties for NEWLY owed particulars. This theorem
states and proves the exact old/new induction split, while a second theorem
connects actual physical event witnesses to the original six X3 duties at
every stage of an outward spiral.

No assumption equates a stored record to authentic subject continuity.
No physical-world realization or positive origin premise is silently proved.
-/

namespace PhysicalBridges.G3TimeKoruNewParticulars

open PhysicalBridges.G3MatterspacetimeRealizationGate
open PhysicalBridges.G3KoruSpiral
open PhysicalBridges.OriginalX3Full

universe u v w

def NewlyOwed {P : Type u} (owed : Nat → P → Prop)
    (n : Nat) (p : P) : Prop :=
  owed (n + 1) p ∧ ¬ owed n p

theorem old_and_new_duties_cover_all_future_particulars
    {P : Type u} (owed : Nat → P → Prop)
    (protected : Nat → P → Prop)
    (hOrigin : ∀ p, owed 0 p → protected 0 p)
    (hKeep : ∀ n p, owed n p → owed (n + 1) p)
    (hCarry : ∀ n p, owed n p → protected n p →
      protected (n + 1) p)
    (hNew : ∀ n p, NewlyOwed owed n p → protected (n + 1) p) :
    ∀ n p, owed n p → protected n p := by
  intro n
  induction n with
  | zero => exact hOrigin
  | succ n ih =>
      intro p hp
      by_cases hPreviously : owed n p
      · exact hCarry n p hPreviously (ih p hPreviously)
      · exact hNew n p ⟨hp, hPreviously⟩

theorem all_six_original_duties_for_old_and_new
    {P : Type u}
    (owed : Nat → P → Prop)
    (continues authorized free restrained maximal provenanced :
      Nat → Nat → P → Prop)
    (hOrigin : ∀ p, owed 0 p →
      OriginalX3 continues authorized free restrained maximal provenanced 0 1 p)
    (hKeep : ∀ n p, owed n p → owed (n + 1) p)
    (hCarry : ∀ n p, owed n p →
      OriginalX3 continues authorized free restrained maximal provenanced
        n (n + 1) p →
      OriginalX3 continues authorized free restrained maximal provenanced
        (n + 1) (n + 2) p)
    (hNew : ∀ n p, NewlyOwed owed n p →
      OriginalX3 continues authorized free restrained maximal provenanced
        (n + 1) (n + 2) p) :
    ∀ n p, owed n p →
      OriginalX3 continues authorized free restrained maximal provenanced
        n (n + 1) p := by
  exact old_and_new_duties_cover_all_future_particulars owed
    (fun n p => OriginalX3 continues authorized free restrained
      maximal provenanced n (n + 1) p)
    hOrigin hKeep hCarry hNew

theorem complete_realization_protects_each_spiral_step
    {C E : Type u} {W : Type v} {P : Type w}
    (next : C → E → C)
    (seed : KoruState C E) (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W)
    (owed : KoruState C E → KoruState C E → P → Prop)
    (d : SourceSix W P)
    (continues authorized free restrained maximal provenanced :
      KoruState C E → KoruState C E → P → Prop)
    (hStep : ∀ n, R.actual (run next seed events n)
      (run next seed events (n + 1)))
    (hCoverage : CompletePhysicalCoverage R)
    (hSource : ∀ s t w p, R.actual s t → owed s t p →
      R.recorded s t = some w → SourceSixHolds d w p)
    (hMeaning : AuthenticRealization R d
      continues authorized free restrained maximal provenanced) :
    ∀ n p, owed (run next seed events n)
      (run next seed events (n + 1)) p →
      OriginalX3 continues authorized free restrained maximal
        provenanced (run next seed events n)
        (run next seed events (n + 1)) p := by
  have allActual := coverage_and_authentic_shapes_yield_every_original_X3
    R owed d continues authorized free restrained maximal provenanced
    hCoverage hSource hMeaning
  intro n p hp
  exact allActual _ _ p (hStep n) hp

theorem forward_koru_history_and_six_duties
    {C E : Type u} {W : Type v} {P : Type w}
    (next : C → E → C)
    (seed : KoruState C E) (events : Nat → E)
    (R : PhysicalRepresentation (KoruState C E) W)
    (owed : KoruState C E → KoruState C E → P → Prop)
    (d : SourceSix W P)
    (continues authorized free restrained maximal provenanced :
      KoruState C E → KoruState C E → P → Prop)
    (hStep : ∀ n, R.actual (run next seed events n)
      (run next seed events (n + 1)))
    (hCoverage : CompletePhysicalCoverage R)
    (hSource : ∀ s t w p, R.actual s t → owed s t p →
      R.recorded s t = some w → SourceSixHolds d w p)
    (hMeaning : AuthenticRealization R d
      continues authorized free restrained maximal provenanced) :
    (∀ i j, i ≤ j → ∃ new : List E,
      (run next seed events j).history =
        new ++ (run next seed events i).history) ∧
    (∀ n p, owed (run next seed events n)
      (run next seed events (n + 1)) p →
      OriginalX3 continues authorized free restrained maximal
        provenanced (run next seed events n)
        (run next seed events (n + 1)) p) := by
  constructor
  · intro i j hij
    exact NOTHING_IS_LOST_ON_THE_SPIRAL next seed events hij
  · exact complete_realization_protects_each_spiral_step
      next seed events R owed d
      continues authorized free restrained maximal provenanced
      hStep hCoverage hSource hMeaning

#print axioms old_and_new_duties_cover_all_future_particulars
#print axioms all_six_original_duties_for_old_and_new
#print axioms complete_realization_protects_each_spiral_step
#print axioms forward_koru_history_and_six_duties

end PhysicalBridges.G3TimeKoruNewParticulars
