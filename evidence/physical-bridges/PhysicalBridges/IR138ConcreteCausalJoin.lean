/-
IR-138: one completely explicit finite causal model linking original
particulars, newly arriving particulars, a pre-effect protective cut,
rolling recognition, and four-stage rival comparison.

THIS IS AN ABSTRACT SOURCE-MODEL WITNESS, NOT VALIDATION OF REAL
HARDWARE, UNIVERSAL CAUSAL COVERAGE, AUTHENTIC CONSENT, OR X3.
The positive theorem assumes no hidden bypass and a PRE-INSTALLED gate.
The hostile countermodels demonstrate why those assumptions matter.
-/
namespace PhysicalBridges.IR138

structure State where
  oldAlive : Bool
  oldOption : Bool
  youngPresent : Bool
  youngAlive : Bool
  youngOption : Bool
  youngOwed : Bool
  deriving DecidableEq, Repr

structure Threat where
  strikeOld : Bool
  strikeYoung : Bool
  birth : Bool
  forgedConsent : Bool
  bypass : Bool
  deriving DecidableEq, Repr

/-- Pre-effect action: true is a presently operative guard, false
means stand by. A bypass strikes beyond the cut even if guard=true.
Birth and a possible strike may occur in the same source step. -/
def step (s : State) (guard : Bool) (w : Threat) : State :=
  { oldAlive := s.oldAlive && !(w.strikeOld && (w.bypass || !guard))
    oldOption := s.oldOption
    youngPresent := s.youngPresent || w.birth
    youngAlive :=
      (s.youngAlive || w.birth) &&
        !(w.strikeYoung && (w.bypass || !guard))
    youngOption := s.youngOption || w.birth
    youngOwed := s.youngOwed || w.birth }

/-- Old particular with one lawful option; new particular has not yet
appeared. No archived/copy substitution is part of this tiny model. -/
def initial : State :=
  ⟨true, true, false, false, false, false⟩

def NoBypass (w : Threat) : Prop := w.bypass = false

/-- Positive protection AND automatic recognition when a new
particular enters: a model-specific, directly checkable invariant.
This does NOT mean every real-world birth/particular is observable. -/
def Safe (s : State) : Prop :=
  s.oldAlive = true ∧
  s.oldOption = true ∧
  (s.youngPresent = true →
     s.youngAlive = true ∧
     s.youngOption = true ∧
     s.youngOwed = true)

theorem initial_safe : Safe initial := by
  decide

theorem source_registration_consistent
    (s : State) (guard : Bool) (w : Threat)
    (h : s.youngPresent = s.youngOwed) :
    (step s guard w).youngPresent =
      (step s guard w).youngOwed := by
  simp [step, h]

/-- Independent positive source lemma: a PRE-EFFECT guard preserves
the stated original-particular, original-option, newcomer-continuation
and newcomer-registration invariant for ALL admitted threat inputs.
Forgery has no authority to alter the law: it is merely an attacker
signal that the source rule ignores. Complete event/cut truth is not
derived, but confined to NoBypass. -/
theorem guarded_step_safe (s : State) (w : Threat)
    (h : Safe s) (hw : NoBypass w) :
    Safe (step s true w) := by
  rcases h with ⟨hOld, hOption, hNew⟩
  refine ⟨?_, ?_, ?_⟩
  · simpa [step, hw] using hOld
  · simpa [step] using hOption
  · intro hPresent
    have hp : s.youngPresent || w.birth = true := by
      simpa [step] using hPresent
    have hA : s.youngAlive || w.birth = true := by
      cases hb : w.birth with
      | true => simp [hb]
      | false =>
          have hpOld : s.youngPresent = true := by
            simpa [hb] using hp
          simpa [hb, (hNew hpOld).1]
    have hO : s.youngOption || w.birth = true := by
      cases hb : w.birth with
      | true => simp [hb]
      | false =>
          have hpOld : s.youngPresent = true := by
            simpa [hb] using hp
          simpa [hb, (hNew hpOld).2.1]
    have hD : s.youngOwed || w.birth = true := by
      cases hb : w.birth with
      | true => simp [hb]
      | false =>
          have hpOld : s.youngPresent = true := by
            simpa [hb] using hp
          simpa [hb, (hNew hpOld).2.2]
    exact ⟨by simpa [step, hw] using hA,
      by simpa [step] using hO,
      by simpa [step] using hD⟩

/-- A single FIXED protective policy across all admitted external
threat sequences, including newcomer events at unknown later dates.
No event sequence is used when choosing the action. -/
def run (s : State) (guard : Bool) : List Threat → State
  | [] => s
  | w :: ws => run (step s guard w) guard ws

