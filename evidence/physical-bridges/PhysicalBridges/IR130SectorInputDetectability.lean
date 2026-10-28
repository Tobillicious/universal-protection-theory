import PhysicalBridges.IR129BoundaryInvisibleKernel

/-!
IR-130: full 6-dimensional sector-block *coordinate* tomography and
input-dependent cut observability.

Represent the REAL 18-dimensional vector space of Hermitian operators
on C^3 ⊕ C^3 using six real diagonal entries and six complex
off-diagonal entries (real and imaginary components). These are
integer-valued coordinates here, a lattice inside the full real
Hermitian space. The theorem is entirely algebraic and extends to
real coefficients without change. Physical positivity / trace-one
and physical availability of all 18 observables remain independent
obligations.

Theorem 1: the 18 declared matrix-coordinate readouts separate any
two distinct sector-block Hermitian operators.

Theorem 2: a source-level channel causes a detectable change for
a SPECIFIC initial state only if its output actually differs from
that initial state. Nonidentity of the channel as a function
is insufficient.

Counterexample: a blockwise pinching/dephasing map preserves EVERY
diagonal input, even though it changes coherent offdiagonal states.
The specified pinching Kraus family is NOT a population-erasure map.
Actual microscopic CPTP and subject-truncation semantics are
analyzed separately in the accompanying mathematical review.

A finite-dimensional full-algebra result does not prove a BCRD
boundary instrument can measure all 18 probes, or that any subject
continued or was truncated.
-/
namespace PhysicalBridges.IR130

/-- Three unordered distinct pairs of indices in a 3×3 block. -/
inductive Pair3 where
  | p01
  | p02
  | p12
  deriving DecidableEq, Repr

/-- 18 Hermitian real coordinate probes: six diagonals, six
real offdiagonals and six imaginary offdiagonals. -/
inductive Probe where
  | diagonal (block : Fin 2) (index : Fin 3)
  | realPart (block : Fin 2) (pair : Pair3)
  | imagPart (block : Fin 2) (pair : Pair3)
  deriving DecidableEq, Repr

/-- Exact integer coordinate subspace of the 18-real-dimensional
sector-block Hermitian operator space. The real vector-space
form and its tomography theorem follow identically. -/
structure BlockHermitian where
  diagonal : Fin 2 → Fin 3 → Int
  realPart : Fin 2 → Pair3 → Int
  imagPart : Fin 2 → Pair3 → Int

def readout (o : Probe) (s : BlockHermitian) : Int :=
  match o with
  | .diagonal b i => s.diagonal b i
  | .realPart b p => s.realPart b p
  | .imagPart b p => s.imagPart b p

/-- Equality of all 18 operational coordinates forces operator
equality in this exact model. -/
theorem all_coordinate_probes_equal_implies_same_operator
    (s t : BlockHermitian)
    (h : ∀ o : Probe, readout o s = readout o t) :
    s = t := by
  have hd : s.diagonal = t.diagonal := by
    funext b i
    exact h (.diagonal b i)
  have hr : s.realPart = t.realPart := by
    funext b p
    exact h (.realPart b p)
  have hi : s.imagPart = t.imagPart := by
    funext b p
    exact h (.imagPart b p)
  cases s with
  | mk sd sr si =>
      cases t with
      | mk td tr ti =>
          dsimp at hd hr hi
          cases hd
          cases hr
          cases hi
          rfl

/-- The full declared finite sector algebra separates all distinct
block-Hermitian states, not merely different block populations.
This is the exact coordinate analogue of choosing O=ρ'-ρ. -/
theorem full_sector_algebra_separates_distinct_operators
    (s t : BlockHermitian) (hDistinct : s ≠ t) :
    ∃ o : Probe, readout o s ≠ readout o t := by
  classical
  by_cases hWitness : ∃ o : Probe, readout o s ≠ readout o t
  · exact hWitness
  · exfalso
    apply hDistinct
    apply all_coordinate_probes_equal_implies_same_operator s t
    intro o
    by_cases hSame : readout o s = readout o t
    · exact hSame
    · exact False.elim (hWitness ⟨o, hSame⟩)

/-- The corrected *fixed-input* theorem for ANY candidate channel.
Only the state-specific, demonstrably nonzero output difference
is needed for algebraic visibility. CPTP alone does not imply it. -/
theorem changed_input_state_is_detectable
    (phi : BlockHermitian → BlockHermitian)
    (rho : BlockHermitian)
    (hActualChange : phi rho ≠ rho) :
    ∃ o : Probe,
      readout o (phi rho) ≠ readout o rho :=
  full_sector_algebra_separates_distinct_operators
    (phi rho) rho hActualChange

