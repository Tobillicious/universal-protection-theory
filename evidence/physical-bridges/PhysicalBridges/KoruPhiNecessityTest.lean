import PhysicalBridges.KoruCyclicGenesisForwardJoin

/-!
# Golden-ratio necessity test: a growing Koru over cyclic objective W

The golden ratio phi is a specific positive solution of x² = x + 1.
This module does NOT introduce real-valued phi, a numerical convergence
claim, cosmic growth, or an ethical theorem. Instead it proves precisely:

* The *chosen* two-generation Fibonacci renewal has an internally
  derived formal phi multiplier obeying phi² = phi + 1.
* Renewal is injective, retains nonzero states and (given positive
  stored growth) strictly increases a size measure after one step.
* The existing banked forward/right-handed complete-W Koru is
  compatible with both that recurrence AND a different non-golden
  renewal rule, on the very same source event. Hence handedness,
  persistence and objective W by themselves do not FORCE phi.
* Even formal golden growth does not impose a simple reciprocal-duty
  relation, let alone the full Golden Rule or original six-X3.

To make phi a consequence of complete Koru physics, one must DERIVE
the Fibonacci two-generation law from independent physical source
relations, rather than stipulate it as renewal.
-/

namespace PhysicalBridges.KoruPhiNecessityTest

open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruDirectorNontrivialSector
open PhysicalBridges.KoruWActionFixedSymmetry

/-- Ordered two-generation growth register. This is a mathematical
register, NOT a universe or a conscious particular. -/
abbrev GrowthPair := Nat × Nat

/-- A general, independently specifiable, forward two-generation
recurrence. k=1 is Fibonacci; k=2 is a different lawful recurrence. -/
def weightedRenewal (k : Nat) (v : GrowthPair) : GrowthPair :=
  (v.2, v.1 + k * v.2)

def fibonacciRenewal : GrowthPair → GrowthPair := weightedRenewal 1
def alternativeRenewal : GrowthPair → GrowthPair := weightedRenewal 2

/-- Renewal retains BOTH degrees of information: the new first coordinate
is the old second, and the old first is recoverable by subtraction of a
known, nonnegative multiple. No "safe action" assumption. -/
theorem every_weighted_renewal_is_injective (k : Nat) :
    Function.Injective (weightedRenewal k) := by
  intro x y h
  rcases x with ⟨a, b⟩
  rcases y with ⟨c, d⟩
  have hb : b = d := by
    exact congrArg (fun z : GrowthPair => z.1) h
  have hs : a + k * b = c + k * d := by
    exact congrArg (fun z : GrowthPair => z.2) h
  have ha : a = c := by
    rw [hb] at hs
    exact Nat.add_right_cancel hs
  exact Prod.ext ha hb

/-- Construct a *formal quadratic number* as two Nat coefficients
of 1 and phi, with the sole multiplication rule phi²=phi+1.
This is a positive coefficient algebra, NOT a real-number
construction or proof of which of the two real roots is selected. -/
abbrev FormalGolden := Nat × Nat

def formalAdd (x y : FormalGolden) : FormalGolden :=
  (x.1 + y.1, x.2 + y.2)

def formalMul (x y : FormalGolden) : FormalGolden :=
  (x.1 * y.1 + x.2 * y.2,
   x.1 * y.2 + x.2 * y.1 + x.2 * y.2)

def formalOne : FormalGolden := (1, 0)
def formalPhi : FormalGolden := (0, 1)

/-- Exact characteristic identity of the Fibonacci multiplier. -/
theorem formal_phi_quadratic :
    formalMul formalPhi formalPhi =
      formalAdd formalPhi formalOne := by
  decide

/-- The Fibonacci recurrence is LITERALLY multiplication by the
formal phi generator. This identifies where the golden polynomial
enters, without pretending that the recurrence was derived from W. -/
theorem formal_phi_multiplies_as_fibonacci
    (v : FormalGolden) :
    formalMul formalPhi v = fibonacciRenewal v := by
  rcases v with ⟨a, b⟩
  simp [formalMul, formalPhi, fibonacciRenewal, weightedRenewal]

/-- Fibonacci coefficient pairs are produced from the original unit
by repeated formal phi multiplication. -/
def phiCoefficients (n : Nat) : FormalGolden :=
  match n with
  | 0 => formalOne
  | k + 1 => fibonacciRenewal (phiCoefficients k)

