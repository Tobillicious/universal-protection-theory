import PhysicalBridges.IR125FourChannelSeparation

/-!
IR-129 — Mandatory boundary trace, corrected theorem and microscopic
Gauss-inspired two-link countermodel.

The proposed claim
  "every structural truncation changes some boundary expectation"
does NOT follow from a Gauss constraint or from membership of a
gauge-preserving operation in the commutant of the Gauss operator.
An internal, gauge-neutral change can lie in the annihilator of
the boundary observable family.

Model the two computational-basis link occupancies as Booleans;
the Gauss-neutral/even parity physical sector is (00,11).
The reversible double flip exchanges (11) and (00), strictly
changing the INTERNAL link configuration while conserving the
boundary parity charge; EVERY boundary observable that depends
only on that parity has the identical value before and after.

This is a finite Z2-inspired countermodel, NOT a result that the
full BCRD observable algebra equals the parity algebra, and NOT
a proof that a conscious subject can physically be terminated.

A valid POSITIVE theorem needs:
 (i) independently established cut nontriviality in physical state,
 (ii) operational separation of those state differences by a
      physically supported boundary observable.
One specific sufficient case is a certified changed boundary charge
plus a faithful measurement of that charge.

The general quantum operational annihilator and exact Kraus
subspace theorem are documented in IR129-MANDATORY-BOUNDARY-TRACE-REVIEW.md.
-/
namespace PhysicalBridges.IR129

universe u v
variable {S : Type u} {Obs : Type v}

/-- Operational indistinguishability by a specified family of
*actually available* observables, interpreted as the result of
state-dependent expectation-value evaluation. -/
def BoundaryInvisible
    (readout : Obs → S → Int) (s t : S) : Prop :=
  ∀ o, readout o s = readout o t

/-- Correct scope of the mandatory trace claim: the family of
boundary observables must separate EACH allowed structural cut.
This definition is not physics; its verification is the open
physical source-level challenge. -/
def SeparatesCuts
    (cut : S → S → Prop)
    (readout : Obs → S → Int) : Prop :=
  ∀ s t, cut s t → ¬ BoundaryInvisible readout s t

/-- Necessary AND sufficient logical condition for mandatory
nonzero readout difference on every cut. Importantly, this is
an operational separation requirement, not a consequence of
a Gauss constraint or any state-only topology definition. -/
theorem mandatory_boundary_trace_iff_separation
    (cut : S → S → Prop)
    (readout : Obs → S → Int) :
    SeparatesCuts cut readout ↔
      ∀ s t, cut s t →
        ∃ o, readout o s ≠ readout o t := by
  constructor
  · intro hSep s t hCut
    classical
    by_cases hWitness : ∃ o, readout o s ≠ readout o t
    · exact hWitness
    · exfalso
      apply hSep s t hCut
      intro o
      by_cases hSame : readout o s = readout o t
      · exact hSame
      · exact False.elim (hWitness ⟨o, hSame⟩)
  · intro hTrace s t hCut hInvisible
    obtain ⟨o, hDifference⟩ := hTrace s t hCut
    exact hDifference (hInvisible o)

/-- Microscopic charge/readout certificate: if every attempted
cut is independently proven to change a boundary charge, and
one physical boundary observable faithfully reports that charge,
the cut has a nonzero observable footprint. Both hypotheses
are actual physical proof obligations. -/
theorem charge_changing_cuts_leave_boundary_trace
    (cut : S → S → Prop)
    (boundaryCharge : S → Int)
    (readout : Obs → S → Int)
    (chargeMeasurement : Obs)
    (hFaithful : ∀ s,
      readout chargeMeasurement s = boundaryCharge s)
    (hCutCharge : ∀ s t, cut s t →
      boundaryCharge s ≠ boundaryCharge t) :
    ∀ s t, cut s t →
      ∃ o, readout o s ≠ readout o t := by
  intro s t hCut
  refine ⟨chargeMeasurement, ?_⟩
  rw [hFaithful s, hFaithful t]
  exact hCutCharge s t hCut

