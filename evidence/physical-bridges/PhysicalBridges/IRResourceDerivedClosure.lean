/-
IR-69: derive (rather than assume) finite-obstruction feasibility
from explicitly specified nonnegative finite-capacity resource ledgers
and finite hard causal incompatibilities.

This is a MATH/PHYSICAL-INTERFACE theorem. Channel costs and caps
must be independently verified. It DOES NOT prove that actual
physical UPT feasibility is exhausted by these accounting constraints.

The full ORIGINAL IR-68 two-stage LexBetter order and the entire
infinite full-feasible retention outcome family are preserved.
-/
import PhysicalBridges.IRCoupledFinitaryTwoStage

namespace PhysicalBridges.IRResourceDerivedClosure
open IRCoupledFinitaryTwoStage

/-- A finite list of distinct retained facts has a nonnegative charge
for channel r. Repetition is excluded by the Nodup premise below. -/
def charge (weight : Nat → Fact → Nat)
    (r : Nat) (xs : List Fact) : Nat :=
  (xs.map (weight r)).sum

/-- For EACH physically relevant channel and EACH finite set of
simultaneously retained facts, the nonnegative additive cost fits
that channel's independently warranted capacity. Resource index
may itself be infinite, but no finite list of channels is assumed. -/
def ResourceSafe (weight : Nat → Fact → Nat)
    (capacity : Nat → Nat) (s : Outcome) : Prop :=
  ∀ r (xs : List Fact), xs.Nodup →
    (∀ f, f ∈ xs → s f) →
    charge weight r xs ≤ capacity r

/-- Further causal or hardware incompatibilities need independent
finite witness patterns. -/
def ConflictSafe (hard : List Fact → Prop)
    (s : Outcome) : Prop :=
  ∀ xs, hard xs → ¬ (∀ f, f ∈ xs → s f)

/-- The full feasible family for this EXPLICIT resource/causal model.
Nothing has been removed by a safe menu or profile quotient. -/
def CapacityFeasible
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (s : Outcome) : Prop :=
  ResourceSafe weight capacity s ∧ ConflictSafe hard s

/-- A forbidden pattern is either independently specified hard
incompatibility, OR one distinct finite subset whose accumulated
resource cost exceeds some channel capacity. -/
def DerivedForbidden
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (xs : List Fact) : Prop :=
  hard xs ∨
    (xs.Nodup ∧ ∃ r, capacity r < charge weight r xs)

/-- Exact correspondence, without any original-feasible-set
restriction or hidden profile-coverage assumption. -/
theorem resource_feasible_iff_finite_forbidden
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (s : Outcome) :
    CapacityFeasible weight capacity hard s ↔
      IRCoupledFinitaryTwoStage.Feasible
        (DerivedForbidden weight capacity hard) s := by
  constructor
  · intro hSafe xs hBad hRetained
    obtain ⟨hBudget,hHard⟩ := hSafe
    rcases hBad with hConflict | ⟨hDistinct,r,hOver⟩
    · exact hHard xs hConflict hRetained
    · have hWithin := hBudget r xs hDistinct hRetained
      omega
  · intro hNoGood
    constructor
    · intro r xs hDistinct hRetained
      by_cases hWithin : charge weight r xs ≤ capacity r
      · exact hWithin
      · have hExceeds : capacity r < charge weight r xs := by omega
        exact False.elim
          ((hNoGood xs (Or.inr ⟨hDistinct,r,hExceeds⟩)) hRetained)
    · intro xs hConflict hRetained
      exact (hNoGood xs (Or.inl hConflict)) hRetained

/-- Empty retention never consumes resource. It is feasible if no
HARD conflict forbids the empty pattern. This is an explicit
non-vacuity assumption, not a physical claim that doing nothing
always guarantees the continuation of particular beings. -/
theorem empty_capacity_feasible
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop)
    (hNoEmptyConflict : ¬ hard []) :
    CapacityFeasible weight capacity hard (fun _ => False) := by
  constructor
  · intro r xs _ hRetained
    cases xs with
    | nil =>
        simp [charge]
    | cons f rest =>
        have hImpossible := hRetained f List.mem_cons_self
        exact False.elim hImpossible
  · intro xs hConflict hRetained
    cases xs with
    | nil => exact hNoEmptyConflict hConflict
    | cons f rest =>
        have hImpossible := hRetained f List.mem_cons_self
        exact False.elim hImpossible

