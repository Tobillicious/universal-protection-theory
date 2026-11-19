import PhysicalBridges.OriginalX3Full

/-!
# Objective Time Koru / strong G-E bridge — independent history interface

This additive module keeps objective time INSIDE the one actuality.
A recorded event persists at every later modeled stage. Thus a local
observer losing access to the record is not objective total erasure.

The strong claim that *any* original-six-X3 failure is absolute E
does NOT follow from retention alone. We make the additional physical
causal-fidelity assertion explicit. The positive join is valid if that
assertion can be proved from native complete-Koru/matterspacetime
dynamics; it is not inserted as a new definition of E.

No existing Koru, original-six, G1/G2 or cosmological definitions change.
No external time, external world, Hilbert space, or proxy duty occurs.
-/

namespace PhysicalBridges.StrongGEObjectiveTimeKoruBridge

open PhysicalBridges.OriginalX3Full

universe u v

/-- One objective actuality with an internal stage-indexed event record.
The two laws represent independently evidenced event admission and
history retention. They are not a claim about all physical events. -/
structure ObjectiveHistory (Event : Type u) where
  actual : Event → Prop
  recorded : Nat → Event → Prop
  actual_recorded : ∀ e, actual e → recorded 0 e
  retained : ∀ n e, recorded n e → recorded (n + 1) e

/-- Any actual event remains represented in the objective record at
every finite internal stage: no outside observer is needed. -/
theorem actual_record_persists {Event : Type u}
    (H : ObjectiveHistory Event) (e : Event) (he : H.actual e) :
    ∀ n : Nat, H.recorded n e := by
  intro n
  induction n with
  | zero => exact H.actual_recorded e he
  | succ n ih => exact H.retained n e ih

/-- The strong total-ending event claims its own occurrence is actual
and simultaneously claims there are no actual events. -/
def AbsoluteE {Event : Type u}
    (H : ObjectiveHistory Event) (e : Event) : Prop :=
  H.actual e ∧ ∀ a, ¬ H.actual a

theorem no_realized_absolute_E {Event : Type u}
    (H : ObjectiveHistory Event) (e : Event) :
    ¬ AbsoluteE H e := by
  rintro ⟨he, hall⟩
  exact hall e he

/-- A nonempty actual event rules out total erasure of the accumulated
record at every internal stage, not just at a chosen future index. -/
theorem actual_event_refutes_total_record_erasure {Event : Type u}
    (H : ObjectiveHistory Event) (e : Event) (he : H.actual e) :
    ∀ n : Nat, ¬ (∀ a, ¬ H.recorded n a) := by
  intro n hNoRecords
  exact hNoRecords e (actual_record_persists H e he n)

/-- Full original-X3 preservation is a separate source/subject claim.
The causal bridge states that a genuine original-X3 failure would make
the enacted event's own objective record unrecoverable at the next
stage. The contradiction with retention completes the requested join,
but deriving THIS causal bridge from physical dynamics is essential.
A recorded injury is an explicit possible countercase to its premise. -/
theorem original_six_from_objective_record_and_causal_fidelity
    {S : Type u} {P : Type v}
    (H : ObjectiveHistory (S × S))
    (step : S → S → Prop)
    (owed : S → S → P → Prop)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (hPhysical : ∀ s t, step s t → H.actual (s, t))
    (hCausalFailure :
      ∀ s t p, step s t → owed s t p →
        ¬ OriginalX3 cont auth free restr maxl prov s t p →
        ¬ H.recorded 1 (s, t)) :
    ∀ s t p, step s t → owed s t p →
      OriginalX3 cont auth free restr maxl prov s t p := by
  intro s t p hs hp
  classical
  apply Classical.byContradiction
  intro hViolation
  have hActual : H.actual (s, t) := hPhysical s t hs
  have hRecord : H.recorded 1 (s, t) :=
    actual_record_persists H (s, t) hActual 1
  exact (hCausalFailure s t p hs hp hViolation) hRecord

/-- Concrete diagnostic: an actual local event with a true local
E-label can coexist with a nonempty complete objective history.
Calling the event E does not make it absolute E. This is NOT an
empirical example of harm or a full BCRD model. -/
def diagnosticHistory : ObjectiveHistory Unit where
  actual := fun _ => True
  recorded := fun _ _ => True
  actual_recorded := by
    intro _ _
    trivial
  retained := by
    intro _ _ _
    trivial

theorem local_E_label_does_not_imply_absolute_E :
    diagnosticHistory.actual () ∧
    (True : Prop) ∧
    ¬ AbsoluteE diagnosticHistory () := by
  exact ⟨trivial, trivial,
    no_realized_absolute_E diagnosticHistory ()⟩

#print axioms actual_record_persists
#print axioms no_realized_absolute_E
#print axioms actual_event_refutes_total_record_erasure
#print axioms original_six_from_objective_record_and_causal_fidelity
#print axioms local_E_label_does_not_imply_absolute_E

end PhysicalBridges.StrongGEObjectiveTimeKoruBridge