theorem phi_coefficients_follow_two_generations (n : Nat) :
    phiCoefficients (n + 1) =
      formalMul formalPhi (phiCoefficients n) := by
  exact (formal_phi_multiplies_as_fibonacci (phiCoefficients n)).symm

/-- The exact Fibonacci second-coordinate recurrence. No analytical
limit or unproved convergence statement appears here. -/
theorem phi_coefficients_recur (n : Nat) :
    (phiCoefficients (n + 2)).2 =
      (phiCoefficients (n + 1)).2 + (phiCoefficients n).2 := by
  simp only [phiCoefficients, fibonacciRenewal, weightedRenewal]
  omega

/-- Any finite number of Fibonacci renewal steps can be undone in
the sense of injectivity, preserving distinctions of starting pairs. -/
def fibonacciIter (seed : GrowthPair) : Nat → GrowthPair
  | 0 => seed
  | n + 1 => fibonacciRenewal (fibonacciIter seed n)

theorem fibonacci_iterations_do_not_merge (n : Nat) :
    Function.Injective (fun seed : GrowthPair => fibonacciIter seed n) := by
  induction n with
  | zero =>
      intro a b h
      exact h
  | succ n ih =>
      intro a b h
      have hStep :
          fibonacciRenewal (fibonacciIter a n) =
            fibonacciRenewal (fibonacciIter b n) := by
        simpa only [fibonacciIter] using h
      exact ih (every_weighted_renewal_is_injective 1 hStep)

/-- The zero register remains zero under every Fibonacci renewal.
Proved separately to avoid incorrectly generalizing over a nonzero
seed inside the later induction. -/
theorem fibonacci_zero_is_fixed (n : Nat) :
    fibonacciIter (0, 0) n = (0, 0) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change fibonacciRenewal (fibonacciIter (0, 0) n) = (0, 0)
      rw [ih]
      rfl

/-- Nonzero ancestry remains nonzero at every finite generation;
this is not a claim that every protected subject survives cosmology. -/
theorem fibonacci_nonzero_origin_is_never_erased
    (seed : GrowthPair) (n : Nat)
    (hNonzero : seed ≠ (0, 0)) :
    fibonacciIter seed n ≠ (0, 0) := by
  intro hZero
  have hZeroStays : fibonacciIter (0, 0) n = (0, 0) :=
    fibonacci_zero_is_fixed n
  exact hNonzero ((fibonacci_iterations_do_not_merge n)
    (hZero.trans hZeroStays.symm))

def registerSize (v : GrowthPair) : Nat := v.1 + v.2

/-- Size grows by the OLD second-generation value, an exact
combinatorial fact, NOT a theorem of ethical or physical improvement. -/
theorem fibonacci_size_growth_formula (v : GrowthPair) :
    registerSize (fibonacciRenewal v) = registerSize v + v.2 := by
  rcases v with ⟨a, b⟩
  dsimp [registerSize, fibonacciRenewal, weightedRenewal]
  omega

theorem fibonacci_strict_size_growth_if_second_positive
    (v : GrowthPair) (hPositive : 0 < v.2) :
    registerSize v < registerSize (fibonacciRenewal v) := by
  rw [fibonacci_size_growth_formula]
  omega

/-- A nonzero total register strictly increases after at most
one preliminary Fibonacci renewal. This is growth of a register,
not an order on the moral quality of successive universes. -/
theorem fibonacci_strict_growth_after_first_nonzero
    (v : GrowthPair) (hPositive : 0 < registerSize v) :
    registerSize (fibonacciRenewal v) <
      registerSize (fibonacciRenewal (fibonacciRenewal v)) := by
  have hSecond : 0 < (fibonacciRenewal v).2 := by
    simpa [fibonacciRenewal, weightedRenewal, registerSize] using hPositive
  exact fibonacci_strict_size_growth_if_second_positive
    (fibonacciRenewal v) hSecond

/-- Different non-erasing growth rules coexist, and give different
next generations from exactly the same initial pair. In particular,
one cannot infer the golden recurrence from injectivity alone. -/
theorem two_injective_renewals_have_different_outcomes :
    Function.Injective fibonacciRenewal ∧
      Function.Injective alternativeRenewal ∧
      fibonacciRenewal (0, 1) ≠ alternativeRenewal (0, 1) := by
  exact ⟨every_weighted_renewal_is_injective 1,
    every_weighted_renewal_is_injective 2, by decide⟩

/-- Source whole U + independently modeled causal time + separate
growth register. Existing source admissibility is unchanged. -/
abbrev GrowingKoruState := Combined × GrowthPair

