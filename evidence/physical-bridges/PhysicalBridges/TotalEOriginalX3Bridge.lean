import PhysicalBridges.OriginalX3Full

/-!
# TOTAL E -> original six-X3: exact theorem and minimal independence control

This is the user's maximal bridge, stated without changing the full six-duty
OriginalX3 target. The key premise says: any ACTUAL step violating one owed
particular's original X3 realizes Absolute E.

The theorem shows exactly why that premise would finish the proof. It also
shows the total-E bridge is LOGICALLY EQUIVALENT to excluding actual violations
when Absolute E has its original impossible meaning (the enacted event itself
must cease to be actual). Consequently the bridge cannot be inferred from
"there is no absolute erasure" alone.

A two-cycle reversible mathematical toy with a fixed unconsenting particular
is an independence test for the bare ontology / reversible-dynamics inference.
It is NOT a BCRD-complete source model or evidence of an actual harmful event.
Do not replace the maximal thesis, rewrite X3, or promote the bridge to a
physical fact without independently deriving it.
-/

namespace PhysicalBridges.TotalEOriginalX3Bridge

open PhysicalBridges.OriginalX3Full

universe u v
variable {Event : Type u} {Particular : Type v}

/-- The strongest E: an enacted event is actual, but absolutely no event is.
Its own occurrence contradicts its claimed realized result. -/
def AbsoluteE (actual : Event → Prop) (e : Event) : Prop :=
  actual e ∧ ∀ a, ¬ actual a

/-- This impossibility is independent of X3: Absolute E negates its own
occurrence, including the actual event witnessing it. -/
theorem no_absolute_E (actual : Event → Prop) (e : Event) :
    ¬ AbsoluteE actual e := by
  rintro ⟨hEvent, hNothing⟩
  exact hNothing e hEvent

/-- An ACTUAL loss of ANY independently interpreted particular-level duty. -/
def ActualX3Violation
    (actual : Event → Prop)
    (owed x3 : Event → Particular → Prop) (e : Event) : Prop :=
  actual e ∧ ∃ p, owed e p ∧ ¬ x3 e p

/-- Exact logical content of "every X3-violating E is Absolute E":
because Absolute E is impossible, this is EQUIVALENT to no violation.
This equivalence does NOT derive either side from bare actuality. -/
theorem total_E_bridge_iff_no_actual_x3_violation
    (actual : Event → Prop)
    (owed x3 : Event → Particular → Prop) :
    (∀ e, ActualX3Violation actual owed x3 e → AbsoluteE actual e) ↔
    (∀ e, ¬ ActualX3Violation actual owed x3 e) := by
  constructor
  · intro bridge e hViolation
    exact no_absolute_E actual e (bridge e hViolation)
  · intro noViolation e hViolation
    exact False.elim (noViolation e hViolation)

/-- Positive reductio: if the *independently proved* total-E reflection
covers each original-X3 violation, all six original duties hold on every
actual step for every owed particular. NO component is discarded. -/
theorem six_original_x3_from_total_E
    {S : Type u} {P : Type v}
    (step : S → S → Prop) (owed : S → S → P → Prop)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (hTotal :
      ∀ s t, step s t →
        (∃ p, owed s t p ∧
          ¬ OriginalX3 cont auth free restr maxl prov s t p) →
          AbsoluteE (fun e : S × S => step e.1 e.2) (s, t)) :
    ∀ s t p, step s t → owed s t p →
      OriginalX3 cont auth free restr maxl prov s t p := by
  classical
  intro s t p hStep hOwed
  by_contra hViolation
  exact no_absolute_E
    (fun e : S × S => step e.1 e.2) (s, t)
    (hTotal s t hStep ⟨p, hOwed, hViolation⟩)

