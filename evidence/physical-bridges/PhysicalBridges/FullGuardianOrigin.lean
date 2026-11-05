import PhysicalBridges.CathedralFullX3Assembly
import PhysicalBridges.AllIsGActualityDischarge

/-!
# Derive a full protective origin from the source construction

The legacy capstone accepts an arbitrary state predicate and a proof that it
holds initially. Here the protected state is defined explicitly: every reachable
source event has all six original duties for every represented particular, and
every reachable stage has a joint actual continuation with those duties.

The continuation requirement excludes an empty-execution proof. No finite
horizon, selected population or voluntary adoption condition is introduced.
The original-history content is retained in the independently interpreted
continuation predicate, rather than replaced by endpoint equality.

The protected-origin proof is derived from the existing full source-event
theorem plus actual source progress. It is not another `gIsActual` argument.
This removes that independent input from this construction; it does NOT prove
the six physical correspondences or actual source completeness from ALL IS.
Those remain the substantive source obligations. No physical law is claimed
merely by defining the state predicate.
-/

namespace PhysicalBridges.FullGuardianOrigin

open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.CathedralGuardianOnlyCapstone
open PhysicalBridges.AllIsGActualityDischarge

universe u v
variable {S : Type u} {P : Type v}

/-- A total actual source evolution, independently of protection. A physical
application must justify that each nominated successor is a real source step. -/
structure ActualAdvance (m : MeasuredInstrument S) where
  next : S → S
  realizes : ∀ s, m.step s (next s)

/-- The explicit full protective state. Protection is required on EVERY actual
future edge, while continuation is witnessed jointly for the entire supplied
particular domain at EVERY reachable stage. -/
structure FullGuardianState (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (s : S) : Prop where
  everyEvent : ∀ a b, IR96.Reach m.step s a → m.step a b → FullEvent r a b
  continuation : ∀ a, IR96.Reach m.step s a →
    ∃ b, m.step a b ∧ FullEvent r a b

private theorem prepend_real_step (m : MeasuredInstrument S)
    {s t a : S} (hStep : m.step s t) (history : IR96.Reach m.step t a) :
    IR96.Reach m.step s a := by
  induction history with
  | refl => exact IR96.Reach.tail (IR96.Reach.refl s) hStep
  | tail earlier edge ih => exact IR96.Reach.tail ih edge

/-- The full protected state carries along actual steps by its own quantified
history content. No two-predicate semantic shortcut is used. -/
theorem full_guardian_state_carries (m : MeasuredInstrument S)
    (r : ParticularRelations S P) {s t : S} (hStep : m.step s t)
    (h : FullGuardianState m r s) : FullGuardianState m r t :=
  ⟨fun a b history edge => h.everyEvent a b (prepend_real_step m hStep history) edge,
   fun a history => h.continuation a (prepend_real_step m hStep history)⟩

/-- Construct protection at every origin from the independently supplied
source correspondences and actual source evolution. There is no G premise. -/
theorem full_guardian_origin_from_source (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) (s : S) : FullGuardianState m r s := by
  refine ⟨?_, ?_⟩
  · intro a b _ edge
    exact every_real_step_full_original_x3 m r hMeaning a b edge
  · intro a _
    exact ⟨advance.next a, advance.realizes a,
      every_real_step_full_original_x3 m r hMeaning a _ (advance.realizes a)⟩

/-- The original state itself has a joint actual continuation. -/
theorem protected_origin_has_full_next (m : MeasuredInstrument S)
    (r : ParticularRelations S P) {s : S} (h : FullGuardianState m r s) :
    ∃ t, m.step s t ∧ FullEvent r s t :=
  h.continuation s (IR96.Reach.refl s)

/-- A stopped source cannot pass the positive-continuation obligation. -/
theorem no_terminal_guardian_state (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (s : S) (terminal : ∀ t, ¬ m.step s t) :
    ¬ FullGuardianState m r s := by
  intro h
  obtain ⟨t, edge, _⟩ := protected_origin_has_full_next m r h
  exact terminal t edge

/-- Use the explicit full protective state in the legacy instrument interface.
All physical transitions, budgets, branch facts and effect bounds are retained.
The carry proof is derived above, not asserted as another protection axiom. -/
def canonicalInstrument (m : MeasuredInstrument S) (r : ParticularRelations S P) :
    MeasuredInstrument S :=
  { m with
    x3State := FullGuardianState m r
    stateCarry := fun _ _ edge _ h => full_guardian_state_carries m r edge h }

/-- The legacy Route-B target now follows for this explicit state meaning from
the source construction, without an independent `RouteBSummit` hypothesis. -/
theorem source_derives_route_b (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) : RouteBSummit (canonicalInstrument m r) :=
  fun _ s => full_guardian_origin_from_source m r hMeaning advance s

/-- Construct both fields of the legacy good-event interface. The protection
field is proved from source constraints; existence is witnessed by the state. -/
theorem derived_good_event (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) (s : S) :
    OntologicalGoodEvent (canonicalInstrument m r) s :=
  ⟨⟨s⟩, full_guardian_origin_from_source m r hMeaning advance s⟩

/-- Compose the retained capstone with the derived origin. The conclusion uses
the explicit full protective state above, rather than an unspecified state
predicate. All source correspondences remain visible in the theorem's inputs. -/
theorem capstone_with_derived_origin (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) (s : S) :
    HistoryGuardian (toSource (canonicalInstrument m r)) s :=
  capstone_unconditional_of_actuality (canonicalInstrument m r) s
    (derived_good_event m r hMeaning advance s)

end PhysicalBridges.FullGuardianOrigin