/-- A class of purported structural cuts is detectably different
at EVERY specified input only when every such cut is independently
proven to change that actual input state. This does not identify
the cut class or its physical agency implications. -/
theorem conditionally_detect_all_sector_cuts
    (isCut : (BlockHermitian → BlockHermitian) → Prop)
    (allowed : BlockHermitian → Prop)
    (hNontrivialOnInput :
      ∀ phi rho, isCut phi → allowed rho → phi rho ≠ rho) :
    ∀ phi rho, isCut phi → allowed rho →
      ∃ o : Probe, readout o (phi rho) ≠ readout o rho := by
  intro phi rho hCut hAllowed
  exact changed_input_state_is_detectable
    phi rho (hNontrivialOnInput phi rho hCut hAllowed)

/-- A diagonal Hermitian operator (including appropriately
normalised maximally mixed density states when the coefficient
field is extended to the rationals). -/
def diagonalOperator (d : Fin 2 → Fin 3 → Int) : BlockHermitian :=
  { diagonal := d
    realPart := fun _ _ => 0
    imagPart := fun _ _ => 0 }

/-- Pinching by P=diag(1,1,0), Q=I-P in each sector; the 01
coherence survives and the 02/12 coherences vanish.
All diagonal populations are preserved. -/
def pinching (s : BlockHermitian) : BlockHermitian :=
  { diagonal := s.diagonal
    realPart := fun b p =>
      match p with
      | .p01 => s.realPart b .p01
      | .p02 => 0
      | .p12 => 0
    imagPart := fun b p =>
      match p with
      | .p01 => s.imagPart b .p01
      | .p02 => 0
      | .p12 => 0 }

/-- Every fully diagonal input is a fixed point even though this
channel is NOT the identity on all operators. -/
theorem pinching_fixes_every_diagonal_operator
    (d : Fin 2 → Fin 3 → Int) :
    pinching (diagonalOperator d) = diagonalOperator d := by
  apply BlockHermitian.ext
  · rfl
  · funext b p
    cases p <;> rfl
  · funext b p
    cases p <;> rfl

/-- Exact sample offdiagonal Hermitian operator. It is a useful
coordinate witness but not asserted to be a density matrix:
positivity and trace one are separate physical requirements. -/
def offDiagonalExample : BlockHermitian :=
  { diagonal := fun _ _ => 0
    realPart := fun b p =>
      if b = (0 : Fin 2) ∧ p = .p02 then 1 else 0
    imagPart := fun _ _ => 0 }

theorem pinching_is_not_identity :
    pinching offDiagonalExample ≠ offDiagonalExample := by
  intro h
  have he := congrArg
    (readout (.realPart (0 : Fin 2) .p02)) h
  have hImpossible : (0 : Int) = 1 := by
    simpa [readout, pinching, offDiagonalExample] using he
  omega

/-- There exists a NONIDENTITY input-output map that fixes a
specified whole class of states. This refutes the proposed
"nonidentity CPTP => detected for every ρ" conclusion; the
continuous map is realized by physical pinching Kraus operators
P,Q on the actual Hermitian state space. -/
theorem nonidentity_dephasing_can_be_invisible_on_its_input :
    (∃ rho : BlockHermitian, pinching rho = rho) ∧
      (∃ rho : BlockHermitian, pinching rho ≠ rho) := by
  constructor
  · exact ⟨diagonalOperator (fun _ _ => 0),
      pinching_fixes_every_diagonal_operator _⟩
  · exact ⟨offDiagonalExample, pinching_is_not_identity⟩

/-- Finite probe set gives a precise source-level distinction:
the same channel is detectable on altered coherent inputs, and
undetectable on its fixed diagonal inputs. -/
theorem nonidentity_map_can_have_both_detected_and_undetected_inputs :
    (∃ rho, ∃ o : Probe,
      readout o (pinching rho) ≠ readout o rho) ∧
    (∃ rho, ∀ o : Probe,
      readout o (pinching rho) = readout o rho) := by
  constructor
  · exact ⟨offDiagonalExample,
      changed_input_state_is_detectable
        pinching offDiagonalExample pinching_is_not_identity⟩
  · refine ⟨diagonalOperator (fun _ _ => 0), ?_⟩
    intro o
    rw [pinching_fixes_every_diagonal_operator]

end PhysicalBridges.IR130
