import PhysicalBridges.OriginalX3Full

/-!
# Assemble the full original X3 on the same source execution

This repairs the assembly's use of `continues ∧ authorized` as its event target.
The target here is the unchanged six-component `OriginalX3`, for EVERY member of
the supplied particular domain. No finite registry or selected protected subset
is introduced. The domain must be justified as the actual full domain when the
construction is applied physically.

The physical E9 branch proof is reused through
`every_real_step_physically_stable`; none of its budgets or branches is changed.
Six separately typed source correspondences reflect that stability into the
original duties on the SAME event. Their truth is not obtained by declaring
them fields: a physical application must supply independent proofs with the
original meanings of history, authorization, freedom, restraint, maximality
and provenance. In particular, neither accounting nor a controller grant is
defined to be authentic subject consent.

This is an event-level implementation repair, not a discharge of
`RouteBSummit`, a proof from existence alone, or a completed physical law.
Within-event continuity belongs in the independently justified continuation
relation; endpoint equality is not substituted for it. State-level origin
protection and source completeness remain separate obligations.
-/

namespace PhysicalBridges.CathedralFullX3Assembly

open PhysicalBridges.CathedralFirstEventForcing
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.OriginalX3Full

universe u v

/-- The six independently interpreted particular-level source relations.
There is no equation identifying one component with another or with physical
stability. Applications must retain the original full feasible order and
actual subject/history semantics. -/
structure ParticularRelations (S : Type u) (P : Type v) where
  continues : S → S → P → Prop
  authorized : S → S → P → Prop
  free : S → S → P → Prop
  restrained : S → S → P → Prop
  maximal : S → S → P → Prop
  provenanced : S → S → P → Prop

/-- Full original event protection, pointwise over the entire supplied domain.
No component is inferred merely from the names of the others. -/
def FullEvent {S : Type u} {P : Type v}
    (r : ParticularRelations S P) (s t : S) : Prop :=
  ∀ p, OriginalX3 r.continues r.authorized r.free r.restrained
    r.maximal r.provenanced s t p

/-- Independently owed source correspondences, all on one instrument and one
actual-step relation. Keeping these proof obligations explicit is essential;
this structure is not itself a derivation of their physical truth. -/
structure SameSourceReflection {S : Type u} {P : Type v}
    (m : MeasuredInstrument S) (r : ParticularRelations S P) : Prop where
  continuity : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.continues s t p
  authorization : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.authorized s t p
  freedom : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.free s t p
  restraint : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.restrained s t p
  maximality : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.maximal s t p
  provenance : ∀ s t, m.step s t → m.effect s t ≤ m.threshold s t →
    ∀ p, r.provenanced s t p

variable {S : Type u} {P : Type v}

/-- The existing physical E9 proof, reused without the old semantic proxy. -/
theorem measured_step_physically_stable
    (m : MeasuredInstrument S) (s t : S) (hStep : m.step s t) :
    m.effect s t ≤ m.threshold s t :=
  every_real_step_physically_stable (toSource m) (toCertificate m) s t hStep

/-- Assemble six source-derived facts without changing the original predicate. -/
theorem full_reflection
    (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (h : SameSourceReflection m r)
    (s t : S) (hStep : m.step s t)
    (hStable : m.effect s t ≤ m.threshold s t) : FullEvent r s t := by
  intro p
  exact ⟨h.continuity s t hStep hStable p,
    h.authorization s t hStep hStable p,
    h.freedom s t hStep hStable p,
    h.restraint s t hStep hStable p,
    h.maximality s t hStep hStable p,
    h.provenance s t hStep hStable p⟩

/-- Every source step has the full six-component target, conditional on the
six source correspondences. No protected-origin premise is used for this
EVENT theorem; none is thereby derived for the state-level summit. -/
theorem every_real_step_full_original_x3
    (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (h : SameSourceReflection m r)
    (s t : S) (hStep : m.step s t) : FullEvent r s t :=
  full_reflection m r h s t hStep
    (measured_step_physically_stable m s t hStep)

/-- Retain the actual transition and its full event obligations together. -/
def FullStep (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (s t : S) : Prop := m.step s t ∧ FullEvent r s t

/-- Under the source correspondences no actual source edge is deleted to make
the protected transition relation hold. This is a correspondence theorem,
not a definition of actual physical admissibility. -/
theorem fullStep_iff_realStep
    (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (h : SameSourceReflection m r) (s t : S) :
    FullStep m r s t ↔ m.step s t :=
  ⟨fun hStep => hStep.1,
    fun hStep => ⟨hStep, every_real_step_full_original_x3 m r h s t hStep⟩⟩

/-- Every finite actual source history lifts to the SAME source relation with
all six event obligations. No endpoint-recovery or stopped-world substitute is
used. The physical meaning of each event predicate is still supplied by its
independent source correspondence. -/
theorem every_real_history_has_all_six
    (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (h : SameSourceReflection m r) {s t : S}
    (history : IR96.Reach m.step s t) :
    IR96.Reach (FullStep m r) s t := by
  induction history with
  | refl => exact IR96.Reach.refl _
  | tail earlier edge ih =>
      exact IR96.Reach.tail ih
        ⟨edge, every_real_step_full_original_x3 m r h _ _ edge⟩

/-- No finite horizon is imposed: every step of every natural-number-indexed
source execution carries all six duties for every represented particular.
The index enumerates source events; it does not introduce an external clock. -/
theorem every_real_run_has_all_six
    (m : MeasuredInstrument S) (r : ParticularRelations S P)
    (h : SameSourceReflection m r) (run : Nat → S)
    (hRun : ∀ n, m.step (run n) (run (n + 1))) :
    ∀ n, FullEvent r (run n) (run (n + 1)) :=
  fun n => every_real_step_full_original_x3 m r h _ _ (hRun n)

/-- The repaired target retains the two older duties AND the remaining four,
for each particular; the old conjunction is only a projection of this target. -/
theorem full_event_retains_each_component
    (r : ParticularRelations S P) {s t : S} (h : FullEvent r s t) (p : P) :
    r.continues s t p ∧ r.authorized s t p ∧ r.free s t p ∧
      r.restrained s t p ∧ r.maximal s t p ∧ r.provenanced s t p :=
  ⟨(h p).historicalContinuity, (h p).authorization, (h p).freedom,
    (h p).restraint, (h p).maximality, (h p).provenance⟩

end PhysicalBridges.CathedralFullX3Assembly