/-- Derived original two-priority LEX MAXIMALITY of the ENTIRE
infinite feasible universe, now with actual bounded nonnegative
resource channels and separately finite causal forbidden patterns.
Finitary feasibility has been DERIVED from these constraints. -/
theorem resource_capacity_implies_global_lex_maximality
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop)
    (hNoEmptyConflict : ¬ hard []) :
    UPTExist.LexAlignedL
      (CapacityFeasible weight capacity hard)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (IRCoupledFinitaryTwoStage.fullChoice
        (DerivedForbidden weight capacity hard)) := by
  have hBase : IRCoupledFinitaryTwoStage.Feasible
      (DerivedForbidden weight capacity hard) (fun _ => False) :=
    (resource_feasible_iff_finite_forbidden
      weight capacity hard (fun _ => False)).mp
      (empty_capacity_feasible weight capacity hard hNoEmptyConflict)
  have hOriginal :=
    IRCoupledFinitaryTwoStage.coupled_two_stage_full_feasible_lex_maximal
      (DerivedForbidden weight capacity hard) hBase
  refine ⟨(resource_feasible_iff_finite_forbidden
      weight capacity hard _).mpr hOriginal.1, ?_⟩
  intro other hPhysical hBetter
  exact hOriginal.2 other
    ((resource_feasible_iff_finite_forbidden
      weight capacity hard other).mp hPhysical) hBetter

/-- The class has a real resource tradeoff: two retention claims,
one from each priority, each costs one unit of a shared channel of
capacity one. The full-retention state is inadmissible. -/
def sharedCost (_r : Nat) (f : Fact) : Nat :=
  if f = (false,0) ∨ f = (true,0) then 1 else 0
def unitCapacity (_r : Nat) : Nat := 1
def noHard (_xs : List Fact) : Prop := False

theorem shared_capacity_excludes_joint_pair :
    ¬ CapacityFeasible sharedCost unitCapacity noHard
        (fun _ => True) := by
  intro h
  have hResource := h.1 0 [(false,0),(true,0)]
      (by decide)
      (by intro _ _; trivial)
  have hCost :
      charge sharedCost 0 [(false,0),(true,0)] = 2 := by decide
  rw [hCost] at hResource
  simp [unitCapacity] at hResource

theorem shared_capacity_global_original_lex_maximal :
    UPTExist.LexAlignedL
      (CapacityFeasible sharedCost unitCapacity noHard)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (IRCoupledFinitaryTwoStage.fullChoice
        (DerivedForbidden sharedCost unitCapacity noHard)) := by
  exact resource_capacity_implies_global_lex_maximality
    sharedCost unitCapacity noHard (by intro h; exact h)

/-- A concrete infinite-horizon requirement which has NO finite
exclusion witness: only FINITELY MANY commitments may persist.
This is a mathematical countercontrol against claiming all real
physical constraints are finite-witness capacity constraints. -/
def EventuallyAbsent (s : Nat → Prop) : Prop :=
  ∃ n, ∀ k, n ≤ k → ¬ s k

theorem finite_prefix_eventually_absent (n : Nat) :
    EventuallyAbsent (UPTExist.chainKey n) := by
  refine ⟨n+1, ?_⟩
  intro k hk hPresent
  change k ≤ n at hPresent
  omega

theorem full_infinite_not_eventually_absent :
    ¬ EventuallyAbsent (fun _ : Nat => True) := by
  rintro ⟨n,hn⟩
  exact hn n (Nat.le_refl _) trivial

/-- No list of finite forbidden patterns can represent the
only-finite-commitments condition exactly. IR-66's original-chain
obstruction is a source-level witness to the failure. -/
theorem eventual_absence_not_exactly_finitary :
    ¬ ∃ forbidden : List Nat → Prop,
      ∀ s : Nat → Prop,
        EventuallyAbsent s ↔
          IRInfiniteFinitaryMaximality.Feasible forbidden s := by
  rintro ⟨forbidden,hAll⟩
  have hPrefixes : ∀ n,
      IRInfiniteFinitaryMaximality.Feasible forbidden
        (UPTExist.chainKey n) := by
    intro n
    exact (hAll (UPTExist.chainKey n)).mp
      (finite_prefix_eventually_absent n)
  have hFull :=
    IRInfiniteFinitaryMaximality.all_prefixes_feasible_forces_full_retention
      forbidden hPrefixes
  exact full_infinite_not_eventually_absent
    ((hAll (fun _ => True)).mpr hFull)

#print axioms resource_feasible_iff_finite_forbidden
#print axioms empty_capacity_feasible
#print axioms resource_capacity_implies_global_lex_maximality
#print axioms shared_capacity_excludes_joint_pair
#print axioms shared_capacity_global_original_lex_maximal
#print axioms finite_prefix_eventually_absent
#print axioms full_infinite_not_eventually_absent
#print axioms eventual_absence_not_exactly_finitary
end PhysicalBridges.IRResourceDerivedClosure