/-- The six-duty physical target is logically equivalent to its total-E
reflection, not a stronger free consequence of the no-exteriority premise. -/
theorem six_original_x3_iff_total_E_bridge
    {S : Type u} {P : Type v}
    (step : S → S → Prop) (owed : S → S → P → Prop)
    (cont auth free restr maxl prov : S → S → P → Prop) :
    (∀ s t, step s t →
      (∃ p, owed s t p ∧
        ¬ OriginalX3 cont auth free restr maxl prov s t p) →
        AbsoluteE (fun e : S × S => step e.1 e.2) (s, t)) ↔
    (∀ s t p, step s t → owed s t p →
      OriginalX3 cont auth free restr maxl prov s t p) := by
  constructor
  · intro h
    exact six_original_x3_from_total_E step owed
      cont auth free restr maxl prov h
  · intro h s t hStep hViolation
    obtain ⟨p, hOwed, hNotX3⟩ := hViolation
    exact False.elim (hNotX3 (h s t p hStep hOwed))

/-! ## Independent cyclic/reversible mathematical actuality control.

A world state has a changing bit and an independent consent bit. The reversible,
two-period dynamics flips the first bit while leaving the second unchanged.
The affected particular's authorization is genuinely false when consent=false.
All other X3 components in this CONTROL are true. That isolates precisely
the original authorization obligation rather than redefining X3.
-/

abbrev CycleState := Bool × Bool

def cycleFlip (s : CycleState) : CycleState :=
  (!s.1, s.2)

def cycleStep (s t : CycleState) : Prop :=
  t = cycleFlip s

theorem cycle_is_reversible (s : CycleState) :
    cycleStep s (cycleFlip s) ∧
      cycleStep (cycleFlip s) s := by
  constructor
  · rfl
  · cases s with
    | mk bit consent =>
      cases bit <;> cases consent <;> rfl

def cycleOtherDuty (_ _ : CycleState) (_ : Unit) : Prop := True

def cycleAuthorization (s _ : CycleState) (_ : Unit) : Prop :=
  s.2 = true

def cycleOriginalX3 (s t : CycleState) (p : Unit) : Prop :=
  OriginalX3 cycleOtherDuty cycleAuthorization
    cycleOtherDuty cycleOtherDuty cycleOtherDuty cycleOtherDuty s t p

def cycleOrigin : CycleState := (false, false)

theorem cycle_origin_violates_original_x3 :
    ¬ cycleOriginalX3 cycleOrigin (cycleFlip cycleOrigin) () := by
  intro h
  have hAuth : (false : Bool) = true := h.authorization
  cases hAuth

def cycleEventActual (e : CycleState × CycleState) : Prop :=
  cycleStep e.1 e.2

def cycleAllOwed (_ _ : CycleState) (_ : Unit) : Prop :=
  True

/-- A completely internal, nonempty, two-period, reversible mathematical
world can have an actual unauthorized step, without absolute annihilation.
This refutes only the deduction from those WEAK premises, not the author's
proposed stronger complete BCRD/ALL IS physical ontology. -/
theorem cyclic_reversible_world_does_not_force_full_x3 :
    (∀ e : CycleState × CycleState, ¬ AbsoluteE cycleEventActual e) ∧
    (∀ s : CycleState,
      cycleStep s (cycleFlip s) ∧ cycleStep (cycleFlip s) s) ∧
    (∃ (s t : CycleState) (p : Unit),
      cycleStep s t ∧ cycleAllOwed s t p ∧ ¬ cycleOriginalX3 s t p) := by
  refine ⟨?_, cycle_is_reversible, ?_⟩
  · intro e
    exact no_absolute_E cycleEventActual e
  · exact ⟨cycleOrigin, cycleFlip cycleOrigin, (), rfl,
        trivial, cycle_origin_violates_original_x3⟩

#print axioms no_absolute_E
#print axioms total_E_bridge_iff_no_actual_x3_violation
#print axioms six_original_x3_from_total_E
#print axioms six_original_x3_iff_total_E_bridge
#print axioms cycle_is_reversible
#print axioms cycle_origin_violates_original_x3
#print axioms cyclic_reversible_world_does_not_force_full_x3

end PhysicalBridges.TotalEOriginalX3Bridge
