import PhysicalBridges.IR130SectorInputDetectability

/-!
IR-132 — Exact boundary reconstruction criterion and historical
D115 / H5 / PNAJ label-seam referee.

A microscopic Gauss constraint, a center anomaly condition or
modular-flow invariance DO NOT by themselves imply that a boundary
readout reconstructs all bulk information.

Positive theorem: in a specified set of admissible physical
states, a logical quantity is exactly reconstructible from a
boundary observation IF AND ONLY IF it is constant on every
fiber of the observation map. For inhabited logical outcome types,
a decoder can be constructed by choosing a representative of
each nonempty fiber. This is a noncomputable EXISTENCE theorem,
NOT a physically calibrated sensor, an efficient reconstruction
algorithm or a microscopic BCRD isometry.

Negative controls: two different bulk states can share the same
boundary readout while obeying a (trivial) Gauss constraint;
there is no universal bulk decoder. A restricted two-state
fixed-ancilla code DOES permit exact boundary reconstruction,
but not the entire ambient physical state space. Two states
with the same available input but different contextual judgments
also defeat any universally exact judgment estimator.

No claim of actual subjective identity or maximal X3 is made.
-/
namespace PhysicalBridges.IR132

universe u v w
variable {Physical : Type u} {Boundary : Type v} {Logical : Type w}

/-- Fiberwise indistinguishability is the exact structural
obstruction to decoding the logical result from boundary data. -/
def FiberConstant
    (boundary : Physical → Boundary)
    (logical : Physical → Logical) : Prop :=
  ∀ s t, boundary s = boundary t → logical s = logical t

def ExactDecoder
    (boundary : Physical → Boundary)
    (logical : Physical → Logical) : Prop :=
  ∃ decode : Boundary → Logical,
    ∀ s, decode (boundary s) = logical s

theorem exact_decoder_implies_fiber_constant
    (boundary : Physical → Boundary)
    (logical : Physical → Logical)
    (h : ExactDecoder boundary logical) :
    FiberConstant boundary logical := by
  obtain ⟨decode, hDecode⟩ := h
  intro s t hBoundary
  calc
    logical s = decode (boundary s) := (hDecode s).symm
    _ = decode (boundary t) := congrArg decode hBoundary
    _ = logical t := hDecode t

/-- An exact set-theoretic reconstruction exists precisely when
boundary fibers are logically unambiguous. The construction uses
classical choice; no computability or physical measurement warrant
is claimed. -/
theorem exact_decoder_iff_fiber_constant
    [Inhabited Logical]
    (boundary : Physical → Boundary)
    (logical : Physical → Logical) :
    ExactDecoder boundary logical ↔
      FiberConstant boundary logical := by
  constructor
  · exact exact_decoder_implies_fiber_constant boundary logical
  · intro hFiber
    classical
    let decode : Boundary → Logical := fun b =>
      if hExists : ∃ s, boundary s = b then
        logical (Classical.choose hExists)
      else default
    refine ⟨decode, ?_⟩
    intro s
    have hExists : ∃ q : Physical, boundary q = boundary s :=
      ⟨s, rfl⟩
    change (if h : ∃ q : Physical, boundary q = boundary s then
      logical (Classical.choose h) else default) = logical s
    rw [dif_pos hExists]
    exact hFiber (Classical.choose hExists) s
      (Classical.choose_spec hExists)

/-- Logical state is the first bit and physical boundary reports
the SECOND bit. The closed-gauge toy model can set G=0 for every
physical state; this imposes no correlation between these bits. -/
def toyBoundary (s : Bool × Bool) : Bool := s.2
def toyBulk (s : Bool × Bool) : Bool := s.1

theorem gauss_compatible_undetectable_bulk_pair :
    ∃ s t : Bool × Bool,
      toyBoundary s = toyBoundary t ∧
      toyBulk s ≠ toyBulk t := by
  exact ⟨(false, false), (true, false), rfl, by decide⟩

theorem no_universal_bulk_reconstruction_from_boundary :
    ¬ ExactDecoder toyBoundary toyBulk := by
  intro hReconstruct
  have hFiber :=
    exact_decoder_implies_fiber_constant
      toyBoundary toyBulk hReconstruct
  obtain ⟨s, t, hObs, hLogical⟩ :=
    gauss_compatible_undetectable_bulk_pair
  exact hLogical (hFiber s t hObs)

/-- A fixed-ancilla code whose boundary stores the logical bit.
This is a special, explicitly supplied ENCODING, not a conclusion
of Gauss constraints or an isometry between all bulk/boundary
algebras. -/
def encodeBoundaryCode (logical : Bool) : Bool × Bool :=
  (logical, false)

def codeBoundary (s : Bool × Bool) : Bool := s.1

theorem fixed_ancilla_boundary_code_is_exact :
    ∀ logical : Bool,
      codeBoundary (encodeBoundaryCode logical) = logical := by
  intro logical
  rfl

theorem fixed_ancilla_code_keeps_interior_fixed :
    ∀ logical : Bool,
      (encodeBoundaryCode logical).2 = false := by
  intro logical
  rfl

theorem boundary_encoding_is_injective :
    Function.Injective encodeBoundaryCode := by
  intro a b h
  exact congrArg Prod.fst h

/-- The precise PNAJ information obstruction: two different
judgments with the SAME accessible input cannot BOTH be
predicted exactly by any deterministic estimator, computable
or otherwise. A nonzero error lower bound in a metric space
needs the triangle inequality, and is conditional on these
actual indistinguishable states existing. -/
theorem same_data_different_judgment_forbids_exact_prediction
    (observed : Physical → Boundary)
    (judgment : Physical → Logical)
    (s t : Physical)
    (hSame : observed s = observed t)
    (hDifferent : judgment s ≠ judgment t) :
    ¬ ∃ estimator : Boundary → Logical,
      estimator (observed s) = judgment s ∧
      estimator (observed t) = judgment t := by
  intro hEstimator
  obtain ⟨estimator, hS, hT⟩ := hEstimator
  apply hDifferent
  calc
    judgment s = estimator (observed s) := hS.symm
    _ = estimator (observed t) := congrArg estimator hSame
    _ = judgment t := hT

/-- If the true judgment is itself directly given as the input,
the identity estimator makes ZERO error on every state. This
rules out a universal positive 'PNAJ gap' without an independent
restriction on what information is accessible to the estimator. -/
theorem identity_estimator_can_be_exact
    (judgment : Physical → Logical) :
    ∃ estimator : Logical → Logical,
      ∀ s, estimator (judgment s) = judgment s := by
  exact ⟨id, by intro s; rfl⟩

/-- Logically trivial state-preserving generator: no positive
entropy-change claim can follow merely from 'deterministic
generator' or 'Gauss-compatible map'; its action is identity. -/
theorem identity_generator_has_zero_entropy_defect
    (entropy : Physical → Int) (s : Physical) :
    entropy (id s) - entropy s = 0 := by
  simp

end PhysicalBridges.IR132
