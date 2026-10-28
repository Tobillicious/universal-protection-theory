import PhysicalBridges.IR96DisturbanceSimulation
import PhysicalBridges.IR131ActionLabelledBranching
import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.Oct10SourceHamiltonianProtection

/-!
10–12 October original X3: particular-continuation generator-seam test.

Original H5, PNAJ, D115 and maximal X3 remain unchanged.
Each real physical step must be independently covered by a source
generator. Every source generator needs a separate subject-continuation,
causal succession and executable-branch certificate. These certificates
have NOT been derived for universal physical BCRD.

Positive finite-trace theorem reuses IR96 and IR131.
Negative controls: copied origin/journal cannot show activity (IR132),
transport of a marker is tautological, and the source H2 pulse changes
a B-site proxy despite conserved parity. B-site is NOT a real subject.
-/
namespace PhysicalBridges.Oct10Continuity

universe u v w x
variable {P : Type u} {Mind : Type v} {Gen : Type w}
variable {Action : Type x}

/-- The physically real relation is distinct from any proposed
source generator list. Completeness is an independent obligation. -/
structure Source (P : Type u) (Mind : Type v)
    (Gen : Type w) (Action : Type x) where
  realStep : P → P → Prop
  source : Gen → P → P → Prop
  owed : Mind → P → Prop
  active : Mind → P → Prop
  causal : Mind → P → P → Prop
  options : Mind → IR131.Process P Action

/-- Minimal modeled physical integrity; not full X3. -/
def Protected (s : Source P Mind Gen Action) (p : P) : Prop :=
  ∀ m, s.owed m p →
    s.active m p ∧ IR131.TwoWayChoice (s.options m) p

/-- Source-by-source proof obligations. These are not a derivation
of real BCRD physics: physical completeness and subjective semantics
must be independently substantiated. -/
structure Certified (s : Source P Mind Gen Action) : Prop where
  completeSources :
    ∀ p q, s.realStep p q → ∃ g, s.source g p q
  preserveDuties :
    ∀ g p q m, s.source g p q → s.owed m p → s.owed m q
  preserveActive :
    ∀ g p q m, s.source g p q →
      s.owed m p → s.active m p → s.active m q
  preserveLineage :
    ∀ g p q m, s.source g p q →
      s.owed m p → s.active m p → s.causal m p q
  preserveAlternatives :
    ∀ g p q m, s.source g p q →
      s.owed m p →
      IR131.TwoWayChoice (s.options m) p →
      IR131.TwoWayChoice (s.options m) q
  newParticulars :
    ∀ g p q m, s.source g p q →
      s.owed m q → ¬ s.owed m p →
      s.active m q ∧
        IR131.TwoWayChoice (s.options m) q

theorem each_real_source_step_preserves_protection
    (s : Source P Mind Gen Action) (cert : Certified s)
    (p q : P) (hStep : s.realStep p q)
    (hGood : Protected s p) :
    Protected s q := by
  obtain ⟨g, hGenerator⟩ := cert.completeSources p q hStep
  intro m hOwedQ
  by_cases hOld : s.owed m p
  · obtain ⟨hLive, hAgency⟩ := hGood m hOld
    exact ⟨cert.preserveActive g p q m hGenerator hOld hLive,
      cert.preserveAlternatives g p q m hGenerator hOld hAgency⟩
  · exact cert.newParticulars g p q m hGenerator hOwedQ hOld

theorem every_finite_real_execution_retains_protection
    (s : Source P Mind Gen Action) (cert : Certified s)
    {p q : P}
    (trace : IR96.Reach s.realStep p q)
    (hInitial : Protected s p) :
    Protected s q := by
  induction trace with
  | refl => exact hInitial
  | tail earlier edge ih =>
      exact each_real_source_step_preserves_protection s cert
        _ _ edge ih

/-- In addition to active status and distinct possible choices,
the original subject has a chain of source-certified physical
causal succession. This relation still needs independent semantics. -/
theorem original_particular_finite_causal_continuation
    (s : Source P Mind Gen Action) (cert : Certified s)
    {p q : P}
    (trace : IR96.Reach s.realStep p q)
    (hInitial : Protected s p) :
    ∀ m, s.owed m p →
      s.owed m q ∧
      s.active m q ∧
      IR131.TwoWayChoice (s.options m) q ∧
      IR96.Reach (s.causal m) p q := by
  induction trace with
  | refl =>
      intro m hOwed
      obtain ⟨hActive, hAgency⟩ := hInitial m hOwed
      exact ⟨hOwed, hActive, hAgency, IR96.Reach.refl _⟩
  | tail earlier edge ih =>
      intro m hStart
      obtain ⟨hOwed, hActive, hAgency, hChain⟩ :=
        ih m hStart
      obtain ⟨g, hg⟩ := cert.completeSources _ _ edge
      exact ⟨cert.preserveDuties g _ _ m hg hOwed,
        cert.preserveActive g _ _ m hg hOwed hActive,
        cert.preserveAlternatives g _ _ m hg hOwed hAgency,
        IR96.Reach.tail hChain
          (cert.preserveLineage g _ _ m hg hOwed hActive)⟩

