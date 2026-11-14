theory G2_Aristotle_Greatestness
  imports G2_Hume_Hillary_Join
begin

text ‹A small independently checkable logical bridge. It does not assert that
  the source premises hold in the physical world. In particular, the
  "infinity" arguments must be translated into exact premises before they
  can discharge any of these assumptions.›

locale g2_aristotle = g2_hume_hillary +
  fixes admissible :: "'event ⇒ bool"
    and dominates :: "'event ⇒ 'event ⇒ bool"
begin

definition universal_six where
  "universal_six e ⟷
    (∀p. owed e p ⟶ original_six e p)"

definition universal_benefit where
  "universal_benefit e ⟷
    (∀p. owed e p ⟶ benefits e p)"

definition nonvacuous_scope where
  "nonvacuous_scope e ⟷ (∃p. owed e p)"

definition greatest_gift where
  "greatest_gift e ⟷
    admissible e ∧ enacted e ∧ universal_six e ∧
    universal_benefit e ∧ (∀r. admissible r ⟶ dominates e r)"

definition witnessed_greatest_gift where
  "witnessed_greatest_gift e ⟷
    greatest_gift e ∧ nonvacuous_scope e"

theorem witnessed_greatest_gift_has_particular:
  assumes "witnessed_greatest_gift e"
  shows "∃p. owed e p ∧ original_six e p ∧ benefits e p"
  using assms
  unfolding witnessed_greatest_gift_def nonvacuous_scope_def
    greatest_gift_def universal_six_def universal_benefit_def
  by blast

theorem greatest_gift_has_all_six:
  assumes "greatest_gift e" and "owed e p"
  shows "original_six e p"
  using assms unfolding greatest_gift_def universal_six_def by blast

theorem greatest_gift_benefits_every_owed:
  assumes "greatest_gift e" and "owed e p"
  shows "benefits e p"
  using assms unfolding greatest_gift_def universal_benefit_def by blast

theorem greatest_gift_from_explicit_bridges:
  assumes "admissible e" and "enacted e"
    and "∀p. owed e p ⟶ original_six e p"
    and "∀p. owed e p ⟶ benefits e p"
    and "∀r. admissible r ⟶ dominates e r"
  shows "greatest_gift e"
  using assms unfolding greatest_gift_def universal_six_def
    universal_benefit_def by blast

lemma vacuous_universal_six_without_owed:
  assumes "∀p. ¬ owed e p"
  shows "universal_six e"
  using assms unfolding universal_six_def by blast

text ‹The preceding theorem is deliberately conditional: it does not
  derive benefit, dominance, existence or authentic consent from ontology.›

end

text ‹A countermodel: reciprocal physical signalling need not be consent.›

lemma physical_reciprocity_does_not_force_consent:
  "¬ (∀ (signal consent :: bool). signal ⟶ consent)"
  by auto

end