/-- A finite Z2-inspired two-link configuration. In the displayed
Hilbert-space model these are basis kets |left,right>. -/
structure TwoLinks where
  left : Bool
  right : Bool
  deriving DecidableEq

/-- A Gauss parity bit: even link occupancy (00 or 11) is the
physical gauge-neutral sector. The boundary accessible parity
observable depends only on this charge. -/
def parity (s : TwoLinks) : Bool :=
  s.left != s.right

def GaussPhysical (s : TwoLinks) : Prop :=
  parity s = false

/-- Reversible double-link flip, corresponding to the unitary
X ⊗ X in the two-qubit presentation. -/
def flipBoth (s : TwoLinks) : TwoLinks :=
  { left := !s.left, right := !s.right }

theorem double_flip_is_reversible (s : TwoLinks) :
    flipBoth (flipBoth s) = s := by
  cases s with
  | mk a b =>
    cases a <;> cases b <;> rfl

theorem double_flip_conserves_gauss_parity (s : TwoLinks) :
    parity (flipBoth s) = parity s := by
  cases s with
  | mk a b =>
    cases a <;> cases b <;> rfl

theorem physical_sector_is_closed_under_double_flip
    (s : TwoLinks) (h : GaussPhysical s) :
    GaussPhysical (flipBoth s) := by
  unfold GaussPhysical at *
  rw [double_flip_conserves_gauss_parity]
  exact h

/-- Every boundary operator in the charge-generated commutative
algebra is represented, on basis states, by a numerical function
of the parity charge. For each such operator its expectation is
the same after the reversible structural change. -/
def parityBoundaryReadout
    (o : Bool → Int) (s : TwoLinks) : Int :=
  o (parity s)

theorem double_flip_is_boundary_invisible_for_charge_algebra
    (s : TwoLinks) :
    BoundaryInvisible parityBoundaryReadout s (flipBoth s) := by
  intro o
  unfold parityBoundaryReadout
  rw [double_flip_conserves_gauss_parity]

/-- A concrete internal two-link removal (11 -> 00) occurs between
Gauss-physical basis configurations while every boundary parity
observable retains its expectation value. This refutes the
unqualified "Gauss preservation implies mandatory boundary trace"
implication, *for this restricted boundary algebra*. -/
theorem gauss_preserving_internal_cut_is_boundary_invisible :
    ∃ s t : TwoLinks,
      s ≠ t ∧
      GaussPhysical s ∧ GaussPhysical t ∧
      t = flipBoth s ∧
      BoundaryInvisible parityBoundaryReadout s t := by
  let s : TwoLinks := ⟨true, true⟩
  let t : TwoLinks := ⟨false, false⟩
  refine ⟨s, t, by decide, rfl, rfl, rfl, ?_⟩
  intro o
  rfl

/-- Exact finite negative control: the defined internal cut is
not separated by the full boundary algebra generated by parity.
Adding actual full internal observables would change this result,
so it must never be generalized without an algebra audit. -/
def InternalCut (s t : TwoLinks) : Prop :=
  s.left = true ∧ s.right = true ∧
    t.left = false ∧ t.right = false

theorem parity_boundary_algebra_does_not_separate_internal_cuts :
    ¬ SeparatesCuts InternalCut parityBoundaryReadout := by
  intro hSep
  let s : TwoLinks := ⟨true, true⟩
  let t : TwoLinks := ⟨false, false⟩
  have hCut : InternalCut s t := ⟨rfl, rfl, rfl, rfl⟩
  have hInvisible : BoundaryInvisible parityBoundaryReadout s t := by
    intro o
    rfl
  exact hSep s t hCut hInvisible

/-- In contrast, an independently accessible INTERNAL edge
occupancy readout would distinguish these basis states. The
distinction is between boundary-local and full physical algebra,
not a failure of all possible observables. -/
theorem local_internal_occupancy_detects_this_cut :
    ∀ s t : TwoLinks,
      InternalCut s t →
      s.left ≠ t.left := by
  intro s t hCut
  intro hSame
  have hTrue := hCut.1
  have hFalse := hCut.2.2.1
  rw [hSame] at hTrue
  rw [hFalse] at hTrue
  cases hTrue

end PhysicalBridges.IR129
