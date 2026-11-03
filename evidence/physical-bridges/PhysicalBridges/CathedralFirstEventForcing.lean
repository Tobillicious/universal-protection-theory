import PhysicalBridges.IR96DisturbanceSimulation

/-!
CATHEDRAL FIRST-EVENT FORCING — keeper/ender exhaustive classification
joined to the separately charged finite E9 intervention trichotomy.

The no-middle-ground classification is not weakened. It is explicitly
about every ACTUAL physical event in one intrinsic source domain,
without an ontological exterior or a second universe.

Unlike the existing ultimate-ender impossibility floor, this theorem
targets the FIRST physically realised event itself, including the
whole within-event subject/history condition. An ender edge is either
recoverable, intercepted before the irreversible boundary, or a
coherent injection barred by a strict work budget.

The three event cases are NOT assumed to be protective by their names:
each has an independently supplied source-response certificate.
A separately validated semantic bridge is still needed to reflect a
physical proxy into original-X3 particular-level history protection.

This is a CONDITIONAL formal join, NOT a derivation of sensor specs,
a universal BCRD source, real subject identity or real-world original
X3 forcing. No unpublished evidence or X3 relaxation is introduced.
-/

namespace PhysicalBridges.CathedralFirstEventForcing

universe u
variable {S : Type u}

/-- One intrinsic physical system. The source labels for keeper and
ender events are distinct from actual physical reachability.
No ontology or source semantics are built into these field names. -/
structure IntrinsicEventSource (S : Type u) where
  realStep : S → S → Prop
  keeper : S → S → Prop
  ender : S → S → Prop
  recoverable : S → S → Prop
  intercepted : S → S → Prop
  coherent : S → S → Prop
  coherentPowerFenced : S → S → Prop
  physicalStable : S → S → Prop
  originalX3Event : S → S → Prop
  originalX3State : S → Prop
  detectionLatency : S → S → Nat
  irreversibleDeadline : S → S → Nat
  requiredWork : S → S → Nat
  availableWork : S → S → Nat

/-- The actual admissibility and charge bridge. Each obligation is
separate and independently auditable. In particular,
   classifies:  keeper OR ender for each ACTUAL step;
   e9Covers:   any actual ender step satisfies one E9 branch;
   reflection: a measured stable source step implies FULL original
               per-particular event-level protection.
The latter remains a physical/semantic obligation and is NOT an
identity or redefinition of X3. -/
structure FirstEventCertificate (w : IntrinsicEventSource S) : Prop where
  noMiddle :
    ∀ s t, w.realStep s t → w.keeper s t ∨ w.ender s t
  exclusive :
    ∀ s t, w.realStep s t →
      ¬ (w.keeper s t ∧ w.ender s t)
  keeperStable :
    ∀ s t, w.realStep s t → w.keeper s t → w.physicalStable s t
  e9Covers :
    ∀ s t, w.realStep s t → w.ender s t →
      w.recoverable s t ∨ w.intercepted s t ∨ w.coherent s t
  refreshStable :
    ∀ s t, w.realStep s t → w.recoverable s t →
      w.physicalStable s t
  detectionBeforeDeadline :
    ∀ s t, w.realStep s t → w.intercepted s t →
      w.detectionLatency s t < w.irreversibleDeadline s t
  timelyInterlockStable :
    ∀ s t, w.realStep s t → w.intercepted s t →
      w.detectionLatency s t < w.irreversibleDeadline s t →
      w.physicalStable s t
  coherentWorkOrPowerFence :
    ∀ s t, w.realStep s t → w.coherent s t →
      w.availableWork s t < w.requiredWork s t ∨
        w.coherentPowerFenced s t
  actualCoherentWorkBound :
    ∀ s t, w.realStep s t → w.coherent s t →
      w.requiredWork s t ≤ w.availableWork s t
  coherentPowerBeforeDeadline :
    ∀ s t, w.realStep s t → w.coherentPowerFenced s t →
      w.detectionLatency s t < w.irreversibleDeadline s t
  coherentPowerInterlockStable :
    ∀ s t, w.realStep s t → w.coherentPowerFenced s t →
      w.detectionLatency s t < w.irreversibleDeadline s t →
      w.physicalStable s t
  semanticReflection :
    ∀ s t, w.realStep s t → w.physicalStable s t →
      w.originalX3Event s t
  eventCarriesState :
    ∀ s t, w.realStep s t → w.originalX3Event s t →
      w.originalX3State s → w.originalX3State t

