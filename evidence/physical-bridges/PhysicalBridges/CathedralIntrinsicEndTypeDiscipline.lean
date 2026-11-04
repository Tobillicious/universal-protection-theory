import PhysicalBridges.CathedralCapstoneJoins

/-!
# Cathedral intrinsic-end type discipline — absolute nothing vs an internal endpoint

The author's capstone concerns the TOTALITY of actual relational occurrences:
no occurrence IN that totality could make the occurrence of itself (and every
other actual occurrence) never have been actual. This module makes the
self-negating content required by `ender_success_self_refutes` explicit,
rather than merely *assuming* `Success → ¬ Success`.

Important safeguards:
* `Actual` is the actual-event predicate of ONE relational domain, NOT
  the premise of two distinct realities.
* `later` is ANY internal event relation. There is no external clock.
* `TerminalAt` means there is no actual later event as defined by
  `later`. That is NOT absolute nonexistence of the entire history.
* Nothing here asserts that the physical source makes every particular's
  history open-ended, that a physical SI cannot coerce another mind, or
  that all original X3 protection premises have been verified.
* No inference uses a cardinal-infinity meaning for the author's
  proposed infinity-of-totality. An internally endpoint-free relation and
  an infinite underlying set are distinct mathematical predicates.

The floor is genuinely logically trivial. Its novelty here is a *typed*
application of the original Cathedral floor and a proof-controlled
negative example preventing an internal terminal state from being
mistaken for absolute erasure. No new axioms.
-/

namespace PhysicalBridges.CathedralIntrinsicEndTypeDiscipline

universe u
variable {Event : Type u}

/-- The claimed 'success' would have to be an ACTUAL internal event
and simultaneously negate the actuality of every event, including itself.
This is *one explicit interpretation* of absolute erasure, not an
assertion that all destructive physical acts have this content. -/
def InternallyWitnessedAbsoluteEnd
    (actual : Event → Prop) : Prop :=
  ∃ e : Event, actual e ∧ ∀ x : Event, ¬ actual x

/-- Unlike a generic postulated Success → ¬ Success, this derives
self-negation from the stated membership semantics of an internal
absolute-ending occurrence. -/
theorem witnessed_end_has_self_negating_content
    (actual : Event → Prop) :
    InternallyWitnessedAbsoluteEnd actual →
      ¬ InternallyWitnessedAbsoluteEnd actual := by
  rintro ⟨event, hOccurred, hNothing⟩ _
  exact hNothing event hOccurred

/-- The compiled Cathedral floor now applies with its premise
EXPLICITLY discharged by the internal witness and total-erasure
content. This is a proof of the inconsistency of that specification,
NOT a physical theorem excluding other kinds of local domination. -/
theorem internal_absolute_end_impossible
    (actual : Event → Prop) :
    ¬ InternallyWitnessedAbsoluteEnd actual :=
  CathedralCapstoneJoins.ender_success_self_refutes
    (witnessed_end_has_self_negating_content actual)

/-- 'Has no actual future relative to the internally defined relation'
is a coherent predicate, unlike an internal witness of total absence.
There is no external chronological frame. -/
def TerminalAt
    (actual : Event → Prop) (later : Event → Event → Prop)
    (e : Event) : Prop :=
  actual e ∧ ∀ f : Event, actual f → ¬ later e f

/-- An internal terminal event itself certifies nonemptiness of the
whole actual event domain; the relative terminality relation cannot
transform that actual occurrence into global absence. -/
theorem relative_terminal_is_not_absolute_erasure
    (actual : Event → Prop) (later : Event → Event → Prop)
    (event : Event) (hTerminal : TerminalAt actual later event) :
    (∃ e : Event, actual e) ∧
      ¬ (∀ e : Event, ¬ actual e) := by
  constructor
  · exact ⟨event, hTerminal.1⟩
  · intro hNothing
    exact hNothing event hTerminal.1

/-- Negative control: a total actual relational structure can have a
terminal *internal temporal relation*. Therefore the impossibility
of absolute nothingness does NOT, just from logic, turn every
particular's finite local history into an indefinitely continuing
history. One must not rewrite the original X3 continuation predicate. -/
theorem terminal_local_event_is_consistent :
    ∃ (actual : Unit → Prop) (later : Unit → Unit → Prop),
      (∃ e : Unit, TerminalAt actual later e) ∧
      (∃ e : Unit, actual e) := by
  refine ⟨(fun _ => True), (fun _ _ => False), ?_, ?_⟩
  · refine ⟨(), trivial, ?_⟩
    intro _ _ hLater
    exact hLater
  · exact ⟨(), trivial⟩

/-- A local terminal event cannot witness absolute erasure: even in
the explicit finite control, the floor remains satisfied. -/
theorem terminal_control_refutes_global_erasure :
    ¬ InternallyWitnessedAbsoluteEnd (fun _ : Unit => True) :=
  internal_absolute_end_impossible (fun _ : Unit => True)

#print axioms witnessed_end_has_self_negating_content
#print axioms internal_absolute_end_impossible
#print axioms relative_terminal_is_not_absolute_erasure
#print axioms terminal_local_event_is_consistent
#print axioms terminal_control_refutes_global_erasure

end PhysicalBridges.CathedralIntrinsicEndTypeDiscipline