/-! Synthetic nonvacuous example: actual changing states and two
authorized alternatives at each state, not a stopped generator. -/
def toyOptions : IR131.Process Bool Bool :=
  { step := fun _ choice next => next = choice
    authorised := fun _ _ => True }

theorem toy_options_really_branch (p : Bool) :
    IR131.TwoWayChoice toyOptions p := by
  exact ⟨false, true, false, true,
    (by decide), (by decide),
    ⟨trivial, rfl⟩, ⟨trivial, rfl⟩⟩

def openToy : Source Bool Unit Bool Bool :=
  { realStep := fun _ _ => True
    source := fun proposed _ next => next = proposed
    owed := fun _ _ => True
    active := fun _ _ => True
    causal := fun _ _ _ => True
    options := fun _ => toyOptions }

theorem open_toy_is_certified : Certified openToy := by
  refine {
    completeSources := ?_
    preserveDuties := ?_
    preserveActive := ?_
    preserveLineage := ?_
    preserveAlternatives := ?_
    newParticulars := ?_
  }
  · intro p q _
    exact ⟨q, rfl⟩
  · intro g p q m _ _
    trivial
  · intro g p q m _ _ _
    trivial
  · intro g p q m _ _ _
    trivial
  · intro g p q m _ _ _
    exact toy_options_really_branch q
  · intro g p q m _ _ _
    exact ⟨trivial, toy_options_really_branch q⟩

theorem open_toy_has_actual_change_and_protected_choices :
    openToy.realStep false true ∧
      Protected openToy false ∧ Protected openToy true := by
  refine ⟨trivial, ?_, ?_⟩
  · intro m _
    exact ⟨trivial, toy_options_really_branch false⟩
  · intro m _
    exact ⟨trivial, toy_options_really_branch true⟩

/-! Countermodel: identical origin and journal with opposite
physical active status, so provenance cannot determine identity. -/
structure ToyPhysical where
  origin : Bool
  journal : Bool
  active : Bool
  deriving DecidableEq

def living : ToyPhysical := ⟨false, false, true⟩
def stopped : ToyPhysical := ⟨false, false, false⟩
def loggedReadout (p : ToyPhysical) : Bool × Bool :=
  (p.origin, p.journal)
def physicallyActive (p : ToyPhysical) : Bool := p.active

theorem provenance_can_be_identical_after_activity_stops :
    loggedReadout living = loggedReadout stopped ∧
    physicallyActive living = true ∧
    physicallyActive stopped = false :=
  ⟨rfl, rfl, rfl⟩

theorem no_provenance_only_exact_activity_decoder :
    ¬ IR132.ExactDecoder loggedReadout physicallyActive := by
  intro hDecode
  have hFiber :=
    IR132.exact_decoder_implies_fiber_constant
      loggedReadout physicallyActive hDecode
  have hBad := hFiber living stopped rfl
  cases hBad

/-! Transporting a nominated projector by the SAME transition
automatically marks its own output. It can remain true even
when the physical active flag changes from true to false. -/
def toyTransport (p : ToyPhysical) : ToyPhysical :=
  { p with active := !p.active }

theorem projector_transport_is_a_tautology
    {X : Type u} (U : X → X) (oldSelected : X → Prop)
    (x : X) (hOld : oldSelected x) :
    ∃ earlier, oldSelected earlier ∧ U earlier = U x :=
  ⟨x, hOld, rfl⟩

theorem exact_transport_can_coexist_with_activity_loss :
    toyTransport living = stopped ∧
    (∃ earlier : ToyPhysical,
      earlier = living ∧ toyTransport earlier = stopped) ∧
    physicallyActive living = true ∧
    physicallyActive stopped = false := by
  refine ⟨rfl, ?_, rfl, rfl⟩
  exact ⟨living, rfl, rfl⟩

/-! Inherited exact H2 source changes B-site occupancy while
preserving parity: B-site is a weak proxy, NOT a subject model. -/
def siteProxy : Source Oct10Source.Basis Unit Unit Bool :=
  { realStep := Oct10Source.H2PulseStep
    source := fun _ p q => Oct10Source.H2PulseStep p q
    owed := fun _ _ => True
    active := fun _ p => Oct10Source.bSiteOccupied p = true
    causal := fun _ _ _ => True
    options := fun _ =>
      { step := fun _ _ _ => True
        authorised := fun _ _ => True } }

theorem original_H2_excludes_naive_B_site_certificate :
    ¬ Certified siteProxy := by
  intro cert
  have hSource : siteProxy.source () .B0 .C1 := by
    exact Oct10Source.H2PulseStep.pulse .B0
  have hLive : siteProxy.active () .B0 := by
    rfl
  have hAfter :=
    cert.preserveActive () .B0 .C1 () hSource trivial hLive
  simp [siteProxy, Oct10Source.bSiteOccupied] at hAfter

end PhysicalBridges.Oct10Continuity
