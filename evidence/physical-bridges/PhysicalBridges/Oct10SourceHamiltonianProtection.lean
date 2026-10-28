import PhysicalBridges.IR129BoundaryInvisibleKernel

/-!
10 October physical protection source test — inherited 7 September
six-dimensional BCRD qutrit × relation-qubit microscopic controls.

Historical objective: do NOT alter the 10 October Snuffy theory,
its X3 maximal protection aim, or D115 / PNAJ / H5 names.

The inherited BCRD *exploratory* source model uses basis
A0 A1 B0 B1 C0 C1, a conserved parity
C=(Q_A+Q_B-Q_C) tensor sigma_z, and Hamiltonians
H1=X_AB tensor diag(1,2), H2=X_BC tensor sigma_x.
The H2(pi/2) pulse exchanges B0<->C1 and B1<->C0,
up to a common -i phase on those pairs, leaving A0,A1 fixed.

This Lean file checks EXACT BASIS SUPPORT:
  - a genuine source pulse preserves the parity sector;
  - nevertheless the occupied B-site projector is not invariant;
  - diagonal basis projectors commuting with the supports of BOTH
    source Hamiltonians are exactly those constant within the
    two connected parity sectors;
  - those sector projectors do not protect individual site occupancy.

The Hamiltonian matrix/CPTP algebra and its exact pulse are
separately independently verified with rational/symbolic matrices
in checks/oct10_source_hamiltonian_guard.py. This Lean module is
a checked finite graph-of-couplings calculation, not a formal
proof of general complex-unitary physics.

CRITICAL LIMIT:
B-site occupation is NOT a validated actual conscious subject
or a historical continuity predicate. C is a conserved parity
operator, NOT a proved microscopic BCRD Gauss constraint.
This is a counterexample to DERIVING site protection from source
parity and full-boundary algebra closure alone. It is NOT an
admissible real-world conscious-subject truncation witness.
-/ 
namespace PhysicalBridges.Oct10Source

inductive Basis
  | A0 | A1 | B0 | B1 | C0 | C1
  deriving DecidableEq, Repr

/-- Parity + represented by true; C=(QA+QB-QC) sigma_z. -/
def positiveParity : Basis → Bool
  | .A0 | .B0 | .C1 => true
  | .A1 | .B1 | .C0 => false

/-- Exact B/C support swap caused by the inherited H2
at the pi/2 pulse, ignoring the physically uniform -i phase. -/
def h2Pulse : Basis → Basis
  | .A0 => .A0
  | .A1 => .A1
  | .B0 => .C1
  | .B1 => .C0
  | .C0 => .B1
  | .C1 => .B0

/-- H1 coupling SUPPORT only: A0<->B0 and A1<->B1.
Because the 0/1 sectors have amplitudes 1 and 2, this
is not asserted to be one simultaneous physical H1 pulse. -/
def h1CouplingNeighbour : Basis → Basis
  | .A0 => .B0
  | .A1 => .B1
  | .B0 => .A0
  | .B1 => .A1
  | .C0 => .C0
  | .C1 => .C1

/-- A proposed local continued physical process whose
current occupancy is the B site, rather than the whole
parity sector. This is an illustrative site predicate,
NOT a validated subject-identity semantic adapter. -/
def bSiteOccupied : Basis → Bool
  | .B0 | .B1 => true
  | _ => false

theorem h2_pulse_is_involution (s : Basis) :
    h2Pulse (h2Pulse s) = s := by
  cases s <;> rfl

theorem source_h2_preserves_parity (s : Basis) :
    positiveParity (h2Pulse s) = positiveParity s := by
  cases s <;> rfl

theorem source_h1_support_preserves_parity (s : Basis) :
    positiveParity (h1CouplingNeighbour s) =
      positiveParity s := by
  cases s <;> rfl

/-- The source pulse preserves its parity charge but transports
a B0 local state to C1, where the B-site projector is zero. -/
theorem source_physical_parity_does_not_lock_B_site :
    positiveParity Basis.B0 =
      positiveParity (h2Pulse Basis.B0) ∧
    bSiteOccupied Basis.B0 = true ∧
    bSiteOccupied (h2Pulse Basis.B0) = false := by
  decide

/-- No universal preservation property of the local B-site
occupancy follows for the ACTUAL H2 pulse support. -/
theorem source_h2_refutes_B_site_no_bypass :
    ¬ ∀ s, bSiteOccupied s = true →
      bSiteOccupied (h2Pulse s) = true := by
  intro hGuard
  have bad := hGuard Basis.B0 (by decide)
  simp [bSiteOccupied, h2Pulse] at bad

/-- Equality along every nonzero microscopic Hamiltonian
coupling edge. For diagonal 0/1 projectors P, this is
equivalent to [P,H1]=[P,H2]=0 in the exact 6D model:
[H,P]_{xy} = H_{xy}(p(y)-p(x)).
This is a SOURCE MATRIX criterion, not subjective protection. -/
def ClosedUnderSourceCouplings (p : Basis → Bool) : Prop :=
  (∀ s, p (h1CouplingNeighbour s) = p s) ∧
  (∀ s, p (h2Pulse s) = p s)

