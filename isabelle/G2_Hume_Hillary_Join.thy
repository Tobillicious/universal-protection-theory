theory G2_Hume_Hillary_Join
  imports Main
begin

text ‹Independent Isabelle/HOL research lane. This does not import or certify Lean.
  Six X3 fields correspond by name to OriginalX3Full.lean. The meaning of
  these fields, actual-event coverage, and the Hume ethical bridge remain
  separate proof obligations. Koru is not modelled as a numeric function.›

locale g2_hume_hillary =
  fixes owed :: "'event ⇒ 'person ⇒ bool"
    and enacted :: "'event ⇒ bool"
    and continues :: "'event ⇒ 'person ⇒ bool"
    and authorized :: "'event ⇒ 'person ⇒ bool"
    and free :: "'event ⇒ 'person ⇒ bool"
    and restrained :: "'event ⇒ 'person ⇒ bool"
    and maximal :: "'event ⇒ 'person ⇒ bool"
    and provenanced :: "'event ⇒ 'person ⇒ bool"
    and offered :: "'event ⇒ 'person ⇒ 'person ⇒ bool"
    and accepted :: "'event ⇒ 'person ⇒ 'person ⇒ bool"
    and benefits :: "'event ⇒ 'person ⇒ bool"
begin

definition original_six where
  "original_six e p ⟷
    continues e p ∧ authorized e p ∧ free e p ∧
    restrained e p ∧ maximal e p ∧ provenanced e p"

definition reciprocal_hand where
  "reciprocal_hand e p q ⟷
    p ≠ q ∧ offered e p q ∧ accepted e q p"

definition g2_gift where
  "g2_gift e p q ⟷
    enacted e ∧ owed e p ∧ owed e q ∧
    reciprocal_hand e p q ∧
    original_six e p ∧ original_six e q ∧
    benefits e p ∧ benefits e q"

lemma gift_preserves_both_original_six:
  assumes "g2_gift e p q"
  shows "original_six e p ∧ original_six e q"
  using assms unfolding g2_gift_def by blast

lemma gift_requires_authentic_acceptance:
  assumes "g2_gift e p q"
  shows "offered e p q ∧ accepted e q p"
  using assms unfolding g2_gift_def reciprocal_hand_def by blast

end
end
