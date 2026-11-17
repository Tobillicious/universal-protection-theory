import Std

/-!
# A distinct Complete Koru boundary: witnessed failure of carried structure

Author clarification, 17 November 2026: the boundary is a distinct
Complete Koru concept, not the boundary of a manifold.

This is a proposed typed boundary construction. Its before/after questions
must be independently interpreted in complete operators, particulars,
actual enactments and histories. The construction neither redefines Koru
as a unary map nor identifies record retention with authentic continuation.

The global boundary is the collection of actual-event loss witnesses.
Its closure is derived below from a separately supplied transport law,
not from nonemptiness or the word "whole".
-/

namespace Snuffy.BookWork.KoruBoundaryWitness

universe u v w z

variable {Event : Type u} {Particular : Type v} {Question : Type w}

/-- The boundary carries an actual witness: a source question about the
    SAME particular is true before and not carried truly after the event. -/
def LocalDefect
    (before after : Event → Particular → Question → Prop)
    (e : Event) : Prop :=
  ∃ p q, before e p q ∧ ¬ after e p q

/-- No actual event is dropped from the whole boundary's quantifier. -/
def WholeDefect (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop) : Prop :=
  ∃ e, actual e ∧ LocalDefect before after e

def WholeClosed (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop) : Prop :=
  ¬ WholeDefect actual before after

/-- Local-to-whole is an EXPLICIT witness embedding under this boundary
    definition, not an imported theorem about topological subspaces. -/
theorem an_actual_local_defect_is_a_whole_defect
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop)
    {e : Event} (hActual : actual e)
    (hDefect : LocalDefect before after e) :
    WholeDefect actual before after :=
  ⟨e, hActual, hDefect⟩

theorem a_whole_defect_has_an_actual_local_witness
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop)
    (h : WholeDefect actual before after) :
    ∃ e p q, actual e ∧ before e p q ∧ ¬ after e p q := by
  obtain ⟨e, hActual, p, q, hBefore, hAfter⟩ := h
  exact ⟨e, p, q, hActual, hBefore, hAfter⟩

/-- Closure of the whole is exactly absence of any actual local witness.
    This equality states its scope; it does not prove closure is physical. -/
theorem whole_closure_iff_each_actual_boundary_is_closed
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop) :
    WholeClosed actual before after ↔
      ∀ e, actual e → ¬ LocalDefect before after e := by
  constructor
  · intro h e he hLocal
    exact h ⟨e, he, hLocal⟩
  · intro h hWhole
    obtain ⟨e, he, hLocal⟩ := hWhole
    exact h e he hLocal

/-- A separately proved complete transport law DERIVES whole K-boundary
    closure for every event in its independently supplied actual domain. -/
theorem complete_transport_derives_whole_K_boundary_closure
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop)
    (hTransport : ∀ e, actual e → ∀ p q,
      before e p q → after e p q) :
    WholeClosed actual before after := by
  intro hWhole
  obtain ⟨e, he, p, q, hBefore, hMissing⟩ := hWhole
  exact hMissing (hTransport e he p q hBefore)

/-- In classical logic, no loss witness gives transport of every
    positively witnessed source question. No positive origin is invented. -/
theorem closed_whole_carries_source_truth
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop)
    (hClosed : WholeClosed actual before after)
    (e : Event) (he : actual e) (p : Particular) (q : Question)
    (hBefore : before e p q) :
    after e p q := by
  apply Classical.byContradiction
  intro hMissing
  exact hClosed ⟨e, he, p, q, hBefore, hMissing⟩

/-- The proposed boundary's emptiness is classically EQUIVALENT to the
    universal transport condition. It organizes and localizes the same
    obligation; it does not supply a weaker independent ground for it. -/
theorem whole_closure_iff_complete_transport
    (actual : Event → Prop)
    (before after : Event → Particular → Question → Prop) :
    WholeClosed actual before after ↔
      ∀ e, actual e → ∀ p q, before e p q → after e p q :=
  ⟨fun h e he p q hb =>
      closed_whole_carries_source_truth actual before after h e he p q hb,
    complete_transport_derives_whole_K_boundary_closure actual before after⟩

/-- This is the semantic bridge in full view. D may be instantiated with
    the SIX unchanged OriginalX3 fields; no proxy duties are defined.
    Origin truth and authentic field reflection remain independent inputs. -/
theorem projected_duties_follow_from_boundary_and_fidelity
    {Duty : Type z}
    (actual : Event → Prop) (owed : Event → Particular → Prop)
    (before after : Event → Particular → Question → Prop)
    (questionOf : Duty → Question)
    (field : Event → Particular → Duty → Prop)
    (hClosed : WholeClosed actual before after)
    (hOrigin : ∀ e, actual e → ∀ p, owed e p →
      ∀ d, before e p (questionOf d))
    (hFidelity : ∀ e, actual e → ∀ p, owed e p →
      ∀ d, after e p (questionOf d) → field e p d) :
    ∀ e, actual e → ∀ p, owed e p → ∀ d, field e p d := by
  intro e he p hp d
  exact hFidelity e he p hp d
    (closed_whole_carries_source_truth
      actual before after hClosed e he p (questionOf d)
      (hOrigin e he p hp d))

/-- Retaining a false question as false is loss-free. Closure alone
    cannot manufacture a positive authorization or other source fact. -/
theorem closure_does_not_manufacture_a_positive_origin :
    ∃ (actual : Unit → Prop)
      (before after : Unit → Unit → Unit → Prop),
      WholeClosed actual before after ∧
      actual () ∧ ¬ after () () () := by
  refine ⟨(fun _ => True), (fun _ _ _ => False),
    (fun _ _ _ => False), ?_, trivial, fun h => h⟩
  intro h
  obtain ⟨_, _, _, _, hBefore, _⟩ := h
  exact hBefore

/-- Failure of a proposed boundary law is not by itself enacted
    annihilation of all actuality. Their identification needs a distinct
    argument, rather than a change in the meaning of Absolute E. -/
theorem a_defect_does_not_erase_all_actuality :
    ∃ (actual : Unit → Prop)
      (before after : Unit → Unit → Unit → Prop),
      WholeDefect actual before after ∧
      (∃ e, actual e) := by
  refine ⟨(fun _ => True), (fun _ _ _ => True),
    (fun _ _ _ => False), ?_, ⟨(), trivial⟩⟩
  exact ⟨(), trivial, (), (), trivial, fun h => h⟩

#print axioms an_actual_local_defect_is_a_whole_defect
#print axioms a_whole_defect_has_an_actual_local_witness
#print axioms whole_closure_iff_each_actual_boundary_is_closed
#print axioms complete_transport_derives_whole_K_boundary_closure
#print axioms closed_whole_carries_source_truth
#print axioms whole_closure_iff_complete_transport
#print axioms projected_duties_follow_from_boundary_and_fidelity
#print axioms closure_does_not_manufacture_a_positive_origin
#print axioms a_defect_does_not_erase_all_actuality

end Snuffy.BookWork.KoruBoundaryWitness