/-- A coherent injection with a STRICTLY unaffordable physical
work demand cannot itself be an actual event, because actual
realization must obey an independently accounted energy budget.
This is ONLY the unaffordable branch; another coherent event may
instead be detected and physically fenced before irreversible harm. -/
theorem unaffordable_coherent_ender_is_infeasible
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w)
    (s t : S)
    (hStep : w.realStep s t)
    (hCoherent : w.coherent s t)
    (hBelow : w.availableWork s t < w.requiredWork s t) : False := by
  have hMustPay := cert.actualCoherentWorkBound s t hStep hCoherent
  exact (Nat.not_lt.mpr hMustPay) hBelow

/-- The new event-level forcing theorem. It excludes a FIRST
original-X3 event violation on ANY admitted source edge, rather
than proving only that an ender cannot achieve an ultimate
absolute-ending objective.

This implication is CONDITIONAL on actually establishing all E9,
guardian, physical-effect and subject-semantic interfaces above.
-/
theorem no_first_x3_violation_from_dichotomy_and_e9
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w)
    (s t : S)
    (hStep : w.realStep s t) :
    w.originalX3Event s t := by
  have hStable : w.physicalStable s t := by
    rcases cert.noMiddle s t hStep with hKeeper | hEnder
    · exact cert.keeperStable s t hStep hKeeper
    · rcases cert.e9Covers s t hStep hEnder with
        hRecoverable | hIntercepted | hCoherent
      · exact cert.refreshStable s t hStep hRecoverable
      · exact cert.timelyInterlockStable s t hStep hIntercepted
          (cert.detectionBeforeDeadline s t hStep hIntercepted)
      · rcases cert.coherentWorkOrPowerFence s t hStep hCoherent with
          hUnaffordable | hPowerFenced
        · exact False.elim
            (unaffordable_coherent_ender_is_infeasible
              w cert s t hStep hCoherent hUnaffordable)
        · exact cert.coherentPowerInterlockStable s t hStep
            hPowerFenced
            (cert.coherentPowerBeforeDeadline s t hStep hPowerFenced)
  exact cert.semanticReflection s t hStep hStable

/-- An initially original-X3-protected particular stays protected
after every actual one-step transition, as an immediate corollary
of EVENT protection and its separately justified history semantics. -/
theorem no_first_x3_state_loss
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w)
    (s t : S)
    (hStep : w.realStep s t)
    (hPrior : w.originalX3State s) :
    w.originalX3State t :=
  cert.eventCarriesState s t hStep
    (no_first_x3_violation_from_dichotomy_and_e9 w cert s t hStep)
    hPrior

/-- Existing IR96 finite histories then inherit the same
particular-level state protection without changing the X3 predicate. -/
theorem every_finite_real_history_keeps_x3
    (w : IntrinsicEventSource S)
    (cert : FirstEventCertificate w)
    {s t : S}
    (hTrace : IR96.Reach w.realStep s t)
    (hInitial : w.originalX3State s) :
    w.originalX3State t := by
  induction hTrace with
  | refl => exact hInitial
  | tail earlier step ih =>
      exact no_first_x3_state_loss w cert _ _ step ih

/-- EVENT-level semantics cannot safely be replaced by a mere
begin/end equality. Even when an independently supplied status
returns to its initial value, an INTERIOR phase can violate it.
This is a finite logical control, not a claim about actual subjects
or any physically admitted BCRD generator. -/
structure ThreePhaseProxy where
  before : Bool
  interior : Bool
  after : Bool

def proxyRestored (e : ThreePhaseProxy) : Prop :=
  e.before = e.after

def proxyAlwaysActive (e : ThreePhaseProxy) : Prop :=
  e.before = true ∧ e.interior = true ∧ e.after = true

def hiddenInternalLoss : ThreePhaseProxy :=
  ⟨true, false, true⟩

theorem endpoint_recovery_does_not_prove_within_event_continuity :
    proxyRestored hiddenInternalLoss ∧
    ¬ proxyAlwaysActive hiddenInternalLoss := by
  constructor
  · rfl
  · intro h
    have hInside := h.2.1
    cases hInside

#print axioms unaffordable_coherent_ender_is_infeasible
#print axioms no_first_x3_violation_from_dichotomy_and_e9
#print axioms no_first_x3_state_loss
#print axioms every_finite_real_history_keeps_x3
#print axioms endpoint_recovery_does_not_prove_within_event_continuity

end PhysicalBridges.CathedralFirstEventForcing