def weightedKoruStep (M k : Nat)
    (s t : GrowingKoruState) : Prop :=
  combinedStep M s.1 t.1 ∧ t.2 = weightedRenewal k s.2

/-- Either renewal law preserves the SAME physical source's forward
causal arrow and right-handedness, with no backward-time event. -/
theorem every_weighted_koru_is_forward_and_right_handed
    (M k : Nat) (s t : GrowingKoruState)
    (hStep : weightedKoruStep M k s t) :
    combinedCausal M s.1 < combinedCausal M t.1 ∧
      combinedHandedness t.1 = combinedHandedness s.1 := by
  exact ⟨each_combined_event_is_causally_forward
      M s.1 t.1 hStep.1,
    each_combined_event_preserves_right_handedness
      M s.1 t.1 hStep.1⟩

/-- The *original Koru* property of the entire W source survives
every modeled step, regardless of the chosen growth coefficient. -/
theorem every_weighted_koru_preserves_original_source_koru
    (M k : Nat) (s t : GrowingKoruState)
    (hStep : weightedKoruStep M k s t) :
    WholeHasIntrinsicKoru t.1.2 ↔ WholeHasIntrinsicKoru s.1.2 := by
  exact each_combined_event_preserves_original_Koru
    M s.1 t.1 hStep.1

/-- An independently generated, nontrivial, right-handed W/genesis
source transition from the existing Koru source physics. -/
def baseStart (U : FiniteObjectiveU) : Combined :=
  ((0, 0, true), U)

def baseNext (U : FiniteObjectiveU) : Combined :=
  ((1, 0, true), objectiveStep U)

theorem actual_banked_W_genesis_witness (U : FiniteObjectiveU) :
    combinedStep 0 (baseStart U) (baseNext U) := by
  exact ⟨Or.inr ⟨rfl, rfl⟩, rfl⟩

/-- Non-vacuous SAME source event, SAME right-hand time and SAME
original Koru preservation, but TWO distinct next growth states.
Therefore these existing source facts cannot distinguish Fibonacci
(k=1, formal phi) from a non-golden k=2 renewal. -/
theorem same_actual_W_event_admits_distinct_growth_laws
    (U : FiniteObjectiveU) :
    weightedKoruStep 0 1
      (baseStart U, (0, 1)) (baseNext U, (1, 1)) ∧
    weightedKoruStep 0 2
      (baseStart U, (0, 1)) (baseNext U, (1, 2)) ∧
    ((1, 1) : GrowthPair) ≠ (1, 2) := by
  have hSource := actual_banked_W_genesis_witness U
  exact ⟨⟨hSource, rfl⟩, ⟨hSource, rfl⟩, by decide⟩

/-- A minimal *symmetric duties* proxy for reciprocity. It is NOT
the full ethical Golden Rule, which requires independently formulated
duties and protected particulars. -/
def ReciprocalDuty (R : Bool → Bool → Prop) : Prop :=
  ∀ p q, R p q → R q p

def asymmetricDuty (p q : Bool) : Prop :=
  p = false ∧ q = true

/-- Even a correctly constructed Fibonacci growth process can
coexist with a nonreciprocal duty relation. Numerical phi alone
does not discharge Hume's ethical bridge or original six X3. -/
theorem golden_growth_does_not_imply_reciprocal_duties :
    fibonacciRenewal (0, 1) = (1, 1) ∧
      ¬ ReciprocalDuty asymmetricDuty := by
  constructor
  · rfl
  · intro h
    have hReverse := h false true ⟨rfl, rfl⟩
    cases hReverse.1

#print axioms every_weighted_renewal_is_injective
#print axioms formal_phi_quadratic
#print axioms formal_phi_multiplies_as_fibonacci
#print axioms phi_coefficients_recur
#print axioms fibonacci_iterations_do_not_merge
#print axioms fibonacci_zero_is_fixed
#print axioms fibonacci_nonzero_origin_is_never_erased
#print axioms fibonacci_strict_growth_after_first_nonzero
#print axioms two_injective_renewals_have_different_outcomes
#print axioms every_weighted_koru_is_forward_and_right_handed
#print axioms every_weighted_koru_preserves_original_source_koru
#print axioms actual_banked_W_genesis_witness
#print axioms same_actual_W_event_admits_distinct_growth_laws
#print axioms golden_growth_does_not_imply_reciprocal_duties

end PhysicalBridges.KoruPhiNecessityTest