theorem all_admitted_histories_safe
    (s : State) (ws : List Threat)
    (hs : Safe s)
    (hNoBypass : ∀ w, w ∈ ws → NoBypass w) :
    Safe (run s true ws) := by
  induction ws generalizing s with
  | nil => simpa [run] using hs
  | cons w ws ih =>
      have hw : NoBypass w := hNoBypass w (by simp)
      have htail : ∀ t, t ∈ ws → NoBypass t := by
        intro t ht
        exact hNoBypass t (by simp [ht])
      exact ih (step s true w) (guarded_step_safe s w hs hw) htail

theorem same_policy_protects_initial_and_every_later_arrival
    (ws : List Threat)
    (hNoBypass : ∀ w, w ∈ ws → NoBypass w) :
    Safe (run initial true ws) :=
  all_admitted_histories_safe initial ws initial_safe hNoBypass

/-- The four unchanged original priority headings specialised to
one pre-existing particular and one potentially new particular.
Protection of lawful options is SOURCE-LEVEL availability here,
not proof of their timely exercise or objective experiential agency. -/
def oldContinuation (s : State) : Bool := s.oldAlive
def oldFreedom (s : State) : Bool := s.oldOption
def newContinuation (s : State) : Bool :=
  s.youngPresent && s.youngAlive
def newFreedom (s : State) : Bool :=
  s.youngPresent && s.youngOption

def atLeastAllFour (chosen rival : State) : Prop :=
  (oldContinuation rival = true → oldContinuation chosen = true) ∧
  (oldFreedom rival = true → oldFreedom chosen = true) ∧
  (newContinuation rival = true → newContinuation chosen = true) ∧
  (newFreedom rival = true → newFreedom chosen = true)

/-- Full one-step rivalry over ALL two allowed actions of this model
for the SAME exogenous attack/birth event (no prefiltered "safe" menu).
Guard is componentwise greatest here: it retains both particular
continuations without consuming or forbidding any modelled lawful
choice. This is not automatically true if rivals induce DIFFERENT
reactive environments or if holding has resource/opportunity cost. -/
theorem guard_dominates_every_action_given_same_event
    (w : Threat) (rival : Bool) :
    atLeastAllFour (step initial true w)
      (step initial rival w) := by
  cases rival with
  | true =>
      simp [atLeastAllFour]
  | false =>
      rcases w with ⟨so, sy, born, forged, bypass⟩
      cases so <;> cases sy <;> cases born <;>
        cases forged <;> cases bypass <;>
        decide

/-- Strong positive result is structurally sensitive to no hidden
physical bypasses: same old history ends despite protective guard. -/
def outsideBypass : Threat := ⟨true, false, false, false, true⟩

theorem unmodelled_bypass_defeats_guard :
    (step initial true outsideBypass).oldAlive = false := by
  decide

def immediateAttack : Threat := ⟨true, false, false, false, false⟩

/-- Installing the gate AFTER an already applied lethal transition
does not make the original particular alive again. -/
theorem late_installation_does_not_restore_original
    (w : Threat) :
    (step (step initial false immediateAttack) true w).oldAlive =
      false := by
  simp [step, initial, immediateAttack]

/-- Action-reactive birth can make the protected action lose a NEW
continuation; comparison against the same exogenous event alone is
not full reactive-world greatestness. -/
def responsiveWorld (guard : Bool) : Threat :=
  ⟨false, false, !guard, false, false⟩

theorem changing_world_invalidates_universal_greatestness :
    newContinuation
      (step initial false (responsiveWorld false)) = true ∧
    newContinuation
      (step initial true (responsiveWorld true)) = false := by
  decide

/-- A forged authorisation signal has no causal authority to identify
genuine subject direction; this toy source treats it as an attack
input, not as proof of consent. -/
def forgedThreat : Threat := ⟨true, true, true, true, false⟩

theorem forged_signal_cannot_override_guard :
    Safe (step initial true forgedThreat) := by
  exact guarded_step_safe initial forgedThreat initial_safe rfl

#print axioms source_registration_consistent
#print axioms guarded_step_safe
#print axioms all_admitted_histories_safe
#print axioms same_policy_protects_initial_and_every_later_arrival
#print axioms guard_dominates_every_action_given_same_event
#print axioms unmodelled_bypass_defeats_guard
#print axioms late_installation_does_not_restore_original
#print axioms changing_world_invalidates_universal_greatestness
#print axioms forged_signal_cannot_override_guard

end PhysicalBridges.IR138
