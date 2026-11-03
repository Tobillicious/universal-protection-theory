import PhysicalBridges.IR134RealHoldEffectRefinement

/-!
IR-135 — PRINCIPAL-SCOPED FINAL-EFFECT AUTHORITY AFTER HOLD.

A Linux DAC / final-application broker experiment can deny one named
unprivileged UID without denying the trusted root (or all other physical
actuators). The model therefore separates an EFFECT-APPLYING principal
from a requesting client. Only the privileged broker actually writes
to a protected resource on behalf of an unprivileged client.

The actual realStep relation is independent of the modelled source.
For an untrusted principal, the OS authority boundary must externally
show source and actual physical effect unchanged. For a trusted applying
principal, the final effect must independently refine a source command
and satisfy physical effect accounting, including nonzero residuals.

These are installation-specific physical premises, not consequences
of OS permissions, a digital log, or the Lean theorem.

A complete finite post-ACK trace has no effect growth only if all
privileged application residuals are independently bounded to zero.
A counterexample proves unprivileged DAC denial does not constrain a
privileged outside writer. No global physical UPT or X3 claim.
-/

namespace PhysicalBridges.IR135

open PhysicalBridges
open PhysicalBridges.IRInFlightQuiescence

variable {S Principal : Type}

/-- Principal is the ACTUAL writer/actor, not the identity of a client
that merely requests the trusted broker to write. -/
def AnyPrincipalStep (physicalStep : Principal → S → S → Prop)
    (s t : S) : Prop :=
  ∃ principal, physicalStep principal s t

/-- Source model + independent actor privilege separation, with a
physically warranted accounting envelope for privileged writers. -/
structure PrincipalEffectAuthority
    (physicalStep : Principal → S → S → Prop)
    (trusted : Principal → Prop)
    (pipeline : S → Pipeline)
    (realEffect : S → Nat)
    (residual : Principal → S → S → Nat) : Prop where
  untrustedSourceUnchanged :
    ∀ principal s t, ¬ trusted principal →
      physicalStep principal s t → pipeline t = pipeline s
  untrustedEffectUnchanged :
    ∀ principal s t, ¬ trusted principal →
      physicalStep principal s t → realEffect t = realEffect s
  trustedStepRefined :
    ∀ principal s t, trusted principal →
      physicalStep principal s t →
      ∃ cmd : Cmd, pipeline t = step (pipeline s) cmd
  trustedEffectAccounted :
    ∀ principal s t, trusted principal →
      physicalStep principal s t →
      realEffect t ≤ realEffect s +
        ((pipeline t).landed - (pipeline s).landed) +
        residual principal s t

/-- One independently specified actual effect step preserves an
already quiescent source, and changes the physical effect by at most
the independently assessed residual of its actual applying principal.
A requester's UID is not silently promoted to an effect writer UID. -/
theorem held_actual_principal_step_bound
    (physicalStep : Principal → S → S → Prop)
    (trusted : Principal → Prop)
    (pipeline : S → Pipeline)
    (realEffect : S → Nat)
    (residual : Principal → S → S → Nat)
    (certificate : PrincipalEffectAuthority
      physicalStep trusted pipeline realEffect residual)
    (principal : Principal) (s t : S)
    (hSource : Quiescent (pipeline s))
    (hStep : physicalStep principal s t) :
    Quiescent (pipeline t) ∧
      realEffect t ≤ realEffect s + residual principal s t := by
  by_cases hTrusted : trusted principal
  · obtain ⟨cmd, hRefine⟩ :=
      certificate.trustedStepRefined principal s t hTrusted hStep
    obtain ⟨hQuiescent, hNoNewLanding⟩ :=
      quiescent_step (pipeline s) cmd hSource
    have hFinalQ : Quiescent (pipeline t) := by
      rw [hRefine]
      exact hQuiescent
    have hLanded : (pipeline t).landed = (pipeline s).landed := by
      rw [hRefine]
      exact hNoNewLanding
    have hPhysical :=
      certificate.trustedEffectAccounted principal s t hTrusted hStep
    constructor
    · exact hFinalQ
    · simpa [hLanded] using hPhysical
  · have hSameSource :=
      certificate.untrustedSourceUnchanged
        principal s t hTrusted hStep
    have hSameEffect :=
      certificate.untrustedEffectUnchanged
        principal s t hTrusted hStep
    constructor
    · rw [hSameSource]
      exact hSource
    · rw [hSameEffect]
      omega

/-- The real trace may interleave privileged broker applications with
arbitrary OS-disallowed unprivileged actions. A physical residual-zero
warrant is needed only for steps by trusted effect-applying principals;
untrusted steps must have independently verified zero effect and unchanged
source. This does NOT rule out an uncontrolled privileged root writer:
it must satisfy the trusted refinement premise too. -/
theorem all_finite_principal_scoped_held_traces
    (physicalStep : Principal → S → S → Prop)
    (trusted : Principal → Prop)
    (pipeline : S → Pipeline)
    (realEffect : S → Nat)
    (residual : Principal → S → S → Nat)
    (certificate : PrincipalEffectAuthority
      physicalStep trusted pipeline realEffect residual)
    (hTrustedZero : ∀ principal s t, trusted principal →
      physicalStep principal s t → residual principal s t = 0)
    (initial final : S)
    (history : IR96.Reach (AnyPrincipalStep physicalStep) initial final)
    (hInitiallyQuiescent : Quiescent (pipeline initial)) :
    Quiescent (pipeline final) ∧ realEffect final ≤ realEffect initial := by
  induction history with
  | refl =>
      exact ⟨hInitiallyQuiescent, Nat.le_refl _⟩
  | tail prefix edge ih =>
      obtain ⟨principal, hStep⟩ := edge
      obtain ⟨hPriorQ, hPriorEffect⟩ := ih
      obtain ⟨hNextQ, hNextEffect⟩ :=
        held_actual_principal_step_bound
          physicalStep trusted pipeline realEffect residual
          certificate principal _ _ hPriorQ hStep
      by_cases hp : trusted principal
      · have hZero := hTrustedZero principal _ _ hp hStep
        rw [hZero] at hNextEffect
        simp only [Nat.add_zero] at hNextEffect
        exact ⟨hNextQ, Nat.le_trans hNextEffect hPriorEffect⟩
      · have hSame :=
          certificate.untrustedEffectUnchanged principal _ _ hp hStep
        constructor
        · exact hNextQ
        · rw [hSame]
          exact hPriorEffect

/-- Counterexample: all writes by NON-trusted principals are denied,
yet a trusted root writer can still alter physical effects without the
source controller's authorization. Restricting one UID is not universal
non-bypass. -/
theorem untrusted_denial_does_not_restrict_trusted_bypass :
    ∃ (trusted : Bool → Prop)
      (physicalStep : Bool → Bool → Bool → Prop)
      (realEffect : Bool → Nat),
      (∀ principal s t, ¬ trusted principal →
        physicalStep principal s t → realEffect t = realEffect s) ∧
      trusted true ∧
      physicalStep true false true ∧
      realEffect false < realEffect true := by
  refine ⟨(fun principal => principal = true),
    (fun principal s t =>
      principal = true ∧ s = false ∧ t = true),
    (fun state => if state then 1 else 0), ?_, rfl, ⟨rfl,rfl,rfl⟩, ?_⟩
  · intro principal s t hUntrusted hStep
    exact False.elim (hUntrusted hStep.1)
  · decide

#print axioms held_actual_principal_step_bound
#print axioms all_finite_principal_scoped_held_traces
#print axioms untrusted_denial_does_not_restrict_trusted_bypass

end PhysicalBridges.IR135
