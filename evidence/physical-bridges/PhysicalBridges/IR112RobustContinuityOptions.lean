import PhysicalBridges.IR109RobustObservationViability

/-!
IR-112: a finite-trace composition contract for continuing subjects.
The result does not identify numerical safety with continuation,
nor equate one remaining option with maximal X3 freedom.
All semantic and physically executable-option obligations are explicit.
-/
namespace PhysicalBridges.IR112

open IR109

universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- The intended subject is continuing and has an executable option.
This is weaker than X3's maximal freedom, which must be specified
separately. -/
def Protected (continuing : S → Prop)
    (executable : S → A → Prop) (s : S) : Prop :=
  continuing s ∧ ∃ a, executable s a

theorem robust_continuation_and_options
    (observe : S → O) (step : S → A → S → Prop)
    (policy : O → A)
    (continuing : S → Prop) (executable : S → A → Prop)
    (hRobust : ∀ o s, observe s = o →
      Protected continuing executable s →
      ∀ t, step s (policy o) t →
        Protected continuing executable t)
    {initial final : S}
    (hTrace : PolicyReach step policy observe initial final)
    (hInitial : Protected continuing executable initial) :
    continuing final ∧ ∃ a, executable final a := by
  have hPreserved :
      Protected continuing executable final :=
    robust_viability_all_finite_traces
      observe step (Protected continuing executable) policy
      hRobust hTrace hInitial
  exact hPreserved

/-- Nonempty options alone do not establish an independently
specified maximal freedom requirement. -/
theorem executable_option_not_maximal_freedom :
    ∃ (options : Bool → Prop) (maximal : Prop),
      (∃ a, options a) ∧ ¬ maximal := by
  exact ⟨fun a => a = true, False, ⟨true, rfl⟩, id⟩

end PhysicalBridges.IR112
