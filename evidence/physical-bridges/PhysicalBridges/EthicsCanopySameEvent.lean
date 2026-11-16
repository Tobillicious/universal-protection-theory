import PhysicalBridges.OriginalX3Full
import PhysicalBridges.LivingTreeGenerations

/-!
# Ethics Canopy: same-event composition and learned-history carriage

Additive research joins. These do not redefine original six X3, authenticate
ethical propositions, establish cultural authority, or certify physical G3.
An independently supplied real-effect correspondence is still necessary.
-/

namespace PhysicalBridges.EthicsCanopySameEvent

open PhysicalBridges.OriginalX3Full
open PhysicalBridges.LivingTreeGenerations

universe u v w
variable {S : Type u} {P : Type v} {E : Type w}

/-- Independent ethics validity, applicability, and fulfillment on one event. -/
def AllApplicableEthics
    (valid : E → Prop)
    (applies fulfills : S → S → P → E → Prop)
    (s t : S) (p : P) : Prop :=
  ∀ e, valid e → applies s t p e → fulfills s t p e

/-- The original six obligations and all independently valid applicable
ethical duties are simultaneously true for the SAME owed particular/event. -/
theorem same_event_six_and_all_ethics
    (step : S → S → Prop) (owed : S → S → P → Prop)
    (valid : E → Prop)
    (applies fulfills : S → S → P → E → Prop)
    (continues authorized free restrained maximal provenanced :
      S → S → P → Prop)
    (hSix : ∀ s t p, step s t → owed s t p →
      OriginalX3 continues authorized free restrained maximal provenanced s t p)
    (hEthics : ∀ s t p, step s t → owed s t p →
      AllApplicableEthics valid applies fulfills s t p) :
    ∀ s t p, step s t → owed s t p →
      OriginalX3 continues authorized free restrained maximal provenanced s t p ∧
      AllApplicableEthics valid applies fulfills s t p := by
  intro s t p hs ho
  exact ⟨hSix s t p hs ho, hEthics s t p hs ho⟩

/-- An authorization that has been withdrawn is not admissible when the
trusted decision checks the withdrawal at effect time. This is a logical
contract, not proof that a concrete writer implements it. -/
theorem withdrawn_effect_denied
    (admitted withdrawn : S → S → P → Prop)
    (hFence : ∀ s t p, admitted s t p → ¬ withdrawn s t p)
    (s t : S) (p : P) (hWithdrawal : withdrawn s t p) :
    ¬ admitted s t p := by
  intro hAdmit
  exact (hFence s t p hAdmit) hWithdrawal

/-- Preservation of recorded ethics through modeled learning; no
inference that every recorded proposition is morally correct. -/
theorem learned_tree_retains_each_ethical_record
    {T H : Type} (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (n : Nat) (e : E) :
    (grow J s n).ethics e ↔ s.ethics e :=
  (modeled_learning_preserves_ethics_and_orientation J s n e).1

#print axioms same_event_six_and_all_ethics
#print axioms withdrawn_effect_denied
#print axioms learned_tree_retains_each_ethical_record

end PhysicalBridges.EthicsCanopySameEvent