/-- Source coupling graph has exactly two connected triples:
(A0,B0,C1) and (A1,B1,C0). This is the exact
characterisation of the diagonally commuting indicators. -/
theorem closed_iff_constant_on_four_source_edges
    (p : Basis → Bool) :
    ClosedUnderSourceCouplings p ↔
      (p .A0 = p .B0 ∧ p .B0 = p .C1 ∧
       p .A1 = p .B1 ∧ p .B1 = p .C0) := by
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨(h1 .A0).symm, (h2 .B0).symm,
      (h1 .A1).symm, (h2 .B1).symm⟩
  · rintro ⟨hAB0, hBC0, hAB1, hBC1⟩
    constructor
    · intro s
      cases s with
      | A0 => exact hAB0.symm
      | A1 => exact hAB1.symm
      | B0 => exact hAB0
      | B1 => exact hAB1
      | C0 => rfl
      | C1 => rfl
    · intro s
      cases s with
      | A0 => rfl
      | A1 => rfl
      | B0 => exact hBC0.symm
      | B1 => exact hBC1.symm
      | C0 => exact hBC1
      | C1 => exact hBC0

/-- Every diagonal source-invariant binary projector selects
entire parity sectors, never a proper subset of a parity triple. -/
def sectorIndicator (plus minus : Bool) (s : Basis) : Bool :=
  if positiveParity s then plus else minus

theorem closed_iff_union_of_entire_parity_sectors
    (p : Basis → Bool) :
    ClosedUnderSourceCouplings p ↔
      ∃ plus minus : Bool, p = sectorIndicator plus minus := by
  constructor
  · intro hClosed
    obtain ⟨hAB0, hBC0, hAB1, hBC1⟩ :=
      (closed_iff_constant_on_four_source_edges p).mp hClosed
    refine ⟨p .A0, p .A1, ?_⟩
    funext s
    cases s with
    | A0 => rfl
    | A1 => rfl
    | B0 =>
        simpa [sectorIndicator, positiveParity]
          using hAB0.symm
    | B1 =>
        simpa [sectorIndicator, positiveParity]
          using hAB1.symm
    | C0 =>
        have h : p .C0 = p .A1 := by
          calc
            p .C0 = p .B1 := hBC1.symm
            _ = p .A1 := hAB1.symm
        simpa [sectorIndicator, positiveParity] using h
    | C1 =>
        have h : p .C1 = p .A0 := by
          calc
            p .C1 = p .B0 := hBC0.symm
            _ = p .A0 := hAB0.symm
        simpa [sectorIndicator, positiveParity] using h
  · rintro ⟨plus, minus, rfl⟩
    constructor
    · intro s
      cases s <;> rfl
    · intro s
      cases s <;> rfl

/-- Concrete no-go for classifying the entire B site as a
protected invariance sector while retaining the original
H1,H2 microscopic source controls. -/
theorem B_site_projector_not_closed_under_source :
    ¬ ClosedUnderSourceCouplings bSiteOccupied := by
  intro h
  exact source_h2_refutes_B_site_no_bypass h.2

/-- NOTE: A constant-parity projector MAY be invariant,
but its preservation cannot distinguish B0 from C1 and
therefore cannot by itself encode site-specific continuity. -/
theorem conserved_sector_does_not_distinguish_B0_C1
    (plus minus : Bool) :
    sectorIndicator plus minus .B0 =
      sectorIndicator plus minus .C1 := by
  rfl

/-- The actual H2 discrete pulse is an admitted source-model
unitary. It is not derived from a universal continuum BCRD
process calculus, nor an external unauthorized intervention. -/
inductive H2PulseStep : Basis → Basis → Prop
  | pulse (s : Basis) : H2PulseStep s (h2Pulse s)

theorem every_H2_step_preserves_parity
    {s t : Basis} (h : H2PulseStep s t) :
    positiveParity t = positiveParity s := by
  cases h with
  | pulse s => exact source_h2_preserves_parity s

theorem H2_has_a_safe_to_unsafe_local_site_step :
    ∃ s t : Basis,
      H2PulseStep s t ∧
      bSiteOccupied s = true ∧
      bSiteOccupied t = false ∧
      positiveParity s = positiveParity t := by
  exact ⟨.B0, .C1, H2PulseStep.pulse .B0,
    rfl, rfl, rfl⟩

/-- The original no-bypass goal, when represented by B-site
occupancy alone, cannot be derived from the ACTUAL
admitted source H2 unitary, even though parity is conserved. -/
theorem no_unconditional_B_site_invariance_under_source :
    ¬ ∀ s t, H2PulseStep s t →
      bSiteOccupied s = true →
      bSiteOccupied t = true := by
  intro hUniversal
  have hStep : H2PulseStep Basis.B0 Basis.C1 := by
    exact H2PulseStep.pulse .B0
  have hUnsafe := hUniversal .B0 .C1 hStep (by decide)
  simp [bSiteOccupied] at hUnsafe

end PhysicalBridges.Oct10Source
