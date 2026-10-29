import Snuffy.ControllerFence

/-!
  R12-A: the decision certificate bound to the permit (Whole Edition 3.5, 23 Oct 2026). Lean 4 core.

  Imports Paper 12's controller and fence modules unchanged (`ControllerFence`, which imports `UPTFence` and
  `ControllerFinality`). The controller grants an authorization only for a context whose scope equals the enrolment
  of its generation (`step`). R12-A enrols each generation with the words of its certified decision: the protected
  resident, the identity-criterion version, the chosen policy and the digest of the feasible family whose canonical
  comparison certified the policy (G6-R, G2-U).
  * `decision_words_injective`: the words name exactly one decision.
  * `grant_names_certified`: every grant is for the requested context, and that context's scope is the certified
    decision of its generation; so `granted_policy_is_certified`: every authorised effect carries the policy whose
    maximality was certified, never a substitute.
  * `wrong_action_rejected` / `certified_action_granted`: the acceptance test of the R12 candidate. One resident, two
    actions (0 = pause, 1 = hot replica), the replica certified. A permit naming the pause, with valid generation,
    boot and sequence, is rejected; the permit naming the replica is granted.
  With `UPTControllerFence.certified_hold_nothing_lands` (unchanged), a retired generation's grants land nowhere once
  the targets' floors rise: decision, permit and effect are one chain.
-/

namespace UPTDecisionPermit

open UPTController

structure Decision where
  resident : Nat
  criterion : Nat
  policy : Nat
  family : Nat
  deriving DecidableEq, Repr

def decisionWords (d : Decision) : List Nat := [d.resident, d.criterion, d.policy, d.family]

theorem decision_words_injective (a b : Decision) (h : decisionWords a = decisionWords b) : a = b := by
  cases a; cases b
  simp only [decisionWords, List.cons.injEq] at h
  obtain ⟨h1, h2, h3, h4, -⟩ := h
  subst h1 h2 h3 h4
  rfl

/-- Enrolment binds each generation to the words of its certified decision. -/
def enrolOf (D : Nat → Decision) : Nat → List Nat := fun g => decisionWords (D g)

theorem grant_names_certified (D : Nat → Decision) (s : State) (c c' : Context)
    (h : (step (enrolOf D) s (.authorize c)).2 = .grant c') :
    c' = c ∧ c.scope = decisionWords (D c.generation) := by
  cases hp : s.pending with
  | none =>
    simp only [step, hp] at h
    by_cases hc : (c.scope = enrolOf D c.generation ∧ c.generation = s.generation ∧ s.held = false ∧
        c.boot = s.boot)
    · rw [ite_eq_left_of_eq_true _ _ (eq_true hc)] at h
      by_cases hs : c.sequence = s.closed + 1
      · rw [ite_eq_left_of_eq_true _ _ (eq_true hs)] at h
        exact ⟨(Reply.grant.inj h).symm, hc.1⟩
      · rw [ite_eq_right_of_eq_false _ _ (eq_false hs)] at h
        exact absurd h (by simp)
    · rw [ite_eq_right_of_eq_false _ _ (eq_false hc)] at h
      exact absurd h (by simp)
  | some old =>
    simp only [step, hp] at h
    by_cases hc : (c.scope = enrolOf D c.generation ∧ c.generation = s.generation ∧ s.held = false ∧
        c.boot = s.boot)
    · rw [ite_eq_left_of_eq_true _ _ (eq_true hc)] at h
      by_cases ho : old = c
      · rw [ite_eq_left_of_eq_true _ _ (eq_true ho)] at h
        exact ⟨(Reply.grant.inj h).symm.trans ho, hc.1⟩
      · rw [ite_eq_right_of_eq_false _ _ (eq_false ho)] at h
        exact absurd h (by simp)
    · rw [ite_eq_right_of_eq_false _ _ (eq_false hc)] at h
      exact absurd h (by simp)

theorem granted_policy_is_certified (D : Nat → Decision) (Certified : Decision → Prop)
    (hcert : ∀ g, Certified (D g)) (s : State) (c c' : Context)
    (h : (step (enrolOf D) s (.authorize c)).2 = .grant c') :
    ∃ d, decisionWords d = c'.scope ∧ Certified d := by
  obtain ⟨rfl, hs⟩ := grant_names_certified D s c c' h
  exact ⟨D c'.generation, hs.symm, hcert _⟩

/-! The acceptance test: resident 0, criterion version 1, feasible family digest 7; generation 1 certifies the hot
    replica (policy 1). -/

def D0 : Nat → Decision := fun _ => ⟨0, 1, 1, 7⟩
def s0 : State := ⟨1, false, 0, 0, none⟩
def pausePermit : Context := ⟨decisionWords ⟨0, 1, 0, 7⟩, 1, 0, 1, 5⟩
def replicaPermit : Context := ⟨decisionWords ⟨0, 1, 1, 7⟩, 1, 0, 1, 5⟩

theorem wrong_action_rejected : (step (enrolOf D0) s0 (.authorize pausePermit)).2 = .rejected := by decide

theorem certified_action_granted :
    (step (enrolOf D0) s0 (.authorize replicaPermit)).2 = .grant replicaPermit := by decide

end UPTDecisionPermit
