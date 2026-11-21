theory Koru_Thermo_Quadratic
  imports Main
begin

text ‹Independent Isabelle/HOL pilot for four-state quadratic entropy.
  This is NOT a Gibbs/Shannon entropy theorem or a physical law.›

definition concentration :: "real ⇒ real ⇒ real ⇒ real ⇒ real" where
  "concentration a b c d = a*a + b*b + c*c + d*d"

definition quadratic_entropy :: "real ⇒ real ⇒ real ⇒ real ⇒ real" where
  "quadratic_entropy a b c d = 1 - concentration a b c d"

lemma pair_averaging_concentration:
  fixes a b :: real
  shows "2 * (((a+b)/2)^2) ≤ a^2 + b^2"
proof -
  have "0 ≤ (a-b)^2" by simp
  then show ?thesis by (simp add: power2_eq_square; arith)
qed

theorem coarse_concentration_le:
  fixes a b c d :: real
  shows "concentration ((a+b)/2) ((a+b)/2) ((c+d)/2) ((c+d)/2)
         ≤ concentration a b c d"
  unfolding concentration_def
  using pair_averaging_concentration[of a b]
        pair_averaging_concentration[of c d]
  by (simp add: power2_eq_square; arith)

theorem coarse_quadratic_entropy_ge:
  fixes a b c d :: real
  shows "quadratic_entropy a b c d
         ≤ quadratic_entropy ((a+b)/2) ((a+b)/2) ((c+d)/2) ((c+d)/2)"
  unfolding quadratic_entropy_def
  using coarse_concentration_le[of a b c d]
  by linarith

theorem cyclic_quadratic_entropy_invariant:
  fixes a b c d :: real
  shows "quadratic_entropy d a b c = quadratic_entropy a b c d"
  by (simp add: quadratic_entropy_def concentration_def add.commute add.left_commute add.assoc)

end
