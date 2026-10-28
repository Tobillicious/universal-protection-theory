/-
IR-137: rolling original-UPT protection for newly appearing PARTICULARS,
not only the initially registered cohort. Reuses the already checked
IR-113, IR-116, IR-134 and IR-135 source compositions.

Scope remains the ORIGINAL all-particular X3, existing/new continuations
and freedoms. Actual same-particular physical identity, exhaustive
recognition of all particulars, the completeness of the transition
inventory and globally maximal original outcome remain OPEN.
-/
import PhysicalBridges.IR135CommonPolicyWorlds

namespace PhysicalBridges.IR137
universe u v w x y z
variable {S : Type u} {O : Type v} {A : Type w}
variable {D : Type x} {P : Type y} {W : Type z}

/-- A single observation policy selected from the intersection of
robustly safe actions for every observation class protects any subject
that becomes owed at ANY later checkpoint, across EVERY admissible
future disturbance trace. There is no switch of policy at admission.

This strengthens "initial cohort" by proving a ROLLING obligation:
a particular first owed at a later state is protected from THAT state
onward; the owed relation is monotone and cannot be cleared.
An exhaustive actual-world recognition oracle remains a premise.
-/
theorem one_policy_protects_every_later_owed_cohort
    (next : S → A → D → S) (observe : S → O)
    (owed : S → P → Prop) (continues : S → P → Prop)
    (required executable : S → P → A → Prop)
    (hDutyMonotone : ∀ s a d m,
      owed s m → owed (next s a d) m)
    (hCommon : ∀ o,
      ∃ a, IR113.ClassViableAction observe
        (IR134.PhysicalStep next)
        (IR116.EveryOwedSubjectProtected
          owed continues required executable) o a) :
    ∃ policy : O → A,
      ∀ initial : S,
        IR116.EveryOwedSubjectProtected
          owed continues required executable initial →
        ∀ (past future : List D) (m : P),
          let checkpoint :=
            IRViability.run next
              (fun s => policy (observe s)) initial past
          owed checkpoint m →
            let final :=
              IRViability.run next
                (fun s => policy (observe s)) checkpoint future
            continues final m ∧
            (∃ a, required final m a) ∧
            (∀ a, required final m a → executable final m a) := by
  obtain ⟨policy, hClass⟩ :=
    (IR113.observation_policy_exists_iff_common_viable_action
      observe (IR134.PhysicalStep next)
      (IR116.EveryOwedSubjectProtected
        owed continues required executable)).mpr hCommon
  have hMonotone : ∀ s d m, owed s m →
      owed (next s (policy (observe s)) d) m := by
    intro s d m hm
    exact hDutyMonotone s (policy (observe s)) d m hm
  have hRobust : ∀ s d,
      IR116.EveryOwedSubjectProtected
        owed continues required executable s →
      IR116.EveryOwedSubjectProtected
        owed continues required executable
          (next s (policy (observe s)) d) := by
    intro s d hs
    exact hClass (observe s) s rfl hs
      (next s (policy (observe s)) d) ⟨d, rfl⟩
  have hAllPrefixes : ∀ (s : S) (ds : List D),
      IR116.EveryOwedSubjectProtected
        owed continues required executable s →
      IR116.EveryOwedSubjectProtected
        owed continues required executable
          (IRViability.run next
            (fun t => policy (observe t)) s ds) := by
    intro s ds
    induction ds generalizing s with
    | nil =>
        intro hS
        exact hS
    | cons d ds ih =>
        intro hS
        change IR116.EveryOwedSubjectProtected
          owed continues required executable
          (IRViability.run next
            (fun t => policy (observe t))
            (next s (policy (observe s)) d) ds)
        exact ih (next s (policy (observe s)) d) (hRobust s d hS)
  refine ⟨policy, ?_⟩
  intro initial hInitial past future m hOwed
  let checkpoint :=
    IRViability.run next (fun s => policy (observe s)) initial past
  have hCheckpoint : IR116.EveryOwedSubjectProtected
      owed continues required executable checkpoint :=
    hAllPrefixes initial past hInitial
  exact
    IR134.source_run_retains_original_cohort_and_required_options
      next observe policy owed continues required executable
      hMonotone hRobust checkpoint hCheckpoint future m hOwed

/-- More directly states the original all-particular obligation:
any physical particular PRESENT at ANY checkpoint is protected on ALL
subsequent admitted reactive-world histories, by ONE common policy.

The separate hRecognize premise is the hard universal reach/identity
bridge: existence in the physical world must imply recognition as owed.
Without it, rolling-registry protection is not universal protection.
-/
theorem every_recognized_present_particular_protected_in_all_worlds
    (next : S → A → D → S) (observe : S → O)
    (world : W → S → A → D)
    (present owed : S → P → Prop) (continues : S → P → Prop)
    (required executable : S → P → A → Prop)
    (hRecognize : ∀ s m, present s m → owed s m)
    (hDutyMonotone : ∀ s a d m,
      owed s m → owed (next s a d) m)
    (hCommon : ∀ o,
      ∃ a, IR113.ClassViableAction observe
        (IR134.PhysicalStep next)
        (IR116.EveryOwedSubjectProtected
          owed continues required executable) o a) :
    ∃ policy : O → A,
      ∀ initial : S,
        IR116.EveryOwedSubjectProtected
          owed continues required executable initial →
        ∀ (ξ : W) (before after : Nat) (m : P),
          let checkpoint :=
            IRViability.run next
              (fun s => policy (observe s)) initial
              (IR135.reactiveDisturbances next observe
                (world ξ) policy initial before)
          present checkpoint m →
            let final :=
              IRViability.run next
                (fun s => policy (observe s)) checkpoint
                (IR135.reactiveDisturbances next observe
                  (world ξ) policy checkpoint after)
            continues final m ∧
            (∃ a, required final m a) ∧
            (∀ a, required final m a → executable final m a) := by
  obtain ⟨policy, hAll⟩ :=
    one_policy_protects_every_later_owed_cohort
      next observe owed continues required executable
      hDutyMonotone hCommon
  refine ⟨policy, ?_⟩
  intro initial hInitial ξ before after m hPresent
  let checkpoint :=
    IRViability.run next (fun s => policy (observe s)) initial
      (IR135.reactiveDisturbances next observe
        (world ξ) policy initial before)
  exact hAll initial hInitial
    (IR135.reactiveDisturbances next observe (world ξ)
      policy initial before)
    (IR135.reactiveDisturbances next observe (world ξ)
      policy checkpoint after)
    m (hRecognize checkpoint m hPresent)

/-- A bounded registry can protect all its own entries while omitting
a newly existing physical particular: the truth of an internal duty
certificate does not entail universal recognition. -/
def partiallyPresent (s : Bool) (m : Bool) : Prop :=
  m = false ∨ (s = true ∧ m = true)

def narrowRegistry (_ : Bool) (m : Bool) : Prop := m = false

theorem omitted_new_particular_countermodel :
    (∀ s m, narrowRegistry s m → partiallyPresent s m) ∧
    (∃ s m, partiallyPresent s m ∧ ¬ narrowRegistry s m) := by
  constructor
  · intro s m hm
    exact Or.inl hm
  · refine ⟨true, true, Or.inr ⟨rfl, rfl⟩, ?_⟩
    decide

#print axioms one_policy_protects_every_later_owed_cohort
#print axioms every_recognized_present_particular_protected_in_all_worlds
#print axioms omitted_new_particular_countermodel
end PhysicalBridges.IR137
